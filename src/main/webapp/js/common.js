/**
 * 공통 js
 * @author 2017-07-05 KaiKim
 */
var tabs;


//정산관리 페이징 전역 변수
//<----------------------------------------------------------------

//현페이지
var currentPageNo = 1;
//한 페이지 당 행수 - 페이지에 따라 수정 요
var pageRow = 1000;
//전체 페이지 수
var totalPage = 0;
//전체 행 수
var totalCount = 0;

//---------------------------------------------------------------->

$(function() {
	/* 단축키 설정 */
    shortcut.add('Alt+Q', function() {
        if ($('.ui-dialog.ui-widget.ui-widget-content.ui-corner-all.ui-front').last().find('.cmb_pop_search').length > 0) {
            $('.ui-dialog.ui-widget.ui-widget-content.ui-corner-all.ui-front').last().find('.cmb_pop_search').triggerHandler('click');
            return false;
        }

        var iframeid = $('#' + $('.ui-tabs-active').attr('aria-controls') + ' iframe').attr('id');
        var btnret = $('#' + iframeid).contents().find('#cbtn_ret');

        if (btnret.length > 0) {
            if (btnret.css('display') != 'none') {
                btnret.triggerHandler('click');
            }
        }
        if ($('#cbtn_ret').length > 0) {
            if ($('#cbtn_ret').css('display') != 'none') {
                $('#cbtn_ret').triggerHandler('click');
            }
        }
    });
    shortcut.add('Alt+Delete', function() {
    	if (cfn_getTopFrameFlg()) {
    		var $obj = $('#tabs li.ui-tabs-active span.ui-icon-close');
    		if ($obj.length > 0) {
    			$obj.trigger('click');
    		}
    	} else {
    		var $obj = parent.$('#tabs li.ui-tabs-active span.ui-icon-close');
    		if ($obj.length > 0) {
    			$obj.trigger('click');
    		}
    	}
    });
    shortcut.add('Alt+Page_up', function() {
    	if (cfn_getTopFrameFlg()) {
    		var tabidx = $('#tabs').tabs('option', 'active');
    		if (tabidx !== 0) {
    			$('#tabs').tabs('option', 'active', tabidx - 1);
    		}
    	} else {
    		var tabidx = parent.$('#tabs').tabs('option', 'active');
    		if (tabidx !== 0) {
    			parent.$('#tabs').tabs('option', 'active', tabidx - 1);
    		}
    	}
    });
    shortcut.add('Alt+Page_down', function() {
    	if (cfn_getTopFrameFlg()) {
    		var tabidx = $('#tabs').tabs('option', 'active');
    		$('#tabs').tabs('option', 'active', tabidx + 1);
    	} else {
    		var tabidx = parent.$('#tabs').tabs('option', 'active');
    		parent.$('#tabs').tabs('option', 'active', tabidx + 1);
    	}
    });

    $( ".selector" ).tabs( "option", "active", 1 );

    cfn_initComponent();
});

/**
 * 컴포넌트 초기 설정 함수
 */
function cfn_initComponent() {
    /* 입력폼 엔터시 button 자동 클릭 방지 */
    var $cinput = $('input');
    if ($cinput.length > 0) {
    	$cinput.on('keyup', function(e) {
    		if (e.keyCode === 13)
    			return false;
    	});
    }

    /* 대문자 입력폼 설정 */
    var $cupper = $('input.upper');
    if ($cupper.length > 0) {
    	$cupper.on('blur', function(e) {
    		$(this).val($(this).val().toUpperCase());
    	});
    }

    /* 소문자 입력폼 설정 */
    var $clower = $('input.lower');
    if ($clower.length > 0) {
    	$clower.on('blur', function(e) {
    		$(this).val($(this).val().toLowerCase());
    	});
    }
    
    /* 숫자 입력폼 설정 */
	var $cnumber = $('input.num');
	if ($cnumber.length > 0) {
		$cnumber.on('keyup', function(e) {
			if(!cfn_isNum($(this).val())){
				$(this).val('');
			}
		})
	}

    /* 날짜-년도(콤보형) 설정 (select.cmc_year) */
    var $csyear = $('select.cmc_year');
    if ($csyear.length > 0 && !$csyear.hasClass('apply')) {
    	var y = new Date().getFullYear(),
    		s = y - 50,
    		e = y + 51;
    	for (var i=s; i<e; i++) {
    		$csyear.append('<option value="' + i + '">' + i + '</option>');
    	}
    	$csyear.val(y).addClass('apply');
    }

    /* 날짜-년도(입력형) 설정 (input.cmc_year) */
    var $ciyear = $('input.cmc_year');
    if ($ciyear.length > 0 && !$ciyear.hasClass('apply')) {
    	$ciyear.after('<button type="button" class="cmb_calendar" tabindex="-1"></button>').addClass('apply')
    		.datetimepicker({
	            language: 'ko',
	            format: 'yyyy',
	            autoclose: true,
	            startView: 'decade',
	            minView: 'decade',
	            todayBtn: true,
	    		todayHighlight: true,
	    		forceParse: false})
	    	.attr({'maxlength':4})
	    	.on('blur', function(e) {
	        	var $t = $(this);
	            if (cfn_isDateTime($t.val())) {
	            	$t.val(cfn_getDateFormat($t.val(), 'yyyy'));
	            } else {
	            	$t.val('');
	            }})
	        .on('click', function(e) {
	        	$(this).datetimepicker('update').datetimepicker('show');
	        });

    	$ciyear.next('button.cmb_calendar').on('click', function(e) {
        	$(this).prev().datetimepicker('update').datetimepicker('show');
        });
    }

    /* 날짜-년월 입력폼 설정 (input.cmc_yearmonth) */
    var $cmonth = $('input.cmc_yearmonth');
    if ($cmonth.length > 0 && !$cmonth.hasClass('apply')) {
    	$cmonth.after('<button type="button" class="cmb_calendar" tabindex="-1"></button>').addClass('apply')
    		.datetimepicker({
	            language: 'ko',
	            format: 'yyyy-mm',
	            autoclose: true,
	            startView: 'year',
	            minView: 'year',
	            todayBtn: true,
	    		todayHighlight: true,
	    		forceParse: false})
	        .attr({'maxlength':7})
	        .on('blur', function(e) {
	        	var $t = $(this);
	            if (cfn_isDateTime($t.val())) {
	            	$t.val(cfn_getDateFormat($t.val(), 'yyyy-MM'));
	            } else {
	            	$t.val('');
	            }})
	        .on('click', function(e) {
	        	$e = $(this);
    			if ($e.hasClass('periods')) {
    				var endDt = $($e.nextAll('input.periode')[0]).val();
    		    	if (!cfn_isEmpty(endDt)) {
    		    		$e.datetimepicker('setEndDate', endDt);
    		    	}
    			} else if ($e.hasClass('periode')) {
    				var startDt = $($e.prevAll('input.periods')[0]).val();
    		    	if (!cfn_isEmpty(startDt)) {
    		    		$e.datetimepicker('setStartDate', startDt);
    		    	}
    			}
    			$e.datetimepicker('update').datetimepicker('show');
	        });
        $cmonth.next('button.cmb_calendar').on('click', function(e) {
        	$e = $(this).prev('input.cmc_yearmonth');
    		if ($e.hasClass('periods')) {
				var endDt = $($e.nextAll('input.periode')[0]).val();
		    	if (!cfn_isEmpty(endDt)) {
		    		$e.datetimepicker('setEndDate', endDt);
		    	}
			} else if ($e.hasClass('periode')) {
				var startDt = $($e.prevAll('input.periods')[0]).val();
		    	if (!cfn_isEmpty(startDt)) {
		    		$e.datetimepicker('setStartDate', startDt);
		    	}
			}
        	$(this).prev().datetimepicker('update').datetimepicker('show');
        });
    }

    /* 날짜-일자 입력폼 설정 (input.cmc_date) */
    var $cdate = $('input.cmc_date');
    if ($cdate.length > 0 && !$cdate.hasClass('apply')) {
    	$cdate.after('<button type="button" class="cmb_calendar" tabindex="-1"></button>').addClass('apply')
    		.datetimepicker({
	            language: 'ko',
	            format: 'yyyy-mm-dd',
	            autoclose: true,
	            startView: 'month',
	            minView: 'month',
	            todayBtn: true,
	    		todayHighlight: true,
	    		forceParse: false})
	        .attr({'maxlength':10})
	        .on('blur', function(e) {
	        	var $t = $(this);
	            if (cfn_isDateTime($t.val())) {
	            	$t.val(cfn_getDateFormat($t.val(), 'yyyy-MM-dd'));
	            } else {
	            	$t.val('');
	            }
	        }).on('click', function(e) {
	        	$e = $(this);
    			if ($e.hasClass('periods')) {
    				var endDt = $($e.nextAll('input.periode')[0]).val();
    		    	if (!cfn_isEmpty(endDt)) {
    		    		$e.datetimepicker('setEndDate', endDt);
    		    	}
    			} else if ($e.hasClass('periode')) {
    				var startDt = $($e.prevAll('input.periods')[0]).val();
    		    	if (!cfn_isEmpty(startDt)) {
    		    		$e.datetimepicker('setStartDate', startDt);
    		    	}
    			}
    			$e.datetimepicker('update').datetimepicker('show');
	        });
    	$cdate.next('button.cmb_calendar').on('click', function(e) {
    		$e = $(this).prev('input.cmc_date');
    		if ($e.hasClass('periods')) {
				var endDt = $($e.nextAll('input.periode')[0]).val();
		    	if (!cfn_isEmpty(endDt)) {
		    		$e.datetimepicker('setEndDate', endDt);
		    	}
			} else if ($e.hasClass('periode')) {
				var startDt = $($e.prevAll('input.periods')[0]).val();
		    	if (!cfn_isEmpty(startDt)) {
		    		$e.datetimepicker('setStartDate', startDt);
		    	}
			}
			$e.datetimepicker('update').datetimepicker('show');
        });
    }
    
    /* 날짜-일자 입력폼 설정 (input.cmc_date_auditPay) */
    var $cdate = $('input.cmc_date_auditPay');
    if ($cdate.length > 0 && !$cdate.hasClass('apply')) {
    	$cdate.after('<button type="button" class="cmb_calendar" tabindex="-1"></button>').addClass('apply')
    		.datetimepicker({
	            language: 'ko',
	            format: 'yyyy-mm-dd',
	            autoclose: true,
	            startView: 'month',
	            minView: 'month',
	            todayBtn: true,
	    		todayHighlight: true,
	    		forceParse: false})
	        .attr({'maxlength':10})
	        .on('blur', function(e) {
	        	var $t = $(this);     
	            if (cfn_isDateTime($t.val())) {
	            	$t.val(cfn_getDateFormat($t.val(), 'yyyy-MM-dd'));
	            } else {
	            	$t.val('');
	            }
	        }).on('click', function(e) {
	        	$e = $(this);
    			if ($e.hasClass('periods')) {
    				var endDt = $($e.nextAll('input.periode')[0]).val();
    				var setStartDt = new Date(endDt);
    				var setEndDt = new Date(setStartDt);
    				
    				setEndDt.setDate(setEndDt.getDate()+30);
    				
    		    	if (!cfn_isEmpty(endDt)) {
    		    		$e.datetimepicker('setStartDate', setStartDt);
    		    		$e.datetimepicker('setEndDate', setEndDt);
    		    	}
    			} else if ($e.hasClass('periode')) {
    				var startDt = $($e.prevAll('input.periods')[0]).val();
    				var setEndDt = new Date(startDt)
    				var setStartDt = new Date(setEndDt);
    				
    				setStartDt.setDate(setStartDt.getDate()-30);
    				
    		    	if (!cfn_isEmpty(startDt)) {
    		    		$e.datetimepicker('setStartDate', setStartDt);
    		    		$e.datetimepicker('setEndDate', setEndDt);
    		    	}
    			}
    			$e.datetimepicker('update').datetimepicker('show');
	        });
    	$cdate.next('button.cmb_calendar').on('click', function(e) {
    		$e = $(this).prev('input.cmc_date_auditPay');
    		if ($e.hasClass('periods')) {
				var endDt = $($e.nextAll('input.periode')[0]).val();
		    	if (!cfn_isEmpty(endDt)) {
		    		$e.datetimepicker('setEndDate', endDt);
		    	}
			} else if ($e.hasClass('periode')) {
				var startDt = $($e.prevAll('input.periods')[0]).val();
		    	if (!cfn_isEmpty(startDt)) {
		    		$e.datetimepicker('setStartDate', startDt);
		    	}
			}
			$e.datetimepicker('update').datetimepicker('show');
        });
    }

    /* 날짜-일시 입력폼 설정 (input.cmc_datetime) */
    var $cdt = $('input.cmc_datetime');
    if ($cdt.length > 0 && !$cdt.hasClass('apply')) {
    	$cdt.after('<button type="button" class="cmb_calendar" tabindex="-1"></button>').addClass('apply')
    		.datetimepicker({
	            language: 'ko',
	            format: 'yyyy-mm-dd hh:ii:ss',
	            autoclose: true,
	            startView: 'month',
	            minView: 'day',
	            todayBtn: true,
	    		todayHighlight: true,
	    		showMeridian: true,
	    		forceParse: false,
	    		initialDate: cfn_getToday()})
	        .attr({'maxlength':19})
	        .on('blur', function(e) {
	        	var $t = $(this);
	            if (cfn_isDateTime($t.val())) {
	            	$t.val(cfn_getDateFormat($t.val(), 'yyyy-MM-dd hh:mm:ss'));
	            } else {
	            	$t.val('');
	            }
	        }).on('click', function(e) {
	        	$(this).datetimepicker('update').datetimepicker('show');
	        });
    	$cdt.next('button.cmb_calendar').on('click', function(e) {
        	$(this).prev().datetimepicker('update').datetimepicker('show');
        });
    }

    /* 날짜-일자+시분 입력폼 설정 (input.cmc_datehm) */
    var $cdhm = $('input.cmc_datehm');
    if ($cdhm.length > 0 && !$cdhm.hasClass('apply')) {
    	$cdhm.after('<button type="button" class="cmb_calendar" tabindex="-1"></button>').addClass('apply')
    	.datetimepicker({
    		language: 'ko',
    		format: 'yyyy-mm-dd hh:ii',
    		autoclose: true,
    		startView: 'month',
    		minView: 'day',
    		todayBtn: true,
    		todayHighlight: true,
    		showMeridian: true,
    		forceParse: false,
    		initialDate: cfn_getToday()})
    		.attr({'maxlength':16})
    		.on('blur', function(e) {
    			var $t = $(this);
    			if (cfn_isDateTime($t.val())) {
    				$t.val(cfn_getDateFormat($t.val(), 'yyyy-MM-dd hh:mm'));
    			} else {
    				$t.val('');
    			}
    		}).on('click', function(e) {
    			$(this).datetimepicker('update').datetimepicker('show');
    		});
    	$cdhm.next('button.cmb_calendar').on('click', function(e) {
    		$(this).prev().datetimepicker('update').datetimepicker('show');
    	});
    }

    /* 툴팁 설정 */
    var $button = $('input:button,button');
    if ($button.length > 0) {
    	$button.each(function() {
    		if (!cfn_isEmpty($(this).attr('title'))) {
    			$(this).tooltip({show: {delay: 500}, hide: false});
    		}
    	});
    }

    /* disabled 폼 포커스 이동 방지 */
    var $disabled = $('input.disabled,select.disabled,textarea.disabled');
    if ($disabled.length > 0) {
    	$disabled.attr({'tabindex':-1});
    	$.each($disabled, function(k, v) {
    		var $btncal = $(v).next('button.cmb_calendar');
        	if ($btncal.length > 0) {
        		$btncal.hide();
        		$(v).datetimepicker('remove');
        		$(v).off('click');
        	}
    	});
    }
}

