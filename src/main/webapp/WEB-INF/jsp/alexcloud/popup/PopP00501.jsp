<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popP00501
	화면명    : 팝업-로케이션코드
-->
<div id="popP00501" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popP00501" action="#" onsubmit="return false">
		<input type="hidden" id="S_COMPCD" class="cmc_code" />
		<input type="hidden" id="S_WHTYPE" class="cmc_code" />
			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div style="width:100px">로케이션/명</div>
					<div style="width:180px">
						<input type="text" id="S_LOCCD" class="cmc_txt" />
					</div>
				</li>
				<li class="sech_li">
					<div style="width:80px">로케이션타입</div>
					<div style="width:180px">	
						<select id="S_LOCTYPE" class="cmc_combo">
							<option value="">--전체--</option>
							<c:forEach var="i" items="${CODE_LOCTYPE}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>			
					</div>
				</li>
				<li class="sech_li">
			  		<div style="width:70px">창고</div>
					<div style="width:210px">
						<input type="text" id="S_WHCD" class="cmc_code disabled" readonly="readonly"/>
						<input type="text" id="S_WHNM" class="cmc_value disabled" readonly="readonly"/>
						<!-- <button type="button" class="cmc_cdsearch"></button> -->
					</div>
				</li>
			</ul>		
			<ul class="sech_ul">
				<li class="sech_li">
					<div style="width:100px">
						<select id="S_SPACEKEY" class="cmc_combo">
							<option value="BUIL">동(건물)</option>
							<option value="FLOOR">플로어</option>
							<option value="ZONE">존</option>
							<option value="LINE">열</option>
							<option value="RANGE">연</option>
							<option value="STEP">단</option>
							<option value="LANE">레인</option>
							<option value="LENGTH">깊이</option>
							<option value="WIDTH">폭</option>
							<option value="HEIGHT">높이</option>
							<option value="WEIGHTCAPACITY">가용중량</option>
							<option value="CAPACITY">가용수량</option>
						</select>	
					</div>
					<div style="width:180px">
						<input type="text" id="S_SPACEVAL" class="cmc_txt" />
					</div>
				</li>
				<li class="sech_li">
					<div style="width:80px">할당금지여부</div>
					<div style="width:180px">	
						<select id="S_NOTALLOCFLG" class="cmc_combo">
							<option value="">--전체--</option>
							<c:forEach var="i" items="${CODE_NOTALLOCFLG}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>			
					</div>
				</li>
				<li class="sech_li" id="itemli">
			  		<div style="width:70px">품목</div>
					<div style="width:210px">
						<input type="text" id="S_ITEMCD" class="cmc_code disabled" readonly="readonly"/>
						<input type="text" id="S_ITEMNM" class="cmc_value disabled" readonly="readonly"/>
						<!-- <button type="button" class="cmc_cdsearch"></button> -->
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popP00501()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid_popP00501"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#popP00501').lingoPopup({
		title: '로케이션코드 검색',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var rowidx = $('#grid_popP00501').gfn_getCurRowIdx();
					var gridData = [$('#grid_popP00501').gfn_getDataRow(rowidx)];
					
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
			cfn_bindFormData('frm_search_popP00501', data);
						
			grid_Load_popP00501();
			
			var gridData = data.gridData;
			
			if (gridData.length > 0) {
				$('#grid_popP00501').gfn_setDataList(data.gridData);
			} else {
				fn_search_popP00501();
			}
		}
	});
});

