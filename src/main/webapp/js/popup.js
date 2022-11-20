/**
 * 팝업 공통 js
 * @author 2017-07-05 KaiKim
 */
var popup = {
	rtnData:'',
	rtnType:'',
	curfocus:''
};
var gv_compItemInfo = {};
/*
$(function(){
	//최근 포커스 입력폼 전역변수 저장
	$('input,select,textarea').on('focus', function(e) {
		popup.curfocus = e.target;
		return false;
	});
});
*/
(function(){
	/**
	 * 팝업 초기 설정 및 함수 사용
	 * @param {object} p : key/value 형태 파라미터 - 팝업 초기 설정
	 * 		@key {string} title : 팝업 제목 (기본값 '팝업')
	 * 		@key {boolean} autoOpen : 팝업 자동 열림 여부 (기본값 false)
	 * 		@key {boolean} modal : 팝업 modal 여부 (기본값 true)
	 * 		@key {number} width : 팝업 가로 크기 px (기본값 1000)
	 * 		@key {number} height : 팝업 세로 크기 px (기본값 700)
	 * 		@key {object} buttons : 하단 버튼 요소 (key/value 형태)
	 * 		@key {function} open(data, e, ui) : 팝업 시작시 처리 함수
	 * 		@key {function} close(e, ui) : 팝업 종료시 처리 함수
	 * 
	 * @param {string} p ('getParam') : 팝업으로 전달한 파라미터를 반환 ({string} p2 사용시 해당 키값만 반환)
	 * @param {string} p ('setData') : 반환할 배열 데이터 셋팅 ({array} p2 반환할 배열데이터 값)
	 * @param {string} p ('getData') : 반환할 배열 데이터 가져옴
	 * @param {string} p ('close') : 팝업을 닫음 ({string} p2 사용시 type 반환)
	 */
	$.fn.lingoPopup = function(p, p2) {
		/* popup init */
		if (typeof p === 'object') {
			var opt = {
				title: typeof p.title === 'undefined' ? '팝업' : p.title,
				autoOpen: typeof p.autoOpen === 'undefined' ? false : p.autoOpen,
				modal: typeof p.modal === 'undefined' ? true : p.modal,
				width: typeof p.width === 'undefined' ? 1000 : p.width,
				height: typeof p.height === 'undefined' ? 700 : p.height,
				buttons: p.buttons,
				open: p.open,
				close: p.close
			};
			
			/* 품목속성 지정 */
			if (cfn_getTopFrameFlg()) {
				if ($('#tabs').find('div.tabs-content[aria-hidden=false] iframe').length > 0) {
					gv_compItemInfo = $('#' + $('#tabs').find('div.tabs-content[aria-hidden=false] iframe').attr('id'))[0].contentWindow.gv_compItemInfo;
				}
			}
			
			this.dialog({
				title: opt.title,
				autoOpen: opt.autoOpen,
				modal: opt.modal,
				height: opt.height,
				width: opt.width,
				buttons: opt.buttons,
				open: function(e, ui) {
					initPopLayout();
				    cfn_initComponent();

				    if (typeof opt.open === 'function') {
				    	opt.open($(this).data(), e, ui);
				    }
				},
				close: function(e, ui) {
					if (typeof opt.close === 'function') {
						opt.close(e, ui);
					}
					
					popup.rtnType = typeof popup.rtnType === 'undefined' ? 'close' : popup.rtnType;
					pfn_popupClose($(this).data('pid'));
				}
			}).on('keydown', function(e) {
		        if (e.keyCode === 27 || e.which === 27) {
		        	popup.rtnType = 'close';
		        	popup.rtnData = '';
		        }
		    });
		} else if (typeof p === 'string') {
			switch (p) {
				case 'getParam':
					if (typeof p2 === 'undefined') {
						return this.data();
					} else {
						return this.data(p2);
					}
					break;
				case 'setData':
					popup.rtnData = p2;
					break;
				case 'getData':
					return popup.rtnData;
				case 'close':
					popup.rtnType = typeof p2 === 'undefined' ? 'close' : p2;
					this.dialog('close');
					break;
				case 'destroy':
					this.dialog('destroy');
					break;
				case 'isOpen':
					return this.dialog('isOpen');
				case 'open':
					this.dialog('open');
					break;
			}
		}
		
		return this;
	}
})();

