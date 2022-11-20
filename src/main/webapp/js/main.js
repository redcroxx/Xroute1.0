/**
 * 메인화면 공통 js
 * @author 2017-07-05 KaiKim
 */
var tabs, loginObj = {}, printObj = {};

$(function() {
	/* 탭 화면 적용 */
	tabs = $('#tabs').tabs();
	/* 탭 화면 제거 */
	tabs.on('click', 'span.ui-icon-close', function() {
		var index = parseInt(tabIndex);
		var panelId = $(this).closest('li').remove().attr('aria-controls');

		$('#' + panelId).remove();
		tabs.tabs('refresh');
		tabs.tabs('option', 'active', tabIndex);

		tabIndex--;
	});
	/* 탭 화면 모두 제거 */
	tabs.on('click', '#tabsAllClose', function() {
		if(!confirm("전체닫기 하시겠습니까?")){
			return false;
		}
		$('#tabs').find('.li-add').not('.li-fixed').remove();
		$('#tabs').find('.tabs-content').not('.tabs-fixed').remove();

		tabIndex = 2;
		tabs.tabs('refresh');
		tabs.tabs('option', 'active', tabIndex);
	});

	tabs.on('keyup', function(event) {
		if (event.altKey && event.keyCode === $.ui.keyCode.BACKSPACE) {
			var panelId = tabs.find('.ui-tabs-active').remove().attr('aria-controls');
			$('#' + panelId).remove();
			tabs.tabs('refresh');
		}
	});

	setLoginInfo();
	setPrintInfo();

	//좌측메뉴 아코디언
	/*
	$('#accordion').accordion({
		heightStyle: 'content',
		collapsible:false,
        active:false
	});
	$('#accordion').accordion('refresh');

	var icons = $('#accordion').accordion('option', 'icons');
    $('.acod_open').click(function () {
        $('.ui-accordion-header').removeClass('ui-corner-all').addClass('ui-accordion-header-active ui-state-active ui-corner-top').attr({
            'aria-selected': 'true',
            'tabindex': '0'
        });
        $('.ui-accordion-header-icon').removeClass(icons.header).addClass(icons.headerSelected);
        $('.ui-accordion-content').addClass('ui-accordion-content-active').attr({
            'aria-expanded': 'true',
            'aria-hidden': 'false'
        }).show();
        $(this).attr('disabled','disabled');
        $('.acod_close').removeAttr('disabled');
    });
    $('.acod_close').click(function () {
        $('.ui-accordion-header').removeClass('ui-accordion-header-active ui-state-active ui-corner-top').addClass('ui-corner-all').attr({
            'aria-selected': 'false',
            'tabindex': '-1'
        });
        $('.ui-accordion-header-icon').removeClass(icons.headerSelected).addClass(icons.header);
        $('.ui-accordion-content').removeClass('ui-accordion-content-active').attr({
            'aria-expanded': 'false',
            'aria-hidden': 'true'
        }).hide();
        $(this).attr('disabled','disabled');
        $('.acod_open').removeAttr('disabled');
    });
    $('.ui-accordion-header').click(function () {
        $('.acod_open').removeAttr('disabled');
        $('.acod_close').removeAttr('disabled');

    });
    */
});

/**
 * 로그인정보 전역변수 저장
 */
function setLoginInfo() {
	var url = '/comm/getLoginInfo.do';

	gfn_ajax(url, false, {}, function(data, xhr) {
		var resultData = data.loginVO;
		loginObj = {};
		loginObj.USERCD = resultData.usercd
		loginObj.USERNM = resultData.name
		loginObj.COMPCD = resultData.compcd
		loginObj.COMPNM = resultData.compnm
		loginObj.ORGCD = resultData.orgcd
		loginObj.ORGNM = resultData.orgnm
		loginObj.CUSTCD = resultData.custcd
		loginObj.CUSTNM = resultData.custnm
		loginObj.DEPTCD = resultData.deptcd
		loginObj.DEPTNM = resultData.deptnm
		loginObj.WHCD = resultData.whcd
		loginObj.WHNM = resultData.whnm
		//20191128 jy.hong 2019년12까지 추가개발
		loginObj.SELLERWHCD = resultData.sellerWhcd
		//20200210 jy.hong 결제타입구분 추가
		loginObj.PAYMENTTYPE = resultData.paymentType
		loginObj.LOGINCNT = resultData.logincnt
		loginObj.LASTLOGIN = resultData.lastlogin
		loginObj.USERGROUP = resultData.usergroup
		loginObj.USERGROUPNM = resultData.usergroupnm
		loginObj.PWDCHGDATE = resultData.pwdchgdate
		loginObj.PWDCHGSCDATE = resultData.pwdchgscdate
		loginObj.ISLOCK = resultData.islock
	});
}

/**
 * 프린터정보 전역변수 저장
 */
function setPrintInfo() {
	var url = '/comm/getPrintInfo.do';
	
	gfn_ajax(url, false, {}, function(data, xhr) {
		var resultData = data.printVO;
		printObj = {};
		printObj.PRINT1 = resultData.print1
		printObj.PRINT2 = resultData.print2
		printObj.PRINT3 = resultData.print3
		printObj.PRINT4 = resultData.print4
		
	});
	
	
}