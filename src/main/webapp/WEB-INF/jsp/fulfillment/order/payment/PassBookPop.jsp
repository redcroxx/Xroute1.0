<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="passBookPop" class="pop_wrap">
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_right">
                <input type="button" value="승인확인" onclick="setData()">
                <input type="button" value="닫기" onclick="cancel()">
            </div>
        </div>
        <div>
            <ul>
                <li>로지포커스 주식회사(이하 “로지포커스”)는 고객(이하 “고객”)의 개인정보를 중요시하며 개인정보 보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관계법령을 준수하고 있습니다.</li>
                <li>“고객”은 개인정보처리방침을 통하여 “로지포커스”의 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해어떠한 조치가 취해지고 있는지 알려드립니다.</li>
                <li>“로지포커스” & 내통장결제</li>
                <li style="color: red;">“로지포커스”에서는 세틀뱅크와 제휴를 맺고 “내통장결제” 서비스를 제공합니다.</li>
                <li style="color: red;">“로지포커스” 이커머스 B2C 해외배송 서비스를 이용하기 위해 반드시 내통장결제 계좌를 등록해야 합니다.</li>
                <li>“내통장결제” 서비스는 자주 쓰는 내통장을 고객이 직접 최초 1회 본인 계좌를 등록하면, 이후 해외 배송비를 자동으로 손쉽게 결제가 이뤄지는 서비스입니다.</li>
                <li>본인 계좌를 등록을 위한 최초 1회 결제 금액은 결제 후 바로 취소 처리가 되며, 관련한 최초 1회 수수료는 “로지포커스”에서 부담합니다.</li>
                <li>“내통장결제” 계좌 등록 이후 해외 배송비는 “로지포커스” 김포센터에 화물 입고 후 등록된 계좌에서 자동결제가 이뤄진 후 “입고완료” 처리가 됩니다.</li>
                <li>“로지포커스” 김포센터에 입고된 화물은 “입고완료”를 위해 반드시 “내통장결제” 계좌의 잔고가 부족하지 않은 지 확인을 해주시길 바랍니다.</li>
                <li>만약 등록된 “내통장결제” 계좌에 잔고가 부족하여 배송비 결제가 실패한 경우, “입고완료” 처리가 이뤄지지 않고 “결제실패” 상태로 전환되어, 배송이 지연될 수 있습니다. 이로 인한 지연으로 발생된 책임은 “로지포커스”에는 없습니다.</li>
                <li>수입국에서 배송 시 발생되는 관세/부가세 등 기타 추가 비용도 등록된 “내통장결제” 계좌에서 결제가 되며, 등록된 결제 계좌에 잔고 확인이 필요합니다.</li>
                <li>“로지포커스” 해외배송 서비스 이용을 원하지 않아 탈퇴/탈회를 하시는 경우, 등록된 계좌는 해지 또는 파기처리 됩니다.</li>
                <li>수집하는 개인정보의 항목</li>
                <li>“세틀뱅크”는 개인정보의 수집 및 이용목적을 달성하기 위하여 지불수단 별로 아래와 같은 개인정보를 수집합니다.</li>
                <li>- 계좌이체 : 계좌번호, 주문자명</li>
                <li>개인정보의 보유 및 이용기간</li>
                <li>개인정보는 개인정보의 수집∙이용목적이 달성되면 지체 없이 파기 합니다.</li>
                <li>해당 “내통장결제계좌” 승인을 하실려면 위의 <span style="color: red;">승인확인버튼</span>을 클릭하세요.</li>
                <li>관련한 자세한 문의사항은 “로지포커스” 대표번호(02-6956-6603) 로 연락주시면 자세한 안내 도와드리겠습니다.</li>
            </ul>
        </div>
    </div>
    <form id="passBook" name="passBook" method="post" style="display: none;">
        <!-- 공통부분 -->
        <input type="hidden" name="hdInfo">
        <input type="hidden" name="apiVer">
        <input type="hidden" name="processType">
        <input type="hidden" name="mercntId">
        <input type="hidden" name="authNo">
        <input type="hidden" name="trDay">
        <input type="hidden" name="trTime">
        <input type="hidden" name="trPrice">
        <input type="hidden" name="cancelPrice">
        <input type="hidden" name="discntPrice">
        <input type="hidden" name="payPrice">
        <input type="hidden" name="mercntParam1">
        <input type="hidden" name="mercntParam2">
        <input type="hidden" name="mercntParam3">
        <input type="hidden" name="mercntParam4">
        <input type="hidden" name="signature">
        <!-- 인증부분 -->
        <input type="hidden" name="ordNo">
        <input type="hidden" name="productNm">
        <input type="hidden" name="dutyFreeYn">
        <input type="hidden" name="regularpayYn">
        <input type="hidden" name="callbackUrl">
        <!-- 결제승인 -->
        <input type="hidden" name="reqDay">
        <input type="hidden" name="reqTime">
        <input type="hidden" name="regularpayKey">
        <input type="hidden" name="bankAcctNo">
        <!-- 정기결제 승인 -->
        <input type="hidden" name="regularStatus">
        <input type="hidden" name="usercd">
        
        
    </form>