/**
 * 팝업 열기
 * @param {object} obj : key/value 형태
 * 		@key {string} url : 팝업url
 * 		@key {string} pid : 팝업id (기본값: 팝업코드)
 * 		@key {object} params : 팝업에 전달될 데이터 (ex. {'key':'value'})
 * 		@key {string} selfFrameFlg : 팝업 프레임위치 여부 (기본값: false)
 * 		@key {function} returnFn(data, type) : callback 함수
 */
function pfn_popupOpen(obj) {
	var opt = {
		url: obj.url,
		pid: obj.pid,
		params: obj.params,
		selfFrameFlg: obj.selfFrameFlg,
		returnFn: obj.returnFn
	}
	
	if (typeof opt.pid === 'undefined') {
		var pid = cfn_replaceAll(opt.url, '/view.do', '');
		opt.pid = pid.substring(pid.lastIndexOf('/') + 1, pid.length)
	}
	
	if (typeof opt.selfFrameFlg === 'undefined') {
		if (cfn_getTopFrameFlg()) {
			opt.selfFrameFlg = true;
		} else {
			opt.selfFrameFlg = false;
		}
	}
	
	var $body = opt.selfFrameFlg ? $('body') : parent.$('body');
	var $popdiv = opt.selfFrameFlg ? $('#pop_' + opt.pid) : parent.$('#pop_' + opt.pid);
	var $pddiv = opt.selfFrameFlg ? $('#pd_' + opt.pid) : parent.$('#pd_' + opt.pid);

	if ($popdiv.length < 1) {
		if (typeof opt.returnFn === 'function') {
			$body.append('<input type="hidden" id="pd_' + opt.pid + '" />');
			$pddiv = opt.selfFrameFlg ? $('#pd_' + opt.pid) : parent.$('#pd_' + opt.pid);
		}
		
		$body.append('<div id="pop_' + opt.pid + '"></div>');
		$popdiv = opt.selfFrameFlg ? $('#pop_' + opt.pid) : parent.$('#pop_' + opt.pid);

		$popdiv.load(opt.url, function() {
            var popid = opt.selfFrameFlg ? $('#' + opt.pid) : parent.$('#' + opt.pid);
            popid.data('pid', opt.pid);
            
            if (typeof opt.params !== 'undefined') {
            	$.each(opt.params, function(k, v) {
            		popid.data(k, v);
            	});
            }
            popid.dialog('open');
            setTimeout(pfn_popupFocus, 100);
        });

        if (typeof opt.returnFn === 'function') {
        	$pddiv.on('click', function(e) {
        		if (opt.selfFrameFlg) {
        			opt.returnFn(popup.rtnData, popup.rtnType);
        		} else {
        			if (cfn_getTopFrameFlg()) {
        				opt.returnFn(popup.rtnData, popup.rtnType);
        			} else {
        				opt.returnFn(parent.popup.rtnData, parent.popup.rtnType);
        			}
        		}
        		return false;
            });
        }
    }
}

/* 팝업 오픈시 강제 포커스 지정 */
function pfn_popupFocus() {
	parent.$('.ui-dialog.ui-widget.ui-widget-content.ui-corner-all.ui-front').last().find('input:text,button.cmb_pop_search').first().focus();
}

/**
 * 팝업 닫기
 * @param {string} pid : 팝업id
 */
