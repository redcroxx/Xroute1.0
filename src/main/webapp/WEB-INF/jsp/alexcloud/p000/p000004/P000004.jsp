<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst" %>
<!-- 
	화면코드 : P000004
	화면명    : 창고 관리
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
					<input type="text" id="S_WHCD" class="cmc_code" />
					<input type="text" id="S_WHNM" class="cmc_value" />
					<button type="button" id="S_WHCD_BTN" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li id="selectHide" class="sech_li">
				<div>사용여부</div>
				<div>
					<select id="S_ISUSING" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_ISUSING}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">창고<span>(총 0건)</span></div>
		<div class="grid_top_right" >
		    <div id="gridTopRight">
			<button type="button" id="btn_grid1Add" class="cmb_plus" onclick="fn_grid1AddRow()"></button>
			<button type="button" id="btn_grid1Del" class="cmb_minus" onclick="fn_grid1DelRow()"></button>
			</div>
		</div>		
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

	setCommBtn('del', null, '미사용');
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM); 
	$('#S_ISUSING').val('Y');

	if (cfn_loginInfo().USERGROUP == '${SELLER_ADMIN}' || cfn_loginInfo().USERGROUP == '${CENTER_ADMIN}') {
		$('#S_WHCD').val(cfn_loginInfo().WHCD);
		$('#S_WHNM').val(cfn_loginInfo().WHNM);
		$('#S_WHCD').prop("disabled",true);
		$('#S_WHNM').prop("disabled",true);
		$('#S_WHCD_BTN').prop("disabled",true);
		$('#selectHide').hide();
// 	} else if(cfn_loginInfo().USERGROUP == '${XROUTE_ADMIN}'){
		//TODO disabled 제거
	}
	// +, - 버튼 표시제어
	if (cfn_loginInfo().USERGROUP == '${SELLER_ADMIN}') {
		document.getElementById("gridTopRight").style.display = 'none';
	} else {
		document.getElementById("gridTopRight").style.display = 'block';
	}
	
	/* 창고 */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'S_WHCD,S_WHNM'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	
	authority_Load();
	grid1_Load();
	cfn_retrieve();
});

function authority_Load(){
	if (cfn_loginInfo().USERGROUP != '${XROUTE_ADMIN}') {
		$('#S_WHCD').val(cfn_loginInfo().WHCD);
		$('#S_WHCD').prop("disabled",true);
 	}
};

function grid1_Load() {
	var gid = 'grid1', $grid = $('#' + gid);
	var columns = [
		{name:'ISUSING',header:{text:'사용여부'},width:100,formatter:'combo',comboValue:'${GCODE_ISUSING}',
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = "Y"',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = "N"',styles:{figureBackground:cfn_getStsColor(0)}}]
		},
		{name:'WHCD',header:{text:'창고코드'},width:120,editable:true,required:true,editor:{maxLength:20}},
		{name:'NAME',header:{text:'창고명'},width:180,editable:true,required:true,editor:{maxLength:100}},
		{name:'WHTYPE',header:{text:'창고유형'},width:100,formatter:'combo',comboValue:'${GCODE_WHTYPE}',styles:{textAlignment:'center'},editable:true,editor:{maxLength:10}},
		{name:'WHINVTYPE',header:{text:'창고재고유형'},width:140,formatter:'combo',comboValue:'${GCODE_WHINVTYPE}',styles:{textAlignment:'center'},editable:true,editor:{maxLength:10}},
		{name:'POST',header:{text:'우편번호'},width:100,styles:{textAlignment:'center'},formatter:'popup',editable:true,editor:{maxLength:10},
			popupOption:{url:'/sys/popup/popPost/view.do',
				inparam:{POST:'POST'},outparam:{POST:'POST',ADDR:'ADDR1'}}
		},
		{name:'ADDR1',header:{text:'주소'},width:300,editable:true,editor:{maxLength:100}},
		{name:'ADDR2',header:{text:'주소상세'},width:200,editable:true,editor:{maxLength:100}},
		/* {name:'WHINLOCCD',header:{text:'입고로케이션'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
				inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'NAME',S_LOCCD:'WHINLOCCD'},outparam:{LOCCD:'WHINLOCCD'},params:{S_NOTALLOCFLG:'Y'}}
		},
		{name:'WHOUTLOCCD',header:{text:'CART출고로케이션'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
				inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'NAME',S_LOCCD:'WHOUTLOCCD'},outparam:{LOCCD:'WHOUTLOCCD'}}
		},
		{name:'DPSLOCCD',header:{text:'DPS출고로케이션'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
				inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'NAME',S_LOCCD:'DPSLOCCD'},outparam:{LOCCD:'DPSLOCCD'}}
		},
		{name:'RETURNLOCCD',header:{text:'반품입고로케이션'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
				inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'NAME',S_LOCCD:'RETURNLOCCD'},outparam:{LOCCD:'RETURNLOCCD'},params:{S_NOTALLOCFLG:'Y'}}
		},
		{name:'ASSYLOCCD',header:{text:'가공로케이션'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
				inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'NAME',S_LOCCD:'ASSYLOCCD'},outparam:{LOCCD:'ASSYLOCCD'},params:{S_NOTALLOCFLG:'Y'}}
		},
		{name:'CANCELLOCCD',header:{text:'취소로케이션'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
				inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'NAME',S_LOCCD:'CANCELLOCCD'},outparam:{LOCCD:'CANCELLOCCD'},params:{S_NOTALLOCFLG:'Y'}}
		}, */
		{name:'REMARK',header:{text:'비고'},width:400,editable:true,editor:{maxLength:255}},
		
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false, show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,visible:false, show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:120,styles:{textAlignment:'center'},visible:false, show:false},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'},visible:false, show:false},
		{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'},visible:false, show:false},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'},visible:false, show:false},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},visible:false, show:false},
	];
	$grid.gfn_createGrid(columns, {footerflg:false});
	
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
				$grid.gfn_setColDisabled(['WHCD'], editable);
			}
		};
	});
}

