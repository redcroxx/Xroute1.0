/**
 * 화면 공통 js
 * @author 2017-07-05 KaiKim
 */
/**
 * 화면 레이아웃 설정
 */
function initLayout() {
	cfn_setLayout('#ct_wrap');
}

/**
 * 팝업 레이아웃 설정
 */
function initPopLayout() {
	cfn_setLayout('.pop_wrap');
}

/**
 * 레이아웃 구성 및 리사이징 처리
 */
function cfn_setLayout(target) {
	var botPad = 10; /* bot 상단padding값 */
	var rightPad = 15; /* right 좌측padding값 */

	$(target).find('.ct_top_wrap, .ct_left_wrap').each(function(i, tag) {
		var $sech = $(tag).parent().children('#ct_sech_wrap');
		
		/* 탭설정 */
		var ctTabs = $(target + ' .ct_tab');
		if (ctTabs.length > 0) {
			ctTabs.tabs({
				activate: function(e, ui) {
					/* 리사이징 처리 */
					$(window).triggerHandler('resize');
				}
			});
		}

		if ($(tag).children().children('.tblForm').length > 0) {
			$(tag).css('overflow','auto');
		}

		/* 상하 분할 리사이징 */
		if ($(tag).next().hasClass('ct_bot_wrap')) {
			var $top = $(tag), $bot = $(tag).next();
			var topDfHeight = $top.css('height').replace('px',''), botDfHeight = $bot.css('height').replace('px','');
			if (!$top.hasClass('botfix')) 
				$top.resizable({handles:'s'});

			$(window).bind('resize', function(e) {
				var parentHeight = $top.parent().height();
				var sechHeight = ($sech.length > 0) ? $sech.outerHeight(true) : 0;
				var defaultHeight = Math.floor((parentHeight - sechHeight) / 2);
				
				/* 브라우저 창 조절 및 해상도에 따른 조정 */
				if (typeof e.which == 'undefined') {
					if ($bot.hasClass('fix')) {
						$bot.height(botDfHeight - botPad);
						$top.height(parentHeight - sechHeight - $bot.outerHeight(true));
					} else {
						$top.height($top.hasClass('fix') ? topDfHeight : defaultHeight - botPad);
						$bot.height(parentHeight - sechHeight - $top.outerHeight(true) - botPad);
					}
				}
				/* 라인 리사이즈 조절시 */
				else {
					$bot.height(parentHeight - sechHeight - $top.outerHeight(true) - botPad);
				}
			}).trigger('resize');
		}

		/* 상하 3단 균등 분할 */
		else if ($(tag).next().hasClass('ct_mid_wrap')) {

			var $top = $(tag), $mid = $(tag).next(), $bot = $(tag).next().next();
			var topDfHeight = $top.css('height').replace('px',''), midDfHeight = $mid.css('height').replace('px',''), botDfHeight = $bot.css('height').replace('px','');
			
			//$top.resizable({handles:'s'});
			$mid.resizable({handles:'s'});
			

			$(window).bind('resize', function(e) {
				var parentHeight = $top.parent().height();
				var sechHeight = ($sech.length > 0) ? $sech.outerHeight(true) : 0;
				var defaultHeight = Math.floor((parentHeight - sechHeight) / 3);
				var parentWidth = $top.parent().width();
				var sechWidth = ($sech.length > 0) ? $sech.outerWidth(true) : 0;
				var defaultWidth = parentWidth - sechWidth;
				
				/* 브라우저 창 조절 및 해상도에 따른 조정 */
				if (typeof e.which == 'undefined') {
					if ($bot.hasClass('fix')) {
						$bot.height(botDfHeight - botPad);
						var halfHeight = Math.floor((parentHeight - $top.outerHeight(true)) / 2);
						$top.height(halfHeight);
						$mid.height(halfHeight - botPad);						
					} else if($mid.hasClass('fix')) {
						$mid.height(midDfHeight - botPad);
						var halfHeight = Math.floor((parentHeight - $mid.outerHeight(true)) / 2);
						$top.height(halfHeight);
						$bot.height(halfHeight - botPad);
					} else if($top.hasClass('fix')) {
						$top.height($top.hasClass('fix') ? topDfHeight : defaultHeight);
						var halfHeight = Math.floor((parentHeight - $top.outerHeight(true)) / 2);
						$mid.height(halfHeight - botPad);
						$bot.height(halfHeight - botPad);
					}
				} else if ($(e.target).hasClass('ct_top_wrap')) {
					$mid.height(parentHeight - $top.outerHeight(true) - $bot.outerHeight(true) - botPad);
				} else if ($(e.target).hasClass('ct_mid_wrap')) {
					$bot.height(parentHeight - $top.outerHeight(true) - $mid.outerHeight(true) - botPad);
				}

				$top.width(defaultWidth);
				$mid.width(defaultWidth);
				$bot.width(defaultWidth);
				
			}).trigger('resize');
		}
		/* 좌우 분할 리사이징 */
		else if ($(tag).next().hasClass('ct_right_wrap')) {
			var $left = $(tag), $right = $(tag).next();
			var leftDfWidth = $left.css('width').replace('px',''), rightDfWidth = $right.css('width').replace('px','');
			$left.resizable({handles:'e'});

			$(window).bind('resize', function(e) {
				var scrollwidth = $left.parent().innerWidth() > $left.parent()[0].scrollWidth ? 17 : 1;
				var parentWidth = $left.parent().width() - scrollwidth;
				var parentHeight = $left.parent().height();
				var sechHeight = ($sech.length > 0) ? $sech.outerHeight(true) : 0;
				var defaultWidth = Math.floor(parentWidth / 2);
				var defaultHeight = parentHeight - sechHeight;
				
				/* 브라우저 창 조절 및 해상도에 따른 조정 */
				if (typeof e.which == 'undefined') {
					if ($right.hasClass('fix')) {
						$right.width(rightDfWidth - rightPad);
						$left.width(parentWidth - $right.outerWidth(true));
					} else {
						$left.width($left.hasClass('fix') ? leftDfWidth : defaultWidth);
						$right.width(parentWidth - $left.outerWidth(true) - rightPad);
					}
				}
				/* 라인 리사이즈 조절시 */
				else {
					$right.width(parentWidth - $left.outerWidth(true) - rightPad);
				}
				
				$left.height(defaultHeight);
				$right.height(defaultHeight);
			}).trigger('resize');
		}
		/* 좌우3단 균등 분할 */
		else if ($(tag).next().hasClass('ct_center_wrap')) {
			var $left = $(tag), $center = $(tag).next(), $right = $(tag).next().next();
			var leftDfWidth = $left.css('width').replace('px',''), centerDfWidth = $center.css('width').replace('px',''), rightDfWidth = $right.css('width').replace('px','');
			$left.resizable({handles:'e'});
			$center.resizable({handles:'e'});

			$(window).bind('resize', function(e) {
				var scrollwidth = $left.parent().innerWidth() > $left.parent()[0].scrollWidth ? 17 : 1;
				var parentWidth = $left.parent().width() - scrollwidth;
				var parentHeight = $left.parent().height();
				var sechHeight = ($sech.length > 0) ? $sech.outerHeight(true) : 0;
				var defaultWidth = Math.floor(parentWidth / 3);
				var defaultHeight = parentHeight - sechHeight;

				if (typeof e.which == 'undefined') {
					if ($center.hasClass('fix')) {
						$center.width(centerDfWidth - rightPad);
						var halfWidth = Math.floor((parentWidth - $center.outerWidth(true)) / 2);
						$left.width(halfWidth);
						$right.width(halfWidth - rightPad);
					} else if ($right.hasClass('fix')) {
						$right.width(rightDfWidth - rightPad);
						var halfWidth = Math.floor((parentWidth - $right.outerWidth(true)) / 2);
						$left.width(halfWidth);
						$center.width(halfWidth - rightPad);
					} else {
						$left.width($left.hasClass('fix') ? leftDfWidth : defaultWidth);
						var halfWidth = Math.floor((parentWidth - $left.outerWidth(true)) / 2);
						$center.width(halfWidth - rightPad);
						$right.width(halfWidth - rightPad);
					}
				} else if ($(e.target).hasClass('ct_left_wrap')) {
					$center.width(parentWidth - $left.outerWidth(true) - $right.outerWidth(true) - rightPad);
				} else if ($(e.target).hasClass('ct_center_wrap')) {
					$right.width(parentWidth - $left.outerWidth(true) - $center.outerWidth(true) - rightPad);
				}

				$left.height(defaultHeight);
				$center.height(defaultHeight);
				$right.height(defaultHeight);
			}).trigger('resize');
		}
		/* 단일 리사이징 */
		else {
			$(window).bind('resize', function(e) {
				var sechHeight = ($sech.length > 0) ? $sech.outerHeight(true) : 0;
				$(tag).height($(tag).parent().height() - sechHeight);
		    }).trigger('resize');
		}
	});

	/* 검색조건 확장 */
	var sech_extwrap = $(target + ' #sech_extwrap');
	var ct_sech_wrap = $(target + ' #ct_sech_wrap');
	var sech_extbtn = $(target + ' #sech_extbtn');
	
	if (sech_extwrap.length > 0) {
		ct_sech_wrap.css('padding', '4px 0 2px 0');
		sech_extwrap.hide();
		sech_extbtn.click(function(e) {
			if (sech_extbtn.attr('class') == 'down') {
				ct_sech_wrap.css('padding', '4px 0 6px 0');
				sech_extbtn.attr('class', 'up');
				sech_extwrap.show();
			} else {
				ct_sech_wrap.css('padding', '4px 0 2px 0');
				sech_extbtn.attr('class', 'down');
				sech_extwrap.hide();
			}
			refreshLayout();
		});
	}

	/* 상세폼 확장 */
	var form_extwrap = $(target + ' #form_extwrap');
	var form_extbtn = $(target + ' #form_extbtn');
	
	if (form_extwrap.length > 0) {
		form_extwrap.hide();
		form_extbtn.click(function(e) {
			if (form_extbtn.attr('class') == 'down') {
				form_extbtn.attr('class', 'up');
				form_extwrap.show();
			} else {
				form_extbtn.attr('class', 'down');
				form_extwrap.hide();
			}
			refreshLayout();
		});
	}

	/* 입력폼 필수 색상 적용 */
	var threquired = $(target + ' th.required');
	
	if (threquired.length > 0) {
		$.each(threquired, function(k, v) {
			if ($(v).html().indexOf('<span') < 0) {
				$(v).html('<span style="padding-right:2px;color:red">*</span>' + $(v).html());
			}
		});
	}
}

