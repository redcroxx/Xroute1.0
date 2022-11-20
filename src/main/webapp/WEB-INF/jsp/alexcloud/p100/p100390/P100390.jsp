<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100390
	화면명    : 입고 적치실적 - RealGrid 마스터 디테일 그리드 2개 패턴
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<ul class="sech_ul">
		<li class="sech_li">
			<div>적치일자</div>
			<div>
				<input type="text" id="S_IMDT_FROM" class="cmc_date periods" /> ~
				<input type="text" id="S_IMDT_TO" class="cmc_date periode" />
			</div>
		</li>
		<li class="sech_li">
			<div>상태</div>
			<div>	
				<select id="S_IMSTS" name="S_IMSTS" class="cmc_combo" >
					<option value="NOT99">전체</option>
						<option value="100" selected >예정/실적중</option>
						<option value="200">확정</option>
						<option value="99">취소</option>
					<option value="">전체(취소포함)</option>
				</select>			
			</div>
		</li>
		<li class="sech_li">
			<div>적치번호</div>
			<div>				
				<input type="text" id="S_IMKEY" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<li class="sech_li required">
			<div>창고</div>
			<div>
				<input type="text" id="S_WHCD" class="cmc_code required" />
				<input type="text" id="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
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
		<div class="grid_top_left">적치 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- 그리드 시작 -->
<div class="ct_bot_wrap">
	<div class="ct_left_wrap fix" style="width: 70%;">
		<div class="grid_top_wrap">
			<div class="grid_top_left">적치 상세리스트<span>(총 0건)</span></div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid2"></div>
	</div>
	<div class="ct_right_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">부분실적</div>
			<div class="grid_top_right">
				<input type="button" id="btn_executeDiv" class="cmb_normal" value="부분실적" onclick="fn_executeDiv()" />		
				<input type="button" id="btn_detailAdd" class="cmb_plus" onclick="fn_detailAdd();"/>
				<input type="button" id="btn_detailDel" class="cmb_minus" onclick="fn_detailDel();" />
			</div>
		</div>
		<div id="grid3"></div>
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
	
	setCommBtn('execute', null, '일괄확정');
	setCommBtn('del', null, '취소');
	
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
	grid3_Load();

	/* 공통코드 코드/명 (셀러) */
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
		{name:'IMKEY',header:{text:'적치번호'},width:150,styles:{textAlignment:'center'}},
		{name:'IMDT',header:{text:'적치일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'IMSTS',header:{text:'상태'},width:100,formatter:'combo',comboValue:'${gCodeIMSTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'value = 150',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 200',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}
			]
		},
		{name:'AFTERWHCD',header:{text:'창고코드'},width:110,styles:{textAlignment:'center'}},
		{name:'WHNM',header:{text:'창고명'},width:110,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ORGNM',header:{text:'셀러명'},width:100,styles:{textAlignment:'center'}},
		{name:'REMARK',header:{text:'비고'},width:300},
	 	{name:'PROGRESS_QTY',header:{text:'실적현황'},width:100,formatter:'progressbar',dataType:'number',
			dynamicStyles:[
				{criteria:'value >= 0',styles:{figureBackground:cfn_getStsColor(4)}},
				{criteria:'value >= 50',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value >= 100',styles:{figureBackground:cfn_getStsColor(3)}} 
			]
		},
		{name:'ITEMCNT',header:{text:'품목수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'IMSSCHQTY',header:{text:'총 지시수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMQTY',header:{text:'총 실적수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
				
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,visible:false,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,visible:false,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var imkey = $('#' + gid).gfn_getValue(newRowIdx, 'IMKEY');
				
				if(!cfn_isEmpty(imkey)) {
					var param = {'IMKEY':imkey};
					fn_getDetailList(param);
				}
			}
		};
		
	});
}

