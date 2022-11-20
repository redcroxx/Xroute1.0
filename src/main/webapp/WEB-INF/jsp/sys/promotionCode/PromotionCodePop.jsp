<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : promotionCodePop
    화면명   : 프로모션 코드 등록 및 수정
-->
<!-- 검색 시작 -->
<div id="promotionCodePop" class="pop_wrap">
    <form id="frmPromotionCodePop" action="#" onsubmit="return false">
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
                    <input type="text" class="cmc_txt required" id="promotionCode" placeholder="숫자및 영문을 입력하세요.">
                </td>
                <th  class="required">코드 수량</th>
                <td>
                    <input type="text" class="cmc_txt required" id="codeCount" placeholder="숫자만 입력하세요.">
                </td>
            </tr>
            <tr>
                <th class="required">프리미엄 할인율</th>
                <td>
                    <input type="text" class="cmc_txt required" id="premium" placeholder="숫자만 입력하세요.">
                </td>
                <th  class="required">DHL 할인율</th>
                <td>
                    <input type="text" class="cmc_txt required" id="dhl" placeholder="숫자만 입력하세요.">
                </td>
            </tr>
            <tr>
                <th  class="required">코드 등록 유효 시작일</th>
                <td>
                    <input type="text" class="cmc_date periods required" id="codeStartDate">
                </td>
                <th  class="required">코드 등록 유효 종료일</th>
                <td>
                    <input type="text" class="cmc_date periods required" id="codeEndDate">
                </td>
            </tr>
            <tr>
                <th  class="required">할인 적용 시작일</th>
                <td>
                    <input type="text" class="cmc_date periods required" id="discountStartDate">
                </td>
                <th  class="required">할인 적용 종료일</th>
                <td>
                    <input type="text" class="cmc_date periods required" id="discountEndDate">
                </td>
            </tr>
            <tr>
                <th  class="required">내용</th>
                <td colspan="3">
                    <textarea rows="3" cols="90" id="content"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">
    // 초기 로드
    $(function() {
        $("#promotionCodePop").lingoPopup({
            title : "프로모션 코드 등록",
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
                $("#codeStartDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
                $("#codeEndDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
                $("#discountStartDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
                $("#discountEndDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
            }
        });
    });
    // 프로모션 코드 등록 저장
    function setSave() {
        if (confirm("저장 하시겠습니까?") == false) {
            return;
        }
        
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
        

        gv_searchData = cfn_getFormData("frmPromotionCodePop");
        var url = "/sys/promotionCode/pop/setSave.do";
        var sendData = gv_searchData;

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "저장되었습니다.");
                $("#promotionCodePop").lingoPopup("setData", "");
                $("#promotionCodePop").lingoPopup("close", "OK");
            }
        });
    }
</script>