/****************************************************************************
 * 공통 관련 함수
 ***************************************************************************/
/**
 * Ajax 처리
 * @param {String} url     : 처리할 주소
 * @param {Boolean} async  : 비동기(true) 또는 동기(false) 방식
 * @param {Array} sendData : 전송될 데이터들
 * @param {function} fn    : callback 받을 함수(data, xhr)
 */
function gfn_ajax(url, async, sendData, fn) {
    var sendcode, sendmsg;

    $.ajax({
        url: url,
        async: async,
        type: 'post',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        traditional: true,
        data: JSON.stringify(sendData),
        beforeSend: function(request) {
            $('body').css('cursor','wait');
            loadingStart();
            request.setRequestHeader('METHOD_ID', 'AJAX');
        },
        success: function(data, dataType, xhr) {
            sendcode = data.CODE;
            sendmsg = data.MESSAGE;
            data.GSECHDATA = sendData;
            data.GSECHURL = url;

            if (sendcode == '1') {
                fn(data, xhr);
            }
        },
        error: function(xhr, status, error) {
            sendcode = xhr.status;
            sendmsg = error;
        },
        complete: function(xhr, status) {
            loadingEnd();
            $('body').css('cursor','default');

            if (sendcode == '991') {
                // 세션 만료시 로그인 이동
                parent.location.href = '/comm/login.do';
            } else if (sendcode != '1') {
                cfn_msg('ERROR', '에러코드 : ' + sendcode + '\n에러메시지 :\n' + sendmsg);
            }
        }
    });
}

/**
 * Ajax 데이터처리
 * @param {String} sid     : 데이터 처리명
 * @param {String} url     : 데이터 처리할 주소
 * @param {Array} sendData : 전송될 데이터들
 * @returns 성공 : gfn_callback(), 실패 : 에러Alert 또는 로그인화면이동
 */
function gfn_sendData(sid, url, sendData, isAsync) {
    var sendcode, sendmsg;

    var asyncable = typeof isAsync !== 'undefined' ? isAsync : true;
    $.ajax({
        url: url,
        async: asyncable,
        type: 'post',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        traditional: true,
        data: JSON.stringify(sendData),
        beforeSend: function(request) {
            $('body').css('cursor','wait');
            loadingStart();
            request.setRequestHeader('METHOD_ID', sid);
        },
        success: function(data, status, xhr) {
            var sid = xhr.getResponseHeader('METHOD_ID');	//헤더에 저장된 sid
            sendcode = data.CODE;
            sendmsg = data.MESSAGE;
            data.GSECHDATA = sendData;
            data.GSECHURL = url;

            if (sendcode == '1') {
                loadingEnd();
                $('body').css('cursor','default');
                if (typeof gfn_callback === 'function') {
                	gfn_callback(sid, data);
                }
            }
        },
        error: function(xhr, status, error){
            sendcode = xhr.status;
            sendmsg = error;
        },
        complete: function(xhr, status) {
            if (sendcode == '991') {
                loadingEnd();
                $('body').css('cursor','default');
                // 세션 만료시 로그인 이동
                parent.location.href = '/comm/login.do';
            } else if (sendcode != '1') {
                loadingEnd();
                $('body').css('cursor','default');
                cfn_msg('ERROR', '에러코드 : ' + sendcode + '\n에러메시지 :\n' + sendmsg);
            }
        }
    });
}

/**
 * form태그 데이터 바인딩
 * @param {String} formid : Form태그 ID
 * @param {Json} data : 바인딩데이터
 */
function cfn_bindFormData(formid, data) {
    $.each(data, function(key, val) {
        var $tag = $('#' + formid).find('#' + key + ',input:radio[name=' + key + ']');

        if ($tag.length > 0) {
        	val = cfn_isEmpty(val) ? '' : val;

        	if ($tag.hasClass('cmc_datetime')) {
                if (val.length == 14) {
                    val = val.substring(0, 4) + '-' + val.substring(4, 6) + '-' + val.substring(6, 8) + ' '
                        + val.substring(8, 10) + ':' + val.substring(10, 12) + ':' + val.substring(12, 14);
                } else if (val.length == 12) {
                    val = val.substring(0, 4) + '-' + val.substring(4, 6) + '-' + val.substring(6, 8) + ' '
                        + val.substring(8, 10) + ':' + val.substring(10, 12) + ':00';
                } else if (val.length == 8) {
                    val = val.substring(0, 4) + '-' + val.substring(4, 6) + '-' + val.substring(6, 8) + ' 00:00:00';
                }
                $tag.val(val);
            } else if ($tag.hasClass('cmc_date')) {
                if (val.length == 8) {
                	val = val.substring(0, 4) + '-' + val.substring(4, 6) + '-' + val.substring(6, 8);
                }
                $tag.val(val);
            } else if ($tag.hasClass('cmc_yearmonth')) {
                if (val.length == 6) {
                    val = val.substring(0, 4) + '-' + val.substring(4, 6);
                }
                $tag.val(val);
            } else if ($tag.hasClass('cmc_datehm')) {
                if (val.length == 12) {
                	val = val.substring(0, 4) + '-' + val.substring(4, 6) + '-' + val.substring(6, 8) + ' '
                        + val.substring(8, 10) + ':' + val.substring(10, 12);
                } else if (val.length == 8) {
                    val = val.substring(0, 4) + '-' + val.substring(4, 6) + '-' + val.substring(6, 8) + ' 00:00';
                }
                $tag.val(val);
            } else if ($tag.hasClass('cmc_time')) {
            	if (val.length == 6) {
            		val = val.substring(0, 2) + ':' + val.substring(2, 4) + ':' + val.substring(4, 6);
            	} else if (val.length == 4) {
            		val = val.substring(0, 2) + ':' + val.substring(2, 4) + ':00';
            	}
            	$tag.val(val);
            } else if ($tag.attr('type') == 'radio') {
                $('input:radio[name=' + key + '][value=' + val + ']').prop('checked', true);
            } else if ($tag.attr('type') === 'checkbox') {
                if (val === 1 || val === 'Y') {
                	$tag.prop('checked', true);
                } else {
                	$tag.prop('checked', false);
                }
            } else if ($tag[0].tagName.toUpperCase() === 'TEXTAREA') {
            	$tag.val(val.replace(/\\r\\n/g, '\r\n'));
            } else {
            	$tag.val(val);
            }
        }
    });
}

