<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100382
	화면명    : 입고현황(발주/미발주) 
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="S_COMPNM" class="cmc_code" />
	<ul class="sech_ul">
		<li class="sech_li">
			<div>창고</div>
			<div>
				<input type="text" id="S_WHCD" class="cmc_code" />
				<input type="text" id="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<li class="sech_li">
			<div >입고요청일자</div>
			<div>
				<input type="text" id="S_WISCHDT_FROM" class="cmc_date periods"/> ~
				<input type="text" id="S_WISCHDT_TO" class="cmc_date periode"/>
			</div>
		</li>
		<li class="sech_li">
			<div>입고번호</div>
			<div>				
				<input type="text" id="S_WIKEY" name="S_WIKEY" class="cmc_txt" />
			</div>
		</li>
	</ul>	
	<ul class="sech_ul">
		<!-- <li class="sech_li">
			<div>거래처</div>
			<div>
				<input type="text" id="S_CUSTCD" class="cmc_code" />
				<input type="text" id="S_CUSTNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li> -->
		<li class="sech_li">
			<div>품목코드/명</div>
			<div>
				<input type="text" id="S_ITEMCD" name="S_ITEMCD" class="cmc_txt" />
			</div>
		</li>
		<li class="sech_li">
			<div>발주여부</div>
			<div>
				<select id="S_IFYN" class="cmc_combo">
					<c:forEach var="i" items="${CODE_YN}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
	</ul>
	<div id="sech_extbtn" class="down"></div>
	<div id="sech_extline"></div>
	<div id="sech_extwrap">
		<ul class="sech_ul">
			<li class="sech_li">
				<div>셀러</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code" />
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
		</ul>	
		<!-- 회사별 상품정보 조회조건 -->
		<c:import url="/comm/compItemSearch.do" />
	</div>
	
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고현황(발주/미발주) 리스트<span>(총 0건)</span></div>
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
//초기 로드
$(function() {
	initLayout();

	$('#S_WISCHDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WISCHDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));

	//로그인 정보로 세팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM); 
	$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	$('#S_ORGCD').val('C0014');
	$('#S_ORGNM').val('애터미(주)');
	
	grid1_Load();
	
	/* 공통코드 코드/명 (거래처) */
	/* pfn_codeval({
		url:'/alexcloud/popup/popP003/view.do',codeid:'S_CUSTCD',
		inparam:{S_CUSTCD:'S_CUSTCD,S_CUSTNM',S_ORGCD:'S_ORGCD',S_ORGNM:'S_ORGNM',S_COMPCD:'S_COMPCD'},
		outparam:{CUSTCD:'S_CUSTCD',NAME:'S_CUSTNM'},
		params:{CODEKEY:'ISSUPPLIER'}
	}); */
	
	/* 공통코드 코드/명 (창고) */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_WHCD:'S_WHCD,S_WHNM',S_COMPCD:'S_COMPCD'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
		
	cfn_initSearch();
	
 	if (!cfn_isEmpty(cfn_loginInfo().WHCD)) {
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
		$('#S_WHCD').val(cfn_loginInfo().WHCD);
		$('#S_WHNM').val(cfn_loginInfo().WHNM);
	} 
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WISCHDT',header:{text:'입고요청일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WIDT',header:{text:'입고일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WISTS',header:{text:'입고상태'},width:120,formatter:'combo',comboValue:'${gCodeWISTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 400',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}]},
		{name:'WITYPE',header:{text:'입고유형'},width:90,formatter:'combo',comboValue:'${gCodeWITYPE}',styles:{textAlignment:'center'}},
		
		{name:'ORGCD',header:{text:'셀러코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ORGNM',header:{text:'셀러명'},width:120,styles:{textAlignment:'center'}},
		{name:'WHCD',header:{text:'창고코드'},width:80,styles:{textAlignment:'center'}},
		{name:'WHNM',header:{text:'창고명'},width:100,styles:{textAlignment:'center'}},
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:120,styles:{textAlignment:'center'}},
		{name:'CUSTNM',header:{text:'거래처명'},width:150}, */
		
		{name:'ITEMCD',header:{text:'품목코드'},width:120,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:250},
		{name:'WISCHQTY',header:{text:'예정수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY',header:{text:'입고수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
			
		{name:'IFORDERNO',header:{text:'IF구매번호'},width:130,styles:{textAlignment:'center'}},
		{name:'IFORDERSUBNO',header:{text:'IF상세번호'},width:110,styles:{textAlignment:'center'}},
		{name:'IFORDERSEQ',header:{text:'IF순번'},width:80,styles:{textAlignment:'far'}},
		{name:'IFPOQTY',header:{text:'구매서입고요청량'},width:130,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
			
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}}
		
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns);
}
/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색(전표별)
	if (sid == 'sid_getSearch') {
		var gridData = data.resultList;	
		$('#grid1').gfn_setDataList(data.resultList);
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100382/getSearch.do';
	var sendData = {'paramData':gv_searchData};

	gfn_sendData(sid, url, sendData);
	
}

</script>

<c:import url="/comm/contentBottom.do" />