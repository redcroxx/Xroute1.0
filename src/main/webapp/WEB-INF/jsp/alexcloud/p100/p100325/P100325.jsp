<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100325
	화면명 : 입고지시/실적
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="S_COMPNM" class="cmc_code" />
	<ul class="sech_ul">
		<li class="sech_li">
			<div>입고요청일자</div>
			<div>	
				<input type="text" id="S_WISCHDT_FROM" name="S_WISCHDT_FROM" class="cmc_date periods" /> ~ 	
				<input type="text" id="S_WISCHDT_TO" name="S_WISCHDT_TO" class="cmc_date periode" />		
			</div>
		</li>	
		<li class="sech_li">
			<div>입고상태</div>
			<div>	
				<select id="S_WISTS" name="S_WISTS" class="cmc_combo" >
					<option value="">전체</option>
					<c:forEach var="i" items="${codeWISTS}">
						<c:if test="${i.code == '100' || i.code == '200' || i.code == '400'}">
							<option value="${i.code}" selected>${i.value}</option>
						</c:if>
					</c:forEach>
				</select>			
			</div>
		</li>
		<li class="sech_li">
			<div>
				<select id="S_KEY" name="S_KEY" class="cmc_combo" >
					<option value="WI">입고번호</option>
					<option value="WD">입고지시번호</option>
				</select>	
			</div>
			<div>				
				<input type="text" id="S_KEYBOX" name="S_KEYBOX" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
	
		<li class="sech_li required">
			<div>창고</div>
			<div>
				<input type="text" id="S_WHCD" name="S_WHCD" class="cmc_code required" />
				<input type="text" id="S_WHNM" name="S_WHNM" class="cmc_value" />		
				<button type="button" class="cmc_cdsearch"></button>	
			
			</div>
		</li>
		<!-- <li class="sech_li">
			<div>거래처</div>
			<div>
				<input type="text" id="S_CUSTCD" name="S_CUSTCD" class="cmc_code" />
				<input type="text" id="S_CUSTNM" name="S_CUSTNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
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
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			입고로케이션 
			<input type="text" id="WHINLOCCD" class="cmc_txt disabled" readonly="readonly"/>
		</div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- 그리드 시작 -->
