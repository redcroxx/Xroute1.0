<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100300_popup
	화면명    : 팝업 - 발주적용 팝업
-->
<div id="P100300_popup" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_P100300_popup" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" class="cmc_code" />
			<ul class="sech_ul">
				<li class="sech_li">
					<div style="width:100px">발주일자</div>
					<div style="width:250px;">
						<input type="text" id="S_POSCHDT_FROM" class="cmc_date"/> ~
						<input type="text" id="S_POSCHDT_TO" class="cmc_date"/>
					</div>
				</li>
				<li class="sech_li">
					<div style="width:100px;">
						<select id="S_SERACHCOMBO1" class="cmc_combo" style="width:100px">
							<option value="POKEY"><c:out value="발주번호"/></option>
							<option value="COKEY"><c:out value="구매번호"/></option>
						</select>
					</div>
					<div style="width:80px;">		
						<input type="text" id="S_SEARCH1" class="cmc_txt" />
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<!-- <li class="sech_li">
					<div style="width:100px;">거래처</div> 
					<div>
						<input type="text" id="S_CUSTCD" class="cmc_code disabled" readonly="readonly" />
						<input type="text" id="S_CUSTNM" class="cmc_value disabled" readonly="readonly" />
					</div>
				</li> -->
				<li class="sech_li">
					<div style="width:100px;">창고</div>
					<div>
						<input type="text" id="S_WHCD" class="cmc_code disabled" readonly="readonly"/>
						<input type="text" id="S_WHNM" class="cmc_value disabled" readonly="readonly"/>
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">
					<div style="width:100px">품목코드/명</div>
					<div>		
						<input type="text" id="S_ITEM" class="cmc_txt" />
					</div>
				</li>
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_P100300_popup_search()"></button>
			<div id="sech_extbtn" class="down"></div>
			<div id="sech_extline"></div>
			<div id="sech_extwrap">
				<ul class="sech_ul">
					<li class="sech_li">
						<div style="width:100px">
							<select id="S_SERACHCOMBO2" class="cmc_combo" style="width:80px">
								<option value="USERCD"><c:out value="담당자"/></option>
								<option value="CFMUSERCD"><c:out value="확정자"/></option>
							</select>
						</div>
						<div>
							<input type="text" id="S_USERCD" class="cmc_code" />
							<input type="text" id="S_USERNM" class="cmc_value" />
							<button type="button" class="cmc_cdsearch"></button>
						</div>
					</li>
					<li class="sech_li">		
						<div style="width:100px;">사업장</div>
						<div style="width:250px;">
							<input type="text" id="S_ORGCD" class="cmc_code" />
							<input type="text" id="S_ORGNM" class="cmc_value" />
							<button type="button" class="cmc_cdsearch"></button>
						</div>
					</li>
				</ul>
				<c:import url="/comm/compItemSearch.do" />
			</div>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	<div class="ct_top_wrap">
		<div id="tab1" class="ct_tab">
			<ul>
				<li><a href="#tab1Cont1">전표별리스트</a></li>
				<li><a href="#tab1Cont2">품목별리스트</a></li>
			</ul>
			<div id="tab1Cont1">
				<div class="ct_top_wrap">
					<div class="grid_top_wrap">
						<div class="grid_top_left">발주 리스트<span>(총 0건)</span></div>
						<div class="grid_top_right"></div>
					</div>
					<div id="grid1_P100300_popup"></div>
				</div>
				<div class="ct_bot_wrap">
					<div class="grid_top_wrap">
						<div class="grid_top_left">발주 상세 리스트<span>(총 0건)</span></div>
						<div class="grid_top_right"></div>
					</div>
					<div id="grid2_P100300_popup"></div>
				</div>
			</div>
			<div id="tab1Cont2">
				<div class="grid_top_wrap">
					<div class="grid_top_left">발주 상세 리스트<span>(총 0건)</span></div>
					<div class="grid_top_right"></div>
				</div>
				<div id="grid3_P100300_popup"></div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#P100300_popup').lingoPopup({
		title: '발주적용',
		width: 1450,
		height : 800,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var tabidx = cfn_getTabIdx('tab1');

					if (tabidx === 1) {
						var gridData = $('#grid2_P100300_popup').gfn_getDataList();
						
						if (gridData.length < 1) {
							cfn_msg('WARNING', '선택된 전표가 없습니다.');
							return false;
						}
					} else if(tabidx === 2) {
						var checkRows = $('#grid3_P100300_popup').gridView().getCheckedRows();
						
						if (checkRows.length < 1) {
							cfn_msg('WARNING', '선택된 행이 없습니다.');
							return false;
						}

						var gridData = $('#grid3_P100300_popup').gfn_getDataRows(checkRows);
						
					}
					$(this).lingoPopup('setData', gridData);
					$(this).lingoPopup('close', 'OK');
				}
			},
			'취소': {
				text: '취소',
				click: function() {
					$(this).lingoPopup('setData', '');
					$(this).lingoPopup('close', 'CANCEL');
				}
			}
		},
		open: function(data) {
			cfn_bindFormData('frm_search_P100300_popup', data);
			
			//회사별 상품정보 제어를 위한 함수 호출
			cfn_getCompItemInfo();
			
			$('#S_POSCHDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
			$('#S_POSCHDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));

			$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
			$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
			$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
			
			grid1_P100300_popup_Load();
			grid2_P100300_popup_Load();
			grid3_P100300_popup_Load();
			
			/* 공통코드 코드/명 (사업장) */
			pfn_codeval({
				url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
				inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
				outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
			});
			
			/* 공통코드 코드/명 (담당자) */
			pfn_codeval({
				url:'/alexcloud/popup/popS010/view.do',codeid:'S_USERCD',
				inparam:{S_USERCD:'S_USERCD,S_USERNM'},
				outparam:{USERCD:'S_USERCD',NAME:'S_USERNM'}
			});
			
			cfn_setTabIdx('tab1', 1);
			
			fn_P100300_popup_search();
		}
	});
});

