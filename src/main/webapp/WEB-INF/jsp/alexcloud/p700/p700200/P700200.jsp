<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P700200
	화면명    : 로케이션이동등록 - RealGrid 마스터 디테일 그리드 2개 패턴
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="S_COMPNM" class="cmc_code" />
	<input type="hidden" id="C_CHKWHCD" class="cmc_code" />
	<input type="hidden" id="C_CHKWHNM" class="cmc_code" />
	
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
					<option value="">전체(취소포함)</option>
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
			<div>이동유형</div>
			<div>
				<select id="S_MVTYPE" class="cmc_combo">
					<option value="">전체</option>
					<c:forEach var="i" items="${codeMVTYPE}">
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
		<div class="grid_top_right">
			<input type="text" id="A_LOCCD" class="cmc_code" />
			<input type="hidden" id="A_LOCCD_R" class="cmc_value" />
			<button type="button" class="cmc_cdsearch"></button>
			<input type="button" id="btn_applyAll" class="cmb_normal" value="일괄적용" onclick="fn_applyAll();"/>
			<input type="button" id="btn_autoQty" class="cmb_normal" value="수량자동세팅" onclick="fn_autoQty();"/>
			<input type="button" id="btn_detailAdd" class="cmb_plus" onclick="fn_detailAdd();"/>
			<input type="button" id="btn_detailDel" class="cmb_minus" onclick="fn_detailDel();" />
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
	
	setCommBtn('del', null, '취소');

	$('#S_IMDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_IMDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_IMSTS').val('100');
	
	//로그인 정보로 세팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM); 
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
	
	/* 공통코드 코드/명 (로케이션 일괄적용) */
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'A_LOCCD',
		inparam:{S_COMPCD:'S_COMPCD',S_LOCCD:'A_LOCCD,A_LOCCD_R',S_WHCD:'C_CHKWHCD',S_WHNM:'C_CHKWHNM'},
		outparam:{LOCCD:'A_LOCCD,A_LOCCD_R'},
		beforeFn: function() { 
			var c_chkwhcd = $('#C_CHKWHCD').val();
			var c_chkwhnm = $('#C_CHKWHNM').val();
			
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
		{name:'IMKEY',header:{text:'이동번호'},width:150,styles:{textAlignment:'center'}},
		{name:'IMDT',header:{text:'이동일자'},width:110,formatter:'date',styles:{textAlignment:'center'},editable:true,required:true},
		{name:'MVTYPE',header:{text:'이동구분'},width:100,formatter:'combo',comboValue:'${gCodeMVTYPE}',styles:{textAlignment:'center'}},
		{name:'IMSTS',header:{text:'상태'},width:100,formatter:'combo',comboValue:'${gCodeIMSTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'value = 200',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}			
			]		
		},
		{name:'WHCD',header:{text:'창고코드'},width:110,editable:true,styles:{textAlignment:'center'},required:true,formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP004/view.do',
						 inparam:{S_WHCD:'WHCD',S_COMPCD:'COMPCD',S_WHNM:'WHNM'},
						 outparam:{WHCD:'WHCD',NAME:'WHNM'},
						 returnFn: function(data, type) {
							 if(data.length > 0) {
								 var rowidx = $('#' + gid).gfn_getCurRowIdx();
								 $('#' + gid).gfn_setValue(rowidx, 'IMWHCD', data[0].WHCD);}}}},
		{name:'WHNM',header:{text:'창고명'},width:110,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'화주코드'},width:100,editable:true,styles:{textAlignment:'center'},required:true,formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP002/view.do',
				 inparam:{S_ORGCD:'ORGCD',S_COMPCD:'COMPCD'},
				 outparam:{ORGCD:'ORGCD',NAME:'ORGNM'}}},
		{name:'ORGNM',header:{text:'화주명'},width:100,styles:{textAlignment:'center'}},
		{name:'REMARK',header:{text:'비고'},width:300,editable:true,editor:{maxLength:200}},
		{name:'PRINTBTN',header:{text:'출력'},width:35,formatter:'btnsearch'},
		{name:'ITEMCNT',header:{text:'품목수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'TOTQTY',header:{text:'총수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMWHCD',header:{text:'이동중창고코드'},width:110,styles:{textAlignment:'center'}},
		{name:'IMWHNM',header:{text:'이동중창고명'},width:110,styles:{textAlignment:'center'}},
		{name:'CFMUSERCD',header:{text:'확정자'},width:100,styles:{textAlignment:'center'}},
		{name:'CFMUSERNM',header:{text:'확정자명'},width:100,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,visible:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,visible:false}
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
				//상태가 예정이 아닐 때 해당 Row 컬럼 모두 disabled 처리
				var editable = $('#' + gid).gfn_getValue(newRowIdx, 'IMSTS') === '100';
				
				$('#' + gid).gfn_setColDisabled(['IMDT','ORGCD','WHCD', 'USERCD', 'REMARK'], editable);
				$('#grid2').gfn_setColDisabled(['ITEMCD', 'IMSCHQTY','AFTERLOCCD','REMARK'], editable);
				
				/*if(editable == false) {
					$('#A_LOCCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
					$('#A_LOCCD_R').next('button.cmc_cdsearch').hide();
					$('#btn_applyAll').hide();
				} else {
					$('#A_LOCCD').attr('disabled',false).removeClass('disabled').attr('readonly',false);
					$('#A_LOCCD_R').next('button.cmc_cdsearch').show();
					$('#btn_applyAll').show();
				}*/
			
				if (!cfn_isEmpty(cfn_loginInfo().WHCD)) {
					$('#' + gid).gfn_setColDisabled(['WHCD'], false);
				} 
				if (!cfn_isEmpty(cfn_loginInfo().ORGCD)) {
					$('#' + gid).gfn_setColDisabled(['ORGCD'], false);
				}
			}
			
			
			
			var imkey = $('#' + gid).gfn_getValue(newRowIdx, 'IMKEY');
			$('#C_CHKWHCD').val($('#' + gid).gfn_getValue(newRowIdx, 'WHCD'));
			$('#C_CHKWHNM').val($('#' + gid).gfn_getValue(newRowIdx, 'WHNM'));
			
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
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'},required:true,editable:true,formatter:'popup',
			popupOption:{
				url:'/alexcloud/popup/popP810/view.do'
				, inparam:{
					S_ITEM:'ITEMCD'
					, S_COMPCD:'COMPCD'
					, S_ORGCD:'ORGCD'
					, S_ORGNM:'ORGNM'
					, S_WHCD:'WHCD'
					, S_WHNM:'WHNM'
					, S_LOCCD:'BEFORELOCCD'
					, S_LOTKEY:'LOTKEY'
				}
				, outparam:{
					ITEMCD:'ITEMCD'
					, ITEMNM:'ITEMNM'
					, ITEMSIZE:'ITEMSIZE'
					, UNITCD:'UNITCD'
					, INBOXQTY:'INBOXQTY'
					, UNITTYPE:'UNITTYPE'
					, LOCCD:'BEFORELOCCD'
					, AVAILQTY:'BEFAVAILQTY'
					, LOTKEY:'LOTKEY'
					, LOT1:'LOT1'
					, LOT2:'LOT2'
					, LOT3:'LOT3'
					, LOT4:'LOT4'
					, LOT5:'LOT5'
				}
				, returnFn: function(data, type) {
					var rowidxM = $('#grid1').gfn_getCurRowIdx();
					var masterData = $('#grid1').gfn_getDataRow(rowidxM);
					var rowidx = $('#' + gid).gfn_getCurRowIdx();
					for (var i=0; i<data.length; i++) {
						if (i === 0) {
							$('#' + gid).gfn_setValue(rowidx, 'ITEMCD', data[i].ITEMCD);
							$('#' + gid).gfn_setValue(rowidx, 'ITEMNM', data[i].ITEMNM);
							$('#' + gid).gfn_setValue(rowidx, 'ITEMSIZE', data[i].ITEMSIZE);
							$('#' + gid).gfn_setValue(rowidx, 'UNITCD', data[i].UNITCD);
							$('#' + gid).gfn_setValue(rowidx, 'UNITTYPE', data[i].UNITTYPE);
							$('#' + gid).gfn_setValue(rowidx, 'INBOXQTY', data[i].INBOXQTY);
							$('#' + gid).gfn_setValue(rowidx, 'IMSCHQTY_BOX', '');
							$('#' + gid).gfn_setValue(rowidx, 'IMSCHQTY_EA', '');
							$('#' + gid).gfn_setValue(rowidx, 'IMSCHQTY', '');
							$('#' + gid).gfn_setValue(rowidx, 'BEFORELOCCD', data[i].LOCCD);
							$('#' + gid).gfn_setValue(rowidx, 'BEFAVAILQTY', data[i].AVAILQTY);
							$('#' + gid).gfn_setValue(rowidx, 'LOT1', data[i].LOT1);
							$('#' + gid).gfn_setValue(rowidx, 'LOT2', data[i].LOT2);
							$('#' + gid).gfn_setValue(rowidx, 'LOT3', data[i].LOT3);
							$('#' + gid).gfn_setValue(rowidx, 'LOT4', data[i].LOT4);
							$('#' + gid).gfn_setValue(rowidx, 'LOT5', data[i].LOT5);
							$('#' + gid).gfn_setValue(rowidx, 'LOTKEY', data[i].LOTKEY);
							$('#' + gid).gfn_setValue(rowidx, 'COMPCD', masterData.COMPCD);
							$('#' + gid).gfn_setValue(rowidx, 'COMPNM', masterData.COMPNM);
							$('#' + gid).gfn_setValue(rowidx, 'WHCD', masterData.WHCD);
							$('#' + gid).gfn_setValue(rowidx, 'WHNM', masterData.WHNM);
							$('#' + gid).gfn_setValue(rowidx, 'ORGCD', masterData.ORGCD);
							$('#' + gid).gfn_setValue(rowidx, 'ORGNM', masterData.ORGNM);
						} else {
							$('#' + gid).gfn_addRow({
								ITEMCD: data[i].ITEMCD,
								ITEMNM: data[i].ITEMNM,
								ITEMSIZE: data[i].ITEMSIZE,
								UNITCD: data[i].UNITCD,
								UNITTYPE: data[i].UNITTYPE,
								INBOXQTY: data[i].INBOXQTY,
								IMSCHQTY_BOX:'',
								IMSCHQTY_EA:'',
								IMSCHQTY: '',
								BEFORELOCCD: data[i].LOCCD,
								BEFAVAILQTY: data[i].AVAILQTY,
								LOT1: data[i].LOT1,
								LOT2: data[i].LOT2,
								LOT3: data[i].LOT3,
								LOT4: data[i].LOT4,
								LOT5: data[i].LOT5,
								LOTKEY: data[i].LOTKEY,
								COMPCD:masterData.COMPCD,
								COMPNM:masterData.COMPNM,
								WHCD:masterData.WHCD,
								WHNM:masterData.WHNM,
								ORGCD:masterData.ORGCD,
								ORGNM:masterData.ORGNM
							});	
						}
					}
				}
			}
		},
		{name:'ITEMNM',header:{text:'품명'},width:250},
		{name:'ITEMSIZE',header:{text:'규격'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},styles:{textAlignment:'center'}},
		{name:'BEFORELOCCD',header:{text:'로케이션'},formatter:'popup',width:110,styles:{textAlignment:'center'}},
		{name:'AFTERLOCCD',header:{text:'이동로케이션'},formatter:'popup',width:110, editable:true, required:true,styles:{textAlignment:'center'},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
						 inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'WHNM',S_LOCCD:'AFTERLOCCD'},
						 outparam:{LOCCD:'AFTERLOCCD'},
						 returnFn: function(data, type) {
							 if(data.length > 0) {
								 var rowidx = $('#' + gid).gfn_getCurRowIdx();
								 $('#' + gid).gfn_setValue(rowidx, 'IMLOCCD', data[0].LOCCD); }}}},
		//{name:'TOTAVAILQTY',header:{text:'이동전총가용수량'},width:120,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'BEFAVAILQTY',header:{text:'이동가능수량'},dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMSCHQTY_BOX',header:{text:'지시[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMSCHQTY_EA',header:{text:'지시[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMSCHQTY',header:{text:'이동지시수량'},width:110,required:true,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11,type:"number",positiveOnly:true,integerOnly:true},minVal:1,
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},			
		{name:'IMQTY_BOX',header:{text:'이동[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMQTY_EA',header:{text:'이동[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMQTY',header:{text:'이동수량'},dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
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
		{name:'SEQ',header:{text:'순번'},width:60,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,visible:false},
		{name:'WHCD',header:{text:'창고코드'},width:110,visible:false},
		{name:'WHNM',header:{text:'창고명'},width:110,visible:false},
		{name:'ORGCD',header:{text:'화주코드'},width:100,visible:false},
		{name:'ORGNM',header:{text:'화주명'},width:100,visible:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,visible:false},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true,mstGrid:'grid1'});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
	  	//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				$('#grid1').gfn_setColDisabled(['ORGCD','WHCD'], false); //행추가되면 무조건 disable
				
			} else { //품목이 다 지워지면 edit 가능
				$('#grid1').gfn_setColDisabled(['ORGCD','WHCD'], true);
			
				if (!cfn_isEmpty(cfn_loginInfo().WHCD)) {
					$('#grid1').gfn_setColDisabled(['WHCD'], false);
				}
				if (!cfn_isEmpty(cfn_loginInfo().ORGCD)) {
					$('#grid1').gfn_setColDisabled(['ORGCD'], false);
				}
			}
		};
		//셀 수정 이벤트
		gridView.onEditChange = function(grid, column, value) {
			if (column.column === 'IMSCHQTY') {
				var INBOXQTY = $('#' + gid).gfn_getValue(column.dataRow, 'INBOXQTY'); //BOX입수량
				var UNITTYPE = $('#' + gid).gfn_getValue(column.dataRow, 'UNITTYPE'); //관리단위
				if (INBOXQTY <= 0) {
					$('#' + gid).gfn_setValue(column.dataRow, 'IMSCHQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'IMSCHQTY_EA', 0);
					cfn_msg('ERROR', '품목의 박스입수량이 잘못되었습니다.');
					return false;
				}
				if (UNITTYPE == 'BOXEA') {
					$('#' + gid).gfn_setValue(column.dataRow, 'IMSCHQTY_BOX', parseInt(value / INBOXQTY)); 
					$('#' + gid).gfn_setValue(column.dataRow, 'IMSCHQTY_EA', parseInt(value % INBOXQTY));	
				} else if (UNITTYPE == 'EA'){
					$('#' + gid).gfn_setValue(column.dataRow, 'IMSCHQTY_BOX', 0); 
					$('#' + gid).gfn_setValue(column.dataRow, 'IMSCHQTY_EA', value);	
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
		$('#A_LOCCD').val('');
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//저장
	if(sid == 'sid_setSave') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['IMKEY']);
		cfn_msg('INFO', '정상적으로  저장되었습니다.');
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
	$('#grid1').gridView().cancel();
	$('#grid2').gridView().cancel();

	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p700/p700200/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p700/p700200/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 신규 클릭 */
function cfn_new() {
	$('#C_CHKWHCD').val('');
	$('#C_CHKWHNM').val('');
	$('#A_LOCCD').val('');
	
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
		IMDT:cfn_getDateFormat(new Date(), 'yyyyMMdd')
		, IMSTS:'100'
		, COMPCD:cfn_loginInfo().COMPCD
		, COMPNM:cfn_loginInfo().COMPNM
		, WHCD:cfn_loginInfo().WHCD
		, WHNM:cfn_loginInfo().WHNM
		, ORGCD:cfn_loginInfo().ORGCD
		, ORGNM:cfn_loginInfo().ORGNM
	});
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
	
	var realRowData = $('#grid2').gfn_getDataList(true, false); //삭제된 행은 카운트하지 않는다.
	
	if (realRowData.length < 1) {
		cfn_msg('WARNING', '품목이 없습니다.');
		return false;
	}
	
	//디테일 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;
	
	for (var i = 0; i < realRowData.length; i++) { 
		if (realRowData[i].BEFAVAILQTY < realRowData[i].IMSCHQTY) {
			cfn_msg('WARNING', '이동지시수량이 이동가능수량보다 많습니다.');
			$('#grid2').gfn_setFocusPK(realRowData[i], ['COMPCD','ORGCD','ITEMCD','IMSCHQTY']);
			$('#grid2').gfn_focusPK();
			return;
		} else if(realRowData[i].BEFORELOCCD == realRowData[i].AFTERLOCCD) {
			cfn_msg('WARNING', '현로케이션과 이동로케이션이 같습니다.');
			$('#grid2').gfn_setFocusPK(realRowData[i], ['COMPCD','ORGCD','ITEMCD','AFTERLOCCD']);
			$('#grid2').gfn_focusPK();
			return;
		}
	}
	
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}

	var detailData = $('#grid2').gfn_getDataList();

	if (flg) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p700/p700200/setSave.do';
		var sendData = {'mGridData':masterData,'dGridData':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//디테일 그리드 추가 버튼 이벤트
function fn_detailAdd() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	if (masterData.IMSTS !== '100') {
		cfn_msg('WARNING', '예정전표에서만 추가 가능합니다.');
		return false;
	} else if(cfn_isEmpty(masterData.WHCD)) {
		cfn_msg('WARNING', '창고를 선택하세요.');
		return false;
	}
	
	$('#C_CHKWHCD').val(masterData.WHCD);
	$('#C_CHKWHNM').val(masterData.WHNM);
	
	$('#grid2').gfn_addRow({
		'LOT4':''
		, 'LOT5':''
		, 'COMPCD':masterData.COMPCD
		, 'COMPNM':masterData.COMPNM
		, 'WHCD':masterData.WHCD
		, 'WHNM':masterData.WHNM
		, 'ORGCD':masterData.ORGCD
		, 'ORGNM':masterData.ORGNM
	});
}

//디테일 그리드 삭제 버튼 이벤트
function fn_detailDel() {
	var rowidx = $('#grid2').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow($('#grid1').gfn_getCurRowIdx());
	if (masterData.IMSTS !== '100') {
		cfn_msg('WARNING', '예정전표에서만 삭제 가능합니다.');
		return false;
	}
	
	$('#grid2').gfn_delRow(rowidx);
}

/* 로케이션 일괄적용 */
function fn_applyAll() {
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);

	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	var editable = $('#grid1').gfn_getValue(rowidx, 'IMSTS') === '100';
	
	if (editable == false) {
		cfn_msg('WARNING','예정상태에서만 적용 가능합니다.');
		return;
	}
	
	var loccd = $('#A_LOCCD_R').val();
	
	if (cfn_isEmpty(loccd)) {
		cfn_msg('WARNING','로케이션을 확인하세요.');
		return;
	}
	
	//전체 행의 개수
	var endidx = $('#grid2').dataProvider().getRowCount();
	
	if (endidx > 0) {
		for(var i=0; i < endidx; i++) {
			$('#grid2').gfn_setValue(i,'AFTERLOCCD', loccd);
			$('#grid2').gfn_setValue(i,'IMLOCCD', loccd);
		}
	}
	
	$('#A_LOCCD').val('');
	$('#A_LOCCD_R').val('');
}

