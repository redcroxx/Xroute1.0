<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : promotionCodeInputPop
	화면명   : 프로모션 코드 입력 팝업
-->
<div id="promotionCodeInputPop" class="pop_wrap">
    <form id="frmPromotionCodeInputPop" action="#" onsubmit="return false">
        <input type="hidden" id="compcd" value="<c:out value='${sessionScope.loginVO.compcd}' />" />
        <input type="hidden" id="orgcd" value="<c:out value='${sessionScope.loginVO.orgcd}' />" />
        <input type="hidden" id="usercd" value="<c:out value='${sessionScope.loginVO.usercd}' />" />
        <table class="tblForm" style="min-width: 300px">
            <colgroup>
                <col width="130px" />
                <col />
            </colgroup>
            <tr>
                <th>프로모션 코드</th>
                <td>
                    <input type="text" id="promotionCode" class="cmc_txt">
                </td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">
    $(function() {
        $("#promotionCodeInputPop").lingoPopup({
            title : "프로모션 코드 입력",
            width : 320,
            height : 300,
            buttons : {
                "저장" : {
                    text : "저장",
                    click : function() {
                        setPromotionCode();
                    }
                },
                "취소" : {
                    text : "취소",
                    click : function() {
                        $(this).lingoPopup("setData", "");
                        $(this).lingoPopup("close", "");
                    }
                }
            },
            open : function(data) {

            }
        });
    });

    function setPromotionCode() {
        
        if ($("#promotionCode").val() == "") {
            cfn_msg("ERROR", "프로모션코드를 입력하세요.");
            $("#promotionCode").focus();
            return;
        }
        
        var regType1 = /^[A-Za-z0-9+]*$/;
        if (!regType1.test($("#promotionCode").val())) {
            cfn_msg("ERROR", "프로모션코드는 숫자 및 영문만 가능합니다.");
            $("#promotionCode").focus();
            return;
        }

        gv_searchData = cfn_getFormData("frmPromotionCodeInputPop");
        var url = "/sys/promotionCode/pop/input/setPromotionCode.do";
        var sendData = gv_searchData;

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", data.MESSAGE);
                $("#promotionCodeInputPop").lingoPopup("setData", "");
                $("#promotionCodeInputPop").lingoPopup("close", "OK");
            }
        });
    }
</script>