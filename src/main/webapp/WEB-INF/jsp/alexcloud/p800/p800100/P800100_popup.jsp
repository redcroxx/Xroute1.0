<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P800100_popup
	화면명    : 팝업 - 재고이력 팝업
-->
<div id="P800100_popup" class="pop_wrap">
	<!-- 검색조건영역 시작 	-->
	<div id="ct_sech_wrap">
		<form id="frm_search_P800100_popup" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" class="cmc_code" />
			<input type="hidden" id="S_ORGCD" class="cmc_code" />
			<input type="hidden" id="S_WHCD" class="cmc_code" />
			<input type="hidden" id="S_LOCCD" class="cmc_code" />
			<input type="hidden" id="S_ITEMCD" class="cmc_code" />
			<input type="hidden" id="S_LOTKEY" class="cmc_code" />
			<ul class="sech_ul">
				<li class="sech_li">
					최근 이력 100건만 조회됩니다.
				</li>
			</ul>
		</form>
	</div>
	
	<!-- 검색조건영역 끝 -->
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">재고이력 리스트<span>(총 0건)</span></div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid1_P800100_popup"></div>
	</div> 
</div>

<script type="text/javascript">
$(function() {
	$('#P800100_popup').lingoPopup({
		title: '재고이력',
		buttons: {
			'닫기': {
				text: '닫기',
				click: function() {
					$(this).lingoPopup('setData', '');
					$(this).lingoPopup('close', 'OK');
				}
			}
		},
		open: function(data) {
			cfn_bindFormData('frm_search_P800100_popup', data);
			
			grid1_P800100_popup_Load();
			
			fn_P800100_popup_search();
		}
	});
});

function grid1_P800100_popup_Load() {
	var gid = 'grid1_P800100_popup';
	var columns = [
		{name:'ADDDATETIME',header:{text:'처리일시'},width:150,styles:{textAlignment:'center'}},
		{name:'ADDUSERCD',header:{text:'처리자'},width:100,styles:{textAlignment:'center'}},
		{name:'IOTYPE',header:{text:'처리유형'},width:100,formatter:'combo',comboValue:'${gCodeIOTYPE}',styles:{textAlignment:'center'}},
		{name:'IOFLG',header:{text:'증/감'},width:100,formatter:'combo',comboValue:'${gCodeIOFLG}',styles:{textAlignment:'center'}},
		{name:'QTY',header:{text:'처리수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'BEFOREQTY',header:{text:'이전재고'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'AFTERQTY',header:{text:'이후재고'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'IOKEY',header:{text:'전표번호'},width:130},
		{name:'IOSEQ',header:{text:'전표SEQ'},width:60},
		{name:'WORKKEY',header:{text:'지시전표번호'},width:130},
		{name:'LOCCD',header:{text:'로케이션코드'},width:100},
		{name:'ITEMCD',header:{text:'품목코드'},width:120},
		{name:'ITEMNM',header:{text:'품목명'},width:200},
		{name:'LOTKEY',header:{text:'로트키'},width:100},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'ORGCD',header:{text:'사업장코드'},width:100},
		{name:'WHCD',header:{text:'창고코드'},width:100},
		{name:'TYPE',header:{text:'처리테이블'},width:100},
		{name:'SHKEY',header:{text:'이력번호'},width:100},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg: false});
}

/* 검색 */
function fn_P800100_popup_search() {

	var paramData = cfn_getFormData('frm_search_P800100_popup');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/p800/p800100_popup/getSearch.do';
		
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid1_P800100_popup').gfn_setDataList(data.resultList);
	});	
}
</script>