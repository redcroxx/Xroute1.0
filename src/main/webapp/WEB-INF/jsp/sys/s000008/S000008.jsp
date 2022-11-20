<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : S000008
	화면명    : 중/소메뉴
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<ul class="sech_ul">
			<li class="sech_li">
				<div>회사</div>
				<div>	
					<input type="text" id="S_COMPCD" class="cmc_code" readonly="readonly" disabled /> 
					<input type="text" id="S_COMPNM" class="cmc_value" readonly="readonly" disabled />
					<button type="button" class="cmc_cdsearch disabled" disabled></button>
				</div>
			</li>
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
		</ul>
	</form>
</div>
<!-- 검색조건 끝 -->

<div class="ct_left_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">대메뉴 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
</div>

<div class="ct_center_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">중메뉴 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid2"></div>
</div>

<div class="ct_right_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">소메뉴 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<button type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid3RowAdd()"></button>
			<button type="button" id="btn_rowDel" class="cmb_minus" onclick="fn_grid3RowDel()"></button>
		
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
	
	//화면레이아웃 지정
	initLayout();
	
	//로그인 정보로 초기화
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	
	/* 공통코드 코드/명 (회사) */
	pfn_codeval({
		url:'/alexcloud/popup/popP001/view.do',codeid:'S_COMPCD',
		inparam:{S_COMPCD:'S_COMPCD,S_COMPNM'},
		outparam:{COMPCD:'S_COMPCD',NAME:'S_COMPNM'}
	});
	
	//3.그리드 초기화
	grid1_Load();
	grid2_Load();
	grid3_Load();
	
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'MENUL1KEY',header:{text:'대메뉴코드'},width:140},
		{name:'L1TITLE',header:{text:'대메뉴명'},width:130},
		{name:'SORTNO',header:{text:'정렬순'},width:100,styles:{textAlignment:'far'}},
		{name:'REMARKS',header:{text:'비고'},width:250},
		{name:'ADDUSERCD',header:{text:'등록자ID'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자ID'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:200,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,styles:{textAlignment:'center'},visible:false}
    ];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false}); 
	
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//열고정 설정
		gridView.setFixedOptions({colCount:2,resizable:true,colBarWidth:1});
	});	
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var param = {
					'COMPCD' : $('#S_COMPCD').val(),
					'S_L2TITLE': $('#S_L2TITLE').val(),
					'MENUL1KEY': $('#' + gid).gfn_getValue(newRowIdx, 'MENUL1KEY')
				}
				fn_getMstList(param);
			}
		};
		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			if(oldIndex.dataRow !== -1 && oldIndex.dataRow !== newIndex.dataRow){
				var grid2Data = $('#grid2').gfn_getDataList(false); 
				var grid3Data = $('#grid3').gfn_getDataList(false); 
				
				if ( grid2Data.length > 0 || grid3Data.length > 0){
					if(confirm('변경된 내용이 있습니다. 저장하시겠습니까?')){
						cfn_save('Y');
					}
					return false;
				}
			}
		}
	});
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'MENUL2KEY',header:{text:'중메뉴코드(숫자만)'},width:140,required:true,editable:true,editor:{maxLength:10,type:"number",positiveOnly:true}},
		{name:'L2TITLE',header:{text:'중메뉴명'},width:130,required:true,editable:true,formatter:'select',editor:{maxLength:50}},
		{name:'SORTNO',header:{text:'정렬순(숫자만)'},width:100,required:true,editable:true,styles:{textAlignment:'far'},editor:{maxLength:10,type:"number",positiveOnly:true}},
		{name:'REMARKS',header:{text:'비고'},width:250,editable:true,editor:{maxLength:200}},
		{name:'ADDUSERCD',header:{text:'등록자ID'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자ID'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:200,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,styles:{textAlignment:'center'},visible:false},
		{name:'MENUL1KEY',header:{text:'대메뉴코드'},width:100,styles:{textAlignment:'center'},visible:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//열고정 설정
		gridView.setFixedOptions({colCount:2,resizable:true,colBarWidth:1});
	});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {

				var  state= $('#' + gid).dataProvider().getRowState(newRowIdx) === 'created'
				$('#' + gid).gfn_setColDisabled(['MENUL2KEY'], state);				
				
				var param = {
						'COMPCD' : $('#S_COMPCD').val(),
						'MENUL1KEY': $('#' + gid).gfn_getValue(newRowIdx, 'MENUL1KEY'), 
						'MENUL2KEY': $('#' + gid).gfn_getValue(newRowIdx, 'MENUL2KEY')
						}
			fn_getDetailList(param);
			}
		};
 		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			if(oldIndex.dataRow !== -1 && oldIndex.dataRow !== newIndex.dataRow){
				var grid3Data = $('#grid3').gfn_getDataList(false);
				var state = dataProvider.getRowState(oldIndex.dataRow);
				
				if(state ==='updated' || state === 'created' || grid3Data.length > 0){
					if(confirm('변경된 내용이 있습니다. 저장하시겠습니까?')){
						cfn_save('Y');
					}else{
						return false;
					}	
				}
			}
		};
	});
}