/**
 * 화면 레이아웃 새로고침
 */
function refreshLayout() {
	$(window).triggerHandler('resize');
}

/**
 * 상세화면 공통버튼 클릭
 * @param type(버튼종류:RET(검색),LIST(목록),NEW(신규),DEL(삭제),SAVE(저장),COPY(복사),INIT(초기화),EXECUTE(지시),PRINT(출력),EXCELDOWN(엑셀다운),EXCELUP(엑셀업로드),
 * 				USER1(사용자버튼1)..USER5(사용자버튼5))
 */
function gfn_cmnBtn_onclick(type) {
	switch(type) {
	case "RET": 	//검색버튼
		if (typeof cfn_retrieve == 'function')
			cfn_retrieve();
		break;
	case "LIST": 	//목록버튼
		if (typeof cfn_list == 'function')
			cfn_list();
		break;
	case "NEW": 	//신규버튼
		if (typeof cfn_new == 'function')
			cfn_new();
		break;
	case "DEL": 	//삭제버튼
		if (typeof cfn_del == 'function')
			cfn_del();
		break;
	case "SAVE": 	//저장버튼
		if (typeof cfn_save == 'function')
			cfn_save();
		break;
	case "COPY": 	//복사버튼
		if (typeof cfn_copy == 'function')
			cfn_copy();
		break;
	case "INIT": 	//초기화버튼
		if (typeof cfn_init == 'function')
			cfn_init();
		break;
	case "EXECUTE": //실행버튼
		if (typeof cfn_execute == 'function')
			cfn_execute();
		break;
	case "CANCEL": //취소버튼
		if (typeof cfn_cancel == 'function')
			cfn_cancel();
		break;
	case "PRINT": 	//출력버튼
		if (typeof cfn_print == 'function')
			cfn_print();
		break;
	case "EXCELDOWN": 	//엑셀다운버튼
		if (typeof cfn_exceldown == 'function')
			cfn_exceldown();
		break;
	case "EXCELUP": 	//엑셀업로드버튼
		if (typeof cfn_excelup == 'function')
			cfn_excelup();
		break;
	case "USER1": 	//사용자설정1버튼
		if (typeof cfn_userbtn1 == 'function')
			cfn_userbtn1();
		break;
	case "USER2": 	//사용자설정2버튼
		if (typeof cfn_userbtn2 == 'function')
			cfn_userbtn2();
		break;
	case "USER3": 	//사용자설정3버튼
		if (typeof cfn_userbtn3 == 'function')
			cfn_userbtn3();
		break;
	case "USER4": 	//사용자설정4버튼
		if (typeof cfn_userbtn4 == 'function')
			cfn_userbtn4();
		break;
	case "USER5": 	//사용자설정5버튼
		if (typeof cfn_userbtn5 == 'function')
			cfn_userbtn5();
		break;
	default:
		break;
	}
}