/**
 * form태그 데이터 초기화
 * @param {String} formid : Form태그 ID
 */
function cfn_clearFormData(formid) {
	$('#' + formid).find('input:text,input:password,select,textarea').each(function() {
		this.value = '';
	});
}

/**
 * 입력폼 및 그리드를 모두 Disable
 * @param {Array} formIDs : 폼태그 아이디
 * @param {Array} gridIDs : 그리드 아이디
 */
function cfn_formAllDisable(formIds, gridIds) {
    if (Array.isArray(formIds)) {
        for (var f=0, len=formIds.length; f<len; f++) {
        	var $form = $('#' + formIds[f]);
        	$form.find('input,textarea').not('.nodis').attr('readonly','readonly').attr('tabindex','-1').addClass('disabled').attr('disabled',true);
        	$form.find('select,button,input:button').not('.nodis').attr('disabled','disabled').attr('tabindex','-1').addClass('disabled');
        	$form.find('input:checkbox,input:radio').not('.nodis').attr('disabled','disabled').attr('tabindex','-1').addClass('disabled');
        	$form.find('input.cmc_year,input.cmc_yearmonth,input.cmc_date,input.cmc_datetime,input.cmc_datehm').not('.nodis')
            	.attr('tabindex','-1').removeClass('apply').datetimepicker('remove').off('click');
        	$form.find('input.cmc_year,input.cmc_yearmonth,input.cmc_date,input.cmc_datetime,input.cmc_datehm').not('.nodis')
            	.next('button.cmb_calendar').remove();
        }
    }

    if (Array.isArray(gridIds)) {
        $('.cmb_plus').hide();
        $('.cmb_minus').hide();

        for (var g=0, len=gridIds.length; g<len; g++) {
        	var $g = $('#' + gridIds[g]);
        	var colkeys = $g.gridView().getColumnNames(false);

        	for (var i=0, len2=colkeys.length; i<len2; i++) {
        		$g.gridView().setColumnProperty(colkeys[i], 'editable', false);
    			$g.gridView().setColumnProperty(colkeys[i], 'button', 'none');
    		}
        }
    }
}

/**
 * Form 안의 입력 값들을 Map형태로 변환 (빈값 제외)
 * @param {String} formId : 폼ID
 * @param {String} rtnflg : 리턴값 종류 Y : Y/N, N또는null : 1:0
 */
function formIdToMap(formId, rtnflg) {
    var serializer = $('form#' + formId).serializeArray();
    var str = '{';

    for (var i=0, len=serializer.length; i<len; i++) {
    	if (!cfn_isEmpty(serializer[i].value)) {
    		str += '"' + serializer[i].name + '":"' + serializer[i].value.replace(/"/g,'\\"').replace(/\n/g,"\\\\n").replace(/\r/g,"\\\\r") + '",';
    	}
    }

    $('form#' + formId + ' select:disabled').each(function() {
    	str += '"' + this.name + '":"' + this.value + '",';
    });
    $('form#' + formId + ' input[type="text"]:disabled').each(function() {
    	str += '"' + this.name + '":"' + this.value + '",';
    });

    $('form#' + formId + ' input:checkbox').each(function() {
        var chkval = '';
        if (!cfn_isEmpty(rtnflg) && rtnflg == 'Y') {
        	chkval = this.checked ? 'Y':'N';
        } else {
        	chkval = this.checked ? 1:0;
        }
        str += '"' + this.name + '":"' + chkval + '",';
    });

    if (typeof cfn_getIDUR !== 'undefined')
    	str += '"IDUR":"' + cfn_getIDUR() + '",';

    if (str.indexOf(',') >= 0)
    	str = str.substring(0, str.length - 1);
    str += '}';

    return JSON.parse(str);
}

/**
 * Form 안의 입력 값들을 Map형태로 변환 (빈값 포함)
 * @param {String} formId : 폼ID
 * @param {String} rtnflg : 리턴값 종류 Y : Y/N, N또는null : 1:0
 */
function formIdAllToMap(formId, rtnflg) {
	var $form = $('#' + formId);
    var serializer = $form.serializeArray();
    var str = '{';

    for (var i=0, len=serializer.length; i<len; i++) {
    	str += '"' + serializer[i].name + '":"' + serializer[i].value.replace(/"/g,'\\"').replace(/\n/g,"\\\\n").replace(/\r/g,"\\\\r") + '",';
    }

    $form.find('select:disabled').each(function() {
    	str += '"' + this.name + '":"' + this.value + '",';
    });
    $form.find('input[type="text"]:disabled').each(function() {
    	str += '"' + this.name + '":"' + this.value + '",';
    });
    $form.find('input:checkbox').each(function() {
        var chkval = '';
        if (!cfn_isEmpty(rtnflg) && rtnflg == 'Y') {
        	chkval = this.checked ? 'Y':'N';
        } else {
        	chkval = this.checked ? 1:0;
        }
        str += '"' + this.name + '":"' + chkval + '",';
    });
    $form.find('input.cmc_yearmonth,input.cmc_date,input.cmc_datetime,input.cmc_datehm').each(function() {
        str += '"' + this.name + '":"' + this.value.replace(/[^0-9]/g, '') + '",';
    });

    if (typeof cfn_getIDUR !== 'undefined')
    	str += '"IDUR":"' + cfn_getIDUR() + '",';

    if (str.indexOf(',') >= 0)
    	str = str.substring(0, str.length - 1);
    str += '}';

    return JSON.parse(str);
}

/**
 * Form 안의 입력 값들을 Object(key/value)형태로 변환 (빈값 포함)
 * @param {string} fid : form태그ID
 * @param {object} opt : 옵션값 Object(key/value)
 * 					chkflg: 체크박스 반환값 true일때 1/0, false 또는 빈값일때 Y/N
 * 					allflg: 값이 빈값일 경우 반환값에 포함여부 true 또는 빈값일때 전부포함, false일때 미포함
 * @return {object}
 */
function cfn_getFormData(fid, opt) {
	var $form = $('#' + fid);
	var chkflg = (cfn_isEmpty(opt) || cfn_isEmpty(opt.chkflg)) ? false : opt.chkflg;
	var allflg = (cfn_isEmpty(opt) || cfn_isEmpty(opt.allflg)) ? true : opt.allflg;
	var rtnObj = {};
	var exCpnt = $form.find('input:button,input:image,input:reset,input:submit');

	$form.find('input,select,textarea').not(exCpnt).each(function() {
		if (this.type === 'checkbox') {
	        if (chkflg) {
	        	rtnObj[this.id] = this.checked ? 1:0;
	        } else {
	        	rtnObj[this.id] = this.checked ? 'Y':'N';
	        }
		} else if (this.type === 'radio') {
			if (this.checked) {
				rtnObj[this.name] = this.value;
			} else if (cfn_isEmpty(rtnObj[this.name]) && allflg) {
				rtnObj[this.name] = '';
			}
		} else {
			if (allflg || !cfn_isEmpty(this.value)) {
				if ($(this).hasClass('cmc_datetime') || $(this).hasClass('cmc_date') || $(this).hasClass('cmc_yearmonth') ||
						$(this).hasClass('cmc_datehm') || $(this).hasClass('cmc_time')) {
					rtnObj[this.id] = this.value.replace(/[^0-9]/g, '');
				} else {
					if($(this).hasClass('cmc_list')){
						if(!cfn_isEmpty(this.value)){
							var datalist = this.value.split(",");
							rtnObj[this.id+"LIST"] = datalist; 
						}else{
							rtnObj[this.id+"LIST"] = [];
						}
					}else{
						rtnObj[this.id] = this.value;
					}
				}
			}
		}
	});

	if (typeof cfn_getIDUR !== 'undefined')
		rtnObj.IDUR = cfn_getIDUR();

    return rtnObj;
}

/**
 * form태그안의 입력폼 필수입력값 체크
 *  - 필수입력이 필요한 입력폼 class에 "required"를 넣어주어야 한다.
 *  - title 속성은 입력폼 명칭
 * @param {String} formID : 폼태그 아이디
 * @returns flag : true 또는 false
 */
function cfn_isFormRequireData(formid) {
    var formdata = cfn_getFormData(formid);
    var msg = '', cnt = 0, focusinput;

    $.each(formdata, function(k, v) {
        if ($('#' + k).hasClass('required')) {
        	if (cfn_isEmpty(v)) {
        		if (cnt === 0) {
            		focusinput = k;
            	}
        		var title = cfn_isEmpty($('#' + k).attr('title')) ? $('#' + k).parent().prev().text().replace('*', '') : $('#' + k).attr('title');
        		msg += '\n' + title + '은(는) 필수입력 입니다.';
            	$('#' + k).css({border: '1px solid #ff3939'});
            	cnt++;
        	} else {
        		$('#' + k).css({border: ''});
        	}
        }
    });

    if (!cfn_isEmpty(msg)) {
    	msg = '총 ' + cnt + '건의 입력 오류가 있습니다.' + msg;
    	cfn_msg('WARNING', msg);
    	$('#' + focusinput).focus();
    	return false;
    }

    return true;
}

/**
 * 필수입력폼 css 클리어
 * @param {String} formID : 폼태그 아이디
 */
function cfn_clearFormRequireData(formid) {
    var formdata = cfn_getFormData(formid);

    $.each(formdata, function(k, v) {
        if ($('#' + k).hasClass('required')) {
        	$('#' + k).css({border: ''});
        }
    });
}

/**
 * 쿠키 값 저장
 * @param {String} name  : 쿠키 key
 * @param {String} value : 쿠키 value
 * @param {Data} expires : 쿠키유효시간
 */
function setCookie(name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

/**
 * 쿠키 값 가져오기
 * @param {String} Name : 쿠키 key
 * @returns {String} 쿠키값
 */
function getCookie(Name) {
    var search = Name + "=";
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search);
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length;
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset);
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length;
            return unescape(document.cookie.substring(offset, end));
        }
    }
    return "";
}