function pfn_popupClose(pid) {
	if (cfn_getTopFrameFlg()) {
		if ($('#pop_' + pid).length > 0) {
			var $poppd = $('#pd_' + pid);
			
			if ($poppd.length > 0) {
				$poppd.triggerHandler('click');
			}
			
			var $datetimepicker = $('#' + pid).find('input.cmc_year,input.cmc_yearmonth,input.cmc_date,input.cmc_datetime,input.cmc_datehm');
			
			if ($datetimepicker.length > 0) {
				$datetimepicker.datetimepicker('remove');
			}
			
		    $('#' + pid).dialog('destroy');
		    $('#pop_' + pid).remove();
		    $('#pd_' + pid).remove();
		    $('body').find('.ui-jqdialog').remove();
		}
	} else {
		if (parent.$('#pop_' + pid).length > 0) {
			var $poppd = parent.$('#pd_' + pid);
			
			if ($poppd.length > 0) {
				$poppd.triggerHandler('click');
			}
			
			var $datetimepicker = parent.$('#' + pid).find('input.cmc_year,input.cmc_yearmonth,input.cmc_date,input.cmc_datetime,input.cmc_datehm');
			
			if ($datetimepicker.length > 0) {
				$datetimepicker.datetimepicker('remove');
			}
			
		    parent.$('#' + pid).dialog('destroy');
		    parent.$('#pop_' + pid).remove();
		    parent.$('#pd_' + pid).remove();
		    parent.$('body').find('.ui-jqdialog').remove();
		} else if ($('#pop_' + pid).length > 0) {
			var $poppd = $('#pd_' + pid);
			
			if ($poppd.length > 0) {
				$poppd.triggerHandler('click');
			}
			
			$('#' + pid).find('input.cmc_year,input.cmc_yearmonth,input.cmc_date,input.cmc_datetime,input.cmc_datehm').datetimepicker('remove');
		    $('#' + pid).dialog('destroy');
		    $('#pop_' + pid).remove();
		    $('#pd_' + pid).remove();
		    $('body').find('.ui-jqdialog').remove();
		}
	}
}

/**
 * 코드/명칭 입력폼 팝업 이벤트
 * @param {object} obj : key/value 형태
 *   {string} url : 팝업url
 *   {string} pid : 팝업id (기본값 팝업코드)
 *   {string} codeid : 코드id
 *   {object} inparam : 전달할 입력폼id {컬럼키:id,컬럼키2:id2} (컬럼키:팝업쪽 / id:부모쪽)
 *   {object} outparam : 반환될 출력폼id {컬럼키:id,컬럼키2:id2} (컬럼키:팝업쪽 / id:부모쪽)
 *   {object} params : 전달할 파라미터 {컬럼키:값,컬럼키2:값2}
 *   {boolean} blurflg : blur 이벤트 적용 여부 (기본값 true)
 *   {function} beforeFn() : 팝업 처리 전 함수
 *   {function} returnFn(data, type) : callback 함수
 */
