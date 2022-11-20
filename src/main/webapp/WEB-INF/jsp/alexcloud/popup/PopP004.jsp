<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popP004
	화면명    : 팝업-창고코드
-->
<div id="popP004" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popP004" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" />
			
			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div style="width:80px">창고코드/명</div>
					<div style="width:150px">
						<input type="text" id="S_WHCD" class="cmc_txt" />
					</div>
				</li>
			  	<!-- <li class="sech_li">
			  		<div style="width:100px">거래처코드/명</div>
					<div style="width:150px">
						<input type="text" id="S_CUSTCD" class="cmc_txt" />
					</div>
				</li> -->
				<!-- <li class="sech_li">
					<div style="width:120px">
						<select id="S_LOCCDKEY" name="S_LOCCDKEY" class="cmc_combo" style="width:110px">
							<option value="WHINLOCCD">입고대기로케이션</option>
							<option value="WHOUTLOCCD">출고대기로케이션</option>
							<option value="RETURNLOCCD">반품로케이션</option>
							<option value="ASSYLOCCD">가공로케이션</option>
						</select>	
					</div>
					<div>
						<input type="text" id="S_LOCCDVAL" class="cmc_txt" />
					</div>
				</li> -->
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popP004()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid_popP004"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#popP004').lingoPopup({
		title: '창고코드 검색',
		width:1400,
		height:800,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var rowidx = $('#grid_popP004').gfn_getCurRowIdx();
					var gridData = [$('#grid_popP004').gfn_getDataRow(rowidx)];
					
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
			cfn_bindFormData('frm_search_popP004', data);
			
			if (cfn_isEmpty(data.S_COMPCD)) {
				$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
			}
			
			grid_Load_popP004();

			var gridData = data.gridData;
			
			if (gridData.length > 0) {
				$('#grid_popP004').gfn_setDataList(data.gridData);
			} else {
				fn_search_popP004();
			}
		}
	});
});

function grid_Load_popP004() {
	var gid = 'grid_popP004';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'WHCD',header:{text:'창고코드'},width:100},
		{name:'NAME',header:{text:'창고명'},width:150,styles:{textAlignment:'center'}},
		{name:'WHTYPE',header:{text:'창고명'},width:100,formatter:'combo',comboValue:'${gCodeWHTYPE}',styles:{textAlignment:'center'}},
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:100,styles:{textAlignment:'center'}},
		{name:'CUSTNM',header:{text:'거래처명'},width:140}, */
		{name:'POST',header:{text:'우편번호'},width:80,styles:{textAlignment:'center'}},
		{name:'ADDR1',header:{text:'주소'},width:200},
		{name:'ADDR2',header:{text:'상세주소'},width:200},
		{name:'WHINLOCCD',header:{text:'입고대기로케이션'},width:140,styles:{textAlignment:'center'}},
		{name:'WHOUTLOCCD',header:{text:'출고대기로케이션'},width:140,styles:{textAlignment:'center'}},
		{name:'RETURNLOCCD',header:{text:'반품로케이션'},width:140,styles:{textAlignment:'center'}},
		{name:'ASSYLOCCD',header:{text:'가공로케이션'},width:140,styles:{textAlignment:'center'}},
		
		
	];

	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid_popP004').gfn_getCurRowIdx();
			var gridData = [$('#grid_popP004').gfn_getDataRow(rowidx)];

			$('#popP004').lingoPopup('setData', gridData);
			$('#popP004').lingoPopup('close', 'OK');
		};
		
	});
}

/* 검색 */
function fn_search_popP004() {
	var paramData = cfn_getFormData('frm_search_popP004');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popP004/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popP004').gfn_setDataList(data.resultList);
	});
}
</script>