<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P700205_reportPop
	화면명    : 로케이션이동지시서 팝업
-->
<div id="P700205_reportPop" class="pop_wrap">
	<div id="ct_sech_wrap">
		<form id="frm_P700205_reportPop" action="#" onsubmit="return false">
			<ul class="sech_ul">
				<li class="sech_li">	
					<div style="min-width:300px;">
						<input type="radio" id="P700205_R01" name="P700200_R" class="cmc_radio" value="2" checked="checked" style = "width:15px;">
						<label for="P700205_R01">로케이션이동지시서(품목순)</label>
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">	
					<div style="min-width:300px;">
						<input type="radio" id="P700205_R01" name="P700200_R" class="cmc_radio" value="3" style = "width:15px;">
						<label for="P700205_R01">로케이션이동지시서(로케이션)</label>
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">	
					<div style="min-width:300px;">
						<input type="radio" id="P700205_R01" name="P700200_R" class="cmc_radio" value="4" style = "width:15px;">
						<label for="P700205_R01">로케이션이동지시서(이동로케이션)</label>
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">	
					<div style="min-width:300px;">
						<input type="radio" id="P700205_R01" name="P700200_R" class="cmc_radio" value="5" style = "width:15px;">
						<label for="P700205_R01">로케이션이동지시서(수량)</label>
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">	
					<div style="min-width:300px;">
						<input type="radio" id="P700205_R01" name="P700200_R" class="cmc_radio" value="1" style = "width:15px;">
						<label for="P700200_R00">빈양식</label>
					</div>
				</li>
			</ul>
		</form>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#P700205_reportPop').lingoPopup({
		title: '로케이션이동지시서 출력',
		width: 350,
		height: 250,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var param = cfn_getFormData('frm_P700205_reportPop');
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
		}
	});
});
</script>