function pfn_codeval(obj) {
	var opt = {
		url: obj.url,
		pid: obj.pid,
		codeid: obj.codeid,
		inparam: obj.inparam,
		outparam: obj.outparam,
		params: obj.params,
		beforeFn: obj.beforeFn,
		returnFn: obj.returnFn,
		blurflg: true,
		_btnflg: false,
		_blurflg: false,
		_enterkeyflg: false,
		_sechXtag: [],
		_changeflg: false
	};
	
	var $cid = $('#' + opt.codeid);
	var $nid = $($cid.nextAll('input.cmc_value')[0]);
	var $btn = $($cid.nextAll('button.cmc_cdsearch')[0]);
	var _dataflg = false;
	
	$btn.attr('id', 'btn_' + opt.codeid).attr('tabindex', '-1').off().on('click', function(e) {
		opt._btnflg = true;
		opt._enterkeyflg = false;
		opt._blurflg = false;
		opt._sechXtag = [$cid, $nid];
		pfn_codevalProc(opt);
	});
	
	$cid.off().on('keydown', function(e) {
		if (e.which === 13 || e.keyCode === 13) {
			if ($cid.val().length > 0) {
				opt._btnflg = false;
				opt._enterkeyflg = true;
				opt._blurflg = false;
				opt._sechXtag = [$nid, $nid];
				_dataflg = pfn_codevalProc(opt);
			}
		} else {
			if (!e.altKey && !e.shiftKey && !e.ctrlKey && pfn_isNotCodeValFnKey(e.keyCode)) {
				$nid.val('');
				
				/*
				if (typeof opt.outparam !== 'undefined') {
					$.each(opt.outparam, function(k, v) {
						if (v !== $cid.attr('id')) {
							$('#' + v).val('');
						}
					});
				}*/
			}
		}
	}).on('change', function(e) {
		opt._changeflg = true;
	});
	
	/*if (opt.blurflg) {
		$cid.on('blur', function(e) {
			if ($cid.val().length > 0) {
				if (!opt._enterkeyflg && !opt._btnflg && !_dataflg) {
					opt._blurflg = true;
					opt._sechXtag = [$nid, $nid];
					pfn_codevalProc(opt);
				}
				opt._btnflg = false;
				opt._enterkeyflg = false;
			} else {	//2017.12.05 추가 코드값이 비었을때 returnfn시 blur적용 가능하게
				if (typeof opt.returnFn === 'function') {
					opt.returnFn(null, null);
				}
			}
			return false;
		});
	}*/
	
	$nid.off().on('keydown', function(e) {
		if (e.which === 13 || e.keyCode === 13) {
			if ($nid.val().length > 0) {
				opt._btnflg = false;
				opt._enterkeyflg = true;
				opt._blurflg = false;
				opt._sechXtag = [$cid, $cid];
				_dataflg = pfn_codevalProc(opt);
			}
		} else {
			if (!e.altKey && !e.shiftKey && !e.ctrlKey && pfn_isNotCodeValFnKey(e.keyCode)) {
				$cid.val('');
				/*
				if (typeof opt.outparam !== 'undefined') {
					$.each(opt.outparam, function(k, v) {
						if (v !== $nid.attr('id')) {
							$('#' + v).val('');
						}
					});
				}*/
			}
		}
	});
}

/**
 * 코드/명칭 입력폼 팝업 이벤트(멀티 선택 조회 팝업)
 * @param {object} obj : key/value 형태
 *   {string} url : 팝업url
 *   {string} pid : 팝업id (기본값 팝업코드)
 *   {string} codeid : 코드id
 *   {object} inparam : 전달할 입력폼id {컬럼키:id,컬럼키2:id2} (컬럼키:팝업쪽 / id:부모쪽)
 *   {object} outparam : 반환될 출력폼id {컬럼키:id,컬럼키2:id2} (컬럼키:팝업쪽 / id:부모쪽)
 *   {object} params : 전달할 파라미터 {컬럼키:값,컬럼키2:값2}
 *   {boolean} blurflg : blur 이벤트 적용 여부 (기본값 true)
 *   {function} beforeFn() : 팝업 처리 전 함수
 *   {function} returnFn(data, type) : callback 함수
 */
function pfn_codevalList(obj) {
	var opt = {
		url: obj.url,
		pid: obj.pid,
		codeid: obj.codeid,
		inparam: obj.inparam,
		outparam: obj.outparam,
		params: obj.params,
		beforeFn: obj.beforeFn,
		returnFn: obj.returnFn,
		blurflg: true,
		_btnflg: false,
		_blurflg: false,
		_enterkeyflg: false,
		_sechXtag: [],
		_changeflg: false
	};
	
	var $cid = $('#' + opt.codeid);
	var $nid = $($cid.nextAll('input.cmc_value')[0]);
	var $btn = $($cid.nextAll('button.cmc_cdsearch')[0]);
	var _dataflg = false;
	
	$btn.attr('id', 'btn_' + opt.codeid).attr('tabindex', '-1').off().on('click', function(e) {
		opt._btnflg = true;
		opt._enterkeyflg = false;
		opt._blurflg = false;
		opt._sechXtag = [$cid, $nid];
		// 확인 필요
		pfn_codevalListProc(opt);
	});
	
	$cid.off().on('keydown', function(e) {
			if (!e.altKey && !e.shiftKey && !e.ctrlKey && pfn_isNotCodeValFnKey(e.keyCode)) {
				$nid.removeAttr('title');
				$cid.removeAttr('title');
				$nid.val('');
				
			}
	
	});
	
	$nid.off().on('keydown', function(e) {
			if (!e.altKey && !e.shiftKey && !e.ctrlKey && pfn_isNotCodeValFnKey(e.keyCode)) {
				$cid.removeAttr('title');
				$nid.removeAttr('title');
				$cid.val('');
				
			}
		
	});
	
	if (opt.blurflg) {
		$cid.on('blur', function(e) {
			if ($cid.val().length > 0) {
				
				opt._btnflg = false;
				opt._enterkeyflg = false;
			}
			return false;
		});
	}
	
}

