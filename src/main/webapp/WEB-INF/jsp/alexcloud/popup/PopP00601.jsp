<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popP00601
	화면명    : 팝업 - 품목코드
-->
<div id="popP00601" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popP00601" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" />
			<input type="hidden" id="WHCD" />
			<input type="hidden" id="ORGCD" />
			<input type="hidden" id="S_SETYN" />
			<!-- <input type="hidden" id="CUSTCD" /> -->
			<ul class="sech_ul">
				<li class="sech_li">
			  		<div style="width:50px">셀러</div>
					<div>
						<input type="text" id="S_ORGCD" class="cmc_code disabled" readonly="readonly" />
						<input type="text" id="S_ORGNM" class="cmc_value disabled" readonly="readonly" />
					</div>
				</li>
			  	<li class="sech_li">
			  		<div style="width:100px">품목코드/명</div>
					<div style="width:180px">
						<input type="text" id="S_ITEMCD" class="cmc_txt" />
					</div>
				</li>
			  	<!-- <li class="sech_li">
			  		<div style="width:100px">거래처코드/명</div>
					<div style="width:180px">
						<input type="text" id="S_CUSTCD" class="cmc_txt" />
					</div>
				</li> -->
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popP00601()"></button>
			<div id="sech_extbtn" class="down"></div>
			<div id="sech_extline"></div>
			<div id="sech_extwrap">
				<c:import url="/comm/compItemSearch.do" />
			</div>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	<div class="ct_top_wrap">
		<div id="tab1" class="ct_tab">
			<ul>
				<li id="tab1Click"><a href="#tab1Cont">단일</a></li>
				<li id="tab2Click"><a href="#tab2Cont">다중</a></li>
			</ul>
			<div id="tab1Cont">
				<div class="grid_top_wrap">
					<div class="grid_top_left">검색결과</div>
					<div class="grid_top_right"></div>
				</div>
				<div id="grid_popP00601A"></div>
			</div>
			<div id="tab2Cont">
				<div class="ct_top_wrap">
					<div class="grid_top_wrap">
						<div class="grid_top_left">검색결과</div>
						<div class="grid_top_right"></div>
					</div>
					<div id="grid_popP00601"></div>
				</div>
				<div class="ct_bot_wrap">
					<div class="grid_top_wrap">
						<div class="grid_top_left">선택품목</div>
						<div class="grid_top_right" >                                                     
							<input type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid1RowAdd()" />  
							<input type="button" id="btn_rowDel" class="cmb_minus" onclick="fn_grid1RowDel()" />                                                   
						</div>
					</div>
					<div id="grid_popP00601C"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
