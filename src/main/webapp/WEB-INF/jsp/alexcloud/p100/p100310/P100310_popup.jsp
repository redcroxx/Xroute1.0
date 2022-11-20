<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100310_popup
	화면명    : 입고지시처리 팝업
-->
<div id="P100310_popup" class="pop_wrap">
	<div id="ct_sech_wrap">
		<form id="frm_P100310_popup_detail" action="#" onsubmit="return false">
			<input type="hidden" id="USERCD" name="USERCD" />				
			<input type="hidden" id="USERNM" name="USERNM" />
			<!-- <ul class="sech_ul">
				<li class="sech_li">
					<div style="width:100px;">입고지시방법</div>
					<div>
						<input type="radio" id="UNIT01" name="UNIT" class="cmc_radio" value="BATCH" checked='checked'><label for="UNIT01">전표 일괄지시</label>
						<input type="radio" id="UNIT02" name="UNIT" class="cmc_radio" value="WIUNIT"><label for="UNIT02">전표 개별지시</label>
					</div>
				</li>
			</ul> -->
			<ul class="sech_ul">
				<li class="sech_li required">	
					<div style="width:100px;">입고일자</div>
					<div style="width:270px;">
						<input type="text" id="WDDT" name="WDDT" class="cmc_date required"/><br>
						<!-- <p style="margin-top:5px; color:#FF0000; font-weight:bold;">※입고일자가 수불 실적일자로 사용됩니다.</p> -->
					</div>
				</li>
			</ul>
			<%-- <ul class="sech_ul">
				<li class="sech_li required">
					<div style="width:100px;">입고지시유형</div>
					<div style="width:270px;">
						<select id="WDTYPE" name="WDTYPE" class="cmc_combo disabled" disabled="disabled" >
							<c:forEach var="i" items="${codeWDTYPE}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>		
					</div>
				</li>
			</ul> --%>
			<ul class="sech_ul">
				<li class="sech_li">	
					<div style="width:100px;">비고</div>
					<div style="height:120px;">
						<textarea id="REMARK_P" name="REMARK_P" class="cmc_area" maxlength="200" cols="45" style="height:110px;"></textarea>
					</div>
				</li>
			</ul>
			<!-- <ul class="sech_ul">
				<li class="sech_li">
					<label for="ISSUE"><input type="checkbox" id="ISSUE" name="ISSUE" class="cmc_checkbox" /> 지시서발행</label>
				</li>
			</ul> -->
		</form>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#P100310_popup').lingoPopup({
		title: '입고지시처리',
		width: 430,
		height: 275,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					//검색조건 필수입력 체크
					if(cfn_isFormRequireData('frm_P100310_popup_detail') == false) return;
					
					var param = cfn_getFormData('frm_P100310_popup_detail');
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
			$('#USERCD').val(cfn_loginInfo().USERCD);
			$('#USERNM').val(cfn_loginInfo().USERNM);
			/* $('#WDTYPE').val('INS'); */
		}
	});
});
</script>