</div>
<script type="text/javascript" src="<c:out value='${PASS_BOOK_URL}' />" charset="UTF-8"></script>
<script type="text/javascript">

    $(function() {
        $("#passBookPop").lingoPopup({
            title : "정기결제 공지",
            width : 1350,
            height : 600,
            open : function(data) {
                dataReset();
                $("input[name='usercd']").val(data.USERCD);
            }
        });
    });

    function dataReset() {
        $("input[name='hdInfo']").val("");
        $("input[name='apiVer']").val("");
        $("input[name='processType']").val("");
        $("input[name='mercntId']").val("");
        $("input[name='ordNo']").val("");
        $("input[name='trDay']").val("");
        $("input[name='trTime']").val("");
        $("input[name='trPrice']").val("");
        $("input[name='signature']").val("");
        $("input[name='regularpayYn']").val("");
        $("input[name='dutyFreeYn']").val("");
        $("input[name='productNm']").val("");
        $("input[name='authNo']").val("");
        $("input[name='usercd']").val("");
    }

    function cancel() {
        $("#passBookPop").lingoPopup("setData", "");
        $("#passBookPop").lingoPopup("close", "OK");
    }

    function setData() {
        var sid = "sid_getSearch";
        var url = "/sys/passBook/auth.do";
        var sendData = {
            "usercd" : $("input[name='usercd']").val()
        };

        gfn_sendData(sid, url, sendData, true);
    }

    function gfn_callback(sid, data) {
        if (sid == "sid_getSearch") {
            $("input[name='hdInfo']").val(data.hdInfo || "");
            $("input[name='apiVer']").val(data.apiVer || "");
            $("input[name='processType']").val(data.processType || "");
            $("input[name='mercntId']").val(data.mercntId || "");
            $("input[name='ordNo']").val(data.ordNo || "");
            $("input[name='trDay']").val(data.trDay || "");
            $("input[name='trTime']").val(data.trTime || "");
            $("input[name='trPrice']").val(data.trPrice || "");
            $("input[name='signature']").val(data.signature || "");
            $("input[name='dutyFreeYn']").val(data.dutyFreeYn || "");
            $("input[name='regularpayYn']").val(data.regularpayYn || "");
            $("input[name='callbackUrl']").val(data.callbackUrl || "");
            $("input[name='productNm']").val(data.productNm || "");

            var obj = document.forms["passBook"];
            SettlePay.execute(obj);
        } else if (sid == "sid_payApprov") {
            if (data.CODE == "1") {
                setCancel();
            } else {
                cfn_msg(data.MESSAGE);
            }
        } else if (sid == "sid_payCancel") {
            if (data.CODE == "1") {
                $("#passBookPop").lingoPopup("setData", "");
                $("#passBookPop").lingoPopup("close", "OK");
            } else {
                cfn_msg(data.MESSAGE);
            }
        } else {
            cfn_msg("오류가 발생하였습니다");
        }
    }

    function getCallBack(resultCd, etcCd, errCd) {

        if (resultCd != 0) {
            cfn_msg("ERROR", "인증 부분에서 '" + errCd + "' 오류가 발생하였습니다.");
            return;
        }

        $("input[name='authNo']").val(etcCd || "");

        var sid = "sid_payApprov";
        var url = "/sys/passBook/payApprov.do";
        var sendData = {
            "authNo" : $("input[name='authNo']").val() || "",
            "ordNo" : $("input[name='ordNo']").val() || ""
        };
        gfn_sendData(sid, url, sendData, true);
    }

    function setCancel() {
        var sid = "sid_payCancel";
        var url = "/sys/passBook/payCancel.do";
        var sendData = {
            "ordNo" : $("input[name='ordNo']").val() || "",
            "cancelPrice" : "1",
            "usercd" : $("input[name='usercd']").val()
        };
        gfn_sendData(sid, url, sendData, true);
    }
</script>