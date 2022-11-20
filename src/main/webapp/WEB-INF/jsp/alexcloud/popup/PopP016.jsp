<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popP016
	화면명    : 팝업-부서코드
-->
<div id="popP016" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popP016" action="#" onsubmit="return false">
			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div>회사</div>
					<div>
						<input type="text" id="S_COMPCD" class="cmc_code disabled" readonly="readonly" />
						<input type="text" id="S_COMPNM" class="cmc_value disabled" readonly="readonly" />
					</div>
				</li>
			  	<li class="sech_li">
			  		<div>사업장</div>
					<div>
						<input type="text" id="S_ORGCD" class="cmc_code disabled" readonly="readonly" />
						<input type="text" id="S_ORGNM" class="cmc_value disabled" readonly="readonly" />
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div>부서코드/명</div>
					<div>
						<input type="text" id="S_DEPTCD" class="cmc_txt" />
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popP016()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid_popP016"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#popP016').lingoPopup({
		title: '부서코드 검색',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var rowidx = $('#grid_popP016').gfn_getCurRowIdx();
					var gridData = [$('#grid_popP016').gfn_getDataRow(rowidx)];
					
					if (!cfn_isEmpty(gridData[0].DEPTCD)) {
						$(this).lingoPopup('setData', gridData);
						$(this).lingoPopup('close', 'OK');
					} else {
						cfn_msg('INFO', '사업장은 선택할 수 없습니다.');
					}
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
			cfn_bindFormData('frm_search_popP016', data);
			
			if (cfn_isEmpty(data.S_COMPCD)) {
				$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
				$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
			}

			if (cfn_isEmpty(data.S_ORGCD)) {
				$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
				$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
			}
			
			grid_Load_popP016();

			var gridData = data.gridData;
			
			fn_search_popP016();
		}
	});
});

function grid_Load_popP016() {
	var gid = 'grid_popP016';
	var columns = [
		{name:'DEPTINFO',header:{text:'조직정보'},width:200},
		{name:'DEPTCD',header:{text:'부서코드'},width:100},
		{name:'NAME',header:{text:'부서명'},width:130},
		{name:'LVLNAME',header:{text:'단계'},width:80,styles:{textAlignment:'center'}},
		{name:'SORTNO',header:{text:'정렬순서'},width:80,styles:{textAlignment:'far'}},
		{name:'REMARK',header:{text:'비고'},width:200},
		{name:'LVL',header:{text:'부서레벨'},width:80,styles:{textAlignment:'far'},visible:false},	
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'ORGCD',header:{text:'사업장코드'},width:100,visible:false},
		{name:'ORGNM',header:{text:'사업장명'},width:100,visible:false},
		{name:'DEPTTREE',header:{text:'트리'},width:150,show:false}
	];
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {treeflg:true,panelflg:false,footerflg:false,sortable:false,fitStyle:'even'});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP016').gfn_getCurRowIdx();
			var gridData = [$('#grid_popP016').gfn_getDataRow(rowidx)];
			
			if (!cfn_isEmpty(gridData[0].DEPTCD)) {
				$('#popP016').lingoPopup('setData', gridData);
				$('#popP016').lingoPopup('close', 'OK');
			} else {
				cfn_msg('INFO', '사업장은 선택할 수 없습니다.');
			}
		};
		
	});
}

//검색
function fn_search_popP016() {
	var paramData = cfn_getFormData('frm_search_popP016');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP016/searchTree.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		var gridData = data.resultList;
		var resultData = data.resultData;
		var $grid1 = $('#grid_popP016');
		
		$grid1.dataProvider().setRows(gridData, 'DEPTTREE', false);
		$grid1.gridView().expandAll();
		
		if (!cfn_isEmpty(resultData.S_DEPTCD)) {
			var rowidxs = [], i = 0;
			do {
				i = $grid1.gridView().searchItem({fields:['DEPTCD','NAME'],values:[resultData.S_DEPTCD,resultData.S_DEPTCD],allFields:false,partialMatch:true,select:false,startIndex:i,wrap:false});
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
			
			$grid1.dataProvider().setRows(gridData, 'DEPTTREE', false);
			$grid1.gridView().expandAll();
		}
	});
}

/* 자동 검색 */
/*
function fn_search_popP016() {
	var paramData = cfn_getFormData('frm_search_popP016');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP016/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popP016').gfn_setDataList(data.resultList);
	});
}
*/
</script>