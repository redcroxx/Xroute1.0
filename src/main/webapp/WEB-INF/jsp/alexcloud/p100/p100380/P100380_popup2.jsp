<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100380_popup2
	화면명    : 팝업 - 입고 업체수 팝업
-->
<div id="P100380_popup2" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="S_COMPCD"/>
		<input type="hidden" id="S_ORGCD"/>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>입고일자</div>
				<div>
					<input type="text" id="S_WIDT" class="cmc_date periods"/>
				</div>
			</li>
		</ul>	
		<ul class="sech_ul">
			<li class="sech_li">
				<div>입고상태</div>
				<div>
					<select id="S_WISTS" class="cmc_combo">
						<option value="NOT99"><c:out value="전체" /></option>
						<c:forEach var="i" items="${codeWISTS}">
							<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
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
			<div class="grid_top_left">입고 업체 수<span>(총 0건)</span></div>
		</div>
		<div id="grid1"></div>
	</div> 
</div>

<script type="text/javascript">
$(function() {
	$('#P100380_popup2').lingoPopup({
		
		title: '입고',
		width: '650px',
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
			$('#S_WIDT').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			$('#S_WISTS').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			
		 	cfn_bindFormData('frmSearch', data);
			
			grid1_Load();
			cfn_retrieve();
		}
	});
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:100},
		{name:'CUSTNM',header:{text:'거래처명'},width:120}, */
		{name:'ITEMCNT',header:{text:'품목수'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'ITEMQTY',header:{text:'총 수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'TOTALSUPPLYAMT',header:{text:'총입고금액'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}}
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
	var url = '/alexcloud/p100/p100380_popup2/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}
</script>