<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst"%>
<!-- 
    화면코드 : AtomyStockInsert
    화면명   : 애터미 입고 등록.
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="livePackingForm" name="livePackingForm" action="POST">
        <input type="hidden" name="xrtInvcSno">
        <input type="hidden" id="orgcd" name="orgcd">
    </form>
    <form id="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" id="ordCd">
        <input type="hidden" id="eNation">
        <input type="hidden" id="shipMethodCd">
        <input type="hidden" id="paymentType">
        <input type="hidden" id="statusCd">
        <input type="hidden" id="boxNo">
        <ul class="sech_ul">
            <li class="sech_li required">
                <div style="width: 120px">XROUTE 송장번호</div>
                <div>
                    <input type="text" class="cmc_code required" id="xrtInvcSno" name="xrtInvcSno" maxlength="13" onkeyup="stringConvert()" tabindex="-1" style="width: 200px;">
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 120px">바코드 스캔 횟수</div>
                <div id="scanCnt" style="color: blue; margin-top: 3px;"></div>
            <li>
        </ul>
        <table style="margin: 10px 0;">
            <colgroup>
                <col width="130px" />
                <col width="200px" />
                <col width="130px" />
                <col width="200px" />
                <col width="130px" />
                <col width="200px" />
                <col width="130px" />
                <col width="200px" />
            </colgroup>
            <tbody>
                <tr style="height: 25px;">
                    <th style="text-align: left;">XROUTE송장번호</th>
                    <td>
                        <span id="txtXrtInvcSno" ></span>
                    </td>
                    <th>셀러 ID</th>
                    <td>
                        <span id="txtOrgCd" ></span>
                    </td>
                    <th>주문배송상태</th>
                    <td>
                        <span id="txtStatusNm" ></span>
                    </td>
                    <th>결제타입구분</th>
                    <td>
                        <span id="txtPaymentNm" ></span>
                    </td>
                </tr>
                <tr style="height: 25px;">
                    <th style="text-align: left">총수량 / 타입</th>
                    <td>
                        <span id="txtOrdCntShipMethodCd" ></span>
                    </td>
                    <th>도착 국가</th>
                    <td>
                        <span id="txtENation" ></span>
                    </td>
                    <th>오더등록일</th>
                    <td>
                        <span id="txtUploadDate" ></span>
                    </td>
                    <th>박스 정보</th>
                    <td>
                        <span id="txtBoxNo" ></span>
                    </td>
                </tr>
                <tr style="height: 25px;">
                    <th class="required" style="text-align: left;">중량</th>
                    <td colspan="6">
                        <input type="text" class="cmc_code" id="wgt" placeholder="KG">
                    </td>
                </tr>
                <tr style="height: 25px;">
                    <th class="required" style="text-align: left;">치수</th>
                    <td colspan="6">
                        <input type="text" class="cmc_code" id="boxWidth" placeholder="가로 Cm">
                        X
                        <input type="text" class="cmc_code" id="boxLength" placeholder="세로 Cm">
                        X
                        <input type="text" class="cmc_code" id="boxHeight" placeholder="높이 Cm">
                        <input type="button" class="cmb_normal_new cbtn_save" id="bthExam" value="검수" onclick="set();" style="min-width: 70px !important; text-align: right;" />
                        <input type="button" class="cmb_normal_new cbtn_save" id="btnSave" value="(용인)발송완료" onclick="setSave();" style="min-width: 130px !important; text-align: right;" />
                        <input type="button" class="cmb_normal_new cbtn_save" id="btnStockComp" value="(김포)입고완료" onclick="setStockComp();" style="min-width: 130px !important; text-align: right;" />
                        <input type="button" class="cmb_normal_new cbtn_cancel" id="btnStockCancel" value="(김포)입고취소" onclick="setCancel();" style="min-width: 130px !important; text-align: right;" />
                        <input type="button" class="cmb_normal_new cbtn_print" id="btnInvoice" value="     Invoice 출력" onclick="printing('invoice')" style="min-width: 70px !important; text-align: right;"/>
                    </td>
                </tr>
                <tr style="height: 25px;">
                    <th class="required" style="text-align: left;">부피 측정</th>
                    <td>
                        <span id="txtVolume" style="color: blue"></span>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
</div>
<!-- 그리드 시작 -->
<div class="ct_left_wrap fix" style="width: 700px;">
    <div id="goodsGrid"></div>
