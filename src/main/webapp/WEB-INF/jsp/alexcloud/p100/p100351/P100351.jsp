<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100351
	화면명    : 입고실적조정 - RealGrid 마스터 디테일 그리드 2개 패턴
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	
	<ul class="sech_ul">
		<li class="sech_li">
			<div>입고일자</div>
			<div style="width:250px;">
				<input type="text" id="S_WIDT_FROM" class="cmc_date periods"/> ~
				<input type="text" id="S_WIDT_TO" class="cmc_date periode"/>
			</div>
		</li>
		<li class="sech_li">
			<div>입고상태</div>
			<div>
				<select id="S_WISTS" class="cmc_combo disabled" disabled="disabled">
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
			<div style="width:250px">
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
			<div>로케이션</div>
			<div style="width:250px;">
				<input type="text" id="S_LOCCD" class="cmc_code" />
				<!-- <button type="button" class="cmc_cdsearch"></button> -->
			</div>
		</li>
		<li class="sech_li">
			<div>품목코드/명</div>
			<div style="width:250px;">
				<input type="text" id="S_ITEM" class="cmc_txt" />
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
		<div class="grid_top_left">입고 실적 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
	
</div>
<!-- 그리드 끝 -->

<!-- 그리드 시작 -->
<div class="ct_bot_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고 실적 상세 리스트 <span>(총 0건)</span></div>
		<div class="grid_top_right">
			<span style="color: red; font-size: 12px; font-weight: bold; padding-left:20px">※ 최종입고량이 최종 입고실적수량입니다.</span>
		</div>
	</div>
	<div id="grid2"></div>
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
	
	$('#S_WIDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WIDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	

	$('#S_WITYPE').val('STD');
	$('#S_WISTS').val('400'); 
	
	//로그인 정보로 세팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	

	
	
	grid1_Load();
	grid2_Load();
	
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
	
	/* 공통코드 코드/명 (로케이션) 
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'S_LOCCD',
		inparam:{S_LOCCD:'S_LOCCD',S_WHCD:'S_WHCD'},
		outparam:{LOCCD:'S_LOCCD'},
		beforeFn: function() { 
			if(cfn_isEmpty($('#S_WHCD').val())) {
				cfn_msg('WARNING', '창고를 선택하세요.');
				return false;
			}
		}
	});*/
	
 	if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
		$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
		$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	} 
 	
 	if(!cfn_isEmpty(cfn_loginInfo().WHCD)){
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
		{name:'WISCHDT',header:{text:'입고요청일자'},width:120,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WIDT',header:{text:'입고일자'},width:120,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WISTS',header:{text:'입고상태'},width:120,formatter:'combo',comboValue:'${gCodeWISTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 400',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}]},   
		{name:'WITYPE',header:{text:'입고유형'},width:90,formatter:'combo',comboValue:'${gCodeWITYPE}',styles:{textAlignment:'center'}},
		
		{name:'WHCD',header:{text:'창고코드'},width:80,styles:{textAlignment:'center'}},
		{name:'WHNM',header:{text:'창고명'},width:120,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'셀러코드'},width:80,styles:{textAlignment:'center'}},
		{name:'ORGNM',header:{text:'셀러명'},width:120,styles:{textAlignment:'center'}},
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:120,styles:{textAlignment:'center'}},
		{name:'CUSTNM',header:{text:'거래처명'},width:150}, */
		
		{name:'REMARK',header:{text:'비고'},width:300},
		{name:'ITEMCNT',header:{text:'품목수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'TOTQTY',header:{text:'총수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		
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
	$('#' + gid).gfn_createGrid(columns, {editable:true});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			var param = {'WIKEY':$('#' + gid).gfn_getValue(newRowIdx, 'WIKEY')};

			fn_getDetailList(param);
			
			if (newRowIdx > -1) {
				//입고상태가 400인 컬럼만 수량 변경처리(입고완료)
				var editable = $('#' + gid).gfn_getValue(newRowIdx, 'WISTS') === '400';
				
				$('#grid2').gfn_setColDisabled(['AFTERQTY'], editable);
			}
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
		{name:'WDKEY',header:{text:'입고지시번호'},width:150,styles:{textAlignment:'center'}},
		{name:'SEQ',header:{text:'지시순번'},width:70,dataType:'number',styles:{textAlignment:'far'}},
		{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WISEQ',header:{text:'입고순번'},width:70,dataType:'number',styles:{textAlignment:'far'}},
		
		
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품명'},width:250},
		
		{name:'LOCCD',header:{text:'입고로케이션'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},		
		{name:'WDQTY_BOX',header:{text:'입고[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},	
		{name:'WDQTY_EA',header:{text:'입고[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDQTY',header:{text:'입고수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'AFTERQTY_BOX',header:{text:'최종입고[BOX]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},			
		{name:'AFTERQTY_EA',header:{text:'최종입고[EA]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'AFTERQTY',header:{text:'최종입고수량'},width:90,dataType:'number',editable:true,styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11,type:"number",positiveOnly:true,integerOnly:true},required:true,
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'REMARK',header:{text:'비고'},width:300,editable:true},
		
		{name:'LOTKEY',header:{text:'로트키'},width:100,styles:{textAlignment:'center'}},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, editor:{maxLength:50}, formatter:cfn_getLotType(1), show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, editor:{maxLength:50}, formatter:cfn_getLotType(2), show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, editor:{maxLength:50}, formatter:cfn_getLotType(3), show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',comboValue:'${gCodeLOT4}',styles:{textAlignment:'center'}},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',comboValue:'${gCodeLOT5}',styles:{textAlignment:'center'}},
		
		/* {name:'IFORDERNO',header:{text:'IF구매번호'},width:130,styles:{textAlignment:'center'}},
		{name:'IFORDERSUBNO',header:{text:'IF상세번호'},width:110,styles:{textAlignment:'center'}},
		{name:'IFORDERSEQ',header:{text:'IF순번'},width:80,styles:{textAlignment:'far'}},
		{name:'IFPOQTY',header:{text:'구매서입고요청량'},width:130,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}}, */
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'WHCD',header:{text:'창고코드'},width:100,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,show:false},
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
	$('#' + gid).gfn_createGrid(columns, {editable:true, checkBar:true});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 수정 이벤트
		gridView.onEditChange = function(grid, column, value) {
			if (column.column === 'AFTERQTY') {
				var INBOXQTY = $('#' + gid).gfn_getValue(column.dataRow, 'INBOXQTY');
				var UNITTYPE = $('#' + gid).gfn_getValue(column.dataRow, 'UNITTYPE');

				if (INBOXQTY <= 0) {
					$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_EA', 0);
					cfn_msg('ERROR', '품목의 박스입수량이 잘못되었습니다.');
					return false;
				}
				
				if (UNITTYPE == 'BOXEA') {
					$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_BOX', parseInt(value / INBOXQTY)); 
					$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_EA', parseInt(value % INBOXQTY));	
				} else if (UNITTYPE == 'EA') {
					$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_EA', value);
				}
			}
		};
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').gridView().commit();
		$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);		
		
		//검색결과에 따른 마스터 데이터 포커스 이동 처리 (저장처리 이후 발생 gfn_setFocusPK함수 처리)
		$('#grid1').gfn_focusPK();
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//실행
	if (sid == 'sid_setExecute') {
		var resultData = data.resultData;

		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['WIKEY']);
		
		cfn_msg('INFO', '정상적으로 실행되었습니다.');
		
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100351/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p100/p100351/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 실행 클릭 */
function cfn_execute(directmsg) {
	$('#grid2').gridView().commit();
	
	var checkRows = $('#grid2').gridView().getCheckedRows();
	
	if (checkRows.length < 1) {
		cfn_msg('WARN', '선택된 행이 없습니다.');
		return false;
	}
	
	var detailData = $('#grid2').gfn_getDataRows(checkRows);
	
	//디테일 필수입력 체크
	//if ($('#grid2').gfn_checkValidateCells(checkRows)) return false; -> 수량에 0이 들어갈 수 있기 때문에 FOR문으로 돌린다.
	
	for (var i = 0; i < detailData.length; i++) { 
		if(cfn_isEmpty(detailData[i].AFTERQTY)) {
			cfn_msg('WARNING', '변경수량은 필수 입력입니다.');
			return;
		} 
	}
	
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('입고수량을 변경하시겠습니까??');
	}
	
	if (flg) {
		var sid = 'sid_setExecute';
		var url = '/alexcloud/p100/p100351/setExecute.do';
		var sendData = {'paramDataList':detailData};
	
		gfn_sendData(sid, url, sendData);
	}
}
</script>

<c:import url="/comm/contentBottom.do" />