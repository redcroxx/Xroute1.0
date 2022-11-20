<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : E000001
	화면명 : 업로드설정
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="S_COMPNM" class="cmc_code" />
	<ul class="sech_ul">
		<li class="sech_li">
			<div>프로그램 ID/명</div>
			<div>
				<input type="text" id="S_PGM" class="cmc_txt"/>
			</div>
		</li>
	</ul>
	</form>
</div>
<!-- 검색조건 끝 -->

<div class="ct_left_wrap fix" style="width:610px">
	<div class="grid_top_wrap">
		<div class="grid_top_left">등록정보<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<button type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid1RowAdd()"></button>
			<button type="button" id="btn_rowDel" class="cmb_minus" onclick="fn_grid1RowDel()"></button>
			
		</div>
	</div>
	<div id="grid1"></div>
</div>

<div class="ct_right_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">상세정보<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<button type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid2RowAdd()"></button>
			<button type="button" id="btn_rowDel" class="cmb_minus" onclick="fn_grid2RowDel()"></button>
		</div>
	</div>
	<div id="grid2">
	</div>
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
  	
	//3.그리드 초기화
	grid1_Load();
	grid2_Load();
  
});

//컬럼ID 채번순서
var colArr = ['COL_0A','COL_0B','COL_0C','COL_0D','COL_0E','COL_0F','COL_0G','COL_0H'
				,'COL_0I','COL_0J','COL_0K','COL_0L','COL_0M','COL_0N','COL_0O','COL_0P'
				,'COL_0Q','COL_0R','COL_0S','COL_0T','COL_0U','COL_0V','COL_0W','COL_0X'
				,'COL_0Y','COL_0Z','COL_AA','COL_AB','COL_AC','COL_AD','COL_AE','COL_AF'
				,'COL_AG','COL_AH','COL_AI','COL_AJ','COL_AK','COL_AL','COL_AM','COL_AN'
				,'COL_AO','COL_AP','COL_AQ','COL_AR','COL_AS','COL_AT','COL_AU','COL_AV'
				,'COL_AW','COL_AX','COL_AY','COL_AZ','COL_BA','COL_BB','COL_BC','COL_BD'
				,'COL_BE','COL_BF','COL_BG','COL_BH','COL_BI','COL_BJ','COL_BK','COL_BL'
				,'COL_BM','COL_BN','COL_BO','COL_BP','COL_BQ','COL_BR','COL_BS','COL_BT'
				,'COL_BU','COL_BV','COL_BW','COL_BX','COL_BY','COL_BZ','COL_CA','COL_CB'
				,'COL_CC','COL_CD','COL_CE','COL_CF','COL_CG','COL_CH','COL_CI','COL_CJ'
				,'COL_CK','COL_CL','COL_CM','COL_CN','COL_CO','COL_CP','COL_CQ','COL_CR'
				,'COL_CS','COL_CT','COL_CU','COL_CV','COL_CW','COL_CX','COL_CY','COL_CZ'];
				