/**
 * 코드/명칭 입력폼 팝업 이벤트 처리(멀티 선택 팝업)
 * @param {object} opt : key/value 형태
 */
function pfn_codevalListProc(opt) {
	var resultData, resultType, resultGridData = [];
	
	var _inparam = {};

	if (!opt._btnflg && !cfn_isEmpty(_inparam)) {
		var sendData = {'paramData':_inparam};
		var url = opt.url.replace('/view.do', '/search.do');
		
		gfn_ajax(url, false, sendData, function(data, xhr) {
			resultGridData = data.resultList;
			
		});
	}
	
	_inparam.gridData = resultGridData;

	pfn_popupOpen({
		url: opt.url,
		pid: opt.pid,
		params: _inparam,
		selfFrameFlg: false,
		returnFn: function(data, type) {
			resultType = type;
			resultData = data;
			
			var cd, nm;
			if (cfn_isEmpty(data)) {
				if (opt._changeflg) {
					$.each(opt.outparam, function(k, v) {
						if (v.indexOf(',') >= 0) {
							var _vs = v.split(',');
							
							for (var ii=0; ii<_vs.length; ii++) {
								$('#' + _vs[ii]).val('');
							}
						} else {
							$('#' + v).val('');
						}
					});
				}
			} else if (data.length === 1) {
				$.each(opt.outparam, function(k, v) {
					opt._changeflg = false;
					
					if (v.indexOf(',') >= 0) {
						var _vs = v.split(',');
						
						for (var ii=0; ii<_vs.length; ii++) {
							
							$('#' + _vs[ii]).val(data[0][k]);
							cd = data[0][k].replace(/,/gi,"<br/>");
							$('#' + _vs[ii]).tooltip({
								content:function(){
									return $(this).prop('title');
								}
							});
							$('#' + _vs[ii]).attr('title',cd).tooltip({show: {delay: 500}, hide: false});
						}
					} else {
						$('#' + v).val(data[0][k]);
						nm = data[0][k].replace(/,/gi,"<br/>");
						$('#' + v).tooltip({
							content:function(){
								return $(this).prop('title');
							}
						});
						$('#' + v).attr('title',nm).tooltip({show: {delay: 500}, hide: false});
					}
				});
			}
			
			if (typeof opt.returnFn === 'function') {
				opt.returnFn(resultData, resultType);
			}
			
			$('#' + opt.codeid).focus().select();
		}
	});
	
	return true;
}

/**
 * 코드/명칭 입력폼 팝업 이벤트 처리
 * @param {object} opt : key/value 형태
 */
