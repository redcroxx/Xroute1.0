<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst"%>
<!--
    화면코드 : AtomyOrderList
    화면명   : 애터미 주문 목록
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" id="sOrgCd" name="sOrgCd" value="<c:out value="${sOrgCd}"/>"/>
        <input type="hidden" id="sCompCd" value="<c:out value="${sessionScope.loginVO.compcd}"/>" />
        <input type="hidden" id="sXrtInvcSno" name="sXrtInvcSno">
        <ul class="sech_ul">
            <li class="sech_li required">
                <div>주문등록일자</div>
                <div>
                    <input type="text" id="sToDate" class="cmc_date periods required"/>
                    ~
                    <input type="text" id="sFromDate" class="cmc_date periods required"/>
                </div>
            </li>
            <li class="sech_li">
                <div>송장,주문 번호</div>
                <div style="width: 150px;">
                    <input type="text" id="sKeyword" class="cmc_code" style="width: 150px;"/>
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 100px;">UPS 배송 국가</div>
                <div>
                    <select id="sFromNation" style="width: 200px">
                        <option selected="selected" value="">-- 전체 --</option>
                        <option value="IT">Italy - 이탈리아</option>
                        <option value="AU">Australia - 호주</option>
                        <option value="HK">Hong Kong - 홍콩</option>
                        <option value="JP">Japan - 일본</option>
                        <option value="MY">Malaysia - 말레이시아</option>
                        <option value="MN">Mongolia - 몽골</option>
                        <option value="NZ">New Zealand - 뉴질랜드</option>
                        <option value="SG">Singapore - 싱가폴</option>
                        <option value="TW">Taiwan - 대만</option>
                        <option value="US">United State - 미국</option>
                        <option value="CA">Canada - 캐나다</option>
                        <option value="FR">France - 프랑스</option>
                        <option value="DE">Germany - 독일</option>
                        <option value="CH">Switzerland - 스위스</option>
                        <option value="GB">United Kingdom - 영국</option>
                    </select>
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 100px;">UPS 운송 여부</div>
                <div>
                    <select id="sShipCompany" style="width: 200px">
                        <option selected="selected" value="">-- 전체 --</option>
                        <option value="ups">UPS</option>
                        <option value="other">UPS 제외</option>
                    </select>
                </div>
            </li>
        </ul>
    </form>
