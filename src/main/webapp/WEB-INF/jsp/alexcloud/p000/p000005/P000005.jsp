<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000005
	화면명    : 로케이션 관리
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
				<div>창고코드/명</div>
				<div>
					<input type="text" id="S_WH" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li">
				<div>로케이션/명</div>
				<div>
					<input type="text" id="S_LOC" class="cmc_txt" style="ime-mode:inactive;"/>
				</div>
			</li>
			
		</ul>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>LOC사용여부</div>
				<div>
					<select id="S_ISUSING" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_ISUSING}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li">
				<div>로케이션타입</div>
				<div>
					<select id="S_LOCTYPE" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_LOCTYPE}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li">
				<div>로케이션 유형</div>
				<div>
					<select id="S_LOCGROUP" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_LOCGROUP}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li">
				<div>층</div>
				<div>
					<input type="text" id="S_FLOOR" class="cmc_txt" />
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_top_wrap fix" style="height:200px">

	<div class="ct_left_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">창고 리스트<span>(총 0건)</span></div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid1"></div>
	</div>
	
	<div class="ct_right_wrap fix" style="width:450px">
	 	<!-- <div class="grid_top_wrap">
			<div class="grid_top_right">
				<input type="button" id="btn_upload" class="cmb_normal" value="업로드" onclick="pfn_upload('P000005');" />
				<button type="button" id="btn_loccreate" class="cmb_normal" onclick="fn_loccreate()">LOC 생성</button>
			</div>
		</div> -->
		<div class="ct_left_wrap fix" style="width:195px">
			<div class="ct_left_wrap fix" style="width:80px">
				<div class="grid_top_wrap">
				</div>
				<div id="grid1_1"></div>
			</div>
			<div class="ct_right_wrap">
				<div class="grid_top_wrap">
				</div>
				<div id="grid1_2"></div>
			</div>
		</div>
		<div class="ct_right_wrap">
			<div class="ct_left_wrap fix" style="width:98px">
			 	<div class="grid_top_wrap">
				</div>
				<div id="grid1_3"></div>
			</div>
			<div class="ct_right_wrap">
				<div class="grid_top_wrap">
					<div  class="grid_top_right">
						<input type="button" id="btn_upload" class="cmb_normal" value="업로드" style="position: absolute;right: 95px" onclick="pfn_upload('P000005');" />
						<button type="button" id="btn_loccreate" class="cmb_normal" onclick="fn_loccreate()">LOC 생성</button>
					</div>
				</div>
				<div id="grid1_4"></div>
			</div>
		</div>
	</div>
	
</div>

<div class="ct_bot_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">로케이션 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<button type="button" id="btn_grid2Add" class="cmb_plus" onclick="fn_grid2AddRow()"></button>
			<button type="button" id="btn_grid2Del" class="cmb_minus" onclick="fn_grid2DelRow()"></button>
		</div>		
	</div>
	<div id="grid2"></div>
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
	setCommBtn('del', null, '미사용');
	setCommBtn('print', null, '라벨출력');
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM); 
	
	$('#S_ISUSING').val('Y');
	
	grid1_Load();
	grid1_1_Load();
	grid1_2_Load();
	grid1_3_Load();
	grid1_4_Load();
	grid2_Load();
	
	fn_getLocZoneInfo();
	authority_Load();
});

function authority_Load(){
	
	if (cfn_loginInfo().USERGROUP == '${SELLER_ADMIN}' || cfn_loginInfo().USERGROUP == '${CENTER_ADMIN}') {
		$('#S_WH').val(cfn_loginInfo().WHCD);
		$('#S_WH').prop("disabled",true);
 	}
	
};

