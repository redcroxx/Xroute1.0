<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
    화면코드 : mainContent
    화면명   : 메인화면
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색조건 시작 -->
<!-- 검색조건 끝 -->
<div id="uct_top_wrap" class="ct_top_wrap" style="height: 100%;">
    <form id="frmSearch" action="#" onsubmit="return false" style="display: none;">
        <input type="hidden" id="S_COMPCD" value="<c:out value='${sessionScope.loginVO.compcd}' />" />
        <input type="hidden" id="S_ORGCD" value="<c:out value='${sessionScope.loginVO.orgcd}' />" />
        <input type="hidden" id="S_WHCD" value="<c:out value='${sessionScope.loginVO.whcd}' />" />
        <input type="hidden" id="S_STDDATE" />
    </form>
    <div class="ct_float_left" style="width: calc(50% - 7px); height: 100%;">
        <div style="width: 100%; height: calc(100% - 5px)">
            <div class="ct_main_top" style="width: calc(100% - 2px); height: calc(50% - 5px);">
                <div class="ct_main_top_header" style="width: 100%; height: 7.5%">
                    <div style="height: 100%; padding-left: 10px;">
                        <span class="ct_main_top_header_txt">최근 1주일간 업로드 목록</span>
                    </div>
                </div>
                <div style="width: 100%; height: calc(92.5% - 3px)">
                    <div class="ct_main_center_content1" style="padding: 10px; width: calc(100% - 20px); height: calc(100% - 20px)">
                        <div id="weekList"></div>
                    </div>
                </div>
            </div>
            <div class="ct_main_top" style="width: calc(100% - 2px); height: calc(50% - 5px); margin-top: 10px;">
                <div class="ct_main_top_header" style="width: 100%; height: 7.5%">
                    <div style="height: 100%; padding-left: 10px;">
                        <span class="ct_main_top_header_txt">물동량 현황</span>
                    </div>
                </div>
                <div style="width: 100%; height: calc(92.5% - 3px)">
                    <div style="padding: 10px 0px 10px 0px; width: calc(100%); height: calc(30% - 20px)">
                        <div style="float: left; width: calc(33% - 0px); height: calc(100%); background: #ffffff">
                            <div style="width: 100%; height: calc(70% - 25px); padding: 20px 0px 5px 0px">
                                <p id="ordShippedTotal" class="ct_count_numer" style="text-align: center; font-size: 35px; font-weight: bold">0</p>
                            </div>
                            <div style="width: 100%; height: 30%">
                                <p id="" style="text-align: center; font-size: 15px; font-weight: bold">Total</p>
                            </div>
                        </div>
                        <div style="float: left; width: calc(34% - 0px); height: calc(100%); background: #ffffff;">
                            <div style="width: 100%; height: calc(70% - 25px); padding: 20px 0px 5px 0px">
                                <p id="newOrder" class="ct_count_numer" style="text-align: center; font-size: 35px; font-weight: bold">0</p>
                            </div>
                            <div style="width: 100%; height: 30%">
                                <p id="" style="text-align: center; font-size: 15px; font-weight: bold">NewOrder</p>
                            </div>
                        </div>
                        <div style="float: left; width: calc(33% - 0px); height: calc(100%); background: #ffffff;">
                            <div style="width: 100%; height: calc(70% - 25px); padding: 20px 0px 5px 0px">
                                <p id="orderShipped" class="ct_count_numer" style="text-align: center; font-size: 35px; font-weight: bold">0</p>
                            </div>
                            <div style="width: 100%; height: 30%">
                                <p id="" style="text-align: center; font-size: 15px; font-weight: bold">Orders Shipped</p>
                            </div>
                        </div>
                    </div>
                    <div class="ct_main_center_content1" style="padding: 10px; width: calc(100% - 20px); height: calc(70% - 20px)">
                        <div id="chart1" style="height: 100%"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="ct_float_left" style="width: calc(50% - 7px); height: 100%; margin-left: 10px">
        <div style="width: 100%; height: calc(100% - 5px)">
            <div style="width: 100%; height: calc(50% - 5px);">
                <div class="ct_main_top" style="width: calc(100% - 2px); height: calc(50% - 7px);">
                    <div class="ct_main_top_header" style="height: 15.5%">
                        <div style="height: 100%; padding-left: 10px;">
                            <span class="ct_main_top_header_txt">공지사항</span>
                        </div>
                    </div>
                    <div style="width: 100%; height: calc(84.5% - 3px)">
                        <div class="ct_main_center_content1" style="padding: 10px; width: calc(100% - 20px); height: calc(100% - 20px)">
                            <div id="notiList"></div>
                        </div>
                    </div>
                </div>
                <div class="ct_main_top" style="width: calc(100% - 2px); height: calc(50% - 7px); margin-top: 10px">
                    <div class="ct_main_top_header" style="height: 15.5%">
                        <div style="height: 100%; padding-left: 10px;">
                            <span class="ct_main_top_header_txt">누적 배송현황</span>
                        </div>
                    </div>
                    <div style="width: 100%; height: calc(84.5% - 3px)">
                        <div style="float: left; width: calc(50% - 0px); height: calc(100%); background: #ffffff">
                            <div style="width: 100%; height: calc(30% - 25px); padding: 25px 0px 0px 0px">
                                <p style="text-align: center; font-size: 15px; font-weight: bold">이번 주 배송 건</p>
                            </div>
                            <div style="width: 100%; height: calc(70% - 25px); padding: 20px 0px 5px 0px">
                                <p id="weekCnt" class="ct_count_numer" style="text-align: center; font-size: 50px; font-weight: bold; color: #7cb5ec">0</p>
                            </div>
                        </div>
                        <div style="float: left; width: calc(50% - 0px); height: calc(100%); background: #ffffff">
                            <div style="width: 100%; height: calc(30% - 25px); padding: 25px 0px 0px 0px">
                                <p style="text-align: center; font-size: 15px; font-weight: bold">이번 달 배송 건</p>
                            </div>
                            <div style="width: 100%; height: calc(70% - 25px); padding: 20px 0px 5px 0px">
                                <p id="monthCnt" class="ct_count_numer" style="text-align: center; font-size: 50px; font-weight: bold; color: #f15c80">0</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="ct_main_top" style="width: calc(100% - 2px); height: calc(50% - 5px); margin-top: 10px;">
                <div class="ct_main_top_header" style="height: 8%">
                    <div style="height: 100%; padding-left: 10px;">
                        <span class="ct_main_top_header_txt">국가별 배송현황</span>
                    </div>
                </div>
                <div style="width: 100%; height: calc(93% - 3px)">
                    <div class="ct_main_center_content1" style="padding: 10px; width: calc(100% - 20px); height: calc(100% - 20px)">
                        <div id="chart2" style="height: 100%"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="width: 100%; height: calc(17.2% - 5px); margin-top: 10px;">
        <div class="ct_main_top" style="width: calc(100% - 2px); height: calc(100% - 2px);">
            <div class="ct_main_top_header" style="height: 27%">
                <div style="height: 100%; padding-left: 10px;">
                    <span class="ct_main_top_header_txt">info</span>
                </div>
            </div>
            <div style="width: 100%; height: calc(100% - 3px)">
                <div style="padding: 10px; width: calc(100% - 20px); height: calc(100% - 20px); background: #ffffff">
                    <div class="ct_float_left" style="width: 15%; height: 100%">
                        <div class="ctn_main_url_img_div2">
                            <a href="http://www.logifocus.co.kr/" target="_blank">
                                <img src="/images/main/main-logifocus.png" style="width: 100%; height: 100%;">
                            </a>
                        </div>
                    </div>
                    <div class="ct_float_left" style="width: calc(35% - 1px); height: 100%; border-right: 2px dotted #134779;">
                        <div style="height: calc(100% - 20px); padding: 10px">
                            <p class="ct_main_copyright_txt">주소 :  서울특별시 강서구 하늘길 210, 105호(김포공항 화물청사8-1 A창고)</p>
                            <p class="ct_main_copyright_txt">사업자등록번호 : 215-81-89514</p>
                            <p class="ct_main_copyright_txt">대표 : 신상우 | 개인정보관리자 : 김광희</p>
                            <p class="ct_main_copyright_txt">대표번호 : 02-6956-6603 │ 팩스 : 070-8233-6603 │ 이메일 : info@xroute.co.kr</p>
                            <p>
                                <a href="#" onclick="javascript:privacyPolicyPopup();">
                                    <span style="color: #000000; font-size: 12px;">개인정보취급방침
                                        <span style="font-size: 12px;">
                                            <span style="color: #000000;">&nbsp;</span>
                                        </span>
                                    </span>
                                </a>
                                <span style="color: #000000; font-size: 12px;">
                                    <span style="font-size: 12px;">
                                        <span style="color: #000000;">|&nbsp;</span>
                                    </span>
                                </span>
                                <a href="#" onclick="javascript:agreementPopup();">
                                    <span style="color: #000000; font-size: 12px;">
                                        <span style="font-size: 12px;">
                                            <span style="color: #000000;">이용약관</span>
                                        </span>
                                    </span>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    //초기 로드
    $(function() {
        $("#S_STDDATE").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#uct_top_wrap").css("height", "100%");
        
        //그리드 초기화
        initLayout();
        //grid load
        getWeekList();
        getNotiList();
        //chart load
        chart1_Load();
        chart2_Load();

        fn_reload();

        $(window).trigger("resize");
        mainNoticePop();
    });
    

    // 개인정보 취급방침 윈도우 팝업.
    function privacyPolicyPopup() {
        var width = "1000";
        var height = "690";
        var left = (window.screen.width / 2) - (width / 2);
        var top = (window.screen.height / 2) - (height / 2);
        var url = "/comm/privacyPolicy.do";
        var option = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top + ", resizable=no, scrollbars=no, menubar=no, location=no, status=no";
        var openWin = window.open(url, "개인정보취급방침", option);
    }

    // 이용약관 윈도우 팝업.
    function agreementPopup() {
        var width = "1000";
        var height = "690";
        var left = (window.screen.width / 2) - (width / 2);
        var top = (window.screen.height / 2) - (height / 2);
        var url = "/comm/agreement.do";
        var option = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top + ", resizable=no, scrollbars=no, menubar=no, location=no, status=no";
        var openWin = window.open(url, "이용약관", option);
    }

    //주간 주문상태 현황
    function getWeekList() {
        var gid = "weekList";
        var $grid = $("#" + gid);
        var columns = [
                {
                    name : "UPLOAD_DATE",
                    header : {
                        text : "날짜"
                    },
                    formatter : "date",
                    styles : {
                        textAlignment : "center"
                    },
                    width : 120
                }, {
                    name : "orderRegistration",
                    header : {
                        text : "주문등록"
                    },
                    dataType : "number",
                    styles : {
                        textAlignment : "far",
                        numberFormat : "#,##0"
                    },
                    width : 100
                }, {
                    name : "warehousingCompleted",
                    header : {
                        text : "입고"
                    },
                    dataType : "number",
                    styles : {
                        textAlignment : "far",
                        numberFormat : "#,##0"
                    },
                    width : 100
                }, {
                    name : "waitingForDeposit",
                    header : {
                        text : "입금대기"
                    },
                    dataType : "number",
                    styles : {
                        textAlignment : "far",
                        numberFormat : "#,##0"
                    },
                    width : 100
                }, {
                    name : "confirmingPayment",
                    header : {
                        text : "입금완료"
                    },
                    dataType : "number",
                    styles : {
                        textAlignment : "far",
                        numberFormat : "#,##0"
                    },
                    width : 100
                }, {
                    name : "depositCompleted",
                    header : {
                        text : "입고완료"
                    },
                    dataType : "number",
                    styles : {
                        textAlignment : "far",
                        numberFormat : "#,##0"
                    },
                    width : 100
                }
        ];
        $grid.gfn_createGrid(columns, {
            panelflg : false,
            indicator : false,
            footerflg : false,
            sortable : false,
            fitStyle : "even",
            contextmenu : false,
            rowFocusVisible : false,
            headerSelectFocusVisible : false
        });

        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
        });
    }

    //공지사항
    function getNotiList() {
        var gid = "notiList"
        var $grid = $("#" + gid);
        var columns = [
                {
                    name : "TITLE",
                    header : {
                        text : "제목"
                    },
                    width : 400
                }, {
                    name : "ADDUSERNM",
                    header : {
                        text : "작성자"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "ADDDATETIME",
                    header : {
                        text : "등록일"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "COMPCD",
                    visible : false
                }, {
                    name : "NTKEY",
                    visible : false
                }
        ];
        $grid.gfn_createGrid(columns, {
            panelflg : false,
            indicator : false,
            footerflg : false,
            sortable : false,
            fitStyle : "even",
            contextmenu : false,
            rowFocusVisible : false,
            headerSelectFocusVisible : false
        });
        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            //셀 더블클릭
            gridView.onDataCellDblClicked = function(grid, index) {

                var rowidx = $("#notiList").gfn_getCurRowIdx();
                var rowData = $("#notiList").gfn_getDataRow(rowidx);
                pfn_popupOpen({
                    url : "/alexcloud/popup/popS014/view.do",
                    pid : "popS014",
                    params : {
                        "NTKEY" : rowData.NTKEY
                    }
                });

                var sid = "sid_setHits";
                var url = "/sys/s000015/setHits.do";
                var sendData = {
                    "paramData" : rowData
                };

                gfn_sendData(sid, url, sendData);
            };
        });
    }
    /* 공지 팝업 호출 */
    function mainNoticePop() {

        var paramData = cfn_getFormData("frmSearch");
        var url = "/alexcloud/popup/popS014_1/getSearch.do";
        var sendData = {
            "paramData" : paramData
        };
        gfn_ajax(url, true, sendData, function(data, xhr) {
            var noticeList = data.resultList;
            for (var p = 0; p < noticeList.length; p++) {
                if (noticeList[p].POPFLG != "N") {
                    if (getCookie(noticeList[p].NTKEY) != "done") {
                        var popUrl = "/alexcloud/popup/popS014_1/view.do?ntkey=" + noticeList[p].NTKEY;
                        var popOption = "width=900%, height=550%, resizable=no, scrollbars=no, status=no;";
                        window.open(popUrl, "", popOption);
                    }
                }
            }

            function getCookie(name) {
                var nameOfCookie = name + "=";
                var x = 0;
                while (x <= document.cookie.length) {
                    var y = (x + nameOfCookie.length);
                    if (document.cookie.substring(x, y) == nameOfCookie) {
                        if ((endOfCookie = document.cookie.indexOf(";", y)) == -1) {
                            endOfCookie = document.cookie.length;
                        }
                        return unescape(document.cookie.substring(y, endOfCookie));
                    }
                    x = document.cookie.indexOf(" ", x) + 1;
                    if (x == 0)
                        break;
                }
                return "";
            }
        });
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_search") {
            var noticeList = data.resultNoticeList;
            var orderList = data.resultOrderList;
            var orderShippedCntList = data.resultOrderShippedCntList;
            var orderShippedCnt = data.resultOrderShippedCnt;
            var orderCnt = data.resultOrderCntList;
            var orderNationCntList = data.resultOrderNationCntList;
            var thisMonthList = data.resultThisMonthList;

            //그리드 데이터 바인딩
            $("#weekList").gfn_setDataList(orderList);
            $("#notiList").gfn_setDataList(noticeList);

            //차트 데이터 바인딩
            $("#chart2").highcharts().series[0].setData(orderNationCntList);

            //<tag> id 바인딩
            $("#ordShippedTotal").text(parseInt(orderShippedCnt.OrderShipped + orderShippedCnt.NewOrder));
            $("#newOrder").text(orderShippedCnt.NewOrder);
            $("#orderShipped").text(orderShippedCnt.OrderShipped);

            orderCnt.forEach(function(element, index, array) {
                if (element.GBN === "WEEK") {
                    $("#weekCnt").text(element.count);
                } else if (element.GBN === "MONTH") {
                    $("#monthCnt").text(element.count);
                }
            });

            //숫자 countup
            $(".ct_count_numer").counterUp({
                delay : 5,
                time : 500
            });

            //차트 x축 항목 바인딩
            var chart1Cate = cfn_divChartData(thisMonthList, {
                name : "DT"
            });
            $("#chart1").highcharts().xAxis[0].setCategories(chart1Cate.name);
            //차트1 데이터 바인딩
            var chart1Data = cfn_divChartData(orderShippedCntList, {
                ORDERQTY : "ORDERQTY",
                SHIPPEDQTY : "SHIPPEDQTY"
            });

            cfn_clearChartSeries("chart1");

            $("#chart1").highcharts().addSeries({
                name : "입고",
                type : "column",
                color : "rgb(51, 51, 51)",
                data : chart1Data.ORDERQTY
            });
            $("#chart1").highcharts().addSeries({
                name : "출고",
                type : "spline",
                color : "rgb(51, 51, 51)",
                data : chart1Data.SHIPPEDQTY
            });
        }
    }

    function fn_reload() {
        gv_searchData = cfn_getFormData("frmSearch");

        var sid = "sid_search";
        var url = "/comm/getMainContentData.do";
        var sendData = {
            "paramData" : gv_searchData
        };

        gfn_sendData(sid, url, sendData);
    }

    //월간 주문등록/입고완료 현황 xy chart
    function chart1_Load() {
        var chartid = "chart1";

        $("#" + chartid)
                .highcharts(
                        {
                            chart : {
                                zoomType : "xy",
                                height : "30%",
                                backgroundColor : "transparent",
                                plotBackgroundColor : "rgba(255,200,200,0)",
                                backgroundColor : "rgba(255,255,255,0)",
                                borderColor : "rgba(255,255,255,0)"
                            },
                            exporting : {
                                enabled : false
                            },
                            credits : {},
                            title : {
                                text : "최근 30일간 주문등록/입고완료 현황(단위 :건)",
                                style : {
                                    color : "#333333",
                                    afontFamily : "나눔 고딕",
                                    fontSize : "12px",
                                    fontWeight : "800"
                                }
                            },
                            xAxis : {
                                categories : [],
                                lineColor : "#2A4573",
                                alternateGridColor : "rgba(255,255,255,0)",
                                tickLength : 0,
                                labels : {
                                    style : {
                                        color : "#333333",
                                        fontFamily : "나눔 고딕",
                                        fontSize : "12px",
                                        fontWeight : "800"
                                    }
                                }
                            },
                            yAxis : [
                                {
                                    opposite : false,
                                    lineColor : "#2A4573",
                                    gridLineColor : "#333333",
                                    alternateGridColor : "rgba(255,255,255,0)",
                                    title : "",
                                    labels : {
                                        style : {
                                            color : "#333333",
                                            fontFamily : "나눔 고딕",
                                            fontSize : "12px",
                                            fontWeight : "800"
                                        }
                                    }
                                }
                            ],
                            tooltip : {
                                borderWidth : 1,
                                backgroundColor : "#F7F9FB",
                                shadow : true,
                                headerFormat : "<span style='font-size:17px;fontFamily:나눔 고딕;fontWeight:800'>{point.key}</span><table>",
                                pointFormat : "<tr><td style='font-size:15px;fontFamily:나눔 고딕;fontWeight:800;color:#333333;font-weight-bold; padding-top:3px'>{series.name} : </td><td style='padding-top:3px'><b> &nbsp;{point.y}</b></td></tr>",
                                footerFormat : "</table>",
                                shared : true,
                                useHTML : true
                            },
                            legend : {
                                enabled : true,
                                backgroundColor : "rgba(255,255,255,0)",
                                borderColor : "rgba(144,144,144,1)",
                                itemStyle : {
                                    color : "#333333",
                                    fontFamily : "나눔 고딕",
                                    fontSize : "12px",
                                    fontWeight : "800"
                                }
                            },
                            series : []
                        });
    }

    //배송국가현황 pie chart
    function chart2_Load() {
        var chartid = "chart2";

        $("#" + chartid).highcharts({
            chart : {
                type : "pie",
                backgroundColor : "transparent"
            },
            exporting : {
                enabled : false
            },
            title : {
                text : "최근 국가별 배송현황",
                style : {
                    color : "#333333",
                    fontFamily : "나눔 고딕",
                    fontSize : "12px",
                    fontWeight : "800"
                }
            },
            plotOptions : {
                pie : {
                    allowPointSelect : true,
                    cursor : "pointer",
                    dataLabels : {
                        enabled : true,
                        format : "<b style='font-size:15px;fontFamily:나눔 고딕;fontWeight:800'>{point.name}</b>",
                        style : {
                            color : (Highcharts.theme && Highcharts.theme.contrastTextColor) || "black"
                        },
                        showInLegend : true
                    }
                }
            },
            legend : {
                enabled : true
            },
            tooltip : {
                borderWidth : 1,
                backgroundColor : "#F7F9FB",
                shadow : true,
                pointFormat : "<span style='font-size:15px;fontFamily:나눔 고딕; font-weight: bold'>{series.name} : {point.y}건</span>",
                shared : true,
                useHTML : true
            },
            series : [
                {
                    size : "83%",
                    name : "배송량"
                }
            ]
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />