<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="/css/common.css" rel="stylesheet">
<!-- 
    화면코드 : mainContentSeller
    화면명   : 메인화면
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색조건 시작 -->
<!-- 검색조건 끝 --> 
<div id="uct_top_wrap" class="ct_top_wrap" style="height: 50%;">
    <form id="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" id="S_COMPCD" value="<c:out value='${sessionScope.loginVO.compcd}' />" />
        <input type="hidden" id="S_ORGCD" value="<c:out value='${sessionScope.loginVO.orgcd}' />" />
        <input type="hidden" id="S_WHCD" value="<c:out value='${sessionScope.loginVO.whcd}' />" />
        <input type="hidden" id="S_STDDATE" />
        <div class="ct_float_left" style="width: calc(30% - 7px); height: 50%;">
            <div style="width: 100%; height: calc(100% - 5px)">
                <div class="ct_main_top" style="width: calc(100% - 2px); height: calc(100% - 5px);">
                    <div class="ct_main_top_header" style="height: 10.5%">
                        <div style="height: 100%; padding-left: 10px;">
                            <span class="ct_main_top_header_txt">공지사항</span>
                        </div>
                    </div>
                    <div style="width: 100%; height: calc(95.5% - 3px)">
                        <div class="ct_main_center_content1" style="padding: 10px; width: calc(100%); height: calc(100% - 20px)">
                            <div id="grid"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="ct_float_left" style="width: calc(30% - 7px); height: 50%; margin-left: 10px;">
            <div style="width: 100%; height: calc(100%);">
                <div style="width: 100%; height: calc(100% - 5px);">
                    <div class="ct_main_top" style="width: calc(100% - 2px); height: calc(100% - 5px);">
                        <div class="ct_main_top_header" style="height: 10.5%;">
                            <div style="height: 100%; padding-left: 10px;">
                                <span class="ct_main_top_header_txt">메모 사항</span>
                            </div>
                        </div>
                        <div style="width: 100%; height: calc(90.5% - 3px)">
                            <div style="float: left; width: calc(50% - 0px); height: calc(100%); background: #ffffff">
                                <div style="width: 100%; height: calc(30% - 25px); padding: 80px 0px 0px 0px">
                                    <p style="text-align: center; font-size: 25px; font-weight: bold">전체 메모</p>
                                </div>
                                <div style="width: 100%; height: calc(70% - 25px); padding: 20px 0px 5px 0px">
                                    <p id="allCnt" class="ct_count_numer" style="text-align: center; font-size: 100px; font-weight: bold; color: #7cb5ec" onclick="openPopup('A');">0</p>
                                </div>
                            </div>
                            <div style="float: left; width: calc(50% - 0px); height: calc(100%); background: #ffffff">
                                <div style="width: 100%; height: calc(30% - 25px); padding: 80px 40px 0px 0px">
                                    <p style="text-align: center; font-size: 25px; font-weight: bold">미완료 메모</p>
                                </div>
                                <div style="width: 100%; height: calc(70% - 25px); padding: 20px 40px 5px 0px">
                                    <p id="noCnt" class="ct_count_numer" style="text-align: center; font-size: 100px; font-weight: bold; color: #f15c80" onclick="openPopup('N');">0</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="ct_float_left" style="width: calc(40% - 7px); height: 50%; margin-left: 10px;">
            <div style="width: 100%; height: calc(100%);">
                <div style="width: 100%; height: calc(100% - 5px);">
                    <div class="ct_main_top" style="width: calc(100% - 2px); height: calc(100% - 5px); background-color: #f6f6f6;">
                        <div class="ct_main_top_header" style="height: 10.5%;">
                            <div style="height: 100%; padding-left: 10px;">
                                <span class="ct_main_top_header_txt">배송비 계산</span>
                            </div>
                        </div>
                        <div style="width: 100%; height: calc(90.5% - 3px); color: #FFFFFF;">
                            <table width="100%" align="center" style="margin-top: 7px;">
                                <tr>
                                    <td align="center" valign="top">
                                        <table width="515" border="1" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                    <td height="27" align="center" style="background-color: #e0e0e0;">
                                                        <b>배송정보</b>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <table border="1" cellpadding="1" cellspacing="1" width="515" bgcolor="bdbdbd" align="center">
                                            <tr>
                                                <td bgcolor="#e0e0e0" width="" height="26" align="center"><b>배송 구분</b></td>
                                                <td bgcolor="ffffff" align="left">
                                                    &nbsp;
                                                    <input type="radio" id="premium" name="shipMethodCd" value="premium" checked="checked"><b>&nbsp;Premium</b>
                                                    <!-- <input type="radio" id="dhl" name="shipMethodCd" value="dhl"><b>&nbsp;DHL</b> -->
                                                    <input type="radio" id="ups" name="shipMethodCd" value="ups"><b>&nbsp;UPS</b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td bgcolor="#e0e0e0" width="120" height="28" align="center"><b>국가 선택</b></td>
                                                <td bgcolor="ffffff" align="left" width="330">
                                                    &nbsp;
                                                    <select id="premiumCountry" name="premiumCountry" style="width: 170px; LETTER-SPACING: -0.9px; color: 000000;">
                                                        <option selected="selected" value="">====== 선택 ======</option>
                                                        <c:forEach var="i" items="${countrylist}">
                                                            <option value="${i.code}">${i.value}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <%-- <select id="dhlCountry" name="dhlCountry" style="width: 170px; LETTER-SPACING: -0.9px; color: 000000;">
                                                        <option selected="selected" value="">====== 선택 ======</option>
                                                        <c:forEach var="i" items="${countrylist2}">
                                                            <option value="${i.code}">${i.value}</option>
                                                        </c:forEach>
                                                    </select> --%>
                                                   <select id="upsCountry" name="upsCountry" style="width: 250px; LETTER-SPACING: -0.9px; color: 000000;">
                                                        <option selected="selected" value="">====== 선택 ======</option>
                                                        <c:forEach var="i" items="${countrylist3}">
                                                            <option value="${i.code}">${i.value}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <input type="text" onkeypress="" id="zipCode" name="zipCode" placeholder="우편번호 입력" size="15" maxlength="5" class="text" style="height: 22; text-align: left;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td bgcolor="#e0e0e0" width="" height="28" align="center"><b>실중량 (kg)</b></td>
                                                <td bgcolor="ffffff" align="left">
                                                    &nbsp;
                                                    <input type="text" onkeypress="return isNumberKey(event)" id="wgt" name="wgt" placeholder="ex)    11.11" size="8" maxlength="5" class="text"
                                                        style="height: 22; text-align: right;"
                                                    >
                                                    &nbsp;<b>kg (kilogram)</b><font style="FONT-SIZE: 12px; LINE-HEIGHT: 1.2; COLOR: #FF0000; FONT-FAMILY: 돋움; LETTER-SPACING: -0.98px">&nbsp;(예 : 11 .
                                                        11)</font>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td bgcolor="#e0e0e0" width="" height="28" align="center"><b>부피 (cm)</b></td>
                                                <td bgcolor="ffffff" align="left">
                                                    &nbsp;
                                                    <input type="text" name="width" id="width" size="3" class=cmc_code placeholder="cm" onkeypress="return isNumberKey(event)"
                                                        style="width: 50; height: 22; text-align: right"
                                                    >
                                                    X
                                                    <input type="text" name="height" id="height" size="3" class="cmc_code" placeholder="cm" onkeypress="return isNumberKey(event)"
                                                        style="width: 50; height: 22; text-align: right"
                                                    >
                                                    X
                                                    <input type="text" name="length" id="length" size="3" class="cmc_code" placeholder="cm" onkeypress="return isNumberKey(event)"
                                                        style="width: 50; height: 22; text-align: right"
                                                    >
                                                    <font style="FONT-SIZE: 12px; LINE-HEIGHT: 1.2; COLOR: #FF0000; FONT-FAMILY: 돋움; LETTER-SPACING: -0.98px">(가로 X 세로 X 높이)&nbsp;(예 : 11 . 11)</font>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td bgcolor="#e0e0e0" width="" height="28" align="center"><b>부피 중량 (kg)</b></td>
                                                <td bgcolor="ffffff" valign="middle"><div id="volume" style="color: blue; font-weight: bold; margin-left: 10px;"></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td bgcolor="#e0e0e0" width="" height="28" align="center"><b>요금 적용 중량</b></td>
                                                <td bgcolor="ffffff" valign="middle"><div id="resultVolume" style="color: blue; font-weight: bold; margin-left: 10px;"></div>
                                                </td>
                                            </tr>
                                        </table>
                                        <table width="515" border="1" cellpadding="1" cellspacing="1" bgcolor="bdbdbd" align="center" style="margin-top: 10px;">
                                            <tbody>
                                                <tr>
                                                    <td bgcolor="#e0e0e0" width="115px;" height="28" valign="middle" align="center">
                                                        <b>예상 비용</b>
                                                    </td>
                                                    <td width="380" bgcolor="ffffff" align="right" valign="middle">
                                                        <font color="blue"><b id="resultPrice"></b></font>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <table cellpadding="0" cellspacing="0" width="450" bgcolor="" align="center" style="margin-top: 10px;">
                                            <tbody>
                                                <tr>
                                                    <td colspan="1" align="center">
                                                        <input type="button" class="btn" value="계산하기" onclick="shippingCharge();" style="background-color: #ffa726; font-weight: 500;">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <table border="1" id="id_table_iframe" width="515" style="margin-top: 10px;">
                                            <tbody>
                                                <tr>
                                                    <td style="FONT-SIZE: 12px; LINE-HEIGHT: 1.5; FONT-FAMILY: 돋움; LETTER-SPACING: -0.5px; text-align: center; background-color: #e0e0e0;">
                                                        * PREMIUM 부피적용(cm) : (가로X세로X높이) / 6000 으로 계산하여 중량과 부피값 중 높은값 적용.<br> 
                                                        * UPS 부피적용(cm) : (가로X세로X높이) / 5000 으로 계산하여 중량과 부피값 중 높은값 적용.<br>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 하단 부분. -->
        <div class="ct_main_top" style="width: calc(100% - 2px); height: calc(40% - 5px); margin-top: 5px;">
            <div class="ct_main_top_header" style="margin-top: 7px; width: 100%; height: 11.5%;">
                <div style="height: 100%; padding-left: 10px;">
                    <span class="ct_main_top_header_txt">기간 검색</span>
                    <input type="text" id="sToDate" class="cmc_date periods required" />
                    ~
                    <input type="text" id="sFromDate" class="cmc_date periode required" />
                </div>
            </div>
            <div style="width: 100%; height: calc(87% - 3px)">
                <div style="padding: 10px 0px 10px 0px; width: calc(100%); height: calc(100% - 20px);">
                    <div style="float: left; width: calc(100% - 0px); height: calc(100%); background: #f9f9f9;">
                        <div class="lf-cont_step">
                            <a class="all" id="btn_spnStatisticsTotal" role="button" onclick="sendStatus('totalCount')">
                                전체 <strong id="totalCount" class="ct_count_numer">0</strong>
                            </a>
                            <a class="dlv" id="btn_spnStatisticsP1" role="button" onclick="sendStatus('order')">
                                오더등록<strong id="order" class="ct_count_numer">0</strong>
                            </a>
                            <a class="dlv" id="btn_spnStatisticsA2" role="button" onclick="sendStatus('warehouse')">
                                창고입고<strong id="warehouse" class="ct_count_numer">0</strong>
                            </a>
                            <a class="dlv" id="btn_spnStatisticsP3" role="button" onclick="sendStatus('warehousing')">
                                창고보관<strong id="warehousing" class="ct_count_numer">0</strong>
                            </a>
                            <a class="dlv" id="btn_spnStatisticsP3" role="button" onclick="sendStatus('shipped')">
                                출고<strong id="shipped" class="ct_count_numer">0</strong>
                            </a>
                            <a class="dlv" id="btn_spnStatisticsD4" role="button" onclick="sendStatus('delivery')">
                                배송중<strong id="delivery" class="ct_count_numer">0</strong>
                            </a>
                            <a class="dlv" id="btn_spnStatisticsD5" role="button" onclick="sendStatus('delivered')">
                                배송완료<strong id="delivered" class="ct_count_numer">0</strong>
                            </a>
                            <a class="rej" id="btn_spnStatisticsPX" role="button" onclick="sendStatus('error')">
                                배송취소/실패<strong id="error" class="ct_count_numer">0</strong>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="width: 100%; height: calc(17.2% - 5px); margin-top: 10px;">
            <div class="ct_main_top" style="width: calc(100% - 2px); height: calc(100% - 2px);">
                <div class="ct_main_top_header" style="height: 27%">
                    <div style="height: 100%; padding-left: 10px;">
                        <span class="ct_main_top_header_txt">Info</span>
                    </div>
                </div>
                <div style="width: 100%; height: calc(100% - 30px)">
                    <div style="padding: 10px; width: calc(100%); height: calc(100%); background: #ffffff">
                        <div class="ct_float_left" style="width: 15%; height: 100%">
                            <div class="ctn_main_url_img_div2">
                                <a href="http://www.logifocus.co.kr/" target="_blank">
                                    <img src="/images/main/main-logifocus.png" style="width: 100%; height: 100%;">
                                </a>
                            </div>
                        </div>
                        <div class="ct_float_left" style="width: calc(35% - 1px); height: 100%; border-right: 2px dotted #134779;">
                            <div style="height: calc(100% - 20px);">
                                <p class="ct_main_copyright_txt">주소 : 서울특별시 강서구 하늘길 210, 105호(김포공항 화물청사8-1 A창고)</p>
                                <p class="ct_main_copyright_txt">사업자등록번호 : 215-81-89514</p>
                                <p class="ct_main_copyright_txt">대표 : 신상우 | 개인정보관리자 : 김광희</p>
                                <p class="ct_main_copyright_txt">대표번호 : 02-6956-6603 │ 팩스 : 070-8233-6603 │ 이메일 : info@xroute.co.kr</p>
                                <p>
                                    <a href="javacsript:void(0)" onclick="javascript:privacyPolicyPopup();">
                                        <span style="color: #000000; font-size: 12px;">
                                            개인정보취급방침
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
                                    <a href="javacsript:void(0)" onclick="javascript:agreementPopup();">
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
    </form>