/**
 * 화면 조회시 textbox enter 이벤트 처리
 * 텍스트박스 class에 evEvent를 추가해서 사용하면 됨
 *  팝업 사용 불가
 */
$(document).on('keydown', '.etkeysech', function(e) {
    var val = $(e.target).val();
    if (e.which === 13 && val.length > 0) {
        if ($('.ui-dialog.ui-widget.ui-widget-content.ui-corner-all.ui-front').last().find('.btn_search').length > 0) {
            $('.ui-dialog.ui-widget.ui-widget-content.ui-corner-all.ui-front').last().find('.btn_search').triggerHandler('click');
            return false;
        }

        if (typeof cfn_retrieve == 'function')
            cfn_retrieve();
    }
});

/**
 * 로딩 시작
 */
function loadingStart() {
    $('body').append('<div id="wrap-loading"><div><img src="/images/loading.gif" /></div></div>');
}

/**
 * 로딩 종료
 */
function loadingEnd() {
    $('#wrap-loading').remove();
}

/**
 * Form을 생성하여 전송한다.
 * @param {String} url : form 전송 URL
 * @param {Hash} data : 전송 파라미터
 */
function gfn_formSubmit(url, data, target) {
    var form = '';

    if (typeof target == 'undefined') {
        form = '<form action="' + url + '" method="post">';
    } else {
        form = '<form action="' + url + '" method="post" target="' + target + '">';
    }

    $.each(data, function(key, value) {
        form += '<input type="hidden" name="' + key + '" value="' + value + '" />';
    });
    form += '</form>';

    $(form).appendTo('body').submit().remove();
}

/**
 * Form 태그를 생성하여 전송한다.
 * @param {Object} obj : Object타입 옵션 설정
 *        - {String} action : 전송 URL
 *        - {String} method : 전송방식
 *        - {String} target : 전송 프레임 위치
 *        - {Object} param : 전송할 파라미터
 */
function gfn_formDynmSubmit(obj) {
    if (typeof obj != 'undefined') {
        var $form = $('<form></form>');

        if (typeof obj.action != 'undefined') {
            $form.attr('action', obj.action);
        }
        if (typeof obj.method != 'undefined') {
            $form.attr('method', obj.method);
        }
        if (typeof obj.target != 'undefined') {
            $form.attr('target', obj.target);
        }
        if (typeof obj.param != 'undefined') {
            $.each(obj.param, function(k, v) {
                $form.append($('<input type="hidden" name="' + k + '" value="' + v + '" />'));
            });
        }

        $form.appendTo('body').submit().remove();
    }
}

/**
 * 메시지 창 출력
 * @param {String} type : 정보: INFO, 경고: WARNING, 에러: ERROR (기본값 INFO)
 * @param {String} msg : 메시지
 * @param {Json} options :
 * 		@key {String} title : 메시지 창 제목
 * 		@key {Boolean} autoCloseFlg : true: 자동 닫힘, false: 닫히지 않음 (기본값 true)
 * 		@key {Number} autoCloseSec : 몇초 후 자동으로 닫을지 설정 (기본값 5)
 */
function cfn_msg(type, msg, options) {
	var _title, icon, timer;
	var _options = $.extend({
		title: '알림',
		autoCloseFlg: false,
		autoCloseSec: 5
	}, options);

	if (type.toUpperCase() === 'WARNING') {
		icon = 'warning';
		_title = '알림 - 경고';
	} else if (type.toUpperCase() === 'ERROR') {
		icon = 'error';
		_title = '에러';
		_options.autoCloseFlg = false;
	} else {
		icon = 'info';
		_title = '알림 - 정보';
	}

	_title = typeof _options.title === 'undefined' || _options.title === null ? _title : _options.title;
	var $body = cfn_getTopFrameFlg() ? $('body') : parent.$('body');
	var lasttag = $body.find('div.cm_msg');

	if (lasttag.length > 0) {
		$body.find('div.cm_msg').find('button').click();
	}

	if (_options.autoCloseFlg) {
		timer = setTimeout(function() {
			$body.find('div.cm_msg').find('button').click();
		}, _options.autoCloseSec * 1000);
	}

	var tag = '<div class="cm_msg" style="top:150px;">';
	tag += '<div class="cm_msgtitle">';
	tag += '<div class="cm_msgtitle_center">' + _title + '</div>';
	tag += '<div class="cm_msgtitle_right"></div>';
	tag += '</div>';
	tag += '<div class="cm_msgtitle_' + icon + '">';
	tag += '</div>';
	tag += '<div class="cm_msgcontent">';
	tag += cfn_replaceAll(msg, '\n', '<br />');
	tag += '</div><div class="cm_msgbottom"><button>OK</button></div>';
	tag += '</div>';

	$body.append(tag);
	$body.find('div.cm_msg').find('button').focus();

	$body.find('div.cm_msg').on('click', 'div.cm_msgtitle_right,button', function(e) {
		if (_options.autoCloseFlg) {
			clearTimeout(timer);
		}
		$body.find('div.cm_msg').remove();
	});
}


/****************************************************************************
 * 문자열 관련 함수
 ***************************************************************************/
/**
 * undefined/null/빈값인지 검사
 * @param val : 검사 대상 값
 * @return {boolean} true / false
 * @author 2017-06-16 KaiKim
 */
function cfn_isEmpty(val) {
	if (typeof val === 'undefined' || val === null) {
		return true;
	} else if (typeof val === 'string' && cfn_trim(val).length < 1) {
		return true;
	} else if (typeof val === 'object' && val.constructor == Object && Object.keys(val).length < 1) {
		return true;
	} else if (typeof val === 'object' && val.constructor == Array && val.length < 1) {
		return true;
	}

	return false;
}

/**
 * 빈값일 경우 기본값 반환
 * @param val : 검사 대상 값
 * @param df : 기본값
 * @return 빈값일 경우 기본값 반환. 아닐경우 기존값
 * @author 2017-06-16 KaiKim
 */
function cfn_ifEmpty(val, df) {
	var _v = val;
	if (cfn_isEmpty(_v)) {
		return df;
	} else if (typeof rtn === 'string') {
		_v = cfn_trim(_v);
	}

	return _v;
}

/**
 * 문자열 좌측에 문자를 채움
 * @param {string} str : 적용 대상 문자열
 * @param {number} length : 문자열 총 길이
 * @param {string} padstr : 좌측에 채울 문자열
 * @return {string} 적용된 문자열
 * @author 2017-06-16 KaiKim
 */
function cfn_lpad(str, length, padstr) {
	var _s = str;
    while(_s.toString().length < length) {
    	_s = padstr + _s;
    }

    return _s;
}

/**
 * 문자열 우측에 문자를 채움
 * @param {string} str : 적용 대상 문자열
 * @param {number} length : 문자열 총 길이
 * @param {string} padstr : 우측에 채울 문자열
 * @return {string} 적용된 문자열
 * @author 2017-06-16 KaiKim
 */
function cfn_rpad(str, length, padstr) {
	var _s = str;
    while(_s.toString().length < length) {
    	_s += padstr;
    }

    return _s;
}

/**
 * 문자열의 양쪽 공백을 제거
 * @param {string} str : 공백제거할 문자열
 * @return {string} 공백제거된 문자열
 * @author 2017-06-16 KaiKim
 */
function cfn_trim(str) {
	return str.toString().replace(/(^\s*)|(\s*$)/gi, '');
}

/**
 * 문자열의 좌측 공백을 제거
 * @param {string} str : 공백제거할 문자열
 * @return {string} 공백제거된 문자열
 * @author 2017-06-16 KaiKim
 */
function cfn_ltrim(str) {
	return str.toString().replace(/^\s+/, '');
}

/**
 * 문자열의 우측 공백을 제거
 * @param {string} str : 공백제거할 문자열
 * @return {string} 공백제거된 문자열
 * @author 2017-06-16 KaiKim
 */
function cfn_rtrim(str) {
	return str.toString().replace(/\s+$/, '');
}

/**
 * 문자열 변환
 * @param {string} str : 대상 문자열
 * @param {string} oldStr : 기존 문자열
 * @param {string} newStr : 변경할 문자열
 * @return {string} 변경된 문자열
 * @author 2017-06-16 KaiKim
 */
function cfn_replaceAll(str, oldStr, newStr) {
	var _s = str;
    if (!cfn_isEmpty(_s)) {
    	_s = _s.split(oldStr).join(newStr);
    }

    return _s;
}


/****************************************************************************
 * 숫자 관련 함수
 ***************************************************************************/
/**
 * 숫자로 변환
 * @param {string} val : 대상 문자열
 * @return 숫자로 반환. 아닐경우 0 반환
 * @author 2017-06-16 KaiKim
 */
function cfn_castNum(val) {
	if (!cfn_isNum(val)) {
		return 0;
	}

	return Number(val);
}

/**
 * 숫자여부 검사
 * @param val : 검사 대상 값
 * @return {boolean} true / false
 * @author 2017-06-16 KaiKim
 */
function cfn_isNum(val) {
	return !isNaN(val) && isFinite(val);
}

/**
 * 숫자 천단위 "," 표시
 * @param num : 대상 숫자
 * @return {string} 천단위 표시한 문자열
 * @author 2017-06-16 KaiKim
 */
function cfn_comma(num) {
    var arrNum = num.toString().split('.');
    var _n = arrNum[0].replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');

    if (arrNum.length > 1) {
    	_n = _n + '.' + arrNum[1];
    }

    return _n;
}

/**
 * 숫자 천단위 "," 제거
 * @param {string} num : 천단위 "," 가 있는 문자열
 * @return {number} 숫자
 * @author 2017-06-16 KaiKim
 */
function cfn_uncomma(num) {
    return num.toString().replace(/[^\d]+/g, '');
}

function cfn_onlyNum(e){
	var keyID = (e.which) ? e.which : e.keyCode;
	if ((keyID >= 33 && keyID <= 40) || (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) ||
			keyID == 8 || keyID == 9 || keyID == 13 || keyID == 16 || keyID == 17 || keyID == 25 || keyID == 46) {
		return;
	} else {
		return false;
	}
}

function cfn_removeChar(e) {
	var keyID = (e.which) ? e.which : e.keyCode;
	if (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39) {
		return;
	} else {
		$(e.target).val($(e.target).val().replace(/[^0-9]/g, ''));
	}
}


/****************************************************************************
 * 날짜 관련 함수
 ***************************************************************************/
