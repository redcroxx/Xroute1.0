<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P700205
	화면명    : 이동지시서 발행
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="C_CHKWHCD" class="cmc_code" />
	<ul class="sech_ul">
		<li class="sech_li">
			<div>이동일자</div>
			<div>
				<input type="text" id="S_IMDT_FROM" class="cmc_date periods" /> ~
				<input type="text" id="S_IMDT_TO" class="cmc_date periode" />
			</div>
		</li>
		<li class="sech_li">
			<div>이동구분</div>
			<div>
				<select id="S_MVTYPE" class="cmc_combo">
					<c:forEach var="i" items="${codeMVTYPE}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
		<li class="sech_li">
			<div>이동상태</div>
			<div>
				<select id="S_IMSTS" class="cmc_combo">
					<option value="NOT99">전체</option>
					<c:forEach var="i" items="${codeIMSTS}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
	</ul>
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
			<div>이동번호</div>
			<div>				
				<input type="text" id="S_SEARCH" class="cmc_txt" />
			</div>
		</li>
		<li class="sech_li">
			<div>품목코드/명</div>
			<div>		
				<input type="text" id="S_ITEM" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<li class="sech_li">
			<div>로케이션</div>
			<div>
				<input type="text" id="S_BEFORELOCCD" class="cmc_txt" />
			</div>
		</li>
		<li class="sech_li">
			<div>이동로케이션</div>
			<div>
				<input type="text" id="S_AFTERLOCCD" class="cmc_txt" />
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
		<div class="grid_top_left">이동지시 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- 그리드 시작 -->
<div class="ct_bot_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">이동 상세리스트<span>(총 0건)</span></div>
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
	
	$('#S_IMDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_IMDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_IMSTS').val('100');
	
	//로그인 정보로 세팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_WHCD').val(cfn_loginInfo().WHCD);
	$('#S_WHNM').val(cfn_loginInfo().WHNM);
	
	grid1_Load();
	grid2_Load();

	/* 공통코드 코드/명 (셀러) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});

	/* 공통코드 코드/명 (창고) */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_WHCD:'S_WHCD,S_WHNM',S_COMPCD:'S_COMPCD'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	
	if ($('#S_ORGCD').val().length > 0) {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}
	
	if ($('#S_WHCD').val().length > 0) {
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	}		
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'IMKEY',header:{text:'이동번호'},width:150,styles:{textAlignment:'center'}},
		{name:'IMDT',header:{text:'이동일자'},width:110,formatter:'date',styles:{textAlignment:'center'}},
		{name:'IMSTS',header:{text:'상태'},width:100,formatter:'combo',comboValue:'${gCodeIMSTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:cfn_getStsColor(1)}},
				{criteria:'value = 200',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value = 99',styles:{figureBackground:cfn_getStsColor(4)}}			
			]		
		},
		{name:'MVTYPE',header:{text:'이동구분'},width:100,formatter:'combo',comboValue:'${gCodeMVTYPE}',styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ORGNM',header:{text:'셀러명'},width:100,styles:{textAlignment:'center'}},
		{name:'WHCD',header:{text:'창고코드'},width:110,styles:{textAlignment:'center'}},
		{name:'WHNM',header:{text:'창고명'},width:110,styles:{textAlignment:'center'}},
		{name:'REMARK',header:{text:'비고'},width:300},
		
		{name:'ITEMCNT',header:{text:'품목수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'TOTQTY',header:{text:'총수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'CFMUSERCD',header:{text:'확정자'},width:100,styles:{textAlignment:'center'}},
		{name:'CFMUSERNM',header:{text:'확정자명'},width:100,styles:{textAlignment:'center'}},
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,visible:false,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,visible:false,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true, checkBar:true});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			var imkey = $('#' + gid).gfn_getValue(newRowIdx, 'IMKEY');
			
			if(!cfn_isEmpty(imkey)) {
				var param = {'IMKEY':imkey};
				fn_getDetailList(param);
			}
		};
	});
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'IMKEY',header:{text:'이동번호'},width:150,styles:{textAlignment:'center'}},
		{name:'SEQ',header:{text:'순번'},width:60,styles:{textAlignment:'far'}},
		
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품명'},width:250},
		
		{name:'ITEMSIZE',header:{text:'규격'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'BEFORELOCCD',header:{text:'로케이션'},width:110,styles:{textAlignment:'center'}},
		{name:'AFTERLOCCD',header:{text:'이동로케이션'},width:110,styles:{textAlignment:'center'}},
		{name:'IMLOCCD',header:{text:'이동중로케이션'},width:110,styles:{textAlignment:'center'}},
		
		{name:'BEFAVAILQTY',header:{text:'이동가능수량'},dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'IMSCHQTY',header:{text:'이동지시수량'},width:110,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},			
		{name:'IMQTY',header:{text:'이동수량'},dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11,type:"number",positiveOnly:true,integerOnly:true},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
			
		{name:'REMARK',header:{text:'비고'},width:200,editor:{maxLength:200}},
		{name:'LOTKEY',header:{text:'로트번호'},width:100},
		
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1),show:cfn_getLotVisible(1)},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2),show:cfn_getLotVisible(2)},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3),show:cfn_getLotVisible(3)},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100,show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100,show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100,show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100,show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100,show:cfn_getCompItemVisible(15)},
		
		
		{name:'WHCD',header:{text:'창고코드'},width:110,visible:false,show:false},
		{name:'WHNM',header:{text:'창고명'},width:110,visible:false,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,visible:false,show:false},
		{name:'ORGNM',header:{text:'셀러명'},width:100,visible:false,show:false},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,visible:false,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,visible:false,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true,mstGrid:'grid1'});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('#grid1').gridView().cancel();
	$('#grid2').gridView().cancel();
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p700/p700205/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p700/p700205/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

//로케이션간 이동 지시서 출력
function cfn_print() {
	
	var checkRows = $('#grid1').gridView().getCheckedRows();
	var gridData = $('#grid1').gfn_getDataRows(checkRows);
	var imkey = '';
	
	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	pfn_popupOpen({
		url: '/alexcloud/p700/p700205/popReportView.do',
		pid: 'P700205_reportPop',
		returnFn: function(data, type) {
			var order;
			if (type === 'OK') {//리포트 띄우기
				
				for (var i=0, len=checkRows.length; i<len; i++) {
					if (i === 0) {
						imkey += $('#grid1').gfn_getValue(checkRows[i], 'IMKEY') ;
					} else {
						imkey += ',' + $('#grid1').gfn_getValue(checkRows[i], 'IMKEY') ;
					}
				}
				
				if(data.P700200_R === '1') { //빈양식
					
					rfn_reportView({
						title: '이동지시서',
						jrfName: 'P700205_R02'
					});
				} else {	
					if(data.P700200_R === '2') { //품목순
						order = '2'
					} else if(data.P700200_R === '3') { //이동전로케이션
						order = '3'
					} else if(data.P700200_R === '4') { //이동후로케이션
						order = '4'
					} else if(data.P700200_R === '5') { //수량
						order = '5'
					}

					rfn_reportView({
						title: '이동지시서',
						jrfName: 'P700205_R01',
						args: {'IMKEY':imkey, 'PRINTUSERNM':cfn_loginInfo().USERNM,'ORDER':order}
					});
				}
			}
		}
	});	
}

</script>

<c:import url="/comm/contentBottom.do" />