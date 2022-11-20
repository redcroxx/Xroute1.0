<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100200
	화면명    : 입고 인터페이스 확정(애터미)
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<%-- <form id="frmSearch" action="#" onsubmit="return false">
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
		<li class="sech_li">
			<div>거래처</div>
			<div>
				<input type="text" id="S_CUSTCD" class="cmc_code" />
				<input type="text" id="S_CUSTNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<li class="sech_li">
			<div>입고상태</div>
			<div>
				<select id="S_WISTS" class="cmc_combo">
					<option value="NOT99">전체</option>
					<c:forEach var="i" items="${codeWISTS}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
					<option value="">전체(취소포함)</option>
				</select>
			</div>
		</li>
	</ul>	
	<ul class="sech_ul">
		<li class="sech_li">
			<div >입고요청일자</div>
			<div>
				<input type="text" id="S_WISCHDT_FROM" class="cmc_date periods"/> ~
				<input type="text" id="S_WISCHDT_TO" class="cmc_date periode"/>
			</div>
		</li>
		<li class="sech_li">
			<div>입고번호</div>
			<div>
				<input type="text" id="S_WIKEY" class="cmc_txt" />
			</div>
		</li>
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
	
	</form> --%>
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
			<div>구매번호</div>
			<div>				
				<input type="text" id="S_ORDERNO" name="S_ORDERNO" class="cmc_txt" />
			</div>
		</li>
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
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고 인터페이스 리스트<span>(총 0건)</span></div>
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
	
	setCommBtn('execute', null, '확정');
	 	
	$('#S_ORDERDATE_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_ORDERDATE_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	 
	//로그인 정보로 세팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM); 
	
	grid1_Load();
	
	/* 공통코드 코드/명 (거래처) */
	/* pfn_codeval({
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

/* function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'WIKEY',header:{text:'입고번호'},width:130},
		{name:'SEQ',header:{text:'순번'},width:70,styles:{textAlignment:'far'}},
		{name:'WISCHDT',header:{text:'입고요청일자'},width:130,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WIDT',header:{text:'입고일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WISTS',header:{text:'입고상태'},width:120,formatter:'combo',comboValue:'${gCodeWISTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 400',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}]},
		{name:'WITYPE',header:{text:'입고유형'},width:90,formatter:'combo',comboValue:'${gCodeWITYPE}',styles:{textAlignment:'center'}},
		{name:'WHCD',header:{text:'창고코드'},width:80},
		{name:'WHNM',header:{text:'창고명'},width:100},
		{name:'CUSTCD',header:{text:'거래처코드'},width:100},
		{name:'CUSTNM',header:{text:'거래처명'},width:120},
		{name:'ITEMCD',header:{text:'품목코드'},width:120},
		{name:'ITEMNM',header:{text:'품목명'},width:250},
		{name:'WISCHQTY',header:{text:'예정수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY',header:{text:'입고수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'PRINTBTN',header:{text:'IF'},width:35,formatter:'btnsearch'},	
		{name:'IFORDERNO',header:{text:'구매번호'},width:120,required:true},		
		{name:'IFORDERSUBNO',header:{text:'상세번호'},width:100},		
		{name:'IFORDERSEQ',header:{text:'순번'},width:80},
		{name:'IFPOQTY',header:{text:'발주서수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'QTY',header:{text:'확정수량'},width:80,required:true,editable:true,editor:{maxLength:50, type:"number",positiveOnly: true, integerOnly: true},dataType:"number", styles:{textAlignment:'far',numberFormat:"#,##0"},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'RMK',header:{text:'기타'},width:200,styles:{textAlignment:'center'},editable:true,editor:{maxLength:50}},
		{name:'VALIDATE',header:{text:'유통기간'},width:120,editable:true,formatter:'date',editor:{maxLength:8}},
		{name:'LOT',header:{text:'LOT'},width:100,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20}},
		{name:'RETURNYN',header:{text:'반품여부'},width:100,styles:{textAlignment:'center'},editable:true,editor:{maxLength:1}},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}},
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,visible:false,show:false},
		{name:'IDX',header:{text:'IDX(인터페이스)'},width:100,visible:false,show:false},
		{name:'IFORDERDATE',header:{text:'주문일자(인터페이스)'},width:100,visible:false,show:false},
		{name:'IFTYPE',header:{text:'타입(인터페이스)'},width:100,visible:false,show:false},
		{name:'IFPLANTCODE',header:{text:'플랜트코드(인터페이스)'},width:100,visible:false,show:false},
		{name:'IFSTORAGECODE',header:{text:'스토리지코드(인터페이스)'},width:100,visible:false,show:false},
	
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns , {checkBar:true} );
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		//셀 클릭 이벤트
		gridView.onDataCellClicked = function(gridview, column) {
			var rowidx = $('#' + gid).gfn_getCurRowIdx();
			//출력버튼 클릭
			if (column.column === 'PRINTBTN') {
				var compcd = $('#' + gid).gfn_getValue(rowidx, 'COMPCD');
				var orgcd = $('#' + gid).gfn_getValue(rowidx, 'ORGCD');
				var whcd = $('#' + gid).gfn_getValue(rowidx, 'WHCD');
				var custcd = $('#' + gid).gfn_getValue(rowidx, 'CUSTCD');
				var itemcd = $('#' + gid).gfn_getValue(rowidx, 'ITEMCD');
				
				pfn_popupOpen({
					url: '/alexcloud/p100/p100200_popup/view.do',
					pid: 'P100200_popup',
					params:{'S_COMPCD':compcd, 'S_ORGCD':orgcd, 'S_WHCD':whcd, 'S_CUSTCD':custcd, 'S_ITEMCD':itemcd},
					returnFn: function(data, type) {
						if (type === 'OK') {
							$('#' + gid).gfn_setValue(rowidx, 'IFORDERNO', data[0].ORDERNO);
							$('#' + gid).gfn_setValue(rowidx, 'IFORDERSUBNO', data[0].ORDERSUBNO);
							$('#' + gid).gfn_setValue(rowidx, 'IFORDERSEQ', data[0].ORDERSEQ);
							$('#' + gid).gfn_setValue(rowidx, 'IFPOQTY', data[0].STOCKCOUNT);
							$('#' + gid).gfn_setValue(rowidx, 'IDX', data[0].IDX);
							$('#' + gid).gfn_setValue(rowidx, 'IFORDERDATE', data[0].ORDERDATE);
							$('#' + gid).gfn_setValue(rowidx, 'IFTYPE', data[0].TYPE);
							$('#' + gid).gfn_setValue(rowidx, 'IFPLANTCODE', data[0].PLANTCODE);
							$('#' + gid).gfn_setValue(rowidx, 'IFSTORAGECODE', data[0].STORAGECODE);
							$('#' + gid).gfn_setValue(rowidx, 'QTY', '');
						}
					}
				});
				
			}
		}
		
		//셀 수정완료 이벤트  
		gridView.onCellEdited = function(grid, itemIdx, dataRow, fieldIdx) {
			
			gridView.commit();
			
			var rowidx = $('#' + gid).gfn_getCurRowIdx();
			var gridData = $('#' + gid).gfn_getDataRow(rowidx);
			
			if(fieldIdx === 19) {
				if((Math.ceil(gridData.IFPOQTY * 1.2) < gridData.QTY)){
					cfn_msg('WARNING', '발주서(인터페이스) 수량의 120%인 ['+Math.ceil(gridData.IFPOQTY * 1.2) +'개]이상 입력할 수 없습니다.');
					$('#' + gid).gfn_setValue(rowidx, 'QTY', '')
					return false;
				}
				
				if(gridData.IFPOQTY > gridData.QTY){
					cfn_msg('WARNING', '발주서(인터페이스) 수량보다 작습니다.')
				}
			}
			
			if(fieldIdx === 23) {
				alert(gridData.RETURNYN);
				if(gridData.RETURNYN !== 'N' && gridData.RETURNYN !== 'Y'){
					cfn_msg('WARNING', 'Y 또는 N 값만 입력할 수 있습니다.');
					$('#' + gid).gfn_setValue(rowidx, 'RETURNYN', '')
					return false;
				 }
			}
		}; 
		
		
	});
} */

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
		
		{name:'MATERIALCODE',header:{text:'상품코드'},width:120,styles:{textAlignment:'center'}},
		{name:'MATERIALNAME',header:{text:'상품명'},width:350},
		
		{name:'STOCKCOUNT',header:{text:'PO수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'QTY',header:{text:'확정수량'},width:100,required:true,dataType:'number',editable:true,editor:{maxLength:50},styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'MPBTN',header:{text:'전표검색'},width:35,formatter:'btnsearch'},
			
		{name:'RMK',header:{text:'기타'},width:200,editable:true,editor:{maxLength:50}},
		{name:'VALIDATE',header:{text:'유통기간'},width:120,editable:true,formatter:'date',editor:{maxLength:8}},
		{name:'LOT',header:{text:'LOT'},width:100,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20}},
		{name:'RETURNYN',header:{text:'반품여부'},width:100,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		
		{name:'COMPANYCODE',header:{text:'거래처코드'},width:120,styles:{textAlignment:'center'}},
		{name:'COMPANYNAME',header:{text:'공급처명'},width:200},
		

		{name:'PLANTCODE',header:{text:'플랜트코드'},width:100,styles:{textAlignment:'center'},show:false},
		{name:'STORAGECODE',header:{text:'스토리지코드'},width:100,styles:{textAlignment:'center'},show:false},
		
		{name:'UPDDATETIME',header:{text:'확정일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		/* {name:'MPKEY',header:{text:'입고전표'},width:150,required:false,styles:{textAlignment:'center'}},
		{name:'MPSEQ',header:{text:'입고번호'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'STOCKCOUNT',header:{text:'PO수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'MPQTY',header:{text:'매핑수량'},width:110,required:true,editable:true,editor:{maxLength:50, type:"number",positiveOnly: true, integerOnly: true},dataType:"number", styles:{textAlignment:'far',numberFormat:"#,##0"},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}}, */
			
			
		{name:'WHCD',header:{text:'창고코드'},width:80,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'WHNM',header:{text:'창고명'},width:100,styles:{textAlignment:'center'},visible:false,show:false},
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'IDX',header:{text:'IDX'},width:100,visible:false,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,visible:false,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns , {checkBar:true});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		$('#'+gid).gridView().setColumnProperty(
			gridView.columnByField("INTF_YN"),
			"dynamicStyles", [{
				criteria: [
					"values['INTF_YN'] = '0'",
					"values['INTF_YN'] = '1'",
					"values['INTF_YN'] = '2'"
				],
				styles: [
					"background=#ff6464",
					"background=#ffff1a",
					"background=#33ff33"
				]
			}]
		)
		
		//셀 클릭 이벤트
		gridView.onDataCellClicked = function(gridview, column) {
			var rowidx = $('#' + gid).gfn_getCurRowIdx();
			//출력버튼 클릭
			if (column.column === 'MPBTN') {
				var compcd = $('#' + gid).gfn_getValue(rowidx, 'COMPCD');
				var orgcd = $('#' + gid).gfn_getValue(rowidx, 'ORGCD');
				var whcd = $('#' + gid).gfn_getValue(rowidx, 'WHCD');
				var whnm = $('#' + gid).gfn_getValue(rowidx, 'WHNM');
				var materialcode = $('#' + gid).gfn_getValue(rowidx, 'MATERIALCODE');
				
				pfn_popupOpen({
					url: '/alexcloud/p700/p700102_popup/viewP131.do',
					pid: 'P700102IPGO_popup',
					params:{'S_COMPCD' : compcd, 'S_ORGCD' : orgcd, 'S_WHCD' : whcd, 'S_WHNM' : whnm, 'S_ITEMCD' : materialcode},
					returnFn: function(data, type) {
						if (type === 'OK') {
							/* $('#' + gid).gfn_setValue(rowidx, 'MPKEY', data.MPKEY);
							$('#' + gid).gfn_setValue(rowidx, 'MPSEQ', data.SEQ);
							$('#' + gid).gfn_setValue(rowidx, 'MPYMD', data.MPYMD);
							$('#' + gid).gfn_setValue(rowidx, 'MPQTY', data.MPQTY); */
						}
					}
				});
				
			}
		}
		
		//셀 수정완료 이벤트  
		gridView.onCellEdited = function(grid, itemIdx, dataRow, fieldIdx) {
			
			gridView.commit();
			
			var rowidx = $('#' + gid).gfn_getCurRowIdx();
			var gridData = $('#' + gid).gfn_getDataRow(rowidx);
			
			if(fieldIdx === 12) {
				if((Math.ceil(gridData.STOCKCOUNT * 1.2) < gridData.QTY)){
					cfn_msg('WARNING', '발주서(인터페이스) 수량의 120%인 \n['+Math.ceil(gridData.STOCKCOUNT * 1.2) +'개]이상 입력할 수 없습니다.');
					$('#' + gid).gfn_setValue(rowidx, 'QTY', '')
					return false;
				}
				
				if(gridData.STOCKCOUNT > gridData.QTY){
					cfn_msg('WARNING', '발주서(인터페이스) 수량보다 작습니다.')
				}
				
			}
		}; 
	});
	/* var gid = 'grid1', $grid = $('#' + gid);
	var columns = [
		{name:'ORDERNO',header:{text:'분류'},width:200},
		{name:'ORDERSUBNO',header:{text:'분류코드'},width:100},
		{name:'ORDERSEQ',header:{text:'분류명'},width:130},
		{name:'LVLNAME',header:{text:'단계'},width:80,styles:{textAlignment:'center'}},
		{name:'SORTNO',header:{text:'정렬순서'},width:80,styles:{textAlignment:'far'}},
		{name:'MPBTN',header:{text:'매핑'},width:35,formatter:'btnsearch'},
		{name:'ITEMCNT',header:{text:'등록품목수'},width:80},
		{name:'REMARK',header:{text:'비고'},width:200},
		{name:'LVL',header:{text:'분류레벨'},width:80},	
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'TREE',header:{text:'트리'},width:150,show:false}
	];
	$grid.gfn_createGrid(columns, {treeflg:true,panelflg:false,footerflg:false,sortable:false,fitStyle:'even'});
	
	$('#'+gid).gridView().setColumnProperty(
			"LVL",
	    	 "dynamicStyles", function(grid, index, value) {
			}
		)
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				 var cur = $grid.gridView().getCurrent();
			     var rowIds = $grid.gridView().getAncestors(cur.dataRow);
			     if(!rowIds.length) rowIds = "부모가 없는 행입니다.";
			     alert(rowIds);
			}
		};

	    //셀 클릭 이벤트
	    gridView.onDataCellClicked = function(gridView, column) {
	    	var rowidx = $('#'+gid).gfn_getCurRowIdx();
	    	//출력버튼 클릭
	    	if(column.column == 'PRINTBTN') {
	    		var wikey = $('#' + gid).gfn_getValue(rowidx, 'WIKEY');
	    		
	    		rfn_getReport(wikey);
	    		
	    	}
	    }

		
	}); */
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid1').gfn_setDataList(data.resultList);
	}
	//실행
	if(sid == 'sid_setExecute') {
		var resultData = data.resultData
		$('#grid1').gfn_setFocusPK(resultData, ['ORDERNO']);
		
		cfn_msg('INFO', '인터페이스 확정 처리 되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100200/getSearch.do';
	var sendData = {'paramData':gv_searchData};

	gfn_sendData(sid, url, sendData);
	
}

/* 공통버튼 - 실행 클릭(확정처리) */
function cfn_execute() {
	var checkRows = $('#grid1').gridView().getCheckedRows();
	var gridData = $('#grid1').gfn_getDataRows(checkRows);
	
	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	
	if($('#grid1').gfn_checkValidateCells(checkRows)){
		return false;
	}
	
	
	if (confirm('인터페이스 확정처리 하시겠습니까?')) {
		
		var sid = 'sid_setExecute';
		var url = '/alexcloud/p100/p100200/setExecute.do';
		var sendData = {'paramList':gridData};
	
		gfn_sendData(sid, url, sendData);
		
	}
	
}

</script>

<c:import url="/comm/contentBottom.do" />