</div>
<div  class="ct_center_wrap" style="width: 470px;">
    <div id="stockGrid"></div>
</div>
<div class="ct_right_wrap" style="width: 473px;">
    <iframe src="/fulfillment/atomy/livePacking/view.do" id="atomyLivePacking" name="atomyLivePacking" style="width: 470px; height: 575px;"></iframe>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    var _SCAN = false;
    var _COUNT = 0;
    var usercd = "<c:out value='${usercd}'/>";
    
    $(function() {
        $(".cmc_code").keyup(function() {
            var wid = $("#boxWidth").val() || 0;
            var len = $("#boxLength").val() || 0;
            var hei = $("#boxHeight").val() || 0;
            result = wid * len * hei / 5000;
            $("#txtVolume").text(result.toFixed(2) + " (KG)");
        });
        // 1. 화면레이아웃 지정 (리사이징)
        initLayout();
        // 2. 그리드 초기화
        setGoodsData();
        setStockData();
        getStockList();
        scanCount();
        $("#xrtInvcSno").focus();
        $("#normal").hide();
        $("#abnormal").hide();
        $("#bthExam").hide();
        $("#btnSave").hide();
        $("#btnStockComp").hide();
        $("#btnStockCancel").hide();
        $("#btnInvoice").hide();
    });

    function setGoodsData() {
        var gid = "goodsGrid";
        var columns = [
         {
             name : "goodsNm",
             header : {
                 text : "상품명"
             },
             width : 500
         }, {
             name : "goodsCnt",
             header : {
                 text : "주문수량"
             },
             width : 158
         }
        ];

        // 그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false
        });

        // 그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            // 열고정 설정
            gridView.setFixedOptions({
                colCount : 2,
                resizable : false,
                colBarWidth : 1
            });
        });
    }

    function setStockData() {
        var gid = "stockGrid";
        var columns = [
            {
                name : "stockData",
                header : {
                    text : "애터미 역직구 금일 입고내역"
                },
                styles : {
                    textAlignment : "left"
                },
                width : 410
            }
        ];

        // 그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false
        });

        // 그리드설정 및 이벤트 처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            // 열고정 설정
            gridView.setFixedOptions({
                colCount : 2,
                resizable : false,
                colBarWidth : 1
            });
        });
    }

    // 한글 입력 -> 영문 변환
    function stringConvert() {

        var str = $("#xrtInvcSno").val();
        var convertStr = cfn_lngg_convert(str, "eng");

        if (window.event.keyCode == 13 && str != "9999" && _SCAN == false) {
            strVal = convertStr;

            $("#xrtInvcSno").val(convertStr.replace(/ /gi, ""));
            cfn_retrieve();
            _COUNT++;
            
            $("#xrtInvcSno").val("");
        } else if (str == "9999") {
            _SCAN = true;
            if (window.event.keyCode == 13 && _COUNT == 0) {
                cfn_save();
            }
            _COUNT++;
        }
    }
    
    

    // 공통버튼 - 초기화 클릭
    function cfn_init() {

        var prop = {
            "readonly" : false,
            "disabled" : false
        };

        $("#bthExam").hide();
        $("#btnSave").hide();
        $("#btnStockComp").hide();
        $("#btnStockCancel").hide();

        $("#alert").html("");
        $("#wgt").css({
            border : ""
        });
        $("#boxWidth").css({
            border : ""
        });
        $("#boxLength").css({
            border : ""
        });
        $("#boxHeight").css({
            border : ""
        });
        $("#txtVolume").text("");

        $("input[name='xrtInvcSno']").val("");
        $("input[name='clplXrtInvcSno']").val("");
        $("input[name='orgcd']").val("");
        $("#ordCd").val("");
        $("#eNation").val("");
        $("#statusCd").val("");
        $("#shipMethodCd").val("");
        $("#paymentType").val("");
        $("#boxWidth").val("");
        $("#boxLength").val("");
        $("#boxHeight").val("");
        $("#boxNo").val("");
        $("#wgt").val("");
        $("#txtXrtInvcSno").text("");
        $("#txtUploadDate").text("");
        $("#txtOrgCd").text("");
        $("#txtENation").text("");
        $("#txtBoxNo").text("");
        $("#txtOrdCntShipMethodCd").text("");
        $("#txtStatusNm").text("");
        $("#txtPaymentNm").text("");

        $("#wgt").removeClass("disabled").prop(prop);
        $("#boxWidth").removeClass("disabled").prop(prop);
        $("#boxLength").removeClass("disabled").prop(prop);
        $("#boxHeight").removeClass("disabled").prop(prop);
        
        _COUNT = 0;
        $("#scanCnt").text(_COUNT);
    }

    // 공통버튼 - 검색 클릭
    function cfn_retrieve() {

        $("#alert").html("");
        $("#wgt").css({
            border : ""
        });
        $("#boxWidth").css({
            border : ""
        });
        $("#boxLength").css({
            border : ""
        });
        $("#boxHeight").css({
            border : ""
        });

        var param = cfn_getFormData("frmSearch");
        var sid = "sid_search";
        var url = "/fulfillment/atomy/stockInsert/getSearch.do";
        var sendData = {
            "xrtInvcSno" : $("#xrtInvcSno").val()
        };
        gfn_sendData(sid, url, sendData, true);

        $("#ordCd").val("");
        $("#eNation").val("");
        $("#shipMethodCd").val("");
        $("#paymentType").val("");
        $("input[name='xrtInvcSno']").val("");
        $("input[name='orgcd']").val("");

        $("#bthExam").hide();
        $("#btnSave").hide();
        $("#btnStockComp").hide();
        $("#btnStockCancel").hide();
        $("#btnInvoice").hide();
        
        $("#scanCnt").text(_COUNT);
    }

    // 발송완료 클릭(용인센터 - 발송완료)
    function setSave() {
        if (cfn_isFormRequireData("frmSearch") == false) {
            return;
        }
        
        // 용인센터 검수 스캔 완료한 송장번호 인지 확인.
        var xrt_invc_sno = $("#frmSearch").find("#xrtInvcSno").val();
        console.log(xrt_invc_sno);
        
        var urls = "/fulfillment/atomy/stockInsert/checkInspection.do";
        
        var sendData = {
                "xrtInvcSno" : xrt_invc_sno
        };
        
        $.ajax({
            url : urls,
            type : "POST",
            data : JSON.stringify(sendData),
            contentType: "application/json",
            success : function(data) {
                if (data.code == "Y") {
                    var xrtInvcSno = $("#livePackingForm").find("input[name='xrtInvcSno']").val();
                    var orgcd = $("#livePackingForm").find("input[name='orgcd']").val();
                    
                    var iframes = document.getElementById("atomyLivePacking");
                    var result = iframes.contentWindow.save();
                    
                    var param = cfn_getFormData("frmSearch");
                    var sid = "sid_setSave";
                    var url = "/fulfillment/atomy/stockInsert/setSave.do";

                    gfn_sendData(sid, url, param, true);
                    
                    _COUNT = 0;
                    $("#scanCnt").text(_COUNT);
                    // $("#xrtInvcSno").focus();
                } else {
                    cfn_msg("WARNING", "검수 스캔을 완료하지 않은 송장번호입니다.");
                }
            },
            error : function(data) {
                loadingEnd();
                cfn_msg("ERROR", "발송처리 에러");
            }
        });
    }
    
    // 김포센터 자동 입고 완료 처리.
    function stockComp(strVal) {
        var url = "/fulfillment/atomy/stockInsert/checkSendingComp.do";
      
        var sendData = {
                "xrtInvcSno" : strVal
        };
        
        $.ajax({
            url : url,
            type : "POST",
            data : JSON.stringify(sendData),
            contentType: "application/json",
            success : function(data) {
                console.log(data.statusCd);
                if (data.statusCd == "12") {
                    $("#xrtInvcSno").focus();
                } else {
                    cfn_msg("WARNING", "Code : " + data.code + "\nMessage : " + data.message);
                }
            },
            error : function(data) {
                loadingEnd();
                cfn_msg("ERROR", "입고처리 오류");
            }
        });
        
        $("#xrtInvcSno").focus();
    }

    // 김포센터 입고완료 클릭
    function setStockComp() {
        if (cfn_isFormRequireData("frmSearch") == false) {
            return;
        }

        var param = cfn_getFormData("frmSearch");
        var sid = "sid_stockComp";
        var url = "/fulfillment/atomy/stockInsert/setStockComp.do";

        gfn_sendData(sid, url, param, true);
        _COUNT = 0;
        $("#scanCnt").text(_COUNT);
        
        $("#xrtInvcSno").focus();
    }

    // 김포센터 입고취소 클릭
    function setCancel() {
        if (cfn_isFormRequireData("frmSearch") == false) {
            return;
        }

        if (confirm("입고취소 처리를 하시겠습니까?") == true) {
            var param = cfn_getFormData("frmSearch");
            var sid = "sid_cancel";
            var url = "/fulfillment/atomy/stockInsert/setCancel.do";
            gfn_sendData(sid, url, param, true);
        }
        _COUNT = 0;
        $("#scanCnt").text(_COUNT);
        
        $("#xrtInvcSno").focus();
    }

    // 입고내역 히스토리
    function getStockList() {
        var param = cfn_getFormData("frmSearch");
        var sid = "sid_stockList";
        var url = "/fulfillment/atomy/stockInsert/getStockList.do";

        gfn_sendData(sid, url, param, true);
    }

    // 요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        var propFalse = {
            "readonly" : false,
            "disabled" : false
        };
        // 검색
        if (sid == "sid_search") {
            if (cfn_isEmpty(data)) {
                cfn_msg("WARNING", "검색결과가 존재하지 않습니다.");
                return false;
            }
            if (data.resultData.statusCd == "10") {
                // 무게 입력
                $("#wgt").removeClass("disabled").prop(propFalse);
                // 박스 사이즈 입력
                $("#boxWidth").removeClass("disabled").prop(propFalse);
                $("#boxLength").removeClass("disabled").prop(propFalse);
                $("#boxHeight").removeClass("disabled").prop(propFalse);
            }
            $("#goodsGrid").gfn_setDataList(data.resultList);
            $("#goodsGrid").gfn_focusPK();
            $("#alert").html("");
            setOrderData(data.resultData);
            getStockList();

            if (data.resultData.statusCd == "10" || data.resultData.statusCd == "11") {
                if (typeof navigator.mediaDevices != "undefined") {
                    var iframeAtomy = document.getElementById("atomyLivePacking");
                    iframeAtomy.contentWindow.startFunction();
                }
                $("#wgt").focus();
            } else {
                $("#xrtInvcSno").focus();
            }

            volumeResult();
        } else if (sid == "sid_setSave") {
            cfn_init();
            $("#xrtInvcSno").focus();
            _SCAN = false;
        } else if (sid == "sid_stockComp" || sid == "sid_cancel") {
            _SCAN = false;
            $("#goodsGrid").dataProvider().clearRows();
            cfn_init();
            getStockList();
        } else if (sid == "sid_stockList") {
            $("#stockGrid").gfn_setDataList(data.resultList);
        }
    }

    function setOrderData(data) {
        var propFalse = {
            "readonly" : false,
            "disabled" : false
        };
        var propTrue = {
            "readonly" : true,
            "disabled" : true
        };
        if (data != null) {
            $("input[name='xrtInvcSno']").val(data.xrtInvcSno);
            $("input[name='orgcd']").val(data.orgcd);
            $("#ordCd").val(data.ordCd);
            $("#txtXrtInvcSno").text(data.xrtInvcSno);
            $("#eNation").val(data.eNation); //도착국가
            $("#statusCd").val(data.statusCd);
            $("#shipMethodCd").val(data.shipMethodCd);
            $("#paymentType").val(data.paymentType);
            $("#boxWidth").val(data.boxWidth);
            $("#boxLength").val(data.boxLength);
            $("#boxHeight").val(data.boxHeight);
            $("#boxNo").val(data.boxNo);
            $("#wgt").val(data.wgt);
            $("#txtUploadDate").text(cfn_getDateFormat(data.uploadDate, "yyyy-MM-dd"));
            $("#txtOrgCd").text(data.orgcd);
            $("#txtENation").text(data.eNation);
            $("#txtBoxNo").text(data.boxNo);
            $("#txtOrdCntShipMethodCd").text(data.ordCnt + " / " + data.shipMethodCd);
            $("#txtStatusNm").text(data.statusNm);
            $("#txtPaymentNm").text(data.paymentNm);
            $("#scanCnt").text(_COUNT);

            if (data.statusCd == "10") { // 주문 등록 상태.
                $("#btnSave").hide();
                $("#btnStockComp").hide();
                $("#btnStockCancel").hide();
                $("#btnInvoice").hide();

                $("#wgt").removeClass("disabled").prop(propFalse);
                $("#boxWidth").removeClass("disabled").prop(propFalse);
                $("#boxLength").removeClass("disabled").prop(propFalse);
                $("#boxHeight").removeClass("disabled").prop(propFalse);
            } else if (data.statusCd == "11") { // 발송대기 상태.
                $("#btnSave").show();
                $("#btnStockComp").hide();
                $("#btnStockCancel").hide();
                $("#btnInvoice").hide();
                
                $("#wgt").addClass("disabled").prop(propTrue);
                $("#boxWidth").addClass("disabled").prop(propTrue);
                $("#boxLength").addClass("disabled").prop(propTrue);
                $("#boxHeight").addClass("disabled").prop(propTrue);
            } else if (data.statusCd == "12") { // 발송완료 상태.
                $("#btnSave").hide();
                
                if (usercd == "YICENTER1") {
                    $("#btnStockComp").hide();
                    $("#btnStockCancel").hide();
                    $("#btnInvoice").hide();
                }else {
	                $("#btnStockComp").show();
	                $("#btnStockCancel").hide();
	                $("#btnInvoice").hide();
                }
                
                $("#wgt").addClass("disabled").prop(propTrue);
                $("#boxWidth").addClass("disabled").prop(propTrue);
                $("#boxLength").addClass("disabled").prop(propTrue);
                $("#boxHeight").addClass("disabled").prop(propTrue);
            } else if (data.statusCd == "30") { // 입고 완료 상태.
                if (usercd == "YICENTER1") {
                    $("#btnSave").hide();
                    $("#btnStockComp").hide();
                    $("#btnStockCancel").hide();
                    $("#btnInvoice").hide();
                }
            
                $("#btnSave").hide();
                $("#btnStockComp").hide();
                $("#btnStockCancel").show();
                $("#btnInvoice").show();
                
                $("#wgt").addClass("disabled").prop(propTrue);
                $("#boxWidth").addClass("disabled").prop(propTrue);
                $("#boxLength").addClass("disabled").prop(propTrue);
                $("#boxHeight").addClass("disabled").prop(propTrue);
            } else if (data.statusCd == "95") { // 입고 취소 상태.
                if (usercd == "YICENTER1") {
                    $("#btnSave").hide();
                    $("#btnStockComp").hide();
                    $("#btnStockCancel").hide();
                    $("#btnInvoice").hide();
                }
            
                $("#btnSave").hide();
                $("#btnStockComp").show();
                $("#btnStockCancel").hide();
                $("#btnInvoice").hide();

                $("#wgt").addClass("disabled").prop(propTrue);
                $("#boxWidth").addClass("disabled").prop(propTrue);
                $("#boxLength").addClass("disabled").prop(propTrue);
                $("#boxHeight").addClass("disabled").prop(propTrue);
            } else {
                $("#btnSave").hide();
                $("#btnStockComp").hide();
                $("#btnStockCancel").hide();
                $("#btnInvoice").hide();

                $("#wgt").addClass("disabled").prop(propTrue);
                $("#boxWidth").addClass("disabled").prop(propTrue);
                $("#boxLength").addClass("disabled").prop(propTrue);
                $("#boxHeight").addClass("disabled").prop(propTrue);
            }
        }
    }

    // 부피 측정 (가로 * 세로  * 높이)
    function volumeResult() {
        var wid = $("#boxWidth").val() || 0;
        var len = $("#boxLength").val() || 0;
        var hei = $("#boxHeight").val() || 0;
        var result = wid * len * hei / 5000;
        $("#txtVolume").text(result.toFixed(2) + " (Kg)");
    }
    
    // 바코드 스캔 횟수
    function scanCount() { 
        $("#scanCnt").text(_COUNT);
    }
    
    // Commercial Invoice 출력.
    function printing(type) {
        var name = "";
        var xrtInvcSno = $("#xrtInvcSno").val(); // 송장번호.
        var params = {
            "xrtInvcSno" : xrtInvcSno
        }
        
        if (type == "invoice") {
            name = "ATOMY_STOCK_INVOICE_PACKING_LIST";
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
</script>
<c:import url="/comm/contentBottom.do" />