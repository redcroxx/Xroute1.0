<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000026
	화면명    : 복합품목관리
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="S_COMPCD" /> 
		<input type="hidden" id="S_COMPNM" /> 
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
				<div>복합코드/명</div>
				<div>
					<input type="text" id="S_ITEM" class="cmc_txt" />
				</div>
			</li>
			<%-- <li class="sech_li">
				<div>개별품목여부</div>
				<div>
					<select id="S_MAX_CLGO_QTY" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_YN}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li">
				<div>70%품목여부</div>
				<div>
					<select id="S_SEVENTY" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_YN}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li">
				<div>소형품목여부</div>
				<div>
					<select id="S_SMALL_YN" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_YN}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li> --%>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_left_wrap fix" style="width:950px;">
	<div class="grid_top_wrap">
		<div class="grid_top_left">복합코드목록<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>		
	</div>
	<div id="grid1"></div>
</div>
<div class="ct_right_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">구성품목록<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="button" id="btn_upload" class="cmb_normal" value="업로드" onclick="pfn_upload('P000026');" />
			<button type="button" id="btn_grid2Add" class="cmb_plus" onclick="fn_grid2AddRow()"></button>
			<button type="button" id="btn_grid2Del" class="cmb_minus" onclick="fn_grid2DelRow()"></button>
		</div>		
	</div>
	<div id="grid2"></div>
	<div class="grid_top_wrap">
			<div class="grid_top_left">복합 코드 리스트<span>(총 0건)</span></div>
			<div class="grid_top_right">
			</div>
		</div>
	<div id="grid3" ></div>
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
	$('#grid3').hide();
	initLayout();
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	
	//검색 신규 삭제 저장
	setCommBtnSeq(['exceldown','ret','new','del','save']);
	setCommBtn('exceldown', null, '복합코드리스트다운');
	
	grid1_Load();
	grid2_Load(); 
	grid3_Load(); 
	
	//셀러
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD', S_COMPNM:'S_COMPNM', S_ORGCD:'S_ORGCD'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});

	if ($('#S_ORGCD').val().length > 0) {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}		
});

function grid1_Load() {
	var gid = 'grid1', $grid = $('#' + gid);
	var orgcode = cfn_loginInfo().ORGCD
	
	// 셀러코드가 없으면 셀러코드 선택,수정가능
	if (orgcode == null) {
		var columns = [
		
			{name:'PROD_CD',header:{text:'복합코드'},width:120,required:true,editable:true,styles:{textAlignment:'center'}},
			{name:'PROD_NM',header:{text:'명칭'},width:350,required:true,editable:true},
		
			/* {name:'MAX_CLGO_QTY',header:{text:'개별\n품목여부'},width:100,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
			{name:'SMALL_YN',header:{text:'소형\n품목여부'},width:100,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
			{name:'SEVENTY',header:{text:'70%\n품목여부'},width:100,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}}, */
			
			{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'}},
			{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
			{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}},
			{name:'ADDUSERCD',header:{text:'등록자'},width:120,styles:{textAlignment:'center'}},
			{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
			{name:'ORGCD',header:{text:'셀러코드'},width:100,formatter:'popup',editable:true,required:true,editor:{maxLength:20},
				popupOption:{url:'/alexcloud/popup/popP002/view.do',
					inparam:{S_COMPCD:'COMPCD',S_ORGCD:'ORGCD'},outparam:{ORGCD:'ORGCD',NAME:'ORGNM'}}
			},
			{name:'ORGNM',header:{text:'셀러명'},width:100},
			{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		];
	} else {
		var columns = [
			
			{name:'PROD_CD',header:{text:'복합코드'},width:120,required:true,editable:true,styles:{textAlignment:'center'}},
			{name:'PROD_NM',header:{text:'명칭'},width:350,required:true,editable:true},
			
			/* {name:'MAX_CLGO_QTY',header:{text:'개별\n품목여부'},width:100,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
			{name:'SMALL_YN',header:{text:'소형\n품목여부'},width:100,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
			{name:'SEVENTY',header:{text:'70%\n품목여부'},width:100,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}}, */
			
			{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'}},
			{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
			{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}},
			{name:'ADDUSERCD',header:{text:'등록자'},width:120,styles:{textAlignment:'center'}},
			{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
			{name:'ORGCD',header:{text:'셀러코드'},width:100, visible:false},
			{name:'ORGNM',header:{text:'셀러명'},width:100},
			{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		];
	}
	$grid.gfn_createGrid(columns, {footerflg:false});
	
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		$('#'+gid).gridView().setColumnProperty(
			gridView.columnByField("PROD_NM"),
				"dynamicStyles", [{
					criteria: [
						"values['PROD_NM'] <> ''"
					],
					styles: [
						"background=#33ff33"
					]
				}]
			)
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
				var state = dataProvider.getRowState(newRowIdx);
				var editable = state === 'created';
				$grid.gfn_setColDisabled(['ORGCD','PROD_CD'], editable);

				var rowData = dataProvider.getJsonRow(newRowIdx);
				if (!cfn_isEmpty(rowData.PROD_CD)) {
					fn_getDetailList(rowData);
				} else {
					$('#grid2').gfn_clearData();
				}
			}
		};
	});
}

function grid2_Load() {
	var gid = 'grid2', $grid = $('#' + gid);
	var columns = [
		{name:'ITEMCD',header:{text:'단품코드'},width:120,formatter:'popup',editable:true,required:true,
			popupOption:{url:'/alexcloud/popup/popP006/view.do',
				inparam:{S_COMPCD:'COMPCD', S_ORGCD:'ORGCD', S_ORGNM:'ORGNM', S_ITEMCD:'ITEMCD'},
				outparam:{},
				returnFn: function(data, type) {
					var rowidx = $grid.gfn_getCurRowIdx();
					$grid.gfn_delRow(rowidx);
					
					var rowData = $('#grid1').gfn_getDataRow($('#grid1').gfn_getCurRowIdx());
					
					for (var i=0; i<data.length; i++) {
						$grid.gfn_addRow({
							COMPCD:rowData.COMPCD,
							ORGCD:rowData.ORGCD, 
							ORGNM:rowData.ORGNM, 
							PROD_CD:rowData.PROD_CD,
							ITEMCD: data[i].ITEMCD,
							NAME: data[i].NAME,
							SPROD_QTY: 1,
							SET_QTY : 1
						});	
					}
				}
			}
		},
		{name:'NAME',header:{text:'품목명'},width:180},
		{name:'SPROD_QTY',header:{text:'수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			editable:true,required:true,editor:{maxLength:11,type:'number',positiveOnly:true,integerOnly:true,editFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'SET_QTY',header:{text:'세트수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			editable:true,required:true,editor:{maxLength:11,type:'number',positiveOnly:true,integerOnly:true,editFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'REMARKS',header:{text:'비고'},width:300,editable:true,editor:{maxLength:200}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,visible:false},
		{name:'ORGNM',header:{text:'셀러명'},width:100,visible:false},
		{name:'PROD_CD',header:{text:'복합코드'},width:100,visible:false},
		
	];
	$grid.gfn_createGrid(columns,{mstGrid:'grid1'});
	
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var state = dataProvider.getRowState(newRowIdx);
				var editable = state === 'created';
				$grid.gfn_setColDisabled(['ITEMCD'], editable);
			}
		};
	});
}


