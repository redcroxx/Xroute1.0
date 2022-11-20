<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000027
	화면명    : 매입처별 품목관리
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="S_COMPCD" /> 
		<input type="hidden" id="S_COMPNM" /> 
		<ul class="sech_ul">
			<li class="sech_li required">
				<div>화주</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code required" />
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li">
				<div>매입처</div>
				<div>
					<input type="text" id="S_CUSTCD" class="cmc_code" />
					<input type="text" id="S_CUSTNM" class="cmc_value" />
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
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_left_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">매입처 목록 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>		
	</div>
	<div id="grid1"></div>
</div>
<div class="ct_center_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">매입처 품목 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<button type="button" id="btn_grid2Del" class="cmb_minus" onclick="fn_grid2DelRow()"></button>
		</div>		
	</div>
	<div id="grid2"></div>
</div>
<div class="ct_right_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">매입처 미지정 품목 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<button type="button" id="btn_grid2Add" class="cmb_plus" onclick="fn_grid3AddRow()"></button>
		</div>		
	</div>
	<div id="grid3"></div>
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
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	
	grid1_Load();
	grid2_Load();
	grid3_Load(); 
	
	//화주
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD', S_COMPNM:'S_COMPNM', S_ORGCD:'S_ORGCD'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	/* 거래처 */
	pfn_codeval({
		url:'/alexcloud/popup/popP003/view.do',codeid:'S_CUSTCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD',S_ORGNM:'S_ORGNM',S_CUSTCD:'S_CUSTCD,S_CUSTNM'},
		outparam:{CUSTCD:'S_CUSTCD',NAME:'S_CUSTNM'},
		params:{CODEKEY:'ISSHIPPER'}
	});	 

	if( $('#S_ORGCD').val().length > 0) {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}		
});

function grid1_Load() {
	var gid = 'grid1', $grid = $('#' + gid);
	var columns = [
		{name:'CUSTCD',header:{text:'매입처코드'},width:100},
		{name:'CUSTNM',header:{text:'매입처명'},width:150},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'ORGCD',header:{text:'화주코드'},width:100,visible:false},
	];
	$grid.gfn_createGrid(columns, {footerflg:false});
	
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			
			if (newRowIdx > -1) {
				var state = dataProvider.getRowState(newRowIdx);
				var editable = state === 'created';
				$grid.gfn_setColDisabled(['CUSTCD','CUSTNM'], editable);

				var rowData = dataProvider.getJsonRow(newRowIdx);
				rowData.S_ITEM = $('#S_ITEM').val();
				rowData.S_CUSTCD = $('#S_CUSTCD').val();
				
				if (!cfn_isEmpty(rowData.CUSTCD)) {
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
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'NAME',header:{text:'품목명'},width:195},
		{name:'ITEMCAT1NM',header:{text:'대분류'},width:70},
		{name:'ITEMCAT2NM',header:{text:'중분류'},width:70},
		{name:'ITEMCAT3NM',header:{text:'소분류'},width:70},
		
	];
	$grid.gfn_createGrid(columns,{footerflg:false,mstGrid:'grid1'});
}

function grid3_Load() {
	var gid = 'grid3', $grid = $('#' + gid);
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'NAME',header:{text:'매입처명'},width:190},
		{name:'ITEMCAT1NM',header:{text:'대분류'},width:70},
		{name:'ITEMCAT2NM',header:{text:'중분류'},width:70},
		{name:'ITEMCAT3NM',header:{text:'소분류'},width:70},
	];
	$grid.gfn_createGrid(columns, {footerflg:false,checkBar:true});
}

//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
		if(data.resultList.length != 0){
			$('#grid3').gfn_setDataList(data.resultList2);
		} else{
			$('#grid3').dataProvider().clearRows();
		}
		$('#grid1').gfn_focusPK();
	}
	//디테일 검색
	else if (sid === 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//저장
	else if (sid === 'sid_setSave') {
		var resultData = data.resultData;

		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','CUSTNM']);
		cfn_msg('INFO', '정상적으로 품목이 저장되었습니다.');
		cfn_retrieve();
	}
	//취소
	if(sid == 'sid_setDelete') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','CUSTNM']);
		cfn_msg('INFO', '삭제 되었습니다.');
		cfn_retrieve();
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	if (!cfn_isFormRequireData('frmSearch')) return false;
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000027/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

//상세리스트 검색
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p000/p000027/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

//그리드2 행삭제 버튼 클릭
function fn_grid2DelRow(){
	var masterRowidx = $('#grid1').gfn_getCurRowIdx();
	var masterData = $('#grid1').gfn_getDataRow(masterRowidx);
	
	var gridRowidx = $('#grid2').gfn_getCurRowIdx()
	var gridData = $('#grid2').gfn_getDataRow(gridRowidx);
	
	if (gridRowidx < 0) {
		cfn_msg('WARNING', '선택된 품목이 없습니다.');
		return false;
	}
	
	if (confirm('해당 품목을 매입처 [' + masterData.CUSTNM + '] 에서 삭제하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000027/setDelete.do';		
		var sendData = {'mGridData':masterData,'dGridData':gridData};

		gfn_sendData(sid, url, sendData);
	}
}

//그리드3 행추가 버튼 클릭
function fn_grid3AddRow() {
	
	var masterRowidx = $('#grid1').gfn_getCurRowIdx();
	var masterData = $('#grid1').gfn_getDataRow(masterRowidx);
	
	var gridRowidx = $('#grid1').gfn_getCurRowIdx();
	var checkRows = $('#grid3').gridView().getCheckedRows();
	var gridData = $('#grid3').gfn_getDataRows(checkRows);
	
	var flg = true;
	
	if (gridRowidx < 0) {
		cfn_msg('WARNING', '추가할 품목이 없습니다.');
		
		return false;
	}
	
	if(cfn_isEmpty(checkRows)) {
		cfn_msg('WARNING','선택된 품목이 없습니다.');
		return false;
	}
	
	if (confirm('매입처 [' + masterData.CUSTNM + ']로 품목을 지정 하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/p000027/setSave.do';
		var sendData = {'mGridData':masterData,'dGridData':gridData};
		
		gfn_sendData(sid, url, sendData);
	}
}	
</script>

<c:import url="/comm/contentBottom.do" />