function grid1_Load() {
	var gid = 'grid1', $grid = $('#' + gid);
	var columns = [
		{name:'ISUSING',header:{text:'사용여부'},width:100,formatter:'combo',comboValue:'${GCODE_ISUSING}',
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = "Y"',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = "N"',styles:{figureBackground:cfn_getStsColor(0)}}
				]
		},
		{name:'WHCD',header:{text:'창고코드'},width:120},
		{name:'NAME',header:{text:'창고명'},width:180},
		{name:'WHTYPE',header:{text:'창고유형'},width:100,formatter:'combo',comboValue:'${GCODE_WHTYPE}',styles:{textAlignment:'center'}},
		{name:'POST',header:{text:'우편번호'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDR1',header:{text:'주소'},width:300},
		{name:'ADDR2',header:{text:'주소상세'},width:200},
		{name:'WHINLOCCD',header:{text:'입고로케이션'},width:120},
		{name:'WHOUTLOCCD',header:{text:'CART출고로케이션'},width:120},
		{name:'DPSLOCCD',header:{text:'DPS출고로케이션'},width:120},
		{name:'RETURNLOCCD',header:{text:'반품입고로케이션'},width:120},
		{name:'ASSYLOCCD',header:{text:'가공로케이션'},width:120},
		{name:'CANCELLOCCD',header:{text:'취소로케이션'},width:120},
		/*{name:'CUSTCD',header:{text:'지정거래처코드'},width:120},
		{name:'CUSTNM',header:{text:'지정거래처명'},width:160},*/
		{name:'REMARK',header:{text:'비고'},width:400},
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:120,visible:false,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:120,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},visible:false,show:false}
	];
	$grid.gfn_createGrid(columns, {footerflg:false,editable:true});
	
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			if (oldIndex.dataRow !== -1 && oldIndex.dataRow !== newIndex.dataRow) {
				var grid2Data = $('#grid2').gfn_getDataList(false);
				var state = dataProvider.getRowState(oldIndex.dataRow);
							
				if (state === 'updated' || state === 'created' || grid2Data.length > 0) {
					if (confirm('변경된 내용이 있습니다. 저장하시겠습니까?')) {
						cfn_save('Y');
					}
					return false;
				}
			} 
		};
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var editable = $grid.gfn_getValue(newRowIdx, 'ISUSING') === 'Y';
				$('#grid2').gfn_setRowDisabled(editable, ['COMPCD','WHCD','LOCCD'/* ,'CUSTNM' */]);	
			}
			
			var masterData = $grid.gfn_getDataRow(newRowIdx);
			
			if(!cfn_isEmpty(masterData.WHCD)) {
				var param = {'WHCD':masterData.WHCD, 'COMPCD':masterData.COMPCD};
				
				fn_getDetailList(param);
			}
		};
	});
}

function grid1_1_Load() {
	var gid = 'grid1_1', $grid = $('#' + gid);
	var columns = [
		{name:'NAME',header:{text:'존'},width:50,styles:{textAlignment:'center'}},
		{name:'CODE',header:{text:'존코드'},width:50,styles:{textAlignment:'center'},visible:false}
	];
	$grid.gfn_createGrid(columns, 
		{indicator:false,sortable:false,contextmenu:false,footerflg:false,headerSelectFocusVisible:false,fitStyle:'even'});
}

function grid1_2_Load() {
	var gid = 'grid1_2', $grid = $('#' + gid);
	var columns = [
		{name:'NAME',header:{text:'행'},width:50,styles:{textAlignment:'center'}},
		{name:'CODE',header:{text:'행코드'},width:50,styles:{textAlignment:'center'},visible:false}
	];
	$grid.gfn_createGrid(columns, 
		{indicator:false,checkBar:true,sortable:false,contextmenu:false,footerflg:false,headerSelectFocusVisible:false,fitStyle:'even',cellFocusVisible:false});
}

function grid1_3_Load() {
	var gid = 'grid1_3', $grid = $('#' + gid);
	var columns = [
		{name:'NAME',header:{text:'열'},width:50,styles:{textAlignment:'center'}},
		{name:'CODE',header:{text:'열코드'},width:50,styles:{textAlignment:'center'},visible:false}
	];
	$grid.gfn_createGrid(columns, 
		{indicator:false,checkBar:true,sortable:false,contextmenu:false,footerflg:false,headerSelectFocusVisible:false,fitStyle:'even',cellFocusVisible:false});
}
function grid1_4_Load() {
	var gid = 'grid1_4', $grid = $('#' + gid);
	var columns = [
		{name:'NAME',header:{text:'단'},width:50,styles:{textAlignment:'center'}},
		{name:'CODE',header:{text:'단코드'},width:50,styles:{textAlignment:'center'},visible:false}
	];
	$grid.gfn_createGrid(columns, 
		{indicator:false,checkBar:true,sortable:false,contextmenu:false,footerflg:false,headerSelectFocusVisible:false,fitStyle:'even',cellFocusVisible:false});
}

