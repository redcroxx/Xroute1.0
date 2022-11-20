<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
    화면코드 : AtomyStockInspection
    화면명   : 애터미 입고 검수.
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
            <li class="sech_li required">
                <div style="width: 120px">CI/PL 송장번호</div>
                <div>
                    <input type="text" class="cmc_code required" id="ciplXrtInvcSno" name="ciplXrtInvcSno" maxlength="13" onkeyup="stringConvert()" tabindex="-1" style="width: 200px;">
                </div>
            </li>
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
                        <input type="button" class="cmb_normal_new cbtn_cancel" id="btnInit" value="초기화" onclick="cfn_init();" style="min-width: 80px !important; text-align: right;">
                        <input type="button" class="cmb_normal_new cbtn_save" id="btnInspection" value="   검수완료" onclick="setInspection();" style="min-width: 70px !important; text-align: right;" />
                        <input type="button" class="cmb_normal_new cbtn_cancel" id="btnInspectionCancel" value="   검수취소" onclick="setCancel();" style="min-width: 70px !important; text-align: right;" />
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
<div  class="ct_left_wrap fix" style="width: 754px;">
    <div id="inspectionGrid"></div>
</div>
<div class="ct_right_wrap" style="width: 500px;">
    <div id="goodsGrid"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    var _SCAN = false;
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
        setInspectionData();
        getInspectionList();
        $("#xrtInvcSno").focus();
        $("#normal").hide();
        $("#abnormal").hide();
        $("#btnInspection").hide();
        $("#btnInspectionCancel").hide();
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

    function setInspectionData() {
        var gid = "inspectionGrid";
        var columns = [
            {
                name : "xrtInvcSno",
                header : {
                    text : "XROUTE 송장번호"
                },
                styles : {
                    textAlignment : "left"
                },
                width : 150
            },
            {
                name : "ciplXrtInvcSno",
                header : {
                    text : "CI/PL 송장번호"
                },
                styles : {
                    textAlignment : "left"
                },
                width : 150
            },
            {
                name : "inspectionData",
                header : {
                    text : "금일 검수 내역"
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

            $("#ciplXrtInvcSno").focus();
            
            var str2 = $("#ciplXrtInvcSno").val();
            var convertStr2 = cfn_lngg_convert(str2, "eng");
            
            if (window.event.keyCode == 13 && str2 != "9999" && _SCAN == false) {
                strVal2 = convertStr2;
                $("#ciplXrtInvcSno").val(convertStr2.replace(/ /gi, ""));
                
                if (strVal2 != "") {
                    checkXrtInvcSno(strVal, strVal2);
                }
            }
        } else if (str == "9999") {
            _SCAN = true;
            if (window.event.keyCode == 13) {
                strVal = convertStr;

                $("#xrtInvcSno").val(convertStr.replace(/ /gi, ""));
                cfn_retrieve();

                $("#ciplXrtInvcSno").focus();
                
                var str2 = $("#ciplXrtInvcSno").val();
                var convertStr2 = cfn_lngg_convert(str2, "eng");
                
                if (window.event.keyCode == 13 && str2 != "9999" && _SCAN == false) {
                    strVal2 = convertStr2;
                    $("#ciplXrtInvcSno").val(convertStr2.replace(/ /gi, ""));
                    
                    if (strVal2 != "") {
                        checkXrtInvcSno(strVal, strVal2);
                    }
                }
            }
        }
    }
    
    // 송장번호 확인.
    function checkXrtInvcSno(strVal, strVal2) {
        console.log("strVal : " + strVal);
        console.log("strVal2 : " + strVal2);
        var url = "/fulfillment/atomy/stockInspection/checkXrtInvcSno.do";
        var sendData = {
                "xrtInvcSno" : strVal,
                "ciplXrtInvcSno" : strVal2
        };
        
        $.ajax({
            url : url,
            type : "POST",
            data : JSON.stringify(sendData),
            contentType: "application/json",
            success : function(data) {
                if (data.result == "false") {
                    cfn_msg("WARNING", "송장 정보가 일치하지 않습니다.");
                    cfn_init();
                }else {
                    if (data.statusCd == "30" || data.statusCd == "34") {
                        $("#btnInspection").show();
                        $("#btnInspectionCancel").hide();
                    } else if (data.statusCd == "33") {
                        $("#btnInspectionCancel").show();
                        $("#btnInspection").hide();
                    }else {
                        cfn_msg("WARNING", "입고완료 처리된 송장번호가 아닙니다.");
                        cfn_init();
                    }
                }
            },
            error : function(data) {
                cfn_msg("ERROR", "송장번호 오류");
            }
        });
    }
    
    // 공통버튼 - 초기화 클릭
    function cfn_init() {

        var prop = {
            "readonly" : false,
            "disabled" : false
        };

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

        $("#xrtInvcSno").val("");
        $("#ciplXrtInvcSno").val("");
        $("input[name='xrtInvcSno']").val("");
        $("input[name='ciplXrtInvcSno']").val("");
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
        
        $("#btnInspection").hide();
        $("#btnInspectionCancel").hide();
        
        $("#xrtInvcSno").focus();
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
        var url = "/fulfillment/atomy/stockInspection/getSearch.do";
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

        $("#bthInspection").hide();
    }

    // 검수완료 클릭
    function setInspection() {
        if (cfn_isFormRequireData("frmSearch") == false) {
            return;
        }

        var param = cfn_getFormData("frmSearch");
        var sid = "sid_inspectionComp";
        var url = "/fulfillment/atomy/stockInspection/setInspection.do";

        gfn_sendData(sid, url, param, true);
    }

    // 검수취소 클릭
    function setCancel() {
        if (cfn_isFormRequireData("frmSearch") == false) {
            return;
        }

        if (confirm("검수취소 처리를 하시겠습니까?") == true) {
            var param = cfn_getFormData("frmSearch");
            var sid = "sid_cancel";
            var url = "/fulfillment/atomy/stockInspection/setCancel.do";
            gfn_sendData(sid, url, param, true);
        }
    }

    // 검수내역 히스토리
    function getInspectionList() {
        var param = cfn_getFormData("frmSearch");
        var sid = "sid_inspectionList";
        var url = "/fulfillment/atomy/stockInspection/getInspectionList.do";

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
            
            $("#goodsGrid").gfn_setDataList(data.resultList);
            $("#goodsGrid").gfn_focusPK();
            $("#alert").html("");
            setOrderData(data.resultData);
            getInspectionList();
            volumeResult();
        } else if (sid == "sid_inspectionComp" || sid == "sid_cancel") {
            _SCAN = false;
            $("#goodsGrid").dataProvider().clearRows();
            cfn_init();
            getInspectionList();
            $("#xrtInvcSno").focus();
        } else if (sid == "sid_inspectionList") {
            $("#inspectionGrid").gfn_setDataList(data.resultList);
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
            $("#eNation").val(data.eNation);
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

            if (data.statusCd == "10" || data.statusCd == "11" || data.statusCd == "13") {
                $("#bthInspection").hide();
                $("#bthInspectionCancel").hide();

                $("#wgt").removeClass("disabled").prop(propFalse);
                $("#boxWidth").removeClass("disabled").prop(propFalse);
                $("#boxLength").removeClass("disabled").prop(propFalse);
                $("#boxHeight").removeClass("disabled").prop(propFalse);
            } else if(data.statusCd == "30"){ // 입고 완료 상태.
                $("#bthInspection").show();
                $("#bthInspectionCancel").hide();

                $("#wgt").addClass("disabled").prop(propTrue);
                $("#boxWidth").addClass("disabled").prop(propTrue);
                $("#boxLength").addClass("disabled").prop(propTrue);
                $("#boxHeight").addClass("disabled").prop(propTrue);
            } else if(data.statusCd == "33"){ // 검수 완료 상태.
                $("#bthInspection").hide();
                $("#bthInspectionCancel").show();
                
                $("#wgt").addClass("disabled").prop(propTrue);
                $("#boxWidth").addClass("disabled").prop(propTrue);
                $("#boxLength").addClass("disabled").prop(propTrue);
                $("#boxHeight").addClass("disabled").prop(propTrue);
            } else if(data.statusCd == "34") { // 검수 취소 상태.
                $("#bthInspection").show();
                $("#bthInspectionCancel").hide();
                
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
</script>
<c:import url="/comm/contentBottom.do" />