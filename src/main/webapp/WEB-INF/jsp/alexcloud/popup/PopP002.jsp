<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popP002
	화면명    : 팝업-셀러코드
-->
<div id="popP002" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popP002" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" class="cmc_code"/>
			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div style="width:100px">셀러코드/명</div>
					<div style="width:180px">
						<input type="text" id="S_ORGCD" class="cmc_txt" />
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popP002()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid_popP002"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#popP002').lingoPopup({
		title: '셀러코드 검색',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var rowidx = $('#grid_popP002').gfn_getCurRowIdx();
					var gridData = [$('#grid_popP002').gfn_getDataRow(rowidx)];
					
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
			cfn_bindFormData('frm_search_popP002', data);
			
			if (cfn_isEmpty(data.S_COMPCD)) {
				$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
				$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
			}
			
			grid_Load_popP002();

			var gridData = data.gridData;
			
			if (!cfn_isEmpty(gridData) && gridData.length > 0) {
				$('#grid_popP002').gfn_setDataList(data.gridData);
			} else {
				fn_search_popP002();
			}
		}
	});
});

function grid_Load_popP002() {
	var gid = 'grid_popP002';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100},
		{name:'NAME',header:{text:'셀러명'},width:140},
		{name:'SNAME',header:{text:'셀러명(약칭)'},width:140},
		{name:'TEL1',header:{text:'전화번호1'},width:140},
		{name:'TEL2',header:{text:'전화번호2'},width:140},
		{name:'FAX1',header:{text:'팩스1'},width:140},
		{name:'FAX2',header:{text:'팩스2'},width:140},
		{name:'POST',header:{text:'우편번호'},width:80},
		{name:'ADDR',header:{text:'주소'},width:200},
		{name:'CEO',header:{text:'대표자'},width:100},
		{name:'WEBADDR',header:{text:'홈페이지'},width:140},
		{name:'EMAIL',header:{text:'이메일'},width:140}
		
	];

	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP002').gfn_getCurRowIdx();
			var gridData = [$('#grid_popP002').gfn_getDataRow(rowidx)];

			$('#popP002').lingoPopup('setData', gridData);
			$('#popP002').lingoPopup('close', 'OK');
		};
		
	});
}

/* 검색 */
function fn_search_popP002() {
	var paramData = cfn_getFormData('frm_search_popP002');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP002/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popP002').gfn_setDataList(data.resultList);
	});
}
</script>