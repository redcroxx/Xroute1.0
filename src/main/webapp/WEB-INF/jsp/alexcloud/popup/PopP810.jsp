<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popP810
	화면명    : 품목재고팝업 - 다중
-->

<div id="popP810" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popP810" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" class="cmc_code" />
			<input type="hidden" id="S_AFTERWHCD" class="cmc_code" /> <!-- 이동후 창고 -->
			<input type="hidden" id="S_AFTERLOCCD" class="cmc_code" /> <!-- 이동후 로케이션 -->
			<ul class="sech_ul">
				<li class="sech_li">
					<div>창고</div>
					<div>
						<input type="text" id="S_WHCD" class="cmc_code disabled" readonly="readonly"/>
						<input type="text" id="S_WHNM" class="cmc_value disabled" readonly="readonly"/>
					</div>
				</li>
				<li class="sech_li">
					<div>로케이션</div>
					<div>
						<input type="text" id="S_LOCCD" class="cmc_code" />
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">
					<div>셀러</div>
					<div>
						<input type="text" id="S_ORGCD" class="cmc_code disabled" readonly="readonly"/>
						<input type="text" id="S_ORGNM" class="cmc_value disabled" readonly="readonly"/>
					</div>
				</li>
				<li class="sech_li">
			  		<div>로트키</div>
					<div>
						<input type="text" id="S_LOTKEY" class="cmc_txt" />
					</div>
				</li>
			  	<li class="sech_li">
			  		<div>품목코드/명</div>
					<div>
						<input type="text" id="S_ITEM" class="cmc_txt" />
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popP810()"></button>
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
					<div class="grid_top_left">재고리스트<span>(총 0건)</span></div>
					<div class="grid_top_right"></div>
				</div>
				<div id="grid1_popP810"></div>
			</div>
			<div id="tab2Cont">
				<div class="ct_top_wrap">
					<div class="grid_top_wrap">
						<div class="grid_top_left">재고리스트<span>(총 0건)</span></div>
						<div class="grid_top_right"></div>
					</div>
					<div id="grid2_popP810"></div>
				</div>
				<div class="ct_bot_wrap">
					<div class="grid_top_wrap">
						<div class="grid_top_left">선택품목<span>(총 0건)</span></div>
						<div class="grid_top_right" >                                                     
							<input type="button" id="btn_add" class="cmb_plus" onclick="pfn_add()" />  
							<input type="button" id="btn_del" class="cmb_minus" onclick="pfn_del()" />                                                   
						</div>
					</div>
					<div id="grid3_popP810"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
