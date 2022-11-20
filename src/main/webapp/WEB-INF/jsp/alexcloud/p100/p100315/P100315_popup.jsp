<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100315_popup
	화면명    : 입고지시서발행 팝업
-->
<div id="P100315_popup" class="pop_wrap">
	<div id="ct_sech_wrap">
		<form id="frm_P100315_popup_detail" action="#" onsubmit="return false">		
		
			<br><div>
				<input type="radio" id="P100315_R00" name="P100315_R" class="cmc_radio" value="1" checked="checked" style = "width:15px;"><label for="P100315_R00">입고지시서</label>
			</div><br>
			<div>
				<input type="radio" id="P100315_R01" name="P100315_R" class="cmc_radio" value="1" style = "width:15px;"><label for="P200311_R01">입고실적서</label>
			</div><br>
			
		</form>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#P100315_popup').lingoPopup({
		title: '입고지시서 발행',
		width: 300,
		height:200,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					//검색조건 필수입력 체크
					if(cfn_isFormRequireData('frm_P100315_popup_detail') == false) return;
					
					var param = cfn_getFormData('frm_P100315_popup_detail');
					$(this).lingoPopup('setData', param);
					$(this).lingoPopup('close', 'OK');
				}
			},
			'취소': {
				text: '취소',
				click: function() {
					$(this).lingoPopup('setData', '');
					$(this).lingoPopup('close', 'CANCEL');
				}
			}
		}
	});
});
</script>