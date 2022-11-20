<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : BOLOrderList
    화면명   : BOL 주문 목록
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
                    <input type="text" id="sXrtInvcSno" class="cmc_value" style="width: 200px;">
                </div>
            </li>
            <li class="sech_li">
                <div>배송 국가</div>
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
            <li class="sech_li" style="width: 450px;">
                <div>BOL 검색어</div>
                <div>
                    <select id="sKeywordType" style="width: 100px;">
                        <option selected="selected" value="total">--전체--</option>
                        <option value="SBL">SBL 번호</option>
                        <option value="HBL">HBL 번호</option>
                        <option value="MBL">MBL 번호</option>
                    </select>
                    <input type="text" id="sKeyword" class="cmc_code" style="width: 140px;" />
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
            주문 목록
            <span>(총 0건)</span>
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
        var sKeywordType = $("#sKeywordType").val();
        var sKeyword = $("#sKeyword").val();
        
        if (sKeywordType != "total") {
            if (sKeyword == "") {
                cfn_msg("WARNING", "해당 BOL번호를 입력하세요.");
                return false;
            }
        }
        
        gv_searchData = cfn_getFormData("frmSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/bol/shipment/wait/getOrderSearch.do";
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
                    name : "shipmentBlNo",
                    header : {
                        text : "SBL 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "houseBlNo",
                    header : {
                        text : "HBL 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "scacCode",
                    header : {
                        text : "스캇 코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "masterBlNo",
                    header : {
                        text : "MBL 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "airwayBill",
                    header : {
                        text : "AWB 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
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
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "shipTel",
                    header : {
                        text : "송화인 연락처"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "shipAddr",
                    header : {
                        text : "송화인 주소"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 250
                }, {
                    name : "recvName",
                    header : {
                        text : "수화인명"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "recvTel",
                    header : {
                        text : "수화인 전화번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 130
                }, {
                    name : "recvMobile",
                    header : {
                        text : "수화인 핸드폰 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 130
                }, {
                    name : "recvAddr1",
                    header : {
                        text : "수화인 주소1"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 250
                }, {
                    name : "recvAddr2",
                    header : {
                        text : "수화인 주소2"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 250
                }, {
                    name : "recvPost",
                    header : {
                        text : "수화인 우편번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "recvCity",
                    header : {
                        text : "수화인 도시"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "recvState",
                    header : {
                        text : "수화인 주"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 120
                }, {
                    name : "recvCurrency",
                    header : {
                        text : "통화"
                    },
                    styles : {
                        textAlignment : "center"
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
                    width : 80
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
    }
    // 창고 및 셀러 이름 변경시 초기화
    function inputClear(elemId) {
        $("#" + elemId).val("");
    }
</script>

<c:import url="/comm/contentBottom.do" />