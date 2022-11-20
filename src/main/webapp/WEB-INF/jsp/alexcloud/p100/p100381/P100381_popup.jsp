<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100381_popup
	화면명    : 팝업 - 애터미 입고 팝업
-->
<div id="P100381_popup" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="S_COMPCD"/>
		<input type="hidden" id="S_ORGCD"/>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>구매일자<br/>(ERP)</div>
				<div>
					<input type="text" id="S_ORDERDATE_FROM" class="cmc_date periods" readonly="readonly"/> ~
					<input type="text" id="S_ORDERDATE_TO" class="cmc_date periode" readonly="readonly"/>
				</div>
			</li>
			<li class="sech_li">
				<div>상태</div>
				<div>
					<select id="S_INTF_YN" class="cmc_combo">
						<option value="">전체</option>
						<c:forEach var="i" items="${codeIFSTS}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
		</ul>	
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">입고</div>
		</div>
		<div id="grid1"></div>
	</div> 
</div>

<script type="text/javascript">
$(function() {
	$('#P100381_popup').lingoPopup({
		
		title: '입고',
		width: 1000,
		height: 600,
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
			$('#S_ORDERDATE_FROM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			$('#S_ORDERDATE_TO').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			$('#S_INTF_YN').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
						
			//$('#S_ORDERDATE_FROM').val(cfn_getDateFormat(S_ORDERDATE, 'yyyy-MM-dd'));
			//$('#S_ORDERDATE_TO').val(cfn_getDateFormat(S_ORDERDATE, 'yyyy-MM-dd'));
			
		 	cfn_bindFormData('frmSearch', data);
			
			grid1_Load();
			cfn_retrieve();
		}
	});
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'ORDERNO',header:{text:'구매번호'},width:120},
		{name:'ORDERSUBNO',header:{text:'상세번호'},width:0},
		{name:'ORDERDATE',header:{text:'구매일자'},width:100,formatter:'date',styles:{textAlignment:'center'}},
		{name:'COMPANYNAME',header:{text:'공급처명'},width:180},
		{name:'MATERIALNAME',header:{text:'품목명'},width:300},
		{name:'STOCKCOUNT',header:{text:'발주서수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY',header:{text:'WMS입고수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'PROGRESS_QTY',header:{text:'실적현황'},width:100,formatter:'progressbar',dataType:'number',
			dynamicStyles:[
				{criteria:'value >= 0',styles:{figureBackground:cfn_getStsColor(4)}},
				{criteria:'value >= 50',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value >= 100',styles:{figureBackground:cfn_getStsColor(3)}}
			]
		},
		{name:'WISCHDT',header:{text:'입고일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WHNM',header:{text:'창고명'},width:100}	
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {fitStyle:'even'});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색(전표별)
	if (sid == 'sid_getSearch') {
		var gridData = data.resultList;			
		$('#grid1').gfn_setDataList(data.resultList);		
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100381_popup/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}
</script>