function grid1_P100300_popup_Load() {
	var gid = 'grid1_P100300_popup';
	var columns = [
		{name:'POKEY',header:{text:'발주번호'},width:120,styles:{textAlignment:'center'}},
		{name:'POSCHDT',header:{text:'발주일자'},width:90,formatter:'date',styles:{textAlignment:'center'}},
		/* {name:'CUSTNM',header:{text:'거래처'},width:100}, */
		{name:'VATFLG',header:{text:'과세구분'},width:80,formatter:'combo',comboValue:'${gCodeVATFLG}',styles:{textAlignment:'center'}},
		{name:'USERNM',header:{text:'담당자명'},width:70},
		{name:'DEPTNM',header:{text:'요청부서'},width:80},
		{name:'WHNM',header:{text:'창고'},width:80},
		{name:'TOTQTY',header:{text:'총발주수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'TOTAVAILABLEQTY',header:{text:'총적용가능수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'TOTCNT',header:{text:'품목수'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'TOTSUPPLYAMT',header:{text:'총발주금액'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'CFMUSERNM',header:{text:'확정자'},width:80},
		{name:'REMARK',header:{text:'비고'},width:300},
		//{name:'ISCLOSING',header:{text:'마감여부'},width:80,formatter:'combo',comboValue:'${gCodeISCLOSING}',styles:{textAlignment:'center'}},
		{name:'EAKEY',header:{text:'전자결재번호'},width:120,styles:{textAlignment:'center'}},
		{name:'EASTS',header:{text:'결재상태'},width:120,styles:{textAlignment:'center'}},
		{name:'POTYPE',header:{text:'발주유형'},width:80,formatter:'combo',comboValue:'${gCodePOTYPE}',styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'ORGCD',header:{text:'사업장코드'},width:100},
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:100}, */
		{name:'USERCD',header:{text:'담당자코드'},width:100},
		{name:'DEPTCD',header:{text:'부서코드'},width:100},
		{name:'WHCD',header:{text:'창고코드'},width:100},
		{name:'CFMUSERCD',header:{text:'확정자코드'},width:100},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns);
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			var pokey = $('#' + gid).gfn_getValue(newRowIdx, 'POKEY');
			
			if(!cfn_isEmpty(pokey)) {
				var param = {'POKEY':pokey};
				fn_getDetailList(param);	
			}
		};
		
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var gridData = $('#grid2_P100300_popup').gfn_getDataList();

			$('#P100300_popup').lingoPopup('setData', gridData);
			$('#P100300_popup').lingoPopup('close', 'OK');
		};
	});
}