/* 3개 그리드 : 컬럼  같음 전역변수로.*/
var columns = [
	{name:'WHNM',header:{text:'창고명'},width:100,styles:{textAlignment:'center'}},
	{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
	{name:'ITEMNM',header:{text:'품목명'},width:250},
	{name:'ITEMSIZE',header:{text:'규격'},width:60,styles:{textAlignment:'center'}},
	{name:'UNITCD',header:{text:'단위'},width:60,styles:{textAlignment:'center'}},
	{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
	{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},styles:{textAlignment:'center'}},
	{name:'LOCCD',header:{text:'로케이션'},width:80,styles:{textAlignment:'center'}},
	{name:'TOTAVAILQTY',header:{text:'총가용수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
	{name:'AVAILQTY',header:{text:'가용수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
	{name:'QTY',header:{text:'재고수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
	{name:'ALLOCQTY',header:{text:'할당수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
					footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
	{name:'AFTAVAILQTY',header:{text:'이동후가용수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
					footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
	{name:'LOTKEY',header:{text:'로트번호'},width:80,styles:{textAlignment:'center'}},
	
	{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1),show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
	{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2),show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
	{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3),show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
	{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',comboValue:gCodeLOT4,styles:{textAlignment:'center'}},
	{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',comboValue:gCodeLOT5,styles:{textAlignment:'center'}},
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
	{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
	{name:'COMPNM',header:{text:'회사명'},width:100,visible:false},
	{name:'WHCD',header:{text:'창고코드'},width:100,visible:false},
	{name:'ORGCD',header:{text:'셀러코드'},width:100,visible:false},
	{name:'ORGNM',header:{text:'셀러명'},width:100,visible:false},
	{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'},visible:false},
	{name:'ADDDATETIME',header:{text:'등록일시'},width:150,visible:false},
	{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'},visible:false},
	{name:'UPDDATETIME',header:{text:'수정일시'},width:150,visible:false},
	{name:'TERMINALCD',header:{text:'IP'},width:100,visible:false}
];

$(function() {
	$('#popP810').lingoPopup({
		title: '재고품목팝업',
		width:1400,
		height:800,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var tabidx = cfn_getTabIdx('tab1');
					
					if(tabidx === 1) {
						var checkRows = $('#grid1_popP810').gridView().getCheckedRows();
						
						if (checkRows.length === 0) {
							cfn_msg('WARNING','품목을 선택해주세요.');
							return false;
						}
						
						var gridData = $('#grid1_popP810').gfn_getDataRows(checkRows);
						
					} else if(tabidx === 2) {
						var gridData = $('#grid3_popP810').gfn_getDataList();

						if (gridData.length < 1) {
							cfn_msg('WARNING','품목을 선택해주세요.');
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
			cfn_bindFormData('frm_search_popP810', data);
			//회사별 상품정보 제어를 위한 함수 호출
			cfn_getCompItemInfo();
			
			if (cfn_isEmpty(data.S_COMPCD)) {
				$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
			}
			grid1_Load_popP810();
			grid2_Load_popP810();
			grid3_Load_popP810();
		
			var gridData = data.gridData;
			
			if (gridData.length > 0) {
				$('#grid1_popP810').gfn_setDataList(gridData);
			} else {
				fn_search_popP810();
			}
		}
	});
});

function grid1_Load_popP810() {
	var gid = 'grid1_popP810';
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid1_popP810').gfn_getCurRowIdx();
			var gridData = [$('#grid1_popP810').gfn_getDataRow(rowidx)];
			
			$('#popP810').lingoPopup('setData', gridData);
			$('#popP810').lingoPopup('close', 'OK');
		};
	});
}

function grid2_Load_popP810() {
	var gid = 'grid2_popP810';
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid2_popP810').gfn_getCurRowIdx();
			var gridData = $('#grid2_popP810').gfn_getDataRow(rowidx);
			
			$('#grid3_popP810').gfn_addRow(gridData);
		};
		
	});
}

function grid3_Load_popP810() {
	var gid = 'grid3_popP810';
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid3_popP810').gfn_getCurRowIdx();
			$('#grid3_popP810').gfn_delRow(rowidx);
		};
	});
}

/* 검색 */
function fn_search_popP810() {
	var paramData = cfn_getFormData('frm_search_popP810');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP810/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		var gridData = data.resultList;
		
		var tabidx = cfn_getTabIdx('tab1');
		
		if(tabidx === 1) {
			$('#grid1_popP810').gfn_setDataList(data.resultList);
		} else if(tabidx === 2) {
			$('#grid2_popP810').gfn_setDataList(data.resultList);
		}
	});
}

//선택품목으로 자리 옮기기
function pfn_add(){
	var checkRows = $('#grid2_popP810').gridView().getCheckedRows();
	var gridData = $('#grid2_popP810').gfn_getDataRows(checkRows);

	if (cfn_isEmpty(checkRows)) {
		cfn_msg('WARNING','품목을 선택해주세요.');
		return false;
	}
	for (var i=0, len=checkRows.length; i<len; i++) {
		$('#grid3_popP810').gfn_addRow(gridData[i]);
	}
	//체크해제
	$('#grid2_popP810').gridView().checkAll(false);
}

//선택품목에서 검색결과로 자리 옮기기
function pfn_del(){
	var checkRows = $('#grid3_popP810').gridView().getCheckedRows();
	if (cfn_isEmpty(checkRows)) {
		cfn_msg('WARNING','품목을 선택해주세요.');
		return false;
	}

	for (var i=checkRows.length - 1; i>=0; i--) {
		$('#grid3_popP810').gfn_delRow(checkRows[i]);
	}
}
</script>