/* 수량자동세팅 */
function fn_autoQty() {
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);

	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '신규행을 추가해주세요.');
		return false;
	}
	var rowidxD = $('#grid2').gfn_getCurRowIdx();
	
	if (rowidxD < 0) {
		cfn_msg('WARNING', '행을 추가해주세요.');
		return false;
	}	
	var editable = $('#grid1').gfn_getValue(rowidx, 'IMSTS') === '100';
	
	if (editable == false)  {
		cfn_msg('WARNING','예정상태에서만 적용 가능합니다.');
		return;
	}
	
	//전체 행의 개수
	var endidx = $('#grid2').dataProvider().getRowCount();
	
	if (endidx > 0) {
		for(var i=0; i < endidx; i++) {
			$('#grid2').gfn_setValue(i,'IMSCHQTY', $('#grid2').gfn_getValue(i, 'BEFAVAILQTY'));
		}
	}
}

/* 공통버튼 - 취소 클릭 */
function cfn_del() {
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);

	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (cfn_isEmpty(masterData.IMKEY)) {
		$('#grid1').gfn_delRow(rowidx);
		return false;
	} else if (masterData.IMSTS !== '100') {
		cfn_msg('WARNING', '예정 상태 일 때만 취소할 수 있습니다.');
		return false;
	}
	
	if (confirm('이동번호[' + masterData.IMKEY + '] 항목을 취소하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p700/p700200/setDelete.do';
		var sendData = {'paramData':masterData};

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
				if (data.P700200_R === '1') { //빈양식
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