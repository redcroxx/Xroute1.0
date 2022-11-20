<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100320
	화면명    : 입고관리 > 입고실적
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="C_CHKWHCD" class="cmc_code" />
	<input type="hidden" id="C_CHKWHNM" class="cmc_code" />
	
	<ul class="sech_ul">
		<li class="sech_li">
			<div>입고요청일자</div>
			<div>
				<input type="text" id="S_WISCHDT_FROM" class="cmc_date periods" /> ~
				<input type="text" id="S_WISCHDT_TO" class="cmc_date periode" />
			</div>
		</li>
		<li class="sech_li">
			<div>입고상태</div>
			<div>
				<select id="S_WISTS" class="cmc_combo">
					<option value="">전체</option>
					<c:forEach var="i" items="${codeWISTS}">
						<c:if test="${i.code == '200' || i.code == '300' || i.code == '400'}">
							<option value="${i.code}" selected>${i.value}</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
		</li>
		<li class="sech_li">
			<div>입고유형</div>
			<div>
				<select id="S_WITYPE" class="cmc_combo">
					<option value="">전체</option>
					<c:forEach var="i" items="${codeWITYPE}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<li class="sech_li">
			<div style="width:100px">입고일자</div>
			<div style="width:250px">				
				<input type="text" id="S_WIDT_FROM" name="S_WIDT_FROM" data-type="date" class="cmc_date"/> ~
				<input type="text" id="S_WIDT_TO" name="S_WIDT_TO" data-type="date" class="cmc_date"/>				
			</div>
		</li>
		<!-- <li class="sech_li">
			<div style="width:100px">거래처</div>
			<div style="width:250px">
				<input type="text" id="S_CUSTCD" name="S_CUSTCD" class="cmc_code" />
				<input type="text" id="S_CUSTNM" name="S_CUSTNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li> -->
		<li class="sech_li">
			<div style="width:100px;">
				<select id="S_SEARCHTYPE" name="S_SEARCHTYPE" class="cmc_combo" style="width:98px">
						<option value="WD" selected >지시번호</option>
						<option value="WI">입고번호</option>
				</select>	
			</div>
			<div style="width:250px">
				<input type="text" id="S_SEARCHKEY" name="S_SEARCHKEY" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<li class="sech_li required">
			<div style="width:100px">창고</div>
			<div style="width:250px">	
				<input type="text" id="S_WHCD" name="S_WHCD" class="cmc_code required"/>
				<input type="text" id="S_WHNM" name="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>	
		<li class="sech_li">
			<div style="width:100px">품목코드/명</div>
			<div style="width:250px">		
				<input type="text" id="S_ITEM" name="S_ITEM" class="cmc_txt" />
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
	<div id="tab1" class="ct_tab">
		<ul>
			<li id="firstTab"><a href="#tab1Cont1">지시전표단위처리</a></li>
			<li id="secondTab"><a href="#tab1Cont2">부분/분할처리</a></li>
		</ul>
		<div id="tab1Cont1">
			<div class="ct_top_wrap">
				<div class="grid_top_wrap">
					<div class="grid_top_left">입고지시 리스트<span>(총 0건)</span></div>
					<div class="grid_top_right">
					</div>
				</div>
				<div id="grid1"></div>
			</div>
			<div class="ct_bot_wrap">
				<div class="grid_top_wrap">
					<div class="grid_top_left">상세 리스트<span>(총 0건)</span></div>
					<div class="grid_top_right">
						<!-- <input type="text" id="A_LOCCD" class="cmc_code" />
						<input type="hidden" id="A_LOCCD_R" class="cmc_value" />
						<button type="button" class="cmc_cdsearch"></button> 
						<input type="button" id="btn_applyAll" class="cmb_normal authupd" value="일괄적용"/>
						<input type="button" id="btn_setQtyLoc" class="cmb_normal authupd" value="지시 ->실적 적용" /> -->
					</div>
				</div>
				<div id="grid2"></div>
			</div>
		</div>
		<div id="tab1Cont2">
			<div class="grid_top_wrap">
				<div class="grid_top_left">미입고리스트<span>(총 0건)</span></div>
				<div class="grid_top_right">
					<!-- <input type="text" id="A_LOCCD2" class="cmc_code" />
					<input type="hidden" id="A_LOCCD_R2" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
					<input type="button" id="btn_applyAll2" class="cmb_normal authupd" value="일괄적용"/> -->
					<input type="button" id="btn_setQtyLoc2" class="cmb_normal authupd" value="지시수량을 실적수량에 적용" />
				</div>
			</div>
			<div id="grid3"></div>
		</div>
	</div>