function grid3_Load() {
	
	var gid = 'grid3';
	var columns = [
		{name:'APPKEY',header:{text:'프로그램코드'},width:140,required:true,editable:true,formatter:'popup',
 			popupOption:{url:'/alexcloud/popup/popS005/view.do',
						inparam:{S_APPITEM : 'APPKEY'},
						outparam:{APPKEY : 'APPKEY', APPNM : 'L3TITLE'},
						returnFn: function(data, type) {
							var rowidx = $('#' + gid).gfn_getCurRowIdx();
							var rowidx2 = $('#grid2').gfn_getCurRowIdx();
							for (var i=0; i<data.length; i++) {
								if (i === 0) {
									$('#' + gid).gfn_setValue(rowidx, 'APPKEY', data[i].APPKEY);
									$('#' + gid).gfn_setValue(rowidx, 'L3TITLE', data[i].APPNM);
									$('#' + gid).gfn_setValue(rowidx, 'COMPCD',$('#grid2').gfn_getValue(rowidx2,'COMPCD'));
									$('#' + gid).gfn_setValue(rowidx, 'MENUL1KEY', $('#grid2').gfn_getValue(rowidx2, 'MENUL1KEY'));
									$('#' + gid).gfn_setValue(rowidx, 'MENUL2KEY', $('#grid2').gfn_getValue(rowidx2, 'MENUL2KEY'));
									
								}else {
									$('#' + gid).gfn_addRow({
										APPKEY : data[i].APPKEY,
										L3TITLE: data[i].APPNM,
										COMPCD : $('#grid2').gfn_getValue(rowidx2,'COMPCD'),
										MENUL1KEY : $('#grid2').gfn_getValue(rowidx2, 'MENUL1KEY'),
										MENUL2KEY : $('#grid2').gfn_getValue(rowidx2, 'MENUL2KEY')
									});
								}
							}
						}
			} 		
		},
		{name:'L3TITLE',header:{text:'소메뉴명'},width:130,editable:true,required:true,formatter:'select'},
		{name:'SORTNO',header:{text:'정렬순(숫자만)'},width:100,required:true,editable:true,styles:{textAlignment:'far'},editor:{maxLength:10,type:"number",positiveOnly:true}},
		{name:'REMARKS',header:{text:'비고'},width:250,editable:true,editor:{maxLength:200}},
		{name:'ADDUSERCD',header:{text:'등록자ID'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자ID'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,styles:{textAlignment:'center'},visible:false},
		{name:'MENUL1KEY',header:{text:'대메뉴코드'},width:100,styles:{textAlignment:'center'},visible:false},
		{name:'MENUL2KEY',header:{text:'중메뉴코드'},width:120,styles:{textAlignment:'center'},visible:false},
		{name:'REALAPPKEY',header:{text:'프로그램코드'},width:140,visible:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//열고정 설정
		gridView.setFixedOptions({colCount:2,resizable:true,colBarWidth:1});
	});
	
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {

	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').gridView().commit();	
		$('#grid3').gridView().commit();
		$('#grid3').dataProvider().clearRows();
		$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	//마스터(중메뉴) 리스트 검색
	else if (sid == 'sid_getMstList') {		
		$('#grid3').dataProvider().clearRows();
		$('#grid2').gfn_setDataList(data.resultList);
		$('#grid2').gfn_focusPK();
	}
	//디테일(소메뉴) 리스트 검색
	else if (sid == 'sid_getDetailList') {
		$('#grid3').gfn_setDataList(data.resultList);
		$('#grid3').gfn_focusPK();
	}
	//마스터 & 디테일 저장
	else if (sid == 'sid_setSave') {
		
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		
		//중메뉴 PK
		$('#grid2').gfn_setFocusPK(data.resultData, ['MENUL1KEY','MENUL2KEY']);
		//소메뉴 PK
		$('#grid3').gfn_setFocusPK(data.resultData, ['MENUL1KEY','MENUL2KEY','APPKEY']);
		fn_getMstList(data.resultData);
		
	}
	//마스터 삭제
	else if (sid == 'sid_setDelete'){
		
		cfn_msg('INFO','정상적으로 삭제 되었습니다.');
		
		$('#grid2').gfn_setFocusPK(data.resultData, ['MENUL1KEY','MENUL2KEY','COMPCD']);
		fn_getMstList(data.resultData);
	}
	
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	
	//대메뉴 검색
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/sys/s000008/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 마스터(중메뉴) 검색 */
function fn_getMstList(param) {
	
	var sid = 'sid_getMstList';
	var url = '/sys/s000008/getMstList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);	
}

/* 디테일 디테일(소메뉴) 검색 */
function fn_getDetailList(param) {
	
	var sid = 'sid_getDetailList';
	var url = '/sys/s000008/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}


/* 공통버튼 - 신규 클릭 */
function cfn_new() {

	var rowidx1 = $('#grid1').gfn_getCurRowIdx();
	var rowidx2 = $('#grid2').gfn_getCurRowIdx();	
	var gridData = $('#grid1').gfn_getDataList(false);

	
	if(rowidx1 < 0){
		cfn_msg('WARNING','선택된 항목이 없습니다..');
		return false;
	}
	
	if(rowidx2 >=0){
		var state = $('#grid2').dataProvider().getRowState(rowidx2);
		if( state === 'created' || state === 'updated') {
			cfn_msg('INFO','신규 입력 상태입니다.');
			return false; 
		}
	}

	
	$('#grid3').dataProvider().clearRows();
	
	$('#grid2').gfn_addRow({
		   'COMPCD': $('#grid1').gfn_getValue(rowidx1,'COMPCD'),
		'MENUL1KEY': $('#grid1').gfn_getValue(rowidx1, 'MENUL1KEY')
	});
	
}

/* 공통버튼 - 삭제 클릭 */
function cfn_del() {
	
	var rowidx2 = $('#grid2').gfn_getCurRowIdx();
	
	//검색 안하고 삭제  눌렀을 경우
	if (rowidx2 < 0) {
		cfn_msg('WARNING', '선택된 항목이 없습니다.');
		return false;
	}
	
	//소메뉴에서 삭제 눌렀을 경우
	var rowidx3 = $('#grid3').gfn_getCurRowIdx();
	
	if(rowidx3 > 0){
		cfn_msg('WARNING','소메뉴 삭제는 (-)아이콘을 이용해주세요.');
		return false;
	}
	
	//신규행 삭제
 	var state = $('#grid2').dataProvider().getRowState(rowidx2);
 	
 	if(state === 'created'){
 		$('#grid2').gfn_delRow(rowidx2);
 		return false;
 	}
 	
 	//기등록행 삭제
	var masterData = $('#grid2').gfn_getDataRow(rowidx2);
	
	if (confirm('중메뉴코드[' + masterData.MENUL2KEY + '] 항목을 삭제하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/sys/s000008/setDelete.do';
		var sendData = {'paramData':masterData};
		
		gfn_sendData(sid, url, sendData);			
	}
	
}

/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {
	
	var rowidx2 = $('#grid2').gfn_getCurRowIdx();
	
	//검색 안하고 저장 눌렀을 경우
	if (rowidx2 < 0) {
		cfn_msg('WARNING', '저장할 내역이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid2').gfn_getDataRow(rowidx2);
	var detailDataList = $('#grid3').gfn_getDataList(false);
	
	//중메뉴 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells([rowidx2])) return false;
	
	var rowidx3 = $('#grid3').gfn_getCurRowIdx();
	//소메뉴 필수입력 체크
	if (rowidx3 > -1 ){
		if ($('#grid3').gfn_checkValidateCells([rowidx3])) return false;
	}
	
 	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}

	if (flg) {
			var sid = 'sid_setSave';
			var url = '/sys/s000008/setSave.do';
			var sendData = {'mGridData':masterData,'dGridDataList':detailDataList};
			
			gfn_sendData(sid, url, sendData);
	}  
}



//소메뉴 행추가 ICON 버튼 클릭
function fn_grid3RowAdd() {
	
	var rowidx = $('#grid2').gfn_getCurRowIdx();
	
	//검색 안하고 행 추가 경우
	if(rowidx < 0){
		cfn_msg('WARNING','선택된 중메뉴가 없습니다.');
		return false;
	}
	
	$('#grid3').gfn_addRow({
		'COMPCD': $('#grid2').gfn_getValue(rowidx,'COMPCD'),
		'MENUL1KEY': $('#grid2').gfn_getValue(rowidx, 'MENUL1KEY'),
		'MENUL2KEY': $('#grid2').gfn_getValue(rowidx, 'MENUL2KEY')
	});
}

//소메뉴 행삭제 ICON 버튼 클릭
function fn_grid3RowDel() {
	
	var rowidx = $('#grid3').gfn_getCurRowIdx();
	
	//검색 안하고 행 삭제 경우
	if(rowidx < 0){
		cfn_msg('WARNING', '선택된 소메뉴가 없습니다.');
		return false;
	}
	
	var state = $('#grid3').dataProvider().getRowState(rowidx);
	
	//신규행 삭제 
	if(state === 'created') {
		$('#grid3').gfn_delRow(rowidx);
		return;
	}
	
	var detailData = $('#grid3').gfn_getDataRow(rowidx);

 	if(confirm('소메뉴[' + detailData.L3TITLE + '] 항목을 삭제하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/sys/s000008/setDelete2.do';
		var sendData = {'paramData' : detailData};
		
		gfn_sendData(sid, url, sendData);
	} 
}
</script>

<c:import url="/comm/contentBottom.do" />