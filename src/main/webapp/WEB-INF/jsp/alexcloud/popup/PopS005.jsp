<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popS005
	화면명    : 팝업 - 프로그램코드
-->

<div id="popS005" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popS005" action="#" onsubmit="return false">
			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div style="width:100px">프로그램코드/명</div>
					<div style="width:180px">
						<input type="text" id="S_APPITEM" class="cmc_txt" />
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popS005A()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid_popS005"></div>
	</div>
</div>

<script type="text/javascript">

$(function() {
	$('#popS005').lingoPopup({
			title: '프로그램코드 검색',
			buttons : {
				'확인': {
					text: '확인',
					click: function() {
						var checkRows = $('#grid_popS005').gridView().getCheckedRows();
						var gridData = $('#grid_popS005').gfn_getDataRows(checkRows);
						
						if (checkRows.length === 0) {
							alert('프로그램을 선택해주세요.');
							return false;
						}			
/* 						var rowidx = $('#grid_popS005').gfn_getCurRowIdx();
						var gridData = [$('#grid_popS005').gfn_getDataRow(rowidx)]; */
						
						$(this).lingoPopup('setData',gridData);
						$(this).lingoPopup('close','OK');
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
			open: function(data){
				cfn_bindFormData('frm_search_popS005', data);
				
				grid_Load_popS005();
				
				var gridData = data.gridData;
				
				if (gridData.length > 0) {
					$('#grid_popS005').gfn_setDataList(gridData);
				} else {
					fn_search_popS005();
				}
			}
	});
});

function grid_Load_popS005(){
	var gid = 'grid_popS005';
	
	var columns = [
		{name:'APPKEY',header:{text:'프로그램코드'},width:90},
		{name:'APPNM',header:{text:'프로그램명'},width:250},
		{name:'APPURL',header:{text:'프로그램주소'},width:250},
		{name:'REMARK',header:{text:'비고'},width:200},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true, footerflg:false});
	
	//그리드 설정 및 이벤트 처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 더블 클릭
		gridView.onDataCellDblClicked = function (grid, index){
			var rowidx = $('#grid_popS005').gfn_getCurRowIdx();
			var gridData = [$('#grid_popS005').gfn_getDataRow(rowidx)];
			$('#popS005').lingoPopup('setData', gridData);
			$('#popS005').lingoPopup('close', 'OK');			
		};
	});
}

/* 검색 아이콘 눌렀을 경우 */
function fn_search_popS005(){
	var paramData = cfn_getFormData('frm_search_popS005');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popS005/search.do';
	
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popS005').gfn_setDataList(data.resultList);
	});
}
/* 팝업창에 검색 버튼 */
function fn_search_popS005A(){
	var paramData = cfn_getFormData('frm_search_popS005');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popS005/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popS005').gfn_setDataList(data.resultList);
	});
}
</script>