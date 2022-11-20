<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100315
	화면명    : 구매발주 > 입고관리 > 입고지시서 발행
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="S_COMPNM" class="cmc_code" />
	
	<ul class="sech_ul">
		<li class="sech_li">
			<div style="width:100px">입고일자</div>
			<div style="width:250px">				
				<input type="text" id="S_WIDT_FROM" name="S_WIDT_FROM" data-type="date" class="cmc_date"/> ~
				<input type="text" id="S_WIDT_TO" name="S_WIDT_TO" data-type="date" class="cmc_date"/>				
			</div>
		</li>
		<li class="sech_li">
			<div style="width:100px">입고상태</div>
 			<div style="width:250px">		
				<select id="S_WISTS" name="S_WISTS" class="cmc_combo">
					<option value="0" selected>전체</option>
					<c:forEach var="i" items="${codeWISTS}">
						<c:if test="${i.code == '200' || i.code == '99'}">
							<option value="${i.code}">${i.value}</option>
						</c:if>
					</c:forEach>
				</select>		
			</div> 
	
		</li>
		<li class="sech_li">
			<div>입고유형</div>
			<div>
				<select id="S_WITYPE" class="cmc_combo">
					<option value="">전체</option>
					<c:forEach var="i" items="${codeWITYPE}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<!-- <li class="sech_li">
			<div style="width:100px">거래처</div>
			<div style="width:250px">
				<input type="text" id="S_CUSTCD" name="S_CUSTCD" class="cmc_code" />
				<input type="text" id="S_CUSTNM" name="S_CUSTNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li> -->
		<li class="sech_li">
			<div style="width:100px;">
				<select id="S_SEARCHTYPE" name="S_SEARCHTYPE" class="cmc_combo" style="width:98px">
						<option value="WD" selected >지시번호</option>
						<option value="WI">입고번호</option>
				</select>	
			</div>
			<div style="width:250px">
				<input type="text" id="S_SEARCHKEY" name="S_SEARCHKEY" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<li class="sech_li required">
			<div style="width:100px">창고</div>
			<div style="width:250px">	
				<input type="text" id="S_WHCD" name="S_WHCD" class="cmc_code required"/>
				<input type="text" id="S_WHNM" name="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>	
		<li class="sech_li">
			<div style="width:100px">품목코드/명</div>
			<div style="width:250px">		
				<input type="text" id="S_ITEM" name="S_ITEM" class="cmc_txt" />
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

<!-- Mst그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- Det그리드 시작 -->
<div class="ct_bot_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고지시 상세리스트<span>(총 0건)</span></div>
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
	
	setCommBtn('execute', null, '발행');
	
	$('#S_WIDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WIDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);

	grid1_Load();
	grid2_Load();
		
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
	
	/* 공통코드 코드/명 (셀러) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_ORGCD:'S_ORGCD,S_ORGNM',S_COMPCD:'S_COMPCD',S_COMPNM:'S_COMPNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
		$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
		$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	} 
 	
 	if(!cfn_isEmpty(cfn_loginInfo().WHCD)){
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
		$('#S_WHCD').val(cfn_loginInfo().WHCD);
		$('#S_WHNM').val(cfn_loginInfo().WHNM);
	} 
});

function grid1_Load() {
	var gid = 'grid1', $grid = $('#'+gid);
	
	var columns = [
		{name:'WDKEY',header:{text:'입고지시번호'},width:150, styles:{textAlignment:'center'}},
		{name:'WDDT',header:{text:'입고일자'},width:120,formatter:'date', styles:{textAlignment:'center'}},
		{name:'WDSTS',header:{text:'입고상태'},width:110,formatter:'combo',comboValue:'${gCodeWISTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:'#FFFF00'}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:'#FFA500'}},
				{criteria:'value = 400',styles:{figureBackground:'#008000'}},
				{criteria:'value = 99',styles:{figureBackground:'#ff0000'}}]},		
		{name:'ORGNM',header:{text:'셀러'},width:100, styles:{textAlignment:'center'}},
		{name:'WHNM',header:{text:'창고'},width:100, styles:{textAlignment:'center'}},
		/* {name:'CUSTNM',header:{text:'거래처명'},width:150}, */
		{name:'REMARK',header:{text:'비고'},width:300},
		
		{name:'PROGRESS_QTY',header:{text:'실적현황'},width:100,formatter:'progressbar',dataType:'number',
			dynamicStyles:[
				{criteria:'value >= 0',styles:{figureBackground:cfn_getStsColor(4)}},
				{criteria:'value >= 50',styles:{figureBackground:cfn_getStsColor(2)}},
				{criteria:'value >= 100',styles:{figureBackground:cfn_getStsColor(3)}} 
			]
		},
		{name:'ITEMCNT',header:{text:'품목수'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		
		{name:'WDSCHQTY',header:{text:'지시 총 수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'WDQTY',header:{text:'입고 총 수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		
		{name:'WHCD',header:{text:'창고코드'},width:100,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},show:false}
	];
	
	//그리드 생성
	$grid.gfn_createGrid(columns, {checkBar:true});
	

	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			var param = {'WDKEY':$grid.gfn_getValue(newRowIdx, 'WDKEY')};
			fn_getDetailList(param);
		};
	});
	
}

