<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="trackingDtl" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frmTrackingDtlSearch" action="#" onsubmit="return false">
		<input type="hidden" name="ordCd" >
		<ul class="sech_ul">
			<li class="sech_li">
				<div>송장번호</div>
				<div>
					<input type="text" class="disabled" id="xrtInvcSno">
					<input type="button" class="cmc_cdsearch" id="btnSearch" onclick="cfn_retrieve()" />
				</div>
			</li>
		</ul>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	<!-- 그리드 시작 -->
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">이력<span>(총 0건)</span></div>
			<div class="grid_top_right">
				<button type="button" id="btn_grid1Add" class="cmb_plus" onclick="fn_grid1AddRow()"></button>
				<button type="button" id="btn_grid1Del" class="cmb_minus" onclick="fn_grid1DelRow()"></button>
			</div>
		</div>
		<div id="trackingDtlGrid"></div>
	</div>
	<!-- 그리드 끝 -->
</div>
<script type="text/javascript">
$(function() {
	$('#trackingDtl').lingoPopup({
		title : "이력확인",
		width : 850,
		height : 700,
		buttons : {
			"확인" : {
				text : "저장",
				click : function() {
					cfn_save();
				}
			},
			"취소" : {
				text : "닫기",
				click : function() {
					$(this).lingoPopup("setData", "");
					$(this).lingoPopup("close", "CANCEL");
				}
			},
		},
		open : function(data) {
			$("#xrtInvcSno").val(data.xrtInvcSno||"");
			$("input[name='ordCd']").val(data.ordCd||"");
			getCountryList();
		}
	});
});

//공통버튼 - 검색 클릭
function getCountryList() {
	gv_searchData = cfn_getFormData("frmTrackingDtlSearch");
	var sid = "sid_getCountryList";
	var url = "/fulfillment/tracking/trackingDtl/getCountryList.do";
	var sendData = gv_searchData;
	var countryList = [];
	
	gfn_ajax(url, true, sendData, function(result, xhr) {
		for (i=0; i<result.resultList.length; i++) {
			countryList.push(result.resultList[i].code||"");
		}
		
		getList(countryList);
		cfn_retrieve();
	});
}
function getList(countryList) {
	var tagKey = ["Wating", "InfoReceived", "Pending", "InTransit", "Delivered", "API Error"];
	var gid = "trackingDtlGrid";
	var $grid = $('#' + gid);
	var columns = [
		{name : "checkPointDate", header : {text : "일자"}, width : 150, editable : true, editor : {maxLength : 200, type: "date", datetimeFormat: "yyyy-MM-dd hh:mm:ss"}, required:true}
		, {name : "nation", header : {text : "국가"}, width : 150, editable : true, editor : {type: "dropDown", values: countryList, labels: countryList, textReadOnly: true, domainOnly: true, maxLength : 250}, required:true}
		, {name : "tag", header : {text : "배송상태"}, width : 150, editable : true, editor : {type: "dropDown", values: tagKey, labels: tagKey, textReadOnly: true, domainOnly: true, maxLength : 350}, required:true}
		, {name : "tagKr", header : {text : "배송상태(한글)"}, width : 150, editable : false, editor : {maxLength : 350}}
		, {name : "rowStatusCd", header : {text : "열상태코드"}, show : false}
	];
	
	//그리드 생성 (realgrid 써서)
	$grid.gfn_createGrid(columns, {
		footerflg : false,
		cmenuGroupflg : false,
		cmenuColChangeflg : false,
		cmenuColSaveflg : false,
		cmenuColInitflg : false
	});
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(
		function(gridView, dataProvider) {
			gridView.onEditCommit = function (grid, index, oldValue, newValue) {
				if (index.fieldName === "tag") {
					var tagKrValue = "";
					
					switch (newValue) {
						case "Wating" :
							tagKrValue = "대기";
							break;
						case "InfoReceived" :
							tagKrValue = "입고";
							break;
						case "Pending" :
							tagKrValue = "대기 중";
							break;
						case "InTransit" :
							tagKrValue = "운송 중";
							break;
						case "Delivered" :
							tagKrValue = "배송 완료";
							break;
						case "API Error" :
							tagKrValue = "API 오류";
							break;
						default:
							tagKrValue = "오류";
							break;
					}
					
					grid.setValue(index.itemIndex, "tagKr", tagKrValue);
				}
			};
		}
	);
}
//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == "sid_getSearch") {
		$("#trackingDtlGrid").gfn_setDataList(data.resultList);
	} else if (sid == "sid_setSave") {
		if (data.CODE == "1") {
			cfn_msg("INFO", "정상적으로 처리되었습니다.");
		}
	}
}
//공통버튼 - 검색 클릭
function cfn_retrieve() {
	$("#trackingDtlGrid").gridView().cancel();
	gv_searchData = cfn_getFormData("frmTrackingDtlSearch");
	var sid = "sid_getSearch";
	var url = "/fulfillment/tracking/trackingDtl/getSearch.do";
	var sendData = gv_searchData;

	gfn_sendData(sid, url, sendData, true);
}
//공통버튼 - 신규 클릭
function cfn_new() {
		
	$('#trackingDtlGrid').gridView().commit(true);
	
	$('#trackingDtlGrid').gfn_addRow();
}
//그리드1 행추가 버튼 클릭
function fn_grid1AddRow() {
	cfn_new();
}

