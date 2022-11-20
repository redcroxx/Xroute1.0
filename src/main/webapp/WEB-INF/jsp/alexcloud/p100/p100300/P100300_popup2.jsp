<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100300_popup2
	화면명    : 팝업 - 애터미 입고 팝업
-->
<div id="P100300_popup2" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_P100300_popup2" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" class="cmc_code" />
			<ul class="sech_ul">
				<li class="sech_li">
				<div>셀러</div>
					<div>
						<input type="text" id="S_ORGCD" class="cmc_code disabled" readonly="readonly" />
						<input type="text" id="S_ORGNM" class="cmc_value disabled" readonly="readonly" />
					</div>
				</li>
			  	<!-- <li class="sech_li">
			  		<div>거래처</div>
					<div>
						<input type="text" id="S_CUSTCD" class="cmc_code disabled" readonly="readonly" />
						<input type="text" id="S_CUSTNM" class="cmc_value disabled" readonly="readonly" />
					</div>
				</li> -->
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">
					<div>창고</div>
					<div>
						<input type="text" id="S_WHCD" class="cmc_code disabled" readonly="readonly"/>
						<input type="text" id="S_WHNM" class="cmc_value disabled" readonly="readonly"/>
					</div>
				</li>
				<li class="sech_li">
					<div>품목코드/명</div>
					<div>
						<input type="text" id="S_ITEMCD" class="cmc_txt" />
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">
					<div>입고예정일자</div>
					<div>
						<input type="text" id="S_WISCHDT_FROM" class="cmc_date periods" />
						<input type="text" id="S_WISCHDT_TO" class="cmc_date periode" />
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_P100300_popup2_search()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	 <div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid1_P100300_popup2"></div>
	</div> 
</div>

<script type="text/javascript">
$(function() {
	$('#P100300_popup2').lingoPopup({
		title: '애터미 입고',
		width: 1550,
		height : 800,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var checkRows = $('#grid1_P100300_popup2').gridView().getCheckedRows();
					var gridData = $('#grid1_P100300_popup2').gfn_getDataRows(checkRows);
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
			cfn_bindFormData('frm_search_P100300_popup2', data);
			
			$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
			$('#S_WISCHDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
			$('#S_WISCHDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
			grid1_P100300_popup2_Load();
			
			/* 공통코드 코드/명 (사업장) */
			pfn_codeval({
				url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
				inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
				outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
			});
			
			/* 공통코드 코드/명 (창고) */
			pfn_codeval({
				url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
				inparam:{S_WHCD:'S_WHCD,S_WHNM',S_COMPCD:'S_COMPCD'},
				outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
			});
			
			/* 공통코드 코드/명 (거래처) */
		 	/* pfn_codeval({
				url:'/alexcloud/popup/popP003/view.do',codeid:'S_CUSTCD',
				inparam:{S_CUSTCD:'S_CUSTCD,S_CUSTNM',S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD',S_ORGNM:'S_ORGNM'},
				outparam:{CUSTCD:'S_CUSTCD',NAME:'S_CUSTNM'},
				params:{CODEKEY:'ISSUPPLIER'}
			});	  */
			
			
			fn_P100300_popup2_search();
		}
	});
});

function grid1_P100300_popup2_Load() {
	var gid = 'grid1_P100300_popup2';
	var columns = [
		{name:'ORDERNO',header:{text:'구매번호'},width:120,styles:{textAlignment:'center'}},
		{name:'ORDERSUBNO',header:{text:'상세번호'},width:100,styles:{textAlignment:'center'}},
		{name:'ORDERSEQ',header:{text:'SEQ'},width:80,styles:{textAlignment:'far'}},
		{name:'ORDERDATE',header:{text:'구매일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'TYPE',header:{text:'타입명'},width:100,formatter:'combo',comboValue:'${gCodeATOMY_INTERFACE}',styles:{textAlignment:'center'}},
		{name:'STOCKDATE',header:{text:'입고예정일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'COMPANYCODE',header:{text:'공급처코드'},width:100,styles:{textAlignment:'center'}},
		{name:'COMPANYNAME',header:{text:'공급처명'},width:150,styles:{textAlignment:'center'}},
		{name:'PLANTCODE',header:{text:'플랜트코드'},width:100,styles:{textAlignment:'center'}},
		{name:'PLANTNAME',header:{text:'플랜트'},width:150,styles:{textAlignment:'center'}},
		{name:'WH',header:{text:'스토리지코드'},width:100,styles:{textAlignment:'center'}},
		{name:'STORAGENAME',header:{text:'스토리지'},width:150,styles:{textAlignment:'center'}},
		{name:'MATERIALCODE',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'MATERIALNAME',header:{text:'품목명'},width:250},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:100,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,styles:{textAlignment:'center'}},
		{name:'STOCKCOUNT',header:{text:'예정수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,visible:false,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true});

	//그리드설정 및 이벤트처리

	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		
		//셀 더블클릭
		 gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid1_P100300_popup2').gfn_getCurRowIdx();
			var gridData = [$('#grid1_P100300_popup2').gfn_getDataRow(rowidx)];

			$('#P100300_popup2').lingoPopup('setData', gridData);
			$('#P100300_popup2').lingoPopup('close', 'OK');
		}; 
	});
}


/* 검색 */
function fn_P100300_popup2_search() {
	var paramData = cfn_getFormData('frm_search_P100300_popup2');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/p100/p100300_popup2/getSearch.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid1_P100300_popup2').gfn_setDataList(data.resultList);
	});	
}

</script>