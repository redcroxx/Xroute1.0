<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popS010
	화면명    : 팝업-사용자코드
-->
<div id="popS010" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popS010" action="#" onsubmit="return false">

			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div style="width:100px">사용자코드/명</div>
					<div style="width:180px">
						<input type="text" id="S_USERCD" class="cmc_txt" />
					</div>
				</li>
				<li class="sech_li">
					<div style="width:100px">부서코드/명</div>
					<div>
						<input type="text" id="S_DEPTCD" class="cmc_txt" />
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popS010()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid_popS010"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#popS010').lingoPopup({
		title: '사용자코드 검색',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var rowidx = $('#grid_popS010').gfn_getCurRowIdx();
					var gridData = [$('#grid_popS010').gfn_getDataRow(rowidx)];
					
					$(this).lingoPopup('setData', gridData);
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
			cfn_bindFormData('frm_search_popS010', data);
			
			grid_Load_popS010();

			var gridData = data.gridData;
			
			if (gridData.length > 0) {
				$('#grid_popS010').gfn_setDataList(data.gridData);
			} else {
				fn_search_popS010();
			}
		}
	});
});

function grid_Load_popS010() {
	var gid = 'grid_popS010';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'USERCD',header:{text:'사용자코드'},width:100},
		{name:'NAME',header:{text:'사용자명'},width:140},
		{name:'DEPTCD',header:{text:'부서코드'},width:100},
		{name:'DEPTNM',header:{text:'부서명'},width:140},
		{name:'USERGROUP',header:{text:'사용자그룹'},width:100,/*formatter:'combo',comboValue:'${gCodeCOSTS}', */styles:{textAlignment:'center'}},
		{name:'PHONENO',header:{text:'전화번호'},width:140},
		{name:'FAX',header:{text:'팩스'},width:140},
		{name:'EMAIL',header:{text:'이메일'},width:140},
		{name:'SEX',header:{text:'성별'},width:140},
		{name:'BIRTHDATE',header:{text:'생년월일'},width:90,formatter:'date',styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'사업장코드'},width:100},
		{name:'NAME',header:{text:'사업장명'},width:140}
	];


	//그리드 생성
	$('#' + gid).gfn_createGrid(columns);
	

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popS010').gfn_getCurRowIdx();
			var gridData = [$('#grid_popS010').gfn_getDataRow(rowidx)];

			$('#popS010').lingoPopup('setData', gridData);
			$('#popS010').lingoPopup('close', 'OK');
		};
		
	});
	
}

/* 검색 */
function fn_search_popS010() {
	var paramData = cfn_getFormData('frm_search_popS010');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popS010/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popS010').gfn_setDataList(data.resultList);
	});
}
</script>