<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000003
	화면명    : 거래처 관리
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
				<div>화주</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code" />				
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
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
				<div>거래처코드/명</div>
				<div>
					<input type="text" id="S_CUST" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li">
				<div>거래처분류</div>
				<div>
					<input type="text" id="S_CUSTCATCD" class="cmc_code" />
					<input type="text" id="S_CUSTCATNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li">
				<div style="width:300px">
					<input type="checkbox" id="S_ISSUPPLIER" class="cmc_checkbox" style="width:18px;margin-top:0;" />
						<label for="S_ISSUPPLIER">공급처</label>
					<input type="checkbox" id="S_ISSHIPPER" class="cmc_checkbox" style="width:18px;margin-top:0;" />
						<label for="S_ISSHIPPER">납품처</label>
					<input type="checkbox" id="S_ISDELIVERY" class="cmc_checkbox" style="width:18px;margin-top:0;" />
						<label for="S_ISDELIVERY">배송처</label>
				</div>
				<div></div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">거래처<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="button" id="btn_upload" class="cmb_normal" value="업로드" onclick="pfn_upload('P000003');" />
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

	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_ISUSING').val('Y');
	
	grid1_Load();
	
	//화주
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD', S_COMPNM:'S_COMPNM', S_ORGCD:'S_ORGCD'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	//거래처분류
	pfn_codeval({
		url:'/alexcloud/popup/popP018/view.do',codeid:'S_CUSTCATCD',
		inparam:{S_COMPCD:'S_COMPCD',S_CUSTCAT:'S_CUSTCATCD,S_CUSTCATNM'},
		outparam:{CUSTCATCD:'S_CUSTCATCD',NAME:'S_CUSTCATNM'}
	});
	
 	if ($('#S_ORGCD').val().length > 0) {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}	
});