function pfn_codevalProc(opt) {
	var resultData, resultType, resultGridData = [];
	
	var _inparam = {};
	$.each(opt.inparam, function(k, v) {
		if (opt._sechXtag[0].attr('id') !== v && opt._sechXtag[1].attr('id') !== v) {
			if (v.indexOf(',') >= 0) {
				var _vs = v.split(',');
				var _val = '';
				
				for (var ii=0; ii<_vs.length; ii++) {
					if (opt._sechXtag[0].attr('id') !== _vs[ii] && opt._sechXtag[1].attr('id') !== _vs[ii]) {
						if (!cfn_isEmpty($('#' + _vs[ii]).val())) {
							_val = $('#' + _vs[ii]).val();
						}
					}
				}
				
				_inparam[k] = _val;
			} else {
				_inparam[k] = $('#' + v).val();
			}
		}
	});
	$.each(opt.params, function(k, v) {
		_inparam[k] = v;
	});
	
	if (typeof opt.beforeFn === 'function') {
		var flg = opt.beforeFn();
		if (flg === false) {
			$.each(opt.inparam, function(k, v) {
				$('#' + v).val('');
			});
			return false;
		}
	}
	
	if (!opt._btnflg && !cfn_isEmpty(_inparam)) {
		var sendData = {'paramData':_inparam};
		var url = opt.url.replace('/view.do', '/check.do');
		
		gfn_ajax(url, false, sendData, function(data, xhr) {
			resultGridData = data.resultList;
			
			if (resultGridData.length === 1) {
				$.each(opt.outparam, function(k, v) {
					opt._changeflg = false;
					
					if (v.indexOf(',') >= 0) {
						var _vs = v.split(',');
						
						for (var ii=0; ii<_vs.length; ii++) {
							$('#' + _vs[ii]).val(resultGridData[0][k]);
						}
					} else {
						$('#' + v).val(resultGridData[0][k]);
					}
				});
				
				if (typeof opt.returnFn === 'function') {
					opt.returnFn(resultData, resultType);
				}
			}
		});
	}
	
	if (resultGridData.length === 1) {
		return false;
	}
	
	_inparam.gridData = resultGridData;
/*
	var prevFocus = popup.curfocus;
	*/
	pfn_popupOpen({
		url: opt.url,
		pid: opt.pid,
		params: _inparam,
		selfFrameFlg: false,
		returnFn: function(data, type) {
			resultType = type;
			resultData = data;
			
			if (cfn_isEmpty(data)) {
				if (opt._changeflg) {
					$.each(opt.outparam, function(k, v) {
						if (v.indexOf(',') >= 0) {
							var _vs = v.split(',');
							
							for (var ii=0; ii<_vs.length; ii++) {
								$('#' + _vs[ii]).val('');
							}
						} else {
							$('#' + v).val('');
						}
					});
				}
			} else if (data.length === 1) {
				$.each(opt.outparam, function(k, v) {
					opt._changeflg = false;
					
					if (v.indexOf(',') >= 0) {
						var _vs = v.split(',');
						
						for (var ii=0; ii<_vs.length; ii++) {
							$('#' + _vs[ii]).val(data[0][k]);
						}
					} else {
						$('#' + v).val(data[0][k]);
					}
				});
			}
			/*
			var nextFocus = popup.curfocus;
			var focusflg = false;
			
			if (prevFocus.id !== nextFocus.id) {
				focusflg = true;
			} else if (!opt._blurflg && popup.curfocus !== '') {
				focusflg = true;
			}
			
			if (focusflg) {
				$(popup.curfocus).focus().select();
			}*/
			
			if (typeof opt.returnFn === 'function') {
				opt.returnFn(resultData, resultType);
			}
			
			$('#' + opt.codeid).focus().select();
		}
	});
	
	return true;
}

/**
 * 코드/명 폼에서 입력한 KeyCode 검사 - 기능키 제외
 * @param {number} keycode
 */
function pfn_isNotCodeValFnKey(keycode) {
    var notKeyList = [81,9,16,17,18,19,20,27,33,34,35,36,37,38,39,40,44,45,91,93,144,145];

    if (notKeyList.indexOf(keycode) >= 0) {
        return false;
    }

    return true;
}

/**
 * 우편번호 코드/명칭 적용
 * @param {string} postid : 우편번호 입력 id
 * @param {string} addrid : 주소 입력 id
 */
function pfn_postcodeval(postid, addrid) {
	pfn_codeval({
		url:'/sys/popup/popPost/view.do',codeid:postid,blurflg:false,
		outparam:{POST:postid,ADDR:addrid}
	});
}