var columns = [
	{name:'ITEMCD',header:{text:'품목코드'},width:100},
	{name:'NAME',header:{text:'품목명'},width:140},
	{name:'SNAME',header:{text:'품목명(약칭)'},width:140},
	{name:'ITEMTYPE',header:{text:'품목유형'},width:100,formatter:'combo',comboValue:'${gCodeITEMTYPE}',styles:{textAlignment:'center'}},
	{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
	{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
	{name:'UNITTYPE',header:{text:'관리단위'},width:100,styles:{textAlignment:'center'},formatter:'combo',comboValue:'${gCodeUNITTYPE}'},
	
	{name:'UNITCOST',header:{text:'매입단가'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
	{name:'UNITPRICE',header:{text:'판매단가'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
	{name:'INVQTY',header:{text:'가용재고'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
	
	{name:'ITEMCAT1NM',header:{text:'대분류'},width:100},
	{name:'ITEMCAT2NM',header:{text:'중분류'},width:100},
	{name:'ITEMCAT3NM',header:{text:'소분류'},width:100},
	{name:'SETYN',header:{text:'세트여부'},width:100,formatter:'combo',comboValue:'${gCodeSETYN}',styles:{textAlignment:'center'}},
	{name:'INBOXQTY',header:{text:'박스입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
	{name:'INPLTQTY',header:{text:'팔레트입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
	{name:'LENGTH',header:{text:'깊이'},width:100},
	{name:'WIDTH',header:{text:'폭'},width:100},
	{name:'HEIGHT',header:{text:'높이'},width:100},
	{name:'CAPACITY',header:{text:'용량'},width:100},
	{name:'MANUFACTURE',header:{text:'제조사'},width:100},
	{name:'MANUCOUNTRY',header:{text:'제조국'},width:100},
	/* {name:'CUSTNM',header:{text:'거래처(지정)'},width:100}, */
	{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(1)},
	{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(2)},
	{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(3)},
	{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(4)},
	{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(5)},
	{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100, visible:cfn_getCompItemVisible(11)},
	{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100, visible:cfn_getCompItemVisible(12)},
	{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100, visible:cfn_getCompItemVisible(13)},
	{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100, visible:cfn_getCompItemVisible(14)},
	{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100, visible:cfn_getCompItemVisible(15)},
	{name:'CATEGORYCD',header:{text:'소분류코드'},width:100,visible:false},
	{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
	{name:'COMPNM',header:{text:'회사명'},width:100,visible:false}
];

$(function() {
	$('#popP00601').lingoPopup({
		title: '품목코드 검색',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var tabidx = cfn_getTabIdx('tab1');
					
					if(tabidx === 1) {
						var checkRows = $('#grid_popP00601A').gridView().getCheckedRows();
						var gridData = $('#grid_popP00601A').gfn_getDataRows(checkRows);
						if (checkRows.length === 0) {
							alert('품목을 선택해주세요.');
							return false;
						}
						
					} else if(tabidx === 2) {
						var gridData = $('#grid_popP00601C').gfn_getDataList();

						if (gridData.length < 1) {
							alert('품목을 선택해주세요.');
							return false;
						}
					}
					
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
			cfn_bindFormData('frm_search_popP00601', data);
			
			if (cfn_isEmpty(data.S_COMPCD)) {
				$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
			}
			if (cfn_isEmpty(data.WHCD)) {
				$('#WHCD').val(cfn_loginInfo().WHCD);
			}
			if (cfn_isEmpty(data.ORGCD)) {
				$('#ORGCD').val(cfn_loginInfo().ORGCD);
			}
			
			//회사별 상품정보 제어를 위한 함수 호출
			cfn_getCompItemInfo();
			
			grid_Load_popP00601();
			grid_Load_popP00601C();
			grid_Load_popP00601A();

			var gridData = data.gridData;
			
			if (gridData.length > 0) {
				$('#grid_popP00601A').gfn_setDataList(data.gridData);
			} else {
				fn_search_popP00601();
			}
		}
	});
});

function grid_Load_popP00601() {
	var gid = 'grid_popP00601';
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true, footerflg:false});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP00601').gfn_getCurRowIdx();
			var gridData = $('#grid_popP00601').gfn_getDataRow(rowidx);
			$('#grid_popP00601C').gfn_addRow(gridData);
		};
		
	});
}

function grid_Load_popP00601C() {
	var gid = 'grid_popP00601C';
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true, footerflg:false});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP00601C').gfn_getCurRowIdx();
			$('#grid_popP00601C').gfn_delRow(rowidx);
		};
		
	});

}

function grid_Load_popP00601A() {
	var gid = 'grid_popP00601A';
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true, footerflg:false});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP00601A').gfn_getCurRowIdx();
			var gridData = [$('#grid_popP00601A').gfn_getDataRow(rowidx)];
			$('#popP00601').lingoPopup('setData', gridData);
			$('#popP00601').lingoPopup('close', 'OK');
		};
		
	});
}

/* 검색 */
function fn_search_popP00601() {
	var paramData = cfn_getFormData('frm_search_popP00601');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP00601/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		var gridData = data.resultList;
		
		var tabidx = cfn_getTabIdx('tab1');
		
		if(tabidx === 1) {
			$('#grid_popP00601A').gfn_setDataList(data.resultList);
		} else if(tabidx === 2) {
			$('#grid_popP00601').gfn_setDataList(data.resultList);
		}
	});
}

//검색결과에서 선택품목으로 자리 옮기기
function fn_grid1RowAdd(){
	var checkRows = $('#grid_popP00601').gridView().getCheckedRows();
	var gridData = $('#grid_popP00601').gfn_getDataRows(checkRows);

	if (cfn_isEmpty(checkRows)) {
		alert('품목을 선택해주세요.');
		return false;
	}
	for (var i=0, len=checkRows.length; i<len; i++) {
		$('#grid_popP00601C').gfn_addRow(gridData[i]);
	}
	//체크해제
	$('#grid_popP00601').gridView().checkAll(false);
}

//선택품목에서 검색결과로 자리 옮기기
function fn_grid1RowDel(){
	var checkRows = $('#grid_popP00601C').gridView().getCheckedRows();
	
	if (cfn_isEmpty(checkRows)) {
		cfn_msg('WARNING', '품목을 선택해주세요.');
		return false;
	}
	
	for (var i=checkRows.length - 1; i>=0; i--) {
		$('#grid_popP00601C').gfn_delRow(checkRows[i]);
	}
}
</script>