function grid2_Load() {
	var gid = 'grid2';
	
	var columns = [
		{name:'IMKEY',header:{text:'적치번호'},width:150,styles:{textAlignment:'center'}},
		{name:'SEQ',header:{text:'SEQ'},width:60,styles:{textAlignment:'far'}},
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:250},
		{name:'IMDSTS',header:{text:'상태'},width:100,formatter:'combo',comboValue:'${gCodeIMDSTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'value = 200',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}			
			]		
		},
		{name:'AFTERLOCCD',header:{text:'지시로케이션'},width:110,styles:{textAlignment:'center'}},
		{name:'IMSCHQTY',header:{text:'적치지시수량'},width:110,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMQTY',header:{text:'실적수량'},dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11,type:"number",positiveOnly:true,integerOnly:true},minVal:1,
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'LOTKEY',header:{text:'로트번호'},width:100,styles:{textAlignment:'center'}},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1),show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2),show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3),show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		{name:'REMARK',header:{text:'비고'},width:300},
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
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'WHCD',header:{text:'창고코드'},width:100,visible:false,show:false},
		{name:'WHNM',header:{text:'창고명'},width:100,visible:false,show:false},
		
	];
		
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns);
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			if (oldIndex.dataRow !== -1 && oldIndex.dataRow !== newIndex.dataRow) {
				var grid2Data = $('#grid3').gfn_getDataList(false);
				var state = dataProvider.getRowState(oldIndex.dataRow);
				
				if (state === 'updated' || state === 'created' || grid2Data.length > 0) {
					if (confirm('해당 품목의 부분실적 내용이 있습니다.\n부분실적처리 하시겠습니까?')) {
						fn_executeDiv('Y');
					}
					return false;
				}
			} 
		};
	});
	
}