/**
 * 공통버튼 설정
 * @param {String} id : ret(검색),list(목록),new(신규),del(삭제),save(저장),copy(복사),init(초기화),execute(실행),
 * 						excelup(엑셀업로드),exceldown(엑셀다운),print(출력),user1(사용자버튼1)..user5(사용자버튼5)
 * @param {Boolean} flag : true: 표시, false: 숨김
 * @param {String} text : 버튼 텍스트
 * @param {Json} options : 기타 설정
 * 		@key {String} iconname : 아이콘명
 * 		@key {String} tooltip : 툴팁내용
 */
function setCommBtn(id, flag, text, options) {
	if (typeof flag !== 'undefined' && flag !== null) {
		if (flag) {
			$('#cbtn_'+id.toLowerCase()).show();
		} else {
			$('#cbtn_'+id.toLowerCase()).hide();
		}
	}

	if (typeof text !== 'undefined' && text !== null) {
		$('#cbtn_'+id.toLowerCase()).val(text);
	}
	
	if (typeof options !== 'undefined' && options !== null) {
		$.each(options, function(k, v) {
			if (k === 'iconname') {
				$('#cbtn_' + id.toLowerCase()).css('background', 'url("/images/' + v + '") 3px 3px no-repeat').css('background-size', '18px auto');
			} else if (k === 'tooltip') {
				$('#cbtn_' + id.toLowerCase()).attr('title', v).tooltip({show: {delay: 500}, hide: false});
			}
		});
	}
}

