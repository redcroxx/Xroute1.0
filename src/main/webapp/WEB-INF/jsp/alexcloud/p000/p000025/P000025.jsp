<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000025
	화면명    : 대입품목관리
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="S_COMPCD" class="cmc_code" />
		<ul class="sech_ul">
			<li class="sech_li">
				<div>셀러</div>
				<div>
					<input type="text" id="S_ORGCD" name="S_ORGCD" class="cmc_code" />
					<input type="text" id="S_ORGNM" name="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li">
				<div>대입코드</div>
				<div>		
					<input type="text" id="S_MAP_PROD_CD" name="S_MAP_PROD_CD" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li">
				<div>대입된코드/명</div>
				<div>		
					<input type="text" id="S_PROD_CD" name="S_PROD_CD" class="cmc_txt" />
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_left_wrap fix" style="width:70%;">
	<div class="grid_top_wrap">
		<div class="grid_top_left">대입코드 목록<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="button" id="btn_upload" class="cmb_normal" value="업로드" onclick="pfn_upload('P000025');" />
			<input type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid1RowAdd()" />  
			<input type="button" id="btn_rowDel" class="cmb_minus" onclick="fn_grid1RowDel()" /> 
		</div>
	</div>
	<div id="grid1"></div>
</div>

<div class="ct_right_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">단품 정보<span>(총 0건)</span></div>
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

	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	
 	/* 셀러 */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
			
	if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
		$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
		$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	} 
 		
	grid1_Load();
	grid2_Load();
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'ORGCD',header:{text:'셀러코드'},width:80,editable:true,required:true,formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP002/view.do',
				 inparam:{S_ORGCD:'ORGCD',S_COMPCD:'COMPCD'},
				 outparam:{ORGCD:'ORGCD',NAME:'ORGNM'}}
		},
		{name:'ORGNM',header:{text:'셀러명'},width:100,styles:{textAlignment:'center'}},		
		{name:'MAP_PROD_CD',header:{text:'대입코드'},width:120,editable:true,required:true,editor:{maxLength:30},styles:{textAlignment:'center'}},
		{name:'PROD_CD',header:{text:'대입된코드'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},required:true,styles:{textAlignment:'center'},
			popupOption:{url:'/alexcloud/popup/popP025/view.do',
				inparam:{S_COMPCD:'COMPCD',S_ORGCD:'ORGCD',S_ORGNM:'ORGNM', S_PROD_CD:'PROD_CD'},
				outparam:{PROD_CD:'PROD_CD',PROD_NM:'PROD_NM',PROD_TYPE_CD:'PROD_TYPE_CD'}}
		},
		{name:'PROD_NM',header:{text:'대입된코드명'},width:300},
		{name:'PROD_TYPE_CD',header:{text:'구분'},width:80,formatter:'combo',comboValue:'${gCodePROD_TYPE_CD}',styles:{textAlignment:'center'}},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var editable = dataProvider.getRowState(newRowIdx) === 'created';
				
				$('#' + gid).gfn_setColDisabled(['ORGCD'], editable);
				$('#' + gid).gfn_setColDisabled(['MAP_PROD_CD'], editable);
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD) && (dataProvider.getRowState(newRowIdx) == 'created')) {
					$('#grid1').gfn_setColDisabled(['ORGCD'],false);
				}

				var orgcd = $('#' + gid).gfn_getValue(newRowIdx, 'ORGCD');
				
				if((editable == true) && (orgcd == '' || orgcd == null)){
					editable = false;
				} else{
					editable = true;
				}
				
				$('#' + gid).gfn_setColDisabled(['PROD_CD'], editable);
			}
			
			var prod_cd = $('#' + gid).gfn_getValue(newRowIdx, 'PROD_CD');
			var compcd = $('#' + gid).gfn_getValue(newRowIdx, 'COMPCD');
			
			if(!cfn_isEmpty(prod_cd) && (dataProvider.getRowState(newRowIdx) != 'created')) {
				var param = {'COMPCD':compcd, 'ORGCD':orgcd, 'PROD_CD':prod_cd};
				fn_getDetailList(param);
			}
		};
		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			var rowidx = $('#grid1').gfn_getCurRowIdx();
			if(rowidx > -1){
				var editable = true;
				var orgcd = $('#' + gid).gfn_getValue(rowidx, 'ORGCD');
				if((dataProvider.getRowState(rowidx) == 'created') && (orgcd == '' || orgcd == null)){
					editable = false;
				} else {
					editable = true;
				}
				$('#' + gid).gfn_setColDisabled(['PROD_CD'], editable);
			}
				
		};
		//셀 수정 완료 이벤트
		gridView.onCellEdited = function(grid, itemIdx, dataRow, fieldIdx) {
			if (dataProvider.getFieldName(fieldIdx) === 'ORGCD'){
				$('#' + gid).gfn_setValue(dataRow, 'PROD_CD', '');
				$('#' + gid).gfn_setValue(dataRow, 'PROD_NM', '');
				$('#' + gid).gfn_setValue(dataRow, 'PROD_TYPE_CD', '');
			}
		};
		//셀 값 변경시 이벤트
		dataProvider.onValueChanged = function (provider, row, field) {
			if (dataProvider.getFieldName(field) === 'ORGCD') {
				$('#' + gid).gfn_setValue(row, 'PROD_CD', '');
				$('#' + gid).gfn_setValue(row, 'PROD_NM', '');
				$('#' + gid).gfn_setValue(row, 'PROD_TYPE_CD', '');
			}			
		};
		
	});
}