function grid3_Load() {
	var gid = 'grid3';
	
	var columns = [
		{name:'AFTERLOCCD',header:{text:'실적로케이션'},formatter:'popup',width:110,required:true, editable:true,styles:{textAlignment:'center'},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
						 inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'WHNM',S_LOCCD:'AFTERLOCCD'},
						 outparam:{LOCCD:'AFTERLOCCD'}
						 }
		},
		{name:'IMQTY',header:{text:'적치수량'},required:true,editable:true,dataType:'number',minVal:1,styles:{textAlignment:'far',numberFormat:'#,##0'},
			editor:{maxLength:11,type:'number',positiveOnly:true,integerOnly: true},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'WHCD',header:{text:'창고코드'},width:100,visible:false,show:false},
		{name:'WHNM',header:{text:'창고명'},width:100,visible:false,show:false},
	];
		
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true});
	
	
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').dataProvider().clearRows();
		$('#grid3').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
		$('#grid3').dataProvider().clearRows();
	}
	//저장
	if(sid == 'sid_setSave') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['IMKEY']);
		cfn_msg('INFO', '정상적으로  저장되었습니다.');
		cfn_retrieve();
	}
	//확정
	if(sid == 'sid_setExecute') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['IMKEY']);
		cfn_msg('INFO', '정상적으로 확정되었습니다.');
		cfn_retrieve();
	}
	//부분실적
	if(sid == 'sid_setExecute2') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['IMKEY']);
		cfn_msg('INFO', '정상적으로 처리되었습니다.');
		cfn_retrieve();
	}
	//취소
	if(sid == 'sid_setDelete') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['IMKEY']);
		cfn_msg('INFO', '정상적으로 취소되었습니다.');
		cfn_retrieve();
	}
	
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('#grid3').gridView().cancel();

	//검색조건 필수입력 체크
	if(cfn_isFormRequireData('frmSearch') == false) return; 
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100390/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p100/p100390/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 확정 클릭 */
function cfn_execute() {
	$('#grid3').gridView().commit(true);
	
	var checkRows = $('#grid1').gridView().getCheckedRows();
	
	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}	
	
	var masterData = $('#grid1').gfn_getDataRows(checkRows);
	var exeData = [];
	
	for (var i=0; i<checkRows.length; i++) {
		if (masterData[i].IMSTS == '200' && masterData[i].IMSTS == '99' ) {
			cfn_msg('WARNING', '예정 혹은 실적중 상태일 때만 확정할 수 있습니다. \n적치번호: [' + masterData[i].IMKEY + ']');
			return;
		}
		exeData.push(masterData[i]);
	}
	if (confirm('확정 하시겠습니까?')) {
		var sid = 'sid_setExecute';
		var url = '/alexcloud/p100/p100390/setExecute.do';
		var sendData = {'paramList':exeData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//부분실적
function fn_executeDiv(directmsg) {
	$('#grid3').gridView().commit(true);

	var checkRows =  $('#grid2').gfn_getCurRowIdx();
	
	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택된 품목이 없습니다.');
		return false;
	}	
	
	var masterData = $('#grid2').gfn_getDataRow(checkRows);

	for (var i=0; i<checkRows.length; i++) {
		if(masterData[i].IMDSTS != '100') {
			cfn_msg('WARNING', '예정상태일 때만 처리할 수 있습니다.\n 품목코드 : [' + masterData[i].ITEMCD + ']');
			return;
		}
	}
	
	var detailData = $('#grid3').gfn_getDataList();
	if (detailData.length < 1) {
		cfn_msg('WARNING', '부분실적 리스트가 없습니다.');
		return false;
	}
	
	//IMSCHQTY
	//디테일 필수입력 체크
	if ($('#grid3').gfn_checkValidateCells()) return false;
	
	var grid3_sum = 0;
	for (var i = 0; i < detailData.length; i++) {
		grid3_sum += detailData[i].IMQTY;
	}
		
	if (masterData.IMSCHQTY < grid3_sum) {
		cfn_msg('WARNING', '적치수량이 적치가능수량보다 많습니다.');
		return;
	}
	
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('부분실적 하시겠습니까?');
	}

	if (flg) {
		var sid = 'sid_setExecute2';
		var url = '/alexcloud/p100/p100390/setExecuteDiv.do';
		var sendData = {'mGridList':masterData,'dGridList':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//디테일 그리드 추가 버튼 이벤트
function fn_detailAdd() {
	var rowidx1 = $('#grid2').gfn_getCurRowIdx();
	var masterData = $('#grid2').gfn_getDataRow(rowidx1);
	
	if (rowidx1 < 0) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	if (masterData.IMDSTS != '100') {
		cfn_msg('WARNING','품목이 예정상태에서만 추가 가능합니다.');
		return false;
	}
	
	var rowidx2 = $('#grid1').gfn_getCurRowIdx();
	var grid1Data = $('#grid1').gfn_getDataRow(rowidx2);
	
	if (grid1Data.IMSTS == '99') {
		cfn_msg('WARNING','취소전표에서는 추가할 수 없습니다.');
		return false;
	}
	
	$('#grid3').gfn_addRow({
		COMPCD:grid1Data.COMPCD
		, WHCD:grid1Data.AFTERWHCD
		, WHNM:grid1Data.WHNM
	});
}

//디테일 그리드 삭제 버튼 이벤트
function fn_detailDel() {
	var rowidx1 = $('#grid2').gfn_getCurRowIdx();	
	var masterData = $('#grid2').gfn_getDataRow(rowidx1);
	
	if (rowidx1 < 0) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	if (masterData.IMDSTS != '100') {
		cfn_msg('WARNING','품목이 예정전표에서만 삭제 가능합니다.');
		return false;
	}
	
	var rowidx2 = $('#grid1').gfn_getCurRowIdx();
	var grid1Data = $('#grid1').gfn_getDataRow(rowidx2);
	
	if (grid1Data.IMSTS == '99') {
		cfn_msg('WARNING','취소전표에서는 삭제할 수 없습니다.');
		return false;
	}
	
	
	var rowidx2 = $('#grid3').gfn_getCurRowIdx();
	
	if (rowidx2 < 0) {
		cfn_msg('WARNING', '선택된 항목이 없습니다.');
		return false;
	}
	var state = $('#grid3').dataProvider().getRowState(rowidx2);
	
	$('#grid3').gfn_delRow(rowidx2);
	
} 

//공통버튼 - 취소 클릭
function cfn_del() {
	$('#grid3').gridView().commit();
		
	var checkRows = $('#grid1').gridView().getCheckedRows();
	
	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}	
	
	var masterData = $('#grid1').gfn_getDataRows(checkRows);
	var exeData = [];
	
	for (var i=0; i<checkRows.length; i++) {
		if (masterData[i].IMSTS != '100') {
			cfn_msg('WARNING', '예정 상태일 때만 취소할 수 있습니다. 적치번호: [' + masterData[i].IMKEY + ']');
			return;
		}
		
		exeData.push(masterData[i]);
	}
	if (confirm('취소 하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p100/p100390/setDelete.do';
		var sendData = {'paramList':exeData};
		
		gfn_sendData(sid, url, sendData);
	}
	
}
</script>

<c:import url="/comm/contentBottom.do" />