</div>

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

	setCommBtn('execute', null, '실적처리');
	setCommBtn('user1', null, '강제종료');
	$('#S_WISTS').val('200');
	
	$('#S_WIDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WIDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_WHCD').val(cfn_loginInfo().WHCD); 
	$('#S_WHNM').val(cfn_loginInfo().WHNM); 
	
	grid1_Load();
	grid2_Load();
	grid3_Load();
		
	/* 공통코드 코드/명 (창고) */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'S_WHCD,S_WHNM'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	
	/* 공통코드 코드/명 (거래처) */
	/* pfn_codeval({
		url:'/alexcloud/popup/popP003/view.do',codeid:'S_CUSTCD',
		inparam:{S_COMPCD:'S_COMPCD',S_CUSTCD:'S_CUSTCD,S_CUSTNM',S_ORGCD:'S_ORGCD',S_ORGNM:'S_ORGNM'},
		outparam:{CUSTCD:'S_CUSTCD',NAME:'S_CUSTNM'},
		params:{CODEKEY:'ISSUPPLIER'}
	}); */

	/* 공통코드 코드/명 (지시전표단위처리 - 일괄적용 로케이션) */
	/* pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'A_LOCCD',
		inparam:{S_COMPCD:'S_COMPCD',S_LOCCD:'A_LOCCD,A_LOCCD_R',S_WHCD:'C_CHKWHCD',S_WHNM:'C_CHKWHNM'},
		outparam:{LOCCD:'A_LOCCD,A_LOCCD_R'}
	}); */

	/* 공통코드 코드/명 (부분/분할처리 - 일괄적용 로케이션) */
	/* pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'A_LOCCD2',
		inparam:{S_COMPCD:'S_COMPCD',S_LOCCD:'A_LOCCD2,A_LOCCD_R2',S_WHCD:'C_CHKWHCD',S_WHNM:'C_CHKWHNM'},
		outparam:{LOCCD:'A_LOCCD2,A_LOCCD_R2'}
	});
 */
	/* 공통코드 코드/명 (셀러) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});

	//지시 -> 실적 반영 버튼 클릭 이벤트
	$('#btn_setQtyLoc').click(function () {
		fn_setQtyLoc();
	});
	//지시 -> 실적 반영 버튼 클릭 이벤트
	$('#btn_setQtyLoc2').click(function () {
		fn_setQtyLoc2();
	});
	
	// 일괄적용 버튼 클릭 이벤트
	/*  $('#btn_applyAll').click(function () {
		fn_applyAll();
	});
	*/
	// 일괄적용 버튼 TAB2 클릭 이벤트
	/* $('#btn_applyAll2').click(function () {
		fn_applyAll2();
	}); */
	
	$("#firstTab").on("click", function() {
		fn_tabChange('1');
	});

	$("#secondTab").on("click", function() {
		fn_tabChange('2');
	});

	if ($('#S_ORGCD').val().length > 0) {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}
	
	if($('#S_WHCD').val().length > 0){
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	}
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'WDKEY',header:{text:'입고지시번호'},width:150, styles:{textAlignment:'center'}},
		{name:'WDDT',header:{text:'입고일'},width:120,formatter:'date', styles:{textAlignment:'center'}},
		{name:'WDTYPE',header:{text:'입고지시유형'},width:100,formatter:'combo',comboValue:'${gCodeWDTYPE}',styles:{textAlignment:'center'}},
		{name:'WDSTS',header:{text:'입고지시상태'},width:120,styles:{textAlignment:'center'},formatter:'combo',comboValue:'${gCodeWISTS}',
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 400',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}]},
				
		{name:'WHCD',header:{text:'창고코드'},width:80, styles:{textAlignment:'center'},show:false},
		{name:'WHNM',header:{text:'창고명'},width:100, styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'셀러코드'},width:80, styles:{textAlignment:'center'},show:false},
		{name:'ORGNM',header:{text:'셀러명'},width:100, styles:{textAlignment:'center'}},
		
		/* {name:'CUSTNM',header:{text:'거래처명'},width:150}, */
		{name:'REMARK',header:{text:'비고'},width:300},
		{name:'PROGRESS_QTY',header:{text:'실적현황'},width:100,formatter:'progressbar',dataType:'number',
			dynamicStyles:[
				{criteria:'value >= 0',styles:{figureBackground:cfn_getStsColor(4)}},
				{criteria:'value >= 50',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value >= 100',styles:{figureBackground:cfn_getStsColor(3)}} 
			]
		},
		{name:'ITEMCNT',header:{text:'품목수'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'WDSCHQTY',header:{text:'지시 총 수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'WDQTY',header:{text:'입고 총 수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'변경IP'},width:100,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			var param = {'WDKEY':$('#' + gid).gfn_getValue(newRowIdx, 'WDKEY')};
			fn_getDetailList(param);
			
			$('#C_CHKWHCD').val($('#' + gid).gfn_getValue(newRowIdx, 'WHCD'));
			$('#C_CHKWHNM').val($('#' + gid).gfn_getValue(newRowIdx, 'WHNM'));
			
		};
		
		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			if (oldIndex.dataRow !== -1 && oldIndex.dataRow !== newIndex.dataRow) {
				var grid2Data = $('#grid2').gfn_getDataList(false);
				var state = dataProvider.getRowState(oldIndex.dataRow);
				
				if (grid2Data.length > 0) {
					if (confirm('변경된 내용이 있습니다. 실행하시겠습니까?')) {
						cfn_execute('Y');
					}
					return false;
				}
			} 
		};
	});
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
	{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WISEQ',header:{text:'입고SEQ'},width:70,styles:{textAlignment:'far'}},
		{name:'WDKEY',header:{text:'입고지시번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WDSEQ',header:{text:'지시SEQ'},width:70,styles:{textAlignment:'far'}},
		{name:'WDSTS',header:{text:'입고상태'},width:100,formatter:'combo',comboValue:'${gCodeWISTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 400',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}]},
				
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:350},
		
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'SCHLOCCD',header:{text:'지시로케이션'},width:100,styles:{textAlignment:'center'}},
		{name:'LOCCD',header:{text:'입고로케이션'},formatter:'popup',width:100,styles:{textAlignment:'center'}, required:true},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		
		{name:'WDSCHQTY_BOX',header:{text:'지시[BOX]'},width:90,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDSCHQTY_EA',header:{text:'지시[EA]'},width:90,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDSCHQTY',header:{text:'지시수량'},width:90,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'WDQTY_BOX',header:{text:'실적[BOX]'},width:90,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDQTY_EA',header:{text:'실적[EA]'},width:90,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDQTY',header:{text:'실적수량'},width:90,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1),  show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2),  show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3),  show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100,  show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100,  show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		{name:'REMARK',header:{text:'비고'},width:300, maxlength:200},
		
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		
		/* {name:'IFORDERNO',header:{text:'IF구매번호'},width:130,styles:{textAlignment:'center'}},
		{name:'IFORDERSUBNO',header:{text:'IF상세번호'},width:110,styles:{textAlignment:'center'}},
		{name:'IFORDERSEQ',header:{text:'IF순번'},width:80,styles:{textAlignment:'far'}},
		{name:'IFPOQTY',header:{text:'구매서입고요청량'},width:130,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}}, */
		
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100,show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100,show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100,show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100,show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100,show:cfn_getCompItemVisible(15)},
	];

	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true,editable:true,mstGrid:'grid1'});
	
	$('#' + gid).gridView().setCheckableExpression("values['WDSTS'] <> '400'", true);
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		/* gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var editable = grid.getValue(newRowIdx, 'WDSTS') !== '400';
				$('#' + gid).gfn_setColDisabled(['LOT1', 'LOT2', 'LOT3', 'LOT4', 'LOT5', 'REMARK'], editable);
			}
		};
		
		dataProvider.onDataChanged = function (provider) {
	    	var rowidx = $('#' + gid).gfn_getCurRowIdx();
			var gridData = $('#' + gid).gfn_getDataRow(rowidx);
			
			var lot1 = $('#' + gid).gfn_getValue(rowidx, 'LOT1');
			var inputDate = new Date(lot1.substr(0,4), parseInt(lot1.substr(4,2))-1, lot1.substr(6,2));
			var todayDate = new Date();
			
	        if(inputDate > todayDate){
	        	cfn_msg('ERROR', '제조일자는 현재일 이후의 날짜로는\n 입력할 수 없습니다.');
	        	$('#' + gid).gfn_setValue(rowidx, 'LOT1', ''); 
	    		return false;
	        }
	    }; */
	});
	
}

