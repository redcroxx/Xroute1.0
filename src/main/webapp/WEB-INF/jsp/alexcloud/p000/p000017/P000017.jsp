<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000017
	화면명    : 품목분류 관리
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
				<div>품목분류코드/명</div>
				<div>
					<input type="text" id="S_CATEGORY" class="cmc_txt" />
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_top_wrap">
	<div class="ct_left_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">품목분류 리스트<span>(총 0건)</span></div>
			<div class="grid_top_right"></div>		
		</div>
		<div id="grid1"></div>
	</div>
	<div class="ct_right_wrap fix" style="width:700px">
		<form id="frmDetail" action="#" onsubmit="return false">
		<input type="hidden" id="COMPCD" name="COMPCD" />
		<input type="hidden" id="LVL" name="LVL" />
		
		<table class="tblForm" style="min-width:400px">
			<caption>품목분류정보</caption>
			<colgroup>
				<col width="120px" />
		        <col />
		    </colgroup>
			<tr>
				<th>상위분류</th>
				<td>
					<input type="text" id="PCATEGORYCD" class="cmc_code disabled" readonly="readonly" />
					<input type="text" id="PCATEGORYNM" class="cmc_value disabled" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<th>단계</th>
				<td>
					<input type="text" id="LVLNAME" class="cmc_txt disabled" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<th class="required">분류코드</th>
				<td>
					<input type="text" id="CATEGORYCD" class="cmc_txt required disabled" maxlength="20" readonly="readonly" tabindex="1" />
				</td>
			</tr>
			<tr>
				<th class="required">분류명</th>
				<td>
					<input type="text" id="NAME" class="cmc_txt required disabled" maxlength="100" readonly="readonly" tabindex="2" />
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
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	$('#S_ISUSING').val('Y');
	
	grid1_Load();
});

function grid1_Load() {
	var gid = 'grid1', $grid = $('#' + gid);
	var columns = [
		{name:'CATEGORYINFO',header:{text:'분류'},width:200},
		{name:'CATEGORYCD',header:{text:'분류코드'},width:100},
		{name:'NAME',header:{text:'분류명'},width:130},
		{name:'LVLNAME',header:{text:'단계'},width:80,styles:{textAlignment:'center'}},
		{name:'SORTNO',header:{text:'정렬순서'},width:80,styles:{textAlignment:'far'}},
		{name:'ITEMCNT',header:{text:'등록품목수'},width:80},
		{name:'REMARK',header:{text:'비고'},width:200},
		{name:'LVL',header:{text:'분류레벨'},width:80,styles:{textAlignment:'far'},visible:false},	
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'TREE',header:{text:'트리'},width:150,show:false}
	];
	$grid.gfn_createGrid(columns, {treeflg:true,panelflg:false,footerflg:false,sortable:false,fitStyle:'even'});
	
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var rowData = dataProvider.getJsonRow(newRowIdx);
				if (!cfn_isEmpty(rowData.CATEGORYCD)) {
					cfn_clearFormData('frmDetail');
					fn_getDetail(rowData);
				} else {
					cfn_clearFormData('frmDetail');
					cfn_formAllDisable(['frmDetail']);
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
		var resultData = data.resultData;
		var $grid1 = $('#grid1');
		
		cfn_clearFormData('frmDetail');
		$grid1.dataProvider().setRows(gridData, 'TREE', false);
		$grid1.gridView().expandAll();
		
		if (!cfn_isEmpty(resultData.S_CATEGORY)) {
			var rowidxs = [], i = 0;
			do {
				i = $grid1.gridView().searchItem({fields:['CATEGORYCD','NAME'],values:[resultData.S_CATEGORY,resultData.S_CATEGORY],allFields:false,partialMatch:true,select:false,startIndex:i,wrap:false});
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
			
			$grid1.dataProvider().setRows(gridData, 'TREE', false);
			$grid1.gridView().expandAll();
		}

		//검색결과에 따른 마스터 데이터 포커스 이동 처리
		$grid1.gfn_focusPK();
	}
	//상세 검색
	else if (sid == 'sid_getDetail') {
		var formData = data.resultData;
		
		$('#CATEGORYCD').prop('readonly', true).addClass('disabled');
		$('#NAME').prop('readonly', false).removeClass('disabled').attr('tabindex', '1');
		$('#SORTNO').prop('readonly', false).removeClass('disabled').attr('tabindex', '2');
		$('#REMARK').prop('readonly', false).removeClass('disabled').attr('tabindex', '3');
		cfn_setIDUR('U');
		cfn_bindFormData('frmDetail', formData);
	}
	//저장
	else if (sid === 'sid_setSave') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','CATEGORYCD']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//삭제
	else if (sid === 'sid_setDelete') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','CATEGORYCD']);
		cfn_msg('INFO', '정상적으로 삭제되었습니다.');
		cfn_retrieve();
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000017/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);			
}

//상세 검색
function fn_getDetail(param) {
	var sid = 'sid_getDetail';
	var url = '/alexcloud/p000/p000017/getDetail.do';
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
			cfn_msg('WARNING', '하위 분류 생성은 3단계까지만 가능합니다.');
			return false;
		}
		
		cfn_clearFormData('frmDetail');
		$('#COMPCD').val(rowData.COMPCD);
		$('#PCATEGORYCD').val(cfn_isEmpty(rowData.CATEGORYCD) ? '*' : rowData.CATEGORYCD);
		$('#PCATEGORYNM').val(rowData.NAME);
		$('#CATEGORYCD').attr('disabled',false).prop('readonly', false).removeClass('disabled').attr('tabindex', '1').focus();
		$('#NAME').attr('disabled',false).prop('readonly', false).removeClass('disabled').attr('tabindex', '2');
		$('#SORTNO').attr('disabled',false).prop('readonly', false).removeClass('disabled').attr('tabindex', '3').val('10');
		$('#REMARK').attr('disabled',false).prop('readonly', false).removeClass('disabled').attr('tabindex', '4');
		$('#LVL').val(cfn_castNum(rowData.LVL) + 1);
		
		if ($('#LVL').val() == '1') {
			$('#LVLNAME').val('대분류');
		} else if ($('#LVL').val() == '2') {
			$('#LVLNAME').val('중분류');
		} else if ($('#LVL').val() == '3') {
			$('#LVLNAME').val('소분류');
		} else {
			$('#LVLNAME').val('회사');
		}
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
		var url = '/alexcloud/p000/p000017/setSave.do';
		var sendData = {'paramData':formData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 삭제 클릭
function cfn_del() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 분류가 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (cfn_isEmpty(masterData.CATEGORYCD)) {
		cfn_msg('WARNING', '최상위 회사는 삭제할 수 없습니다.');
		return false;
	}
	
	if (cfn_castNum(masterData.ITEMCNT) > 0) {
		cfn_msg('WARNING', '해당 분류코드 [' + masterData.CATEGORYCD + '] 에 품목이 존재하여 삭제가 불가능 합니다.');
		return false;
	}

	var childIdxs = $('#grid1').dataProvider().getDescendants(rowidx);
	var delList = $('#grid1').gfn_getDataRows(childIdxs);
	
	delList.push(masterData);
	if (confirm('분류코드 [' + masterData.CATEGORYCD + '] 항목을 삭제 하시겠습니까?')) {
		
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000017/setDelete.do';
		var sendData = {'paramList':delList};
		
		gfn_sendData(sid, url, sendData);
	}
}
</script>

<c:import url="/comm/contentBottom.do" />