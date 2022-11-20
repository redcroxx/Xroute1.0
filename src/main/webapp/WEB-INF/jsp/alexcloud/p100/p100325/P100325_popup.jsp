<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100325_popup
	화면명    : 입고실적처리 팝업
-->
<div id="P100325_popup" class="pop_wrap">
	<div id="ct_sech_wrap">
		<form id="frm_P100325_popup_detail" action="#" onsubmit="return false">
			<ul class="sech_ul">
				<li class="sech_li required">	
					<div style="width:100px;">입고일자</div>
					<div style="width:270px;">
						<input type="text" id="WDDT" name="WDDT" class="cmc_date required"/><br>
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">	
					<div style="width:100px;">비고</div>
					<div style="height:120px;">
						<textarea id="REMARK_P" name="REMARK_P" class="cmc_area" maxlength="200" cols="45" style="height:110px;"></textarea>
					</div>
				</li>
			</ul>
		</form>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#P100325_popup').lingoPopup({
		title: '입고실적처리',
		width: 430,
		height: 275,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					//검색조건 필수입력 체크
					if(cfn_isFormRequireData('frm_P100325_popup_detail') == false) return;
					
					var param = cfn_getFormData('frm_P100325_popup_detail');
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
		},
		open: function(data) {
			$('#WDDT').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
		}
	});
});
</script>