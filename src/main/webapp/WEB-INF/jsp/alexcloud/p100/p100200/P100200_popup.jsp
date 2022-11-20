<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100200_popup
	화면명    : 팝업 - 미입고 애터미 발주내역 팝업
-->
<div id="P100200_popup" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_P100200_popup" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" class="cmc_code" />
			<input type="hidden" id="S_ORGCD" class="cmc_code" />
			<input type="hidden" id="S_WHCD" class="cmc_code" />
			<!-- <input type="hidden" id="S_CUSTCD" class="cmc_code" /> -->
			<input type="hidden" id="S_ITEMCD" class="cmc_code" />
			<ul class="sech_ul">
				<li class="sech_li">
					<div>구매일자</div>
					<div>
						<input type="text" id="S_ORDERDATE_FROM" class="cmc_date"/> ~
						<input type="text" id="S_ORDERDATE_TO" class="cmc_date"/>
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_P100200_popup_search()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
		
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid_P100200_popup"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#P100200_popup').lingoPopup({
		title: '미입고 애터미 발주내역',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var rowidx = $('#grid_P100200_popup').gfn_getCurRowIdx();
					var gridData = [$('#grid_P100200_popup').gfn_getDataRow(rowidx)];
					
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
			cfn_bindFormData('frm_search_P100200_popup', data);
			$('#S_ORDERDATE_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
			$('#S_ORDERDATE_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
			grid_P100200_popup_Load();

			var gridData = data.gridData;
			
			if (!cfn_isEmpty(gridData) && gridData.length > 0) {
				$('#grid_P100200_popup').gfn_setDataList(data.gridData);
			} else {
				fn_P100200_popup_search();
			}
		}
	});
});

function grid_P100200_popup_Load() {
	var gid = 'grid_P100200_popup';
	var columns = [
		{name:'ORDERNO',header:{text:'구매번호'},width:120},
		{name:'ORDERSUBNO',header:{text:'상세번호'},width:100},
		{name:'ORDERSEQ',header:{text:'SEQ'},width:80,styles:{textAlignment:'far'}},
		{name:'ORDERDATE',header:{text:'구매일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'TYPE',header:{text:'타입명'},width:100,formatter:'combo',comboValue:'${gCodeATOMY_INTERFACE}',styles:{textAlignment:'center'}},
		{name:'STOCKDATE',header:{text:'입고예정일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'PLANTCODE',header:{text:'플랜트코드'},width:100},
		{name:'PLANTNAME',header:{text:'플랜트'},width:120},
		{name:'STORAGECODE',header:{text:'스토리지코드'},width:100},
		{name:'STORAGENAME',header:{text:'스토리지'},width:120},
		{name:'MATERIALCODE',header:{text:'품목코드'},width:100},
		{name:'MATERIALNAME',header:{text:'품목명'},width:250},
		{name:'STOCKCOUNT',header:{text:'발주서수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'COMPANYCODE',header:{text:'공급처코드'},width:100},
		{name:'COMPANYNAME',header:{text:'공급처명'},width:120},
		{name:'WHCD',header:{text:'창고코드'},width:80},
		{name:'WHNM',header:{text:'창고명'},width:100},
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,visible:false,show:false},
		{name:'IDX',header:{text:'IDX'},width:100,visible:false,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns);
	

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_P100200_popup').gfn_getCurRowIdx();
			var gridData = [$('#grid_P100200_popup').gfn_getDataRow(rowidx)];

			$('#P100200_popup').lingoPopup('setData', gridData);
			$('#P100200_popup').lingoPopup('close', 'OK');
		};
		
	});
}

/* 검색 */
function fn_P100200_popup_search() {
	var paramData = cfn_getFormData('frm_search_P100200_popup');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/p100/p100200_popup/getSearch.do';
		
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_P100200_popup').gfn_setDataList(data.resultList);
	});	
	
}

</script>