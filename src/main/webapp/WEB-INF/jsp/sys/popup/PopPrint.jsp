<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popPrint
	화면명    : 팝업-사용자 프린터 정보 변경
-->
<div id="popPrint" class="pop_wrap">
	<form id="frmDetail_popPrint" action="#" onsubmit="return false">
		<input type="hidden" id="COMPCD" />
		<input type="hidden" id="IDU" />
		
		<table class="tblForm" style="min-width:300px">
			<colgroup>
				<col width="130px" />
				<col />
			</colgroup>
			<tr>
				<th>사용자코드</th>
				<td><input type="text" id="USERCD" class="cmc_txt disabled" readonly="readonly" /></td>
			</tr>
			<tr>
				<th>사용자명</th>
				<td><input type="text" id="USERNM" class="cmc_txt disabled" readonly="readonly" /></td>
			</tr>
			<tr>
				<th>프린터(라벨)</th>
				<td><input type="text" id="PRINT1" class="cmc_txt" maxlength="100" /></td>
			</tr>
			<tr>
				<th>프린터(A4)</th>
				<td><input type="text" id="PRINT2" class="cmc_txt" maxlength="100" /></td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
$(function() {
	$('#popPrint').lingoPopup({
		title: '사용자 프린터 정보 변경',
		width: 320,
		height: 300,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var flg = fn_save_popPrint();
					if (flg) {
						setPrintInfo();
						$(this).lingoPopup('setData', '');
						$(this).lingoPopup('close', 'OK');
					}
				}
			},
			'취소': {
				text: '취소',
				click: function() {
					$(this).lingoPopup('setData', '');
					$(this).lingoPopup('close');
				}
			}
		},
		open: function(data) {
			var param = {COMPCD: data.COMPCD, USERCD: data.USERCD};
			fn_search_popPrint(param);
		}
	});
});

//상세 검색
function fn_search_popPrint(param) {
	var sendData = {'paramData':param};
	var url = '/sys/popup/popPrint/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		var resultData = data.resultData;
		
		if(resultData != null){
			cfn_bindFormData('frmDetail_popPrint', resultData);
			$('#IDU').val("U");
		}else{
			$('#COMPCD').val(cfn_loginInfo().COMPCD);
			$('#USERCD').val(cfn_loginInfo().USERCD);
			$('#USERNM').val(cfn_loginInfo().USERNM);
			$('#IDU').val("I");
		}
		$('#frmDetail_popPrint #PRINT1').focus();
	});
}

//프린터 설정 변경 처리
function fn_save_popPrint() {
	//필수입력 체크
	if (!cfn_isFormRequireData('frmDetail_popPrint')) return false;
	
	var formData = cfn_getFormData('frmDetail_popPrint');
	
	var url = '/sys/popup/popPrint/setSave.do';
	var sendData = {paramData:formData};
	var flg = false;
	
	gfn_ajax(url, false, sendData, function(data, xhr) {
		flg = true;
	});
	
	return flg;
}
</script>