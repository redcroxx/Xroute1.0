<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100380_reportPop
	화면명    : 입고요청서, 거래명세서 , 빈양식 출력팝업
-->
<div id="P100380_reportPop" class="pop_wrap">
	<div id="ct_sech_wrap">
		<form id="frm_P100380_reportPop" action="#" onsubmit="return false">		
			<ul class="sech_ul">
				<li class="sech_li">	
					<div style="min-width:300px;">
						<input type="radio" id="P100300_R01" name="P100380_R" class="cmc_radio" value="1" checked="checked" style = "width:15px;">
						<label for="P100300_R01">입고요청서</label>
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">	
					<div style="min-width:300px;">
					 	<input type="radio" id="P100300_R02" name="P100380_R" class="cmc_radio" value="2" style = "width:15px;">
						<label for="P100300_R02">거래명세서</label>
					</div>
				</li>
			</ul>		
			<ul class="sech_ul">
				<li class="sech_li">	
					<div style="min-width:300px;">
					 	<input type="radio" id="P100300_R03" name="P100380_R" class="cmc_radio" value="3" style = "width:15px;">
						<label for="P100300_R01">입고요청서(빈양식)</label>
					</div>
				</li>
			</ul>	
			<ul class="sech_ul">
				<li class="sech_li">	
					<div style="min-width:300px;">
					 	<input type="radio" id="P100300_R04" name="P100380_R" class="cmc_radio" value="4" style = "width:15px;">
						<label for="P100300_R01">거래명세서(빈양식)</label>
					</div>
				</li>
			</ul>		
			
		</form>
	</div>
</div>

<script type="text/javascript">
$(function() {
 	$('#P100380_reportPop').lingoPopup({
		title: '입고 리포트 출력',
		width: 350,
		height:230,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {					
					var param = cfn_getFormData('frm_P100380_reportPop');
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