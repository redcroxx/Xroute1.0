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
		{name:"customerId", header:{text:"판매자ID"}, styles:{textAlignment:"center"}, width:150},
		{name:"customerShoppingMall", header:{text:"판매자 쇼핑몰"}, styles:{textAlignment:"center"}, width:100},
		{name:"orderNo", header:{text:"주문번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
		{name:"cartNo", header:{text:"장바구니번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
		{name:"refNo1", header:{text:"Ref.No.1"}, styles:{textAlignment:"center"}, width:100, editable:true},
		{name:"refNo2", header:{text:"Ref.No.2"}, styles:{textAlignment:"center"}, width:100, editable:true},
		{name:"serviceType", header:{text:"배송타입"}, styles:{textAlignment:"center"}, width:100, editable:true},
		{name:"goodsCd", header:{text:"상품코드"}, styles:{textAlignment:"center"}, width:100, editable:true},
		{name:"goodsName", header:{text:"상품명"}, styles:{textAlignment:"center"}, width:250, editable:true},
		{name:"goodsCnt", header:{text:"수량"}, styles:{textAlignment:"center"}, width:100, editable:true},
		{name:"goodsOption", header:{text:"옵션정보"}, styles:{textAlignment:"center"}, width:100, editable:true},
		{name:"shipName", header:{text:"송화인명"}, styles:{textAlignment:"center"}, width:150, editable:true},
		{name:"recvName", header:{text:"수취인명"}, styles:{textAlignment:"center"}, width:200, editable:true},
		{name:"recvTel", header:{text:"수취인전화번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
		{name:"recvMobile", header:{text:"수취인휴대폰번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
		{name:"recvAddr1", header:{text:"수취인주소1"}, styles:{textAlignment:"center"}, width:250, editable:true},
		{name:"recvAddr2", header:{text:"수취인주소2"}, styles:{textAlignment:"center"}, width:200, editable:true},
		{name:"recvPost", header:{text:"수취인우편번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
		{name:"eNation", header:{text:"수취인국가코드"}, styles:{textAlignment:"center"}, width:100},
		{name:"currency", header:{text:"통화"}, styles:{textAlignment:"center"}, width:100, editable:true},
		{name:"totPaymentPrice", header:{text:"구매자 전체결제금액"}, styles:{textAlignment:"center"}, width:150, editable:true},
		{name:"cityState", header:{text:"City, State"}, styles:{textAlignment:"center"}, width:150, editable:true},
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
	var url = "/fulfillment/order/efs/getSearch.do";
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
</script>