function grid2_Load() {
	var gid = 'grid2', $grid = $('#' + gid);
	var columns = [
		{name:'ISUSING',header:{text:'사용여부'},width:100,formatter:'combo',comboValue:'${GCODE_ISUSING}',
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = "Y"',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = "N"',styles:{figureBackground:cfn_getStsColor(0)}}
			]
		},
		{name:'LOCCD',header:{text:'로케이션코드'},width:120,editable:true,required:true,editor:{maxLength:20}},
		{name:'LOCNAME',header:{text:'로케이션명'},width:120,editable:true,required:true,editor:{maxLength:100}},
		{name:'LOCGROUP',header:{text:'로케이션유형'},width:100,formatter:'combo',comboValue:'${GCODE_LOCGROUP}',styles:{textAlignment:'center'},
			editable:true,editor:{maxLength:5}
		},
		{name:'ISVIRTUAL',header:{text:'가상여부'},width:100,formatter:'combo',comboValue:'${GCODE_YN}',styles:{textAlignment:'center'},
			editable:true,editor:{maxLength:1}
		},
		{name:'LOCTYPE',header:{text:'로케이션타입'},width:100,formatter:'combo',comboValue:'${GCODE_LOCTYPE}',styles:{textAlignment:'center'},
			editable:true,editor:{maxLength:5}
		},
		{name:'BUIL',header:{text:'동'},width:60,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20}},
		{name:'FLOOR',header:{text:'층'},width:60,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20}},
		{name:'ZONE',header:{text:'존'},width:60,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20}},
		{name:'LINE',header:{text:'행'},width:60,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20}},
		{name:'RANGE',header:{text:'열'},width:60,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20}},
		{name:'STEP',header:{text:'단'},width:60,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20}},
		{name:'LANE',header:{text:'레인'},width:60,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20}},
		{name:'NOTALLOCFLG',header:{text:'할당금지여부'},width:100,formatter:'combo',comboValue:'${GCODE_NOTALLOCFLG}',styles:{textAlignment:'center'},
			editable:true,editor:{maxLength:1}
		},
		/*{name:'CUSTCD',header:{text:'지정거래처코드'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP003/view.do',
				inparam:{S_COMPCD:'COMPCD',S_CUSTCD:'CUSTCD'},outparam:{CUSTCD:'CUSTCD',NAME:'CUSTNM'}}
		},
		{name:'CUSTNM',header:{text:'지정거래처명'},width:160},*/
		{name:'SLOTTYPE',header:{text:'입고유형'},width:120,formatter:'combo',comboValue:'${GCODE_SLOTTYPE}',styles:{textAlignment:'center'},
			editable:true,editor:{maxLength:5}
		},
		{name:'PICKTYPE',header:{text:'피킹유형'},width:120,formatter:'combo',comboValue:'${GCODE_PICKTYPE}',styles:{textAlignment:'center'},
			editable:true,editor:{maxLength:5}
		},
		{name:'ALLOCATETYPE',header:{text:'할당유형'},width:120,formatter:'combo',comboValue:'${GCODE_ALLOCATETYPE}',styles:{textAlignment:'center'},
			editable:true,editor:{maxLength:5}
		},
		{name:'WHINSEQ',header:{text:'입고순번'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editable:true,editor:{maxLength:10, type: "number", positiveOnly: true, integerOnly: true}},
		{name:'WHOUTSEQ',header:{text:'출고순번'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editable:true,editor:{maxLength:10, type: "number", positiveOnly: true, integerOnly: true}},
		{name:'LENGTH',header:{text:'깊이'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0.###'},editable:true,editor:{maxLength:17, type: "number", positiveOnly: true, integerOnly: true}},
		{name:'WIDTH',header:{text:'폭'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0.###'},editable:true,editor:{maxLength:17, type: "number", positiveOnly: true, integerOnly: true}},
		{name:'HEIGHT',header:{text:'높이'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0.###'},editable:true,editor:{maxLength:17, type: "number", positiveOnly: true, integerOnly: true}},
		{name:'WEIGHTCAPACITY',header:{text:'가용중량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0.###'},editable:true,editor:{maxLength:17, type: "number", positiveOnly: true, integerOnly: true}},
		{name:'CAPACITY',header:{text:'가용수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0.###'},editable:true,editor:{maxLength:17, type: "number", positiveOnly: true, integerOnly: true}},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
		{name:'WHCD',header:{text:'창고코드'},width:100,visible:false,show:false}
	];
	$grid.gfn_createGrid(columns, {footerflg:false,editable:true,mstGrid:'grid1'});
	
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var state = dataProvider.getRowState(newRowIdx);
				var rowData = $grid.gfn_getDataRow(newRowIdx);
				
				if (rowData.ISUSING === 'N') {
					setCommBtn('del', null, '사용', {iconname:'btn_on.png'});
				} else {
					setCommBtn('del', null, '미사용', {iconname:'btn_del.png'});
				}
				
				var editable = state === 'created';
				$grid.gfn_setColDisabled(['LOCCD'], editable);
			}
		};
	});
}

//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').dataProvider().clearRows();
		
		$('#grid1').gfn_setDataList(data.resultList);
		
		$('#grid1').gfn_focusPK();
	} else if (sid == 'sid_getDetailList') {
		//디테일 검색
		var gridData = data.resultList;
		
		$('#grid2').gfn_setDataList(gridData);
	} else if (sid == 'sid_getLocZoneInfo') {
		//존행열단 검색
		var zoneList = data.resultZoneList;
		var lineList = data.resultLineList;
		var rangeList = data.resultRangeList;
		var stepList = data.resultStepList;
		
		$('#grid1_1').gfn_setDataList(zoneList);
		$('#grid1_2').gfn_setDataList(lineList);
		$('#grid1_3').gfn_setDataList(rangeList);
		$('#grid1_4').gfn_setDataList(stepList);
	} else if (sid === 'sid_setSave') {
		//저장
		var resultData = data.resultData;
		
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','WHCD']);
		
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		
		cfn_retrieve();
	} else if (sid === 'sid_setDelete') {
		//삭제 (사용/미사용)
		var resultData = data.resultData;
		
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','WHCD']);
		
		cfn_msg('INFO', '정상적으로 처리되었습니다.');
		cfn_retrieve();
	} else if (sid === 'sid_setLocCreate') {
		//로케이션 일괄 생성
		var resultData = data.resultData;
		
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','WHCD']);
		
		cfn_msg('INFO', '정상적으로 처리되었습니다.');
		cfn_retrieve();
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	$('#grid2').gridView().cancel();
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000005/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

//공통버튼 - 신규 클릭
function cfn_new() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택한 창고가 없습니다.');
		return false;
	}
	
	var compcd = $('#grid1').gfn_getValue(rowidx, 'COMPCD');
	var whcd = $('#grid1').gfn_getValue(rowidx, 'WHCD');
	
	$('#grid2').gfn_addRow({COMPCD:compcd, WHCD:whcd, ISVIRTUAL:'N', NOTALLOCFLG:'N', ISUSING:'Y'});
}

