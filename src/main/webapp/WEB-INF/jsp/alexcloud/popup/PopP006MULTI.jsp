<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popP006MULTI
	화면명    : 팝업-품목코드(다중선택)
-->
<div id="popP006MULTI" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popP006MULTI" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" />
			<input type="hidden" id="S_SETYN" />
			<!-- <input type="hidden" id="CUSTCD" /> -->
			<input type="hidden" id="ITEMCD" />
			<input type="hidden" id="ITEMNM" />
			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div style="width:100px">셀러</div>
					<div>
						<input type="text" id="S_ORGCD" class="cmc_code required" />
						<input type="text" id="S_ORGNM" class="cmc_value" />
						<button type="button" class="cmc_cdsearch"></button>
					</div>
				</li>
			  	<li class="sech_li">
			  		<div style="width:100px">품목코드/명</div>
					<div style="width:180px">
						<input type="text" id="S_ITEMCD" class="cmc_txt" />
					</div>
				</li>
			  <!-- 	<li class="sech_li">
			  		<div style="width:100px">거래처코드/명</div>
					<div style="width:180px">
						<input type="text" id="S_CUSTCD" class="cmc_txt" />
					</div>
				</li> -->
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popP006MULTI()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	<div class="ct_top_wrap">
		<div id="tab1" class="ct_tab">
			<ul>
				<li id="tab1Click"><a href="#tab1Cont">다중</a></li>
				<li id="tab2Click"><a href="#tab2Cont">단일</a></li>
			</ul>
			<div id="tab1Cont">
				<div class="ct_top_wrap">
					<div class="grid_top_wrap">
						<div class="grid_top_left">검색결과<span>(총 0건)</span></div>
						<div class="grid_top_right"></div>
					</div>
					<div id="grid_popP006MULTI"></div>
				</div>
				<div class="ct_bot_wrap">
					<div class="grid_top_wrap">
						<div class="grid_top_left">선택품목<span>(총 0건)</span></div>
						<div class="grid_top_right" >                                                     
							<input type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid1RowAdd()" />  
							<input type="button" id="btn_rowDel" class="cmb_minus" onclick="fn_grid1RowDel()" />                                                   
						</div>
					</div>
					<div id="grid_popP006MULTIC"></div>
				</div>
			</div>
			<div id="tab2Cont">
				<div class="grid_top_wrap">
					<div class="grid_top_left">검색결과<span>(총 0건)</span></div>
					<div class="grid_top_right"></div>
				</div>
				<div id="grid_popP006MULTIA"></div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
