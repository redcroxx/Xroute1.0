
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst" %>

<c:import url="/comm/contentTop.do" />

<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<ul class="sech_ul">
			<li class="sech_li required">
				<div>등록일자</div>
				<div>
					<input type="text" id="sToDate" class="cmc_date required" /> ~
					<input type="text" id="sFromDate" class="cmc_date required" />
				</div>
			</li>
			<li class="sech_li">
				<div>송장번호</div>
				<div>
					<input type="text" id="xrtInvcSno" class="cmc_code" style="width: 195px;">
				</div>
			</li>
			<li class="sech_li">
				<div>상태</div>
				<div>
					<select id="statusCd">
						<option value="">== 전체 ==</option>
						<option value="Y">처리완료</option>
						<option value="N">미처리</option>
					</select>
				</div>
			</li>
		</ul>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>창고</div>
				<div>
					<input type="text" id="sWhcd" class="cmc_code" />
					<input type="text" id="sWhnm" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li">
				<div>셀러</div>
				<div>
					<input type="text" id="sOrgCd" class="cmc_code" />
					<input type="text" id="sOrgNm" class="cmc_value"/>
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li">
				<div>메모 구분</div>
				<div>
					<select id="memoType">
						<option value="">== 선택 ==</option>
						<option value="shipping">배송관련문의</option>
						<option value="payment">결제관련문의</option>
						<option value="others">기타문의</option>
					</select>
				</div>
			</li>
		</ul>
	</form>
</div>
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">메모리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
</div>
<script type="text/javascript">

// 초기 로드
$(function() {
	// 1. 화면레이아웃 지정 (리사이징)
	initLayout();
	// 2.
	cfn_init();
	// 3. 그리드 초기화
	grid1_Load();
	/* 창고 */
	pfn_codeval({
		url: "/alexcloud/popup/popP004/view.do"
		, codeid: "sWhcd"
		, inparam: {sCompCd:"sCompCd", sWhcd:"sWhcd,sWhnm"}
		, outparam: {WHCD:"sWhcd", NAME:"sWhnm"}
	});
	/* 셀러 */
	pfn_codeval({
		url: "/alexcloud/popup/popP002/view.do"
		, codeid: "sOrgCd"
		, inparam: {sCompCd:"sCompCd", sOrgCd:"sOrgCd,sOrgNm"}
		, outparam: {ORGCD:"sOrgCd", NAME:"sOrgNm"}
	});
});

function grid1_Load() {
	var gid = "grid1";
	var btn = "/images/btn_reply.png";
	var columns = [
		{name:"statusCd", header:{text:"상태"}, styles:{textAlignment:"center"}, dynamicStyles:[{criteria:"value = 'Y'",styles:"background=#00FF00"}, {criteria:"value = 'N'",styles:"background=#FF0000"}], width:40}
		//, {name:"new", header:{text:"신규 답글"}, button:"image", alwaysShowButton:true, imageButtons:{width:50, images:[{name:"신규 답글", up:btn, hover:btn, down:btn}]}, styles:{textAlignment:"center"}, width:80}
		, {name:"orgcd", header:{text:"셀러코드"}, styles:{textAlignment:"center"}, width:80, show:false}
		, {name:"orderMemoSeq", header:{text:"메모 번호"}, styles:{textAlignment:"center"}, width:80, show:false}
		, {name:"xrtInvcSno", header:{text:"송장번호"}, styles:{textAlignment:"center"}, width:150}
		, {name:"memoType", header:{text:"메모타입"}, styles:{textAlignment:"center"}, width:100}
		, {name:"memoAuthority", header:{text:"메모권한"}, styles:{textAlignment:"center"}, width:100, show:false}
		, {name:"contents", header:{text:"내용"}, styles:{textAlignment:"center"}, width:450}
		, {name:"addusercd", header:{text:"작성자"}, styles:{textAlignment:"center"}, width:100}
		, {name:"replyCount", header:{text:"답글"}, styles:{textAlignment:"center"}, width:100}
		, {name:"adddatetime", header:{text:"작성일시"}, styles:{textAlignment:"center"}, width:150}
		, {name:"updusercd", header:{text:"수정자"}, styles:{textAlignment:"center"}, width:100}
		, {name:"upddatetime", header:{text:"수정일시"}, styles:{textAlignment:"center"}, width:150}
		, {name:"shippingStatus", header:{text:"주문배송상태"}, styles:{textAlignment:"center"}, width:140}
		, {name:"eNation", header:{text:"배송국가"}, styles:{textAlignment:"center"}, width:100}
	];
	//그리드 생성 (realgrid 써서)
	$("#"+ gid).gfn_createGrid(columns, {
		footerflg: false
		, cmenuGroupflg: false
		, cmenuColChangeflg: false
		, cmenuColSaveflg: false
		, cmenuColInitflg: false
	});
	
	//그리드설정 및 이벤트처리
	$("#"+ gid).gfn_setGridEvent(
		function(gridView, dataProvider) {
			gridView.onDataCellClicked  = function (grid, data) {
				var xrtInvcSno = grid.getValue(data.dataRow, "xrtInvcSno");
				var orderMemoSeq = grid.getValue(data.dataRow, "orderMemoSeq");
				//openPopUp(jsonObj);
				openPopup(xrtInvcSno, orderMemoSeq);
			};
		}
	);
}

