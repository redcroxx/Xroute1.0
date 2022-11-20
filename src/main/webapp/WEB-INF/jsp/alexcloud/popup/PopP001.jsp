<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popP001
	화면명    : 팝업-회사코드
-->
<div id="popP001" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popP001" action="#" onsubmit="return false">

			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div style="width:100px">회사코드/명</div>
					<div style="width:180px">
						<input type="text" id="S_COMPCD" class="cmc_txt" />
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popP001()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid_popP001"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#popP001').lingoPopup({
		title: '회사코드 검색',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var rowidx = $('#grid_popP001').gfn_getCurRowIdx();
					var gridData = [$('#grid_popP001').gfn_getDataRow(rowidx)];
					
					$(this).lingoPopup('setData', gridData);
					$(this).lingoPopup('close', 'OK');
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
			cfn_bindFormData('frm_search_popP001', data);
			
			grid_Load_popP001();

			var gridData = data.gridData;
			
			if (!cfn_isEmpty(gridData) && gridData.length > 0) {
				$('#grid_popP001').gfn_setDataList(data.gridData);
			} else {
				fn_search_popP001();
			}
		}
	});
});

function grid_Load_popP001() {
	var gid = 'grid_popP001';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'NAME',header:{text:'회사명'},width:140},
		{name:'SNAME',header:{text:'회사명(약칭)'},width:140},
		{name:'TEL1',header:{text:'전화번호1'},width:140},
		{name:'TEL2',header:{text:'전화번호2'},width:140},
		{name:'FAX1',header:{text:'팩스1'},width:140},
		{name:'FAX2',header:{text:'팩스2'},width:140},
		{name:'POST',header:{text:'우편번호'},width:80},
		{name:'ADDR',header:{text:'주소'},width:200},
		{name:'ADDR2',header:{text:'상세주소'},width:100},
		{name:'CEO',header:{text:'대표자'},width:100},
		{name:'BIZNO1',header:{text:'사업자번호1'},width:100},
		{name:'BIZNO2',header:{text:'사업자번호2'},width:100},
		{name:'BIZKIND',header:{text:'업태'},width:100},
		{name:'BIZTYPE',header:{text:'업종'},width:100},
		{name:'EMAIL',header:{text:'이메일'},width:140},
		{name:'WEBADDR',header:{text:'홈페이지'},width:140},
		{name:'NATION',header:{text:'국가'},width:100},
		{name:'REMARK',header:{text:'비고'},width:150},
		{name:'ISUSING',header:{text:'사용여부'},width:150},
	];

	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP001').gfn_getCurRowIdx();
			var gridData = [$('#grid_popP001').gfn_getDataRow(rowidx)];

			$('#popP001').lingoPopup('setData', gridData);
			$('#popP001').lingoPopup('close', 'OK');
		};
		
	});
}

/* 검색 */
function fn_search_popP001() {
	var paramData = cfn_getFormData('frm_search_popP001');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP001/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popP001').gfn_setDataList(data.resultList);
	});
}
</script>