<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : S000005
	화면명    : 프로그램
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<ul class="sech_ul">
		<li class="sech_li">
			<div>프로그램코드</div>
			<div>		
				<input type="text" id="S_APPKEY" class="cmc_txt" />
			</div>
		</li>
		<li class="sech_li">
			<div>프로그램명</div>
			<div>		
				<input type="text" id="S_APPNM" class="cmc_txt" />
			</div>
		</li>
	</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">프로그램 리스트</div>
		<div class="grid_top_right">
			<input type="button" id="btn_masterAdd" class="cmb_plus" onclick="btn_masterAdd_onClick();"/>
			<input type="button" id="btn_masterDel" class="cmb_minus" onclick="btn_masterDel_onClick();" />		</div>
		</div>
	<div id="grid1"></div>
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
	
	grid1_Load();
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'APPKEY',header:{text:'프로그램코드'},width:90,editable:true,required:true,editor:{maxLength:20}},
		{name:'APPNM',header:{text:'프로그램명'},width:180,editable:true,required:true,editor:{maxLength:100}},
		{name:'APPURL',header:{text:'URL'},width:220,editable:true,required:true,editor:{maxLength:100}},
		{name:'USEYN',header:{text:'사용여부'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'BTNSEARCH',header:{text:'검색'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNNEW',header:{text:'신규'},width:70,formatter:'checkbox', renderer:{editable:true, trueValues:'1',falseValues:'0'}},
		{name:'BTNSAVE',header:{text:'저장'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNDELETE',header:{text:'삭제'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNEXECUTE',header:{text:'실행'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNPRINT',header:{text:'출력'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNEXCELDOWN',header:{text:'엑셀저장'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNEXCELUP',header:{text:'엑셀업로드'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNCANCEL',header:{text:'취소'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNCOPY',header:{text:'복사'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNLIST',header:{text:'목록'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNINIT',header:{text:'초기화'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNUSER1',header:{text:'사용자1'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNUSER2',header:{text:'사용자2'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNUSER3',header:{text:'사용자3'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNUSER4',header:{text:'사용자4'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'BTNUSER5',header:{text:'사용자5'},width:70,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'REMARK',header:{text:'비고'},width:200,editable:true,editor:{maxLength:200}},
		{name:'ADDUSERCD',header:{text:'등록자'},width:70},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:190},
		{name:'UPDUSERCD',header:{text:'수정자'},width:70},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:190},
		{name:'TERMINALCD',header:{text:'IP'},width:100},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var state = $('#' + gid).dataProvider().getRowState(newRowIdx) === 'created';
				$('#' + gid).gfn_setColDisabled(['APPKEY'], state);
			} 
		};
		//열고정 설정
		gridView.setFixedOptions({colCount:2,resizable:true,colBarWidth:1});
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid1').gfn_setDataList(data.resultList);
		
		//검색결과에 따른 마스터 데이터 포커스 이동 처리 (저장처리 이후 발생 gfn_setFocusPK함수 처리)
		$('#grid1').gfn_focusPK();
	}
	//저장
	if(sid == 'sid_setSave') {
		var resultData = data.resultData;
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['APPKEY']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		
		cfn_retrieve();
	}
	//삭제
	if(sid == 'sid_setDelete') {
		//마스터 데이터 PK 설정
		cfn_msg('INFO', '정상적으로 삭제되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('#grid1').gridView().commit(true);
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/sys/s000005/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {
	//마스터 필수입력 체크
	if ($('#grid1').gfn_checkValidateCells()) return false;
	
	var masterList = $('#grid1').gfn_getDataList(false);
	
	if (masterList.length < 1) {
		cfn_msg('WARNING', '변경된 내역이 없습니다.');
		return false;
	}
	
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}
	
	if (flg) {
		var sid = 'sid_setSave';
		var url = '/sys/s000005/setSave.do';
		var sendData = {'mGridList':masterList};
		
		gfn_sendData(sid, url, sendData);
	}
}

/* 공통버튼 - 삭제 클릭 */
function cfn_del() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 프로그램이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (confirm('프로그램코드[' + masterData.APPKEY + '] 항목을 삭제 하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/sys/s000005/setDelete.do';
		var sendData = {'paramData':masterData};

		gfn_sendData(sid, url, sendData);
	}
}

//마스터 그리드 추가(+) 버튼 이벤트
function btn_masterAdd_onClick() {
	$('#grid1').gfn_addRow();
}

//마스터 그리드 삭제(-) 버튼 이벤트
function btn_masterDel_onClick() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	var state = $('#grid1').dataProvider().getRowState(rowidx);
	if (state !== 'created') {
		cfn_msg('WARNING', '기등록 데이터는 삭제할 수 없습니다.');
		return false;
	}
	
	$('#grid1').gfn_delRow(rowidx);
}
</script>

<c:import url="/comm/contentBottom.do" />