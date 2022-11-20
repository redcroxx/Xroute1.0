<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100340
	화면명    : 입고조정/취소관리 > 입고실적취소
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" name="S_COMPCD" class="cmc_code" />
	
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
				<select id="S_WISTS" name="S_WISTS" class="cmc_combo disabled" disabled="disabled">
					<option value="">전체</option>
					<c:forEach var="i" items="${codeWISTS}">
						<c:if test="${i.code == '400'}">
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
			<div>창고</div><!-- 필수? -->
			<div style="width:250px;">
				<input type="text" id="S_WHCD" class="cmc_code"/>
				<input type="text" id="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<!-- <li class="sech_li">
			<div>거래처</div>
			<div style="width:250px;">
				<input type="text" id="S_CUSTCD" class="cmc_code" />
				<input type="text" id="S_CUSTNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li> -->
		<li class="sech_li">
			<div>
				<select id="S_SERACHCOMBO" class="cmc_combo" style="width:80px">
					<option value="WIKEY">입고번호</option>
					<option value="WDKEY">지시번호</option>
				</select>
			</div>
			<div style="width:250px">				
				<input type="text" id="S_SEARCH" class="cmc_txt" />
			</div>
		</li>
			
	</ul>
	<ul class="sech_ul">
		<li class="sech_li">
			<div>품목코드/명</div>
			<div>		
				<input type="text" id="S_ITEM" class="cmc_txt" />
			</div>
		</li>	
	</ul>
	<div id="sech_extbtn" class="down"></div>
	<div id="sech_extline"></div>
	<div id="sech_extwrap">
		<!-- 회사정보 조회조건 -->
		<ul class="sech_ul">
			<li class="sech_li">
				<div>셀러</div>
				<div style="width:250px">		
					<input type="text" id="S_ORGCD" class="cmc_code" />
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>			
		</ul>		
		<c:import url="/comm/compItemSearch.do" />
	</div>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<span style="color : #FF0000; font-size: 12px; font-weight: bold; padding-left:20px">※ 입고존에 재고가 있어야 취소됩니다.</span>
		</div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- 그리드 시작 -->
