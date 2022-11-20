<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P200100_Divpopup2
	화면명    : 복합품목 재고
-->
<div id="P200210_Divpopup2" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_P200210_Divpopup2" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" class="cmc_code" />
			<input type="hidden" id="S_ORGCD" class="cmc_code" />
			<input type="hidden" id="S_REG_SEQ" class="cmc_code" />
			<input type="hidden" id="S_SITE_CD" class="cmc_code" />
			<input type="hidden" id="S_ITEMCD" class="cmc_code" />
			<input type="hidden" id="S_ORDQTY" class="cmc_code" />
			<input type="hidden" id="S_WHCD" class="cmc_code" />
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
<div class="ct_left_wrap" ><!-- style="width:500px" -->
	<div class="grid_top_wrap">
		<div class="grid_top_left">검색결과<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid2"></div>
</div> 

</div>

<script type="text/javascript">
$(function() {
	$('#P200210_Divpopup2').lingoPopup({
		title: '복합코드재고확인',
		width: 560,
		height: 300,
		buttons: {
			'확인': {
				text: '취소',
				click: function() {
					$(this).lingoPopup('close', 'CANCEL');
				}
			}
		},
		open: function(data) {
			cfn_bindFormData('frm_search_P200210_Divpopup2', data);
			
			grid2_Load();

			fn_p200210_getSearchDivpopup2();			
		}
	});
});



function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:120},
		{name:'NAME',header:{text:'품목명'},width:170},
		{name:'ORDQTY',header:{text:'주문수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'INVQTY',header:{text:'가용재고'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}}
		
		
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	
}

/* 검색 */
 function fn_p200210_getSearchDivpopup2() {
	
	var paramData = cfn_getFormData('frm_search_P200210_Divpopup2');
	var url = '/alexcloud/p200/p200210_Divpopup2/getSearchDivpopup2.do';
	var sendData = {'paramData':paramData};
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		if (cfn_isEmpty(data.resultList)) {
			cfn_msg('WARNING', '검색결과가 존재하지 않습니다.');
			return false;
		}
		
		$('#grid2').gfn_setDataList(data.resultList);
	});	
} 
</script>