<div class="ct_bot_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고 상세 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
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

	setCommBtn('execute', null, '지시/실적처리');
	
	$('#S_WISCHDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WISCHDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WISTS').val('100');
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM); 
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_WHCD').val(cfn_loginInfo().WHCD); 
	$('#S_WHNM').val(cfn_loginInfo().WHNM); 
	
	grid1_Load();
	grid2_Load();

	/* 공통코드 코드/명 (사업장) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_COMPNM:'S_COMPNM',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
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
	
	if ($('#S_ORGCD').val().length > 0) {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}
	
	if ($('#S_WHCD').val().length > 0) {
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	}
			
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WISCHDT',header:{text:'입고요청일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WIDT',header:{text:'입고일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WISTS',header:{text:'입고상태'},width:120,formatter:'combo',comboValue:'${gCodeWISTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 400',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}]},
		{name:'WITYPE',header:{text:'입고유형'},width:100,formatter:'combo',comboValue:'${gCodeWITYPE}',styles:{textAlignment:'center'}},
		{name:'WHCD',header:{text:'창고코드'},width:80,styles:{textAlignment:'center'}},
		{name:'WHNM',header:{text:'창고'},width:120,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'셀러코드'},width:80,styles:{textAlignment:'center'}},
		{name:'ORGNM',header:{text:'셀러명'},width:120,styles:{textAlignment:'center'}},
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:120,styles:{textAlignment:'center'}},
		{name:'CUSTNM',header:{text:'거래처명'},width:150}, */
		{name:'REMARK',header:{text:'비고'},width:300},
		{name:'PROGRESS_QTY',header:{text:'실적현황'},width:100,formatter:'progressbar',dataType:'number',
			dynamicStyles:[
				{criteria:'value >= 0',styles:{figureBackground:cfn_getStsColor(4)}},
				{criteria:'value >= 50',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value >= 100',styles:{figureBackground:cfn_getStsColor(3)}} 
			]
		},
		{name:'ITEMCNT',header:{text:'품목수'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WISCHQTY',header:{text:'총 예정 수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY',header:{text:'총 입고 수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDKEY',header:{text:'입고지시번호'},width:150,styles:{textAlignment:'center'}},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},show:false},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true});
	
	$('#' + gid).gridView().setCheckableExpression("(values['WISTS'] = '100')", true);
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {	
			if (newRowIdx > -1) {
				var editable = grid.getValue(newRowIdx, 'WISTS') === '100'
				$('#grid2').gfn_setColDisabled(['WIQTY','REMARK', 'LOT1', 'LOT3', 'LOT4', 'LOT5'], editable);
			}
			
			var wikey = $('#' + gid).gfn_getValue(newRowIdx, 'WIKEY');
			if(!cfn_isEmpty(wikey)) {
				var param = {'WIKEY':wikey};
				fn_getDetailList(param);
				
				var masterData = $('#grid1').gfn_getDataRow(newRowIdx);
				fn_getWiLoccd(masterData);
			}
		};
	});
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'SEQ',header:{text:'입고순번'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'ITEMCD',header:{text:'품목코드'},width:120,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:250},
		
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		
		{name:'WISCHQTY_BOX',header:{text:'지시[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WISCHQTY_EA',header:{text:'지시[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WISCHQTY',header:{text:'지시수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY_BOX',header:{text:'실적[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY_EA',header:{text:'실적[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY',header:{text:'실적수량'},width:100, editable:true,required:true,dataType:'number',minVal:1,styles:{textAlignment:'far',numberFormat:'#,##0'},
				editor:{maxLength:11,type:'number',positiveOnly:true,integerOnly: true},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
				
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:110, editable:true, formatter:cfn_getLotType(1), show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:110, editable:true, formatter:cfn_getLotType(2), show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, editable:true, formatter:cfn_getLotType(3), show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, editable:true, show:cfn_getLotVisible(4),styles:{textAlignment:'center'},formatter:'combo',comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, editable:true, show:cfn_getLotVisible(5),styles:{textAlignment:'center'},formatter:'combo',comboValue:gCodeLOT5},
		
		{name:'REMARK',header:{text:'비고'},width:300, editable:true},
		/* {name:'IFORDERNO',header:{text:'IF구매번호'},width:130,styles:{textAlignment:'center'}},
		{name:'IFORDERSUBNO',header:{text:'IF상세번호'},width:110,styles:{textAlignment:'center'}},
		{name:'IFORDERSEQ',header:{text:'IF순번'},width:80,styles:{textAlignment:'far'}},
		{name:'IFPOQTY',header:{text:'구매서입고요청량'},width:130,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}}, */
			
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},show:false},
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100,show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100,show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100,show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100,show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100,show:cfn_getCompItemVisible(15)}
		
	];
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true});
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		// 셀 수정 이벤트
		gridView.onEditChange = function(grid, column, value) {
			if (column.column === 'WIQTY') {

				var inboxqty = $('#' + gid).gfn_getValue(column.dataRow, 'INBOXQTY');
				var unittype = $('#' + gid).gfn_getValue(column.dataRow, 'UNITTYPE');
				if (inboxqty <= 0) {
					$('#' + gid).gfn_setValue(column.dataRow, 'WIQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'WIQTY_EA', 0);
					
					cfn_msg('ERROR', '품목의 박스입수량이 잘못되었습니다.');
					return false;
				}

				if (unittype == 'BOXEA') {
					$('#' + gid).gfn_setValue(column.dataRow, 'WIQTY_BOX', parseInt(value / inboxqty)); 
					$('#' + gid).gfn_setValue(column.dataRow, 'WIQTY_EA', parseInt(value % inboxqty));	
				} else if (unittype == 'EA'){
					$('#' + gid).gfn_setValue(column.dataRow, 'WIQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'WIQTY_EA', value);	
					}
			}
		};
		dataProvider.onDataChanged = function (provider) {
			var rowidx = $('#' + gid).gfn_getCurRowIdx();
			var gridData = $('#' + gid).gfn_getDataRow(rowidx);
			
			var lot1 = $('#' + gid).gfn_getValue(rowidx, 'LOT1');
			var inputDate = new Date(lot1.substr(0,4), parseInt(lot1.substr(4,2))-1, lot1.substr(6,2));
			var todayDate = new Date();
			
			if (inputDate > todayDate) {
				cfn_msg('ERROR', '제조일자는 현재일 이후의 날짜로는 \n입력할 수 없습니다.');
				$('#' + gid).gfn_setValue(rowidx, 'LOT1', ''); 
				return false;
			
		};
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#WHINLOCCD').val('');
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_focusPK();
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//저장
	if (sid == 'sid_setSave') {
		var resultData = data.resultData
		$('#grid1').gfn_setFocusPK(resultData, ['WIKEY']);
		
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//실행
	if (sid == 'sid_setExecute') {
		var resultData = data.resultData
		$('#grid1').gfn_setFocusPK(resultData, ['WIKEY']);
		
		cfn_msg('INFO', '입고실적처리가 되었습니다.');
		fn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	fn_retrieve();	
}

//검색 처리
function fn_retrieve() {
	//검색조건 필수입력 체크
	if(cfn_isFormRequireData('frmSearch') == false) return; 
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100325/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p100/p100325/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

//입고로케이션검색
function fn_getWiLoccd(param) {
	var url = '/alexcloud/p100/p100325/getWiLoccd.do';
	var sendData = {'paramData':param};
	
	gfn_ajax(url, false, sendData, function (data, xhr) {
		var resultData = data.resultData
		whinloccd = resultData.WHINLOCCD;
	});
	
	$('#WHINLOCCD').val(whinloccd);
}


/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {
	$('#grid1').gridView().commit();
	$('#grid2').gridView().commit();
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
		
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (masterData.WISTS !== '100') {
		cfn_msg('WARNING', '예정 상태일 때만 저장할 수 있습니다.');
		return false;
	}
	
	var detailData = $('#grid2').gfn_getDataList(); 
	
	if (detailData.length < 1) {
		cfn_msg('WARNING', '품목이 없습니다.');
		return false;
	}
	
	//디테일 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;
	
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}

	var detailData = $('#grid2').gfn_getDataList();
	
	if (flg) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p100/p100325/setSave.do';
		var sendData = {'paramData':masterData,'paramList':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

/* 공통버튼 - 실행 클릭(실적처리) */
function cfn_execute() {
	
	var checkRows = $('#grid1').gridView().getCheckedRows();
	var gridData = $('#grid1').gfn_getDataRows(checkRows);
	var list = [];
	
	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}

	for (var i=0, len=checkRows.length; i<len; i++) {
		if (gridData[i].WISTS != '100') {
			cfn_msg('WARNING', '예정 상태일 때만 처리할 수 있습니다. 입고번호[' + gridData[i].WIKEY + ']');
			return false;
		}
		list.push(gridData[i]);
	}
	
	var whinloccd = $('#WHINLOCCD').val();
	if(cfn_isEmpty(whinloccd)) {
		cfn_msg('WARNING', '창고에 입고로케이션이 없습니다.');
		return false;
	}
	
	var detailData = $('#grid2').gfn_getDataList(); 
	
	if (detailData.length < 1) {
		cfn_msg('WARNING', '품목이 없습니다.');
		return false;
	}
	
	//디테일 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;
	
	pfn_popupOpen({
		url: '/alexcloud/p100/p100325/popupView.do',
		pid: 'P100325_popup',
		returnFn: function(data, type) {
			if (type === 'OK') {
				if (confirm('입고지시/실적처리를 하시겠습니까?')) {
					
					var sid = 'sid_setExecute';
					var url = '/alexcloud/p100/p100325/setExecute.do';
					var sendData = {'paramData':data, 'paramList':list, 'paramList2':detailData};
				
					gfn_sendData(sid, url, sendData);
					
				}
			}
		}
	});	
}
</script>

<c:import url="/comm/contentBottom.do" />