function grid2_P100300_popup_Load() {
	var gid = 'grid2_P100300_popup';
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:120},
		{name:'ITEMNM',header:{text:'품목명'},width:150},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'DELIVDT',header:{text:'납기일1차'},width:90,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WISCHDT',header:{text:'납기일2차'},width:90,formatter:'date',styles:{textAlignment:'center'}},
		{name:'POQTY',header:{text:'발주수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'AVAILABLEQTY',header:{text:'적용가능수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'UNITPRICE',header:{text:'단가'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'AVAILABLESUPPLYAMT',header:{text:'입고금액'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'SUPPLYAMT',header:{text:'발주금액'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100, visible:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100, visible:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100, visible:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100, visible:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100, visible:cfn_getCompItemVisible(15)},
		{name:'REMARK',header:{text:'비고'},width:200},
		{name:'COKEY',header:{text:'구매번호'},width:120},
		{name:'COSEQ',header:{text:'구매순번'},width:60,styles:{textAlignment:'right'}},
		{name:'POKEY',header:{text:'발주번호'},width:120},
		{name:'SEQ',header:{text:'발주순번'},width:60,styles:{textAlignment:'right'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100},		
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}}
	];

	//그리드 생성
	$('#' + gid).gfn_createGrid(columns);
	
}

function grid3_P100300_popup_Load() {
	var gid = 'grid3_P100300_popup';
	var columns = [
		{name:'POKEY',header:{text:'발주번호'},width:120},
		{name:'ITEMCD',header:{text:'품목코드'},width:80},
		{name:'ITEMNM',header:{text:'품목명'},width:150},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'POSCHDT',header:{text:'발주일자'},width:90,formatter:'date',styles:{textAlignment:'center'}},
		{name:'DELIVDT',header:{text:'납기일1차'},width:90,formatter:'date',styles:{textAlignment:'center'}},
		{name:'WISCHDT',header:{text:'납기일2차'},width:90,formatter:'date',styles:{textAlignment:'center'}},
		{name:'POQTY',header:{text:'발주수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'AVAILABLEQTY',header:{text:'적용가능수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'UNITPRICE',header:{text:'단가'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'AVAILABLESUPPLYAMT',header:{text:'입고금액'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'SUPPLYAMT',header:{text:'발주금액'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},	
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'}, visible:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100, visible:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100, visible:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100, visible:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100, visible:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100, visible:cfn_getCompItemVisible(15)},
		{name:'REMARK',header:{text:'비고'},width:300},
		{name:'COKEY',header:{text:'구매번호'},width:120},
		{name:'COSEQ',header:{text:'구매순번'},width:60,styles:{textAlignment:'right'}},
		{name:'SEQ',header:{text:'발주순번'},width:60,styles:{textAlignment:'right'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100},		
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true});
}

/* 검색 */
function fn_P100300_popup_search() {
	var tabidx = cfn_getTabIdx('tab1');
	var paramData = cfn_getFormData('frm_search_P100300_popup');
	
	if (tabidx === 1) {
		var sendData = {'paramData':paramData};
		var url = '/alexcloud/p100/p100300_popup/getSearch.do';
		
		gfn_ajax(url, true, sendData, function(data, xhr) {
			$('#grid2_P100300_popup').dataProvider().clearRows();
			$('#grid1_P100300_popup').gfn_setDataList(data.resultList).gridView().setCurrent({itemIndex:0});
		});	
	} else if (tabidx === 2) {
		var sendData = {'paramData':paramData};
		var url = '/alexcloud/p100/p100300_popup/getDetailList2.do';

		gfn_ajax(url, true, sendData, function(data, xhr) {
			$('#grid3_P100300_popup').gfn_setDataList(data.resultList);
		
		});	
	}
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sendData = {'paramData':param};
	var url = '/alexcloud/p100/p100300_popup/getDetailList.do'; 
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid2_P100300_popup').gfn_setDataList(data.resultList);
	});
}
</script>