<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000001
	화면명    : 회사 - RealGrid 마스터 그리드 패턴
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<ul class="sech_ul">
		<li class="sech_li">
			<div>회사코드/명</div>
			<div>		
				<input type="text" id="S_COMP" class="cmc_txt" />
			</div>
		</li>
		<li class="sech_li">
			<div>사용여부</div>
			<div>
				<select id="S_ISUSING" class="cmc_combo">
					<option value="">전체</option>
					<c:forEach var="i" items="${codeISUSING}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
	</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">회사<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="button" id="btn_masterAdd" class="cmb_plus" onclick="btn_masterAdd_onClick();"/>
			<input type="button" id="btn_masterDel" class="cmb_minus" onclick="btn_masterDel_onClick();" />		</div>
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
	//1. 화면레이아웃 지정 (리사이징) 
	initLayout();
	
	//2. 화면 공통버튼 설정
	setCommBtn('del', null, '미사용');
	
	//3. 입력폼 초기화
	$('#S_ISUSING').val('Y');
	
	//4. 그리드 초기화
	grid1_Load();
	
	//5. 권한별 표시
	authority_Load();

});

function authority_Load() {
	if(cfn_loginInfo().USERGROUP != '${XROUTE_ADMIN}'){
		$('#S_COMP').val(cfn_loginInfo().COMPNM);
		$('#S_COMP').prop("disabled",true);
	};
}

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:80,editable:true,required:true,editor:{maxLength:20}},
		{name:'NAME',header:{text:'회사명'},width:120,editable:true,required:true,editor:{maxLength:50}},
		{name:'SNAME',header:{text:'회사명(약칭)'},width:120,editable:true,editor:{maxLength:100}},
		{name:'TEL1',header:{text:'전화번호1'},width:110,editable:true,editor:{maxLength:20}},
		{name:'TEL2',header:{text:'전화번호2'},width:110,editable:true,editor:{maxLength:20}},
		{name:'FAX1',header:{text:'팩스번호1'},width:110,editable:true,editor:{maxLength:20}},
		{name:'FAX2',header:{text:'팩스번호2'},width:110,editable:true,editor:{maxLength:20}},
		{name:'POST',header:{text:'우편번호'},width:80,editable:true,formatter:'popup',
			popupOption:{url:'/sys/popup/popPost/view.do',
				 outparam:{POST:'POST',ADDR:'ADDR'}},editor:{maxLength:15}
		},
		{name:'ADDR',header:{text:'주소'},width:400,editable:true,editor:{maxLength:200},styles:{textAlignment:'center'}},
		{name:'ADDR2',header:{text:'주소상세'},width:200,editable:true,editor:{maxLength:200}},
		{name:'CEO',header:{text:'대표자'},width:80,editable:true,editor:{maxLength:50},styles:{textAlignment:'center'}},
		{name:'BIZDATE',header:{text:'창립일'},width:130,formatter:'date',editable:true,editor:{maxLength:8}},
		{name:'ISUSING',header:{text:'사용여부'},width:100,formatter:'combo',comboValue:'${gCodeISUSING}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = "Y"',styles:{figureBackground:'#008000'}},
				{criteria:'value = "N"',styles:{figureBackground:'#ff0000'}}]
		},
		{name:'BIZNO1',header:{text:'사업자번호1'},width:110,editable:true,editor:{maxLength:50}},
		{name:'BIZNO2',header:{text:'사업자번호2'},width:110,editable:true,editor:{maxLength:50}},
		{name:'BIZKIND',header:{text:'업태'},width:80,editable:true,editor:{maxLength:50}},
		{name:'BIZTYPE',header:{text:'업종'},width:80,editable:true,editor:{maxLength:50}},
		{name:'EMAIL',header:{text:'대표이메일'},width:180,editable:true,editor:{maxLength:50}},
		{name:'WEBADDR',header:{text:'홈페이지'},width:180,editable:true,editor:{maxLength:50}},
		{name:'NATION',header:{text:'국가'},width:120,editable:true,formatter:'combo',comboValue:'${GCODE_COUNTRYCD}',editor:{maxLength:20},styles:{textAlignment:'center'}},
		{name:'REMARKS',header:{text:'비고'},width:200,editable:true,editor:{maxLength:255}},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150},
		{name:'TERMINALCD',header:{text:'IP'},width:100},
	];
	
	//그리드 생성 (realgrid 써서)
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {

		//열고정 설정
		gridView.setFixedOptions({colCount:2,resizable:true,colBarWidth:1});
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var editable =  grid.getValue(newRowIdx, 'ISUSING') === 'Y';
				$('#' + gid).gfn_setColDisabled(['COMPCD', 'NAME', 'SNAME', 'TEL1', 'TEL2', 'FAX1', 'FAX2', 'POST', 'ADDR', 'ADDR2', 'CEO', 'BIZDATE', 'BIZNO1', 'BIZNO2', 'BIZKIND', 'BIZTYPE', 'EMAIL', 'WEBADDR', 'NATION', 'REMARKS'], editable);
				if (editable) {
					setCommBtn('del', null, '미사용',{'iconname':'btn_del.png'});
				} else {
					setCommBtn('del', null, '사용',{'iconname':'btn_on.png'});
				}
				
				var state = $('#grid1').dataProvider().getRowState(newRowIdx) === 'created';
				$('#' + gid).gfn_setColDisabled(['COMPCD'], state);
			} 
		};
	});
}


/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	//저장
	if (sid == 'sid_setSave') {
		$('#grid1').gfn_setFocusPK(data.resultData, ['COMPCD']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//취소
	if (sid == 'sid_setDelete') {
		$('#grid1').gfn_setFocusPK(data.resultData, ['COMPCD']);
		cfn_msg('INFO', '정상적으로 처리되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('#grid1').gridView().cancel();
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000001/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 저장 클릭 */
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
		var url = '/alexcloud/p000/p000001/setSave.do';
		var sendData = {'mGridList':masterList};
		
		gfn_sendData(sid, url, sendData);
	}	
}

/* 공통버튼 - 미사용 클릭 */
function cfn_del() {
	$('#grid1').gridView().commit(true);
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 회사가 없습니다.');
		return false;
	}
	
	var state = $('#grid1').dataProvider().getRowState(rowidx);
	
	if (state === 'created') {
		$('#grid1').gfn_delRow(rowidx);
		return;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);	
	var msgtxt;
	
	if (masterData.ISUSING == 'N') {
		msgtxt = '사용';
	} else {
		msgtxt = '미사용';
	}
	
	if (confirm('회사코드[' + masterData.COMPCD + '] 항목을 ' + msgtxt + '처리 하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000001/setDelete.do';
		var sendData = {'paramData':masterData};

		gfn_sendData(sid, url, sendData);
	}
}

//마스터 그리드 추가(+) 버튼 이벤트
function btn_masterAdd_onClick() {
	$('#grid1').gfn_addRow({ISUSING:'Y'});
}

//마스터 그리드 삭제(-) 버튼 이벤트
function btn_masterDel_onClick() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	var state = $('#grid1').dataProvider().getRowState(rowidx);
	if (state !== 'created') {
		cfn_msg('WARNING', '기등록 데이터는 삭제할 수 없습니다.');
		return false;
	}
	
	$('#grid1').gfn_delRow(rowidx);
}

</script>

<c:import url="/comm/contentBottom.do" />