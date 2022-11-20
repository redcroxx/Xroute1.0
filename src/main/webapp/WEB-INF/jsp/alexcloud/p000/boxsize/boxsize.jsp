<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : boxsize
	화면명    : 박스관리
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
				<div>박스코드/명</div>
				<div>
					<input type="text" id="S_BOX" class="cmc_txt" />
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">박스리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<button type="button" id="btn_grid1Add" class="cmb_plus" onclick="fn_grid1AddRow()"></button>
			<button type="button" id="btn_grid1Del" class="cmb_minus" onclick="fn_grid1DelRow()"></button>
		</div>		
	</div>
	<div id="grid1"></div>
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
	authority_Load();
	
	//셀러
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD', S_COMPNM:'S_COMPNM', S_ORGCD:'S_ORGCD'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	if($('#S_ORGCD').val().length > 0){
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}
});

function authority_Load(){
	
	if(cfn_loginInfo().USERGROUP = '${SELLER_ADMIN}'){
		$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
		$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}else if(cfn_loginInfo().USERGROUP = '${SELLER_SUPER}'){
		$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
		$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}else if(cfn_loginInfo().USERGROUP = '${SELLER_USER}'){
		$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
		$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}
};

function grid1_Load() {
	var gid = 'grid1', $grid = $('#' + gid);
	var columns = [
		{name:'ORGCD',header:{text:'셀러코드'},width:100,formatter:'popup',editable:true,required:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP002/view.do',
				inparam:{S_COMPCD:'COMPCD',S_COMPNM:'COMPNM',S_ORGCD:'ORGCD'},outparam:{ORGCD:'ORGCD',NAME:'ORGNM'}}
		},
		{name:'ORGNM',header:{text:'셀러명'},width:100},
		{name:'VOL_SEQ',header:{text:'박스번호'},width:120,editable:true,required:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:10,type:"number",positiveOnly:true}},
		{name:'BOX_ID',header:{text:'박스ID'},width:120,editable:true,required:true,editor:{maxLength:20}},
		{name:'BOX_NM',header:{text:'박스명'},width:180,editable:true,required:true,editor:{maxLength:100}},
		{name:'BOX_SIZE_W',header:{text:'가로(mm)'},width:80,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11,type:"number",positiveOnly:true}	},
		{name:'BOX_SIZE_B',header:{text:'세로(mm)'},width:80,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11,type:"number",positiveOnly:true}	},
		{name:'BOX_SIZE_H',header:{text:'높이(mm)'},width:80,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11,type:"number",positiveOnly:true}	},
		{name:'BOX_VOL',header:{text:'체적'},width:80,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11,type:"number",positiveOnly:true}	},
		{name:'END_DATE',header:{text:'종료일'},width:120,formatter:'date',styles:{textAlignment:'center'},editable:true},
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:120,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},visible:false,show:false},
	];
	$grid.gfn_createGrid(columns, {footerflg:false});
	
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var state = dataProvider.getRowState(newRowIdx);
				var rowData = $grid.gfn_getDataRow(newRowIdx);
				
				var editable = state === 'created';
				$grid.gfn_setColDisabled(['ORGCD', 'BOX_ID'], editable);
				
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#' + gid).gfn_setColDisabled(['ORGCD'], false);
				}
			}
		};
		
		//셀 수정 이벤트
		gridView.onEditChange = function(grid, column, value) {
			if (column.column === 'BOX_SIZE_W' || column.column === 'BOX_SIZE_B' || column.column === 'BOX_SIZE_H') {
				var BOX_SIZE_W = (column.column === 'BOX_SIZE_W') ? value : $('#' + gid).gfn_getValue(column.dataRow, 'BOX_SIZE_W') ;
				var BOX_SIZE_B = (column.column === 'BOX_SIZE_B') ? value : $('#' + gid).gfn_getValue(column.dataRow, 'BOX_SIZE_B');
				var BOX_SIZE_H = (column.column === 'BOX_SIZE_H') ? value : $('#' + gid).gfn_getValue(column.dataRow, 'BOX_SIZE_H');
				$('#' + gid).gfn_setValue(column.dataRow, 'BOX_VOL', BOX_SIZE_W * BOX_SIZE_B * BOX_SIZE_H);
			}
		};
	});
}

//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		var gridData = data.resultList;
		$('#grid1').gfn_setDataList(gridData);
		$('#grid1').gfn_focusPK();
	}
	//저장
	else if (sid === 'sid_setSave') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD', 'ORGCD', 'BOX_ID']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//삭제 (사용/미사용)
	else if (sid === 'sid_setDelete') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD', 'ORGCD', 'BOX_ID']);
		cfn_msg('INFO', '정상적으로 처리되었습니다.');
		cfn_retrieve();
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	
	$('#grid1').gridView().cancel();
	
	//검색조건 필수입력 체크
	//if(cfn_isFormRequireData('frmSearch') == false) return;
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/boxsize/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

//공통버튼 - 저장 클릭
function cfn_save() {
	$('#grid1').gridView().commit(true);
	
	var $grid1 = $('#grid1');
	var masterList = $grid1.gfn_getDataList(false);
	
	if (masterList.length < 1) {
		cfn_msg('WARNING', '변경된 항목이 없습니다.');
		return false;
	}
	
	//변경RowIndex 추출
	var states = $grid1.dataProvider().getAllStateRows();
	var stateRowidxs = states.updated;
	stateRowidxs = stateRowidxs.concat(states.created);
	
	//필수입력 체크
	if ($grid1.gfn_checkValidateCells(stateRowidxs)) return false;
	
	if (confirm('저장하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/boxsize/setSave.do';
		var sendData = {'mGridList':masterList};
		
		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 삭제 (사용/미사용) 클릭
function cfn_del() {
	$('#grid1').gridView().commit(true);
	
	var $grid1 = $('#grid1');
	var rowidx = $grid1.gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 항목이 없습니다.');
		return false;
	}
	
	var state = $grid1.dataProvider().getRowState(rowidx);
	
	if (state === 'created') {
		cfn_msg('WARNING', '신규 항목은 불가능 합니다.');
		return false;
	}
	
	var rowData = $grid1.gfn_getDataRow(rowidx);
	
	if (confirm('박스ID [' + rowData.BOX_ID + ']을 삭제 하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/boxsize/setDelete.do';
		var sendData = {'paramData':rowData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//그리드1 행추가 버튼 클릭
function fn_grid1AddRow() {
	$('#grid1').gfn_addRow({
		COMPCD:cfn_loginInfo().COMPCD
		, COMPNM:cfn_loginInfo().COMPNM
		, ORGCD:cfn_loginInfo().ORGCD
		, ORGNM:cfn_loginInfo().ORGNM
	});
}

//그리드1 행삭제 버튼 클릭
function fn_grid1DelRow() {
	var $grid1 = $('#grid1');
	var rowidx = $grid1.gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 항목이 없습니다.');
		return false;
	}
	
	var state = $grid1.dataProvider().getRowState(rowidx);
	
	if (state === 'created') {
		$grid1.gfn_delRow(rowidx);
	} else {
		cfn_msg('WARNING', '기등록 항목은 삭제할 수 없습니다.');
	}
}
</script>

<c:import url="/comm/contentBottom.do" />