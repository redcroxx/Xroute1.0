<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100300
	화면명    : 입고등록 - RealGrid 마스터 디테일 그리드 2개 패턴
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	
	<ul class="sech_ul">
		<li class="sech_li">
			<div>입고일자</div>
			<div>
				<input type="text" id="S_WIDT_FROM" class="cmc_date periods" /> ~
				<input type="text" id="S_WIDT_TO" class="cmc_date periode" />
			</div>
		</li>
		<li class="sech_li">
			<div>입고상태</div>
			<div>
				<select id="S_WISTS" class="cmc_combo">
					<option value="0">전체</option>
					<c:forEach var="i" items="${codeWISTS}">
						<c:if test="${i.code == '100' || i.code == '99'}">
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
		<li class="sech_li">
			<div>입고번호</div>
			<div>
				<input type="text" id="S_WIKEY" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<li class="sech_li">
				<div>셀러</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code" />
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
		<li class="sech_li">
			<div>창고</div>
			<div>
				<input type="text" id="S_WHCD" class="cmc_code" />
				<input type="text" id="S_WHNM" class="cmc_value" />
				<button type="button" id="S_WHCD_BTN" class="cmc_cdsearch"></button>
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
		
	</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
		<input type="button" id="btn_upload" class="cmb_normal" value="업로드" onclick="pfn_upload('P100300');" />
		</div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- 그리드 시작 -->
