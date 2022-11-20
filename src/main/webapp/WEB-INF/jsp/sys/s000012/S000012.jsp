<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : S000012
	화면명    : 마이메뉴-- RealGrid 마스터 디테일 그리드 2개 패턴
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" disabled="disabled"/>				
	<ul class="sech_ul">
		<li class="sech_li">
			<div>대메뉴명</div>
			<div>
				<input type="text" id="S_L1TITLE" class="cmc_txt" />
			</div>
		</li>
		<li class="sech_li">
			<div>중메뉴명</div>
			<div>
				<input type="text" id="S_L2TITLE" class="cmc_txt" />
			</div>
		</li>
		<li class="sech_li">
			<div>소메뉴명</div>
			<div>
				<input type="text" id="S_L3TITLE" class="cmc_txt" />
			</div>
		</li>
	</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<!-- <div class="ct_left_wrap fix" style="width:550px"> -->
<div style="float:left;width:calc(50% - 42px);height:calc(100% - 50px);">
	<div class="grid_top_wrap">
		<div class="grid_top_left">전체 메뉴<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->
<div style="float:left;display:table;width:80px;height:calc(100% - 50px);">
	<div style="display:table-cell;text-align:center;vertical-align:middle;">
		<input type="button" id="btn_rowAdd" value="&gt;" style="width:35px;height:25px;" onclick="btn_detailAdd_onClick()"/>
	    <div class="emptyH15"></div>
		<input type="button" id="btn_rowDel" value="&lt;" style="width:35px;height:25px;" onclick="btn_detailDel_onClick()" />
	</div>
</div>
<!-- 그리드 시작 -->
<div style="float:left;width:calc(50% - 42px);height:calc(100% - 50px);">
	<div class="grid_top_wrap">
		<div class="grid_top_left">마이 메뉴<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid2"></div>
<!-- </div> -->
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
	
	grid1_Load();
	grid2_Load();
	cfn_retrieve();
	fn_getDetailList();	
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:120,visible:false},
		{name:'L1TITLE',header:{text:'대메뉴명'},width:100},
		{name:'L2TITLE',header:{text:'중메뉴명'},width:100},
		{name:'L3TITLE',header:{text:'소메뉴명'},width:100},
		{name:'APPKEY',header:{text:'프로그램키'},width:100},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true,footerflg:false});
	
	
	
	//그리드설정 및 이벤트처리
	/* $('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
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
				var editable = $('#' + gid).gfn_getValue(newRowIdx, 'EDITABLE') === 'Y';
				
				$('#' + gid).gfn_setColDisabled(['NAME', 'REMARK'], editable);
				$('#grid2').gfn_setColDisabled(['CODE', 'SNAME1', 'SNAME2', 'SNAME3', 'SNAME4', 'SNAME5', 'SORTNO', 'REMARK'], editable);
				if(editable){
					$('#btn_detailAdd').show();
					$('#btn_detailDel').show();
				} else {
					$('#btn_detailAdd').hide();
					$('#btn_detailDel').hide();
				}
				var state = dataProvider.getRowState(newRowIdx);
				if(state === 'created'){
					$('#' + gid).gfn_setColDisabled(['CODEKEY'], true);
				} else {
					$('#' + gid).gfn_setColDisabled(['CODEKEY'], false);
				}
			} 
			
			 var compcd = $('#' + gid).gfn_getValue(newRowIdx, 'COMPCD');
			var codekey = $('#' + gid).gfn_getValue(newRowIdx, 'CODEKEY');
			if(!cfn_isEmpty(codekey)) {
				var param = {'COMPCD':compcd, 'CODEKEY':codekey};
				fn_getDetailList(param);
			} 
			
		};
	}); */
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'L1TITLE',header:{text:'대메뉴명'},width:100},
		{name:'L2TITLE',header:{text:'중메뉴명'},width:100,editable:true,required:true},
		{name:'L3TITLE',header:{text:'소메뉴명'},width:100},
		{name:'APPKEY',header:{text:'프로그램키'},width:100},
		{name:'SORTNO',header:{text:'정렬순서'},width:100,editable:true},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true,footerflg:false});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var state = dataProvider.getRowState(newRowIdx);
				if(state === 'created'){
					$('#' + gid).gfn_setColDisabled(['CODE'], true);
				} else {
					$('#' + gid).gfn_setColDisabled(['CODE'], false);
				}
			}
		};
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		//$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
		
		//검색결과에 따른 마스터 데이터 포커스 이동 처리 (저장처리 이후 발생 gfn_setFocusPK함수 처리)
		//$('#grid1').gfn_focusPK();
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//저장
	if(sid == 'sid_setSave') {
		//var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		//$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','CODEKEY']);
		
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
		fn_getDetailList();
	}
	if(sid == 'sid_setDelete'){
		cfn_msg('INFO', '정상적으로 삭제되었습니다.');
		cfn_retrieve();
		fn_getDetailList();
	}

}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/sys/s000012/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 마이메뉴 리스트 검색 */
function fn_getDetailList() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getDetailList';
	var url = '/sys/s000012/getDetailList.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}


/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var detailData = $('#grid2').gfn_getDataList();//마이메뉴 데이터
	
	//필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;
	
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}
	
	if (flg) {
		var sid = 'sid_setSave';
		var url = '/sys/s000012/setSave.do';
		var sendData = {'paramData':gv_searchData,'dGridData':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

function cfn_del(){
	var checkRows = []; //선택한 열 idx을 담을 변수
	checkRows = $('#grid2').gridView().getCheckedRows();  
	var rowData = []; //선택한 데이터를 담을 변수
}


//디테일 그리드 추가 버튼 이벤트
function btn_detailAdd_onClick() {
	var checkRows = $('#grid1').gridView().getCheckedRows(); //선택한 열 idx을 담을 변수
	
	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택된 항목이 없습니다.');
		return false;
	}
	
	var rowData = $('#grid1').gfn_getDataRows(checkRows); //선택한 데이터를 담을 변수
	
	for (var i=0, len=checkRows.length; i<len; i++) {
		$('#grid2').gfn_addRow(rowData[i]);
	}

	for (var i=checkRows.length-1; i>=0; i--) {
		  $('#grid1').gfn_delRow(checkRows[i]);
	}
	
	cfn_save('Y');
}  

//디테일 그리드 삭제 버튼 이벤트
function btn_detailDel_onClick() {
	var checkRows = checkRows = $('#grid2').gridView().getCheckedRows(); //선택한 열 idx을 담을 변수

	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택한 마이메뉴가 없습니다.');
		return false;
	}
	
	for (var i=checkRows.length-1; i>=0; i--) {
		  $('#grid2').gfn_delRow(checkRows[i]);
	}
	
	cfn_save('Y');
} 



</script>

<c:import url="/comm/contentBottom.do" />