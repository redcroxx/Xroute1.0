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
        <div class="grid_top_left">AtomySettlement<span>(총 0건)</span></div>
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
        {name:"orderDate", header:{text:"주문등록일자"}, styles:{textAlignment:"center"}, width:200, editable:false},
        {name:"unipassTkofdt", header:{text:"선적일자"}, styles:{textAlignment:"center"}, width:200, editable:false},
        {name:"expNo", header:{text:"수출통관필증번호"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"xrtInvcSno", header:{text:"XLF REF"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"ordNo", header:{text:"ATOMY주문번호"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"localShipper", header:{text:"운송사"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"invcSno1", header:{text:"운송장"}, styles:{textAlignment:"center"}, width:200, editable:false},
        {name:"eNation", header:{text:"수출국가(코드)"}, styles:{textAlignment:"center"}, width:100, editable:false},
        {name:"quantity", header:{text:"수량"}, styles:{textAlignment:"center"}, width:100, editable:false},
        {name:"kg", header:{text:"중량(KG)"}, styles:{textAlignment:"center"}, width:100, editable:false},
        {name:"salesPrice1", header:{text:"매출액1(종합)"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"salesPrice2", header:{text:"매출액2(기본)"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"salesPrice3", header:{text:"매출액(기타)"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"purchasesPrice1", header:{text:"매입액1(종합)"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"purchasesPrice2", header:{text:"매입액2(기본)"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"purchasesPrice3", header:{text:"매입액(기타)"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"grossProfits1", header:{text:"총이익(종합)"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"grossProfits2", header:{text:"총이익(기본)"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"grossProfits3", header:{text:"총이익(기타)"}, styles:{textAlignment:"center"}, width:150, editable:false},
        {name:"memo", header:{text:"메모란"}, styles:{textAlignment:"center"}, width:100, editable:false}
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
    var url = "/fulfillment/atomy/settlement/getSearch.do";
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

// 팝업 호출.
function openLayerPopup() {
    var url = "/fulfillment/atomy/settlement/pop/view.do";
    var pid = "atomySettlementPop";
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