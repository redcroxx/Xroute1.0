<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : PopP81001
	화면명    : 재고팝업 - 단일
-->
<div id="popP81001" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popP81001" action="#" onsubmit="return false">
			<input type="hidden" id="S_LOT1" />
			<input type="hidden" id="S_LOT2" />
			<input type="hidden" id="S_LOT3" />
			<input type="hidden" id="S_LOT4" />
			<input type="hidden" id="S_LOT5" />
			<input type="hidden" id="S_NOTALLOCFLG" />
			<input type="hidden" id="S_LOTRESERVEFLG" />
			
			<ul class="sech_ul">
				<li class="sech_li">
					<div>셀러</div>
					<div>
						<input type="text" id="S_ORGCD" class="cmc_code disabled" readonly="readonly" />
						<input type="text" id="S_ORGNM" class="cmc_value disabled" readonly="readonly" />
					</div>
				</li>
				<li class="sech_li">
					<div>창고</div>
					<div>
						<input type="text" id="S_WHCD" class="cmc_code disabled" readonly="readonly" />
						<input type="text" id="S_WHNM" class="cmc_value disabled" readonly="readonly" />
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">
			  		<div>품목</div>
					<div>
						<input type="text" id="S_ITEMCD" class="cmc_code disabled" readonly="readonly" />
						<input type="text" id="S_ITEMNM" class="cmc_value disabled" readonly="readonly" />
					</div>
				</li>
				<li class="sech_li">
					<div>로케이션</div>
					<div>
						<input type="text" id="S_LOCCD" class="cmc_txt" />
					</div>
				</li>
				<!-- 
				<li class="sech_li">
			  		<div>로트키</div>
					<div>
						<input type="text" id="S_LOTKEY" class="cmc_txt" />
					</div>
				</li>
				 -->
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popP81001()"></button>
			<div id="sech_extbtn" class="down"></div>
			<div id="sech_extline"></div>
			<div id="sech_extwrap">
				<c:import url="/comm/compItemSearch.do" />
			</div>
		</form>
	</div>
	
	<!-- 검색조건영역 끝 -->
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">재고리스트</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid1_popP81001"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#popP81001').lingoPopup({
		title: '재고품목팝업',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var rowidx = $('#grid1_popP81001').gfn_getCurRowIdx();
					
					if (rowidx < 0) {
						cfn_msg('WARNING', '선택한 항목이 없습니다.');
						return false;
					}
					
					var gridData = [$('#grid1_popP81001').gfn_getDataRow(rowidx)];
					
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
			cfn_bindFormData('frm_search_popP81001', data);
			
			//회사별 상품정보 제어를 위한 함수 호출
			cfn_getCompItemInfo();
			grid1_Load_popP81001();

			var gridData = data.gridData;
			
			if (gridData.length > 0) {
				$('#grid1_popP81001').gfn_setDataList(gridData);
			} else {
				fn_search_popP81001();
			}
		}
	});
});

function grid1_Load_popP81001() {
	var gid = 'grid1_popP81001';
	var columns = [
		{name:'LOCCD',header:{text:'로케이션'},width:100},
		{name:'LOCNAME',header:{text:'로케이션명'},width:100},
		{name:'ITEMCD',header:{text:'품목코드'},width:100},
		{name:'ITEMNM',header:{text:'품목명'},width:200},
		{name:'ITEMSIZE',header:{text:'규격'},width:60},
		{name:'UNITCD',header:{text:'단위'},width:60},
		{name:'LOTKEY',header:{text:'로트번호'},width:80},
		{name:'AVAILQTY',header:{text:'가용수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'QTY',header:{text:'재고수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
					footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'ALLOCQTY',header:{text:'할당수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
						footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:110, formatter:cfn_getLotType(1), show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:110, formatter:cfn_getLotType(2), show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3), show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},editable:true,comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},editable:true,comboValue:gCodeLOT5},
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100,show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100,show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100,show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100,show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100,show:cfn_getCompItemVisible(15)},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'WHCD',header:{text:'창고코드'},width:100},
		{name:'WHNM',header:{text:'창고명'},width:100},
		{name:'ORGCD',header:{text:'셀러코드'},width:100},
		{name:'ORGNM',header:{text:'셀러명'},width:100}
	];
	$('#' + gid).gfn_createGrid(columns);

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid1_popP81001').gfn_getCurRowIdx();
			var gridData = [$('#grid1_popP81001').gfn_getDataRow(rowidx)];
			
			$('#popP81001').lingoPopup('setData', gridData);
			$('#popP81001').lingoPopup('close', 'OK');
		};
	});
}

/* 검색 */
function fn_search_popP81001() {
	var paramData = cfn_getFormData('frm_search_popP81001');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP81001/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		var gridData = data.resultList;
		$('#grid1_popP81001').gfn_setDataList(gridData);
	});
}
</script>