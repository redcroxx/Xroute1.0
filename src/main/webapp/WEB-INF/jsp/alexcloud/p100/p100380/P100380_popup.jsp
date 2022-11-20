<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100380_popup
	화면명    : 팝업 - 애터미 입고 팝업
-->
<div id="P100380_popup" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="S_COMPCD"/>
		<input type="hidden" id="S_ORGCD"/>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>입고일자</div>
				<div>
					<input type="text" id="S_WIDT_FROM" class="cmc_date periods"/> ~
					<input type="text" id="S_WIDT_TO" class="cmc_date periode"/>
				</div>
			</li>
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
			<div class="grid_top_left">입고<span>(총 0건)</span></div>
		</div>
		<div id="grid1"></div>
	</div> 
</div>

<script type="text/javascript">
$(function() {
	$('#P100380_popup').lingoPopup({
		
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
			$('#S_WIDT_FROM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			$('#S_WIDT_TO').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			$('#S_WISTS').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
						
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
		{name:'WIKEY',header:{text:'입고번호'},width:120},
		{name:'WIDT',header:{text:'입고일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WISTS',header:{text:'입고상태'},width:120,formatter:'combo',comboValue:'${gCodeWISTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 400',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}]},
		{name:'WHNM',header:{text:'창고명'},width:100},
		/* {name:'CUSTNM',header:{text:'거래처명'},width:120}, */
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
	var url = '/alexcloud/p100/p100380_popup/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}
</script>