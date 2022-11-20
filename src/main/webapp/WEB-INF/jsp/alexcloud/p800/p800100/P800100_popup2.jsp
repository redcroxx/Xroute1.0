<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P800100_popup2
	화면명    : 팝업 - 애터미 입고 팝업
-->
<div id="P800100_popup2" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="S_COMPCD"/>
		<input type="hidden" id="S_ORGCD"/>
		<input type="hidden" id="S_WHCD"/>
		<ul class="sech_ul">
			<!-- <li class="sech_li">
				<div>창고</div>
				<div>
					<input type="text" id="S_WHCD" name="S_WHCD" class="cmc_code" />
					<input type="text" id="S_WHNM" name="S_WHNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li> -->
			<li class="sech_li">
				<div>상태</div>
				<div>
					<select id="S_GUBUN" class="cmc_combo">
						<option value="">전체</option>
						<option value="1">재고있는것만</option>
						<option value="2">재고없는것만</option>
					</select>
				</div>
			</li>
		</ul>	
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">재고</div>
		</div>
		<div id="grid1"></div>
	</div> 
</div>

<script type="text/javascript">
$(function() {
	
	$('#P800100_popup2').lingoPopup({
		
		title: '재고',
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
			$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
						
			/*$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			$('#S_WHNM').next().attr('disabled',true).addClass('disabled');*/
			$('#S_GUBUN').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
						
		 	cfn_bindFormData('frmSearch', data);
			
			grid1_Load();
			cfn_retrieve();
		}
	});
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'ORGCD',header:{text:'화주코드'},width:100,show:false},
		{name:'ORGNM',header:{text:'화주명'},width:100},
		{name:'WHCD',header:{text:'창고코드'},width:100,show:false},
		{name:'WHNM',header:{text:'창고명'},width:100},
		{name:'CUSTCD',header:{text:'거래처코드'},width:100},
		{name:'CUSTNM',header:{text:'거래처명'},width:150},
		{name:'ITEMCD',header:{text:'품목코드'},width:80},
		{name:'ITEMNM',header:{text:'품목명'},width:200},
		{name:'AVAILABLEQTY',header:{text:'가용수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'QTY',header:{text:'재고수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'ALLOCQTY',header:{text:'할당수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'ORDERQTY',header:{text:'미할당'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'EXPECTATION_QTY',header:{text:'GAP'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		}
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
	var url = '/alexcloud/p800/p800100_popup2/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}
</script>