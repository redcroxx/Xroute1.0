<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : S000050
	화면명    : 프로그램관리
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<ul class="sech_ul">
		<li class="sech_li">
			<div style="width:80px">프로그램코드</div>
			<div>
				<input type="text" id="S_APPKEY" class="cmc_txt" />
			</div>
		</li>
		<li class="sech_li">
			<div style="width:80px">프로그램명</div>
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
		<div class="grid_top_right"></div>
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
	initLayout();
	
	setCommBtn('list', false);
	setCommBtn('save', false);
	setCommBtn('del', false);
	
	grid1_Load();
	
	cfn_initSearch();
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'APPKEY',header:{text:'프로그램코드'},width:120},
		{name:'APPNM',header:{text:'프로그램명'},width:170},
		{name:'APPURL',header:{text:'URL'},width:250},
		{name:'REMARK',header:{text:'비고'},width:400}
    ];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns);
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onDataCellDblClicked = function(grid, index) {
			var param = {'APPKEY':$('#' + gid).gfn_getValue(index.dataRow, 'APPKEY')};
			
		    gfn_pageMove('/sys/s000050/viewDetail.do', param);
		};
	});
}

//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		var gridData = data.resultList;
		$('#grid1').gfn_setDataList(gridData);
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/sys/s000050/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

//공통버튼 - 신규 클릭
function cfn_new() {
	gfn_pageMove('/sys/s000050/viewDetail.do');
}
</script>

<c:import url="/comm/contentBottom.do" />