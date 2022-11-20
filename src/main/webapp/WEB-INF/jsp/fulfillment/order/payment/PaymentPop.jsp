<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="paymentPop" class="pop_wrap">
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">
                무통장-결제요청리스트
                <span>(총 0건)</span>
            </div>
            <div class="grid_top_right">
                <input type="button" value="결제하기" onclick="makePayment()">
                <input type="button" value="닫기" onclick="cancel()">
            </div>
        </div>
        <div id="popGrid"></div>
    </div>
    <form name="settleBank" method="post" style="display: none;">
        <input type="hidden" name="PNoteUrl" value="https://xroute.logifocus.co.kr/api/settle/responseData.do">
        <input type="hidden" name="PNextPUrl" value="https://xroute.logifocus.co.kr/fulfillment/order/payment/paymentList/pop/getSettleBank.do">
        <input type="hidden" name="PCancPUrl" value="https://xroute.logifocus.co.kr/fulfillment/order/payment/paymentList/pop/getSettleBank.do">
        <input type="hidden" name="PEmail">
        <input type="hidden" name="PPhone">
        <input type="hidden" name="POid">
        <input type="hidden" name="t_PGoods">
        <input type="hidden" name="t_PNoti">
        <input type="hidden" name="t_PMname">
        <input type="hidden" name="t_PUname">
        <input type="hidden" name="t_PBname">
        <input type="hidden" name="PEname">
        <input type="hidden" name="PVtransDt">
        <input type="hidden" name="PUserid">
        <input type="hidden" name="PCardType">
        <input type="hidden" name="PChainUserId">
        <input type="hidden" name="PGoods">
        <input type="hidden" name="PNoti">
        <input type="hidden" name="PMname">
        <input type="hidden" name="PUname">
        <input type="hidden" name="PBname">
        <input type="hidden" name="PMid">
        <input type="hidden" name="PAmt">
        <input type="hidden" name="PHash">
        <input type="hidden" name="PData">
        <input type="hidden" name="PStateCd">
        <input type="hidden" name="POrderId">
    </form>
</div>
<script type="text/javascript">
    var sumPrice = 0;

    $(function() {
        $("#paymentPop").lingoPopup({
            title : "무통장-결제요청리스트",
            width : 1350,
            height : 600,
            open : function(data) {
                dataReset();
                setPopGridData();
                setData(data.gridData);
            }
        });
    });

    function dataReset() {
        $("input[name='PEmail']").val("");
        $("input[name='PPhone']").val("");
        $("input[name='POid']").val("");
        $("input[name='t_PGoods']").val("");
        $("input[name='t_PMname']").val("");
        $("input[name='t_PUname']").val("");
        $("input[name='t_PBname']").val("");
        $("input[name='PMid']").val("");
        $("input[name='PAmt']").val("");
        $("input[name='PUserid']").val("");
        $("input[name='PGoods']").val("");
        $("input[name='PMname']").val("");
        $("input[name='PUname']").val("");
        $("input[name='PBname']").val("");
    }

    function setPopGridData() {
        var gid = "popGrid";
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
            footerflg : true
        });
    }

    function listReset() {
        var docId = $("#main_contents").find("#tabs").find("[aria-hidden=false]").find("iframe").prop("id");
        document.getElementById(docId).contentWindow.cfn_retrieve();
    }

    function cancel() {
        $("#paymentPop").lingoPopup("setData", "");
        $("#paymentPop").lingoPopup("close", "OK");
    }

    function setData(data) {
        var sid = "sid_getSearch";
        var url = "/fulfillment/order/payment/paymentList/pop/getSearch.do";
        var xrtInvcSnos = {};
        xrtInvcSnos.data = data;
        var sendData = {
            "paramData" : xrtInvcSnos
        };

        gfn_sendData(sid, url, sendData, true);
    }

    function gfn_callback(sid, data) {
        if (sid == "sid_getSearch") {
            $("#popGrid").gfn_setDataList(data.resultList);
            $("input[name='PEmail']").val(data.pEmail);
            $("input[name='PPhone']").val(data.pPhone);
            $("input[name='POid']").val(data.pOid);
            $("input[name='t_PGoods']").val(data.pGoods);
            $("input[name='t_PMname']").val(data.pMname);
            $("input[name='t_PUname']").val(data.pUname);
            $("input[name='t_PBname']").val(data.pBname);
            $("input[name='PUserid']").val(data.pUserid);
            $("input[name='PMid']").val(data.pMid);
            $("input[name='PAmt']").val(data.pAmt);
            $("input[name='PGoods']").val(encodeURI(data.pGoods));
            $("input[name='PMname']").val(encodeURI(data.pMname));
            $("input[name='PUname']").val(encodeURI(data.pUname));
            $("input[name='PBname']").val(encodeURI(data.pBname));
        }
    }

    function makePayment(type) {

        var width = 720;
        var height = 630;
        var xpos = (screen.width - width) / 2;
        var ypos = (screen.width - height) / 6;
        var position = "top=" + ypos + ", left=" + xpos;
        var features = position + ", width=" + width + ", height=" + height + ", toolbar=no, location=no";

        window.name = "STPG_CLIENT";
        wallet = window.open("", "STPG_WALLET", features);

        if (wallet != null) {
            $("form[name='settleBank']").prop("action", "https://pg.settlebank.co.kr/vbank/NewVBankAction.do")
            $("form[name='settleBank']").prop("target", "STPG_WALLET")
            $("form[name='settleBank']").submit();
        } else {
            if ((webbrowser.indexOf("Windows NT 5.1") != -1) && (webbrowser.indexOf("SV1") != -1)) { // Windows XP Service Pack 2
                alert("팝업이 차단되었습니다. 브라우저의 상단 노란색 [알림 표시줄]을 클릭하신 후 팝업창 허용을 선택하여 주세요.");
            } else {
                alert("팝업이 차단되었습니다.");
            }
        }

    }
</script>
<c:import url="/comm/contentBottom.do" />