function grid3_Load() {
	var gid = 'grid3', $grid = $('#' + gid);
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:120},
		{name:'ORGCD',header:{text:'셀러코드'},width:180},
		{name:'ORGNM',header:{text:'셀러명'},width:100},	
		{name:'PROD_CD',header:{text:'복합코드'},width:300},
		{name:'PROD_NM',header:{text:'복합명'},width:120},
		{name:'ITEMCD',header:{text:'단품코드'},width:150},
		{name:'NAME',header:{text:'단품명'},width:100},
		{name:'SPROD_QTY',header:{text:'수량'},width:100}
		
	];
	$grid.gfn_createGrid(columns);
	
}


//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
		$('#grid3').gfn_setDataList(data.resultExcelList);
	}
	//디테일 검색
	else if (sid === 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//저장
	else if (sid === 'sid_setSave') {
		var resultData = data.resultData;

		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','ORGCD','PROD_CD']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//취소
	if(sid == 'sid_setDelete') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','ORGCD','PROD_CD']);
		
		cfn_msg('INFO', '삭제 되었습니다.');
		cfn_retrieve();
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	$('#grid1').gridView().cancel();
	$('#grid2').gridView().cancel();
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000026/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

//상세리스트 검색
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p000/p000026/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

//공통버튼 - 신규
function cfn_new(){
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
		COMPCD:cfn_loginInfo().COMPCD
		, ORGCD:cfn_loginInfo().ORGCD
		, ORGNM:cfn_loginInfo().ORGNM
		, /* MAX_CLGO_QTY:'0', */
	});
}

//공통버튼 - 삭제 클릭
function cfn_del(){
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 복합품목이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	var state = $('#grid1').dataProvider().getRowState(rowidx);
	if (state === 'created') {
		$('#grid1').gfn_delRow(rowidx);
		$('#grid2').dataProvider().clearRows();
		return false;
	}
	
	if (confirm('복합코드[' + masterData.PROD_CD + '] 항목을 삭제하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000026/setDelete.do';		
		var sendData = {'paramData':masterData};

		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 저장 클릭
function cfn_save(directmsg) {
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 복합품목이 없습니다.');
		return false;
	}
	
	//마스터 필수입력 체크
	if ($('#grid1').gfn_checkValidateCells([rowidx])) return false;
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	var detailData = $('#grid2').gfn_getDataList();
	if (detailData.length < 1) {
		cfn_msg('WARNING', '구성품 상세내역이 없습니다.');
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
		var url = '/alexcloud/p000/p000026/setSave.do';
		var sendData = {'mGridData':masterData,'dGridData':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//그리드1 행추가 버튼 클릭
function fn_grid2AddRow() {
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택한 복합코드가 없습니다.');
		
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	if (cfn_isEmpty(masterData.ORGCD)) {
		cfn_msg('WARNING', '셀러를 입력해주세요.');
		return false;
	}
	
	var rowData = $('#grid1').gfn_getDataRow(rowidx);
	$('#grid2').gfn_addRow({
		COMPCD:rowData.COMPCD
		, ORGCD:rowData.ORGCD
		, ORGNM:rowData.ORGNM
		, PROD_CD:rowData.PROD_CD
	});
}	

//그리드1 행삭제 버튼 클릭
function fn_grid2DelRow() {
	var rowidx = $('#grid2').gfn_getCurRowIdx();

	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	$('#grid2').gfn_delRow(rowidx);
}


function cfn_exceldown(){
	var gridData = $('#grid3').gfn_getDataList();
	
	if(cfn_isEmpty(gridData)){
		cfn_msg('WARNING', '검색후 이용해주시기바랍니다.');
		return false;
	}
	gfn_excelExport('grid3'); 
}
</script>

<c:import url="/comm/contentBottom.do" />