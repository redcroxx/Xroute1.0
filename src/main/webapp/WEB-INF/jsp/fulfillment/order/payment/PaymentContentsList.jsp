<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : PaymentContentsList.jsp
	화면명   : 결제 내용 목록
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" name="frmSearch" action="#" onsubmit="return false">
        <ul class="sech_ul">
            <li class="sech_li">
                <div>기간</div>
                <div style="width: 400px;">
                    <select id="sPeriodType" style="width: 120px;">
                        <c:forEach var="i" items="${periodType}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                    <input type="text" id="sToDate" class="cmc_date periods" />
                    ~
                    <input type="text" id="sFromDate" class="cmc_date periode" />
                </div>
            </li>
            <li class="sech_li">
                <div>검색어</div>
                <div style="width: 400px;">
                    <select id="sKeywordType" style="width: 100px;">
                        <option selected="selected" value="total">--전체--</option>
                        <c:forEach var="i" items="${ordpaykeyword}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                    <input type="text" id="sKeyword" class="cmc_code" style="width: 180px;" />
                </div>
            </li>
            <li class="sech_li">
                <div>주문상태</div>
                <div>
                    <select id="sStatusCd" style="width: 100px;">
                        <option value="0" selected>--전체--</option>
                        <c:forEach var="i" items="${pstatusCd}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </li>
        </ul>
    </form>
</div>
<!-- 검색 끝 -->
<!-- 그리드 시작 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
            결제내역 목록
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right"></div>
    </div>
    <div id="grid"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    //초기 로드
    $(function() {

        $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        // 1. 화면레이아웃 지정 (리사이징) 
        initLayout();
        // 2. 그리드 초기화
        setGridData();
        // 3. 그리드 조회
        cfn_retrieve();
    });

    function setGridData() {
        var gid = "grid";
        var columns = [
                {
                    name : "pOid",
                    header : {
                        text : "결제주문번호"
                    },
                    button : "action",
                    alwaysShowButton : true,
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "vBankCreateDate",
                    header : {
                        text : "결제신청일자"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 110
                }, {
                    name : "vBankConfirmDate",
                    header : {
                        text : "입금확인일자"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 130
                }, {
                    name : "pAmt",
                    header : {
                        text : "결제금액 (KRW)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    dataType : "number",
                    styles : {
                        textAlignment : "far",
                        numberFormat : "#,##0"
                    },
                    width : 100
                }, {
                    name : "pStatusCd",
                    visible : false
                },
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false,
            cmenuGroupflg : false,
            cmenuColChangeflg : false,
            cmenuColSaveflg : false,
            cmenuColInitflg : false,
        });

        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            //버튼 이벤트
            gridView.onCellButtonClicked = function(grid, itemIndex, column) {
                if (column.fieldName == "pOid") {
                    var jsonObj = {
                        "pOid" : grid.getValue(itemIndex, "pOid") || "",
                        "pAmt" : grid.getValue(itemIndex, "pAmt") || "",
                        "vbankCreateDate" : grid.getValue(itemIndex, "vbankCreateDate") || "",
                        "vbankConfirmDate" : grid.getValue(itemIndex, "vbankConfirmDate") || "",
                        "pStatusCd" : grid.getValue(itemIndex, "pStatusCd") || ""
                    };

                    openLayerPopup(jsonObj);
                }
            };
        });

    }
    // 레이어 팝업 호출 공통
    function openLayerPopup(jsonObj) {
        var pid = "paymentContentsPop";

        pfn_popupOpen({
            url : "/fulfillment/order/payment/paymentContentsList/pop/view.do",
            pid : pid,
            params : jsonObj,
            returnFn : function(data, type) {
                if (type == "OK") {
                }
            }
        });
    }
    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        $("#grid").gridView().cancel();

        gv_searchData = cfn_getFormData("frmSearch");

        var sid = "sid_getSearch";
        var url = "/fulfillment/order/payment/paymentContentsList/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }

    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            $("#grid").gfn_setDataList(data.resultList);
            $("#grid").gfn_focusPK();
        }
    }
</script>
<c:import url="/comm/contentBottom.do" />