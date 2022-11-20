<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P700210
	화면명    : 로케이션이동확정 - RealGrid 마스터 디테일 그리드 2개 패턴
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="C_CHKWHCD" class="cmc_code" />
	<ul class="sech_ul">
		<li class="sech_li">
			<div>이동일자</div>
			<div>
				<input type="text" id="S_IMDT_FROM" class="cmc_date periods" /> ~
				<input type="text" id="S_IMDT_TO" class="cmc_date periode" />
			</div>
		</li>
		<li class="sech_li">
			<div>이동상태</div>
			<div>
				<select id="S_IMSTS" class="cmc_combo">
					<option value="NOT99">전체</option>
					<c:forEach var="i" items="${codeIMSTS}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
		<li class="sech_li">
			<div>이동번호</div>
			<div>				
				<input type="text" id="S_SEARCH" class="cmc_txt" />
			</div>
		</li>
	</ul>
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
			<div>로케이션그룹</div>
			<div>
				<select id="S_LOCGROUP" class="cmc_combo">
					<option value="">전체</option>
					<c:forEach var="i" items="${codeLOCGROUP}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
		<li class="sech_li">
			<div>품목코드/명</div>
			<div>		
				<input type="text" id="S_ITEM" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<li class="sech_li">
			<div>로케이션</div>
			<div>
				<input type="text" id="S_BEFORELOCCD" class="cmc_code" />
			</div>
		</li>
		<li class="sech_li">
			<div>이동로케이션</div>
			<div>
				<input type="text" id="S_AFTERLOCCD" class="cmc_code" />
			</div>
		</li>
	</ul>
	<div id="sech_extbtn" class="down"></div>
	<div id="sech_extline"></div>
	<div id="sech_extwrap">
		<ul class="sech_ul">
			<li class="sech_li">
				<div>화주</div>
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
		<div class="grid_top_left">로케이션이동 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- 그리드 시작 -->
