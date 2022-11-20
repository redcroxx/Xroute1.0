<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popP025
	화면명    : 팝업-품목(복합,단품)코드
-->
<div id="popP025" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popP025" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" class="cmc_code"/>
			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div style="width:80px">셀러</div>
					<div style="width:220px">
						<input type="text" id="S_ORGCD" class="cmc_code disabled" readonly="readonly" />
						<input type="text" id="S_ORGNM" class="cmc_value disabled" readonly="readonly" />
					</div>
				</li>
			  	<li class="sech_li">
			  		<div style="width:80px">품목코드/명</div>
					<div style="width:180px">
						<input type="text" id="S_PROD_CD" class="cmc_txt" />
					</div>
				</li>
			  	<li class="sech_li">
			  		<div>품목코드구분</div>
					<div style="width:180px">
						<select id="S_PROD_TYPE_CD" class="cmc_combo">
							<option value="">--전체--</option>
							<c:forEach var="i" items="${codePROD_TYPE_CD}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>	
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popP025_01()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
		<div style="width:490px; height:100%; position:relative; float:left; margin-right:10px;">
			<div class="grid_top_wrap">
				<div class="grid_top_left">품목마스터 리스트<span>(총 0건)</span></div>
				<div class="grid_top_right"></div>
			</div>
			<div id="grid_popP025_01"></div>
		</div>
		
		<div style="width:450px; height:100%; position:relative; float:left;">
			<div class="grid_top_wrap">
				<div class="grid_top_left">품목 상세 리스트<span>(총 0건)</span></div>
				<div class="grid_top_right"></div>
			</div>
			<div id="grid_popP025_02"></div>
		</div>
</div>

<script type="text/javascript">
$(function() {
	$('#popP025').lingoPopup({
		title: '품목(복합,단품)코드 검색',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var rowidx = $('#grid_popP025_01').gfn_getCurRowIdx();
					var gridData = [$('#grid_popP025_01').gfn_getDataRow(rowidx)];
					
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
			cfn_bindFormData('frm_search_popP025', data);
			
			if (cfn_isEmpty(data.S_COMPCD)) {
				$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
			}		
			
			grid_Load_popP025_01();
			grid_Load_popP025_02();

			var gridData = data.gridData;
			
			if (!cfn_isEmpty(gridData) && gridData.length > 0) {
				$('#grid_popP025_01').gfn_setDataList(data.gridData);
			} else {
				fn_search_popP025_01();
			}
		}
	});
});

function grid_Load_popP025_01() {
	var gid = 'grid_popP025_01';
	var columns = [
		{name:'PROD_CD',header:{text:'품목코드'},width:100},
		{name:'PROD_NM',header:{text:'품목명'},width:200},
		{name:'PROD_TYPE_CD',header:{text:'품목구분'},width:100,formatter:'combo',comboValue:'${gCodePROD_TYPE_CD}',styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,visible:false,show:false},
		{name:'ORGNM',header:{text:'셀러명'},width:140,visible:false,show:false}
	];

	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP025_01').gfn_getCurRowIdx();
			var gridData = [$('#grid_popP025_01').gfn_getDataRow(rowidx)];

			$('#popP025').lingoPopup('setData', gridData);
			$('#popP025').lingoPopup('close', 'OK');
		};
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			var compcd = $('#' + gid).gfn_getValue(newRowIdx, 'COMPCD');
			var orgcd = $('#' + gid).gfn_getValue(newRowIdx, 'ORGCD');
			var prodcd = $('#' + gid).gfn_getValue(newRowIdx, 'PROD_CD');
			var prodtypecd = $('#' + gid).gfn_getValue(newRowIdx, 'PROD_TYPE_CD');
			
			if(!cfn_isEmpty(prodcd)) {
				var param = {'COMPCD':compcd, 'ORGCD':orgcd, 'PROD_CD':prodcd, 'PROD_TYPE_CD':prodtypecd};
				fn_search_popP025_02(param);	
			}
		};
	});
}

function grid_Load_popP025_02() {
	var gid = 'grid_popP025_02';
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:100},
		{name:'ITEMNM',header:{text:'품목명'},width:200},
		{name:'SPROD_QTY',header:{text:'수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,visible:false,show:false}
	];

	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	
}
/* 검색 */
function fn_search_popP025_01() {
	var paramData = cfn_getFormData('frm_search_popP025');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP025/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popP025_01').gfn_setDataList(data.resultList);
	});
}
/* 상세검색 */
function fn_search_popP025_02(param) {
	var sendData = {'paramData':param};
	var url = '/alexcloud/popup/popP025/search2.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popP025_02').gfn_setDataList(data.resultList);
	});
}
</script>