function grid_Load_popP00501() {
	var gid = 'grid_popP00501';
	var columns = [
		{name:'LOCCD',header:{text:'로케이션코드'},width:100},
		{name:'LOCNAME',header:{text:'로케이션명'},width:140},
		{name:'ITEMCD',header:{text:'품목코드'},width:100},
		{name:'ITEMNM',header:{text:'품목명'},width:250},
		{name:'INVQTY',header:{text:'가용수량'},dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'QTY',header:{text:'재고수량'},dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'ALLOCQTY',header:{text:'할당수량'},dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'LOTKEY',header:{text:'로트키'},width:100},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1), show:cfn_getLotVisible(1)},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2), show:cfn_getLotVisible(2)},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3), show:cfn_getLotVisible(3)},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:'${gCodeLOT4}'},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:'${gCodeLOT5}'},
		{name:'LOCGROUP',header:{text:'로케이션그룹'},width:100},
		{name:'ISVIRTUAL',header:{text:'가상여부'},width:100,formatter:'combo',comboValue:'${GCODE_YN}',styles:{textAlignment:'center'}},
		{name:'LOCTYPE',header:{text:'로케이션타입'},width:100,formatter:'combo',comboValue:'${GCODE_LOCTYPE}',styles:{textAlignment:'center'}},
		{name:'SLOTTYPE',header:{text:'입고유형'},width:120,formatter:'combo',comboValue:'${GCODE_SLOTTYPE}',styles:{textAlignment:'center'}},
		{name:'PICKTYPE',header:{text:'피킹유형'},width:120,formatter:'combo',comboValue:'${GCODE_PICKTYPE}',styles:{textAlignment:'center'}},
		{name:'ALLOCATETYPE',header:{text:'할당유형'},width:120,formatter:'combo',comboValue:'${GCODE_ALLOCATETYPE}',styles:{textAlignment:'center'}},
		{name:'NOTALLOCFLG',header:{text:'할당금지여부'},width:100,formatter:'combo',comboValue:'${GCODE_NOTALLOCFLG}',styles:{textAlignment:'center'}},
		{name:'WHINSEQ',header:{text:'입고순번'},width:80,styles:{textAlignment:'right'}},
		{name:'WHOUTSEQ',header:{text:'출고순번'},width:80,styles:{textAlignment:'right'}},
		{name:'BUIL',header:{text:'동(건물)'},width:100},
		{name:'FLOOR',header:{text:'플로어'},width:100},
		{name:'ZONE',header:{text:'존'},width:100},
		{name:'LINE',header:{text:'열'},width:100},
		{name:'RANGE',header:{text:'연'},width:100},
		{name:'STEP',header:{text:'단'},width:100},
		{name:'LANE',header:{text:'레인'},width:100},
		{name:'LENGTH',header:{text:'깊이'},width:100},
		{name:'WIDTH',header:{text:'폭'},width:100},
		{name:'HEIGHT',header:{text:'높이'},width:100},
		{name:'WEIGHTCAPACITY',header:{text:'가용중량'},width:100},
		{name:'CAPACITY',header:{text:'가용용량'},width:100},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'WHCD',header:{text:'창고코드'},width:100,visible:false}
	];
	$('#' + gid).gfn_createGrid(columns);
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP00501').gfn_getCurRowIdx();
			var gridData = [$('#grid_popP00501').gfn_getDataRow(rowidx)];

			$('#popP00501').lingoPopup('setData', gridData);
			$('#popP00501').lingoPopup('close', 'OK');
		};
	});
	
	//가상창고일때
	if($('#S_WHTYPE').val() != 'STD'){
		$('#grid_popP00501').gridView().setColumnProperty($('#grid_popP00501').gridView().columnByName('ITEMCD','visible'), 'visible',false);
		$('#grid_popP00501').gridView().setColumnProperty($('#grid_popP00501').gridView().columnByName('ITEMNM','visible'), 'visible',false);
		$('#grid_popP00501').gridView().setColumnProperty($('#grid_popP00501').gridView().columnByName('INVQTY','visible'), 'visible',false);
		$('#grid_popP00501').gridView().setColumnProperty($('#grid_popP00501').gridView().columnByName('QTY','visible'), 'visible',false);
		$('#grid_popP00501').gridView().setColumnProperty($('#grid_popP00501').gridView().columnByName('ALLOCQTY','visible'), 'visible',false);
		$('#grid_popP00501').gridView().setColumnProperty($('#grid_popP00501').gridView().columnByName('LOTKEY','visible'), 'visible',false);
		$('#grid_popP00501').gridView().setColumnProperty($('#grid_popP00501').gridView().columnByName('LOT1','visible'), 'visible',false);
		$('#grid_popP00501').gridView().setColumnProperty($('#grid_popP00501').gridView().columnByName('LOT2','visible'), 'visible',false);
		$('#grid_popP00501').gridView().setColumnProperty($('#grid_popP00501').gridView().columnByName('LOT3','visible'), 'visible',false);
		$('#grid_popP00501').gridView().setColumnProperty($('#grid_popP00501').gridView().columnByName('LOT4','visible'), 'visible',false);
		$('#grid_popP00501').gridView().setColumnProperty($('#grid_popP00501').gridView().columnByName('LOT5','visible'), 'visible',false);
		
		$('#itemli').hide();
	}
}

/* 검색 */
function fn_search_popP00501() {
	var paramData = cfn_getFormData('frm_search_popP00501');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP00501/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popP00501').gfn_setDataList(data.resultList);
	});
}
</script>