//그리드1 행삭제 버튼 클릭
function fn_grid1DelRow() {
	var $grid1 = $("#trackingDtlGrid");
	var rowidx = $grid1.gfn_getCurRowIdx();
	var state = $grid1.dataProvider().getRowState(rowidx);
	var checkpoint = $grid1.gridView().getValue(rowidx, "checkPointDate");
	
	if (rowidx < 0) {
		cfn_msg("WARNING", "선택된 항목이 없습니다.");
		return false;
	}

	if (state === "created") {
		$grid1.gfn_delRow(rowidx);
	} else {
		if (confirm("정말로 삭제 하시겠습니까?") == false) return;
		
		var url = "/fulfillment/tracking/trackingDtl/delete.do";
		var jsonObj = {};
		jsonObj.invcSno = $("#xrtInvcSno").val()||"";
		jsonObj.adddatetime = checkpoint;
		
		gfn_ajax(url, true, jsonObj, function(result, xhr) {
			if (result.CODE == 1) {
				cfn_msg("INFO", "정상적으로 처리되었습니다.");
				getCountryList();
			} else {
				cfn_msg("ERROR", "오류가 발생하였습니다.");
			}
		});
	}
}
//공통버튼 - 저장 클릭
function cfn_save() {
	$("#trackingDtlGrid").gridView().commit(true);
	
	var $grid = $("#trackingDtlGrid");
	var masterList = $grid.gfn_getDataList(false);
	var jsonArray = [];
	
	if (masterList.length < 1) {
		cfn_msg("WARNING", "변경된 항목이 없습니다.");
		return false;
	}
	
	//변경RowIndex 추출
	var states = $grid.dataProvider().getAllStateRows();
	var stateRowidxs = states.created;
	
	//필수입력 체크
	if ($grid.gfn_checkValidateCells(stateRowidxs)) return false;
	
	for (i=0; i<masterList.length; i++) {
		
		if (masterList[i].rowStatusCd != "U") {
			var tag = masterList[i].tag;
			var statusCd = "";
			
			switch (tag) {
				case "Wating" :
					statusCd = "10";
					break;
				case "InfoReceived" :
					statusCd = "30";
					break;
				case "Pending" :
					statusCd = "40";
					break;
				case "InTransit" :
					statusCd = "50";
					break;
				case "Delivered" :
					statusCd = "60";
					break;
				case "API Error" :
					statusCd = "80";
					break;
				default:
					statusCd = "99";
					break;
			}
			var jsonObj = {};
			
			jsonObj.adddatetime = masterList[i].checkPointDate;
			jsonObj.nation = masterList[i].nation;
			jsonObj.invcSno = $("#xrtInvcSno").val()||"";
			jsonObj.ordCd = $("input[name='ordCd']").val()||"";
			jsonObj.statusCd = statusCd;
			jsonArray.push(jsonObj);
		}
	}
	
	if (confirm('저장하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/fulfillment/tracking/trackingDtl/save.do';
		
		gfn_sendData(sid, url, jsonArray);
	}
}
</script>

<c:import url="/comm/contentBottom.do" />