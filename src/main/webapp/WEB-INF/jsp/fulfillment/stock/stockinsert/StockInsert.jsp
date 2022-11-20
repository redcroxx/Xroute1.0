<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
    화면코드 : StockInsert
    화면명 : 입고스캔
-->
<c:import url="/comm/contentTop.do">
    <c:param name="fixedTab" value="3" />
</c:import>
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="livePackingForm" name="livePackingForm" action="POST">
        <input type="hidden" name="xrtInvcSno">
        <input type="hidden" name="orgcd">
    </form>
    <form id="frmSearch" action="#" onsubmit="return false">
        <ul class="sech_ul">
            <li class="sech_li required">
                <div style="width: 120px">XROUTE 송장번호</div>
                <div>
                    <input type="text" class="cmc_code required" id="XRT_INVC_NO" maxlength="13" onkeyup="fn_str_convert()" tabindex="-1" style="width: 200px;">
                </div>
            </li>
        </ul>
    </form>
    <!-- 송장 정보 -->
    <form id="frmSongjang" style="padding-left: 10px;" action="#" onsubmit="return false">
        <input type="hidden" id="ORD_CD">
        <input type="hidden" id="INVC_SNO">
        <input type="hidden" id="WGT_ST_CD">
        <input type="hidden" id="E_NATION">
        <input type="hidden" id="SHIP_METHOD_CD">
        <input type="hidden" id="PAYMENT_TYPE">
        <input type="hidden" id="STATUS_CD">
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
                <tr>
                    <th style="text-align: left;">XROUTE송장번호</th>
                    <td>
                        <span id="xrouteCd"></span>
                    </td>
                    <th>셀러 ID</th>
                    <td>
                        <span id="lbOrgCd"></span>
                    </td>
                    <th>주문배송상태</th>
                    <td>
                        <span id="krStatusCd"></span>
                    </td>
                    <th>결제타입구분</th>
                    <td>
                        <span id="krPaymentType"></span>
                    </td>
                </tr>
                <tr>
                    <th style="text-align: left">총수량 / 타입</th>
                    <td>
                        <span id="lbOrdCntType"></span>
                    </td>
                    <th>도착 국가</th>
                    <td>
                        <span id="lbENation"></span>
                    </td>
                    <th>오더등록일</th>
                    <td>
                        <span id="lbUploadDate"></span>
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="margin: 10px 0;">
            <colgroup>
                <col width="100px" />
                <col width="100px" />
            </colgroup>
            <tbody>
                <tr>
                    <th class="required" style="text-align: left;">무게</th>
                    <td>
                        <input type="text" id="WGT" placeholder="KG" class="cmc_code required" onfocus="onfocus_event();" onblur="onblur_evnet();" tabindex="2">
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="margin: 10px 0;">
            <colgroup>
                <col width="100px" />
                <col width="*" />
                <col width="100px" />
                <col width="100px" />
                <col width="100px" />
                <col width="100px" />
            </colgroup>
            <tbody>
                <tr>
                    <th class="required" style="text-align: left;">치수</th>
                    <td>
                        <input type="text" class="cmc_code" id="BOX_WIDTH" placeholder="가로 Cm">
                        X
                        <input type="text" class="cmc_code" id="BOX_LENGTH" placeholder="세로 Cm">
                        X
                        <input type="text" class="cmc_code" id="BOX_HEIGHT" placeholder="높이 Cm">
                    </td>
                    <th>
                        <div id="div_var_reset" style="margin: 0 0 0 10px;">
                            <input type="button" class="cmb_normal_new cbtn_cancel" value="초기화" onclick="varReset(); this.onclick=null;" style="min-width: 80px !important; text-align: right;">
                        </div>
                    </th>                    
                    <th>
                        <div id="div_save" style="margin: 0 0 0 10px;">
                            <input type="button" class="cmb_normal_new cbtn_save" value="저장" onclick="cfn_save(); this.onclick=null;" style="min-width: 70px !important; text-align: right;">
                        </div>
                    </th>
                    <th>
                        <div id="div_payment_stock_cancle">
                            <input type="button" class="cmb_normal_new cbtn_cancel" value="취소" onclick="cfn_pmCancle(); this.onclick=null;" style="min-width: 70px !important; text-align: right;">
                        </div>
                    </th>
                    <th>
                        <div id="div_invc_print">
                            <input type="button" class="cmb_normal_new cbtn_stock_print" value="송장출력" onclick="songjang_print(); this.onclick=null;" style="min-width: 100px !important; text-align: right;">
                        </div>
                    </th>
                    <th>
                        <div id="div_stock_cancle">
                            <input type="button" class="cmb_normal_new cbtn_cancel" value="입고취소" onclick="cfn_cancle(); this.onclick=null;" style="min-width: 100px !important; text-align: right;">
                        </div>
                    </th>
                    <th>
                        <div id="div_regular_pay">
                            <input type="button" class="cmb_normal_new cbtn_save" value="정기결제" onclick="regularPay(); this.onclick=null;" style="min-width: 100px !important; text-align: right;">
                        </div>
                    </th>
                    <th>
                        <div id="div_stock_completion">
                            <input type="button" class="cmb_normal_new cbtn_save" value="입고완료" onclick="cfn_completion(); this.onclick=null;" style="min-width: 100px !important; text-align: right;">
                        </div>
                    </th>
                </tr>
            </tbody>
        </table>
        <table style="margin: 10px 0;">
            <colgroup>
                <col width="100px" />
                <col width="200px" />
            </colgroup>
            <tbody>
                <tr>
                    <th class="required" style="text-align: left;">부피 측정</th>
                    <td>
                        <div id="volume" style="color: blue"></div>
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="margin: 10px 0;">
            <colgroup>
                <col width="100px" />
                <col width="200px" />
            </colgroup>
            <tbody>
                <tr>
                    <th class="required" style="text-align: left;">송장번호</th>
                    <td>
                        <span id="lbInvcSno1"></span>
                    </td>
                </tr>
            </tbody>
        </table>
        <p>
            <font color="#FF000">※저장후, 30분 이후부터는 입고취소가 불가합니다.</font>
        </p>
    </form>
    <!-- 송장정보 끝 -->