/**
 * 업로드 팝업
 * @param {string} pgmid : 프로그램ID
 */
function pfn_upload(pgmid){
	pfn_popupOpen({
		url:'/alexcloud/popup/popE000/view.do',
		params:{'S_PGMID':pgmid},
		returnFn: function(data) {
			if (data.length > 0) {
				
			}
		}		
	});	
}

///**
// * 업로드 팝업
// * @param {string} pgmid : 프로그램ID
// */
//function pfn_audit_upload(pgmid){
//	pfn_popupOpen({
//		url:'/auditPay/popup/popAE100/view.do',
//		params:{'S_PGMID':pgmid},
//		returnFn: function(data) {
//			if (data.length > 0) {
//				
//			}
//		}		
//	});	
//}

/**
 * 전자결재 팝업
 * @param {string} eakey : 전자결재번호
 * @param {string} schDate : 전표요청일
 * @param {string} menuid : 메뉴id
 * @param {string} refno1 : 전표번호
 * @param {string} refno2 : 전표내용 - 구매, 발주, ......
 * @param {string} compcd : 회사코드
 * @param {string} compcd : 사업장코드
 * @param {string} custnm : 거래처명
 * @param {string} totsupplyamt : 총금액
 * @param {string} itemcnt : 품목수
 * @param {string} totqty : 총수량
 * @param {string} remark : 비고
 */
function pfn_elecAppr(eakey, schDate, menuid, refno1, refno2,
		              compcd, orgcd, custnm, totsupplyamt,
		              itemcnt, totqty, remark){
	// 전자결재번호 다시한번 확인
	if(cfn_isEmpty(eakey)){
		var sendData = {'paramData':{'REFNO1':refno1}};
		var url = '/alexcloud/popup/PopS120/getSearchDocNo.do';
		
		gfn_ajax(url, false, sendData, function(data, xhr) {
			eakey = data.DocNo;
		});
	}
	
	if(!cfn_isEmpty(eakey)) {
		pfn_popupOpen({
			url:'/alexcloud/popup/PopS120/view.do',
			pid:'PopS120',
			params:{'DOCNO':eakey}
		});
		return;
	} 
	var today = new Date(cfn_getDateFormat(schDate, 'yyyy-MM-dd'));
	
	var year = today.getFullYear(); //년
	var month = today.getMonth() + 1; //월
	var date = today.getDate(); //일
	var day = today.getDay(); //요일
	var week = new Array('일', '월', '화', '수', '목', '금', '토');

	var docdt = year + '년 ' + month + '월 ' + date + '일 (' + week[day] + ')';
	//realgrid가 빈값이 undefined 로 null로 db에 저장되어, 문서에 찍을 때 null로나옴.
	if(cfn_isEmpty(remark)) { 
		remark = '';
	}
	
	pfn_popupOpen({
		url:'/alexcloud/popup/PopS100/view.do',
		pid:'PopS100',
		params:{'DOCNAME':refno2+' 기안서',						//기안서 제목
				//전자결재 제목 ex) 7/6 (목) 발주 요청건(발주번호 : PO201706300005)
				'DOCTITLE':month + '/' + date + ' (' + week[day] + ') '+ refno2 +' 요청건 ('+refno2+'번호 : ' +  refno1 + ')',
				'DOCDT':docdt, 								//기안일자
				'MENUID':menuid,							//전자결재를 사용하는 화면명
				'REFNO1':refno1, 					        //전자결재를 올릴 전표 번호
				'REFNO2': refno2,							//업무구분
				'ORGCD':orgcd,  			                //사업장
				'COMPCD':compcd,					        //회사
				'CUSTNM': custnm,				            //거래처 이름 
				'TOTSUPPLYAMT': totsupplyamt,	            //총금액
				'ITEMCNT': itemcnt, 				        //품목수
				'TOTQTY': totqty,				            //총수량
				'REMARK': remark							//전표비고
				},
		returnFn: function(data) {
		}		
	});
}