/**
 * 현재 일자 가져오기
 * @retrun {date} 년,월,일 날짜형으로 반환
 * @author 2017-06-16 KaiKim
 */
function cfn_getToday() {
    var d = new Date();
    return new Date(d.getFullYear(), d.getMonth(), d.getDate(), 0, 0, 0);
}

/**
 * 해당 월 1일 가져오기
 * @retrun {date} 년,월,일 날짜형으로 반환
 * @author 2018-08-24 ghKim
 */
function cfn_getFirstday(dt) {
    var d = new Date(dt);
    return new Date(d.getFullYear(), d.getMonth(), 1);
}

/**
 * 해당 월 마지막일 가져오기
 * @retrun {date} 년,월,일 날짜형으로 반환
 * @author 2018-08-24 ghKim
 */
function cfn_getLastday(dt) {
    var d = new Date(dt);
    return new Date(d.getFullYear(), d.getMonth()+1, 0);
}

/**
 * 날짜 포맷 적용
 * @param {date, string} dt : 변환할 날짜형 값
 * @param {string} fm : 포맷패턴 (yyyy|yy|MM|dd|E|hh|mm|ss|a/p)
 * @return {string} 포맷형태로 변환된 값 (날짜가 유효하지 않을 경우 빈값 반환)
 * @author 2017-06-16 KaiKim
 */
function cfn_getDateFormat(dt, fm) {
	if (cfn_isEmpty(dt)) return '';
	if (cfn_isEmpty(fm)) return dt;
	var rtn = dt;

	if (typeof rtn === 'string') {
		var year = 0, month = 0, day = 1, hour = 0, minute = 0, second = 0;
		rtn = rtn.replace(/[^0-9]/g, '');
		year = Number(rtn.substring(0, 4));
	    if (rtn.length >= 5) {
	    	month = Number(rtn.substring(4, 5)) - 1;
	    }
	    if (rtn.length >= 6) {
	    	month = Number(rtn.substring(4, 6)) - 1;
	    }
	    if (rtn.length >= 8) {
	    	day = Number(rtn.substring(6, 8));
	    }
	    if (rtn.length >= 12) {
	    	hour = Number(rtn.substring(8, 10));
	    	minute = Number(rtn.substring(10, 12));
	    }
	    if (rtn.length >= 14) {
	    	second = Number(rtn.substring(12, 14));
	    }

	    rtn = new Date(year, month, day, hour, minute, second);
	}

    var weekName = ['일','월','화','수','목','금','토'];

    return fm.replace(/(yyyy|yy|MM|dd|E|hh|HH|mm|ss|a\/p)/gi, function($1) {
    	var h;
        switch ($1) {
            case 'yyyy': return rtn.getFullYear();
            case 'yy': return cfn_lpad(rtn.getFullYear() % 1000, 2, '0');
            case 'MM': return cfn_lpad(rtn.getMonth() + 1, 2, '0');
            case 'dd': return cfn_lpad(rtn.getDate(), 2, '0');
            case 'E': return weekName[rtn.getDay()];
            case 'HH': return cfn_lpad((h = rtn.getHours() % 12) ? h : 12, 2, '0');
            case 'hh': return cfn_lpad(rtn.getHours(), 2, '0');
            case 'mm': return cfn_lpad(rtn.getMinutes(), 2, '0');
            case 'ss': return cfn_lpad(rtn.getSeconds(), 2, '0');
            case 'a/p': return rtn.getHours() < 12 ? '오전':'오후';
            default: return $1;
        }
    });
}

/**
 * 날짜시간이 유효한지 검사
 * @param {string} dt : 검사할 값
 * @return true / false
 * @author 2017-06-16 KaiKim
 */
function cfn_isDateTime(dt) {
	if (cfn_isEmpty(dt)) return false;

	var rDate = dt.replace(/[^0-9]/g, ''),
		rDateLength = rDate.length;

	/* 년도만 체크할 경우 */
	if (rDateLength === 4) {
		return true;
	} else if (rDateLength !== 5 && rDateLength !== 6 && rDateLength !== 8 && rDateLength !== 12 && rDateLength !== 14) {
		return false;
	}

	var month_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
	var year = Number(rDate.substring(0, 4));
    var month = rDateLength === 5 ? Number(rDate.substring(4, 5)) : Number(rDate.substring(4, 6));

    /* 년월만 체크할 경우 */
    if (month > 0 && month <= 12 && (rDateLength === 5 || rDateLength === 6)) return true;

    var day = Number(rDate.substring(6, 8));
    if (day === 0) return false;

    var isValid = false;
    var leaf = false;

    if (year % 4 === 0) {
        leaf = true;

        if(year % 100 === 0) {
            leaf = false;
        }

        if(year % 400 === 0) {
            leaf = true;
        }
    }

    /* 윤년일때 */
    if (leaf) {
        if (month === 2) {
            if(day <= month_day[month-1] + 1) {
                isValid = true;
            }
        } else {
            if(day <= month_day[month-1]) {
                isValid = true;
            }
        }
    } else {
        if (day <= month_day[month-1]) {
            isValid = true;
        }
    }

    if (!isValid) return false;

    var hour, minute, second;
    if (rDate.length > 8) {
        hour = Number(rDate.substring(8, 10));
        minute = Number(rDate.substring(10, 12));

        if (rDate.length > 12) {
        	second = Number(rDate.substring(12, 14));
        }
    }

    if (rDate.length > 8) {
        if (hour < 0 || hour > 23) return false;
        if (minute < 0 || minute > 59) return false;
        if (rDate.length > 12 && (second < 0 || second > 59)) return false;
    }

    return true;
}

/**
 * 메인 프레임인지 여부 반환
 * @return {Boolean} true: 메인프레임, false: 자식프레임
 */
function cfn_getTopFrameFlg() {
	if ($('body.mainbody').length > 0) {
		return true;
	} else {
		return false;
	}
}

/**
 * 활성화된 프로그램/팝업코드 반환
 * @return {String} 프로그램코드 또는 팝업코드
 */
function cfn_getCurProgramcd() {
	var $pop, $prog;

	if (cfn_getTopFrameFlg()) {
		$pop = $('div.pop_wrap').last();
		$prog = $('#tabs').find('li.ui-tabs-active');
	} else {
		$pop = parent.$('div.pop_wrap').last();
		$prog = parent.$('#tabs').find('li.ui-tabs-active');
	}

	if ($pop.length > 0) {
		return $pop.attr('id');
	} else if ($prog.length > 0) {
		return $prog.attr('appkey');
	}

	return undefined;
}

/**
 * 상태별 색상 가져오기
 * @param {Number} n : 상태단계별 숫자 (1: 예정(가능), 2: ~중, 3: 확정(완료), 0: 취소(불가))
 * @return {String} #색상코드
 */
function cfn_getStsColor(n) {
	if (n === 1) {
		return '#ffff1a';
	} else if (n === 2) {
		return '#ffa64b';
	} else if (n === 3) {
		return '#33ff33';
	} else if (n === 0) {
		return '#ff6464';
	}

	return '#a0a0a0';
}

/**
 * 하이차트 데이터 변환
 * @param {Array} list : 배열데이터
 * @param {Json} obj : 변환할 키값 지정
 */
function cfn_divChartData(list, obj) {
	var result = {};

	$.each(obj, function(k, v) {
		result[k] = [];
	});

	for (var i=0, len=list.length; i<len; i++) {
		$.each(obj, function(k, v) {
			result[k].push(list[i][v]);
		});
	}

	return result;
}

/**
 * 하이차트 series clear
 * @param chartid : 차트id 
 */
function cfn_clearChartSeries(chartid) {
	var seriesLength = $('#'+chartid).highcharts().series.length;
	for(var i = seriesLength - 1; i > -1; i--)
    {
		$('#'+chartid).highcharts().series[i].remove();            
    }
}

/**
 * CSV 파일로 Export
 * @param data
 * @param title
 * @param headers
 * @param excludeColumns
 * @param fileName
 */
function cfn_exportCSV(opt) {
	var _opt = $.extend({
		data: [], //데이터
		title: '', //최상위 제목
		headers: [], //헤더명
		excludeColumns: [], //제외 컬럼키
		fileName: 'report', //Export될 csv 파일명
	}, opt);

	var arrCsv = [], arrCsvRow = [];

	if (!cfn_isEmpty(_opt.title)) {
		arrCsv.push(_opt.title);
	}

	if (!cfn_isEmpty(_opt.headers)) {
		arrCsv.push(_opt.headers.join(','));
	}

	for (var i=0, len=_opt.data.length; i<len; i++) {
		arrCsvRow = [];

	    for (var colName in _opt.data[i]) {
	        if (_opt.excludeColumns && _opt.excludeColumns.indexOf(colName) >= 0)
	            continue;
	        arrCsvRow.push(cfn_isEmpty(_opt.data[i][colName]) ? '""' : '"' + _opt.data[i][colName] + '"');
	    }

	    arrCsv.push(arrCsvRow.join(','));
	}

	cfn_exportBlob(arrCsv.join('\r\n'), 'csv', _opt.fileName);
}

/**
 * Blod을 이용한 데이터를 Excel, PDF, CSV Export 처리
 * @param data : 데이터
 * @param {String} type : xls(엑셀파일), xlsx(엑셀파일), pdf, csv
 * @param {String} filename : Export 파일명
 */
function cfn_exportBlob(data, type, filename) {
	var uint8Array, apptype;

	if (type == 'xls') {
		//uint8Array = base64DecToArr(data);
		uint8Array = [uint8Array];
		apptype = 'application/vnd.ms-excel';
		filename = filename + '.xls';
	} else if (type == 'xlsx') {
		//uint8Array = base64DecToArr(data);
		uint8Array = [uint8Array];
		apptype = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
		filename = filename + '.xlsx';
	} else if (type == 'pdf') {
		//uint8Array = base64DecToArr(data);
		uint8Array = [uint8Array];
		apptype = 'application/pdf';
		filename = filename + '.pdf';
	} else if (type == 'csv') {
		uint8Array = ['\ufeff', data];
		apptype = 'text/csv';
		filename = filename + '.csv';
	}

	var blob = new Blob(uint8Array, {type:apptype});

    if (typeof window.navigator.msSaveBlob !== 'undefined') {
    	//IE용
    	//window.navigator.msSaveBlob(blob, filename); //바로열기 없는 다운로드
        window.navigator.msSaveOrOpenBlob(blob, filename);
    } else {
        var URL = window.URL || window.webkitURL;
        var downloadUrl = URL.createObjectURL(blob);

        if (filename) {
            var a = document.createElement('a');
            if (typeof a.download === 'undefined') {
                window.location = downloadUrl;
            } else {
                a.href = downloadUrl;
                a.download = filename;
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
            }
        } else {
            window.location = downloadUrl;
        }

        setTimeout(function () { URL.revokeObjectURL(downloadUrl); }, 100);
    }
}

