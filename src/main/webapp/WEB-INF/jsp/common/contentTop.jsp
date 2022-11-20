<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>XROUTE</title>
<c:import url="/comm/contJsCsImpt.do" />

<script type="text/javascript">
/* 전역 객체 */
var gv_searchData = {}, gv_paramData = {}, ctObj = {IDUR:'I'}, gv_compItemInfo = {};

$(function() {
	//공통버튼 권한 가져오기
	//회사별 상품 로트속성 및 지정속성정보 가져오기 추가 2017-06-28
	var url = '';
	var menul1key = ''	
	var menul2key = ''	
	var appkey = ''
	
	//고정탭 구분을 위한 체크 값
	var check = '<c:out value="${param.fixedTab}" />'
	
	//고정탭이 아닐 경우
	if (cfn_isEmpty(check)) {
		url = '/comm/commonBtnInfo.do';
		menul1key = parent.$('#tabs').find('.li-add.ui-tabs-active').attr('menul1key');
		menul2key = parent.$('#tabs').find('.li-add.ui-tabs-active').attr('menul2key');
		appkey = parent.$('#tabs').find('.li-add.ui-tabs-active').attr('appkey');	
	}else{ // 고정탭일 경우(메인,주문배송조회)
		url = '/comm/commonBtnInfo2.do';
		menul1key = parent.$('#tabs').find('.li-fixed').attr('menul1key');
		menul2key = parent.$('#tabs').find('.li-fixed').attr('menul2key');
		appkey = parent.$('#tabs').find('.li-fixed').attr('appkey');
		
	}

	var sendData = {'menul1key':menul1key,'menul2key':menul2key,'appkey':appkey};	
	
	gfn_ajax(url, false, sendData, function(data, xhr) {
		var btnData = data.resultCommBtnInfo;
		
		if (btnData.length < 1) {
			return false;
		}
		
		if (btnData[0].BTNSEARCH == '1')
			$('#cbtn_ret').css('display','inline-block');
		if (btnData[0].BTNLIST == '1')
			$('#cbtn_list').css('display','inline-block');
		if (btnData[0].BTNNEW == '1')
			$('#cbtn_new').css('display','inline-block');
		if (btnData[0].BTNDELETE == '1')
			$('#cbtn_del').css('display','inline-block');
		if (btnData[0].BTNSAVE == '1')
			$('#cbtn_save').css('display','inline-block');
		if (btnData[0].BTNCOPY == '1')
			$('#cbtn_copy').css('display','inline-block');
		if (btnData[0].BTNINIT == '1')
			$('#cbtn_init').css('display','inline-block');
		if (btnData[0].BTNEXECUTE == '1')
			$('#cbtn_execute').css('display','inline-block');
		if (btnData[0].BTNCANCEL == '1')
			$('#cbtn_cancel').css('display','inline-block');
		if (btnData[0].BTNPRINT == '1')
			$('#cbtn_print').css('display','inline-block');
		if (btnData[0].BTNEXCELDOWN == '1')
			$('#cbtn_exceldown').css('display','inline-block');
		if (btnData[0].BTNEXCELUP == '1')
			$('#cbtn_excelup').css('display','inline-block');
		if (btnData[0].BTNUSER1 == '1')
			$('#cbtn_user1').css('display','inline-block');
		if (btnData[0].BTNUSER2 == '1')
			$('#cbtn_user2').css('display','inline-block');
		if (btnData[0].BTNUSER3 == '1')
			$('#cbtn_user3').css('display','inline-block');
		if (btnData[0].BTNUSER4 == '1')
			$('#cbtn_user4').css('display','inline-block');
		if (btnData[0].BTNUSER5 == '1')
			$('#cbtn_user5').css('display','inline-block');
		
		if (btnData[0].AUTHSEARCH == 'O') {
			$('.authorg').attr('disabled','disabled').attr('tabindex','-1').addClass('disabled');
		} else if (btnData[0].AUTHSEARCH == 'D') {
			$('.authorg').attr('disabled','disabled').attr('tabindex','-1').addClass('disabled');
			$('.authdept').attr('disabled','disabled').attr('tabindex','-1').addClass('disabled');
		} else if (btnData[0].AUTHSEARCH == 'U') {
			$('.authorg').attr('disabled','disabled').attr('tabindex','-1').addClass('disabled');
			$('.authdept').attr('disabled','disabled').attr('tabindex','-1').addClass('disabled');
			$('.authuser').attr('disabled','disabled').attr('tabindex','-1').addClass('disabled');
		}
		
		if (btnData[0].AUTHUPD == 'N') {
			authupd = 'N'
			$('.authupd').hide();
		}
		
		authsearch = btnData[0].AUTHSEARCH;
		
		if (cfn_isEmpty(check)) {
			$('#cbtn_l1title').text(btnData[0].L1TITLE);
			$('#cbtn_l2title').text(' > ' + btnData[0].L2TITLE);
			$('#cbtn_l3title').text(' > ' + btnData[0].L3TITLE);
			$('#cbtn_appkeytitle').text(' [' + btnData[0].APPKEY + ']');
		}else if(check == 1){
			$('#cbtn_l3title').text(' 주문배송조회 ');
			$('#cbtn_appkeytitle').text(' [SHIPPINGLIST]');
		}else if(check == 2){
			$('#cbtn_l3title').text(' 입고리스트 ');
			$('#cbtn_appkeytitle').text(' [STOCKLIST]');
		}else if(check == 3){
			$('#cbtn_l3title').text(' 입고스캔 / 송장출력 ');
			$('#cbtn_appkeytitle').text(' [STOCKINSERT]');
		}else if (check == 4) {
		    $('#cbtn_l3title').text(' 애터미 입고 등록 ');
            $('#cbtn_appkeytitle').text(' [ATOMYSTOCKINSERT]');
        }else if (check == 5) {
            $('#cbtn_l3title').text(' 애터미 입고 목록 ');
            $('#cbtn_appkeytitle').text(' [ATOMYSTOCKLIST]');
        }
		
		// 회사별 상품속성 정보
// 		var compItemData = data.resultCompItemInfo;
// 		if(compItemData.length > 0){
// 			gv_compItemInfo = compItemData[0];
// 		}
		//회사별 상품정보 제어
		//cfn_getCompItemInfo();
	});
	
	/* 검색조건 저장 처리 */
	gv_searchData = '${param.SEARCHDATA}';
	gv_searchData = !cfn_isEmpty(gv_searchData) ? JSON.parse(cfn_replaceAll(gv_searchData, '||', '"')) : {};
	
	/* 파라미터 저장 처리 */
	gv_paramData = '${param.PARAMDATA}';
	gv_paramData = !cfn_isEmpty(gv_paramData) ? JSON.parse(cfn_replaceAll(gv_paramData, '||', '"')) : {};
	
	//입력폼상태 저장 처리
	cfn_setIDUR('${param.IDUR}');
});
</script>
</head>
<body class="contbody">
<!-------- 공통버튼 --------->
<div id="commonButton">
	<div id="ctw_windowpath">
		<span id="cbtn_l1title"></span><span id="cbtn_l2title"></span><span id="cbtn_l3title"></span><span id="cbtn_appkeytitle"></span>
	</div>
	<div id="ctw_btns">
		<input type="button" id="cbtn_ret" class="commonBtn" value="검색" onclick="gfn_cmnBtn_onclick('RET');" />
		<input type="button" id="cbtn_list" class="commonBtn" value="목록" onclick="gfn_cmnBtn_onclick('LIST');" />
		<input type="button" id="cbtn_new" class="commonBtn" value="신규" onclick="gfn_cmnBtn_onclick('NEW');" />
		<input type="button" id="cbtn_del" class="commonBtn" value="삭제" onclick="gfn_cmnBtn_onclick('DEL');" />
		<input type="button" id="cbtn_save" class="commonBtn" value="저장" onclick="gfn_cmnBtn_onclick('SAVE');" />
		<input type="button" id="cbtn_copy" class="commonBtn" value="복사" onclick="gfn_cmnBtn_onclick('COPY');" />
		<input type="button" id="cbtn_init" class="commonBtn" value="초기화" onclick="gfn_cmnBtn_onclick('INIT');" />
		<input type="button" id="cbtn_execute" class="commonBtn" value="실행" onclick="gfn_cmnBtn_onclick('EXECUTE');" />
		<input type="button" id="cbtn_cancel" class="commonBtn" value="취소" onclick="gfn_cmnBtn_onclick('CANCEL');" />
		<input type="button" id="cbtn_excelup" class="commonBtn" value="엑셀업로드" onclick="gfn_cmnBtn_onclick('EXCELUP');" />
		<input type="button" id="cbtn_exceldown" class="commonBtn" value="엑셀다운" onclick="gfn_cmnBtn_onclick('EXCELDOWN');" />
		<input type="button" id="cbtn_print" class="commonBtn" value="인쇄" onclick="gfn_cmnBtn_onclick('PRINT');" />
		<input type="button" id="cbtn_user1" class="commonBtn" value="user1" onclick="gfn_cmnBtn_onclick('USER1');" />
		<input type="button" id="cbtn_user2" class="commonBtn" value="user2" onclick="gfn_cmnBtn_onclick('USER2');" />
		<input type="button" id="cbtn_user3" class="commonBtn" value="user3" onclick="gfn_cmnBtn_onclick('USER3');" />
		<input type="button" id="cbtn_user4" class="commonBtn" value="user4" onclick="gfn_cmnBtn_onclick('USER4');" />
		<input type="button" id="cbtn_user5" class="commonBtn" value="user5" onclick="gfn_cmnBtn_onclick('USER5');" />
	</div>
</div>

<!-------- 화면 영역 --------->
<div id="ct_wrap">