<div class="ct_bot_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">로케이션이동 상세리스트<span>(총 0건)</span></div>
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
	
	setCommBtn('execute', null, '확정');
	
	$('#S_IMDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_IMDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_IMSTS').val('100');
	
	//로그인 정보로 세팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_WHCD').val(cfn_loginInfo().WHCD);
	$('#S_WHNM').val(cfn_loginInfo().WHNM);
	
	grid1_Load();
	grid2_Load();

	/* 공통코드 코드/명 (화주) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});

	/* 공통코드 코드/명 (창고) */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_WHCD:'S_WHCD,S_WHNM',S_COMPCD:'S_COMPCD'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	
	
	/* 공통코드 코드/명 (이동전로케이션) 
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'S_BEFORELOCCD',
		inparam:{S_LOCCD:'S_BEFORELOCCD',S_WHCD:'S_WHCD'},
		outparam:{LOCCD:'S_BEFORELOCCD'},
		beforeFn: function() { 
			if(cfn_isEmpty($('#S_WHCD').val())) {
				cfn_msg('WARNING', '창고를 선택하세요.');
				return false;
			}
		}
	});*/
	
	/* 공통코드 코드/명 (이동후로케이션) 
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'S_AFTERLOCCD',
		inparam:{S_LOCCD:'S_AFTERLOCCD',S_WHCD:'S_WHCD'},
		outparam:{LOCCD:'S_AFTERLOCCD'},
		beforeFn: function() { 
			if(cfn_isEmpty($('#S_WHCD').val())) {
				cfn_msg('WARNING', '창고를 선택하세요.');
				return false;
			}
		}
	});*/
	
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
		{name:'IMKEY',header:{text:'이동번호'},width:150,styles:{textAlignment:'center'}},
		{name:'IMDT',header:{text:'이동일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'IMSTS',header:{text:'상태'},width:100,formatter:'combo',comboValue:'${gCodeIMSTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'value = 200',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}			
			]		
		},
		{name:'WHCD',header:{text:'창고코드'},width:110,styles:{textAlignment:'center'}},
		{name:'WHNM',header:{text:'창고명'},width:110,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'화주코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ORGNM',header:{text:'화주명'},width:100,styles:{textAlignment:'center'}},
		{name:'REMARK',header:{text:'비고'},width:300},
		{name:'PRINTBTN',header:{text:'출력'},width:35,formatter:'btnsearch'},
		{name:'ITEMCNT',header:{text:'품목수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'TOTQTY',header:{text:'총수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMWHCD',header:{text:'이동중창고코드'},width:110,styles:{textAlignment:'center'}},
		{name:'IMWHNM',header:{text:'이동중창고명'},width:110,styles:{textAlignment:'center'}},
		{name:'CFMUSERCD',header:{text:'확정자'},width:100,styles:{textAlignment:'center'}},
		{name:'CFMUSERNM',header:{text:'확정자명'},width:100,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true, checkBar:true});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			
			if (oldIndex.dataRow !== -1 && oldIndex.dataRow !== newIndex.dataRow) {
				var grid2Data = $('#grid2').gfn_getDataList(false);
				var state = dataProvider.getRowState(oldIndex.dataRow);
				
				if (state === 'updated' || grid2Data.length > 0) {
					if (confirm('변경된 내용이 있습니다. 저장하시겠습니까?')) {
						cfn_save('Y');
					}
					return false;
				}
			} 
		};
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				//상태가 예정이 아닐 때 해당 Row 컬럼 모두 disabled 처리
				var editable = $('#' + gid).gfn_getValue(newRowIdx, 'IMSTS') === '100';
				
				$('#grid2').gfn_setColDisabled(['ORGCD','WHCD','IMQTY','AFTERLOCCD','REMARK'], editable);
				
				if(!cfn_isEmpty(cfn_loginInfo().WHCD)){
					$('#' + gid).gfn_setColDisabled(['WHCD'], false);
				} 
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#' + gid).gfn_setColDisabled(['ORGCD'], false);
				}
			}
			
			var imkey = $('#' + gid).gfn_getValue(newRowIdx, 'IMKEY');
			
			if(!cfn_isEmpty(imkey)) {
				var param = {'IMKEY':imkey};
				fn_getDetailList(param);
			}
		};
		
		//셀 클릭 이벤트
		gridView.onDataCellClicked = function(gridview, column) {
			if (column.column === 'PRINTBTN') {
				var rowidx = $('#' + gid).gfn_getCurRowIdx();
				var imkey = $('#' + gid).gfn_getValue(rowidx, 'IMKEY');
				
				rfn_getReport(imkey);
			}
		};
	});
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품명'},width:250},
		{name:'ITEMSIZE',header:{text:'규격'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},styles:{textAlignment:'center'}},
		{name:'BEFORELOCCD',header:{text:'로케이션'},formatter:'popup',width:110,styles:{textAlignment:'center'}},
		{name:'AFTERLOCCD',header:{text:'이동로케이션'},width:110,styles:{textAlignment:'center'}},
		{name:'BEFAVAILQTY',header:{text:'이동가능수량'},dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMSCHQTY_BOX',header:{text:'지시[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMSCHQTY_EA',header:{text:'지시[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMSCHQTY',header:{text:'이동지시수량'},width:110,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},			
		{name:'IMQTY_BOX',header:{text:'이동[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMQTY_EA',header:{text:'이동[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMQTY',header:{text:'이동수량'},required:true,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11,type:"number",positiveOnly:true,integerOnly:true},minVal:1,
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		/*이동후로케이션 팝업 재고를 포함한 것 따로 만들어야....
		{name:'AFTAVAILQTY',header:{text:'이동후가용수량'},dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},*/
		{name:'REMARK',header:{text:'비고'},width:200,editable:true,editor:{maxLength:200}},
		{name:'LOTKEY',header:{text:'로트번호'},width:100,styles:{textAlignment:'center'}},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1),show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2),show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3),show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
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
		{name:'IMLOCCD',header:{text:'이동중로케이션'},width:110,styles:{textAlignment:'center'}},
		{name:'IMKEY',header:{text:'이동번호'},width:150,styles:{textAlignment:'center'}},
		{name:'SEQ',header:{text:'순번'},width:60,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,show:false},
		{name:'WHCD',header:{text:'창고코드'},width:110,show:false},
		{name:'WHNM',header:{text:'창고명'},width:110,show:false},
		{name:'ORGCD',header:{text:'화주코드'},width:100,show:false},
		{name:'ORGNM',header:{text:'화주명'},width:100,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,show:false},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true,mstGrid:'grid1'});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		 //셀 수정 이벤트
		gridView.onEditChange = function(grid, column, value) {
			if (column.column === 'IMQTY') {
				var INBOXQTY = $('#' + gid).gfn_getValue(column.dataRow, 'INBOXQTY'); //BOX입수량
				var UNITTYPE = $('#' + gid).gfn_getValue(column.dataRow, 'UNITTYPE'); //관리단위
				
				if (INBOXQTY <= 0){
					$('#' + gid).gfn_setValue(column.dataRow, 'IMQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'IMQTY_EA', 0);
					cfn_msg('ERROR', '품목의 박스입수량이 잘못되었습니다.');
					return false;
				}
				if (UNITTYPE == 'BOXEA') {
					$('#' + gid).gfn_setValue(column.dataRow, 'IMQTY_BOX', parseInt(value / INBOXQTY)); 
					$('#' + gid).gfn_setValue(column.dataRow, 'IMQTY_EA', parseInt(value % INBOXQTY));	
				} else if (UNITTYPE == 'EA') {
					$('#' + gid).gfn_setValue(column.dataRow, 'IMQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'IMQTY_EA', value);	
				}
			}
		};
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//저장
	if (sid == 'sid_setSave') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['IMKEY']);
		cfn_msg('INFO', '정상적으로  저장되었습니다.');
		cfn_retrieve();
	}
	//확정
	if (sid == 'sid_setExecute') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['IMKEY']);
		cfn_msg('INFO', '정상적으로 확정되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('#grid1').gridView().cancel();
	$('#grid2').gridView().cancel();
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p700/p700210/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p700/p700210/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}


