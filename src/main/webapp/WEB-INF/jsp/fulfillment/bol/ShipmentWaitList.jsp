<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : ShipmentWaitList
    화면명   : SBL 대기 목록
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" id="sCompCd" class="cmc_txt" value="<c:out value='${sessionScope.loginVO.compcd}' />" />
        <ul class="sech_ul">
            <li class="sech_li required">
                <div>입고처리 일자</div>
                <div>
                    <input type="text" id="sToDate" class="cmc_date periods required">
                    ~
                    <input type="text" id="sFromDate" class="cmc_date periods required">
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 160px;">엑스루트 송장번호</div>
                <div>
                    <input type="text" id="sKeyword" class="cmc_value" style="width: 200px;">
                </div>
            </li>
            <li class="sech_li">
                <div>배송국가</div>
                <div>
                    <input type="text" id="sFromNation" list="countrylist">
                    <datalist id="countrylist">
                        <c:forEach var="i" items="${countrylist}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </datalist>
                </div>
            </li>
        </ul>
        <ul class="sech_ul">
            <li class="sech_li">
                <div>창고</div>
                <div>
                    <input type="text" id="sWhcd" class="cmc_code disabled" disabled="disabled">
                    <input type="text" id="sWhnm" class="cmc_value" onchange="inputClear('sWhcd')">
                    <button type="button" class="cmc_cdsearch" onclick="openLayerPopup('sWhcd')"></button>
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 160px;">셀러</div>
                <div>
                    <input type="text" id="sOrgCd" class="cmc_code disabled" disabled="disabled">
                    <input type="text" id="sOrgNm" class="cmc_value" onchange="inputClear('sOrgCd')">
                    <button type="button" class="cmc_cdsearch" onclick="openLayerPopup('sOrgCd')"></button>
                </div>
            </li>
            <li class="sech_li">
                <div>서비스 타입</div>
                <div>
                    <input type="text" id="sShipCompany" list="serviceType">
                    <datalist id="serviceType">
                        <c:forEach var="i" items="${serviceType}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </datalist>
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
            SBL 대기 목록
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <input type="button" class="cmb_normal_new" value="등록" onclick="openLayerPopup('shipment');" />
        </div>
    </div>
    <div id="grid"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    // 초기 로드
    $(function() {
        // 1. 화면레이아웃 지정 (리사이징)
        initLayout();
        // 2. 최초 실행
        cfn_init();
        // 3. 그리드 설정
        setGridData();
    });
    // 공통버튼 - 초기화 클릭
    function cfn_init() {
        $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sToNation").val("KR");
    }
    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        // $("#grid").gridView().cancel();
        gv_searchData = cfn_getFormData("frmSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/bol/shipment/wait/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }
    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            $("#grid").gfn_setDataList(data.resultList);
            $("#grid").gfn_focusPK();
        }
    }
    // 그리드 설정
    function setGridData() {
        var gid = "grid";
        var columns = [
                {
                    name : "xrtInvcSno",
                    header : {
                        text : "송장번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "orgcd",
                    header : {
                        text : "셀러코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80
                }, {
                    name : "stockDate",
                    header : {
                        text : "입고 일자"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "statusCdKr",
                    header : {
                        text : "주문배송상태"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 140
                }, {
                    name : "shipMethodCd",
                    header : {
                        text : "서비스 타입"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "eNation",
                    header : {
                        text : "도착국가"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 70
                }, {
                    name : "shipName",
                    header : {
                        text : "송화인명"
                    },
                    width : 100
                }, {
                    name : "shipTel",
                    header : {
                        text : "송화인 연락처"
                    },
                    width : 100
                }, {
                    name : "shipAddr",
                    header : {
                        text : "송화인 주소"
                    },
                    width : 200
                }, {
                    name : "recvName",
                    header : {
                        text : "수화인명"
                    },
                    width : 150
                }, {
                    name : "recvTel",
                    header : {
                        text : "수화인 전화번호"
                    },
                    width : 130
                }, {
                    name : "recvMobile",
                    header : {
                        text : "수화인 핸드폰 번호"
                    },
                    width : 130
                }, {
                    name : "recvAddr1",
                    header : {
                        text : "수화인 주소1"
                    },
                    width : 200
                }, {
                    name : "recvAddr2",
                    header : {
                        text : "수화인 주소2"
                    },
                    width : 200
                }, {
                    name : "recvPost",
                    header : {
                        text : "수화인 우편번호"
                    },
                    width : 150
                }, {
                    name : "recvCity",
                    header : {
                        text : "수화인 도시"
                    },
                    width : 150
                }, {
                    name : "recvState",
                    header : {
                        text : "수화인 주"
                    },
                    width : 120
                }, {
                    name : "recvCurrency",
                    header : {
                        text : "통화"
                    },
                    width : 100
                }, {
                    name : "ordCnt",
                    header : {
                        text : "주문수량"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 30
                }, {
                    name : "cWgtCharge",
                    header : {
                        text : "실제 과금 중량(Kg)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "cWgtReal",
                    header : {
                        text : "실제 중량(Kg)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "xWgt",
                    header : {
                        text : "무게"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
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
            //열고정 설정
            gridView.setFixedOptions({
                colCount : 2,
                resizable : true,
                colBarWidth : 1
            });
            // 체크박스 설정
            gridView.setCheckBar({
                visible : true,
                exclusive : false,
                showAll : true
            });
            
        });
    }
    // 팝업 호출 공통
    function openLayerPopup(elemId) {
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
        } else if (elemId == "shipment") {
            url = "/fulfillment/bol/shipment/wait/pop/view.do";
            pid = "shipmentWaitPop";
            
            var checkRows = $("#grid").gridView().getCheckedRows();
            var gridData = $("#grid").gfn_getDataRows(checkRows);
            
            params.gridData = gridData;

            if (cfn_isEmpty(checkRows)) {
                cfn_msg("WARNING", "항목이 선택되지 않았습니다.");
                return;
            }
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
                    } else if (elemId == "shipment") {
                        cfn_retrieve();
                    } else {
                    }
                }
            }
        });
    }
    // 창고 및 셀러 이름 변경시 초기화
    function inputClear(elemId) {
        $("#" + elemId).val("");
    }
</script>

<c:import url="/comm/contentBottom.do" />