</div>
<!-- 그리드 시작 -->
<div class="ct_left_wrap fix" style="width: 75%;">
    <div id="grid1"></div>
</div>
<div class="ct_right_wrap">
    <div id="grid2"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    var scan = false;
    var LIVE_PACKING_POPUP;
    var _COUNT = 0;

    //초기 로드
    $(function() {
        // 부피 측정 (가로 * 세로  * 높이) / 6000
        $(".cmc_code").keyup(function() {
            var wid = $("#BOX_WIDTH").val() || 0;
            var len = $("#BOX_LENGTH").val() || 0;
            var hei = $("#BOX_HEIGHT").val() || 0;
            result = wid * len * hei / 6000;
            $("#volume").text(result.toFixed(2) + " (KG)");
        });
        //1. 화면레이아웃 지정 (리사이징) 
        initLayout();
        //2. 그리드 초기화
        grid1_Load();
        grid2_Load();
        cfn_getWarehousing();
        $("#XRT_INVC_NO").focus();
        $("#div_stock_completion").hide();
        $("#div_regular_pay").hide();
        $("#div_payment_stock_cancle").hide();
        $("#div_invc_print").hide();
        $("#div_stock_cancle").hide();
        $("#div_save").hide();
    });

    var playAlert;
    //onfocus 실행
    function onfocus_event() {
        var strStCd = $("#WGT_ST_CD").val();
        var usergroup = "<c:out value='${sessionScope.loginVO.usergroup}' />";
        if (usergroup == "<c:out value='${userGroupMap.centerUser}' />") {
            if (strStCd == "<c:out value='${statusMap.orderApply}' />") {
                var strInvcNo = $("#INVC_SNO").val();
                if (strInvcNo.length > 0) {
                    startAlert();
                }
            } else {
                $("#XRT_INVC_NO").focus();
            }
        }
    }

    function onblur_evnet() {
        var strWgt = $("#WGT_ST_CD").val();
        var usergroup = "<c:out value='${sessionScope.loginVO.usergroup}' />";
        if (usergroup == "<c:out value='${userGroupMap.centerUser}' />") {
            if (strWgt == "<c:out value='${statusMap.orderApply}' />") {
                stopAlert();
            }
        }
    }

    //무게측정값 취득처리 Start
    function startAlert() {
        playAlert = setInterval(function() {
            cfn_getWgt();
        }, 1000);
    }

    //무게측정값 취득처리 Stop
    function stopAlert() {
        if (playAlert != "undefined") {
            clearInterval(playAlert);
        }
    }

    function grid1_Load() {
        var gid = "grid1";
        var columns = [
                {
                    name : "GOODS_NM",
                    header : {
                        text : "상품명"
                    },
                    width : 400
                }, {
                    name : "GOODS_OPTION",
                    header : {
                        text : "옵션정보"
                    },
                    width : 200
                }, {
                    name : "GOODS_CNT",
                    header : {
                        text : "주문수량"
                    },
                    width : 150
                }
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false
        });

        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            // gridView.setStyles(basicBlackSkin);
            //열고정 설정
            gridView.setFixedOptions({
                colCount : 2,
                resizable : true,
                colBarWidth : 1
            });

        });
    }

    function grid2_Load() {
        var gid = "grid2";
        var columns = [
            {
                name : "INVC_SNO_HISTORY",
                header : {
                    text : "금일 입고내역"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 300
            }
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false
        });

        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            // gridView.setStyles(basicBlackSkin);
            //열고정 설정
            gridView.setFixedOptions({
                colCount : 2,
                resizable : true,
                colBarWidth : 1
            });
        });
    }

    //한글 입력 -> 영문 변환
    function fn_str_convert() {

        var str = $("#XRT_INVC_NO").val();
        var convertStr = cfn_lngg_convert(str, "eng");

        if (window.event.keyCode == 13 && str != "9999" && scan == false) {
            strVal = convertStr;

            $("#XRT_INVC_NO").val(convertStr.replace(/ /gi, ""));
            cfn_retrieve();

            $("#XRT_INVC_NO").val("");
        } else if (str == "9999") {
            scan = true;
            if (window.event.keyCode == 13 && _COUNT == 0) {
                cfn_save();
            }
            
            _COUNT++;
        }
    }

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        if (scan == false && cfn_isFormRequireData("frmSearch") == false) {
            return;
        }
        $("#alert").html("");
        $("#WGT").css({
            border : ""
        });
        $("#BOX_WIDTH").css({
            border : ""
        });
        $("#BOX_LENGTH").css({
            border : ""
        });
        $("#BOX_HEIGHT").css({
            border : ""
        });

        var param = cfn_getFormData("frmSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/stock/stockInsert/getSearch.do";
        var sendData = {
            "paramData" : param
        };
        gfn_sendData(sid, url, sendData, true);

        $("#ORD_CD").val("");
        $("#INVC_SNO").val("");
        $("#WGT_ST_CD").val("");
        $("#E_NATION").val("");
        $("#SHIP_METHOD_CD").val("");
        $("#PAYMENT_TYPE").val("");
        $("#lbInvcSno1").text("");
        $("input[name='xrtInvcSno']").val("");
        $("input[name='orgcd']").val("");

    }

    // 송장출력버튼 클릭
    function songjang_print() {
        if ($("#xrouteCd").text() == "") {
            cfn_msg("WARNING", "선택된 송장이 없습니다.");
            return false;
        } else {
            var param = cfn_getFormData("frmSongjang");
            var sid = "sid_print";
            var url = "/fulfillment/stock/stockInsert/print.do";
            var sendData = {
                "paramData" : param
            };
            gfn_sendData(sid, url, sendData, false);
        }
    }

    //공통버튼 - 저장 클릭
    function cfn_save() {
        if (cfn_isFormRequireData("frmSongjang") == false) {
            return;
        }
        var param = cfn_getFormData("frmSongjang");
        var sid = "sid_setSave";
        var url = "/fulfillment/stock/stockInsert/setSave.do";
        var sendData = {
            "paramData" : param
        };
        gfn_sendData(sid, url, sendData, true);
    }

    // 입고취소 클릭
    function cfn_cancle() {
        if (cfn_isFormRequireData("frmSongjang") == false) {
            return;
        }

        if (confirm("입고취소 처리를 하시겠습니까?") == true) {
            var param = cfn_getFormData("frmSongjang");
            var sid = "sid_cancel";
            var url = "/fulfillment/stock/stockInsert/setCancel.do";
            var sendData = {
                "paramData" : param
            };
            gfn_sendData(sid, url, sendData, true);
        }
        // hidden값 null처리
    }

    // 취소 클릭
    function cfn_pmCancle() {
        if (cfn_isFormRequireData("frmSongjang") == false) {
            return;
        }
        if (confirm($("#krStatusCd").text() + "상태 입니다. 취소 처리를 하시겠습니까?") == true) {
            var param = cfn_getFormData("frmSongjang");
            var sid = "sid_pmCancel";
            var url = "/fulfillment/stock/stockInsert/setPmCancel.do";
            var sendData = {
                "paramData" : param
            };
            gfn_sendData(sid, url, sendData, true);
        }
    }

    // 입고완료 클릭
    function cfn_completion() {
        if (cfn_isFormRequireData("frmSongjang") == false) {
            return;
        }

        var param = cfn_getFormData("frmSongjang");
        var sid = "sid_completion";
        var url = "/fulfillment/stock/stockInsert/setCompletion.do";
        var sendData = {
            "paramData" : param
        };
        gfn_sendData(sid, url, sendData, true);
    }

    // 정기결제
    function regularPay() {
        if (cfn_isFormRequireData("frmSongjang") == false) {
            return;
        }

        var param = cfn_getFormData("frmSongjang");
        var sid = "sid_regularPay";
        var url = "/sys/passBook/regularPayment.do";
        var sendData = {
            "xrtInvcSno" : $("input[name='xrtInvcSno']").val() || "",
            "orgcd" : $("input[name='orgcd']").val() || ""
        };
        gfn_sendData(sid, url, sendData, true);
    }

    // 무게값 취득
    function cfn_getWgt() {
        var param = cfn_getFormData("frmSongjang");
        var sid = "sid_getWgt";
        var url = "/fulfillment/stock/stockInsert/getWgt.do";
        var sendData = {
            "paramData" : param
        };
        gfn_sendData(sid, url, sendData, true);
    }

    // 입고내역 히스토리
    function cfn_getWarehousing() {
        var param = cfn_getFormData("frmSongjang");
        var sid = "sid_getWarehousing";
        var url = "/fulfillment/stock/stockInsert/getWarehousing.do";
        var sendData = {
            "paramData" : param
        };
        gfn_sendData(sid, url, sendData, true);
    }

    function livePackingPopup() {
        if (LIVE_PACKING_POPUP !== undefined) {
            LIVE_PACKING_POPUP.close();
        }

        var url = "/livePacking/view.do";
        var status = "menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes";
        LIVE_PACKING_POPUP = window.open("", "LivePacking", status);

        $("#livePackingForm").prop("action", url);
        $("#livePackingForm").prop("target", "livePackingForm");
        $("#livePackingForm").prop("method", "post");
        $("#livePackingForm").submit();
    }

    function livePackingReset() {
        LIVE_PACKING_POPUP = undefined;
    }

    // 요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        var propFalse = {
            "readonly" : false,
            "disabled" : false
        };
        //검색
        if (sid == "sid_getSearch") {
            if (cfn_isEmpty(data)) {
                cfn_msg("WARNING", "검색결과가 존재하지 않습니다.");
                return false;
            }
            if (data.resultData.STATUS_CD == "10") {
                //무게 입력
                $("#WGT").removeClass("disabled").prop(propFalse);
                //박스 사이즈 입력
                $("#BOX_WIDTH").removeClass("disabled").prop(propFalse);
                $("#BOX_LENGTH").removeClass("disabled").prop(propFalse);
                $("#BOX_HEIGHT").removeClass("disabled").prop(propFalse);
            }
            $("#grid1").gfn_setDataList(data.resultList);
            $("#grid1").gfn_focusPK();
            $("#alert").html('');
            cfn_outPutData(data.resultData);
            cfn_getWarehousing();

            if (data.resultData.STATUS_CD == "10") {
                 /* if (typeof navigator.mediaDevices != "undefined") {
                     livePackingPopup();
                 } */

                $("#WGT").focus();
            } else {
                $("#XRT_INVC_NO").focus();
            }

            volumeResult();
        } else if (sid == "sid_print") {
            print(data.resultData);
        } else if (sid == "sid_setSave" || sid == "sid_completion") {

            if (typeof navigator.mediaDevices != "undefined") {
                if (LIVE_PACKING_POPUP !== undefined) {
                    LIVE_PACKING_POPUP.save();
                }
            }

            var eNation = data.orderData.E_NATION.toUpperCase();
            var shipMethodCd = data.orderData.SHIP_METHOD_CD.toUpperCase();
            var xrtNo = $("#INVC_SNO").val() || "";
            if (eNation == "US" && shipMethodCd == "PREMIUM") {
                // STATUS_CD가 입고(30)상태일때 송장 출력 가능 20200210최일규
                if (data.orderData.STATUS_CD == "30") {
                    songjang_print();
                    window.location.reload();
                    $("#XRT_INVC_NO").focus();
                    _COUNT = 0;
                    scan = false;
                } else {
                    if (xrtNo != "") {
                        $("#XRT_INVC_NO").val(xrtNo);
                    }
                    cfn_retrieve();
                    $("#XRT_INVC_NO").val("");
                    cfn_getWarehousing();
                    _COUNT = 0;
                    scan = false;
                }
            } else {
                if (data.orderData.STATUS_CD != "30") {
                    if (xrtNo != "") {
                        $("#XRT_INVC_NO").val(xrtNo);
                    }
                    cfn_retrieve();
                    $("#XRT_INVC_NO").val("");
                    cfn_getWarehousing();
                    _COUNT = 0;
                    scan = false;
                } else {
                    window.location.reload();
                    if (xrtNo != "") {
                        $("#XRT_INVC_NO").val(xrtNo);
                    }
                    cfn_retrieve();
                    $("#XRT_INVC_NO").focus();
                    _COUNT = 0;
                    scan = false;
                }
            }
        } else if (sid == "sid_cancel" || sid == "sid_pmCancel") {
            window.location.reload();
        } else if (sid == "sid_regularPay") {
            $("#XRT_INVC_NO").val($("input[name='xrtInvcSno']").val() || "");
            cfn_retrieve();
        } else if (sid == "sid_getWgt") {
            cfn_wgtOutPutData(data.resultData);
        } else if (sid == "sid_getWarehousing") {
            $("#grid2").gfn_setDataList(data.resultList);
        }
    }

    // 송장출력
    function print(data) {
        var print1 = cfn_printInfo().PRINT1;
        var xrouteSno = data.XRT_INVC_SNO;
        var eNation = data.E_NATION;
        var wgt = data.WGT;
        var shipMethodCd = data.SHIP_METHOD_CD;

        xrouteSno = xrouteSno.toString();
        if (wgt == null || wgt == "") {
            cfn_msg("WARNING", "무게값이 없습니다.");
            return false;
        } else {
            if (wgt < "0.3685") {
                rfn_reportLabel({
                    title : "songjangF",
                    jrfName : "STOCK_INSERT_F",
                    args : {
                        "XRT_INVC_SNO" : xrouteSno
                    }
                });
            } else {
                rfn_reportLabel({
                    title : "songjangP",
                    jrfName : "STOCK_INSERT_P",
                    args : {
                        "XRT_INVC_SNO" : xrouteSno
                    }
                });
            }
            //window.location.reload();
        }
    }

    /**
     * form태그 데이터 바인딩
     * @param {String} formid : Form태그 ID
     * @param {Json} data : 바인딩데이터
     */
    function cfn_outPutData(data) {
        var propFalse = {
            "readonly" : false,
            "disabled" : false
        };
        var propTrue = {
            "readonly" : true,
            "disabled" : true
        };
        if (data != null) {
            $("#ORD_CD").val(data.ORD_CD); //오더넘버
            $("#xrouteCd").text(data.XRT_INVC_SNO); //XROUTE송장번호
            $("#INVC_SNO").val(data.XRT_INVC_SNO); //XROUTE 송장번호 Hid
            $("#H_XRT_INVC_NO").val(data.XRT_INVC_SNO) // 검색 form xroute hidden
            $("#WGT_ST_CD").val(data.STATUS_CD); //
            $("#lbUploadDate").text(cfn_getDateFormat(data.UPLOAD_DATE, "yyyy-MM-dd"));
            $("#lbOrgCd").text(data.ORGCD); //
            $("#lbENation").text(data.E_NATION); //
            $("#WGT").val(data.WGT); //무게
            $("#BOX_WIDTH").val(data.BOX_WIDTH); //가로
            $("#BOX_LENGTH").val(data.BOX_LENGTH); //세로
            $("#BOX_HEIGHT").val(data.BOX_HEIGHT); //높이
            $("#lbOrdCntType").text(data.ORD_CNT + " / " + data.SHIP_METHOD_CD); //
            $("#STATUS_CD").val(data.STATUS_CD); //
            $("#krStatusCd").text(data.KR_STATUS_CD); //
            $("#krPaymentType").text(data.KR_PAYMENT_TYPE); //
            $("#SHIP_METHOD_CD").val(data.SHIP_METHOD_CD); //배송타입
            $("#PAYMENT_TYPE").val(data.PAYMENT_TYPE); //결제타입
            $("#E_NATION").val(data.E_NATION); //도착국가
            $("#XRT_SHIPPING_PRICE").val(data.XRT_SHIPPING_PRICE);
            $("input[name='xrtInvcSno']").val(data.XRT_INVC_SNO);
            $("input[name='orgcd']").val(data.ORGCD);

            // 주문상태에 따른 버튼 표시 20200210최일규
            if (data.STATUS_CD == "10") {
                $("#div_payment_stock_cancle").hide();
                $("#div_regular_pay").hide();
                $("#div_stock_completion").hide();
                $("#div_stock_cancle").hide();
                $("#div_invc_print").hide();
                $("#div_save").show();

                $("#WGT").removeClass("disabled").prop(propFalse);
                $("#BOX_WIDTH").removeClass("disabled").prop(propFalse);
                $("#BOX_LENGTH").removeClass("disabled").prop(propFalse);
                $("#BOX_HEIGHT").removeClass("disabled").prop(propFalse);
            } else if (data.STATUS_CD == "20") {
                if ($("#PAYMENT_TYPE").val() == "3") {
                    $("#div_regular_pay").show();
                } else {
                    $("#div_regular_pay").hide();
                }
                //저장버튼
                $("#div_payment_stock_cancle").show();
                $("#div_stock_completion").hide();
                $("#div_stock_cancle").hide();
                $("#div_invc_print").hide();
                $("#div_save").hide();

                $("#WGT").addClass("disabled").prop(propTrue);
                $("#BOX_WIDTH").addClass("disabled").prop(propTrue);
                $("#BOX_LENGTH").addClass("disabled").prop(propTrue);
                $("#BOX_HEIGHT").addClass("disabled").prop(propTrue);
            } else if (data.STATUS_CD == "21") {
                $("#div_payment_stock_cancle").show();
                $("#div_regular_pay").hide();
                $("#div_stock_completion").show();
                $("#div_stock_cancle").hide();
                $("#div_invc_print").hide();
                $("#div_save").hide();

                $("#WGT").addClass("disabled").prop(propTrue);
                $("#BOX_WIDTH").addClass("disabled").prop(propTrue);
                $("#BOX_LENGTH").addClass("disabled").prop(propTrue);
                $("#BOX_HEIGHT").addClass("disabled").prop(propTrue);
            } else if (data.STATUS_CD == "22") {
                $("#div_payment_stock_cancle").show();
                $("#div_regular_pay").hide();
                $("#div_stock_completion").hide();
                $("#div_stock_cancle").hide();
                $("#div_invc_print").hide();
                $("#div_save").hide();

                $("#WGT").addClass("disabled").prop(propTrue);
                $("#BOX_WIDTH").addClass("disabled").prop(propTrue);
                $("#BOX_LENGTH").addClass("disabled").prop(propTrue);
                $("#BOX_HEIGHT").addClass("disabled").prop(propTrue);
            } else {
                $("#div_payment_stock_cancle").hide();
                $("#div_regular_pay").hide();
                $("#div_stock_completion").hide();
                $("#div_stock_cancle").show();
                $("#div_invc_print").show();
                $("#div_save").hide();

                if (data.E_NATION == "US" && data.SHIP_METHOD_CD == "PREMIUM") {
                    var INVC_SNO1 = data.INVC_SNO1 || "";
                    $("#lbInvcSno1").text(INVC_SNO1);
                }
                $("#WGT").addClass("disabled").prop(propTrue);
                $("#BOX_WIDTH").addClass("disabled").prop(propTrue);
                $("#BOX_LENGTH").addClass("disabled").prop(propTrue);
                $("#BOX_HEIGHT").addClass("disabled").prop(propTrue);
            }
        }
    }
     
     function varReset() {
         _COUNT = 0;
         scan = false;
     }

    /**
     * 무게측정값 
     * @param {String} formid : Form태그 ID
     * @param {Json} data : 바인딩데이터
    */
    function cfn_wgtOutPutData(data) {

        if (data != null && (data.WGT != null && data.WGT != "")) {
            $("#WGT").val(data.WGT); //오더넘버
            if ($("#WGT").val().length > 0) {
                $("#XRT_INVC_NO").focus();
            }
        }
    }

    // 부피 측정 (가로 * 세로  * 높이)
    function volumeResult() {
        var wid = $("#BOX_WIDTH").val() || 0;
        var len = $("#BOX_LENGTH").val() || 0;
        var hei = $("#BOX_HEIGHT").val() || 0;
        var result = wid * len * hei / 6000;
        $("#volume").text(result.toFixed(2) + " (Kg)");
    }
</script>
<c:import url="/comm/contentBottom.do" />