function reset_Search() {
	$("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
	$("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
	$("#sWhcd").val("<c:out value='${sessionScope.loginVO.whcd}' />");
	$("#sWhnm").val("<c:out value='${sessionScope.loginVO.whnm}' />");
	$("#sOrgCd").val("<c:out value='${sessionScope.loginVO.orgcd}' />");
	$("#sOrgNm").val("<c:out value='${sessionScope.loginVO.orgnm}' />");

	var usergroup = "<c:out value='${sessionScope.loginVO.usergroup}' />";
	var sellerGroup = "<c:out value='${SELLER_ADMIN}' />";
	var propFalse = {"readonly": false, "disabled": false};
	var propTrue = {"readonly": true, "disabled": true};

	if (usergroup > sellerGroup) {
		$("#sWhcd").removeClass("disabled").prop(propFalse);
		$("#sWhnm").removeClass("disabled").prop(propFalse);
		$("#sWhnm").next().removeClass("disabled").prop(propFalse);
		
		$("#sOrgCd").removeClass("disabled").prop(propFalse);
		$("#sOrgNm").removeClass("disabled").prop(propFalse);
		$("#sOrgNm").next().removeClass("disabled").prop(propFalse);
	} else if (usergroup <= sellerGroup) {
		$("#sWhcd").addClass("disabled").prop(propTrue);
		$("#sWhnm").addClass("disabled").prop(propTrue);
		$("#sOrgNm").next().addClass("disabled").prop(propTrue);
		
		$("#sOrgCd").addClass("disabled").prop(propTrue);
		$("#sOrgNm").addClass("disabled").prop(propTrue);
		$("#sOrgNm").next().addClass("disabled").prop(propTrue);
	}
}
function openPopup(xrtInvcSno, orderMemoSeq) {
    var width = "1000";
    var height = "690";
    var left = (window.screen.width / 2) - (width / 2);
    var top = (window.screen.height / 2) - (height / 2);
    var url = "/fulfillment/order/orderMemoList/infoView.do?xrtInvcSno=" + xrtInvcSno + "&orderMemoSeq=" + orderMemoSeq;
    var option = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top + ", resizable=no, scrollbars=no, menubar=no, location=no, status=no";
    var openWin = window.open(url, "로지포커스", option);
}

//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == "sid_getSearch") {
		
		for (var i = 0; i < data.resultList.length; i++) {
			if (data.resultList[i].memoType == "shipping") {
				data.resultList[i].memoType = "배송관련문의";
			}
			if (data.resultList[i].memoType == "payment") {
				data.resultList[i].memoType = "결제관련문의";
			}
			if (data.resultList[i].memoType == "others") {
				data.resultList[i].memoType = "기타문의";
			}
			if (data.resultList[i].memoAuthority == "total") {
				data.resultList[i].memoAuthority = "전체";
			}
			if (data.resultList[i].memoAuthority == "admin") {
				data.resultList[i].memoAuthority = "관리자";
			}
		}
		$("#grid1").gfn_setDataList(data.resultList);
		$("#grid1").gfn_focusPK();
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	if(cfn_isFormRequireData("frmSearch") == false) {
		return;
	}
	
	$("#grid1").gridView().cancel();
	var sid = "sid_getSearch";
	var url = "/fulfillment/order/orderMemoList/getSearch.do";
	var sendData = cfn_getFormData("frmSearch");
	gfn_sendData(sid, url, sendData, true);
}

//공통버튼 - 초기화
function cfn_init() {
	reset_Search();
}
</script>

<c:import url="/comm/contentBottom.do" />