/**
 * 로그인 정보 가져오기
 * @return {object}
 * cfn_loginInfo().USERCD : 사용자ID
 * cfn_loginInfo().USERNM : 사용자명
 * cfn_loginInfo().COMPCD : 회사코드
 * cfn_loginInfo().COMPNM : 회사명
 * cfn_loginInfo().ORGCD : 사업장코드
 * cfn_loginInfo().ORGNM : 사업장명
 * cfn_loginInfo().CUSTCD : 거래처코드
 * cfn_loginInfo().CUSTNM : 거래처명
 * cfn_loginInfo().DEPTCD : 부서코드
 * cfn_loginInfo().DEPTNM : 부서명
 * cfn_loginInfo().WHCD : 창고코드
 * cfn_loginInfo().WHNM : 창고명
 * * cfn_loginInfo().USERGROUP : 사용자권한
 */
function cfn_loginInfo() {
	var result = {};
	
	
	if (cfn_getTopFrameFlg()) {
		result = loginObj;
	} else {
		result = window.parent.loginObj;
	}

	return result;
}

function cfn_printInfo() {
	var result = {};

	if (cfn_getTopFrameFlg()) {
		result = printObj;
	} else {
		result = window.parent.printObj;
	}

	return result;
}


/**
 * 로트라벨명 가져오기
 * @param lot index(1,2,3)
 */
function cfn_getLotLabel(idx) {
	var retV = '로트속성'+idx;
	if(idx === 1 && !cfn_isEmpty(gv_compItemInfo.LOT1_LABEL)){
		retV = gv_compItemInfo.LOT1_LABEL;
	}
	if(idx === 2 && !cfn_isEmpty(gv_compItemInfo.LOT2_LABEL)){
		retV = gv_compItemInfo.LOT2_LABEL;
	}
	if(idx === 3 && !cfn_isEmpty(gv_compItemInfo.LOT3_LABEL)){
		retV = gv_compItemInfo.LOT3_LABEL;
	}
	if(idx === 4 && !cfn_isEmpty(gv_compItemInfo.LOT4_LABEL)){
		retV = gv_compItemInfo.LOT4_LABEL;
	}
	if(idx === 5 && !cfn_isEmpty(gv_compItemInfo.LOT5_LABEL)){
		retV = gv_compItemInfo.LOT5_LABEL;
	}

	return retV;
}

/**
 * 로트 visible
 * @param lot index(1,2,3)
 */
function cfn_getLotVisible(idx){
	var retV = false;
	if(idx === 1 && gv_compItemInfo.LOT1_YN === 'Y'){
		retV = true;
	}
	if(idx === 2 && gv_compItemInfo.LOT2_YN === 'Y'){
		retV = true;
	}
	if(idx === 3 && gv_compItemInfo.LOT3_YN === 'Y'){
		retV = true;
	}
	if(idx === 4 && gv_compItemInfo.LOT4_YN === 'Y'){
		retV = true;
	}
	if(idx === 5 && gv_compItemInfo.LOT5_YN === 'Y'){
		retV = true;
	}
	return retV;
}

/**
 * 로트 visible
 * @param lot index(1,2,3)
 */
function cfn_getLotHidden(idx){
	var retV = true;
	if(idx === 1 && gv_compItemInfo.LOT1_YN === 'Y'){
		retV = false;
	}
	if(idx === 2 && gv_compItemInfo.LOT2_YN === 'Y'){
		retV = false;
	}
	if(idx === 3 && gv_compItemInfo.LOT3_YN === 'Y'){
		retV = false;
	}
	if(idx === 4 && gv_compItemInfo.LOT4_YN === 'Y'){
		retV = false;
	}
	if(idx === 5 && gv_compItemInfo.LOT5_YN === 'Y'){
		retV = false;
	}
	return retV;
}

/**
 * 품목지정 속성명 가져오기
 */
function cfn_getCompItemInfo() {

	if(!cfn_isEmpty(gv_compItemInfo.F_USER01_YN) && gv_compItemInfo.F_USER01_YN === 'Y'){
		$('#F_USER01_YN').show();
	} else {
		$('#F_USER01_YN').hide();
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER02_YN) && gv_compItemInfo.F_USER02_YN === 'Y'){
		$('#F_USER02_YN').show();
	} else {
		$('#F_USER02_YN').hide();
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER03_YN) && gv_compItemInfo.F_USER03_YN === 'Y'){
		$('#F_USER03_YN').show();
	} else {
		$('#F_USER03_YN').hide();
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER04_YN) && gv_compItemInfo.F_USER04_YN === 'Y'){
		$('#F_USER04_YN').show();
	} else {
		$('#F_USER04_YN').hide();
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER05_YN) && gv_compItemInfo.F_USER05_YN === 'Y'){
		$('#F_USER05_YN').show();
	} else {
		$('#F_USER05_YN').hide();
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER11_YN) && gv_compItemInfo.F_USER11_YN === 'Y'){
		$('#F_USER11_YN').show();
	} else {
		$('#F_USER11_YN').hide();
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER12_YN) && gv_compItemInfo.F_USER12_YN === 'Y'){
		$('#F_USER12_YN').show();
	} else {
		$('#F_USER12_YN').hide();
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER13_YN) && gv_compItemInfo.F_USER13_YN === 'Y'){
		$('#F_USER13_YN').show();
	} else {
		$('#F_USER13_YN').hide();
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER14_YN) && gv_compItemInfo.F_USER14_YN === 'Y'){
		$('#F_USER14_YN').show();
	} else {
		$('#F_USER14_YN').hide();
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER15_YN) && gv_compItemInfo.F_USER15_YN === 'Y'){
		$('#F_USER15_YN').show();
	} else {
		$('#F_USER15_YN').hide();
	}

	if(!cfn_isEmpty(gv_compItemInfo.F_USER01_LABEL)){
		$('#F_USER01_LABEL').text(gv_compItemInfo.F_USER01_LABEL);
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER02_LABEL)){
		$('#F_USER02_LABEL').text(gv_compItemInfo.F_USER02_LABEL);
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER03_LABEL)){
		$('#F_USER03_LABEL').text(gv_compItemInfo.F_USER03_LABEL);
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER04_LABEL)){
		$('#F_USER04_LABEL').text(gv_compItemInfo.F_USER04_LABEL);
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER05_LABEL)){
		$('#F_USER05_LABEL').text(gv_compItemInfo.F_USER05_LABEL);
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER11_LABEL)){
		$('#F_USER11_LABEL').text(gv_compItemInfo.F_USER11_LABEL);
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER12_LABEL)){
		$('#F_USER12_LABEL').text(gv_compItemInfo.F_USER12_LABEL);
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER13_LABEL)){
		$('#F_USER13_LABEL').text(gv_compItemInfo.F_USER13_LABEL);
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER14_LABEL)){
		$('#F_USER14_LABEL').text(gv_compItemInfo.F_USER14_LABEL);
	}
	if(!cfn_isEmpty(gv_compItemInfo.F_USER15_LABEL)){
		$('#F_USER15_LABEL').text(gv_compItemInfo.F_USER15_LABEL);
	}
}

/**
 * 품목지정라벨명 가져오기
 * @param index(1,2,3,4,5,11,12,13,14,15)
 */
function cfn_getCompItemLabel(idx) {
	var retV = '지정속성'+idx;
	if(idx === 1 && !cfn_isEmpty(gv_compItemInfo.F_USER01_LABEL)){
		retV = gv_compItemInfo.F_USER01_LABEL;
	}
	if(idx === 2 && !cfn_isEmpty(gv_compItemInfo.F_USER02_LABEL)){
		retV = gv_compItemInfo.F_USER02_LABEL;
	}
	if(idx === 3 && !cfn_isEmpty(gv_compItemInfo.F_USER03_LABEL)){
		retV = gv_compItemInfo.F_USER03_LABEL;
	}
	if(idx === 4 && !cfn_isEmpty(gv_compItemInfo.F_USER04_LABEL)){
		retV = gv_compItemInfo.F_USER04_LABEL;
	}
	if(idx === 5 && !cfn_isEmpty(gv_compItemInfo.F_USER05_LABEL)){
		retV = gv_compItemInfo.F_USER05_LABEL;
	}

	if(idx === 11 && !cfn_isEmpty(gv_compItemInfo.F_USER11_LABEL)){
		retV = gv_compItemInfo.F_USER11_LABEL;
	}
	if(idx === 12 && !cfn_isEmpty(gv_compItemInfo.F_USER12_LABEL)){
		retV = gv_compItemInfo.F_USER12_LABEL;
	}
	if(idx === 13 && !cfn_isEmpty(gv_compItemInfo.F_USER13_LABEL)){
		retV = gv_compItemInfo.F_USER13_LABEL;
	}
	if(idx === 14 && !cfn_isEmpty(gv_compItemInfo.F_USER14_LABEL)){
		retV = gv_compItemInfo.F_USER14_LABEL;
	}
	if(idx === 15 && !cfn_isEmpty(gv_compItemInfo.F_USER15_LABEL)){
		retV = gv_compItemInfo.F_USER15_LABEL;
	}

	return retV;
}

/**
 * 로트 Hidden
 * @param lot index(1,2,3)
 */
function cfn_getCompItemHidden(idx){

	var retV = true;
	if(idx === 1 && gv_compItemInfo.F_USER01_YN === 'Y'){
		retV = false;
	}
	if(idx === 2 && gv_compItemInfo.F_USER02_YN === 'Y'){
		retV = false;
	}
	if(idx === 3 && gv_compItemInfo.F_USER03_YN === 'Y'){
		retV = false;
	}
	if(idx === 4 && gv_compItemInfo.F_USER04_YN === 'Y'){
		retV = false;
	}
	if(idx === 5 && gv_compItemInfo.F_USER05_YN === 'Y'){
		retV = false;
	}

	if(idx === 11 && gv_compItemInfo.F_USER11_YN === 'Y'){
		retV = false;
	}
	if(idx === 12 && gv_compItemInfo.F_USER12_YN === 'Y'){
		retV = false;
	}
	if(idx === 13 && gv_compItemInfo.F_USER13_YN === 'Y'){
		retV = false;
	}
	if(idx === 14 && gv_compItemInfo.F_USER14_YN === 'Y'){
		retV = false;
	}
	if(idx === 15 && gv_compItemInfo.F_USER15_YN === 'Y'){
		retV = false;
	}
	return retV;
}

/**
 * 로트 Visible
 * @param lot index(1,2,3)
 */
