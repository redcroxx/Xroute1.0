<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : S000010
	화면명    : 사용자 관리
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
				<div>사용자코드/명</div>
				<div>
					<input type="text" id="S_USER" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li">
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
		<ul class="sech_ul">
			<li class="sech_li">
				<div>권한</div>
				<div>
					<select id="S_USERGROUP" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_USERGROUP}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li">
				<div>소속</div>
				<div>
					<select id="S_DEPTCD" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_DEPTCD}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li">
				<div>셀러코드/명</div>
				<div>
					<input type="text" id="S_ITEM" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li">
			<div>창고</div>
			<div>
				<input type="text" id="S_WHCD" name="S_WHCD" class="cmc_code" />
				<input type="text" id="S_WHNM" name="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">사용자<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<button type="button" id="btn_grid1Add" class="cmb_plus" onclick="fn_grid1AddRow()"></button>
			<button type="button" id="btn_grid1Del" class="cmb_minus" onclick="fn_grid1DelRow()"></button>
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
		setCommBtn('init', null, '비번초기화');
		setCommBtnSeq(['ret','new','save','init','del']);
		
		$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
		$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
		$('#S_ISUSING').val('Y');
		
		/* 창고 */
		pfn_codeval({
			url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
			inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'S_WHCD,S_WHNM'},
			outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
		});
		
		grid1_Load();
	});

	function grid1_Load() {
		var gid = 'grid1', $grid = $('#' + gid);
		var columns = [
			{name:'ISUSING',header:{text:'사용여부'},width:100,formatter:'combo',comboValue:'${GCODE_ISUSING}',renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
				dynamicStyles:[
					{criteria:'value = "Y"',styles:{figureBackground:cfn_getStsColor(3)}},
					{criteria:'value = "N"',styles:{figureBackground:cfn_getStsColor(0)}}
				]
			},
			{name:'USERGROUP',header:{text:'사용자그룹'},width:100,required:true,formatter:'combo',comboValue:'${GCODE_USERGROUP}',styles:{textAlignment:'center'},editable:true,editor:{maxLength:20}},
			{name:'DEPTCD',header:{text:'소속'},width:120,formatter:'combo',required:true,comboValue:'${GCODE_DEPTCD}',styles:{textAlignment:'center'},editable:true,editor:{maxLength:10}},
			{name:'USERCD',header:{text:'사용자코드'},width:120,editable:true,required:true,editor:{maxLength:20}},
			{name:'NAME',header:{text:'사용자명'},width:140,editable:true,required:true,editor:{maxLength:100}},
			{name:'POSITION',header:{text:'직급'},width:100,editable:true,required:true,editor:{maxLength:50},styles:{textAlignment:'center'}},
			{name:'ORGCD',header:{text:'셀러코드'},width:100,formatter:'popup',editable:true,editor:{maxLength:20},popupOption:{url:'/alexcloud/popup/popP002/view.do', inparam:{S_COMPCD:'COMPCD',S_COMPNM:'COMPNM',S_ORGCD:'ORGCD'},outparam:{ORGCD:'ORGCD',NAME:'ORGNM'}}},
			{name:'ORGNM',header:{text:'셀러명'},width:120},
			{name:'WHCD',header:{text:'창고코드'},width:100,formatter:'popup',editable:true,editor:{maxLength:20}, popupOption:{url:'/alexcloud/popup/popP004/view.do', inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'WHNM'},outparam:{WHCD:'WHCD',NAME:'WHNM'}}},
			{name:'WHNM',header:{text:'창고명'},width:120},
			{name:'ISLOCK',header:{text:'잠김여부'},width:100,formatter:'checkbox'},
			{name:'PWDCHGDATE',header:{text:'최근비밀번호변경일시'},width:150,styles:{textAlignment:'center'}},
			{name:'PRINT1',header:{text:'프린터(라벨)'},width:120,editable:true},
			{name:'PRINT2',header:{text:'프린터(A4)'},width:120,editable:true},
			{name:'SCALE1',header:{text:'저울1'},width:120,editable:true},
			{name:'PHONENO',header:{text:'전화번호'},width:120,styles:{textAlignment:'center'},editable:true,editor:{maxLength:25}},
			{name:'FAX',header:{text:'팩스번호'},width:120,styles:{textAlignment:'center'},editable:true,editor:{maxLength:25}},
			{name:'EMAIL',header:{text:'이메일'},width:180,editable:true,editor:{maxLength:80}},
			{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false},
			{name:'COMPNM',header:{text:'회사명'},width:100,visible:false,show:false},
			{name:'USERGROUPNM',header:{text:'사용자그룹명'},width:70,visible:false,show:false,styles:{textAlignment:'center'}},
			{name:'ADDUSERCD',header:{text:'등록자'},width:120,styles:{textAlignment:'center'},visible:false,show:false},
			{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
			{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'},visible:false,show:false},
			{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'},visible:false,show:false},
			{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},visible:false,show:false}
		];
		$grid.gfn_createGrid(columns, {footerflg:false});
		
		//그리드설정 및 이벤트처리
		$grid.gfn_setGridEvent(function(gridView, dataProvider) {
			gridView.setRowGroup({
				headerStatement: '$'+'{groupValue}' + ' - ' + '$'+'{rowCount}' + ' 건',
				sorting:false,
				levels:[
					{
						headerStyles:{ background:"#f7aa5a", foreground:"#555555", fontBold:true},
						barStyles:{background:"#dfebf7"}
					}
				]
			});
			
			gridView.groupBy(["USERGROUPNM"]);
			
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
					$grid.gfn_setColDisabled(['USERCD'], editable);
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
			$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','USERCD']);
			cfn_msg('INFO', '정상적으로 저장되었습니다.');
			cfn_retrieve();
		}
		//삭제 (사용/미사용)
		else if (sid === 'sid_setDelete') {
			var resultData = data.resultData;
			$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','USERCD']);
			cfn_msg('INFO', '정상적으로 처리되었습니다.');
			cfn_retrieve();
		}
		//비밀번호 초기화
		else if (sid === 'sid_setPwInit') {
			var resultData = data.resultData;
			$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','USERCD']);
			cfn_msg('INFO', '정상적으로 처리되었습니다.');
			cfn_retrieve();
		}
	}

	//공통버튼 - 검색 클릭
	function cfn_retrieve() {
		$('#grid1').gridView().cancel();
		
		gv_searchData = cfn_getFormData('frmSearch');
		
		var sid = 'sid_getSearch';
		var url = '/sys/s000010/getSearch.do';
		var sendData = {'paramData':gv_searchData};
		
		gfn_sendData(sid, url, sendData);
	}
	
	//공통버튼 - 신규 클릭
	function cfn_new() {
		$('#grid1').gridView().commit(true);
		
		$('#grid1').gfn_addRow({COMPCD:cfn_loginInfo().COMPCD, COMPNM:cfn_loginInfo().COMPNM, ISDRT:'N', ISLOCK:'N', ISUSING:'Y'});
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
			var url = '/sys/s000010/setSave.do';
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
			cfn_msg('WARNING', '선택된 항목이 없습니다.');
			return false;
		}
		
		var state = $grid1.dataProvider().getRowState(rowidx);
		
		if (state === 'created') {
			cfn_msg('WARNING', '신규 항목은 불가능 합니다.');
			return false;
		}
		
		var rowData = $grid1.gfn_getDataRow(rowidx);
		var delstr = rowData.ISUSING === 'N' ? '사용' : '미사용';
		
		if (confirm('사용자코드 [' + rowData.USERCD + '] 항목을 ' + delstr + ' 처리하시겠습니까?')) {
			var sid = 'sid_setDelete';
			var url = '/sys/s000010/setDelete.do';
			var sendData = {'paramData':rowData};
			
			gfn_sendData(sid, url, sendData);
		}
	}

	//공통버튼 - 초기화
	function cfn_init() {
		$('#grid1').gridView().commit(true);
		
		var rowidx = $('#grid1').gfn_getCurRowIdx();
		
		if (rowidx < 0) {
			cfn_msg('WARNING', '선택된 항목이 없습니다.');
			return false;
		}
		
		var state = $('#grid1').dataProvider().getRowState(rowidx);
		
		if (state === 'created') {
			cfn_msg('WARNING', '신규행은 처리할 수 없습니다.');
			return false;
		}
		
		var rowData = $('#grid1').gfn_getDataRow(rowidx);
		
		if (confirm('사용자코드 [' + rowData.USERCD + '] 의 비밀번호를 초기화 하시겠습니까?\n(초기화 비밀번호는 아이디(소문자)와 동일하게 변경됩니다.)')) {
			var sid = 'sid_setPwInit';
			var url = '/sys/s000010/setPwInit.do';
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
			cfn_msg('WARNING', '선택된 항목이 없습니다.');
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