<div class="ct_bot_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고 상세 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
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
	//1. 화면레이아웃 지정 (리사이징) 
	initLayout();
	
	//2. 화면 공통버튼 설정
	//setCommBtn('del', null, '취소');
	
	//3. 입력폼 초기화
	$('#S_WIDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WIDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WISTS').val('100');
	
	//로그인 정보로 세팅 
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_WHCD').val(cfn_loginInfo().WHCD);
	$('#S_WHNM').val(cfn_loginInfo().WHNM);
	
	if (cfn_loginInfo().USERGROUP == '${SELLER_ADMIN}' || cfn_loginInfo().USERGROUP == '${CENTER_ADMIN}') {
		$('#S_WHCD').val(cfn_loginInfo().WHCD);
		$('#S_WHNM').val(cfn_loginInfo().WHNM);
		$('#S_WHCD').prop("disabled",true);
		$('#S_WHNM').prop("disabled",true);
		$('#S_WHCD_BTN').prop("disabled",true);
		
		$('#sOrgCd').prop("disabled",true);
		$('#sOrgNm').prop("disabled",true);
 	}
	
	//4. 그리드 초기화
	grid1_Load();
	grid2_Load();

	//5. 공통코드/명 팝업 지정
	/* 공통코드 코드/명 (사업장) */
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
		{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		/* {name:'WISCHDT',header:{text:'입고요청일자'},width:120,formatter:'date',styles:{textAlignment:'center'},editable:true,required:true}, */
		{name:'WIDT',header:{text:'입고일자'},width:90,formatter:'date',styles:{textAlignment:'center'}},
		 {name:'WISTS',header:{text:'입고상태'},width:120,formatter:'combo',comboValue:'${gCodeWISTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 400',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}]},   
		{name:'WITYPE',header:{text:'입고유형'},width:100,editable:true,formatter:'combo',comboValue:'${gCodeWITYPE}',styles:{textAlignment:'center'}},
		
		{name:'WHCD',header:{text:'창고코드'},width:100,editable:true,required:true,styles:{textAlignment:'center'},formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP004/view.do',
						 inparam:{S_WHCD:'WHCD',S_COMPCD:'COMPCD',S_WHNM:'WHNM'},
						 outparam:{WHCD:'WHCD',NAME:'WHNM'}}},
		{name:'WHNM',header:{text:'창고명'},width:100,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,editable:true,required:true,styles:{textAlignment:'center'},formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP002/view.do',
				 inparam:{S_ORGCD:'ORGCD',S_COMPCD:'COMPCD'},
				 outparam:{ORGCD:'ORGCD',NAME:'ORGNM'}}}, //셀러변경되면 그에따른 거래처 지워줘야한다.
		{name:'ORGNM',header:{text:'셀러명'},width:100,styles:{textAlignment:'center'}},
		
		{name:'CUSTCD',header:{text:'거래처코드'},width:120,editable:true,required:true,visible:false,show:false,styles:{textAlignment:'center'}},
		{name:'CUSTNM',header:{text:'거래처명'},width:150,visible:false,show:false},
		
		{name:'REMARK',header:{text:'비고'},width:300,editable:true,editor:{maxLength:200}},
		
		{name:'ITEMCNT',header:{text:'품목수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'TOTQTY',header:{text:'총수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'TOTSUPPLYAMT',header:{text:'총입고금액'},width:90,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
					footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
					
		{name:'WISTS',header:{text:'입고상태'},width:100,visible:false,show:false},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,visible:false,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,visible:false,show:false}
		
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			if (oldIndex.dataRow !== -1 && oldIndex.dataRow !== newIndex.dataRow) {
				var grid2Data = $('#grid2').gfn_getDataList(false);
				var state = dataProvider.getRowState(oldIndex.dataRow);
				
				if (state === 'updated' || state === 'created' || grid2Data.length > 0) {
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
				//입고상태가 예정이 아닐 때 해당 Row 컬럼 모두 disabled 처리
				var editable = $('#' + gid).gfn_getValue(newRowIdx, 'WISTS') === '100';
				
				$('#' + gid).gfn_setColDisabled([/* 'WISCHDT',  */'WITYPE', 'WHCD', 'ORGCD', /* 'CUSTCD', */ 'VATFLG', 'USERCD', 'REMARK' /* 'CARNO', */ /* 'DRIVER',  *//* 'DRIVERTEL' */], editable);
				$('#grid2').gfn_setColDisabled(['ITEMCD', 'WISCHQTY', 'UNITPRICE', 'SUPPLYAMT', 'REMARK'], editable);
				
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#' + gid).gfn_setColDisabled(['ORGCD'], false);
				}
				if(!cfn_isEmpty(cfn_loginInfo().WHCD)){
					$('#' + gid).gfn_setColDisabled(['WHCD'], false);
				}
			}
			
			var wikey = $('#' + gid).gfn_getValue(newRowIdx, 'WIKEY');
			
			if(!cfn_isEmpty(wikey)) {
				var param = {'WIKEY':wikey};
				fn_getDetailList(param);
			}
			
		};
		// 셀 클릭 이벤트
		gridView.onDataCellClicked = function(gridView, column) {
	    	var rowidx = $('#'+gid).gfn_getCurRowIdx();
	    }
	    
	});
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'SEQ',header:{text:'입고순번'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'ITEMCD',header:{text:'품목코드'},width:100,required:true,editable:true,styles:{textAlignment:'center'},formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP00602/view.do',
						 inparam:{S_ITEMCD:'ITEMCD',/* S_CUSTCD:'CUSTCD',S_CUSTNM:'CUSTNM', */S_COMPCD:'COMPCD',S_ORGCD:'ORGCD',S_ORGNM:'ORGNM'},
						 outparam:{ITEMCD:'ITEMCD',NAME:'ITEMNM',ITEMSIZE:'ITEMSIZE',UNITCD:'UNITCD',INBOXQTY:'INBOXQTY',UNITTYPE:'UNITTYPE'},
						 returnFn: function(data, type) {
							 var rowidxm = $('#grid1').gfn_getCurRowIdx();
							 var masterData = $('#grid1').gfn_getDataRow(rowidxm);
							 var rowidx = $('#' + gid).gfn_getCurRowIdx();
								for (var i=0; i<data.length; i++) {
									if (i === 0) {
										$('#' + gid).gfn_setValue(rowidx, 'ITEMCD', data[i].ITEMCD);
										$('#' + gid).gfn_setValue(rowidx, 'ITEMNM', data[i].NAME);
										$('#' + gid).gfn_setValue(rowidx, 'ITEMSIZE', data[i].ITEMSIZE);
										$('#' + gid).gfn_setValue(rowidx, 'UNITCD', data[i].UNITCD);
										$('#' + gid).gfn_setValue(rowidx, 'INBOXQTY', data[i].INBOXQTY);
										$('#' + gid).gfn_setValue(rowidx, 'UNITTYPE', data[i].UNITTYPE);
										$('#' + gid).gfn_setValue(rowidx, 'UNITPRICE', data[i].UNITCOST);
										$('#' + gid).gfn_setValue(rowidx, 'COMPCD', masterData.COMPCD);
										$('#' + gid).gfn_setValue(rowidx, 'ORGCD', masterData.ORGCD);
										$('#' + gid).gfn_setValue(rowidx, 'ORGNM', masterData.ORGNM);
										$('#' + gid).gfn_setValue(rowidx, 'WHCD', masterData.WHCD);
									} else {
										$('#' + gid).gfn_addRow({
											ITEMCD: data[i].ITEMCD,
											ITEMNM: data[i].NAME,
											ITEMSIZE: data[i].ITEMSIZE,
											UNITCD: data[i].UNITCD,
											INBOXQTY: data[i].INBOXQTY,
											UNITTYPE: data[i].UNITTYPE,
											UNITPRICE: data[i].UNITCOST,
											COMPCD:masterData.COMPCD,
											ORGCD:masterData.ORGCD,
											ORGNM:masterData.ORGNM,
											WHCD:masterData.WHCD,
										});	
									}
								}
							}
						}
		},
		{name:'ITEMNM',header:{text:'품명'},width:350},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX별 낱개량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'WISCHQTY_BOX',header:{text:'BOX'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY',header:{text:'입고수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'UNITPRICE',header:{text:'단가'},width:100,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11}},
		{name:'SUPPLYAMT',header:{text:'입고금액'},width:100,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11},
					footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'REMARK',header:{text:'비고'},width:300,editable:true,editor:{maxLength:200}},
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,show:false},
		{name:'ORGNM',header:{text:'셀러명'},width:100,show:false},
		{name:'WHCD',header:{text:'창고코드'},width:100,show:false},
		
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true,mstGrid:'grid1'});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		// 셀 수정 이벤트
		gridView.onEditChange = function(grid, column, value) {
			if (column.column === 'UNITPRICE') {
				var WISCHQTY = $('#' + gid).gfn_getValue(column.dataRow, 'WISCHQTY');
				$('#' + gid).gfn_setValue(column.dataRow, 'SUPPLYAMT', WISCHQTY * value);
			}
		};
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				//구매적용이 되면 품목코드, 거래처코드 변경못함(디테일 중 한로우라도 적용되어있으면.)
				var rowidx = $('#grid1').gfn_getCurRowIdx();
				
				var masterData = $('#grid1').gfn_getDataRow(rowidx);
				var detailData = $('#grid2').gfn_getDataList();

				var master_editable = (detailData.length <= 0) && masterData.WISTS === '100';
				$('#grid1').gfn_setColDisabled(['WHCD','ORGCD'/* ,'CUSTCD' */], master_editable);
				
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#grid1').gfn_setColDisabled(['ORGCD'], false);
				}
				if(!cfn_isEmpty(cfn_loginInfo().WHCD)){
					$('#grid1').gfn_setColDisabled(['WHCD'], false);
				}
				
				var itemcd_editable = masterData.WISTS === '100';
				$('#' + gid).gfn_setColDisabled(['ITEMCD'], itemcd_editable);
				
			} else { //품목이 다 지워지면 거래처 코드 edit 가능
				$('#grid1').gfn_setColDisabled(['WHCD','ORGCD'/* ,'CUSTCD' */], true);
			
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#grid1').gfn_setColDisabled(['ORGCD'], false);
				}
				if(!cfn_isEmpty(cfn_loginInfo().WHCD)){
					$('#grid1').gfn_setColDisabled(['WHCD'], false);
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
	//저장
	if(sid == 'sid_setSave') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['WIKEY']);
		
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		
		cfn_retrieve();
	}
	//취소
	if(sid == 'sid_setDelete') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['WIKEY']);
		
		cfn_msg('INFO', '정상적으로 취소되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('#grid1').gridView().cancel();
	$('#grid2').gridView().cancel();
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100300/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {	
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p100/p100300/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 신규 클릭 */
function cfn_new() {
	
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);
	
	var grid2Data = $('#grid2').gfn_getDataList(false);
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx >= 0) {
		var state = $('#grid1').dataProvider().getRowState(rowidx);
		if (state === 'created') {
			cfn_msg('INFO', '신규 입력 상태입니다.');
			return false;
		} else if (state === 'updated' || grid2Data.length > 0) {
			if (confirm('변경된 내용이 있습니다. 저장하시겠습니까?')) {
				cfn_save('Y');
			}
			return false;
		}
	}
	
	$('#grid2').dataProvider().clearRows();
	
	$('#grid1').gfn_addRow({
		WISTS:'100'
		, WITYPE:'STD'
		, VATFLG:'0'
		, COMPCD:cfn_loginInfo().COMPCD
		, COMPNM:cfn_loginInfo().COMPNM
		, CUSTCD:cfn_loginInfo().CUSTCD
		, ORGCD:cfn_loginInfo().ORGCD
		, ORGNM:cfn_loginInfo().ORGNM
		, WHCD:cfn_loginInfo().WHCD
		, WHNM:cfn_loginInfo().WHNM
	});
}

