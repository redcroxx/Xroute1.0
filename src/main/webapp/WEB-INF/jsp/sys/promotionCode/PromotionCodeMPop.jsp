<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : promotionCodeMPop
    화면명   : 프로모션 코드 수정 팝업
-->
<!-- 검색 시작 -->
<div id="promotionCodeMPop" class="pop_wrap">
    <form id="frmPromotionCodeMPop" action="#" onsubmit="return false">
        <input type="hidden" id="promotionCodeSeq" value="<c:out value='${data.promotionCodeSeq}' />">
        <table class="tblForm" style="min-width: 300px">
            <colgroup>
                <col width="180px" />
                <col width="240px" />
                <col width="180px" />
                <col width="240px" />
                <col />
            </colgroup>
            <tr>
                <th  class="required">프로모션 코드</th>
                <td>
                    <input type="text" class="cmc_txt required disabled" id="promotionCode" disabled="disabled" value="<c:out value='${data.promotionCode}' />">
                </td>
                <th  class="required">코드 수량</th>
                <td>
                    <input type="text" class="cmc_txt required" id="codeCount" value="<c:out value='${data.codeCount}' />">
                </td>
            </tr>
            <tr>
                <th class="required">프리미엄 할인율</th>
                <td>
                    <input type="text" class="cmc_txt required" id="premium" value="<c:out value='${data.premium}' />">
                </td>
                <th  class="required">DHL 할인율</th>
                <td>
                    <input type="text" class="cmc_txt required" id="dhl" value="<c:out value='${data.dhl}' />">
                </td>
            </tr>
            <tr>
                <th  class="required">코드 등록 유효 시작일</th>
                <td>
                    <input type="text" class="cmc_date periods required" id="codeStartDate" value="<c:out value='${data.codeStartDate}' />">
                </td>
                <th  class="required">코드 등록 유효 종료일</th>
                <td>
                    <input type="text" class="cmc_date periods required" id="codeEndDate" value="<c:out value='${data.codeEndDate}' />">
                </td>
            </tr>
            <tr>
                <th  class="required">할인 적용 시작일</th>
                <td>
                    <input type="text" class="cmc_date periods required" id="discountStartDate" value="<c:out value='${data.discountStartDate}' />">
                </td>
                <th  class="required">할인 적용 종료일</th>
                <td>
                    <input type="text" class="cmc_date periods required" id="discountEndDate" value="<c:out value='${data.discountEndDate}' />">
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">
                    <textarea rows="3" cols="90" id="content"><c:out value='${data.content}' /></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">
    // 초기 로드
    $(function() {
        $("#promotionCodeMPop").lingoPopup({
            title : "프로모션 코드 수정",
            width : 900,
            height : 360,
            buttons : {
                "저장" : {
                    text : "저장",
                    click : function() {
                        setSave();
                    }
                },
                "닫기" : {
                    text : "닫기",
                    click : function() {
                        $(this).lingoPopup("setData", "");
                        $(this).lingoPopup("close", "CANCEL");
                    }
                }
            },
            open : function() {
            }
        });
    });
    // 프로모션 코드 등록 저장
    function setSave() {
        if (confirm("저장 하시겠습니까?") == false) {
            return;
        }
        
        if ($("#codeCount").val() == "") {
            cfn_msg("ERROR", "프로모션 코드 수량을 입력하세요.");
            $("#codeCount").focus();
            return;
        }
        
        if ($("#premium").val() == "") {
            cfn_msg("ERROR", "프리미엄 할인률을 입력하세요.");
            $("#premium").focus();
            return;
        }
        
        if ($("#dhl").val() == "") {
            cfn_msg("ERROR", "DHL 할인률을 입력하세요.");
            $("#dhl").focus();
            return;
        }
        

        gv_searchData = cfn_getFormData("frmPromotionCodeMPop");
        var url = "/sys/promotionCode/pop/setUpdate.do";
        var sendData = gv_searchData;

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "저장되었습니다.");
                $("#promotionCodeMPop").lingoPopup("setData", "");
                $("#promotionCodeMPop").lingoPopup("close", "OK");
            }
        });
    }
</script>