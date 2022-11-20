<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
	화면코드 : S000001
	화면명    : 공통코드-- RealGrid 마스터 디테일 그리드 2개 패턴
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
				<button type="button" class="cmc_cdsearch disabled" disabled />
			</div>
		</li>
		<li class="sech_li">
			<div>공통코드키/명</div>
			<div>
				<input type="text" id="S_CODEKEY" class="cmc_txt" />
			</div>
		</li>
		<li class="sech_li">
			<div>편집여부</div>
			<div>
				<select id="S_EDITABLE" class="cmc_combo">
					<option value="">전체</option>
					<c:forEach var="i" items="${codeEDITABLE}">
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
<div class="ct_left_wrap fix" style="width:550px">
	<div class="grid_top_wrap">
		<div class="grid_top_left">공통코드 마스터<span>(총 0건)</span></div>
		<div class="grid_top_right">
		</div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- 그리드 시작 -->
<div class="ct_right_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">상세 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="button" id="btn_detailAdd" class="cmb_plus" onclick="btn_detailAdd_onClick();"/>
			<input type="button" id="btn_detailDel" class="cmb_minus" onclick="btn_detailDel_onClick();" />
		</div>
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
	//1. 화면레이아웃 지정 (리사이징)
	initLayout();
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	
	grid1_Load();
	grid2_Load();

	/* 공통코드 코드/명 (회사) */
	pfn_codeval({
		url:'/alexcloud/popup/popP001/view.do',codeid:'S_COMPCD',
		inparam:{S_COMPCD:'S_COMPCD,S_COMPNM'},
		outparam:{COMPCD:'S_COMPCD',NAME:'S_COMPNM'}
	});
	
	//$('#S_COMPCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	//$('#S_COMPNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	$('#btn_S_COMPCD').attr('disabled','disabled').addClass('disabled');
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:120,visible:false},
		{name:'CODEKEY',header:{text:'공통코드키'},width:100,editable:true,editor:{maxLength:20},required:true},
		{name:'NAME',header:{text:'공통코드명'},width:120,editable:true,editor:{maxLength:100},required:true},
		{name:'EDITABLE',header:{text:'편집여부'},width:80,formatter:'combo',comboValue:'${gCodeEDITABLE}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = "Y"',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = "N"',styles:{figureBackground:cfn_getStsColor(0)}}
	        ]
		},
		{name:'TABLENAME',header:{text:'테이블명'},width:120,visible:false},
		{name:'REMARK',header:{text:'비고'},width:180,editable:true,editor:{maxLength:200}},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
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
				var editable = $('#' + gid).gfn_getValue(newRowIdx, 'EDITABLE') === 'Y';
				
				$('#' + gid).gfn_setColDisabled(['NAME', 'REMARK'], editable);
				$('#grid2').gfn_setColDisabled(['CODE', 'SNAME1', 'SNAME2', 'SNAME3', 'SNAME4', 'SNAME5', 'SORTNO', 'REMARK'], editable);
				if(editable){
					$('#btn_detailAdd').show();
					$('#btn_detailDel').show();
				} else {
					$('#btn_detailAdd').hide();
					$('#btn_detailDel').hide();
				}
				var state = dataProvider.getRowState(newRowIdx);
				if(state === 'created'){
					$('#' + gid).gfn_setColDisabled(['CODEKEY'], true);
				} else {
					$('#' + gid).gfn_setColDisabled(['CODEKEY'], false);
				}
			}
			
			var compcd = $('#' + gid).gfn_getValue(newRowIdx, 'COMPCD');
			var codekey = $('#' + gid).gfn_getValue(newRowIdx, 'CODEKEY');
			if(!cfn_isEmpty(codekey)) {
				var param = {'COMPCD':compcd, 'CODEKEY':codekey};
				fn_getDetailList(param);
			}
			
		};
	});
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'CODEKEY',header:{text:'공통코드키'},width:100,visible:false},
		{name:'CODE',header:{text:'코드'},width:80,required:true,editable:true,editor:{maxLength:20}},
		{name:'SNAME1',header:{text:'명칭1'},width:100,required:true,editable:true,editor:{maxLength:100}},
		{name:'SNAME2',header:{text:'명칭2'},width:100,editable:true,editor:{maxLength:100}},
		{name:'SNAME3',header:{text:'명칭3'},width:100,editable:true,editor:{maxLength:100}},
		{name:'SNAME4',header:{text:'명칭4'},width:100,editable:true,editor:{maxLength:100}},
		{name:'SNAME5',header:{text:'명칭5'},width:100,editable:true,editor:{maxLength:100}},
		{name:'STATUS',header:{text:'사용여부'},width:80,editable:true,editor:{maxLength:1}},
		{name:'SORTNO',header:{text:'정렬순'},width:100,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'REMARK',header:{text:'비고'},width:300,editable:true,editor:{maxLength:200}},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false,mstGrid:'grid1'});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var state = dataProvider.getRowState(newRowIdx);
				if(state === 'created'){
					$('#' + gid).gfn_setColDisabled(['CODE'], true);
				} else {
					$('#' + gid).gfn_setColDisabled(['CODE'], false);
				}
			}
		};
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
		
		//검색결과에 따른 마스터 데이터 포커스 이동 처리 (저장처리 이후 발생 gfn_setFocusPK함수 처리)
		$('#grid1').gfn_focusPK();
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//저장
	if(sid == 'sid_setSave') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','CODEKEY']);
		
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//취소
	if(sid == 'sid_setDelete') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','CODEKEY']);
		
		cfn_msg('INFO', '정상적으로 취소되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/sys/s000001/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/sys/s000001/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 신규 클릭 */
function cfn_new() {
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);

	var grid2Data = $('#grid2').gfn_getDataList(false);
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx >= 0) {
		var state = $('#grid1').dataProvider().getRowState(rowidx);
		if (state === 'created') {
			cfn_msg('INFO', '신규 입력 상태입니다.');
			return false;
		} else if (state === 'updated' || grid2Data.length > 0) {
			if (confirm('변경된 내용이 있습니다. 저장하시겠습니까?')) {
				cfn_save('Y');
			}
			return false;
		}
	}
	
	$('#grid2').dataProvider().clearRows();
	
	$('#grid1').gfn_addRow({EDITABLE:'Y',
				  	 		COMPCD:cfn_loginInfo().COMPCD
	});
}

/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 공통코드 마스터가 없습니다.');
		return false;
	}
	
	//마스터 필수입력 체크
	if ($('#grid1').gfn_checkValidateCells([rowidx])) return false;
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (masterData.EDITABLE !== 'Y') {
		cfn_msg('WARNING', '편집가능 항목만 저장할 수 있습니다.');
		return false;
	}
	
	var detailData = $('#grid2').gfn_getDataList();
	if (detailData.length < 1) {
		cfn_msg('WARNING', '공통코드 상세내역이 없습니다.');
		return false;
	}
	
	//디테일 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;

	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}

	if (flg) {
		var sid = 'sid_setSave';
		var url = '/sys/s000001/setSave.do';
		var sendData = {'mGridData':masterData,'dGridData':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//디테일 그리드 추가 버튼 이벤트
function btn_detailAdd_onClick() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	$('#grid2').gfn_addRow();
}

//디테일 그리드 삭제 버튼 이벤트
function btn_detailDel_onClick() {
	var rowidx = $('#grid2').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	$('#grid2').gfn_delRow(rowidx);
}

</script>

<c:import url="/comm/contentBottom.do" />