</div>
<!-- 검색 끝 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
                     주문 목록
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <input type="button" id="btn_upload" class="cmb_normal_new cbtn_upload" value="     배송송장입력 상태변경" onclick="openPopup();" style="min-width: 100px;"/>
            <input type="button" class="cmb_normal_new cbtn_print" value="     UPS 라벨 출력" onclick="printing('upsLabel')"/>
            <input type="button" class="cmb_normal_new cbtn_print" value="     XROUTE 라벨 출력" onclick="printing('label')"/>
            <input type="button" class="cmb_normal_new cbtn_print" value="     픽킹 리스트 출력" onclick="printing('picking')"/>
            <input type="button" class="cmb_normal_new cbtn_print" value="     Invoice 출력" onclick="printing('invoice')"/>
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
        // 3. 기초검색 조건 설정
        cfn_init();
        // 4. 그리드 초기화
        setGridData();
    });

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        if (cfn_isFormRequireData("frmSearch") == false) {
            return;
        }
        
        /*
        if ($("#sToDate").val() != $("#sFromDate").val()) {
            cfn_msg("WARNING", "시작일과 종료일을 같은날짜로 변경하세요.");
            return;
        } 
        */

        gv_searchData = cfn_getFormData("frmSearch");

        var sid = "sid_getSearch";
        var url = "/fulfillment/atomy/orderList/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }

    //공통버튼 - 초기화
    function cfn_init() {
        $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
    }

    function setGridData() {
        var gid = "grid";
        var columns = [
                {
                    name : "relaySeq",
                    header : {
                        text : "SEQ"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 50
                }, {
                    name : "uploadDate",
                    header : {
                        text : "오더등록일"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "xrtInvcSno",
                    header : {
                        text : "송장번호"
                    },
                    //button : "action",
                    //alwaysShowButton : true,
                    styles : {
                        textAlignment : "center"
                    },
                    width : 160
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
                    name : "upsError",
                    header : {
                        text : "UPS 송장 발번 여부"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "localShipper",
                    header : {
                        text : "운송사"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
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
                    width : 150
                }, {
                    name : "shipAddr",
                    header : {
                        text : "송화인 주소"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 200
                }, {
                    name : "shipMethodCd",
                    header : {
                        text : "배송방식"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "sNation",
                    header : {
                        text : "출발국가"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 60
                }, {
                    name : "eNation",
                    header : {
                        text : "도착국가"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 60
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
                    width : 100
                }, {
                    name : "recvMobile",
                    header : {
                        text : "수화인 핸드폰 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 200
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
                    width : 200
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
                        text : "수화인 주(State)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 120
                }, {
                    name : "recvPost",
                    header : {
                        text : "수화인 우편번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "recvCurrency",
                    header : {
                        text : "통화"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 60
                }, {
                    name : "ordCnt",
                    header : {
                        text : "주문수량"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 60
                }, {
                    name : "ordNo",
                    header : {
                        text : "주문번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
                    editor : {
                        maxLength : 150
                    }
                }, {
                    name : "mallNm",
                    header : {
                        text : "쇼핑몰명"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 130
                }, {
                    name : "cartNo",
                    header : {
                        text : "장바구니 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "goodsNm",
                    header : {
                        text : "상품명"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 250
                }, {
                    name : "goodsOption",
                    header : {
                        text : "상품옵션"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 200
                }, {
                    name : "goodsCnt",
                    header : {
                        text : "상품수량"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 60
                }, {
                    name : "totPaymentPrice",
                    header : {
                        text : "구매자 결제금액"
                    },
                    styles : {
                        textAlignment : "far",
                        numberFormat : "#,##0"
                    },
                    width : 100
                }, {
                    name : "page",
                    show : false
                }
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false,
            cmenuGroupflg : false,
            cmenuColChangeflg : false,
            cmenuColSaveflg : false,
            cmenuColInitflg : false,
            height : "99%"
        });

        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            // 체크박스 설정
            /* var bVisible = false;
            if ("<c:out value='${sessionScope.loginVO.usergroup}'/>" >= "<c:out value='${constMap.SELLER_ADMIN}'/>") {
                bVisible = true;
            }
            gridView.setCheckBar({
                visible : bVisible,
                exclusive : false,
                showAll : true
            });  */
            
            gridView.onCellButtonClicked = function(grid, itemIndex, column) {
                if (column.fieldName == "xrtInvcSno") {
                    var xrtInvcSno = grid.getValue(itemIndex, column.fieldName);
                    var jsonObj = {};
                    jsonObj.xrtInvcSno = xrtInvcSno;
                    // test(jsonObj); // 애터미 배송완료 신호 전송 API 수동 테스트 시 사용.
                }
            };
        });
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            $("#grid").gfn_setDataList(data.resultList);
            $("#grid").gfn_focusPK();
        }
    }

    function printing(type) {
        var gridDataList = $("#grid").gfn_getDataList();
        
        /* var checkRows = $("#grid").gridView().getCheckedRows(); // 체크 박스 데이터.
        var gridData = $("#grid").gfn_getDataRows(checkRows);
        var labelList = [];
        
        if (checkRows.length == 0) {
            cfn_msg("WARNING", "선택된 행이 없습니다.");
            return;
        }
       
        for (var i = 0; i < gridData.length; i++) {
            var xrtInvcSno = $("#grid").gfn_getValue(checkRows[i], "xrtInvcSno");
            labelList.push({
                "xrtInvcSno" : xrtInvcSno
            });
        } */
        
        var name = "";
        var sOrgCd = $("#sOrgCd").val();
        var sDate = $("#sToDate").val().replace(/-/gi, ""); // 시작 날짜
        var eDate = $("#sFromDate").val().replace(/-/gi, ""); // 종료 날짜
        var params = {
            "orgcd" : sOrgCd,
            "sDate" : sDate,
            "eDate" : eDate
        }
        
        var sendData = {
            "dataList" : gridDataList // 원래 gridDataList.
        };
        
        if (type == "picking") {
            name = "ATOMY_PICKING_LIST";
        } else if (type == "invoice") {
            name = "ATOMY_INVOICE_PACKING_LIST";
        } else if (type == "label") {
            name = "ATOMY_LABEL";
        } else if (type = "upsLabel") {
            name = "UPS_LABEL";
        } else {
            cfn_msg("WARNING", "지정되지 않은 구분입니다.");
            return;
        }

        rfn_reportLabel({
            title : name,
            jrfName : name,
            isMultiReport : true,
            multicount : 1,
            args : params
        });
    }
    
    // 배송송장입력 상태변경 팝업.
    function openPopup() {
        var url = "/fulfillment/atomy/orderList/pop/view.do";
        var pid = "atomyOrderModifyPop";
        var params = {};

        pfn_popupOpen({
            url : url,
            pid : pid,
            params : params,
            returnFn : function(data, type) {
            }
        });
    }
    
    /* function test(jsonObj) {
        var url = "/fulfillment/atomy/test/setDeliveredUpdate.do";
        
        $("#sXrtInvcSno").val(jsonObj.xrtInvcSno);
        
        console.log($("#sXrtInvcSno").val());
        
        var sendData = cfn_getFormData("frmSearch");
        
        $.ajax({
            url : url,
            type : "POST",
            data : JSON.stringify(sendData),
            contentType: "application/json",
            beforeSend: function(request) {
                $("body").css("cursor","wait");
                loadingStart();
            },
            success : function(data) {
                loadingEnd();
                code = data.code;
                message = data.message;
                if (data.code == "1") {
                    cfn_msg("INFO", "Code : " + code + "\nMessage : " + message);
                } else {
                    cfn_msg("WARNING", "Code : " + code + "\nMessage : " + message);
                }
            },
            error : function(data) {
                loadingEnd();
                cfn_msg("ERROR", "API Error");
            }
        });
    } */
</script>
<c:import url="/comm/contentBottom.do" />