//공통버튼 - 저장 클릭
function cfn_save(directmsg) {
	$('#grid2').gridView().commit();
	
	var $grid2 = $('#grid2');
	var masterList = $grid2.gfn_getDataList();
	
	//if (masterList.length < 1) {
	//	cfn_msg('WARNING', '변경된 항목이 없습니다.');
	//	return false;
	//}

	//변경RowIndex 추출
	//var states = $grid2.dataProvider().getAllStateRows();
	//var stateRowidxs = states.updated;
	//stateRowidxs = stateRowidxs.concat(states.created);
	
	//필수입력 체크
	//if ($grid2.gfn_checkValidateCells(stateRowidxs)) return false;
	
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}

	if (flg) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/p000005/setSave.do';
		var sendData = {'paramList':masterList};
		
		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 삭제 (사용/미사용) 클릭
function cfn_del() {
	$('#grid2').gridView().commit(true);
	
	var $grid2 = $('#grid2');
	var rowidx = $grid2.gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 로케이션이 없습니다.');
		return false;
	}
	
	var state = $grid2.dataProvider().getRowState(rowidx);
	
	if (state === 'created') {
		cfn_msg('WARNING', '신규 항목은 불가능 합니다.');
		return false;
	}
	
	var rowData = $grid2.gfn_getDataRow(rowidx);
	var delstr = rowData.ISUSING === 'N' ? '사용' : '미사용';
	
	if (confirm('로케이션코드 [' + rowData.LOCCD + '] 항목을 ' + delstr + ' 처리하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000005/setDelete.do';
		var sendData = {'paramData':rowData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 라벨출력 클릭
function cfn_print() {
	$('#grid2').gridView().commit(true);
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택한 창고가 없습니다.');
		return false;
	}
	
	var compcd = $('#grid1').gfn_getValue(rowidx, 'COMPCD');
	var whcd = $('#grid1').gfn_getValue(rowidx, 'WHCD');

	pfn_popupOpen({
		url: '/alexcloud/p000/p000005/viewPopup.do',
		pid: 'P000005_popup',
		params: {COMPCD: compcd, WHCD: whcd}
	});
}

//디테일 검색
function fn_getDetailList(param) {
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p000/p000005/getDetailList.do';
	var sendData = {'paramData':gv_searchData, 'COMPCD': param.COMPCD, 'WHCD':param.WHCD};
	
	gfn_sendData(sid, url, sendData);
}

//존행열단 검색
function fn_getLocZoneInfo() {
	var sid = 'sid_getLocZoneInfo';
	var url = '/alexcloud/p000/p000005/getLocZoneInfo.do';
	var sendData = {'paramData':{COMPCD:cfn_loginInfo().COMPCD}};
	
	gfn_sendData(sid, url, sendData);
}

//존행열단 로케이션 일괄생성
function fn_loccreate() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택한 창고가 없습니다.');
		return false;
	}
	
	var mData = $('#grid1').gfn_getDataRow(rowidx);
	var checkRow1 = $('#grid1_1').gfn_getCurRowIdx();
	var checkRows2 = $('#grid1_2').gridView().getCheckedRows();
	var checkRows3 = $('#grid1_3').gridView().getCheckedRows();
	var checkRows4 = $('#grid1_4').gridView().getCheckedRows();
	
	if (checkRow1 < 0) {
		cfn_msg('WARNING', '선택한 존이 없습니다.');
		return false;
	} else if (checkRows2.length < 1) {
		cfn_msg('WARNING', '선택한 행이 없습니다.');
		return false;
	} else if (checkRows3.length < 1) {
		cfn_msg('WARNING', '선택한 열이 없습니다.');
		return false;
	} else if (checkRows4.length < 1) {
		cfn_msg('WARNING', '선택한 단이 없습니다.');
		return false;
	}
	
	if (confirm('로케이션코드 일괄 생성하시겠습니까?')) {
		var zoneData = $('#grid1_1').gfn_getDataRow(checkRow1);
		var lineList = $('#grid1_2').gfn_getDataRows(checkRows2);
		var rangeList = $('#grid1_3').gfn_getDataRows(checkRows3);
		var stepList = $('#grid1_4').gfn_getDataRows(checkRows4);
		
		var sid = 'sid_setLocCreate';
		var url = '/alexcloud/p000/p000005/setLocCreate.do';
		var sendData = {mData:mData, zoneData:zoneData, lineList:lineList, rangeList:rangeList, stepList:stepList};
		
		gfn_sendData(sid, url, sendData);
	}
}

//그리드2 행추가 버튼 클릭
function fn_grid2AddRow() {
	cfn_new();
}	

//그리드2 행삭제 버튼 클릭
function fn_grid2DelRow() {
	var $grid2 = $('#grid2');
	var rowidx = $grid2.gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	var state = $grid2.dataProvider().getRowState(rowidx);
	
	if (state === 'created') {
		$grid2.gfn_delRow(rowidx);
	} else {
		cfn_msg('WARNING', '기등록 항목은 삭제할 수 없습니다.');
	}
}
</script>

<c:import url="/comm/contentBottom.do" />