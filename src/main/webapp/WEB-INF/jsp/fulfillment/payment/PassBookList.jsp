<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
화면코드 : PassBookList
화면명   : 내통장 결제 목록
-->
<!-- 고정탭 구분을 위한 체크 값-->
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" id="sCompCd" value="<c:out value='${sessionScope.loginVO.compcd}' />">
        <ul class="sech_ul">
            <li class="sech_li">
                <div>기간</div>
                <div>
                    <input type="text" class="cmc_date periods" id="sToDate">
                    ~
                    <input type="text" class="cmc_date periode" id="sFromDate">
                </div>
            </li>
            <li class="sech_li">
                <div>검색어</div>
                <div>
                    <input type="text" class="cmc_code" id="sKeyword" style="width: 130px;">
                </div>
            </li>
        </ul>
        <ul class="sech_ul">
            <c:choose>
                <c:when test="${sessionScope.loginVO.usergroup <= constMap.SELLER_ADMIN}">
                    <input type="hidden" id="sWhcd" value="<c:out value='${sessionScope.loginVO.whcd}' />">
                    <input type="hidden" id="sOrgCd" value="<c:out value='${sessionScope.loginVO.orgcd}' />">
                </c:when>
                <c:otherwise>
                    <li class="sech_li">
                        <div>창고</div>
                        <div>
                            <input type="text" id="sWhcd" class="cmc_code disabled" disabled="disabled">
                            <input type="text" id="sWhnm" class="cmc_value" onchange="inputClear('sWhcd')">
                            <button type="button" class="cmc_cdsearch" onclick="openLayerPopup('sWhcd')"></button>
                        </div>
                    </li>
                    <li class="sech_li">
                        <div>셀러</div>
                        <div>
                            <input type="text" id="sOrgCd" class="cmc_code disabled" disabled="disabled">
                            <input type="text" id="sOrgNm" class="cmc_value" onchange="inputClear('sOrgCd')">
                            <button type="button" class="cmc_cdsearch" onclick="openLayerPopup('sOrgCd')"></button>
                        </div>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </form>
</div>
<!-- 검색 끝 -->
<!-- 그리드 시작 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
            정기 결제 목록
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <c:if test="${sessionScope.loginVO.usergroup > constMap.SELLER_ADMIN}">
                <button type="button" onclick="openLayerPopup('payApprov')">추가비용 결제</button>
                <button type="button" onclick="setCancel()">추가비용 취소</button>
            </c:if>
        </div>
    </div>
    <div id="grid"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    //초기 로드
    $(function() {
        // 1. 화면레이아웃 지정 (리사이징)
        initLayout();
        // 2. 검색조건 기초설정
        cfn_init();
        // 3. 그리드 초기화
        setGridData();
        // 4. 초기검색
        cfn_retrieve();

    });

    function setGridData() {
        var gid = "grid";
        var columns = [
                {
                    name : "orgcd",
                    header : {
                        text : "셀러코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "userName",
                    header : {
                        text : "이름"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "usercd",
                    header : {
                        text : "사용자 ID"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "custParam1",
                    header : {
                        text : "송장번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "price",
                    header : {
                        text : "가격"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "productNm",
                    header : {
                        text : "구분"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "reqDay",
                    header : {
                        text : "거래일자"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "reqTime",
                    header : {
                        text : "거래시간"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "cancelReqDay",
                    header : {
                        text : "취소일자"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "ordNo",
                    visible : false
                }
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false,
            cmenuGroupflg : false,
            cmenuColChangeflg : false,
            cmenuColSaveflg : false,
            cmenuColInitflg : false
        });
        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            // 체크박스 설정
            var bVisible = false;
            if ("<c:out value='${sessionScope.loginVO.usergroup}'/>" >= "<c:out value='${constMap.SELLER_ADMIN}'/>") {
                bVisible = true;
            }
            gridView.setCheckBar({
                visible : bVisible,
                exclusive : false,
                showAll : true
            });
        });
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            // console.log(data.resultList);
            $("#grid").gfn_setDataList(data.resultList);
            $("#grid").gfn_focusPK();
        }
    }

    function cfn_init() {
        $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));

        if ("<c:out value='${sessionScope.loginVO.usergroup}'/>" >= "<c:out value='${constMap.SELLER_ADMIN}'/>") {
            $("#sKeyword").val("");
            $("#sWhcd").val("");
            $("#sWhnm").val("");
            $("#sOrgcd").val("");
            $("#sOrgNm").val("");
        }
    }

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        $("#grid").gridView().cancel();
        gv_searchData = cfn_getFormData("frmSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/payment/passBookList/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }

    // 창고 및 셀러 이름 변경시 초기화
    function inputClear(elemId) {
        $("#" + elemId).val("");
    }

    // 레이어 팝업 호출 공통
    function openLayerPopup(elemId, jsonObj) {
        var url = "";
        var pid = "";
        var params = {
            S_COMPCD : ($("#sCompCd").val() || ""),
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
        } else if(elemId == "payApprov") {
            url = "/fulfillment/payment/passBookList/pop/view.do";
            pid = "passBookPayPop";
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
                    } else {
                    }
                }
            }
        });
    }
    
    function setCancel() {
        if (confirm("정말로 취소 하시겠습니까?") == false) {
            return;
        }

        var checkRows = $("#grid").gridView().getCheckedRows();
        var gridData = $("#grid").gfn_getDataRows(checkRows);
        var cancelList = [];

        if (checkRows.length == 0) {
            cfn_msg("WARNING", "선택된 행이 없습니다.");
            return;
        }

        for (var i = 0; i < gridData.length; i++) {
            var ordNo = $("#grid").gfn_getValue(checkRows[i], "ordNo");
            var price = $("#grid").gfn_getValue(checkRows[i], "price");
            cancelList.push({
                "cancelPrice" : price,
                "ordNo" : ordNo
            });
        }

        var url = "/fulfillment/payment/passBookList/setCancel.do";
        var sendData = {
            dataList : cancelList
        };

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "저장되었습니다.");
                cfn_retrieve();
            }
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />