<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : S000013
	화면명    : 로그인이력조회
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
				<div>셀러</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code" />
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
		</ul>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>기간</div>
				<div>
					<input type="text" id="S_HISTORYDATETIME_FROM" name="S_HISTORYDATETIME_FROM" class="cmc_date periods required" /> ~ 	
					<input type="text" id="S_HISTORYDATETIME_TO" name="S_HISTORYDATETIME_TO" class="cmc_date periode" />		
				</div>
			</li>
			<li class="sech_li">
				<div>사용자코드/명</div>
				<div>
					<input type="text" id="S_USER" class="cmc_txt" />
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">로그인이력<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
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

	//회사 코드/명
	pfn_codeval({
		url:'/alexcloud/popup/popP001/view.do',codeid:'S_COMPCD',
		inparam:{S_COMPCD:'S_COMPCD,S_COMPNM'},
		outparam:{COMPCD:'S_COMPCD',NAME:'S_COMPNM'}
	});
	//사업장 코드/명
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_COMPNM:'S_COMPNM',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	$('#S_HISTORYDATETIME_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	
	grid1_Load();
});

function grid1_Load() {
	var gid = 'grid1', $grid = $('#' + gid);
	var columns = [
		{name:'HISTORYDATETIME',header:{text:'일시'},width:150,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'COMPNM',header:{text:'회사명'},width:100},
		{name:'ORGCD',header:{text:'셀러코드'},width:100},
		{name:'ORGNM',header:{text:'셀러명'},width:100},
		{name:'USERCD',header:{text:'사용자코드'},width:100},
		{name:'USERNM',header:{text:'사용자명'},width:120},
		{name:'HISTORYTYPE',header:{text:'로그인유형'},width:100,styles:{textAlignment:'center'}},
		{name:'STATUS',header:{text:'상태'},width:100,formatter:'combo',comboValue:'${GCODE_LOGINSTATUS}',styles:{textAlignment:'center'}},
		{name:'USERIP',header:{text:'IP'},width:120,styles:{textAlignment:'center'}},
		{name:'USEROS',header:{text:'OS'},width:120,styles:{textAlignment:'center'}},
		{name:'USERBROWSER',header:{text:'브라우저'},width:120,styles:{textAlignment:'center'}},
		{name:'REMARK',header:{text:'비고'},width:400}
	];
	$grid.gfn_createGrid(columns, {footerflg:false});
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
	var url = '/sys/s000013/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}
</script>

<c:import url="/comm/contentBottom.do" />