function grid1_Load() {
	var gid = 'grid1', $grid = $('#' + gid);
	var columns = [
		{name:'ORGCD',header:{text:'화주코드'},width:100,formatter:'popup',editable:true,required:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP002/view.do',
				inparam:{S_COMPCD:'COMPCD',S_COMPNM:'COMPNM',S_ORGCD:'ORGCD'},outparam:{ORGCD:'ORGCD',NAME:'ORGNM'}}
		},
		{name:'ORGNM',header:{text:'화주명'},width:100,styles:{textAlignment:'center'}},
		{name:'CUSTCD',header:{text:'거래처코드'},width:120,editable:true,required:true,editor:{maxLength:20}},
		{name:'NAME',header:{text:'거래처명'},width:180,editable:true,required:true,editor:{maxLength:100}},
		{name:'SNAME',header:{text:'거래처명(약칭)'},width:160,editable:true,editor:{maxLength:100}},
		{name:'ANAME',header:{text:'거래처명(별칭)'},width:160,editable:true,editor:{maxLength:100}},
		{name:'CUSTGROUP',header:{text:'거래처그룹'},width:100,formatter:'combo',comboValue:'${GCODE_CUSTGROUP}',styles:{textAlignment:'center'},editable:true},
		{name:'CUSTCAT1NM',header:{text:'대분류'},width:120},
		{name:'CUSTCAT2NM',header:{text:'중분류'},width:120},
		{name:'CUSTCAT3NM',header:{text:'소분류'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP018/view.do',
				inparam:{S_COMPCD:'COMPCD',S_CUSTCAT:'CUSTCAT3NM'},
				outparam:{CUSTCAT1NM:'CUSTCAT1NM',CUSTCAT2NM:'CUSTCAT2NM',CUSTCAT3CD:'CUSTCAT3CD',CUSTCAT3NM:'CUSTCAT3NM'},
				params:{S_LVL3:'Y'}}
		},
		{name:'POST',header:{text:'우편번호'},width:100,styles:{textAlignment:'center'},formatter:'popup',editable:true,editor:{maxLength:10},
			popupOption:{url:'/sys/popup/popPost/view.do',btnflg:true,
				inparam:{POST:'POST'},outparam:{POST:'POST',ADDR:'ADDR1'}}
		},
		{name:'ADDR1',header:{text:'주소'},width:300,editable:true,editor:{maxLength:100}},
		{name:'ADDR2',header:{text:'주소상세'},width:200,editable:true,editor:{maxLength:100}},
		{name:'CEO',header:{text:'대표자'},width:100,editable:true,editor:{maxLength:50}},
		{name:'BIZNO',header:{text:'사업자번호'},width:100,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20}},
		{name:'BIZKIND',header:{text:'업태'},width:100,editable:true,editor:{maxLength:50}},
		{name:'BIZTYPE',header:{text:'업종'},width:100,editable:true,editor:{maxLength:50}},
		{name:'ISSUPPLIER',header:{text:'공급처'},width:100,formatter:'checkbox'},
		{name:'ISSHIPPER',header:{text:'납품처'},width:100,formatter:'checkbox'},
		{name:'ISDELIVERY',header:{text:'배송처'},width:100,formatter:'checkbox'},
		{name:'PHONE1',header:{text:'전화번호1'},width:120,styles:{textAlignment:'center'},editable:true,editor:{maxLength:25}},
		{name:'PHONE2',header:{text:'전화번호2'},width:120,styles:{textAlignment:'center'},editable:true,editor:{maxLength:25}},
		{name:'FAX1',header:{text:'FAX1'},width:120,styles:{textAlignment:'center'},editable:true,editor:{maxLength:25}},
		{name:'FAX2',header:{text:'FAX2'},width:120,styles:{textAlignment:'center'},editable:true,editor:{maxLength:25}},
		{name:'REFUSERNM',header:{text:'담당자명'},width:100,editable:true,editor:{maxLength:20}},
		{name:'REFUSERPHONE',header:{text:'담당자연락처'},width:120,styles:{textAlignment:'center'},editable:true,editor:{maxLength:25}},
		{name:'EMAIL',header:{text:'이메일'},width:180,editable:true,editor:{maxLength:80}},
		{name:'URL',header:{text:'홈페이지'},width:200,editable:true,editor:{maxLength:80}},
		{name:'COUNTRYCD',header:{text:'국가'},width:100,formatter:'combo',comboValue:'${GCODE_COUNTRYCD}',styles:{textAlignment:'center'},editable:true},
		{name:'PORTCD',header:{text:'PORTCD'},width:100,editable:true,editor:{maxLength:20}},
		{name:'DISTRICTCD',header:{text:'DISTRICTCD'},width:100,editable:true,editor:{maxLength:20}},
		{name:'REMARK',header:{text:'비고'},width:400,editable:true,editor:{maxLength:255}},
		{name:'ISUSING',header:{text:'사용여부'},width:100,formatter:'combo',comboValue:'${GCODE_ISUSING}',
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = "Y"',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = "N"',styles:{figureBackground:cfn_getStsColor(0)}}]
		},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'COMPNM',header:{text:'회사명'},width:100},
		{name:'ADDUSERCD',header:{text:'등록자'},width:120,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}},
		{name:'CUSTCAT3CD',header:{text:'소분류코드'},width:100,visible:false}
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
				$grid.gfn_setColDisabled(['ORGCD', 'CUSTCD'], editable);
				
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#' + gid).gfn_setColDisabled(['ORGCD'], false);
				}
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
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD', 'ORGCD', 'CUSTCD']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//삭제 (사용/미사용)
	else if (sid === 'sid_setDelete') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD', 'ORGCD', 'CUSTCD']);
		cfn_msg('INFO', '정상적으로 처리되었습니다.');
		cfn_retrieve();
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	
	$('#grid1').gridView().cancel();
	
	//검색조건 필수입력 체크
	//if(cfn_isFormRequireData('frmSearch') == false) return;
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000003/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

//공통버튼 - 신규 클릭
function cfn_new() {
	$('#grid1').gfn_addRow({
		COMPCD:cfn_loginInfo().COMPCD
		, COMPNM:cfn_loginInfo().COMPNM
		, ORGCD:cfn_loginInfo().ORGCD
		, ORGNM:cfn_loginInfo().ORGNM
		, ISSALES:'N'
		, ISSUPPLIER:'N'
		, ISSHIPPER:'N'
		, ISDELIVERY:'N'
		, ISUSING:'Y'
	});
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
		var url = '/alexcloud/p000/p000003/setSave.do';
		var sendData = {'mGridList':masterList};
		
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
	
	if (confirm('거래처코드 [' + rowData.CUSTCD + '] 항목을 ' + delstr + ' 처리하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000003/setDelete.do';
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