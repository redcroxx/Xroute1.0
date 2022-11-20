<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000016
	화면명    : 부서 관리
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<ul class="sech_ul">
			<li class="sech_li">
				<div>회사</div>
				<div>
					<input type="text" id="S_COMPCD" class="cmc_code" />				
					<input type="text" id="S_COMPNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li">
				<div>사업장</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code" />
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li">
				<div>부서코드/명</div>
				<div>
					<input type="text" id="S_DEPT" class="cmc_txt" />
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_top_wrap">
	<div class="ct_left_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">부서 리스트<span>(총 0건)</span></div>
			<div class="grid_top_right"></div>		
		</div>
		<div id="grid1"></div>
	</div>
	<div class="ct_right_wrap fix" style="width:700px">
		<form id="frmDetail" action="#" onsubmit="return false">
		<input type="hidden" id="COMPCD" name="COMPCD" />
		<input type="hidden" id="LVL" name="LVL" />
		
		<table class="tblForm" style="min-width:400px">
			<caption>부서정보</caption>
			<colgroup>
				<col width="120px" />
				<col />
			</colgroup>
			<tr>
				<th>사업장</th>
				<td>
					<input type="text" id="ORGCD" class="cmc_code disabled" readonly="readonly" />
					<input type="text" id="ORGNM" class="cmc_value disabled" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<th>상위부서</th>
				<td>
					<input type="text" id="PDEPTCD" class="cmc_code disabled" readonly="readonly" />
					<input type="text" id="PDEPTNM" class="cmc_value disabled" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<th>단계</th>
				<td>
					<input type="text" id="LVLNAME" class="cmc_txt disabled" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<th class="required">부서코드</th>
				<td>
					<input type="text" id="DEPTCD" class="cmc_txt required disabled" maxlength="20" readonly="readonly" tabindex="1" />
				</td>
			</tr>
			<tr>
				<th class="required">부서명</th>
				<td>
					<input type="text" id="DEPTNM" class="cmc_txt required disabled" maxlength="100" readonly="readonly" tabindex="2" />
				</td>
			</tr>
			<tr>
				<th>정렬순서</th>
				<td>
					<input type="text" id="SORTNO" class="cmc_txt disabled" maxlength="10" readonly="readonly" tabindex="3" />
				</td>
			</tr>
			<tr>
				<th>비고</th>
				<td>
					<input type="text" id="REMARK" class="cmc_txt disabled" style="width:100%" maxlength="255" readonly="readonly" tabindex="4" />
				</td>
			</tr>
		</table>
		</form>
	</div>
</div>
<div class="ct_bot_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">부서별 사용자<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>		
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
	
	//회사 코드/명
	pfn_codeval({
		url:'/alexcloud/popup/popP001/view.do',codeid:'S_COMPCD',
		inparam:{S_COMPCD:'S_COMPCD,S_COMPNM'},
		outparam:{COMPCD:'S_COMPCD',NAME:'S_COMPNM'}
	});
	//사업장 코드/명
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD', S_COMPNM:'S_COMPNM', S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD); 
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_ISUSING').val('Y');
	
	grid1_Load();
	grid2_Load();
});

function grid1_Load() {
	var gid = 'grid1', $grid = $('#' + gid);
	var columns = [
		{name:'DEPTINFO',header:{text:'조직정보'},width:200},
		{name:'DEPTCD',header:{text:'부서코드'},width:100},
		{name:'DEPTNM',header:{text:'부서명'},width:130},
		{name:'LVLNAME',header:{text:'단계'},width:80,styles:{textAlignment:'center'}},	
		{name:'SORTNO',header:{text:'정렬순서'},width:80,styles:{textAlignment:'far'}},
		{name:'COMPNM',header:{text:'회사명'},width:100},
		{name:'REMARK',header:{text:'비고'},width:200},
		{name:'LVL',header:{text:'부서레벨'},width:80,styles:{textAlignment:'far'},visible:false},	
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'ORGCD',header:{text:'사업장코드'},width:100,visible:false},
		{name:'ORGNM',header:{text:'사업장명'},width:100,visible:false},
		{name:'DEPTTREE',header:{text:'트리'},width:150,show:false}
	];
	$grid.gfn_createGrid(columns, {treeflg:true,panelflg:false,footerflg:false,sortable:false,fitStyle:'even'});
	
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var rowData = dataProvider.getJsonRow(newRowIdx);
				if (!cfn_isEmpty(rowData.DEPTCD)) {
					cfn_clearFormData('frmDetail');
					fn_getDetail(rowData);
				} else {
					cfn_clearFormData('frmDetail');
					cfn_formAllDisable(['frmDetail']);
					$('#grid2').dataProvider().clearRows();
				}
			}
		};
	});
}

function grid2_Load() {
	var gid = 'grid2', $grid = $('#' + gid);
	var columns = [
		{name:'USERCD',header:{text:'사용자코드'},width:100},
		{name:'USERNM',header:{text:'사용자명'},width:120},
		{name:'POSITION',header:{text:'직급'},width:100},
		{name:'PHONENO',header:{text:'연락처'},width:120,styles:{textAlignment:'center'}},	
		{name:'EMAIL',header:{text:'이메일'},width:180},
		{name:'SEX',header:{text:'성별'},width:80,formatter:'combo',comboValue:'${GCODE_SEX}',styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'COMPNM',header:{text:'회사명'},width:120},
		{name:'ORGCD',header:{text:'사업장코드'},width:100},
		{name:'ORGNM',header:{text:'사업장명'},width:120},
		{name:'DEPTCD',header:{text:'부서코드'},width:100},
		{name:'DEPTNM',header:{text:'부서명'},width:120}
	];
	$grid.gfn_createGrid(columns, {footerflg:false});
}

