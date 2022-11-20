<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/comm/contentTop.do"/>
<div id="ct_sech_wrap">
	<form id="formSearch" action="#" onsubmit="return false">
		<ul class="sech_ul">
			<li class="sech_li" style="width:460px;">
				<div>기간</div>
				<div style="width: 350px;">
					<select id="sPeriodType" style="width: 100px;">
						<c:forEach var="i" items="${periodType}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
					<input type="text" id="sToDate" class="cmc_date periods required" /> ~ 
					<input type="text" id="sFromDate" class="cmc_date periode required" />
				</div>
			</li> 
			<li class="sech_li" style="width:460px;">
				<div>송장번호</div>
				<div>
					<input type="text" id="sXrtInvcSno" class="cmc_code" style="width: 140px;"/>
				</div>
			</li>
			<li class="sech_li" style="width:460px;">
				<div>결제 타입</div>
				<div>
					<select id="sPaymentType" style="width: 100px">
						<option selected="selected" value="">--전체--</option>
						<c:forEach var="p" items="${paymentType}">
							<option value="${p.code}">${p.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
		</ul>
		<ul class="sech_ul">
			<li class="sech_li" style="width: 460px;">
                <div>창고</div>
                <div>
                    <input type="text" id="sWhcd" class="cmc_code disabled" disabled="disabled">
                    <input type="text" id="sWhnm" class="cmc_value" onchange="inputClear('sWhcd')">
                    <button type="button" class="cmc_cdsearch" onclick="openLayerPopup('sWhcd')"></button>
                </div>
            </li>
            <li class="sech_li" style="width: 450px;">
                <div>셀러</div>
                <div>
                    <input type="text" id="sOrgCd" class="cmc_code disabled" disabled="disabled">
                    <input type="text" id="sOrgNm" class="cmc_value" onchange="inputClear('sOrgCd')">
                    <button type="button" class="cmc_cdsearch" onclick="openLayerPopup('sOrgCd')"></button>
                </div>
            </li>
			<li class="sech_li" style="width:460px;">
				<div>상태</div>
				<div>
					<select id="sStatusCd" style="width: 100px">
						<option selected="selected" value="">-- 전체 --</option>
                            <option value="10">주문등록</option>
                            <option value="11">발송대기</option>
                            <option value="12">발송완료</option>
                            <option value="20">입금대기</option>
                            <option value="21">결제완료</option>
                            <option value="22">결제대기</option>
                            <option value="23">결제실패</option>
                            <option value="30">입고완료</option>
                            <option value="31">창고보관</option>
                            <option value="32">출고대기</option>
                            <option value="33">검수완료</option>
                            <option value="34">검수취소</option>
                            <option value="40">출고완료</option>
                            <option value="50">공항출발(예정)</option>
                            <option value="51">공항출발(완료)</option>
                            <option value="52">해외공항도착(예정)</option>
                            <option value="53">해외공항도착(완료)</option>
                            <option value="54">통관대기</option>
                            <option value="55">통관완료</option>
                            <option value="56">배송시작</option>
                            <option value="57">배송중</option>
                            <option value="60">배송완료</option>
                            <option value="80">API오류</option>
                            <option value="98">입금취소</option>
                            <option value="99">주문취소</option>
					</select>
				</div>
			</li>
		</ul>
	</form>
</div>
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">주문리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid"></div>
</div>
<c:import url="/comm/contentBottom.do"/>
<script type="text/javascript">
$(function() {
	initLayout();
	cfn_init();
	grid_load();

	// 창고 팝업.
	pfn_codeval({
		url: "/alexcloud/popup/popP004/view.do"
		, codeid: "sWhcd"
		, inparam: {sCompCd:"sCompCd", sWhcd:"sWhcd,sWhnm"}
		, outparam: {WHCD:"sWhcd", NAME:"sWhnm"}
	});
	
	pfn_codeval({
		url: "/alexcloud/popup/popP002/view.do"
		, codeid: "sOrgCd"
		, inparam: {S_COMPCD:"S_COMPCD", S_ORGCD:"S_ORGCD"}
		, outparam: {ORGCD:"sOrgCd", NAME:"sOrgNm"}
	});
});

function grid_load() {
	var gid = "grid";
	var columns = [
		{name:"orderNo1", header:{text:"주문번호 1"}, styles:{textAlignment:"center"}, width:200},
		{name:"orderNo2", header:{text:"주문번호 2"}, styles:{textAlignment:"center"}, width:100},
		{name:"shippingType", header:{text:"배송타입"}, styles:{textAlignment:"center"}, width:100},
		{name:"senderName", header:{text:"발송인 이름"}, styles:{textAlignment:"center"}, width:150},
		{name:"senderAddress", header:{text:"발송인 주소"}, styles:{textAlignment:"center"}, width:100},
		{name:"senderPhoneno", header:{text:"발송인 전화번호"}, styles:{textAlignment:"center"}, width:100},
		{name:"consigneeName", header:{text:"수취인 이름"}, styles:{textAlignment:"center"}, width:200},
		{name:"yomigana", header:{text:"수취인 이름(YOMIGANA)"}, styles:{textAlignment:"center"}, width:200},
		{name:"consigneeAddress", header:{text:"수취인 주소"}, styles:{textAlignment:"center"}, width:350},
		{name:"consigneePostalcode", header:{text:"수취인 우편번호"}, styles:{textAlignment:"center"}, width:150},
		{name:"consigneePhoneno", header:{text:"수취인 전화번호"}, styles:{textAlignment:"center"}, width:200},
		{name:"consigneeEmailId", header:{text:"수취인 이메일"}, styles:{textAlignment:"center"}, width:200},
		{name:"deliveryDate", header:{text:"배송요청일자"}, styles:{textAlignment:"center", "datetimeFormat":"yyyy-MM-dd"}, width:150, editor:{type:"date","mask": {"editMask":"9999-99-99", "placeHolder":"yyyy-MM-dd", "includedFormat":true}, "datetimeFormat":"yyyy-MM-dd"}, editable:true},
		{name:"deliveryTime", header:{text:"배송요청시간"}, styles:{textAlignment:"center", "datetimeFormat":"hh:mm:ss"}, width:100, editor:{type:"time","mask": {"editMask":"99:99:99", "placeHolder":"hh:mm:ss", "includedFormat":true}, "datetimeFormat":"hh:mm:ss"}, editable:true},
		{name:"boxCount", header:{text:"박스갯수"}, styles:{textAlignment:"center"}, width:50},
		{name:"weight", header:{text:"전체무게"}, styles:{textAlignment:"center"}, width:100},
		{name:"codAmount", header:{text:"다이비끼 금액"}, styles:{textAlignment:"center"}, width:100},
		{name:"width", header:{text:"가로"}, styles:{textAlignment:"center"}, width:100},
		{name:"length", header:{text:"세로"}, styles:{textAlignment:"center"}, width:100},
		{name:"height", header:{text:"높이"}, styles:{textAlignment:"center"}, width:100},
		{name:"uploadDate", header:{text:"업로드 날짜"}, styles:{textAlignment:"center", "datetimeFormat":"yyyy-MM-dd"}, width:150, editor:{type:"date","mask": {"editMask":"9999-99-99", "placeHolder":"yyyy-MM-dd", "includedFormat":true}, "datetimeFormat":"yyyy-MM-dd"}, editable:true},
		{name:"userData", header:{text:"사용자 데이터"}, styles:{textAlignment:"center"}, width:100},
		{name:"currencyUnit", header:{text:"통화 단위"}, styles:{textAlignment:"center"}, width:100},
		{name:"itemCode", header:{text:"상품코드"}, styles:{textAlignment:"center"}, width:150},
		{name:"itemName", header:{text:"상품명"}, styles:{textAlignment:"center"}, width:300},
		{name:"material", header:{text:"재질"}, styles:{textAlignment:"center"}, width:100},
		{name:"itemAmount", header:{text:"개수"}, styles:{textAlignment:"center"}, width:100},
		{name:"unitPrice", header:{text:"단가"}, styles:{textAlignment:"center"}, width:100},
		{name:"itemOrigin", header:{text:"원산지"}, styles:{textAlignment:"center"}, width:100},
		{name:"purchaseUrl", header:{text:"구매 URL"}, styles:{textAlignment:"center"}, width:200, editable:true},
		{name:"salesSite", header:{text:"판매 Site"}, styles:{textAlignment:"center"}, width:200},
		{name:"productOrderNo", header:{text:"주문번호"}, styles:{textAlignment:"center"}, width:200}
	];
	$("#"+ gid).gfn_createGrid(columns, {
	    indicator: false
		, footerflg: false
		, cmenuGroupflg: false
		, cmenuColChangeflg: false
		, cmenuColSaveflg: false
		, cmenuColInitflg: false
	});
	
	$("#"+ gid).gfn_setGridEvent(
		function(gridView, dataProvider) {
			gridView.setFixedOptions({colCount:1, resizable:true, colBarWidth:1});
		}
	);
}

function gfn_callback(sid, data) {
	if (sid == "getSearch") {
		$("#grid").gfn_setDataList(data.resultList);
	}
}

function cfn_retrieve() {
	gv_searchData = cfn_getFormData("formSearch");
	var sid = "getSearch";
	var url = "/fulfillment/order/kokusai/getSearch.do";
	var sendData = gv_searchData;
	gfn_sendData(sid, url, sendData, true);
}

function cfn_init() {
	$("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
	$("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
	
	// 초기화.
	$("#sWhNm").val(""); 
	$("#sWhcd").val(""); 
	$("#sOrgNm").val(""); 
	$("#sOrgCd").val(""); 
	$("#sXrtInvcSno").val("");
	$("#sPaymentType").val("");
	$("#sStatusCd").val("");
}
//레이어 팝업 호출 공통
function openLayerPopup(elemId, jsonObj) {
    var url = "";
    var pid = "";
    var params = {
        S_COMPCD : ($("#S_COMPCD").val() || ""),
        gridData : []
    };

    if (elemId == "sWhcd") {
        url = "/alexcloud/popup/popP004/view.do";
        pid = "popP004";
        params.S_WHCD = $("#sWhnm").val() || "";
    } else if (elemId == "sOrgCd") {
        url = "/alexcloud/popup/popP002/view.do";
        pid = "popP002";
        params.S_ORGCD = $("#sOrgNm").val() || "";
    } else {
        cfn_msg("ERROR", "오류가 발생 하였습니다..");
        return;
    }
    
    pfn_popupOpen({
        url : url,
        pid : pid,
        params : params,
        returnFn : function(data, type) {
            if (type == "OK") {
                if (elemId == "sWhcd") {
                    $("#sWhcd").val(data[0].WHCD || "");
                    $("#sWhnm").val(data[0].NAME || "");
                } else if (elemId == "sOrgCd") {
                    $("#sOrgCd").val(data[0].ORGCD || "");
                    $("#sOrgNm").val(data[0].NAME || "");
                }
            }
        }
    });
}

//저장.
function cfn_save() {
    $("#grid").gridView().commit(true);
    var $grid = $("#grid");
    var dataList = $grid.gfn_getDataList(false);
    console.log(dataList);
    
    if (dataList.length < 1) {
        cfn_msg("WARNING", "변경된 항목이 없습니다.");
        return false;
    }
    
    // 변경 행 추출.
    var state = $grid.dataProvider().getAllStateRows();
    var stateRowIndex = state.updated;

    var selectedRowIndex = $("#grid").gfn_getCurRowIdx();
    var rowData = $("#grid").gfn_getDataRow(selectedRowIndex);
    if (selectedRowIndex < 0) {
        cfn_msg("WARNING", "저장할 정보가 없습니다.");
        return false;
    }
    
    if ($("#grid").gfn_checkValidateCells()){
        return false;
    }
    
    if (confirm("수정하시겠습니까?")) {
        var sid = "updateKokusai";
        var url = "/fulfillment/order/kokusai/updateKokusai.do";
        var param = cfn_getFormData("formSearch");
        var sendData = {"paramData" : param, "paramList" : dataList};
        gfn_sendData(sid, url, sendData);
        gfn_ajax(url, true, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "목록 수정 완료");
                cfn_retrieve();
            }
        });
    }
}
</script>