function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'ITEMCD',header:{text:'단품코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:350},
		{name:'SPROD_QTY',header:{text:'수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'PROD_CD',header:{text:'마스터코드'},width:100,visible:false,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns);

}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid1').gridView().commit();
		var gridData = data.resultList;
		$('#grid1').gfn_setDataList(gridData);
		$('#grid2').gfn_clearData();		
		//검색결과에 따른 마스터 데이터 포커스 이동 처리
		$('#grid1').gfn_focusPK();
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//저장
	else if (sid === 'sid_setSave') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','ORGCD','MAP_PROD_CD']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//삭제
	else if (sid === 'sid_setDelete') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','ORGCD','MAP_PROD_CD']);
		cfn_msg('INFO', '정상적으로 처리되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('#grid1').gridView().commit();
	
	if (!cfn_isFormRequireData('frmSearch')) return false; //필수입력 체크
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000025/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}


/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p000/p000025/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}


/* 공통버튼 - 저장 클릭 */
function cfn_save() {
	$('#grid1').gridView().commit(true);
	
	var masterList = $('#grid1').gfn_getDataList(false);
	
	if (masterList.length < 1) {
		cfn_msg('WARNING', '변경된 항목이 없습니다.');
		return false;
	}
	
	//변경RowIndex 추출
	var states = $('#grid1').dataProvider().getAllStateRows();
	var stateRowidxs = states.updated;
	stateRowidxs = stateRowidxs.concat(states.created);
	
	//필수입력 체크
	if ($('#grid1').gfn_checkValidateCells(stateRowidxs)) return false;
	
	if (confirm('저장하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/p000025/setSave.do';
		var sendData = {'paramList':masterList};
		
		gfn_sendData(sid, url, sendData);
	}
}

/* 공통버튼 - 삭제 클릭 */
function cfn_del() {
	$('#grid1').gridView().commit();
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 항목이 없습니다.');
		return false;
	}
	
	var state = $('#grid1').dataProvider().getRowState(rowidx);
	var rowData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (state === 'created') {
		$('#grid1').gfn_delRow(rowidx);
	} else {
		if (confirm('삭제하시겠습니까?')) {
			var sid = 'sid_setDelete';
			var url = '/alexcloud/p000/p000025/setDelete.do';
			var sendData = {'paramData':rowData};

			gfn_sendData(sid, url, sendData);
		}		
	}
}

//그리드 행추가 버튼 클릭
function fn_grid1RowAdd() {
	$('#grid2').gfn_clearData();
	$('#grid1').gfn_addRow({
		COMPCD: cfn_loginInfo().COMPCD
		, ORGCD: cfn_loginInfo().ORGCD
		, ORGNM:	cfn_loginInfo().ORGNM
	});
	
}

//그리드 행삭제 버튼 클릭
function fn_grid1RowDel() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 항목이 없습니다.');
		return false;
	}
	
	var state = $('#grid1').dataProvider().getRowState(rowidx);
	
	if (state === 'created') {
		$('#grid1').gfn_delRow(rowidx);
	} else {
		cfn_msg('WARNING', '기등록 항목은 삭제할 수 없습니다.');
	}
}
</script>

<c:import url="/comm/contentBottom.do" />