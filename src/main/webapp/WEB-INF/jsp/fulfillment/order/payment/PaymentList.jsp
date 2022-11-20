<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
화면코드 : PAYMENTLIST
화면명   : 주문결제리스트
-->
<!-- 고정탭 구분을 위한 체크 값-->
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" id="sOrgCd" value="<c:out value='${sessionScope.loginVO.orgcd}' />">
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
            <li class="sech_li">
                <div>검색어</div>
                <div>
                    <select id="sKeywordType" style="width: 100px;">
                        <option selected="selected" value="total">--전체--</option>
                        <c:forEach var="i" items="${paymentKeyword}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                    <input type="text" class="cmc_code" id="sKeyword" style="width: 130px;">
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
            주문리스트
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <!-- <input type="button" class="cmb_normal" value="내통장인증" onclick="openLayerPopup('passBook')" /> -->
            <input type="button" class="cmb_normal" value="무통장결제" onclick="openLayerPopup('etc')" />
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
        var btn = "/images/btn_memo.png";
        var columns = [
                {
                    name : "memo",
                    header : {
                        text : "메모"
                    },
                    button : "image",
                    alwaysShowButton : true,
                    imageButtons : {
                        width : 45,
                        images : [
                            {
                                name : "메모",
                                up : btn,
                                hover : btn,
                                down : btn
                            }
                        ]
                    },
                    width : 60
                }, {
                    name : "xrtInvcSno",
                    header : {
                        text : "송장번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "xrtShippingPrice",
                    header : {
                        text : "운임"
                    },
                    styles : {
                        textAlignment : "far",
                        numberFormat : "#,##0.##"
                    },
                    width : 120
                }, {
                    name : "statusCdKr",
                    header : {
                        text : "주문배송상태"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    dynamicStyles : [
                        {
                            criteria : "value like '%오류%'",
                            styles : "background=#FFFF00"
                        }
                    ],
                    width : 140
                }, {
                    name : "shipMethodCd",
                    header : {
                        text : "배송구분"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80
                }, {
                    name : "sNation",
                    header : {
                        text : "출발국가"
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
                    width : 100
                }, {
                    name : "recvCurrency",
                    header : {
                        text : "통화코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80
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
                    name : "xWgt",
                    header : {
                        text : "중량(KG)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80
                }, {
                    name : "xBoxWidth",
                    header : {
                        text : "가로(CM)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80
                }, {
                    name : "xBoxLength",
                    header : {
                        text : "세로(CM)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80
                }, {
                    name : "xBoxHeight",
                    header : {
                        text : "높이(CM)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80
                }, {
                    name : "ordNo",
                    header : {
                        text : "주문번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "totPaymentPrice",
                    header : {
                        text : "구매자 금액"
                    },
                    styles : {
                        textAlignment : "far",
                        numberFormat : "#,##0.##"
                    },
                    width : 120
                }
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false
        });

        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            // 체크박스 설정
            gridView.setCheckBar({
                visible : true,
                exclusive : false,
                showAll : true
            });
            //열고정 설정
            gridView.setFixedOptions({colCount:4, resizable:true, colBarWidth:1});
            gridView.onImageButtonClicked = function (grid, itemIndex, column, buttonIndex, name) {
                var xrtInvcSno = grid.getValue(itemIndex, "xrtInvcSno");
                // openWindowPopup("memo", jsonObj);
                openWindowPopup(xrtInvcSno);
            };
        });
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            console.log(data.resultList);
            $("#grid").gfn_setDataList(data.resultList);
            $("#grid").gfn_focusPK();
        }
    }
    
    function cfn_init() {
        $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
    }

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        $("#grid").gridView().cancel();
        gv_searchData = cfn_getFormData("frmSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/order/payment/paymentList/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }
    // 레이어 팝업 호출 공통
    function openLayerPopup(type) {
        var checkRows = $("#grid").gridView().getCheckedRows();
        var grid1Data = $("#grid").gfn_getDataRows(checkRows);
        var gridData = [];
        var pid = "";
        var url = "";

        if (cfn_isEmpty(checkRows)) {
            alert("항목이 선택되지 않았습니다.");
            return false;
        }
        
        if (type == "etc") {
            pid = "paymentPop";
            url = "/fulfillment/order/payment/paymentList/pop/view.do"
        } else if(type == "passBook") {
            pid = "passBookPop"
            url = "/fulfillment/order/payment/paymentList/pop/passBook/view.do"
        } else {
            
        }
        
        for (var i = 0; i < grid1Data.length; i++) {
            var xrtInvcSno = $("#grid").gfn_getValue(checkRows[i], "xrtInvcSno");
            gridData.push(xrtInvcSno);
        }
        pfn_popupOpen({
            url : url,
            pid : pid,
            params : {
                "gridData" : gridData
            },
            returnFn : function(data, type) {
                if (type == "OK") {
                }
            }
        });
    }
    // 윈도우 팝업 호출
    function openWindowPopup(xrtInvcSno) {
        var width = "1000";
        var height = "690";
        var left = (window.screen.width/2) - (width/2);
        var top = (window.screen.height/2) - (height/2);
        var url = "/fulfillment/order/orderMemoListDtl/view.do?xrtInvcSno=" + xrtInvcSno;
        var option = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top + ", resizable=no, scrollbars=no, menubar=no, location=no, status=no";
        var openWin = window.open(url, "로지포커스", option);
    }
</script>
<c:import url="/comm/contentBottom.do" />