/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	
	//마스터 필수입력 체크
	if ($('#grid1').gfn_checkValidateCells([rowidx])) return false;
	
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

	if (flg) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p100/p100300/setSave.do';
		var sendData = {'mGridData':masterData,'dGridData':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

/* 공통버튼 - 취소 클릭 */
function cfn_del() {
	console.log('1');
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (cfn_isEmpty(masterData.WIKEY)) {
		$('#grid1').gfn_delRow(rowidx);
		$('#grid2').dataProvider().clearRows();
		return false;
	} else if (masterData.WISTS !== '100') {
		cfn_msg('WARNING', '예정 상태 일 때만 취소할 수 있습니다.');
		return false;
	}
	

	var detailData = $('#grid2').gfn_getDataList();
	
	if (detailData.length < 1) {
		cfn_msg('WARNING', '품목이 없습니다.');
		return false;
	}
	
	if (confirm('입고번호[' + masterData.WIKEY + '] 항목을 취소하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p100/p100300/setDelete.do';
		var sendData = {'paramData':masterData,'paramList':detailData};

		gfn_sendData(sid, url, sendData);
	}
}

//디테일 그리드 추가 버튼 이벤트
function btn_detailAdd_onClick() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	if (masterData.WISTS !== '100') {
		cfn_msg('WARNING', '예정전표에서만 추가 가능합니다.');
		return false;
	}
	if (cfn_isEmpty(masterData.ORGCD)) {
		cfn_msg('WARNING', '셀러를 입력해주세요.');
		return false;
	}
	
	$('#grid2').gfn_addRow({
		'COMPCD':masterData.COMPCD
		, 'ORGCD':masterData.ORGCD
		, 'ORGNM':masterData.ORGNM
		, 'WHCD':masterData.WHCD
	});
}

//디테일 그리드 삭제 버튼 이벤트
function btn_detailDel_onClick() {
	var rowidx = $('#grid2').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow($('#grid1').gfn_getCurRowIdx());
	if (masterData.WISTS !== '100') {
		cfn_msg('WARNING', '예정전표에서만 삭제 가능합니다.');
		return false;
	}
	
	$('#grid2').gfn_delRow(rowidx);
}
</script>

<c:import url="/comm/contentBottom.do" />