function grid3_Load() {
	var gid = 'grid3';
	var columns = [
		{name:'WDKEY',header:{text:'입고지시번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WDTYPE',header:{text:'입고지시유형'},width:100,formatter:'combo',comboValue:'${gCodeWDTYPE}',styles:{textAlignment:'center'}},
		{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WISEQ',header:{text:'입고SEQ'},width:100,styles:{textAlignment:'center'}},
		{name:'WISTS',header:{text:'입고상태'},width:120,styles:{textAlignment:'center'},formatter:'combo',comboValue:'${gCodeWISTS}',
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 400',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}]},  
				
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:250},
		{name:'SCHLOCCD',header:{text:'지시로케이션'},width:100,styles:{textAlignment:'center'}},
		{name:'LOCCD',header:{text:'입고로케이션'},formatter:'popup',width:100, styles:{textAlignment:'center'},required:true},
		
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'WDSCHQTY_BOX',header:{text:'지시[BOX]'},width:90,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDSCHQTY_EA',header:{text:'지시[EA]'},width:90,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDSCHQTY',header:{text:'지시수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'WDQTY_BOX',header:{text:'실적[BOX]'},width:90,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDQTY_EA',header:{text:'실적[EA]'},width:90,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDQTY',header:{text:'분할실적수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editable:true,editor:{maxLength:11,type:"number",positiveOnly:true},required:true,minVal:1,
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1),  show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2),  show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3),  show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100,  show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100,  show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		{name:'REMARK',header:{text:'비고'},width:300, maxlength:200},
		
		/* {name:'IFORDERNO',header:{text:'IF구매번호'},width:130,styles:{textAlignment:'center'}},
		{name:'IFORDERSUBNO',header:{text:'IF상세번호'},width:110,styles:{textAlignment:'center'}},
		{name:'IFORDERSEQ',header:{text:'IF순번'},width:80,styles:{textAlignment:'far'}},
		{name:'IFPOQTY',header:{text:'구매서입고요청량'},width:130,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}}, */
		
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100,show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100,show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100,show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100,show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100,show:cfn_getCompItemVisible(15)},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true,editable:true});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 수정 이벤트
		gridView.onCellEdited = function(grid, itemIdx, dataRow, fieldIdx) {
			var WDSCHQTY = $('#' + gid).gfn_getValue(dataRow, 'WDSCHQTY');
			var WDQTY = $('#' + gid).gfn_getValue(dataRow, 'WDQTY');
			if (WDQTY > WDSCHQTY) {
				$('#' + gid).gfn_setValue(dataRow, 'WDQTY', 0);
				cfn_msg('WARNING', '미입고 수량 이하로 입력하시기 바랍니다.');
			}
		};

		//셀 수정 이벤트
		gridView.onEditChange = function(grid, column, value) {
			if (column.column === 'WDQTY') {
				var INBOXQTY = $('#' + gid).gfn_getValue(column.dataRow, 'INBOXQTY');
				var UNITTYPE = $('#' + gid).gfn_getValue(column.dataRow, 'UNITTYPE');

				if (INBOXQTY <= 0) {
					$('#' + gid).gfn_setValue(column.dataRow, 'WDQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'WDQTY_EA', 0);
					
					cfn_msg('ERROR', '품목의 박스입수량이 잘못되었습니다.');
					return false;
				}
				
				if (UNITTYPE == 'BOXEA') {
					$('#' + gid).gfn_setValue(column.dataRow, 'WDQTY_BOX', parseInt(value / INBOXQTY)); 
					$('#' + gid).gfn_setValue(column.dataRow, 'WDQTY_EA', parseInt(value % INBOXQTY));	
				} else if (UNITTYPE == 'EA'){
					$('#' + gid).gfn_setValue(column.dataRow, 'WDQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'WDQTY_EA', value);	
				}
			}
		};

		// 셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			$('#C_CHKWHCD').val($('#' + gid).gfn_getValue(newRowIdx, 'WHCD'));
			$('#C_CHKWHNM').val($('#' + gid).gfn_getValue(newRowIdx, 'WHNM'));
			
		};
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').gridView().commit();
		$('#grid1').gfn_setDataList(data.resultList);
		/* $('#A_LOCCD').val(''); */
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//미입고리스트 검색
	if (sid == 'sid_getTab2List') {
		$('#grid3').gfn_setDataList(data.resultList);
	}
	//입고실적 처리 
	if (sid == 'sid_instruct') {
		cfn_msg('INFO', '실적 등록 되었습니다.');
		cfn_retrieve();
	}
	//강제종료 
	if (sid == 'sid_setExecute') {
		cfn_msg('INFO', '강제종료 되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	
	$('#grid1').gridView().cancel();
	$('#grid2').gridView().cancel();
	$('#grid3').gridView().cancel();
	
	//검색조건 필수입력 체크
	if(cfn_isFormRequireData('frmSearch') == false) return; 
	
	gv_searchData = cfn_getFormData('frmSearch');

	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100320/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	if ($("#tab1").tabs("option", "active") == 1){
		sid = 'sid_getTab2List';
		url = '/alexcloud/p100/p100320/getTab2List.do';
	}
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p100/p100320/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 입고 실적 처리 */
function cfn_execute(directmsg) {
	
	var formdata = cfn_getFormData('frmSearch');
	
	if ($("#tab1").tabs("option", "active") == 0){
		
		var rowidx = $('#grid1').gfn_getCurRowIdx();
		if (rowidx < 0) {
			cfn_msg('WARNING', '선택된 전표가 없습니다.');
			return false;
		}
		var masterData = $('#grid1').gfn_getDataRow(rowidx);
		
		if(masterData.WDSTS == '400'){
			cfn_msg('WARNING', '입고완료되어 처리 불가합니다.');
			return false;
		}
	
		$('#grid2').gridView().commit();
		
		// 필수 입력 체크 
		if ($('#grid2').gfn_checkValidateCells()) return false;
		
		var gridDataRows = $('#grid2').gfn_getDataList();
		var exeData = [];
		
		for (var i=0, len=gridDataRows.length; i<len; i++) {
			
			if($('#grid2').gfn_getValue(i, 'WDSTS') == "200"){
				if($('#grid2').gfn_getValue(i, 'LOCCD') == '' || $('#grid2').gfn_getValue(i, 'LOCCD') == null) {
					var index = {dataRow:i,fieldName:'LOCCD'};
					$('#grid2').gridView().setCurrent(index);
					$('#grid2').gridView().setFocus();
					cfn_msg('WARNING', '입고로케이션을  입력하세요.');
					return;
				}
				var param = $('#grid2').gfn_getDataRow(i);
				exeData.push(param);
			}
		}

		if(exeData.length < 1){
			cfn_msg('WARNING', '선택하신 내역은 실적 불가 합니다.');
			return;
		}
		
		var flg = true;
		if (directmsg !== 'Y') {
			flg = confirm('입고 실적 처리를 하시겠습니까?');
		}
		
		if (flg) {
			var sid = 'sid_instruct';
			var url = '/alexcloud/p100/p100320/setInstruct.do';
			var sendData = {'paramData':formdata,'paramDataList':exeData};
			gfn_sendData(sid, url, sendData);
		}
	} else {
		
		$('#grid3').gridView().commit();
		
		var checkRows = $('#grid3').gridView().getCheckedRows();
		
		if (checkRows.length < 1) {
			cfn_msg('WARNING', '선택된 행이 없습니다.');
			return false;
		}
		
		// 필수 입력 체크 
		if ($('#grid3').gfn_checkValidateCells(checkRows)) return false;
		
		/* for (var i = 0; i < checkRows.length; i++) { 
			if($('#grid3').gfn_getValue(checkRows[i], 'LOCCD') == '' || $('#grid3').gfn_getValue(checkRows[i], 'LOCCD') == null) {
				var index = {dataRow:checkRows[i],fieldName:'LOCCD'};
				$('#grid3').gridView().setCurrent(index);
				$('#grid3').gridView().setFocus();
				alert('입고로케이션을  입력하세요.');
				return;
			}
			if($('#grid3').gfn_getValue(checkRows[i], 'WDQTY') == 0 || $('#grid3').gfn_getValue(checkRows[i], 'WDQTY') == '' || $('#grid3').gfn_getValue(checkRows[i], 'WDQTY') == null) {
				var index = {dataRow:checkRows[i],fieldName:'WDQTY'};
				$('#grid3').gridView().setCurrent(index);
				$('#grid3').gridView().setFocus();
				alert('입고수량을  입력하세요.');
				return;
			}
	    } */
		
		var gridData = $('#grid3').gfn_getDataRows(checkRows);

		var flg = true;
		if (directmsg !== 'Y') {
			flg = confirm('입고 실적 처리를 하시겠습니까?');
		}
		
		if (flg) {
			var sid = 'sid_instruct';
			var url = '/alexcloud/p100/p100320/setInstruct.do';
			var sendData = {'paramData':formdata,'paramDataList':gridData};
			gfn_sendData(sid, url, sendData);
		}
	}
}

/* 지시수량 및 로케이션을 실적수량을 반영 */
function fn_setQtyLoc(){
	$('#grid2').gridView().commit(true);
	var checkRows = $('#grid2').gridView().getCheckedRows();
	
	if(checkRows.length < 1) {
		cfn_msg('WARNING','체크된 품목이 없습니다.');
		return;
	}
	
	for (var i = 0; i < checkRows.length; i++) { 
		$('#grid2').gfn_setValue(checkRows[i], 'LOCCD', $('#grid2').gfn_getValue(checkRows[i], 'SCHLOCCD'));
    }
}

/* 지시수량 및 로케이션을 실적수량을 반영 */
function fn_setQtyLoc2(){
	$('#grid3').gridView().commit(true);
	var checkRows = $('#grid3').gridView().getCheckedRows();
	
	if(checkRows.length < 1) {
		cfn_msg('WARNING','체크된 품목이 없습니다.');
		return;
	}
	
	for (var i = 0; i < checkRows.length; i++) { 
		$('#grid3').gfn_setValue(checkRows[i], 'LOCCD', $('#grid3').gfn_getValue(checkRows[i], 'SCHLOCCD'));
		$('#grid3').gfn_setValue(checkRows[i], 'WDQTY', $('#grid3').gfn_getValue(checkRows[i], 'WDSCHQTY'));
	}
}

/* 로케이션 일괄적용 */
function fn_applyAll() {
	var checkRows = $('#grid2').gridView().getCheckedRows();
	
	if(checkRows.length < 1) {
		cfn_msg('WARNING','체크된 품목이 없습니다.');
		return;
	}
	
	var loccd = $('#A_LOCCD_R').val();
	
	if(cfn_isEmpty(loccd)) {
		cfn_msg('WARNING','로케이션을 입력하세요.');
		return;
	}
	

	for (var i = 0; i < checkRows.length; i++) { 
		$('#grid2').gfn_setValue(checkRows[i], 'LOCCD', loccd);
	}
	
	$('#A_LOCCD').val('');
	$('#A_LOCCD_R').val('');
}

/* 로케이션 일괄적용 */
function fn_applyAll2() {	
	var checkRows = $('#grid3').gridView().getCheckedRows();
	
	if(checkRows.length < 1) {
		cfn_msg('WARNING','체크된 품목이 없습니다.');
		return;
	}

	var loccd = $('#A_LOCCD_R2').val();
	
	if(cfn_isEmpty(loccd)) {
		cfn_msg('WARNING','로케이션을 입력하세요.');
		return;
	}
	
	for (var i = 0; i < checkRows.length; i++) { 
		$('#grid3').gfn_setValue(checkRows[i], 'LOCCD', loccd);
	}
	
	$('#A_LOCCD2').val('');
	$('#A_LOCCD_R2').val('');
}

function fn_tabChange(tabIndex){
	
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);
	$('#grid3').gridView().commit(true);
	
	if(tabIndex === '1'){
		$('#grid3').gfn_setDataList(null);
		$('#S_WISTS').removeClass("disabled").attr('disabled',false);
	} else {
		$('#grid1').gfn_setDataList(null);
		$('#grid2').gfn_setDataList(null);
		$('#S_WISTS').addClass("disabled").attr('disabled',true);
	}
}


/* 공통버튼 - 사용자1(강제종료) */
function cfn_userbtn1() {
	
	var tabidx = cfn_getTabIdx('tab1');
	if(tabidx !== 1) {
		cfn_msg('WARNING', '지시전표단위처리 탭으로 이동해주세요.');
		return false;		
	}
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);

	if (masterData.WDSTS === '200') {
		cfn_msg('WARNING', '지시완료 상태에서는 강제종료 할 수 없습니다.');
		return false;
	}
	if (masterData.WDSTS === '400') {
		cfn_msg('WARNING', '입고완료 상태에서는 강제종료 할 수 없습니다.');
		return false;
	}
	if (confirm('강제종료 하시겠습니까?')) {
		var sid = 'sid_setExecute';
		var url = '/alexcloud/p100/p100320/setExecute.do';
		var sendData = {'paramData':masterData};
		
		gfn_sendData(sid, url, sendData);
	}
}
</script>

<c:import url="/comm/contentBottom.do" />