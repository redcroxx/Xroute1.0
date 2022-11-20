<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
    화면코드 : shipmentBlNoPop
-->
<div id="shipmentBlNoPop" class="pop_wrap">
    <!-- 검색조건영역 시작 -->
    <div id="ct_sech_wrap">
        <form id="frm_search_sbl" action="#" onsubmit="return false">
            <ul class="sech_ul">
                <li class="sech_li">
	                <div>기간</div>
	                <div>
	                    <input type="text" id="DATE_TO" class="cmc_date periods" readonly="readonly" />
	                    ~
	                    <input type="text" id="DATE_FROM" class="cmc_date periode" readonly="readonly" />
	                </div>
	            </li>
	            <li class="sech_li">
                    <div>SBL 번호</div>
                    <div>
                        <input type="text" id="shipmentBlNo" class="cmc_value" style="width: 200px;">
                    </div>
                </li>
            </ul>
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>배송국가</div>
                    <div>
                        <input type="text" id="country" list="countrylist">
                        <datalist id="countrylist">
                            <c:forEach var="i" items="${countrylist}">
                                <option value="${i.code}">${i.value}</option>
                            </c:forEach>
                        </datalist>
                    </div>
                </li>
                <li class="sech_li">
                <div style="width: 100px;">서비스 타입</div>
                <div>
                    <select id="sKeywordType">
                        <option selected="selected" value="PREMIUM">PREMIUM</option>
                        <option value="DHL">DHL</option>
                    </select>
                </div>
            </li>
            </ul>
            <button type="button" class="cmb_pop_search" onclick="fn_search_sbl()"></button>
        </form>
    </div>
    <!-- 검색조건영역 끝 -->
    
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">검색결과</div>
            <div class="grid_top_right"></div>
        </div>
        <div id="grid_sblNo"></div>
    </div>
</div>

<script type="text/javascript">

//초기 로드
$(function() {
    $("#shipmentBlNoPop").lingoPopup({
        title: "SBL 번호 검색",
        buttons: {
            "확인": {
                text: "확인",
                click: function() {
                    var checkRows = $("#grid_sblNo").gridView().getCheckedRows();
                    var gridData = $("#grid_sblNo").gfn_getDataRows(checkRows);
                    var shipmentBlNos = "";
                    for (var i = 0; i < gridData.length; i++) {
                        var shipmentBlNo = $("#grid_sblNo").gfn_getValue(checkRows[i], "shipmentBlNo");
                        if (i == 0) {
                            shipmentBlNos += shipmentBlNo;
                        }else {
                            shipmentBlNos += "," + shipmentBlNo;
                        }
                    }
                    
                    console.log("shipmentBlNos : " + shipmentBlNos);

                    if (shipmentBlNos == "") {
                        cfn_msg("ERROR", "선택된 데이터가 없습니다.");
                        return;
                    }
                    
                    var resMap = {
                            "shipMethodCd" : $("#sKeywordType").val(),
                            "shipmentBlNos" : shipmentBlNos,
                            "DATE_TO" : $("#DATE_TO").val(),
                            "DATE_FROM" : $("#DATE_FROM").val()
                    }
                    
                    $("#shipmentBlNoPop").lingoPopup("setData", resMap);
                    $("#shipmentBlNoPop").lingoPopup("close", "OK");
                }
            },
            "취소": {
                text: "취소",
                click: function() {
                    $(this).lingoPopup("setData", "");
                    $(this).lingoPopup("close", "CANSEL");
                }
            }
        },
        open: function(data) {
            cfn_bindFormData("frm_search_sbl", data);
            
            grid_Load_sblPop();

            var gridData = data.gridData;
            
            if (!cfn_isEmpty(gridData) && gridData.length > 0) {
                $("#grid_sblNo").gfn_setDataList(data.gridData);
            } else {
                fn_search_sbl();
            }
        }
    });
});

function grid_Load_sblPop() {
    var gid = "grid_sblNo";
    var columns = [
        {name:"shipmentBlNo",header:{text:"SBL번호"},width:200},
        {name:"country",header:{text:"국가"},width:200},
        {name:"customsClearanceNm",header:{text:"통관"},width:200},
        {name:"adddatetime",header:{text:"등록일시"},width:250}
    ];

    //그리드 생성
    $("#" + gid).gfn_createGrid(columns, {footerflg:false});

    //그리드설정 및 이벤트처리
    $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
        // 체크박스 설정
        gridView.setCheckBar({
            visible : true,
            exclusive : false,
            showAll : true
        });
    });
}

/* 검색 */
function fn_search_sbl() {
    var paramData = cfn_getFormData("frm_search_sbl");
    var sendData = {"paramData":paramData};
    var url = "/fulfillment/settlement/packingDetails/pop/search.do";
    
    gfn_ajax(url, true, sendData, function(data, xhr) {
        $("#grid_sblNo").gfn_setDataList(data.resultList);
    });
}
</script>