<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100370
	화면명    : 단순입고 - RealGrid 마스터 디테일 그리드 2개, 탭 패턴
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
				<input type="text" id="S_WISCHDT_FROM" class="cmc_date periods"/> ~
				<input type="text" id="S_WISCHDT_TO" class="cmc_date periode"/>
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
			<div>입고일자</div>
			<div>
				<input type="text" id="S_WIDT_FROM" class="cmc_date periods"/> ~
				<input type="text" id="S_WIDT_TO" class="cmc_date periode"/>
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
			<div>입고번호</div>
			<div>				
				<input type="text" id="S_WIKEY" class="cmc_txt" />
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

<!-- 마스터 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고 리스트 <span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>	
</div>
<!-- 마스터 그리드 끝 -->

<!-- 디테일 그리드 시작 -->
<div class="ct_bot_wrap">
	<div id="tab1" class="ct_tab">
		<ul>
			<li id="tab1Click"><a href="#tab1Cont">등록</a></li>
			<li id="tab2Click"><a href="#tab2Cont">실적</a></li>
		</ul>
		<div id="tab1Cont">
			<div class="grid_top_wrap">
				<div class="grid_top_left">입고 상세 등록 리스트 <span>(총 0건)</span></div>
				<div class="grid_top_right">
					<input type="text" id="A_LOCCD" class="cmc_code" />
					<input type="hidden" id="A_LOCCD_R" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
					<input type="button" id="btn_applyLoc" class="cmb_normal" value="일괄적용" onclick="fn_btn_applyLoc();" />					
					<input type="button" id="btn_detailAdd" class="cmb_plus" onclick="fn_btn_detailAdd();"/>
					<input type="button" id="btn_detailDel" class="cmb_minus" onclick="fn_btn_detailDel();"/>
				</div>
			</div>
			<div id="grid2"></div>
		</div>
		<div id="tab2Cont">
			<div class="grid_top_wrap">
				<div class="grid_top_left">입고 상세 실적 리스트 <span>(총 0건)</span></div>
				<div class="grid_top_right">
					<!-- <input type="button" id="btn_applyWDLoc" class="cmb_normal" value="지시->실적 적용" onclick="fn_btn_applyWDLoc();" /> -->
				</div>
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
	
	setCommBtn('del', null, '취소');
	setCommBtn('execute', null, '확정');
	
	$('#S_WISCHDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WISCHDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WISTS2').val('100');
	
	//로그인 정보로 세팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_WHCD').val(cfn_loginInfo().WHCD);
	$('#S_WHNM').val(cfn_loginInfo().WHNM);
	
	grid1_Load();
	grid2_Load();
	grid3_Load();
	
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
	
	/* 공통코드 코드/명 (거래처) */
	/* pfn_codeval({
		url:'/alexcloud/popup/popP003/view.do',codeid:'S_CUSTCD',
		inparam:{S_CUSTCD:'S_CUSTCD,S_CUSTNM',S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD',S_ORGNM:'S_ORGNM'},
		outparam:{CUSTCD:'S_CUSTCD',NAME:'S_CUSTNM'},
		params:{CODEKEY:'ISSUPPLIER'}
	}); */
	
	/* 공통코드 코드/명 (일괄적용 로케이션) */
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'A_LOCCD',
		inparam:{S_LOCCD:'A_LOCCD,A_LOCCD_R',S_WHCD:'C_CHKWHCD',S_WHNM:'C_CHKWHNM'},
		outparam:{LOCCD:'A_LOCCD,A_LOCCD_R'},
		beforeFn: function() { 
			var c_chkwhcd = $('#C_CHKWHCD').val();
			//전체 행의 개수
			var endidx = $('#grid2').dataProvider().getRowCount();
			
			if (endidx < 1) {
				cfn_msg('WARNING', '품목을 추가하세요.');
				return false;
			}
			
			if (cfn_isEmpty($('#C_CHKWHCD').val())) {
				cfn_msg('WARNING', '창고를 선택하세요.');
				return false;
			}
		}
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
		{name:'WIKEY',header:{text:'입고번호'},width:120},
		{name:'WISCHDT',header:{text:'입고요청일자'},width:120,formatter:'date',styles:{textAlignment:'center'},editable:true,required:true},
		{name:'WIDT',header:{text:'입고일자'},width:90,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WISTS',header:{text:'입고상태'},width:120,formatter:'combo',comboValue:'${gCodeWISTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 400',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}]},   
		{name:'WITYPE',header:{text:'입고유형'},width:100,editable:true,formatter:'combo',comboValue:'${gCodeWITYPE}',styles:{textAlignment:'center'}},
		{name:'WHCD',header:{text:'창고코드'},width:100,editable:true,required:true,formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP004/view.do',
						 inparam:{S_WHCD:'WHCD',S_COMPCD:'COMPCD',S_WHNM:'WHNM'},
						 outparam:{WHCD:'WHCD',NAME:'WHNM'}}},
		{name:'WHNM',header:{text:'창고명'},width:80},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,editable:true,required:true,formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP002/view.do',
				 inparam:{S_ORGCD:'ORGCD',S_COMPCD:'COMPCD'},
				 outparam:{ORGCD:'ORGCD',NAME:'ORGNM'},
				 /* returnFn: function(data, type) {
					 if(data.length > 0) {
						 var rowidx = $('#' + gid).gfn_getCurRowIdx();
						 $('#' + gid).gfn_setValue(rowidx, 'CUSTCD', ''); 
						 $('#' + gid).gfn_setValue(rowidx, 'CUSTNM', '');}} */}},//셀러변경되면 그에따른 거래처 지워줘야한다. 
		{name:'ORGNM',header:{text:'셀러명'},width:100},
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:100,editable:true,required:true,formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP003/view.do',
						 inparam:{S_CUSTCD:'CUSTCD',S_COMPCD:'COMPCD',S_ORGCD:'ORGCD',S_ORGNM:'ORGNM'},
						 outparam:{CUSTCD:'CUSTCD',NAME:'CUSTNM'},
						 params:{CODEKEY:'ISSUPPLIER'},
						 returnFn: function(data, type) {
							 if(data.length > 0) {
								 var maxRowid = $('#grid2').dataProvider().getRowCount();
								 if(data.length > 0 && maxRowid >= 0) {
									for(var i=0; i<maxRowid; i++){
										var grid2rowidx = $('#grid2').gridView().getDataRow(i);
										$('#grid2').gfn_setValue(grid2rowidx, 'CUSTCD', data[0].CUSTCD);
									}
								 }
							 }
						 }
			}
		},
		{name:'CUSTNM',header:{text:'거래처명'},width:150}, */
		{name:'REMARK',header:{text:'비고'},width:300,editable:true,editor:{maxLength:200}},
		{name:'PRINTBTN',header:{text:'출력'},width:35,formatter:'btnsearch'},	
		{name:'ITEMCNT',header:{text:'품목수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'TOTQTY',header:{text:'총수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'TOTSUPPLYAMT',header:{text:'총입고금액'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
					footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'CARNO',header:{text:'입고차량번호'},width:100,editable:true,editor:{maxLength:20}},
		{name:'DRIVER',header:{text:'차량운전자'},width:100,editable:true,editor:{maxLength:20}},
		{name:'DRIVERTEL',header:{text:'운전자연락처'},width:100,editable:true,editor:{maxLength:20}},
		//{name:'WDKEY',header:{text:'입고지시번호'},width:120},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'COMPNM',header:{text:'회사명'},width:100},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:120},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:120},
		{name:'TERMINALCD',header:{text:'IP'},width:100}
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
				var wists = $('#' + gid).gfn_getValue(newRowIdx, 'WISTS');
				
				var editable = (wists === '100');
				
				$('#' + gid).gfn_setColDisabled(['WISCHDT', 'WITYPE', 'WHCD', 'ORGCD', /* 'CUSTCD', */ 'REMARK', 'CARNO', 'DRIVER', 'DRIVERTEL'], editable);
				$('#grid2').gfn_setColDisabled(['ITEMCD', 'WISCHQTY', 'LOCCD', 'UNITPRICE', 'SUPPLYAMT', 'REMARK',
												'LOT1', 'LOT2', 'LOT3', 'LOT4', 'LOT5'], editable);
				
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#' + gid).gfn_setColDisabled(['ORGCD'], false);
				}
				if(!cfn_isEmpty(cfn_loginInfo().WHCD)){
					$('#' + gid).gfn_setColDisabled(['WHCD'], false);
				}
					
				$('#C_CHKWHCD').val($('#' + gid).gfn_getValue(newRowIdx, 'WHCD'));
				$('#C_CHKWHNM').val($('#' + gid).gfn_getValue(newRowIdx, 'WHNM'));
				
				if(wists === '400') {
					$('#tab1').tabs('enable', 1);
				} else {
					cfn_setTabIdx('tab1', 1);
					$('#tab1').tabs('disable', 1);
				}
			}
			
			var wikey = $('#' + gid).gfn_getValue(newRowIdx, 'WIKEY');
			if(!cfn_isEmpty(wikey)) {
				var param = {'WIKEY':wikey};
				fn_getDetailListTab1(param);
				fn_getDetailListTab2(param);
			}
			
		};
		//셀 클릭 이벤트
		gridView.onDataCellClicked = function(gridview, column) {
			var rowidx = $('#' + gid).gfn_getCurRowIdx();
			//출력버튼 클릭
			if (column.column === 'PRINTBTN') {
				var wikey = $('#' + gid).gfn_getValue(rowidx, 'WIKEY');
			
				rfn_getReport(wikey);
			} 
		}
	});
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:100,required:true,editable:true,formatter:'popup',
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
										$('#' + gid).gfn_setValue(rowidx, 'LOT4', '');
										$('#' + gid).gfn_setValue(rowidx, 'LOT5', '');
										$('#' + gid).gfn_setValue(rowidx, 'UNITPRICE', data[i].UNITCOST);
										/* $('#' + gid).gfn_setValue(rowidx, 'CUSTCD', masterData.CUSTCD);
										$('#' + gid).gfn_setValue(rowidx, 'CUSTNM', masterData.CUSTNM); */
										$('#' + gid).gfn_setValue(rowidx, 'COMPCD', masterData.COMPCD);
										$('#' + gid).gfn_setValue(rowidx, 'ORGCD', masterData.ORGCD);
										$('#' + gid).gfn_setValue(rowidx, 'ORGNM', masterData.ORGNM);
										$('#' + gid).gfn_setValue(rowidx, 'WHCD', masterData.WHCD);
									} else {
										$('#' + gid).gfn_addRow({
											ITEMCD: data[i].ITEMCD
											, ITEMNM: data[i].NAME
											, ITEMSIZE: data[i].ITEMSIZE
											, UNITCD: data[i].UNITCD
											, INBOXQTY: data[i].INBOXQTY
											, UNITTYPE: data[i].UNITTYPE
											, LOT4: ''
											, LOT5: ''
											, UNITPRICE: data[i].UNITCOST
											, COMPCD:masterData.COMPCD
											, ORGCD:masterData.ORGCD
											, ORGNM:masterData.ORGNM
											, WHCD:masterData.WHCD
										});	
									}
								}
							}
						}
		},
		{name:'ITEMNM',header:{text:'품명'},width:200},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'WISCHQTY_BOX',header:{text:'예정[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WISCHQTY_EA',header:{text:'예정[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WISCHQTY',header:{text:'예정수량'},width:80,required:true,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11},minVal:1,
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'LOCCD',header:{text:'입고로케이션'},width:90,editable:true,formatter:'popup',width:100,
				popupOption:{url:'/alexcloud/popup/popP005/view.do',
					inparam:{S_WHCD:'WHCD',S_WHNM:'WHNM',S_LOCCD:'LOCCD'},
					outparam:{LOCCD:'LOCCD'},
					returnFn: function(data, type) {
						/*var rowidx = $('#grid2').gfn_getCurRowIdx();
						
						var loccd = $('#' + gid).gfn_getValue(rowidx, 'LOCCD');
						var loc_editable = cfn_isEmpty(loccd); 
						
						$('#grid1').gfn_setColDisabled(['WHCD'], loc_editable);*/	
					}
				}
		},
		{name:'UNITPRICE',header:{text:'단가'},width:100,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11}},
		{name:'SUPPLYAMT',header:{text:'입고금액'},width:100,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11},
					footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'REMARK',header:{text:'비고'},width:300,editable:true,editor:{maxLength:200}},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:110, editor:{maxLength:50},editable:true, formatter:cfn_getLotType(1), show:cfn_getLotVisible(1)},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:110, editor:{maxLength:50},editable:true, formatter:cfn_getLotType(2), show:cfn_getLotVisible(2)},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, editor:{maxLength:50},editable:true, formatter:cfn_getLotType(3), show:cfn_getLotVisible(3)},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, editable:true, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, editable:true, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		{name:'WIKEY',header:{text:'입고번호'},width:120},
		{name:'SEQ',header:{text:'입고순번'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'ORGCD',header:{text:'셀러코드'},width:100},
		{name:'ORGNM',header:{text:'셀러명'},width:100},
		{name:'WHCD',header:{text:'창고코드'},width:100},
		{name:'WHNM',header:{text:'창고명'},width:100},
		{name:'ORIGINQTY',header:{text:'최초입고예정수량'},width:120},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:120},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:120},
		{name:'TERMINALCD',header:{text:'IP'},width:100},
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
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:100},
		{name:'CUSTNM',header:{text:'거래처명'},width:100} */
		
	];
	
	$('#' + gid).gfn_createGrid(columns, {editable:true,mstGrid:'grid1'});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		// 셀 수정 이벤트
		gridView.onEditChange = function(grid, column, value) {
			if (column.column === 'WISCHQTY') {
				var UNITPRICE = $('#' + gid).gfn_getValue(column.dataRow, 'UNITPRICE');
				$('#' + gid).gfn_setValue(column.dataRow, 'SUPPLYAMT', value * UNITPRICE);
				
				var INBOXQTY = $('#' + gid).gfn_getValue(column.dataRow, 'INBOXQTY');
				var UNITTYPE = $('#' + gid).gfn_getValue(column.dataRow, 'UNITTYPE');
				
				if (INBOXQTY <= 0){
					$('#' + gid).gfn_setValue(column.dataRow, 'WISCHQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'WISCHQTY_EA', 0);
					
					cfn_msg('ERROR', '품목의 박스입수량이 잘못되었습니다.');
					return false;
				}
				
				if (UNITTYPE == 'BOXEA'){
					$('#' + gid).gfn_setValue(column.dataRow, 'WISCHQTY_BOX', parseInt(value / INBOXQTY)); 
					$('#' + gid).gfn_setValue(column.dataRow, 'WISCHQTY_EA', parseInt(value % INBOXQTY));	
				} else if (UNITTYPE == 'EA'){
					$('#' + gid).gfn_setValue(column.dataRow, 'WISCHQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'WISCHQTY_EA', value);	
				}
			} else if (column.column === 'UNITPRICE') {
				var WISCHQTY = $('#' + gid).gfn_getValue(column.dataRow, 'WISCHQTY');
				$('#' + gid).gfn_setValue(column.dataRow, 'SUPPLYAMT', WISCHQTY * value);
			}
		};
		// 셀 로우 변경 이벤트
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

function grid3_Load() {
	var gid = 'grid3';
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:100},
		{name:'ITEMNM',header:{text:'품명'},width:200},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'WDQTY_BOX',header:{text:'입고[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDQTY_EA',header:{text:'입고[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WDQTY',header:{text:'입고수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'LOCCD',header:{text:'입고로케이션'},width:90},
		{name:'REMARK',header:{text:'비고'},width:300},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1), show:cfn_getLotVisible(1)},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2), show:cfn_getLotVisible(2)},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3), show:cfn_getLotVisible(3)},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},		
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		{name:'LOTKEY',header:{text:'로트번호'},width:100},
		{name:'WIKEY',header:{text:'입고번호'},width:120},
		{name:'WISEQ',header:{text:'입고순번'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'WHCD',header:{text:'창고코드'},width:100},
		//{name:'ORIGINQTY',header:{text:'최초입고예정수량',width:110,align:'right',formatter:'integer',sorttype:'int'},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:120},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:120},
		{name:'TERMINALCD',header:{text:'IP'},width:100},
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100,show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100,show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100,show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100,show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100,show:cfn_getCompItemVisible(15)}/* ,
		{name:'CUSTCD',header:{text:'거래처코드'},width:110,visible:false,show:false} */
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true,mstGrid:'grid1'});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').gridView().commit();
		$('#grid2').dataProvider().clearRows();
		$('#A_LOCCD').val('');
		
		$('#grid1').gfn_setDataList(data.resultList);
		
		//검색결과에 따른 마스터 데이터 포커스 이동 처리 (저장처리 이후 발생 gfn_setFocusPK함수 처리)
		$('#grid1').gfn_focusPK();
	}
	//등록 : 디테일리스트검색
	else if (sid == 'sid_getDetailListTab1') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//실적 : 디테일리스트검색
	else if (sid == 'sid_getDetailListTab2') {
		$('#grid3').gfn_setDataList(data.resultList);
	}
	//저장
	else if(sid == 'sid_setSave') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['WIKEY']);
		
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		
		cfn_retrieve();
	}
	//삭제
	else if(sid == 'sid_setDelete') {
		var resultData = data.resultData;
		
		$('#grid1').gfn_setFocusPK(resultData, ['WIKEY']);
		
		cfn_msg('INFO', '정상적으로 취소되었습니다.');
		cfn_retrieve();
	}
	else if(sid == 'sid_setExecute') {
		var resultData = data.resultData;
	
		$('#grid1').gfn_setFocusPK(resultData, ['WIKEY']);
	
		cfn_msg('INFO', '정상적으로 실행되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve(chkflg) {

	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);
	$('#grid3').gridView().commit(true);
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100370/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 등록 : 디테일 리스트 검색 */
function fn_getDetailListTab1(param) {
	var sid = 'sid_getDetailListTab1';
	var url = '/alexcloud/p100/p100370/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 실적 : 디테일 리스트 검색 */
function fn_getDetailListTab2(param) {
	var sid = 'sid_getDetailListTab2';
	var url = '/alexcloud/p100/p100370/getDetailList2.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}


/* 공통버튼 - 신규 클릭 */
function cfn_new() {
	
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);
	$('#grid3').gridView().commit(true);

	$('#C_CHKWHCD').val('');
	$('#C_CHKWHNM').val('');
	
	$('#A_LOCCD').val('');
	
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
	$('#grid3').dataProvider().clearRows();
	
	cfn_setTabIdx('tab1', 1);		
	$('#tab1').tabs('disable', 1);	
		
	$('#grid1').gfn_addRow({
		WISCHDT:cfn_getDateFormat(new Date(), 'yyyyMMdd')
		, WISTS:'100'
		, WITYPE:'STD'
		, VATFLG:'0'
		, COMPCD:cfn_loginInfo().COMPCD
		, COMPNM:cfn_loginInfo().COMPNM
		, ORGCD:cfn_loginInfo().ORGCD
		, ORGNM:cfn_loginInfo().ORGNM
		, WHCD:cfn_loginInfo().WHCD
		, WHNM:cfn_loginInfo().WHNM
	});
}


/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {
	var tabidx = cfn_getTabIdx('tab1');
	
	if(tabidx === 2) {
		cfn_msg('WARNING','등록 탭에서 저장하세요.');
		return;
	}
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING','선택된 전표가 없습니다.');
		return false;
	}
	
	//마스터 필수입력 체크
	if ($('#grid1').gfn_checkValidateCells([rowidx])) return false;
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (masterData.WISTS !== '100') {
		cfn_msg('WARNING','예정 상태일 때만 저장할 수 있습니다.');
		return false;
	}
	
	var realRowData = $('#grid2').gfn_getDataList(true, false); //삭제된 행은 카운트하지 않는다.
	
	if (realRowData.length < 1) {
		cfn_msg('WARNING','품목이 없습니다.');
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
		var url = '/alexcloud/p100/p100370/setSave.do';
		var sendData = {'mGridData':masterData, 'dGridData':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

/* 공통버튼 - 취소 클릭 */
function cfn_del() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (cfn_isEmpty(masterData.WIKEY)) {
		$('#grid1').gfn_delRow(rowidx);
		return false;
	} else if (masterData.WISTS !== '100') {
		cfn_msg('WARNING', '예정 상태 일 때만 취소할 수 있습니다.');
		return false;
	}
		
	if(confirm('입고번호 : [' + masterData.WIKEY + '] 취소하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p100/p100370/setDelete.do';
		var sendData = {'paramData':masterData};
		
		gfn_sendData(sid, url, sendData);
	}	
}

//디테일 그리드 추가 버튼 이벤트
function fn_btn_detailAdd() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING','선택된 행이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	if (masterData.WISTS !== '100') {
		cfn_msg('WARNING','예정전표에서만 추가 가능합니다.');
		return false;
	}

	if(cfn_isEmpty(masterData.WHCD)) {
		cfn_msg('WARNING', '창고를 선택하세요.');
		return false;
	}

	$('#grid2').gfn_addRow({
		COMPCD: masterData.COMPCD
		, WHCD: masterData.WHCD
		, WHNM: masterData.WHNM
		, ORGCD: masterData.ORGCD
		, ORGNM: masterData.ORGNM
		, LOT4:''
		, LOT5:''
	});
	
	$('#C_CHKWHCD').val(masterData.WHCD);
	$('#C_CHKWHNM').val(masterData.WHNM);
	
	
}  

//디테일 그리드 삭제 버튼 이벤트
function fn_btn_detailDel() {
	var rowidx = $('#grid2').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING','선택된 행이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow($('#grid1').gfn_getCurRowIdx());
	if (masterData.WISTS !== '100') {
		cfn_msg('WARNING','예정전표에서만 삭제 가능합니다.');
		return false;
	}
	
	$('#grid2').gfn_delRow(rowidx);
}  

/* 공통버튼 - 확정 클릭 */
function cfn_execute() {
	var tabidx = cfn_getTabIdx('tab1');
	
	if(tabidx === 2) {
		cfn_msg('WARNING', '등록 탭에서 실행하세요.');
		return;
	}

	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (masterData.WISTS !== '100') {
		cfn_msg('WARNING', '예정 상태일 때만 확정할 수 있습니다.');
		return false;
	}
	
	var realRowData = $('#grid2').gfn_getDataList(true, false); //삭제된 행은 카운트하지 않는다.
	
	if (realRowData.length < 1) {
		cfn_msg('WARNING', '품목이 없습니다.');
		return false;
	}
	
	//디테일 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;

	for (var i=0; i<realRowData.length; i++) {
		if(cfn_isEmpty($('#grid2').gfn_getValue(i, 'LOCCD'))) {
			cfn_msg('WARNING', '입고로케이션을  입력하세요.');
			return;
		}
	}
	
	var detailData = $('#grid2').gfn_getDataList();
	
	if(confirm("실적 처리하시겠습니까?")) {
		var sid = 'sid_setExecute';
		var url = '/alexcloud/p100/p100370/setExecute.do';
		var sendData = {'mGridData':masterData,'dGridData':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

/* 로케이션 일괄적용 */
function fn_btn_applyLoc() {
	
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);
	$('#grid3').gridView().commit(true);
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	var editable = $('#grid1').gfn_getValue(rowidx, 'WISTS') === '100';
	
	if(editable == false)  {
		cfn_msg('WARNING','예정상태에서만 적용 가능합니다.');
		return;
	}

	var loccd = $('#A_LOCCD_R').val();
	
	if(cfn_isEmpty(loccd)) {
		cfn_msg('WARNING','로케이션을 확인하세요.');
		return;
	}
	
	//전체 행의 개수
	var endidx = $('#grid2').dataProvider().getRowCount();
	
	if(endidx > 0) {
		for(var i=0; i < endidx; i++) {
			$('#grid2').gfn_setValue(i,'LOCCD', loccd);	
		}
	}
	
	$('#A_LOCCD').val('');
	$('#A_LOCCD_R').val('');
}

//출력팝업 - 입고요청서,거래명세서
function rfn_getReport(wikey) {
	pfn_popupOpen({
		url: '/alexcloud/p100/p100380/popReportView.do',
		pid: 'P100380_reportPop',
		returnFn: function(data, type) {
			var reportTitle,reportName;
			
			if (type == 'OK') {
				if (data.P100380_R == '1') { //입고요청서
					reportTitle = '입고요청서';
					reportName = 'P100300_R01';
				} else if(data.P100380_R == '2') {//거래명세서
					reportTitle = '거래명세서';
					reportName = 'P100300_R02';
				} else if(data.P100380_R == '3') {//입고요청서(빈양식)
					reportTitle = '입고요청서(빈양식)';
					reportName = 'P100300_R01';
					wikey = '';
				} else if(data.P100380_R == '4') {//거래명세서(빈양식)
					reportTitle = '거래명세서(빈양식)';
					reportName = 'P100300_R02';
					wikey = '';
				}	
				
				rfn_reportView({
					title: reportTitle,
					jrfName: reportName,
					args: {'WIKEY':wikey, 'PRINTUSERNM':cfn_loginInfo().USERNM}
				});		
			}
		}
		
	});	
}
</script>

<c:import url="/comm/contentBottom.do" />