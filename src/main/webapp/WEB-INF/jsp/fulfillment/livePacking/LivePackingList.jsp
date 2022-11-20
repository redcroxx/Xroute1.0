<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst" %>

<c:import url="/comm/contentTop.do" />

<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="sCompCd" class="cmc_txt" />
		<ul class="sech_ul">
			<li class="sech_li">
				<div>업로드 기간</div>
				<div class="widpx400">
					<input type="text" id="sToDate" class="cmc_date periods" /> ~ 
					<input type="text" id="sFromDate" class="cmc_date periode" />
				</div>
			</li>
			<li class="sech_li">
				<div>셀러</div>
				<div>
					<input type="text" id="sOrgCd" class="cmc_code required" />
					<input type="text" id="sOrgNm" class="cmc_value"/>
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li">
                <div>송장번호</div>
                <div>
                    <input type="text" id="sKeyword" class="cmc_code" style="width : 150px;" />
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
//초기 로드
$(function() {
	// 1. 화면레이아웃 지정 (리사이징)
	initLayout();
	// 2.
	cfn_init();
	// 3. 그리드 초기화
	grid1_Load();
	// 4. 셀러 팝업 설정
	pfn_codeval({
		url: "/alexcloud/popup/popP002/view.do"
		, codeid: "sOrgCd"
		, inparam: {S_COMPCD:"S_COMPCD", S_ORGCD:"S_ORGCD"}
		, outparam: {ORGCD:"sOrgCd", NAME:"sOrgNm"}
	});
});

function grid1_Load() {
	var gid = "grid1";
	var columns = [
		{name:"xrtInvcSno", header:{text:"송장번호"}, styles:{textAlignment:"center"}, width:150, editable:false}
		, {name:"adddatetime", header:{text:"작성일시"}, styles:{textAlignment:"center"}, width:150, editable:false}
		, {name:"s3Url", header:{text:"s3Url"}, show: false}
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
				var s3Url = grid.getValue(data.dataRow, "s3Url");
				var jsonObj = {};
				jsonObj.s3Url = s3Url;
				openPopUp(jsonObj);
			};
		}
	);
}

function reset_Search() {
	$("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
	$("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
	
	var compcd = "<c:out value='${sessionScope.loginVO.compcd}' />";
	var usergroup = "<c:out value='${sessionScope.loginVO.usergroup}' />";
	var sellerGroup = "<c:out value='${constMap.SELLER_ADMIN}' />"||"40";
	
	if (usergroup > sellerGroup) {
		$("#sOrgCd").val("<c:out value='${sessionScope.loginVO.orgcd}' />");
		$("#sOrgNm").val("<c:out value='${sessionScope.loginVO.orgnm}' />");
 		$(".cmc_cdsearch").removeClass("disabled").prop({"readonly":false, "disabled":false});
 		$("#sOrgCd").removeClass("disabled").prop({"readonly":false, "disabled":false});
		$("#sOrgNm").removeClass("disabled").prop({"readonly":false, "disabled":false});
		$("#sOrgNm").next().removeClass("disabled").prop({"readonly":false, "disabled":false});
	} else if (usergroup <= sellerGroup) {
		$("#sOrgCd").val("<c:out value='${sessionScope.loginVO.orgcd}' />");
		$("#sOrgNm").val("<c:out value='${sessionScope.loginVO.orgnm}' />");
		$(".cmc_cdsearch").addClass("disabled").prop({"readonly":true, "disabled":true});
		$("#sOrgCd").addClass("disabled").prop({"readonly":true, "disabled":true});
		$("#sOrgNm").addClass("disabled").prop({"readonly":true, "disabled":true});
		$("#sOrgNm").next().addClass("disabled").prop({"readonly":true, "disabled":true});
	}
}

//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == "sid_getSearch") {
		$("#grid1").gfn_setDataList(data.resultList);
		$("#grid1").gfn_focusPK();
	}
}

function openPopUp(jsonObj) {
	var url = "/fulfillment/livePackingListDtl/view.do";
	var pid = "livePackingListDtl";
	
	pfn_popupOpen({
		url: url
		, pid: pid
		, params: jsonObj
		, returnFn: function(data, type) {
			if (type === 'OK') {
				cfn_retrieve();
			}
		}
	});
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	$("#grid1").gridView().cancel();
	var sid = "sid_getSearch";
	var url = "/fulfillment/livePackingList/getSearch.do";
	var sendData = {};
	sendData.sToDate = $("#sToDate").val();
	sendData.sFromDate = $("#sFromDate").val();
	sendData.sKeyword = $("#sKeyword").val();
	sendData.sOrgCd = $("#sOrgCd").val();
	
	gfn_sendData(sid, url, sendData, true);
}


//공통버튼 - 초기화
function cfn_init() {
	reset_Search();
}
</script>

<c:import url="/comm/contentBottom.do" />