function cfn_getCompItemVisible(idx){

	var retV = false;
	if(idx === 1 && gv_compItemInfo.F_USER01_YN === 'Y'){
		retV = true;
	}
	if(idx === 2 && gv_compItemInfo.F_USER02_YN === 'Y'){
		retV = true;
	}
	if(idx === 3 && gv_compItemInfo.F_USER03_YN === 'Y'){
		retV = true;
	}
	if(idx === 4 && gv_compItemInfo.F_USER04_YN === 'Y'){
		retV = true;
	}
	if(idx === 5 && gv_compItemInfo.F_USER05_YN === 'Y'){
		retV = true;
	}

	if(idx === 11 && gv_compItemInfo.F_USER11_YN === 'Y'){
		retV = true;
	}
	if(idx === 12 && gv_compItemInfo.F_USER12_YN === 'Y'){
		retV = true;
	}
	if(idx === 13 && gv_compItemInfo.F_USER13_YN === 'Y'){
		retV = true;
	}
	if(idx === 14 && gv_compItemInfo.F_USER14_YN === 'Y'){
		retV = true;
	}
	if(idx === 15 && gv_compItemInfo.F_USER15_YN === 'Y'){
		retV = true;
	}
	return retV;
}

/**
 * 로트 Type
 * @param lot index(1,2,3)
 */
function cfn_getLotType(idx){
	var retV = 'text';
	if(idx === 1 && gv_compItemInfo.LOT1_TYPE !== '1'){
		retV = 'date';
	}
	if(idx === 2 && gv_compItemInfo.LOT2_TYPE !== '1'){
		retV = 'date';
	}
	if(idx === 3 && gv_compItemInfo.LOT3_TYPE !== '1'){
		retV = 'date';
	}
	return retV;
}

/* 정산관리 페이징 함수 
 * @param DataresultList
*/
function cfn_auditPayPaging_Set(DataresultList){
	var startRow = 0;
	var endRow = 0;
	var totalCount = 0;
	
	if(DataresultList != ''){
		totalPage = DataresultList[0].TOTAL_PAGE;
	    totalCount = DataresultList[0].TOTAL_COUNT;
		startRow = DataresultList[0].START_ROW;
		endRow = Number(startRow) + Number(DataresultList.length) -1;
	}else{
		currentPageNo = 1;
		totalPage = 0;
		totalCount = 0;
	}
	
	$('#grid1').gridView().setPaging(true, pageRow);
	
	$("#input_paginbottom").val(currentPageNo);
	$("#sp_1_paginbottom").text(totalPage);
	$('#paginbottom_right').text("보기 " + startRow + " - "+ endRow + " / " + totalCount);
	$('#paginbottom_right').attr("style","margin: 5px 5px 0 0;");
	
	//현재 페이지가 0일경우
	if(currentPageNo == 0){
		$('#first_paginbottom').attr("class", "ui-corner-all ui-state-disabled");
		$('#prev_paginbottom').attr("class","ui-corner-all ui-state-disabled");
		$('#next_paginbottom').attr("class","ui-corner-all ui-state-disabled");
		$('#last_paginbottom').attr("class","ui-corner-all ui-state-disabled");
	//현재 페이지가 1일경우
	}else if(currentPageNo == 1){ 
		$('#first_paginbottom').attr("class", "ui-corner-all ui-state-disabled");
		$('#prev_paginbottom').attr("class","ui-corner-all ui-state-disabled");
		//전체 페이지가 1일경우
		if(totalPage == 1){
			$('#next_paginbottom').attr("class","ui-corner-all ui-state-disabled");
			$('#last_paginbottom').attr("class","ui-corner-all ui-state-disabled");
		//전체 페이지가 1이 아닌경우
		}else{
			$('#next_paginbottom').attr("class","ui-corner-all");
			$('#next_paginbottom').attr("style","cursor:pointer; float:left; margin-top : 3.5px;");
			$('#last_paginbottom').attr("class","ui-corner-all");
			$('#last_paginbottom').attr("style","cursor:pointer; float:left; margin-top : 3.5px;");
		}
	//현재 페이지와 전체 페이지가 같을 경우
	}else if(currentPageNo == totalPage){
		$('#first_paginbottom').attr("class", "ui-corner-all");
		$('#first_paginbottom').attr("style","cursor:pointer; float:left; margin-top : 3.5px;");
		$('#prev_paginbottom').attr("class","ui-corner-all");
		$('#prev_paginbottom').attr("style","cursor:pointer; float:left; margin-top : 3.5px;");
		$('#next_paginbottom').attr("class","ui-corner-all ui-state-disabled");
		$('#last_paginbottom').attr("class","ui-corner-all ui-state-disabled");
	}else{
		$('#first_paginbottom').attr("class", "ui-corner-all");
		$('#first_paginbottom').attr("style","cursor:pointer; float:left; margin-top : 3.5px;");
		$('#prev_paginbottom').attr("class","ui-corner-all");
		$('#prev_paginbottom').attr("style","cursor:pointer; float:left; margin-top : 3.5px;");
		$('#next_paginbottom').attr("class","ui-corner-all");
		$('#next_paginbottom').attr("style","cursor:pointer; float:left; margin-top : 3.5px;");
		$('#last_paginbottom').attr("class","ui-corner-all");
		$('#last_paginbottom').attr("style","cursor:pointer; float:left; margin-top : 3.5px;");
	}
}

/* 정산관리 페이징 버튼 이벤트 함수 */
function cfn_auditPayPaging_btnEvt(){
	//5. 페이징 시작(정산관리)
	//맨 처음
	$('#first_paginbottom').click(function(){
		
		if($('#first_paginbottom').attr("class") == "ui-corner-all ui-state-disabled"){
			return false;
		}
		
		//페이징 변수 설정
		currentPageNo = 1;
		//그리드 새로 부르기
		cfn_retrieve();
	});
	//이전
	$('#prev_paginbottom').click(function(){
		
		if($('#prev_paginbottom').attr("class") == "ui-corner-all ui-state-disabled"){
			return false;
		}
		
		//페이징 변수 설정
		currentPageNo = Number(currentPageNo) - 1;
		//그리드 새로 부르기
		cfn_retrieve();
	});
	//다음
	$('#next_paginbottom').click(function(){
		
		if($('#next_paginbottom').attr("class") == "ui-corner-all ui-state-disabled"){
			return false;
		}
		
		//페이징 변수 설정
		currentPageNo = Number(currentPageNo) + 1;
		//그리드 새로 부르기
		cfn_retrieve();
	});
	//맨 마지막
	$('#last_paginbottom').click(function(){
		
		if($('#last_paginbottom').attr("class") == "ui-corner-all ui-state-disabled"){
			return false;
		}
		
		//페이징 변수 설정
		currentPageNo = Number(totalPage);	
		//그리드 새로 부르기
		cfn_retrieve();
	});
	//숫자 입력 엔터
	$('#input_paginbottom').keypress(function(e){
		
		if(e.which == 13){
			var numPage =  Number($.trim($(this).val()));
			
			if(currentPageNo == 0
					|| numPage > totalPage || numPage < 1 || isNaN(numPage)){
				return false;
			}
			//페이징 변수 설정
			currentPageNo = numPage;
			//그리드 새로 부르기
			cfn_retrieve();
		}
	});
	//페이징 끝 */
}

/**
 * input박스 입력 문자 한영변환 (한글 -> 영문, 영문 -> 한글 변환)
 * cfn_lngg_convert() : 문자변환 호출 함수
 * cfn_engTypeToKor() : 한글->영문변환 함수
 * cfn_korTypeToEng() : 영문->한글변환 함수
 * @param String str : '변환문자' 변환 대상 문자 
 * @param String type : 'kor', 'eng' 입력 되는 문자 언어(한글, 영어) 한글일 경우 한글로 변환, 영어일 경우 한글로 변환
 * @return {String} 변환 된 문자
 * @author 2019-10-17 양동근
 */

var ENG_KEY = "rRseEfaqQtTdwWczxvgkoiOjpuPhynbml";
var KOR_KEY = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎㅏㅐㅑㅒㅓㅔㅕㅖㅗㅛㅜㅠㅡㅣ";
var CHO_DATA = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ";
var JUNG_DATA = "ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ";
var JONG_DATA = "ㄱㄲㄳㄴㄵㄶㄷㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅄㅅㅆㅇㅈㅊㅋㅌㅍㅎ";

function cfn_lngg_convert(str, type) {
	/*if (param === 'kor')
		txtConv.value = cfn_engTypeToKor(param.value);
	else
		txtConv.value = cfn_korTypeToEng(param.value);*/
	
	var returnValue = '';
	
	if (type === 'kor'){
		returnValue = cfn_engTypeToKor(str);
	}else{
		returnValue = cfn_korTypeToEng(str);
	}
	
	return returnValue;
}

