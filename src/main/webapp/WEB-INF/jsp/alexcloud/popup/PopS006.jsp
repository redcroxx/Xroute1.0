<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popS006
	화면명    : 팝업-사용자(다중)
-->
<div id="popS006" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popS006" action="#" onsubmit="return false">
		<input type="hidden" id="S_COMPCD" name="S_COMPCD" />
		<input type="hidden" id="USERCD" name="USERCD" />
			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div style="width:100px">사용자코드/명</div>
					<div style="width:180px">
						<input type="text" id="S_USERCD" class="cmc_txt" />
					</div>
				</li>
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
			</ul>
			<button type="button" class="cmb_pop_search" onclick="fn_search_popS006()"></button>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">검색결과</div>
			<div class="grid_top_right"></div>
		</div>
		<div id="grid_popS006"></div>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#popS006').lingoPopup({
		title: '사용자코드 검색',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var checkRows = $('#grid_popS006').gridView().getCheckedRows();

					if (checkRows.length < 1) {
						cfn_msg('WARNING', '선택된 사용자가 없습니다.');
						return false;
					}
					
					var gridData = $('#grid_popS006').gfn_getDataRows(checkRows);
					
					$(this).lingoPopup('setData', gridData);
					$(this).lingoPopup('close', 'OK');
					
					cfn_msg('INFO', '정상적으로 처리되었습니다.');
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
			cfn_bindFormData('frm_search_popS006', data);
			grid_Load_popS006();

			var gridData = data.gridData;
			
			/* if (gridData.length > 0) {
				$('#grid_popS006').gfn_setDataList(data.gridData);
			} else {
				fn_search_popS006();
			} */
		}
	});
});

function grid_Load_popS006() {
	var gid = 'grid_popS006';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'USERGROUP',header:{text:'사용자그룹'},width:120,formatter:'combo',comboValue:'${GCODE_USERGROUP}',styles:{textAlignment:'center'}},
		{name:'DEPTCD',header:{text:'소속'},width:120,formatter:'combo',comboValue:'${GCODE_DEPTCD}',styles:{textAlignment:'center'}},
		{name:'USERCD',header:{text:'사용자코드'},width:100},
		{name:'POSITION',header:{text:'직책책'},width:140},
		{name:'NAME',header:{text:'사용자명'},width:140},
		{name:'ORGCD',header:{text:'사업장코드'},width:100},
		{name:'PHONENO',header:{text:'전화번호'},width:140},
		{name:'FAX',header:{text:'팩스'},width:140},
		{name:'EMAIL',header:{text:'이메일'},width:140},
		{name:'SEX',header:{text:'성별'},width:140},
		{name:'BIRTHDATE',header:{text:'생년월일'},width:90,formatter:'date',styles:{textAlignment:'center'}},
		
	];


	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true});
	

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {		

		gridView.onItemChecked = function(grid, itemIndex, checked) {
			var usercd = $('#' + gid).gfn_getValue(itemIndex, 'USERCD');
			var checkstate = gridView.isCheckedRow(itemIndex);
		}
	});

}

/* 검색 */
function fn_search_popS006() {
	var paramData = cfn_getFormData('frm_search_popS006');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popS006/search.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#grid_popS006').gfn_setDataList(data.resultList);
	});
}
</script>