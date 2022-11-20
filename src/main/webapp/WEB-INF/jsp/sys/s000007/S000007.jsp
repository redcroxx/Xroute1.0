<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : S000007
	화면명    : 대메뉴
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
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
					<input type="text" id="S_MENUNAME" class="cmc_txt" />
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">
			대메뉴 리스트<span>(총 0건)</span>
		</div>
		<div class="grid_top_right">
			<button type="button" id="btn_rowAdd" class="cmb_plus"
				onclick="fn_grid1RowAdd()"></button>
			<button type="button" id="btn_rowDel" class="cmb_minus"
				onclick="fn_grid1RowDel()"></button>
		</div>
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

$(function() {
	//화면레이아웃 지정
	initLayout();

	//화면 공통버튼 설정
	setCommBtn('del', null, '삭제');

	//로그인 정보로 초기화
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	
	//그리드 초기화
	grid1_Load();
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'MENUL1KEY',header:{text:'대메뉴코드'},width:120,editable:true,required:true,editor:{maxLength:10,type:"number",positiveOnly:true}}
	   ,{name:'L1TITLE',header:{text:'대메뉴명'},width:120,editable:true,required:true,editor:{maxLength:10}}
	   ,{name:'SORTNO',header:{text:'정렬순서'},width:120,editable:true,required:true,editor:{maxLength:10,type:"number",positiveOnly:true},styles:{textAlignment:'far'}}
	   ,{name:'REMARKS',header:{text:'비고'},width:500,editable:true,editor:{maxLength:200}}
	   ,{name:'MENUL2CNT',header:{text:'중메뉴 건수'},width:110,styles:{textAlignment:'far'}}
	   ,{name:'MENUL3CNT',header:{text:'소메뉴 건수'},width:110,styles:{textAlignment:'far'}} 
	   ,{name:'COMPCD',header:{text:'회사코드'},width:100,editor:{maxLength:20},visible:false}
	];

	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});

	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//열고정 설정
		gridView.setFixedOptions({colCount : 2,resizable : true,colBarWidth : 1});
	});

	//disable할꺼 
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {

		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx,newRowIdx) {
			if (newRowIdx > -1) {
				var state = $('#grid1').dataProvider().getRowState(newRowIdx) === 'created';
							$('#' + gid).gfn_setColDisabled([ 'MENUL1KEY' ],state);
			}
		};
	});

}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid1').gridView().commit();	
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}

	//저장
	if (sid == 'sid_setSave') {

		$('#grid1').gfn_setFocusPK(data.resultData, [ 'MENUL1KEY' ]);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//삭제
	if (sid == 'sid_setDelete') {
		cfn_msg('INFO', '정상적으로 삭제되었습니다.');
		cfn_retrieve();
	}

}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');

	//서버 호출
	var sid = 'sid_getSearch';
	var url = '/sys/s000007/getSearch.do';
	var sendData = {
		'paramData' : gv_searchData
	};

	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	//검색 안하고 저장 눌렀을 경우
	if (rowidx < 0) {
		cfn_msg('WARNING', '저장할 내역이 없습니다.');
		return false;
	}
	
	//필수입력 체크
	if ($('#grid1').gfn_checkValidateCells())
		return false;

 	var masterList = $('#grid1').gfn_getDataList(false);
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}
	if (flg) {
		var sid = 'sid_setSave';
		var url = '/sys/s000007/setSave.do';
		var sendData = {
			'mGridList' : masterList
		};

		gfn_sendData(sid, url, sendData);
	}
}

/* 공통버튼 - 삭제 클릭 */
function cfn_del() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();

	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 메뉴가 없습니다.');
		return false;
	}
	var state = $('#grid1').dataProvider().getRowState(rowidx);

	if (state === 'created') {
		$('#grid1').gfn_delRow(rowidx);
		return;
	}

	var masterData = $('#grid1').gfn_getDataRow(rowidx);

	if (confirm('대메뉴코드[' + masterData.MENUL1KEY + '] 항목을 삭제하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/sys/s000007/setDelete.do';
		var sendData = {
			'paramData' : masterData
		};

		gfn_sendData(sid, url, sendData);
	}

}
//신규 행추가 ICON 버튼 클릭
function fn_grid1RowAdd() {
	$('#grid1').gfn_addRow({
		'COMPCD' : cfn_loginInfo().COMPCD
	});
}

//신규 행삭제 ICON 버튼 클릭
function fn_grid1RowDel() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();

	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	var state = $('#grid1').dataProvider().getRowState(rowidx);

	if (state === 'created') {
		$('#grid1').gfn_delRow(rowidx);
	} else {
		var masterData = $('#grid1').gfn_getDataRow(rowidx);

		if (confirm('대메뉴코드[' + masterData.MENUL1KEY + '] 항목을 삭제하시겠습니까?')) {
			var sid = 'sid_setDelete';
			var url = '/sys/s000007/setDelete.do';
			var sendData = {
				'paramData' : masterData
			};

			gfn_sendData(sid, url, sendData);
		}
	}
}
</script>

<c:import url="/comm/contentBottom.do" />