/**
 * 공통버튼 순서 설정
 * @param {Array} data : 설정 순서 지정 (ex: ['ret','list'])
 * 						 ret(검색),list(목록),new(신규),del(삭제),save(저장),copy(복사),init(초기화),execute(실행),
 * 						 excelup(엑셀업로드),exceldown(엑셀다운),print(출력),user1(사용자버튼1)..user5(사용자버튼5)
 */
function setCommBtnSeq(list) {
	var v_ret = $('#cbtn_ret').clone();
	var v_list = $('#cbtn_list').clone();
	var v_new = $('#cbtn_new').clone();
	var v_del = $('#cbtn_del').clone();
	var v_save = $('#cbtn_save').clone();
	var v_copy = $('#cbtn_copy').clone();
	var v_init = $('#cbtn_init').clone();
	var v_exec = $('#cbtn_execute').clone();
	var v_cancel = $('#cbtn_cancel').clone();
	var v_print = $('#cbtn_print').clone();
	var v_excel = $('#cbtn_exceldown').clone();
	var v_excelup = $('#cbtn_excelup').clone();
	var v_user1 = $('#cbtn_user1').clone();
	var v_user2 = $('#cbtn_user2').clone();
	var v_user3 = $('#cbtn_user3').clone();
	var v_user4 = $('#cbtn_user4').clone();
	var v_user5 = $('#cbtn_user5').clone();

	for (var i=0, len=list.length; i<len; i++) {
		if (list[i] == 'ret') {
			$('#cbtn_ret').remove();
			$('#ctw_btns').append(v_ret).append(' ');
		} else if (list[i] == 'list') {
			$('#cbtn_list').remove();
			$('#ctw_btns').append(v_list).append(' ');
		} else if (list[i] == 'new') {
			$('#cbtn_new').remove();
			$('#ctw_btns').append(v_new).append(' ');
		} else if (list[i] == 'del') {
			$('#cbtn_del').remove();
			$('#ctw_btns').append(v_del).append(' ');
		} else if (list[i] == 'save') {
			$('#cbtn_save').remove();
			$('#ctw_btns').append(v_save).append(' ');
		} else if (list[i] == 'copy') {
			$('#cbtn_copy').remove();
			$('#ctw_btns').append(v_copy).append(' ');
		} else if (list[i] == 'init') {
			$('#cbtn_init').remove();
			$('#ctw_btns').append(v_init).append(' ');
		} else if (list[i] == 'execute') {
			$('#cbtn_execute').remove();
			$('#ctw_btns').append(v_exec).append(' ');
		} else if (list[i] == 'cancel') {
			$('#cbtn_cancel').remove();
			$('#ctw_btns').append(v_cancel).append(' ');
		} else if (list[i] == 'print') {
			$('#cbtn_print').remove();
			$('#ctw_btns').append(v_print).append(' ');
		} else if (list[i] == 'excelup') {
			$('#cbtn_excelup').remove();
			$('#ctw_btns').append(v_excelup).append(' ');
		} else if (list[i] == 'exceldown') {
			$('#cbtn_exceldown').remove();
			$('#ctw_btns').append(v_excel).append(' ');
		} else if (list[i] == 'user1') {
			$('#cbtn_user1').remove();
			$('#ctw_btns').append(v_user1).append(' ');
		} else if (list[i] == 'user2') {
			$('#cbtn_user2').remove();
			$('#ctw_btns').append(v_user2).append(' ');
		} else if (list[i] == 'user3') {
			$('#cbtn_user3').remove();
			$('#ctw_btns').append(v_user3).append(' ');
		} else if (list[i] == 'user4') {
			$('#cbtn_user4').remove();
			$('#ctw_btns').append(v_user4).append(' ');
		} else if (list[i] == 'user5') {
			$('#cbtn_user5').remove();
			$('#ctw_btns').append(v_user5).append(' ');
		}
	}
}