var columns = [
	{name:'ITEMCD',header:{text:'품목코드'},width:100},
	{name:'NAME',header:{text:'품목명'},width:140},
	{name:'SNAME',header:{text:'품목명(약칭)'},width:140},
	{name:'ITEMTYPE',header:{text:'품목유형'},width:100},
	{name:'UNITCD',header:{text:'단위'},width:80},
	{name:'ITEMSIZE',header:{text:'규격'},width:80},
	
	{name:'UNITCOST',header:{text:'매입단가'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
	{name:'UNITPRICE',header:{text:'판매단가'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},

	{name:'ITEMCAT1NM',header:{text:'대분류'},width:100},
	{name:'ITEMCAT2NM',header:{text:'중분류'},width:100},
	{name:'ITEMCAT3NM',header:{text:'소분류'},width:100},
	{name:'SETYN',header:{text:'세트여부'},width:100,styles:{textAlignment:'center'}},
	{name:'INBOXQTY',header:{text:'박스입수량'},width:100},
	{name:'LENGTH',header:{text:'깊이'},width:100},
	{name:'WIDTH',header:{text:'폭'},width:100},
	{name:'HEIGHT',header:{text:'높이'},width:100},
	{name:'CAPACITY',header:{text:'용량'},width:100},
	{name:'MANUFACTURE',header:{text:'제조사'},width:100},
	{name:'MANUCOUNTRY',header:{text:'제조국'},width:100},
	/* {name:'CUSTNM',header:{text:'거래처(지정)'},width:100}, */
	
	{name:'CATEGORYCD',header:{text:'소분류코드'},width:100,visible:false},
	{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
	{name:'COMPNM',header:{text:'회사명'},width:100,visible:false}
];

$(function() {
	$('#popP006MULTI').lingoPopup({
		title: '품목코드 검색',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var tabidx = cfn_getTabIdx('tab1');
					
					if(tabidx === 1) {

						var gridData = $('#grid_popP006MULTIC').gfn_getDataList();

						if (gridData.length < 1) {
							alert('품목을 선택해주세요.');
							return false;
						}
						
						for(var x=0; x<gridData.length; x++){
							var itemcd=$('#ITEMCD').val();
							var itemnm=$('#ITEMNM').val();
							
							if(cfn_isEmpty(itemcd)){
								
								itemcd=$('#grid_popP006MULTIC').gfn_getValue(x,"ITEMCD");
								itemnm=$('#grid_popP006MULTIC').gfn_getValue(x,"NAME");
								
								$('#ITEMCD').val(itemcd);
								$('#ITEMNM').val(itemnm);
								
							}else{
								
								itemcd=itemcd+","+$('#grid_popP006MULTIC').gfn_getValue(x,"ITEMCD");
								itemnm=itemnm+","+$('#grid_popP006MULTIC').gfn_getValue(x,"NAME");
								
								$('#ITEMCD').val(itemcd);
								$('#ITEMNM').val(itemnm);
								
							}
						}
						
					} else if(tabidx === 2) {
						
						var checkRows = $('#grid_popP006MULTIA').gridView().getCheckedRows();
						var gridData = $('#grid_popP006MULTIA').gfn_getDataRows(checkRows);
						if (checkRows.length === 0) {
							alert('품목을 선택해주세요.');
							return false;
						}
						
						for(var x=0; x<gridData.length; x++){
							var itemcd=$('#ITEMCD').val();
							var itemnm=$('#ITEMNM').val();
							
							if(cfn_isEmpty(itemcd)){
								
								itemcd=gridData[x].ITEMCD;
								itemnm=gridData[x].NAME;
								
								$('#ITEMCD').val(itemcd);
								$('#ITEMNM').val(itemnm);
								
							}else{
								
								itemcd=itemcd+","+gridData[x].ITEMCD;
								itemnm=itemnm+","+gridData[x].NAME;
								
								$('#ITEMCD').val(itemcd);
								$('#ITEMNM').val(itemnm);
								
							}
						}
						
					}
					
					var gridData = [{'ITEMCD':itemcd,'NAME':itemnm}];
					
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
			cfn_bindFormData('frm_search_popP006MULTI', data);
	 		
			if (cfn_isEmpty(data.S_COMPCD)) {
				$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
			} 
			if (cfn_isEmpty(data.S_ORGCD)) {
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
					$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
					$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
					$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
					$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
				}
			}
			
			/* 셀러 */
			pfn_codeval({
				url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
				inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
				outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
			});
			
			grid_Load_popP006MULTI();
			grid_Load_popP006MULTIC();
			grid_Load_popP006MULTIA();

			var gridData = data.gridData;
			                         
			if (gridData.length > 0) {
				$('#grid_popP006MULTIA').gfn_setDataList(data.gridData);
			} else {
				fn_search_popP006MULTI();
			}
		}
	});
});

function grid_Load_popP006MULTI() {
	var gid = 'grid_popP006MULTI';
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true, footerflg:false});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP006MULTI').gfn_getCurRowIdx();
			var gridData = $('#grid_popP006MULTI').gfn_getDataRow(rowidx);
			$('#grid_popP006MULTIC').gfn_addRow(gridData);
		};
		
	});
}

function grid_Load_popP006MULTIC() {
	var gid = 'grid_popP006MULTIC';
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true, footerflg:false});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP006MULTIC').gfn_getCurRowIdx();
			$('#grid_popP006MULTIC').gfn_delRow(rowidx);
		};
		
	});

}

function grid_Load_popP006MULTIA() {
	var gid = 'grid_popP006MULTIA';
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true, footerflg:false});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP006MULTIA').gfn_getCurRowIdx();
			var gridData = [$('#grid_popP006MULTIA').gfn_getDataRow(rowidx)];
			$('#popP006MULTI').lingoPopup('setData', gridData);
			$('#popP006MULTI').lingoPopup('close', 'OK');
		};
		
	});
}

/* 검색 */
function fn_search_popP006MULTI() {
	var paramData = cfn_getFormData('frm_search_popP006MULTI');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP006MULTI/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		var gridData = data.resultList;
		
		var tabidx = cfn_getTabIdx('tab1');
		
		if(tabidx === 1) {
			$('#grid_popP006MULTI').gfn_setDataList(data.resultList);
		} else if(tabidx === 2) {
			$('#grid_popP006MULTIA').gfn_setDataList(data.resultList);
		}
	});
}

//검색결과에서 선택품목으로 자리 옮기기
function fn_grid1RowAdd(){
	var checkRows = $('#grid_popP006MULTI').gridView().getCheckedRows();
	var gridData = $('#grid_popP006MULTI').gfn_getDataRows(checkRows);

	if (cfn_isEmpty(checkRows)) {
		alert('품목을 선택해주세요.');
		return false;
	}
	for (var i=0, len=checkRows.length; i<len; i++) {
		$('#grid_popP006MULTIC').gfn_addRow(gridData[i]);
	}
	//체크해제
	$('#grid_popP006MULTI').gridView().checkAll(false);
}

//선택품목에서 검색결과로 자리 옮기기
function fn_grid1RowDel(){
	var checkRows = $('#grid_popP006MULTIC').gridView().getCheckedRows();
	
	if (cfn_isEmpty(checkRows)) {
		cfn_msg('WARNING', '품목을 선택해주세요.');
		return false;
	}
	
	for (var i=checkRows.length - 1; i>=0; i--) {
		$('#grid_popP006MULTIC').gfn_delRow(checkRows[i]);
	}
}
</script>