function grid2_Load() {
	var gid = 'grid2',$grid2 = $('#'+gid);
	var columns = [
		{name:'WIKEY',header:{text:'입고번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WISEQ',header:{text:'입고SEQ'},width:70,styles:{textAlignment:'far'}},
		{name:'WDKEY',header:{text:'입고지시번호'},width:150,styles:{textAlignment:'center'}},
		{name:'WDSEQ',header:{text:'지시SEQ'},width:70,styles:{textAlignment:'far'}},
		{name:'WDSTS',header:{text:'입고상태'},width:100,formatter:'combo',comboValue:'${gCodeWISTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:'#FFFF00'}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:'#FFA500'}},
				{criteria:'value = 400',styles:{figureBackground:'#008000'}},
				{criteria:'value = 99',styles:{figureBackground:'#ff0000'}}]},
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:250},
		{name:'SCHLOCCD',header:{text:'지시로케이션'},width:100,styles:{textAlignment:'center'}},
		{name:'LOCCD',header:{text:'입고로케이션'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'ORIGINQTY',header:{text:'최초입고예정수량'},width:120,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'WISCHQTY_BOX',header:{text:'지시[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WISCHQTY_EA',header:{text:'지시[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WISCHQTY',header:{text:'지시수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'WIQTY_BOX',header:{text:'입고[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY_EA',header:{text:'입고[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY',header:{text:'입고수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, editor:{maxLength:50},formatter:cfn_getLotType(1), show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, editor:{maxLength:50},formatter:cfn_getLotType(2), show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, feditor:{maxLength:50},ormatter:cfn_getLotType(3), show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		{name:'REMARK',header:{text:'비고'},width:300, maxlength:200},
		/* {name:'IFORDERNO',header:{text:'IF구매번호'},width:130,styles:{textAlignment:'center'}},
		{name:'IFORDERSUBNO',header:{text:'IF상세번호'},width:110,styles:{textAlignment:'center'}},
		{name:'IFORDERSEQ',header:{text:'IF순번'},width:80,styles:{textAlignment:'far'}},
		{name:'IFPOQTY',header:{text:'구매서입고요청량'},width:130,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}}, */
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:100,show:false}, */
		/* {name:'CUSTNM',header:{text:'거래처명'},width:150,show:false}, */
		{name:'WHCD',header:{text:'창고코드'},width:100,show:false},
		{name:'WHNM',header:{text:'창고명'},width:100,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},show:false}	
	];

	//그리드 생성
	$grid2.gfn_createGrid(columns, {editable:true});
	

	
}


/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').gridView().commit();
		$('#grid1').gfn_setDataList(data.resultList);
		$('#A_LOCCD').val('');
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//입고실적 처리 
	if (sid == 'sid_instruct') {
		cfn_msg('INFO', '실적 등록 되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	//검색조건 필수입력 체크
	if(cfn_isFormRequireData('frmSearch') == false) return; 
	
	gv_searchData = cfn_getFormData('frmSearch');

	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100315/getSearch.do';
	var sendData = {'paramData':gv_searchData};
		
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p100/p100315/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 발행 클릭(입고지시서 발행) */
function cfn_execute() {
	
	gv_searchData = cfn_getFormData('frmSearch');
	var checkRows = $('#grid1').gridView().getCheckedRows();
	var gridData = $('#grid1').gfn_getDataRows(checkRows);
	var list = [];
	var wdkey = '';
	
	
	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}

	pfn_popupOpen({
		url: '/alexcloud/p100/p100315/popReportView.do',
		pid: 'P100315_reportPop',
		returnFn: function(data, type) {
			if (type === 'OK') {
				var reportTitle,reportName;
				
				if(data.P100315_R === '1') { //입고지시서
					reportTitle = '입고지시서';
					reportName = 'P100315_R01';					
				} else if(data.P100315_R === '2') { //입고실적서
					reportTitle = '입고실적서';
					reportName = 'P100315_R02';						
				}
				
				
				for (var i=0, len=checkRows.length; i<len; i++) {
					if (i === 0) {
						wdkey += $('#grid1').gfn_getValue(checkRows[i], 'WDKEY') ;
					} else {
						wdkey += ',' + $('#grid1').gfn_getValue(checkRows[i], 'WDKEY') ;
					}
				}

				rfn_reportView({
					title: reportTitle,
					jrfName: reportName,
					args: {'WDKEY':wdkey,'USERNM':cfn_loginInfo().USERNM}
				});
				
				
			}
		}
	});
}

</script>

<c:import url="/comm/contentBottom.do" />