//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		var gridData = data.resultList;
		$('#grid1').gfn_setDataList(gridData);
		$('#grid1').gfn_focusPK();
	}
	//저장
	else if (sid === 'sid_setSave') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','WHCD']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//삭제 (사용/미사용)
	else if (sid === 'sid_setDelete') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','WHCD']);
		cfn_msg('INFO', '정상적으로 처리되었습니다.');
		cfn_retrieve();
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	$('#grid1').gridView().cancel();
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000004/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

//공통버튼 - 신규 클릭
function cfn_new() {
	$('#grid1').gridView().commit(true);
	$('#grid1').gfn_addRow({COMPCD:cfn_loginInfo().COMPCD, COMPNM:cfn_loginInfo().COMPNM, ISUSING:'Y'});
}

//공통버튼 - 저장 클릭
function cfn_save() {
	$('#grid1').gridView().commit(true);
	
	var $grid1 = $('#grid1');
	var masterList = $grid1.gfn_getDataList(false);
	
	if (masterList.length < 1) {
		cfn_msg('WARNING', '변경된 항목이 없습니다.');
		return false;
	}

	//변경RowIndex 추출
	var states = $grid1.dataProvider().getAllStateRows();
	var stateRowidxs = states.updated;
	stateRowidxs = stateRowidxs.concat(states.created);
	
	//필수입력 체크
	if ($grid1.gfn_checkValidateCells(stateRowidxs)) return false;
	
	if (confirm('저장하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/p000004/setSave.do';
		var sendData = {'paramList':masterList};
		
		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 삭제 (사용/미사용) 클릭
function cfn_del() {
	$('#grid1').gridView().commit(true);
	
	var $grid1 = $('#grid1');
	var rowidx = $grid1.gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 창고가 없습니다.');
		return false;
	}
	
	var state = $grid1.dataProvider().getRowState(rowidx);
	
	if (state === 'created') {
		cfn_msg('WARNING', '신규 항목은 불가능 합니다.');
		return false;
	}
	
	var rowData = $grid1.gfn_getDataRow(rowidx);
	var delstr = rowData.ISUSING === 'N' ? '사용' : '미사용';
	
	if (confirm('창고코드 [' + rowData.WHCD + '] 항목을 ' + delstr + ' 처리하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000004/setDelete.do';
		var sendData = {'paramData':rowData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//그리드1 행추가 버튼 클릭
function fn_grid1AddRow() {
	cfn_new();
}	

//그리드1 행삭제 버튼 클릭
function fn_grid1DelRow() {
	var $grid1 = $('#grid1');
	var rowidx = $grid1.gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	var state = $grid1.dataProvider().getRowState(rowidx);
	
	if (state === 'created') {
		$grid1.gfn_delRow(rowidx);
	} else {
		cfn_msg('WARNING', '기등록 항목은 삭제할 수 없습니다.');
	}
}
</script>

<c:import url="/comm/contentBottom.do" />