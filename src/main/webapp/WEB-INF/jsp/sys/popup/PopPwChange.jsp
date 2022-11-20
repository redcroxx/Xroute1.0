<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : PopPwChange
	화면명    : 팝업-사용자 비밀번호 변경
-->
<div id="popPwChange" class="pop_wrap">
	<form id="frmDetail_popPwChange" action="#" onsubmit="return false">
		<input type="hidden" id="COMPCD" />
		
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
				<th class="required">이전비밀번호</th>
				<td><input type="password" id="OLDPASS" class="cmc_txt required" maxlength="20" /></td>
			</tr>
			<tr>
				<th class="required">신규비밀번호</th>
				<td><input type="password" id="NEWPASS" class="cmc_txt required" maxlength="20" /></td>
			</tr>
			<tr>
				<th class="required">신규비밀번호확인</th>
				<td><input type="password" id="NEWREPASS" class="cmc_txt required" maxlength="20" /></td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">

$(function() {	
	$('#popPwChange').lingoPopup({
		title: '사용자 비밀번호 변경',
		width: 320,
		height: 300,
		buttons: {
			/* '프린터 설정': {
				text: '프린터 설정',
				click: function() {
					//var userCD = cfn_loginInfo().USERCD;
					
					if(window.parent.loginObj != undefined){
						pfn_popupOpen({
							url: '/sys/popup/popPrint/view.do', 
							params: {'COMPCD':cfn_loginInfo().COMPCD,'USERCD':cfn_loginInfo().USERCD},
							returnFn: function(data, type) {
								if (type === 'OK') {
									cfn_msg('INFO', '정상적으로 처리되었습니다.');
								}
							}
						});
						$(this).lingoPopup('setData', '');
						$(this).lingoPopup('close', '');
					}else{
						cfn_msg('ERROR', '로그인 후 설정해주시기 바랍니다.');
					}
				}
			}, */
			'확인': {
				text: '확인',
				click: function() {
					var flg = fn_save_popPwChange();
					if (flg) {
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
			fn_search_popPwChange(param);
			
		}
	});
});

//상세 검색
function fn_search_popPwChange(param) {
	var sendData = {'paramData':param};
	var url = '/sys/popup/popPwChange/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		var resultData = data.resultData;
		cfn_bindFormData('frmDetail_popPwChange', resultData);
		$('#frmDetail_popPwChange #OLDPASS').focus();
	});
}

//비밀번호 변경 처리
function fn_save_popPwChange() {
	//필수입력 체크
	if (!cfn_isFormRequireData('frmDetail_popPwChange')) return false;
	
	var formData = cfn_getFormData('frmDetail_popPwChange');

	if (formData.NEWPASS.length < 6 || formData.NEWPASS.length > 20) {
		cfn_msg('WARNING', '비밀번호는 6~20자 이내로 입력하여 주시기 바랍니다.');
		$('#frmDetail_popPwChange #NEWPASS').focus();
		return false;
	} else if (formData.NEWPASS !== formData.NEWREPASS) {
		cfn_msg('WARNING', '신규비밀번호와 비밀번호확인이 일치하지 않습니다.');
		$('#frmDetail_popPwChange #NEWPASS').focus();
		return false;
	}
	
	var url = '/sys/popup/popPwChange/setSave.do';
	var sendData = {paramData:formData};
	var flg = false;
	
	gfn_ajax(url, false, sendData, function(data, xhr) {
		flg = true;
	});
	
	return flg;
}
</script>