/**
 * 페이지 이동 처리
 * @param {String} url : 이동할 주소
 * @param {Array} arrParam : 파라미터 (배열)
 */
function gfn_pageMove(url, arrParam) {
	var form = $('<form></form>');
    form.attr('action', url);
    form.attr('method', 'get');
    form.appendTo('body');
    
    if (!cfn_isEmpty(arrParam)) {
    	if (typeof arrParam == 'object') {
    		if (cfn_isEmpty(arrParam.IDUR)) {
    			cfn_setIDUR('U');
    		}
    	}
    } else {
    	cfn_setIDUR('I');
    }

    /* 파라미터 저장 처리 */
    if (!cfn_isEmpty(arrParam)) {
    	gv_paramData = JSON.stringify(arrParam);
    	form.append('<input type="hidden" name="PARAMDATA" value="' + gv_paramData.replace(/\"/g, '||') + '">');
    }

    /* 검색조건 저장 처리 */
    if (!cfn_isEmpty(gv_searchData)) {
	    gv_searchData = JSON.stringify(gv_searchData);
		form.append('<input type="hidden" name="SEARCHDATA" value="' + gv_searchData.replace(/\"/g, '||') + '">');
    }

    form.append('<input type="hidden" name="IDUR" value="' + cfn_getIDUR() + '">');

    form.submit();
}

/**
 * 저장된 검색조건 자동 검색
 * @param {String} searchData : 검색조건 문자열
 */
function cfn_initSearch() {
	if (!cfn_isEmpty(gv_searchData)) {
		$.each(gv_searchData, function(k, v) {
			$('[name="' + k + '"]').val(v);
		});
		cfn_retrieve();
	}
}

/**
 * 화면 입력폼 상태 가져오기
 * @returns {String} I:신규상태, D:삭제상태, U:수정상태
 */
function cfn_getIDUR() {
	if (typeof ctObj === 'undefined') {
		return 'I';
	}
	return cfn_isEmpty(ctObj.IDUR) ? 'I' : ctObj.IDUR;
}

/**
 * 화면 입력폼 상태 설정
 * @param {String} IDUR : 상태코드 I:신규상태, D:삭제상태, U:수정상태
 */
function cfn_setIDUR(IDUR) {
	ctObj.IDUR = cfn_isEmpty(IDUR) ? 'I' : IDUR;
}

/**
 * 화면 선택된 탭 Index 가져오기
 * @param {String} tabId : 탭ID
 */
function cfn_getTabIdx(tabId) {
	var i;
	if ($('#' + tabId).length > 0)
		i = $('#' + tabId).tabs('option', 'active') + 1;
	return i;
}

/**
 * 화면 선택된 탭 Index 설정
 * @param {String} tabId : 탭ID
 * @param {Number} idx : 탭번호
 */
function cfn_setTabIdx(tabId, idx) {
	if ($('#' + tabId).length > 0) {
		$('#' + tabId).tabs('option', 'active', idx - 1);
		$('#' + tabId).tabs('refresh');
	}
}