//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		var gridData = data.resultList;
		var resultData = data.resultData;
		var $grid1 = $('#grid1');
		
		cfn_clearFormData('frmDetail');
		$('#grid2').dataProvider().clearRows();
		$grid1.dataProvider().setRows(gridData, 'DEPTTREE', false);
		$grid1.gridView().expandAll();
		
		if (!cfn_isEmpty(resultData.S_DEPT)) {
			var rowidxs = [], i = 0;
			do {
				i = $grid1.gridView().searchItem({fields:['DEPTCD','DEPTNM'],values:[resultData.S_DEPT,resultData.S_DEPT],allFields:false,partialMatch:true,select:false,startIndex:i,wrap:false});
				if (i !== -1) {
					rowidxs.push($grid1.gridView().getDataRow(i));
					rowidxs = rowidxs.concat($grid1.dataProvider().getAncestors($grid1.gridView().getDataRow(i)));
					i++;
				}
			} while (i >= 0);
				
			rowidxs = rowidxs.reduce(function(a, b) {
				if (a.indexOf(b) < 0 ) a.push(b);
				return a;
			},[]).sort(function(a, b){
				return a - b;
			});
			
			gridData = $grid1.gfn_getDataRows(rowidxs);
			
			$grid1.dataProvider().setRows(gridData, 'DEPTTREE', false);
			$grid1.gridView().expandAll();
		}

		//검색결과에 따른 마스터 데이터 포커스 이동 처리
		$grid1.gfn_focusPK();
	}
	//상세 검색
	else if (sid == 'sid_getDetail') {
		var formData = data.resultData;
		var gridData = data.resultList;
		
		$('#DEPTCD').prop('readonly', true).addClass('disabled');
		$('#DEPTNM').prop('readonly', false).removeClass('disabled').attr('tabindex', '1');
		$('#SORTNO').prop('readonly', false).removeClass('disabled').attr('tabindex', '2');
		$('#REMARK').prop('readonly', false).removeClass('disabled').attr('tabindex', '3');
		cfn_setIDUR('U');
		cfn_bindFormData('frmDetail', formData);
		$('#grid2').gfn_setDataList(gridData);
	}
	//저장
	else if (sid === 'sid_setSave') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','ORGCD','DEPTCD']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//삭제
	else if (sid === 'sid_setDelete') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','ORGCD','DEPTCD']);
		cfn_msg('INFO', '정상적으로 삭제되었습니다.');
		cfn_retrieve();
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000016/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);			
}

//상세 검색
function fn_getDetail(param) {
	var sid = 'sid_getDetail';
	var url = '/alexcloud/p000/p000016/getDetail.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

//공통버튼 - 신규 클릭
function cfn_new() {
	cfn_setIDUR('I');
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx > -1) {
		var rowData = $('#grid1').gfn_getDataRow(rowidx);
		
		if (cfn_castNum(rowData.LVL) >= 3) {
			cfn_msg('WARNING', '하위 부서 생성은 3단계까지만 가능합니다.');
			return false;
		}
		
		$('#grid2').dataProvider().clearRows();
		cfn_clearFormData('frmDetail');
		$('#COMPCD').val(rowData.COMPCD);
		$('#ORGCD').val(rowData.ORGCD);
		$('#ORGNM').val(rowData.ORGNM);
		$('#PDEPTCD').val(cfn_isEmpty(rowData.DEPTCD) ? '*' : rowData.DEPTCD);
		$('#PDEPTNM').val(rowData.DEPTNM);
		$('#DEPTCD').attr('disabled',false).prop('readonly', false).removeClass('disabled').attr('tabindex', '1').focus();
		$('#DEPTNM').attr('disabled',false).prop('readonly', false).removeClass('disabled').attr('tabindex', '2');
		$('#SORTNO').attr('disabled',false).prop('readonly', false).removeClass('disabled').attr('tabindex', '3').val('10');
		$('#REMARK').attr('disabled',false).prop('readonly', false).removeClass('disabled').attr('tabindex', '4');
		$('#LVL').val(cfn_castNum(rowData.LVL) + 1);
		$('#LVLNAME').val(cfn_castNum(rowData.LVL) + 1);
	}
}

//공통버튼 - 저장 클릭
function cfn_save(directmsg) {
	var formData = cfn_getFormData('frmDetail');
	formData.IDU = cfn_getIDUR();

	//필수 체크
	if (!cfn_isFormRequireData('frmDetail')) return false;
	
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}
	
	if (flg) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/p000016/setSave.do';
		var sendData = {'paramData':formData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 삭제 클릭
function cfn_del() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 부서가 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	var usercnt = $('#grid2').dataProvider().getRowCount();
	
	if (cfn_isEmpty(masterData.DEPTCD)) {
		cfn_msg('WARNING', '최상위 사업장은 삭제할 수 없습니다.');
		return false;
	}
	
	if (usercnt > 0) {
		cfn_msg('WARNING', '해당 부서코드 [' + masterData.DEPTCD + '] 에 사용자가 존재하여 삭제가 불가능 합니다.');
		return false;
	}
	
	var childIdxs = $('#grid1').dataProvider().getChildren(rowidx);
	var delList = $('#grid1').gfn_getDataRows(childIdxs);
	
	delList.push(masterData);
	
	if (confirm('부서코드 [' + masterData.DEPTCD + '] 항목을 삭제 하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000016/setDelete.do';
		var sendData = {'paramList':delList};
		
		gfn_sendData(sid, url, sendData);
	}
}
</script>

<c:import url="/comm/contentBottom.do" />