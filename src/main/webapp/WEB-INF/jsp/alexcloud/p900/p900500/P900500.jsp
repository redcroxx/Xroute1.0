<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P900500
	화면명    : 로케이션별재고현황
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<ul class="sech_ul">
		<li class="sech_li required">
			<div class="required">창고</div>
			<div>
				<input type="text" id="S_WHCD" class="cmc_code required" />
				<input type="text" id="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<li class="sech_li">
			<div>로케이션</div>
			<div>
				<input type="text" id="S_LOCCD" class="cmc_code" />
			</div>
		</li>
		<li class="sech_li">
			<div>구분</div>
			<div>
				<select id="S_GUBUN" class="cmc_combo">
					<option value="">전체</option>
					<option value="1">재고있는것만</option>
					<option value="2">재고없는것만</option>
				</select>
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<li class="sech_li">
			<div>로트키</div>
			<div>		
				<input type="text" id="S_LOTKEY" class="cmc_txt" />
			</div>
		</li>
		<li class="sech_li">
			<div>품목코드/명</div>
			<div>
				<input type="text" id="S_ITEM" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<div id="sech_extbtn" class="down"></div>
	<div id="sech_extline"></div>
	<div id="sech_extwrap">
		<ul class="sech_ul">
			<li class="sech_li">
				<div>화주</div>
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
<div class="ct_left_wrap fix" style="width:400px">
	<div class="grid_top_wrap">
		<div class="grid_top_left">로케이션리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
		</div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- 그리드 시작 -->
<div class="ct_right_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">재고리스트<span>(총 0건)</span></div>
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

	$('#S_WOSCHDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WOSCHDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	
 	/* 화주 */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	/* 창고 */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'S_WHCD,S_WHNM'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
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
	
	grid1_Load();
	grid2_Load();
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'LOCCD',header:{text:'로케이션코드'},width:120},
		{name:'LOCNAME',header:{text:'로케이션명'},width:120},
		{name:'LOCTYPE',header:{text:'로케이션타입'},width:100,formatter:'combo',comboValue:'${gCodeLOCTYPE}',styles:{textAlignment:'center'}},
		{name:'LOCGROUP',header:{text:'로케이션유형'},width:100,formatter:'combo',comboValue:'${gCodeLOCGROUP}',styles:{textAlignment:'center'},show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'},show:false},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'},show:false},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'},show:false},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'},show:false},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},show:false},
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'WHCD',header:{text:'창고코드'},width:100,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {	
			var masterData = $('#grid1').gfn_getDataRow(newRowIdx);

			if(!cfn_isEmpty(masterData.LOCCD)) {
				var param = {'LOCCD':masterData.LOCCD, 'COMPCD':masterData.COMPCD, 'WHCD':masterData.WHCD,'S_ORGCD':$('#S_ORGCD').val()};
				fn_getDetailList(param);
			}
		};	
	});
}

function grid2_Load() {
	var gid = 'grid2';
	
	var columns = [
		{name:'ORGCD',header:{text:'화주코드'},width:100,show:false},
		{name:'ORGNM',header:{text:'화주명'},width:100,show:false},
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:300},
		{name:'ITEMSIZE',header:{text:'규격'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'AVAILABLEQTY',header:{text:'가용수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'QTY',header:{text:'재고수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'ALLOCQTY',header:{text:'할당수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'LOTKEY',header:{text:'로트키'},width:100,styles:{textAlignment:'center'}},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1),show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2),show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3),show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4,styles:{textAlignment:'center'}},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5,styles:{textAlignment:'center'}},
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100, show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100, show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100, show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100, show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100, show:cfn_getCompItemVisible(15)},
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'WHCD',header:{text:'창고코드'},width:100,show:false},
		{name:'LOCCD',header:{text:'로케이션'},width:100,show:false},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns);
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		var gridData = data.resultList;	
		
		$('#grid1').gfn_setDataList(data.resultList);		
	}
	//디테일리스트검색
	else if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	if (!cfn_isFormRequireData('frmSearch')) return false;
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p900/p900500/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p900/p900500/getDetailList.do';
	var sendData = {'paramData':param, 'paramSearch':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

</script>

<c:import url="/comm/contentBottom.do" />