function cfn_engTypeToKor(src) {
	var res = "";
	if (src.length == 0)
		return res;

	var nCho = -1, nJung = -1, nJong = -1;		// 초성, 중성, 종성

	for (var i = 0; i < src.length; i++) {
		var ch = src.charAt(i);
		var p = ENG_KEY.indexOf(ch);
		if (p == -1) {				// 영자판이 아님
			// 남아있는 한글이 있으면 처리
			if (nCho != -1) {
				if (nJung != -1)				// 초성+중성+(종성)
					res += makeHangul(nCho, nJung, nJong);
				else							// 초성만
					res += CHO_DATA.charAt(nCho);
			} else {
				if (nJung != -1)				// 중성만
					res += JUNG_DATA.charAt(nJung);
				else if (nJong != -1)			// 복자음
					res += JONG_DATA.charAt(nJong);
			}
			nCho = -1;
			nJung = -1;
			nJong = -1;
			res += ch;
		} else if (p < 19) {			// 자음
			if (nJung != -1) {
				if (nCho == -1) {					// 중성만 입력됨, 초성으로
					res += JUNG_DATA.charAt(nJung);
					nJung = -1;
					nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
				} else {							// 종성이다
					if (nJong == -1) {				// 종성 입력 중
						nJong = JONG_DATA.indexOf(KOR_KEY.charAt(p));
						if (nJong == -1) {			// 종성이 아니라 초성이다
							res += makeHangul(nCho, nJung, nJong);
							nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
							nJung = -1;
						}
					} else if (nJong == 0 && p == 9) {			// ㄳ
						nJong = 2;
					} else if (nJong == 3 && p == 12) {			// ㄵ
						nJong = 4;
					} else if (nJong == 3 && p == 18) {			// ㄶ
						nJong = 5;
					} else if (nJong == 7 && p == 0) {			// ㄺ
						nJong = 8;
					} else if (nJong == 7 && p == 6) {			// ㄻ
						nJong = 9;
					} else if (nJong == 7 && p == 7) {			// ㄼ
						nJong = 10;
					} else if (nJong == 7 && p == 9) {			// ㄽ
						nJong = 11;
					} else if (nJong == 7 && p == 16) {			// ㄾ
						nJong = 12;
					} else if (nJong == 7 && p == 17) {			// ㄿ
						nJong = 13;
					} else if (nJong == 7 && p == 18) {			// ㅀ
						nJong = 14;
					} else if (nJong == 16 && p == 9) {			// ㅄ
						nJong = 17;
					} else {						// 종성 입력 끝, 초성으로
						res += makeHangul(nCho, nJung, nJong);
						nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
						nJung = -1;
						nJong = -1;
					}
				}
			} else {								// 초성 또는 (단/복)자음이다
				if (nCho == -1) {					// 초성 입력 시작
					if (nJong != -1) {				// 복자음 후 초성
						res += JONG_DATA.charAt(nJong);
						nJong = -1;
					}
					nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
				} else if (nCho == 0 && p == 9) {			// ㄳ
					nCho = -1;
					nJong = 2;
				} else if (nCho == 2 && p == 12) {			// ㄵ
					nCho = -1;
					nJong = 4;
				} else if (nCho == 2 && p == 18) {			// ㄶ
					nCho = -1;
					nJong = 5;
				} else if (nCho == 5 && p == 0) {			// ㄺ
					nCho = -1;
					nJong = 8;
				} else if (nCho == 5 && p == 6) {			// ㄻ
					nCho = -1;
					nJong = 9;
				} else if (nCho == 5 && p == 7) {			// ㄼ
					nCho = -1;
					nJong = 10;
				} else if (nCho == 5 && p == 9) {			// ㄽ
					nCho = -1;
					nJong = 11;
				} else if (nCho == 5 && p == 16) {			// ㄾ
					nCho = -1;
					nJong = 12;
				} else if (nCho == 5 && p == 17) {			// ㄿ
					nCho = -1;
					nJong = 13;
				} else if (nCho == 5 && p == 18) {			// ㅀ
					nCho = -1;
					nJong = 14;
				} else if (nCho == 7 && p == 9) {			// ㅄ
					nCho = -1;
					nJong = 17;
				} else {							// 단자음을 연타
					res += CHO_DATA.charAt(nCho);
					nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
				}
			}
		} else {									// 모음
			if (nJong != -1) {						// (앞글자 종성), 초성+중성
				// 복자음 다시 분해
				var newCho;			// (임시용) 초성
				if (nJong == 2) {					// ㄱ, ㅅ
					nJong = 0;
					newCho = 9;
				} else if (nJong == 4) {			// ㄴ, ㅈ
					nJong = 3;
					newCho = 12;
				} else if (nJong == 5) {			// ㄴ, ㅎ
					nJong = 3;
					newCho = 18;
				} else if (nJong == 8) {			// ㄹ, ㄱ
					nJong = 7;
					newCho = 0;
				} else if (nJong == 9) {			// ㄹ, ㅁ
					nJong = 7;
					newCho = 6;
				} else if (nJong == 10) {			// ㄹ, ㅂ
					nJong = 7;
					newCho = 7;
				} else if (nJong == 11) {			// ㄹ, ㅅ
					nJong = 7;
					newCho = 9;
				} else if (nJong == 12) {			// ㄹ, ㅌ
					nJong = 7;
					newCho = 16;
				} else if (nJong == 13) {			// ㄹ, ㅍ
					nJong = 7;
					newCho = 17;
				} else if (nJong == 14) {			// ㄹ, ㅎ
					nJong = 7;
					newCho = 18;
				} else if (nJong == 17) {			// ㅂ, ㅅ
					nJong = 16;
					newCho = 9;
				} else {							// 복자음 아님
					newCho = CHO_DATA.indexOf(JONG_DATA.charAt(nJong));
					nJong = -1;
				}
				if (nCho != -1)			// 앞글자가 초성+중성+(종성)
					res += makeHangul(nCho, nJung, nJong);
				else                    // 복자음만 있음
					res += JONG_DATA.charAt(nJong);

				nCho = newCho;
				nJung = -1;
				nJong = -1;
			}
			if (nJung == -1) {						// 중성 입력 중
				nJung = JUNG_DATA.indexOf(KOR_KEY.charAt(p));
			} else if (nJung == 8 && p == 19) {            // ㅘ
				nJung = 9;
			} else if (nJung == 8 && p == 20) {            // ㅙ
				nJung = 10;
			} else if (nJung == 8 && p == 32) {            // ㅚ
				nJung = 11;
			} else if (nJung == 13 && p == 23) {           // ㅝ
				nJung = 14;
			} else if (nJung == 13 && p == 24) {           // ㅞ
				nJung = 15;
			} else if (nJung == 13 && p == 32) {           // ㅟ
				nJung = 16;
			} else if (nJung == 18 && p == 32) {           // ㅢ
				nJung = 19;
			} else {			// 조합 안되는 모음 입력
				if (nCho != -1) {			// 초성+중성 후 중성
					res += makeHangul(nCho, nJung, nJong);
					nCho = -1;
				} else						// 중성 후 중성
					res += JUNG_DATA.charAt(nJung);
				nJung = -1;
				res += KOR_KEY.charAt(p);
			}
		}
	}

	// 마지막 한글이 있으면 처리
	if (nCho != -1) {
		if (nJung != -1)			// 초성+중성+(종성)
			res += makeHangul(nCho, nJung, nJong);
		else                		// 초성만
			res += CHO_DATA.charAt(nCho);
	} else {
		if (nJung != -1)			// 중성만
			res += JUNG_DATA.charAt(nJung);
		else {						// 복자음
			if (nJong != -1)
				res += JONG_DATA.charAt(nJong);
		}
	}

	return res;
}

function makeHangul(nCho, nJung, nJong) {
	return String.fromCharCode(0xac00 + nCho * 21 * 28 + nJung * 28 + nJong + 1);
}

function cfn_korTypeToEng(src) {
	var res = "";
	if (src.length == 0)
		return res;

	for (var i = 0; i < src.length; i++) {
		var ch = src.charAt(i);
		var nCode = ch.charCodeAt(0);
		var nCho = CHO_DATA.indexOf(ch), nJung = JUNG_DATA.indexOf(ch), nJong = JONG_DATA.indexOf(ch);
		var arrKeyIndex = [-1, -1, -1, -1, -1];

		if (0xac00 <= nCode && nCode <= 0xd7a3) {
			nCode -= 0xac00;
			arrKeyIndex[0] = Math.floor(nCode / (21 * 28));			// 초성
			arrKeyIndex[1] = Math.floor(nCode / 28) % 21;			// 중성
			arrKeyIndex[3] = nCode % 28 - 1;						// 종성
		} else if (nCho != -1)			// 초성 자음
			arrKeyIndex[0] = nCho;
		else if (nJung != -1)			// 중성
			arrKeyIndex[1] = nJung;
		else if (nJong != -1)			// 종성 자음
			arrKeyIndex[3] = nJong;
		else							// 한글이 아님
			res += ch;

		// 실제 Key Index로 변경. 초성은 순서 동일
		if (arrKeyIndex[1] != -1) {
			if (arrKeyIndex[1] == 9) {					// ㅘ
				arrKeyIndex[1] = 27;
				arrKeyIndex[2] = 19;
			} else if (arrKeyIndex[1] == 10) {			// ㅙ
				arrKeyIndex[1] = 27;
				arrKeyIndex[2] = 20;
			} else if (arrKeyIndex[1] == 11) {			// ㅚ
				arrKeyIndex[1] = 27;
				arrKeyIndex[2] = 32;
			} else if (arrKeyIndex[1] == 14) {			// ㅝ
				arrKeyIndex[1] = 29;
				arrKeyIndex[2] = 23;
			} else if (arrKeyIndex[1] == 15) {			// ㅞ
				arrKeyIndex[1] = 29;
				arrKeyIndex[2] = 24;
			} else if (arrKeyIndex[1] == 16) {			// ㅟ
				arrKeyIndex[1] = 29;
				arrKeyIndex[2] = 32;
			} else if (arrKeyIndex[1] == 19) {			// ㅢ
				arrKeyIndex[1] = 31;
				arrKeyIndex[2] = 32;
			} else {
				arrKeyIndex[1] = KOR_KEY.indexOf(JUNG_DATA.charAt(arrKeyIndex[1]));
				arrKeyIndex[2] = -1;
			}
		}
		if (arrKeyIndex[3] != -1) {
			if (arrKeyIndex[3] == 2) {					// ㄳ
				arrKeyIndex[3] = 0
				arrKeyIndex[4] = 9;
			} else if (arrKeyIndex[3] == 4) {			// ㄵ
				arrKeyIndex[3] = 2;
				arrKeyIndex[4] = 12;
			} else if (arrKeyIndex[3] == 5) {			// ㄶ
				arrKeyIndex[3] = 2;
				arrKeyIndex[4] = 18;
			} else if (arrKeyIndex[3] == 8) {			// ㄺ
				arrKeyIndex[3] = 5;
				arrKeyIndex[4] = 0;
			} else if (arrKeyIndex[3] == 9) {			// ㄻ
				arrKeyIndex[3] = 5;
				arrKeyIndex[4] = 6;
			} else if (arrKeyIndex[3] == 10) {			// ㄼ
				arrKeyIndex[3] = 5;
				arrKeyIndex[4] = 7;
			} else if (arrKeyIndex[3] == 11) {			// ㄽ
				arrKeyIndex[3] = 5;
				arrKeyIndex[4] = 9;
			} else if (arrKeyIndex[3] == 12) {			// ㄾ
				arrKeyIndex[3] = 5;
				arrKeyIndex[4] = 16;
			} else if (arrKeyIndex[3] == 13) {			// ㄿ
				arrKeyIndex[3] = 5;
				arrKeyIndex[4] = 17;
			} else if (arrKeyIndex[3] == 14) {			// ㅀ
				arrKeyIndex[3] = 5;
				arrKeyIndex[4] = 18;
			} else if (arrKeyIndex[3] == 17) {			// ㅄ
				arrKeyIndex[3] = 7;
				arrKeyIndex[4] = 9;
			} else {
				arrKeyIndex[3] = KOR_KEY.indexOf(JONG_DATA.charAt(arrKeyIndex[3]));
				arrKeyIndex[4] = -1;
			}
		}

		for (var j = 0; j < 5; j++) {
			if (arrKeyIndex[j] != -1)
				res += ENG_KEY.charAt(arrKeyIndex[j]);
		}
	}

	return res;
}