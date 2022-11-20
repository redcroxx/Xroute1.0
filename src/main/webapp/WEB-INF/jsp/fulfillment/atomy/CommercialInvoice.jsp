<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/comm/contentTop.do"></c:import>
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
    </form>
</div>
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">CommercialInvoice 리스트<span>(총 0건)</span></div>
        <div class="grid_top_right">
            <input type="button" class="cmb_normal_new cbtn_upload" value="업로드" onclick="openLayerPopup();" style="min-width: 90px !important;text-align: right;margin-top: 4px;">
        </div>
    </div>
    <div id="gridList"></div>
</div>
<script type="text/javascript">
$(function() {
    initLayout();
    cfn_init();
    grid_load();
});

function grid_load() {
    var gid = "gridList";
    var columns = [
        {name:"xrtInvcSno", header:{text:"INVOICE번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
        {name:"신고자상호", header:{text:"신고자상호"}, styles:{textAlignment:"center"}, width:100, editable:true},
        {name:"수출대행회사명", header:{text:"수출대행회사명"}, styles:{textAlignment:"center"}, width:100, editable:true},
        {name:"수출화주상호", header:{text:"수출화주상호"}, styles:{textAlignment:"center"}, width:100, editable:true},
        {name:"수출화주명", header:{text:"수출화주명"}, styles:{textAlignment:"center"}, width:100, editable:true},
        {name:"corporateRegistrationNo", header:{text:"수출자사업번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
        {name:"수출화주통관부호", header:{text:"수출화주통관부호"}, styles:{textAlignment:"center"}, width:150, editable:true},
        {name:"수출화주소재지", header:{text:"수출화주소재지"}, styles:{textAlignment:"center"}, width:150, editable:true},
        {name:"수출화주주소", header:{text:"수출화주주소"}, styles:{textAlignment:"center"}, width:150, editable:true},
        {name:"제조자명", header:{text:"제조자명"}, styles:{textAlignment:"center"}, width:100, editable:true},
        {name:"supplyNo", header:{text:"해외공급자번호(구매자이름/영문)"}, styles:{textAlignment:"center"}, width:200, editable:true},
        {name:"신고구분", header:{text:"신고구분"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"거래구분", header:{text:"거래구분"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"결제방법", header:{text:"결제방법"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"recvNation", header:{text:"목적국"}, styles:{textAlignment:"center"}, width:50, editable:true},
        {name:"shipPost", header:{text:"물품소재지우편번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
        {name:"shipAddr", header:{text:"물품소재지주소"}, styles:{textAlignment:"center"}, width:350, editable:true},
        {name:"보세구역번호", header:{text:"보세구역번호"}, styles:{textAlignment:"center"}, width:100, editable:true},
        {name:"환급신청인", header:{text:"환급신청인"}, styles:{textAlignment:"center"}, width:100, editable:true},
        {name:"wgt", header:{text:"총중량"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"deliveryTerms", header:{text:"인도조건"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"recvCurrency", header:{text:"통화단위"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"excTotSum", header:{text:"총결제금액(USD)"}, styles:{textAlignment:"center"}, width:120, editable:true},
        {name:"excAmt", header:{text:"상품금액(USD)"}, styles:{textAlignment:"center"}, width:120, editable:true},
        {name:"excTagSum", header:{text:"배송비(USD)"}, styles:{textAlignment:"center"}, width:120, editable:true,  show:false},
        {name:"hsCode", header:{text:"세번부호"}, styles:{textAlignment:"center"}, width:300, editable:true},
        {name:"volumeWeight", header:{text:"순중량"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"origin", header:{text:"원산지"}, styles:{textAlignment:"center"}, width:100, editable:true},
        {name:"enProductName", header:{text:"모델"}, styles:{textAlignment:"center"}, width:500, editable:true},
        {name:"goodsCnt", header:{text:"수량"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"each", header:{text:"단위"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"price", header:{text:"단가(원)"}, styles:{textAlignment:"center"}, width:280, editable:true},
        {name:"amount", header:{text:"소계(원)"}, styles:{textAlignment:"center"}, width:280, editable:true},
        {name:"saleTagSum", header:{text:"배송비(원)"}, styles:{textAlignment:"center"}, width:280, editable:true, show:false},
        {name:"saleTotSum", header:{text:"총결제금액(원)"}, styles:{textAlignment:"center"}, width:280, editable:true, show:false},
        {name:"packingUnitCnt", header:{text:"란포장개수"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"packingUnit", header:{text:"란포장개수단위"}, styles:{textAlignment:"center"}, width:150, editable:true},
        {name:"기타명1", header:{text:"기타명1"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"loadingPort", header:{text:"적재항"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"기타명2", header:{text:"기타명2"}, styles:{textAlignment:"center"}, width:80, editable:true},
        {name:"제조사우편번호", header:{text:"제조사우편번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
        {name:"packingUnitAll", header:{text:"총포장개수단위"}, styles:{textAlignment:"center"}, width:150, editable:true},
        {name:"ordNo", header:{text:"송품장부호(란)"}, styles:{textAlignment:"center"}, width:150, editable:true},
        {name:"expNo", header:{text:"수출신고필증번호"}, styles:{textAlignment:"center"}, width:150, editable:true}
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
        $("#gridList").gfn_setDataList(data.resultList);
    }
}

function cfn_retrieve() {
    gv_searchData = cfn_getFormData("formSearch");
    var sid = "getSearch";
    var url = "/fulfillment/atomy/commercialInvoice/getSearch.do";
    var sendData = gv_searchData;
    gfn_sendData(sid, url, sendData, true);
}

function cfn_init() {
    // 기간이 null이 아니면, 기간을 검색 조건에 따라 세팅.
    if ("<c:out value='${sToDate}'/>" != "") {
        $("#sToDate").val("<c:out value='${sToDate}'/>");
        $("#sFromDate").val("<c:out value='${sFromDate}'/>");
    } else {
        $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
    }
    
    // 초기화.
    $("#sXrtInvcSno").val("");
}

//팝업 호출.
function openLayerPopup() {
    var url = "/fulfillment/atomy/commercialInvoice/pop/view.do";
    var pid = "commercialInvoicePop";
    var params = {};

    pfn_popupOpen({
        url : url,
        pid : pid,
        params : params,
        returnFn : function(data, type) {
        }
    });
}
</script>
<c:import url="/comm/contentBottom.do" />