<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : PopS120
	화면명    : 전자결재 문서 확인용 팝업
-->
<div id="PopS120" class="pop_wrap">
	<div id="ct_sech_wrap">
		<form id="frm_search_PopS120" action="#" onsubmit="return false">
		<input type="hidden" id="DOCNO" class="cmc_code" />
		<input type="hidden" id="REFNO1" class="cmc_code" />
		<div id="DOCHTML_V"></div>
		</form>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#PopS120').lingoPopup({
		title: '전자결재문서',
		buttons: {
			'닫기': {
				text: '닫기',
				click: function() {
					$(this).lingoPopup('setData', '');
					$(this).lingoPopup('close', 'CANCEL');
				}
			}
		},
		open: function(data) {
			cfn_bindFormData('frm_search_PopS120', data);
			
			fn_PopS120_search();
		}
	});
});

/* 검색 */
function fn_PopS120_search() {
	var paramData = cfn_getFormData('frm_search_PopS120');
		
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/PopS120/getSearch.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		var gridData = data.resultList;
		$('#DOCHTML').val(gridData[0].DOCHTML);
		var dochtml = document.getElementById("DOCHTML_V");
		dochtml.innerHTML = gridData[0].DOCHTML;
		});	
	}

</script>