<div class="ct_bot_wrap">
	<div id="tab1" class="ct_tab">
		<ul>
			<li id="firstTab"><a href="#tab1Cont1">입고상세</a></li>
			<li id="secondTab"><a href="#tab1Cont2">실적상세</a></li>
		</ul>
		<div id="tab1Cont1">
			<div class="grid_top_wrap">
				<div class="grid_top_left">입고 상세 리스트<span>(총 0건)</span></div>
				<div class="grid_top_right"></div>
			</div>
			<div id="grid2"></div>
		</div>
		<div id="tab1Cont2">
			<div class="grid_top_wrap">
				<div class="grid_top_left">실적 상세 리스트<span>(총 0건)</span></div>
				<div class="grid_top_right"></div>
			</div>
			<div id="grid3"></div>
		</div>
	</div>
	
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
	
	setCommBtn('execute', true, '입고예정처리');
	setCommBtn('cancel', true, '입고취소');
	
	/* var fromdate = new Date();
	fromdate.setDate(fromdate.getDate() + 6);
	$('[name="S_WIDT_FROM"]').val($.datepicker.formatDate('yy-mm-dd', new Date()));
	$('#S_WISCHDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WISCHDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WISTS').val('400'); */
	
	$('#S_WIDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WIDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	
	//로그인 정보로 셋팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_WHCD').val(cfn_loginInfo().WHCD);
	$('#S_WHNM').val(cfn_loginInfo().WHNM);
	//$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	//$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	
	grid1_Load();
	grid2_Load();
	grid3_Load();
	
	/* 셀러 */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	/* 창고 */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'S_WHCD,S_WHNM'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	
	/* 거래처 */
	/* pfn_codeval({
		url:'/alexcloud/popup/popP003/view.do',codeid:'S_CUSTCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD',S_ORGNM:'S_ORGNM',S_CUSTCD:'S_CUSTCD,S_CUSTNM'},
		outparam:{CUSTCD:'S_CUSTCD',NAME:'S_CUSTNM'},
		params:{CODEKEY:'ISSHIPPER'}
	});	 */
	
	//cfn_initSearch();
	
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
		{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WDKEY',header:{text:'입고지시번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WISCHDT',header:{text:'입고요청일자'},width:120,styles:{textAlignment:'center'},formatter:'date'},
		{name:'WIDT',header:{text:'입고일자'},width:120,styles:{textAlignment:'center'},formatter:'date'},
		{name:'WISTS',header:{text:'입고상태'},width:120,styles:{textAlignment:'center'},formatter:'combo',comboValue:'${gCodeWISTS}',
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 400',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}]},   
		{name:'WITYPE',header:{text:'입고유형'},width:70,styles:{textAlignment:'center'},formatter:'combo',comboValue:'${gCodeWITYPE}'},
		
		{name:'ORGCD',header:{text:'셀러코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ORGNM',header:{text:'셀러명'},width:100,styles:{textAlignment:'center'}},
		{name:'WHCD',header:{text:'창고코드'},width:70,styles:{textAlignment:'center'}},
		{name:'WHNM',header:{text:'창고명'},width:100,styles:{textAlignment:'center'}},
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:120,styles:{textAlignment:'center'}},
		{name:'CUSTNM',header:{text:'거래처명'},width:150}, */
		{name:'REMARK',header:{text:'비고'},width:300},
		
		{name:'ITEMCNT',header:{text:'품목수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'TOTQTY',header:{text:'총수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'TOTSUPPLYAMT',header:{text:'총입고금액'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'CARNO',header:{text:'입고차량번호'},width:100},
		{name:'DRIVER',header:{text:'차량운전자'},width:100},
		{name:'DRIVERTEL',header:{text:'운전자연락처'},width:100},
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true,editable:true});
	
	$('#' + gid).gridView().setCheckableExpression("values['WISTS'] = '400'", true);
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			var param = {'WIKEY':$('#' + gid).gfn_getValue(newRowIdx, 'WIKEY')};
			fn_getDetailList(param);
		};
	});
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'SEQ',header:{text:'입고순번'},width:70,dataType:'number',styles:{textAlignment:'far'}},
		
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품명'},width:250}, 
		
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'WISCHQTY_BOX',header:{text:'예정[BOX]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},			
		{name:'WISCHQTY_EA',header:{text:'예정[EA]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WISCHQTY',header:{text:'예정수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'WIQTY_BOX',header:{text:'입고[BOX]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},			
		{name:'WIQTY_EA',header:{text:'입고[EA]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY',header:{text:'입고수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'UNITPRICE',header:{text:'단가'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'SUPPLYAMT',header:{text:'입고금액'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		
		{name:'REMARK',header:{text:'비고'},width:300},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1), show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2), show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3), show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		
		/* {name:'IFORDERNO',header:{text:'IF구매번호'},width:130,styles:{textAlignment:'center'}},
		{name:'IFORDERSUBNO',header:{text:'IF상세번호'},width:110,styles:{textAlignment:'center'}},
		{name:'IFORDERSEQ',header:{text:'IF순번'},width:80,styles:{textAlignment:'far'}},
		{name:'IFPOQTY',header:{text:'구매서입고요청량'},width:130,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}}, */
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'WHCD',header:{text:'창고코드'},width:100,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,show:false},
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
	$('#' + gid).gfn_createGrid(columns, {});
}

function grid3_Load() {
	var gid = 'grid3';
	var columns = [
		{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WISEQ',header:{text:'입고순번'},width:70,dataType:'number',styles:{textAlignment:'far'}},
		{name:'WDKEY',header:{text:'지시번호'},width:150,styles:{textAlignment:'center'}},
		{name:'SEQ',header:{text:'지시순번'},width:70,dataType:'number',styles:{textAlignment:'far'}},
		
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품명'},width:250}, 
		
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		
		{name:'SCHLOCCD',header:{text:'지시로케이션'},width:100,styles:{textAlignment:'center'}},
		{name:'LOCCD',header:{text:'입고로케이션'},width:100,styles:{textAlignment:'center'}},
		
		{name:'WDSCHQTY_BOX',header:{text:'지시[BOX]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},			
		{name:'WDSCHQTY_EA',header:{text:'지시[EA]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDSCHQTY',header:{text:'지시수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'WDQTY_BOX',header:{text:'실적[BOX]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},			
		{name:'WDQTY_EA',header:{text:'실적[EA]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDQTY',header:{text:'실적수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1), show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2), show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3), show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		{name:'REMARK',header:{text:'비고'},width:300},
		
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,show:false},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:120,show:false},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,show:false},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:120,show:false},
		{name:'TERMINALCD',header:{text:'IP'},width:100,show:false},
		
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
	$('#' + gid).gfn_createGrid(columns, {});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid1').gfn_setDataList(data.resultList);
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
		$('#grid3').gfn_setDataList(data.resultList2);
	}
	// 입고예정처리
	if (sid == 'sid_execute') {
		alert('예정 처리되었습니다.');
		cfn_retrieve();
	}
	// 입고취소처리
	if (sid == 'sid_cancel') {
		alert('입고 취소 처리되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100340/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p100/p100340/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 입고예정처리 */
function cfn_execute() {
	
	var formdata = cfn_getFormData('frmSearch');
	
	$('#grid1').gridView().commit();
	
	var checkRows = $('#grid1').gridView().getCheckedRows();
	
	if (checkRows.length < 1) {
		alert('선택된 행이 없습니다.');
		return false;
	}
	
	var gridData = $('#grid1').gfn_getDataRows(checkRows);
	
	if (confirm('입고 예정 처리를 하시겠습니까?') == true) {
		var sid = 'sid_execute';
		var url = '/alexcloud/p100/p100340/setExecute.do';
		var sendData = {'paramData':formdata,'paramDataList':gridData};
		gfn_sendData(sid, url, sendData);
	}
}

/* 입고취소 처리 */
function cfn_cancel() {
	
	var formdata = cfn_getFormData('frmSearch');
	
	$('#grid1').gridView().commit();
	
	var checkRows = $('#grid1').gridView().getCheckedRows();
	
	if (checkRows.length < 1) {
		alert('선택된 행이 없습니다.');
		return false;
	}
	
	var gridData = $('#grid1').gfn_getDataRows(checkRows);

	if (confirm('입고취소 처리를 하시겠습니까?') == true) {
		var sid = 'sid_cancel';
		var url = '/alexcloud/p100/p100340/setCancel.do';
		var sendData = {'paramData':formdata,'paramDataList':gridData};
		gfn_sendData(sid, url, sendData);
	}
}
</script>

<c:import url="/comm/contentBottom.do" />