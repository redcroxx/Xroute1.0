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
                <div>구분</div>
                <div>
                    <select id="sOrgCd" style="width: 100px">
                        <option selected="selected" value="">일반(PREMIUM 제외)</option>
                        <option value="atomy">애터미</option>
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
		{name:"shipmentRef1", header:{text:"Shipment_Ref1"}, styles:{textAlignment:"center"}, width:150, editable:true},
		{name:"goodsPartNumber", header:{text:"Goods_Part_Number"}, styles:{textAlignment:"center"}, width:150, editable:true},
		{name:"goodsDescription", header:{text:"Goods_Description"}, styles:{textAlignment:"center"}, width:300, editable:true},
		{name:"goodsTariffCode", header:{text:"Goods_TariffCode"}, styles:{textAlignment:"center"}, width:150, editable:true},
		{name:"goodsCoo", header:{text:"Goods_Coo"}, styles:{textAlignment:"center"}, width:100, editable:true},
		{name:"goodsUnits", header:{text:"Goods_Units"}, styles:{textAlignment:"center"}, width:100, editable:true},
		{name:"goodsUnitOfMeasure", header:{text:"Goods_UnitOfMeasure"}, styles:{textAlignment:"center"}, width:150, editable:true},
		{name:"goodsUnitPrice", header:{text:"Goods_UnitPrice"}, styles:{textAlignment:"center"}, width:100, editable:true},
		{name:"goodsCurrency", header:{text:"Goods_Currency"}, styles:{textAlignment:"center"}, width:100, editable:true},
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
	var url = "/fulfillment/order/ups/goodsSearch.do";
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