</div>
<script type="text/javascript">
    //초기 로드.
    $(function() {
        $("#S_STDDATE").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#uct_top_wrap").css("height", "100%");
        //그리드 초기화
        initLayout();
        // 일주일 전 날짜 구하기.
        var sToDate = new Date();
        var day = sToDate.getDate();
        sToDate.setDate(day - 7);
        $("#sToDate").val(cfn_getDateFormat(sToDate, "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        //grid load.
        getNotiList();
        getSearch();
        mainNoticePop();
        $(window).trigger("resize");
        
        // selectBox 숨김.
        $("#dhlCountry").hide();
        $("#upsCountry").hide();
        $("#zipCode").hide();
        
        // 라디오 버튼(배송 구분) 클릭 시 이벤트.
        $("input[name='shipMethodCd']").on("change", function () {
           var chkValue = $("input[name='shipMethodCd']:checked").val();
           
           if (chkValue == "premium") {
              $("#premiumCountry").show();
              $("#dhlCountry").hide();
              $("#upsCountry").hide();
              $("#zipCode").hide();
           }else if (chkValue == "dhl") {
               $("#dhlCountry").show();
               $("#premiumCountry").hide();
               $("#upsCountry").hide();
               $("#zipCode").hide();
           }else if (chkValue == "ups") {
               $("#upsCountry").show();
               $("#zipCode").show();
               $("#premiumCountry").hide();
               $("#dhlCountry").hide();
           }
           
           $("#premiumCountry").val("");
           $("#dhlCountry").val("");
           $("#upsCountry").val("");
           $("#wgt").val("");
           $("#width").val("");
           $("#height").val("");
           $("#length").val("");
           $("#volume").text("");
           $("#resultVolume").text("");
           $("#resultPrice").text("");
        });

        // 부피 중량 계산.
        $(".cmc_code").keyup(function() {
            var result = 0;
            $(".cmc_code").each(function(idx,ele){
                if(!isNaN(this.value) && this.value.length != 0){
                    var result = 0;
                    var pct = 0;
                    var wgt = $("#wgt").val() || 0;
                    var wid = $("#width").val() || 0;
                    var len = $("#length").val() || 0;
                    var hei = $("#height").val() || 0;
                    
                    var checkVal = $("input[name='shipMethodCd']:checked").val();
                    console.log("checkVal : " + checkVal);
                    if (checkVal == "premium") {
                        pct = 6000;
                        result = wid * hei * len / pct;
                    }else if (checkVal == "dhl") {
                        pct = 5000;
                        result = wid * hei * len / pct;
                    }else if (checkVal == "ups") {
                        pct = 5000;
                        result = wid * hei * len / pct;
                    }
                    
                    if (wgt > result) {
                        $("#resultVolume").text(wgt + " kg");
                    }else if (result > wgt) {
                        $("#resultVolume").text(result.toFixed(2) + " kg");
                    }
                    
                    $("#volume").text(wid + " X " + hei + " X " + len + " / " + pct + " = "  + result.toFixed(2) + " kg");
                }
            });
        });

        $("#sToDate").on("propertychange change keyup paste input", function() {
            $("#sToDate").val($(this).val());
            getSearch();
        });
        
        $("#sFromDate").on("propertychange change keyup paste input", function() {
            $("#sFromDate").val($(this).val());
            getSearch();
        });
    });
    
    //개인정보 취급방침 윈도우 팝업.
    function privacyPolicyPopup() {
        var width = "1000";
        var height = "690";
        var left = (window.screen.width/2) - (width/2);
        var top = (window.screen.height/2) - (height/2);
        var url = "/comm/privacyPolicy.do";
        var option = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top + ", resizable=no, scrollbars=no, menubar=no, location=no, status=no";
        var openWin = window.open(url, "개인정보취급방침", option);
    }
    
    // 이용약관 윈도우 팝업.
    function agreementPopup() {
        var width = "1000";
        var height = "690";
        var left = (window.screen.width/2) - (width/2);
        var top = (window.screen.height/2) - (height/2);
        var url = "/comm/agreement.do";
        var option = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top + ", resizable=no, scrollbars=no, menubar=no, location=no, status=no";
        var openWin = window.open(url, "이용약관", option);
    }
    
    // 주간 주문상태 현황
    function getNotiList() {
        var gid = "grid";
        var $grid = $("#" + gid);
        var columns = [
                {
                    name : "ADDDATETIME",
                    header : {
                        text : "등록일"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 40
                }, {
                    name : "TITLE",
                    header : {
                        text : "제목"
                    },
                    width : 200
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

        // 그리드설정 및 이벤트처리.
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            //셀 더블클릭
            gridView.onDataCellDblClicked = function(grid, index) {
                var rowidx = $("#grid").gfn_getCurRowIdx();
                var rowData = $("#grid").gfn_getDataRow(rowidx);
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

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_search") {
            var noticeList = data.resultNoticeList;
            console.log("noticeList : " + noticeList);
            var memoCnt = data.resultMemoCnt;
            var resultOrderShippingCnt = data.resultOrderShippingCnt;
            //그리드 데이터 바인딩
            $("#grid").gfn_setDataList(noticeList);
            // 메모 갯수 카운트.
            memoCnt.forEach(function(element, index, array) {
                if (element.DBN === "ALL") {
                    $("#allCnt").text(element.count);
                } else if (element.DBN === "NO") {
                    $("#noCnt").text(element.count);
                }
            });
            // 주문 배송 현황 카운트.
            resultOrderShippingCnt.forEach(function(element, index, array) {
                console.log(element);
                $("#totalCount").text(element.totalCount);
                $("#order").text(element.order);
                $("#warehouse").text(element.warehouse);
                $("#wareHousing").text(element.wareHousing);
                $("#shipped").text(element.shipped);
                $("#delivery").text(element.delivery);
                $("#delivered").text(element.delivered);
                $("#error").text(element.error);
            });
            // 숫자 카운트.
            $(".ct_count_numer").counterUp({
                delay : 5,
                time : 500
            });
        }
    }
    // 조회
    function getSearch() {
        gv_searchData = cfn_getFormData("frmSearch");
        var sid = "sid_search";
        var url = "/comm/getMainContentData.do";
        var sendData = {
            "paramData" : gv_searchData
        };
        gfn_sendData(sid, url, sendData);
    }
    // 공지 팝업 호출
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
        });
    }
    // 쿠키 등록
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
    // 메모 팝업 호출
    function openPopup(closeYn) {
        var width = "1000";
        var height = "690";
        var left = (window.screen.width / 2) - (width / 2);
        var top = (window.screen.height / 2) - (height / 2);
        var sOrgCd = $("#S_ORGCD").val() || "";
        var url = "/fulfillment/order/orderMemoListDtl/mainMemoView.do?closeYn=" + closeYn;
        var option = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top + ", resizable=no, scrollbars=no, menubar=no, location=no, status=no";
        var openWin = window.open(url, "로지포커스", option);
    }
    
    // 메인 화면 주문 배송 상태에 따른 기간 검색.
    function sendStatus(sStatusCd) {
        var sToDate = $("#sToDate").val();
        var sFromDate = $("#sFromDate").val();
        var jsonObj = {
                "sToDate" : sToDate,
                "sFromDate" : sFromDate,
                "sStatusCd" : sStatusCd
        }
        
        parent.add_tab2("/fulfillment/order/shippingList/view.do", "주문배송조회", "7", "10", "ShippingList", jsonObj, 2, 1, true);
    }
    
    // 배송비 계산.
    function shippingCharge() {
        var shippingType = $("input[name='shipMethodCd']:checked").val(); // 배송 구분.
        var zipCode = $("#zipCode").val(); // 우편번호.
        var premiumCountry = $("#premiumCountry").val(); // 프리미엄 국가.
        var dhlCountry = $("#dhlCountry").val(); // DHL 국가.
        var upsCountry = $("#upsCountry").val(); // UPS 국가.
        var wgt = $("#wgt").val(); // 무게.
        var width =  $("#width").val(); // 가로.
        var height = $("#height").val(); // 세로.
        var length = $("#length").val(); // 높이.
        
        if (premiumCountry == "" && dhlCountry == "" && upsCountry == "") {
            cfn_msg("WARNING", "국가를 선택하세요.");
            return false;
        }
        if (shippingType == "ups") {
            if (zipCode == "") {
                cfn_msg("WARNING", "우편번호를 입력하세요.");
                return false;
            }
        }
        if (wgt == "") {
            cfn_msg("WARNING", "무게를 입력하세요.");
            return false;
        }
        if (width == "") {
            cfn_msg("WARNING", "가로 길이를 입력하세요.");
            return false;
        }
        if (height == "") {
            cfn_msg("WARNING", "세로 길이를 입력하세요.");
            return false;
        }
        if (length == "") {
            cfn_msg("WARNING", "높이를 입력하세요.");
            return false;
        }
        
        var sendData = {
                "shippingType" : shippingType,
                "premiumCountry" : premiumCountry,
                "dhlCountry" : dhlCountry,
                "upsCountry" : upsCountry,
                "zipCode" : zipCode,
                "wgt" : wgt,
                "width" : width,
                "height" : height,
                "length" : length
        };
        
        $.ajax({
            url : "/comm/calc.do",
            type : "POST",
            contentType: "application/json",
            data : JSON.stringify(sendData),
            dataType : "json",
            success : function(data) {
                console.log(data);
                if (data.CODE == 1) {
                    $("#resultPrice").text(data.resultPrice + " 원");
                }else {
                    cfn_msg("WARNING", "고중량건은 관리자에게 문의하시기 바랍니다.");
                }
            },
            error : function(data) {
                alert("서버 오류");
            }
        });
    }
    
    // 중량 및 길이 체크.
    function isNumberKey(event) {
        var charCode = (event.which) ? event.which : event.keyCode;
        if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        // 현재 value값에 소수점(.)이 2개나 있으면 입력불가.
        var _value = event.srcElement.value;
        var _pattern0 = /^\d*[.]\d*$/; 
        if (_pattern0.test(_value)) {
            if (charCode == 46) {
                return false;
            }
        }
        // 중량 및 길이 크기 제한.
        $("#wgt").on("keyup", function() {
            if (this.value > 30) {
                this.value = 0;
                alert("최대 중량은 30kg 이하입니다.");
            }
        });
        $("#width").on("keyup", function() {
            if (this.value > 200) {
                this.value = 0;
                alert("최대 길이는 200cm 이하입니다.");
            }
        });
        $("#height").on("keyup", function() {
            if (this.value > 200) {
                this.value = 0;
                alert("최대 길이는 200cm 이하입니다.");
            }
        });
        $("#length").on("keyup", function() {
            if (this.value > 200) {
                this.value = 0;
                alert("최대 길이는 200cm 이하입니다.");
            }
        });
        
        // 소수점 둘째자리까지만 입력가능.
        var _pattern2 = /^\d*[.]\d{2}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
        if (_pattern2.test(_value)) {
            alert("소수점 둘째자리까지만 입력 가능합니다.");
            return false;
        }  
    }
</script>
<c:import url="/comm/contentBottom.do" />