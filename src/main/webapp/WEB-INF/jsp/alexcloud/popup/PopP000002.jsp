<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popP000002
	화면명    : 팝업-사업자등록증 수정 팝업
-->
<div id="popP000002" class="pop_wrap">
	<form id="frmDetail_popP000002" action="#" onsubmit="return false">
		<input type="hidden" id="COMPCD" />
		<input type="hidden" id="ORIGINFILENM" /> <!-- 기존 업로드 파일 -->
		<input type="hidden" id="IDU" />
		
		<table class="tblForm" id="tblForm" style="min-width:300px">
			<colgroup>
				<col width="130px" />
		        <col />
		    </colgroup>
			<tr>
				<th>셀러코드</th>
				<td><input type="text" id="ORGCD" class="cmc_txt disabled" readonly="readonly" disabled="disabled"/></td>
			</tr>
			<tr>
				<th>셀러명</th>
				<td><input type="text" id="NAME" class="cmc_txt disabled" readonly="readonly" disabled="disabled"/></td>
			</tr>
			<!-- <tr>
				<th>사업자등록증(기존)</th>
				<td><input type="text" id="FILENAME" name="FILENAME" class="cmc_txt disabled" readonly="readonly" disabled="disabled" style="width:85%;"  /></td>
			</tr> -->
			<tr>
				<th>사업자 등록증</th>
				<td>
					<input type="FILE" id="UPLOADFILE" name="UPLOADFILE" onchange="fn_fileChange(this)" />
				</td>
			</tr>
			<tr>
				<th>파일용량</th>
				<td>
					<input type="text" id="UPLOADFILE_SIZE" name="UPLOADFILE_SIZE" value="0" class="cmc_txt disabled" readonly="readonly" disabled="disabled" style="text-align:right; "/> KB
				</td>
			</tr>
		</table>
		<span style="color : #FF0000; font-size: 12px; font-weight: bold;">※ 20MB 이하의 파일만 업로드 가능합니다.</span>
	</form>
</div>

<script type="text/javascript">
$(function() {
	$('#popP000002').lingoPopup({
		title: '사업자 등록증 변경',
		width: 520,
		height: 260,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var flg = fn_save_popP000002();
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
			var param = {COMPCD: data.COMPCD, ORGCD: data.ORGCD};
			fn_search_popP000002(param);
		}
	});
});

//상세 검색
function fn_search_popP000002(param) {
	var sendData = {'paramData':param};
	var url = '/alexcloud/popup/popP000002/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		var resultData = data.resultData;
		
		if(resultData != null){
			cfn_bindFormData('frmDetail_popP000002', resultData);
			$('#IDU').val("U");
		}else{
			cfn_msg('WARNING', '해당 셀러가 존재하지 않습니다.');
		}
	});
}

//파일 변경사항 반영
function fn_fileChange(param){
	
	if(!cfn_isEmpty(param.files[0])){
		var f = param.files[0].size;
		var fM = Math.round(f/1000)/1000;
		
		if(fM > 20){
			cfn_msg('WARNING', '파일 1개 용량은 20MB를 넘을 수 없습니다.');
			
			$('#UPLOADFILE').find("input:file").value = "";
			$('#UPLOADFILE_SIZE').val(Math.round(f/1000));
		}
		$('#UPLOADFILE_SIZE').val(Math.round(f/1000));
	} else {
		var f = 0;
		
		$('#UPLOADFILE_SIZE').val(Math.round(f/1000));
	}
}

//프린터 설정 변경 처리
function fn_save_popP000002() {
	
	//필수입력 체크
	if (!cfn_isFormRequireData('frmDetail_popP000002')) return false;
	
	var paramData = cfn_getFormData('frmDetail_popP000002');
	var flg = false;
	var fileData = new FormData();
	
	fileData.append('uploadFile', $('#UPLOADFILE')[0].files[0]);
	fileData.append('originfilenm', paramData.ORIGINFILENM);
	
	$.ajax({
		url: '/alexcloud/popup/popP000002/setFile.do',
		data: fileData,
		async : false,
		processData: false,
		contentType: false,
		type: 'POST',
		success: function (data) {
			var resultAttachFile = data.resultAttachFile;
			
			paramData.FILENM = resultAttachFile.FILENM
			paramData.ORIGINFILENM = resultAttachFile.ORIGINFILENM
			
			var url = '/alexcloud/popup/popP000002/setSave.do';
			var sendData = {'paramData':paramData};

			gfn_ajax(url, false, sendData, function(data, xhr) {
				flg = true;
			});	

	    },
	    	error: function (jqXHR) {
	    }
    });
	return flg;

}
</script>