/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	
	//마스터 필수입력 체크
	if ($('#grid1').gfn_checkValidateCells([rowidx])) return false;
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (masterData.IMSTS !== '100') {
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
	
	for (var i = 0; i < detailData.length; i++) { 
		if (detailData[i].BEFAVAILQTY < detailData[i].IMQTY) {
			cfn_msg('WARNING', '이동수량이 이동가능수량보다 많습니다.');
			$('#grid2').gfn_setFocusPK(detailData[i], ['COMPCD','ORGCD','ITEMCD','IMQTY']);
			$('#grid2').gfn_focusPK();
			return;
		}
	}
	
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}

	if (flg) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p700/p700210/setSave.do';
		var sendData = {'mGridData':masterData,'dGridData':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

/* 공통버튼 - 확정 클릭 */
function cfn_execute() {
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);
	
	var checkRows = $('#grid1').gridView().getCheckedRows();
	
	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}	
	
	var masterData = $('#grid1').gfn_getDataRows(checkRows);

	for (var i=0; i<checkRows.length; i++) {
		if (masterData[i].IMSTS != '100') {
			cfn_msg('WARNING', '예정상태일 때만 확정할 수 있습니다. 이동번호: [' + masterData[i].IMKEY + ']');
			return;
		}
	}
	
	var detailData = $('#grid2').gfn_getDataList();
	
	//디테일 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;
	
	for (var i = 0; i < detailData.length; i++) { 
		if (detailData[i].BEFAVAILQTY < detailData[i].IMQTY) {
			cfn_msg('WARNING', '이동수량이 이동가능수량보다 많습니다.');
			$('#grid2').gfn_setFocusPK(detailData[i], ['COMPCD','ORGCD','ITEMCD','IMQTY']);
			$('#grid2').gfn_focusPK();
			return;
		}
	}
	
	if (confirm('확정 하시겠습니까?')) {
		var sid = 'sid_setExecute';
		var url = '/alexcloud/p700/p700210/setExecute.do';
		var sendData = {'mGridList':masterData,'dGridList':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//로케이션간 이동 지시서 출력
function rfn_getReport(imkey) {
	pfn_popupOpen({
		url: '/alexcloud/p700/p700200/popReportView.do',
		pid: 'P700200_reportPop',
		returnFn: function(data, type) {
			var order;
			if (type === 'OK') {//리포트 띄우기
				if(data.P700200_R === '1') { //빈양식
					imkey = '';
				} else if(data.P700200_R === '2') { //품목순
					order = '2'
				} else if(data.P700200_R === '3') { //이동전로케이션
					order = '3'
				} else if(data.P700200_R === '4') { //이동후로케이션
					order = '4'
				} else if(data.P700200_R === '5') { //수량
					order = '5'
				}
				rfn_reportView({
					title: '로케이션이동지시서',
					jrfName: 'P700200_R01',
					args: {'IMKEY':imkey, 'PRINTUSERNM':cfn_loginInfo().USERNM,'ORDER':order}
				});		
			}
		}
	});	
}

</script>

<c:import url="/comm/contentBottom.do" />