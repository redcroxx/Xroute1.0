<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 
    화면코드 : PaymentContentsPop.jsp
    화면명   : 결제 내용 상세
-->
<div id="paymentContentsPop" class="pop_wrap">
    <!-- 검색조건영역 시작 -->
    <div id="ct_sech_wrap">
        <form id="frmPopSearch" action="#" onsubmit="return false">
            <p id="lbl_name">결제내용상세</p>
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>주문번호</div>
                    <div>
                        <label id="textOid"></label>
                        <input type="hidden" name="pOid" id="pOid" />
                    </div>
                </li>
                <li class="sech_li">
                    <div>결제금액 (KRW)</div>
                    <div>
                        <label id="pAmt"></label>
                    </div>
                </li>
            </ul>
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>결제신청일자</div>
                    <div>
                        <label id="vbankCreateDate"></label>
                    </div>
                </li>
                <li class="sech_li">
                    <div>입금확인일자</div>
                    <div>
                        <label id="vbankConfirmDate"></label>
                    </div>
                </li>
                <li class="sech_li">
                    <div>주문상태</div>
                    <div>
                        <label id="pStatusCd"></label>
                    </div>
                </li>
            </ul>
        </form>
    </div>
    <!-- 검색조건영역 끝 -->
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="ct_top_wrap fix botfix" style="height: 40px">
            <div id="popGrid"></div>
        </div>
    </div>
    <!-- 그리드 끝 -->
</div>
<script type="text/javascript">
    $(function() {
        $("#paymentContentsPop").lingoPopup({
            title : "결제내용상세",
            width : 780,
            height : 700,
            buttons : {
                "취소" : {
                    text : "닫기",
                    click : function() {
                        $(this).lingoPopup("setData", "");
                        $(this).lingoPopup("close", "CANCEL");
                    }
                }
            },
            open : function(data) {
                $("#textOid").text(data.pOid || "");
                $("#pOid").val(data.pOid || "");
                $("#pAmt").text(data.pAmt || "");
                $("#vbankCreateDate").text(data.vbankCreateDate || "");
                $("#vbankConfirmDate").text(data.vbankConfirmDate || "");
                $("#pStatusCd").text(data.pStatusCd || "");

                setPopGridData();
                getPopSearch();
            }
        });
    });

    /* 검색 */
    function getPopSearch() {

        if ($("#pOid").val() == "") {
            return;
        }

        var url = "/fulfillment/order/payment/paymentContentsList/pop/getSearch.do";
        var sendData = {
            "sEtcCd1" : $("#pOid").val()
        };

        gfn_ajax(url, true, sendData, function(data, xhr) {
            if (cfn_isEmpty(data.resultList)) {
                cfn_msg("WARNING", "검색결과가 존재하지 않습니다.");
                return false;
            }

            $("#popGrid").gfn_setDataList(data.resultList);
        });
    }

    function setPopGridData() {
        var gid = "popGrid";
        var columns = [
                {
                    name : "pSeq",
                    header : {
                        text : "시퀀스"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 50,
                }, {
                    name : "xrtInvcSno",
                    header : {
                        text : "XROUTE송장번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 200,
                }, {
                    name : "xrtShippingPrice",
                    header : {
                        text : "XROUTE판매가"
                    },
                    dataType : "number",
                    styles : {
                        textAlignment : "far",
                        numberFormat : "#,##0"
                    },
                    width : 200,
                }
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />