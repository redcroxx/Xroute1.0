<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100381
	화면명    : 입고 인터페이스 현황
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="S_COMPNM" class="cmc_code" />
	<ul class="sech_ul">
		<li class="sech_li">
			<div>창고</div>
			<div>
				<input type="text" id="S_WHCD" class="cmc_code" />
				<input type="text" id="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<!-- <li class="sech_li">
			<div>거래처</div>
			<div>
				<input type="text" id="S_CUSTCD" class="cmc_code" />
				<input type="text" id="S_CUSTNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li> -->
		<li class="sech_li">
			<div>구매일자</div>
			<div>
				<input type="text" id="S_ORDERDATE_FROM" class="cmc_date periods"/> ~
				<input type="text" id="S_ORDERDATE_TO" class="cmc_date periode"/>
			</div>
		</li>
		
		
	</ul>	
	<ul class="sech_ul">
		<li class="sech_li">
			<div>상태</div>
			<div>
				<select id="S_INTF_YN" class="cmc_combo">
					<c:forEach var="i" items="${codeIFYN}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
		<li class="sech_li">
			<div>구매번호</div>
			<!-- <div>
				<select id="S_KEY" name="S_KEY" class="cmc_combo" >
					<option value="IF">구매번호</option>
					<option value="WI">입고번호</option>
				</select>	
			</div> -->
			<div>				
				<input type="text" id="S_ORDERNO" name="S_ORDERNO" class="cmc_txt" />
			</div>
		</li>
		<!-- <li class="sech_li">
			<div >입고요청일자<br/>(WMS)</div>
			<div>
				<input type="text" id="S_WISCHDT_FROM" class="cmc_date periods"/> ~
				<input type="text" id="S_WISCHDT_TO" class="cmc_date periode"/>
			</div>
		</li> -->
		<li class="sech_li">
			<div>품목코드/명</div>
			<div>
				<input type="text" id="S_ITEMCD" name="S_ITEMCD" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<div id="sech_extbtn" class="down"></div>
	<div id="sech_extline"></div>
	<div id="sech_extwrap">
		<ul class="sech_ul">
			<li class="sech_li">
				<div>셀러</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code" />
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
		</ul>	
		<!-- 회사별 상품정보 조회조건 -->
		<c:import url="/comm/compItemSearch.do" />
	</div>
	
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<!-- <div class="ct_top_wrap">
	<div id="tab1" class="ct_tab">
		<ul>
			<li><a href="#tab1Cont1">인터페이스 입고</a></li>
			<li><a href="#tab1Cont2">WMS 입고</a></li>
		</ul>
		<div id="tab1Cont1">
			<div class="ct_top_wrap">
				<div class="grid_top_wrap">
					<div class="grid_top_left">인터페이스 입고 리스트<span>(총 0건)</span></div>
					<div class="grid_top_right"></div>
				</div>
				<div id="grid1"></div>
			</div>
		</div>
		<div id="tab1Cont2">
			<div class="grid_top_wrap">
				<div class="grid_top_left">WMS 입고 리스트<span>(총 0건)</span></div>
				<div class="grid_top_right"></div>
			</div>
			<div id="grid2"></div>
		</div>
	</div>
</div> -->

<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">인터페이스 입고 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<script type="text/javascript">
<%--
  * ========= 공통버튼 클릭함수 =========
  * 검색 : cfn_retrieve()
  * 목록 : cfn_list()
  * 신규 : cfn_new()
  * 삭제 : cfn_del()
  * 저장 : cfn_save()
  * 복사 : cfn_copy()
  * 초기화 : cfn_init()
  * 실행 : cfn_execute()
  * 취소 : cfn_cancel()
  * 엑셀업로드 : cfn_excelup()
  * 엑셀다운 : cfn_exceldown()
  * 출력 : cfn_print()
  * 사용자버튼 : cfn_userbtn1() ~ cfn_userbtn5()
  * -------------------------------
  * 버튼 순서 : setCommBtnSeq(['ret','list']) : ret,list,new,del,save,copy,init,execute,cancel,print,excelup,exceldown,user1,2,3,4,5
  * 버튼 표시/숨김 : setCommBtn('ret', true) : ret,list,new,del,save,copy,init,execute,cancel,print,excelup,exceldown,user1,2,3,4,5
  * ===============================
--%>
//초기 로드
$(function() {
	initLayout();
	 	
	$('#S_ORDERDATE_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_ORDERDATE_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	
	$('#S_WISCHDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WISCHDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	
	//로그인 정보로 세팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM); 
	
	grid1_Load();
	
	/* 공통코드 코드/명 (거래처) */
/* 	pfn_codeval({
		url:'/alexcloud/popup/popP003/view.do',codeid:'S_CUSTCD',
		inparam:{S_CUSTCD:'S_CUSTCD,S_CUSTNM',S_ORGCD:'S_ORGCD',S_ORGNM:'S_ORGNM',S_COMPCD:'S_COMPCD'},
		outparam:{CUSTCD:'S_CUSTCD',NAME:'S_CUSTNM'},
		params:{CODEKEY:'ISSUPPLIER'}
	}); */
	
	/* 공통코드 코드/명 (창고) */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_WHCD:'S_WHCD,S_WHNM',S_COMPCD:'S_COMPCD'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	
	/* 공통코드 코드/명 (셀러) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_ORGCD:'S_ORGCD,S_ORGNM',S_COMPCD:'S_COMPCD',S_COMPNM:'S_COMPNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	
	cfn_initSearch();
	
	if (!cfn_isEmpty(cfn_loginInfo().ORGCD)) {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
		$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
		$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	} 

	if (!cfn_isEmpty(cfn_loginInfo().WHCD)) {
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
		$('#S_WHCD').val(cfn_loginInfo().WHCD);
		$('#S_WHNM').val(cfn_loginInfo().WHNM);
	} 
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'ORDERNO',header:{text:'구매번호'},width:120,styles:{textAlignment:'center'}},
		{name:'ORDERSUBNO',header:{text:'상세번호'},width:100,styles:{textAlignment:'center'}},
		{name:'ORDERSEQ',header:{text:'SEQ'},width:50,styles:{textAlignment:'far'}},
		{name:'ORDERDATE',header:{text:'구매일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		
		{name:'INTF_YN',header:{text:'확정여부'},width:100,formatter:'combo',comboValue:'${gCodeIFYN}',styles:{textAlignment:'center'}},
		{name:'TYPE',header:{text:'타입명'},width:100,formatter:'combo',comboValue:'${gCodeATOMY_INTERFACE}',styles:{textAlignment:'center'}},
		{name:'STOCKDATE',header:{text:'입고예정일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		
		{name:'PLANTNAME',header:{text:'플랜트명'},width:170,styles:{textAlignment:'center'}},
		{name:'STORAGENAME',header:{text:'스토리지명'},width:170,styles:{textAlignment:'center'}},
		
		{name:'MATERIALCODE',header:{text:'상품코드'},width:100,styles:{textAlignment:'center'}},
		{name:'MATERIALNAME',header:{text:'상품명'},width:350},
		
		{name:'STOCKCOUNT',header:{text:'PO수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'QTY',header:{text:'확정수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'PROGRESS_QTY',header:{text:'확정현황'},width:100,formatter:'progressbar',dataType:'number',
			dynamicStyles:[
				{criteria:'value >= 0',styles:{figureBackground:cfn_getStsColor(4)}},
				{criteria:'value >= 50',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value >= 100',styles:{figureBackground:cfn_getStsColor(3)}} 
			]
		},
		{name:'RMK',header:{text:'기타'},width:200},
		{name:'VALIDATE',header:{text:'유통기간'},width:120,formatter:'date'},
		{name:'LOT',header:{text:'LOT'},width:100,styles:{textAlignment:'center'}},
		{name:'RETURNYN',header:{text:'반품여부'},width:100,formatter:'checkbox',renderer:{trueValues:"Y",falseValues:"N"}},
		/* {name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'SEQ',header:{text:'입고순번'},width:80,styles:{textAlignment:'far'}},
		{name:'WISCHDT',header:{text:'입고요청일자(WMS)'},width:130,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WISCHDT',header:{text:'입고일자'},width:110,formatter:'date',styles:{textAlignment:'center'}}, */
		
		{name:'COMPANYCODE',header:{text:'거래처코드'},width:120,styles:{textAlignment:'center'}},
		{name:'COMPANYNAME',header:{text:'공급처명'},width:200},
		
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},show:false},
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,visible:false,show:false}
	
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns);
	
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		$('#'+gid).gridView().setColumnProperty(
			gridView.columnByField("INTF_YN"), 
			"dynamicStyles", [{
				criteria: [
					"values['INTF_YN'] = '0'"
					, "values['INTF_YN'] = '1'"
					, "values['INTF_YN'] = '2'"
				],
				styles: [
					"background=#ff6464"
					, "background=#ffff1a"
					, "background=#33ff33"
				]
			}]
		)
	});
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
	gv_searchData.TABIDX = cfn_getTabIdx('tab1');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100381/getSearch.do';
	var sendData = {'paramData':gv_searchData};

	gfn_sendData(sid, url, sendData);
	
}

</script>

<c:import url="/comm/contentBottom.do" />