function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'PGMID',header:{text:'프로그램ID'},width:90,editable:false,required:true},
		{name:'PGMNM',header:{text:'프로그램명'},width:130,editable:true},
		{name:'USEORGCD',header:{text:'셀러'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'USEWHCD',header:{text:'창고'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'URL',header:{text:'처리프로시저'},width:130,editable:true},
		{name:'REMARK',header:{text:'비고'},width:200,editable:true,editor:{type: 'multiline', maxLength:500}},
		{name:'ADDUSERCD',header:{text:'등록자'},width:120,styles:{textAlignment:'center'},visible:false},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'},visible:false},
		{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'},visible:false},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'},visible:false},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},visible:false},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});	
	
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {

			 	var  state= $('#' + gid).dataProvider().getRowState(newRowIdx) === 'created'
				$('#' + gid).gfn_setColDisabled(['PGMID'], state);	 		
			 	
				var pgmid = $('#' + gid).gfn_getValue(newRowIdx, 'PGMID');
				 	
				if(!cfn_isEmpty(pgmid)){
					var param = {'PGMID': pgmid}
					fn_getDetailList(param);
				}
			}
			 	
		};	
 		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			if(oldIndex.dataRow !== -1 && oldIndex.dataRow !== newIndex.dataRow){
				var grid2Data = $('#grid2').gfn_getDataList(false);
				var state = dataProvider.getRowState(oldIndex.dataRow);
				
				if(state ==='updated' || state === 'created' || grid2Data.length > 0){
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
function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'PGMID',header:{text:'프로그램ID'},width:90,required:true/*,visible:false*/},
		{name:'COL_ID',header:{text:'컬럼ID'},width:60,editable:false,styles:{textAlignment:'center'}},
		{name:'COL_NM',header:{text:'컬럼명'},width:120,editable:true},
		{name:'ISCHECK',header:{text:'필수여부'},width:100,formatter:'combo',comboValue:'${GCODE_YN}',styles:{textAlignment:'center'},
			editable:true,editor:{maxLength:1}
		},
		{name:'CHECKTYPE',header:{text:'체크유형'},width:180,editable:true,formatter:'combo',comboValue:'${GCODE_CHECKTYPE}',styles:{textAlignment:'center'}},
		{name:'CODEKEY',header:{text:'공통코드키'},width:130,editable:true},
		{name:'MAXLEN',header:{text:'최대길이'},width:80,editable:true,dataType:'number',styles:{textAlignment:'far'}},
		{name:'REF1',header:{text:'참조1'},width:130,editable:true},
		{name:'REF2',header:{text:'참조2'},width:130,editable:true},
		{name:'REF3',header:{text:'참조3'},width:130,editable:true},
		{name:'REF4',header:{text:'참조4'},width:130,editable:true},
		{name:'REF5',header:{text:'참조5'},width:130,editable:true},
		{name:'ADDUSERCD',header:{text:'등록자'},width:120,styles:{textAlignment:'center'},visible:false},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'},visible:false},
		{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'},visible:false},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'},visible:false},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},visible:false}/*,
		{name:'PGMID',header:{text:'프로그램ID'},width:90,visible:false},*/
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {sortable:false,footerflg:false,pasteflg:true});	
	
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//열고정 설정
		gridView.setFixedOptions({colCount:2,resizable:true,colBarWidth:1});
	});
}
/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//등록정보 검색
	if (sid == 'sid_getSearch') {
		$('#grid2').gridView().commit();
		$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	//상세정보 검색
	else if (sid == 'sid_getDetailList') {		
		$('#grid2').gfn_setDataList(data.resultList);
	}

	//저장
	else if (sid == 'sid_setSave') {
		$('#grid1').gfn_setFocusPK(data.resultData,['PGMID']);
		
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		
		cfn_retrieve();
	}
}
/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	
	//등록정보 검색
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/sys/e000001/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 상세정보 검색 */
function fn_getDetailList(param) {
	
	var sid = 'sid_getDetailList';
	var url = '/sys/e000001/getDetailSearch.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);	
}
/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {

	var rowidx1 = $('#grid1').gfn_getCurRowIdx();
	
	//검색 안하고 저장 눌렀을 경우
	if (rowidx1 < 0) {
		cfn_msg('WARNING', '저장할 내역이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx1);
	var detailDataList = $('#grid2').gfn_getDataList();
	
	if($('#grid1').gfn_checkValidateCells()){
		return false;
	}
	
 	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}

	if (flg) {
		var sid = 'sid_setSave';
		var url = '/sys/e000001/setSave.do';
		var sendData = {'mGridData':masterData,'dGridDataList':detailDataList};
		
		gfn_sendData(sid, url, sendData);
	}  
}
//등록정보 행추가 ICON 버튼 클릭
function fn_grid1RowAdd() {
	$('#grid2').dataProvider().clearRows();
 	$('#grid1').gfn_addRow(); 
 	
}

//등록정보 행삭제 ICON 버튼 클릭
function fn_grid1RowDel() {
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	//검색 안하고 행 삭제 경우
	if(rowidx < 0){
		cfn_msg('WARNING', '선택된 등록정보가 없습니다.');
		return false;
	}
	
	var state = $('#grid1').dataProvider().getRowState(rowidx);
	
	//신규행 삭제 
	if (state === 'created') {
		$('#grid1').gfn_delRow(rowidx);
	}else {
		cfn_msg('WARNING', '기존에 등록된 내역은 삭제불가합니다.');
		return false;		
	}
}

//상세정보 행추가 ICON 버튼 클릭
function fn_grid2RowAdd() {
	if($('#grid1').gfn_checkValidateCells()){
		return false;
	}
	
	$('#grid1').gridView().commit();
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	//검색 안하고 행 추가 경우
	if(rowidx < 0){
		cfn_msg('WARNING','등록정보를 먼저 추가해주세요.');
		return false;
	}
	
	// 행추가시 배열보다 크지않도록 함
	var maxRowid = $('#grid2').dataProvider().getRowCount();
	
	if(colArr.length == maxRowid){
		cfn_msg('INFO','행추가를 더 이상 할 수 없습니다.');
		return false;
	}
	
	$('#grid2').gfn_addRow({
		'PGMID': $('#grid1').gfn_getValue(rowidx,'PGMID')
	});
	
	//COL_ID 재정렬		
	fn_reSetGrid();
}

//상세정보 행삭제 ICON 버튼 클릭
function fn_grid2RowDel() {
	
	var rowidx = $('#grid2').gfn_getCurRowIdx();
	
	//검색 안하고 행 삭제 경우
	if(rowidx < 0){
		cfn_msg('WARNING', '선택된 상세정보가 없습니다.');
		return false;
	}
	$('#grid2').gfn_delRow(rowidx);

	//COL_ID 재정렬	
	fn_reSetGrid();
}

//COL_ID 재정렬 등록	
function fn_reSetGrid(){
	var maxRowid = $('#grid2').dataProvider().getRowCount();

	if(maxRowid >= 0) {
		for(var i=0; i<maxRowid; i++){
			$('#grid2').gfn_setValue($('#grid2').gridView().getDataRow(i), 'COL_ID', colArr[i]);
		}
 	}
}
</script>
<c:import url="/comm/contentBottom.do" />