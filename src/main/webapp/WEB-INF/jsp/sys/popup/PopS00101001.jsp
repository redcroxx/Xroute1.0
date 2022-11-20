<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : PopS00101001
	화면명    : 팝업-공통코드
-->
<div id="popS00101001" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popS00101001" action="#" onsubmit="return false">
			<input type="hidden" id="CODEKEY" />

			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div style="width:50px">코드</div>
					<div style="width:180px">
						<input type="text" id="CODE" class="cmc_txt" />
					</div>
				</li>
				<li class="sech_li">
					<div style="width:50px">명칭</div>
					<div>
						<input type="text" id="SNAME1" class="cmc_txt" />
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popS00101001()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid_popS00101001"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#popS00101001').lingoPopup({
		title: '공통코드 검색',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var rowidx = $('#grid_popS00101001').gfn_getCurRowIdx();
					var gridData = [$('#grid_popS00101001').gfn_getDataRow(rowidx)];
					
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
			cfn_bindFormData('frm_search_popS00101001', data);
			
			grid_Load_popS00101001();

			var gridData = data.gridData;
			
			if (gridData.length > 0) {
				$('#grid_popS00101001').gfn_setDataList(gridData);
			} else {
				fn_search_popS00101001();
			}
		}
	});
});

function grid_Load_popS00101001() {
	var gid = 'grid_popS00101001';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:100,visiable:false},
		{name:'CODEKEY',header:{text:'코드키'},width:100,visiable:false},
		{name:'CODE',header:{text:'코드'},width:100},
		{name:'SNAME1',header:{text:'명칭'},width:140},
		{name:'SNAME2',header:{text:'명칭2'},width:140},
		{name:'SNAME3',header:{text:'명칭3'},width:140},
		{name:'SNAME4',header:{text:'명칭4'},width:140},
		{name:'SNAME5',header:{text:'명칭5'},width:140}
    ];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns);
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onDataCellDblClicked = function(grid, index) {
			var gridData = [$('#' + gid).gfn_getDataRow(index.dataRow)];
			
			$('#popS00101001').lingoPopup('setData', gridData);
			$('#popS00101001').lingoPopup('close', 'OK');
		};
	});
}

/* 검색 */
function fn_search_popS00101001() {
	var paramData = cfn_getFormData('frm_search_popS00101001');
	var sendData = {'paramData':paramData};
	var url = '/sys/popup/popS00101001/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		var gridData = data.resultList;
		$('#grid_popS00101001').gfn_setDataList(gridData);
	});
}
</script>