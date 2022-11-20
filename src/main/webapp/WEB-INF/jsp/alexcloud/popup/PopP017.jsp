<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popP017
	화면명    : 팝업 - 품목분류(대,중,소)
-->
<div id="popP017" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popP017" action="#" onsubmit="return false">
			<input type="hidden" id="S_LVL3" />
			<input type="hidden" id="S_COMPCD" class="cmc_code" maxlength="20" readonly="readonly" disabled/>
			<ul class="sech_ul">
				<li class="sech_li">
			  		<div>품목분류코드/명</div>
					<div>
						<input type="text" id="S_ITEMCAT" class="cmc_txt" />
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popP017()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid_popP017"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#popP017').lingoPopup({
		title: '품목분류 검색',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					fn_popP017_ok();
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
			
			cfn_bindFormData('frm_search_popP017', data);
			
			if (cfn_isEmpty(data.S_COMPCD)) {
				$('#frm_search_popP017 #S_COMPCD').val(cfn_loginInfo().COMPCD);
			}
			//$('#frm_search_popP017 #S_COMPCD').triggerHandler({type:'keydown',keyCode:13});

			grid_Load_popP017();

			fn_search_popP017();
		}
	});
});

function grid_Load_popP017() {
	var gid = 'grid_popP017';
	var columns = [
		{name:'ITEMCATINFO',header:{text:'분류'},width:200},
		{name:'ITEMCATCD',header:{text:'분류코드'},width:100},
		{name:'NAME',header:{text:'분류명'},width:130},
		{name:'LVLNAME',header:{text:'단계'},width:80,styles:{textAlignment:'center'}},
		{name:'SORTNO',header:{text:'정렬순서'},width:80,styles:{textAlignment:'far'}},
		{name:'REMARK',header:{text:'비고'},width:200},
		{name:'LVL',header:{text:'부서레벨'},width:80,styles:{textAlignment:'far'},visible:false},	
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,visible:false},
		{name:'TREE',header:{text:'트리'},width:150,show:false}
	];
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {treeflg:true,panelflg:false,footerflg:false,sortable:false,fitStyle:'even'});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			fn_popP017_ok();
		};
		
	});
}

function fn_popP017_ok() {
	var rowidx = $('#grid_popP017').gfn_getCurRowIdx();
	var gridData = [$('#grid_popP017').gfn_getDataRow(rowidx)];
	
	if (gridData[0].LVL == '0') {
		cfn_msg('INFO', '회사(최상위)는 선택할 수 없습니다.');
		return false;
	}
	
	if ($('#frm_search_popP017 #S_LVL3').val().toUpperCase() === 'Y') {
		if (gridData[0].LVL != '3') {
			cfn_msg('INFO', '소분류만 선택 가능합니다.');
			return false;
		}
		
		gridData[0].ITEMCAT3CD = gridData[0].ITEMCATCD;
		gridData[0].ITEMCAT3NM = gridData[0].NAME;
		var lvl2_rowidx = $('#grid_popP017').dataProvider().getParent(rowidx);
		gridData[0].ITEMCAT2CD = $('#grid_popP017').gfn_getDataRow(lvl2_rowidx).ITEMCATCD;
		gridData[0].ITEMCAT2NM = $('#grid_popP017').gfn_getDataRow(lvl2_rowidx).NAME;
		var lvl3_rowidx = $('#grid_popP017').dataProvider().getParent(lvl2_rowidx);
		gridData[0].ITEMCAT1CD = $('#grid_popP017').gfn_getDataRow(lvl3_rowidx).ITEMCATCD;
		gridData[0].ITEMCAT1NM = $('#grid_popP017').gfn_getDataRow(lvl3_rowidx).NAME;
	}
	
	$('#popP017').lingoPopup('setData', gridData);
	$('#popP017').lingoPopup('close', 'OK');
}

//검색
function fn_search_popP017() {
	var paramData = cfn_getFormData('frm_search_popP017');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP017/searchTree.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		var gridData = data.resultList;
		var resultData = data.resultData;
		var $grid1 = $('#grid_popP017');
		
		$grid1.dataProvider().setRows(gridData, 'TREE', false);
		$grid1.gridView().expandAll();
		
		if (!cfn_isEmpty(resultData.S_ITEMCAT)) {
			var rowidxs = [], i = 0;
			do {
				i = $grid1.gridView().searchItem({fields:['ITEMCATCD','NAME'],values:[resultData.S_ITEMCAT,resultData.S_ITEMCAT],allFields:false,partialMatch:true,select:false,startIndex:i,wrap:false});
				if (i !== -1) {
					rowidxs.push($grid1.gridView().getDataRow(i));
					rowidxs = rowidxs.concat($grid1.dataProvider().getAncestors($grid1.gridView().getDataRow(i)));
					i++;
				}
			} while (i >= 0);
				
			rowidxs = rowidxs.reduce(function(a, b) {
				if (a.indexOf(b) < 0 ) a.push(b);
				return a;
			},[]).sort(function(a, b){
				return a - b;
			});
			
			gridData = $grid1.gfn_getDataRows(rowidxs);
			
			$grid1.dataProvider().setRows(gridData, 'TREE', false);
			$grid1.gridView().expandAll();
		}
	});
}

/* 자동 검색 */
/*
function fn_search_popP017() {
	var paramData = cfn_getFormData('frm_search_popP017');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP017/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popP017').gfn_setDataList(data.resultList);
	});
}
*/
</script>