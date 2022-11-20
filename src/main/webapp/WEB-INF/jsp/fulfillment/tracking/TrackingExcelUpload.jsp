<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst" %>
<div id="trackingExcel" class="pop_wrap">
	<div id="ct_sech_wrap">
		<form id="frmSearchTrackingExcel" action="#" onsubmit="return false">
			<p id="lbl_name" style=" padding-left: 10px;"><b>트랙킹 등록</b></p>
			<ul style="padding-left: 10px;">
				<li>
					<div style="border: 1px solid gray; width: 760px;">
						<p>
							<b style="padding-left: 10px;">트랙킹 등록 샘플 파일 다운로드</b>
							&emsp;&emsp;&emsp;&emsp;&emsp; <input style="width: 150px;" type="button" value="샘플 Excel 다운로드"	onclick="fn_excel_sample();" /><br>
							<font color="red">※ 지정된 국가만 사용 할 수 있습니다.</font><br>
							[해당국가코드 'KR':'Korea', 'SG':'Singapore', 'ID':'Indonesia', 'MY':'Malaysia', 'JP':'Japan', 'US':'United States', 'TH':'Thailand'
								, 'CN':'China', 'PH':'Philippines', 'TW':'Taiwan', 'CA':'Canada', 'HK':'Hongkong', 'AU':'Australia', 'NO':'Norway', 'RU':'Russia', 'VN':'Vietnam' ]<br>
							<font color="red">※tag는 숫자로 입력하시면됩니다.</font><br>
							[tag 코드 '10':'Wating', '30': 'InfoReceived', '40':'Pending', '50':'InTransit', '60':'Delivered', '80':'API Error']<br>
							<font color="red">※checkPointDate 열은 '2020-06-10 20:00:01 형식으로 입력하시길 바랍니다.</font><br>
						</p>
					</div>
				</li>
			</ul>
		</form>
	</div>
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">업로드 리스트<span>(총 0건)</span></div>
			<div class="grid_top_right"></div>
		</div>
		<div id="trackingExcelList"></div>
	</div>
</div>
<script type="text/javascript">
$(function() {
	$("#trackingExcel").lingoPopup({
		title: "트랙킹 엑셀 업로드",
		width: 800,
		height: 720,
		buttons: {
			"저장": {
				text: "저장",
				class: "popbtnExcel",
				click: function() {
					var gridDataList = $("#trackingExcelList").gfn_getDataList(true, false);
					
					if (gridDataList.length < 1) {
						cfn_msg("WARNING", "등록된 내역이 없습니다.");
						return false;
					}
					
					
					var param = cfn_getFormData("frmSearchTrackingExcel");
					var url = "/fulfillment/tracking/excel/upload.do";
					
					gfn_ajax(url, true, gridDataList, function(data, xhr) {
						if (data.CODE == "1") {
							cfn_msg("info", data.MESSAGE);
							popUpClose();
						}
					});
				}
			}
			, "닫기": {
				text: "취소",
				click: function() {
					$(this).lingoPopup("setData", "");
					$(this).lingoPopup("close");
				}
			}
		} ,
		open: function() {
			getList();
			
			//엑셀업로드
			$('.popbtnExcel').before('<form id="frmupload" action="#" method="post" enctype="multipart/form-data">' +
					'<input type="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" ' +
					'name="excelfile" id="xlf" class="popbtnleft" style="margin:10px 0 0 5px;" />' +
					'</form>');
			
			$("#xlf").bind("click", function(e){
				//검색조건 필수입력 체크
				if (cfn_isFormRequireData("frmSearchTrackingExcel") == false) return false;
				
				this.value = null; 
			});

			$("#xlf").bind("change", function(e){
				gfn_handleXlsFile(e, "trackingExcelList", ["invcSno", "checkPointDate", "nation", "tag"]);
			}); 
		}
	});
});
// 팝업창 닫기
function popUpClose(){
	$('#trackingExcel').lingoPopup('setData', "");
	$('#trackingExcel').lingoPopup('close', 'OK');
};
// 그리드 실행
function getList() {
	var gid = "trackingExcelList";
	var textAlignment = {textAlignment:'center'};
	var columns = [
		{name : "invcSno", header : {text : "invcSno"}, width : 150, editable : true, editor : {maxLength : 200}}
		, {name : "checkPointDate", header : {text : "checkPointDate"}, width : 150, editable : true, editor : {maxLength : 200}}
		, {name : "nation", header : {text : "nation"}, width : 150, editable : true, editor : {maxLength : 250}}
		, {name : "tag", header : {text : "tag"}, width : 150, editable : true, editor : {maxLength : 350}}
	];

	//그리드 생성 (realgrid 써서)
	$('#' + gid).gfn_createGrid(columns, {
		footerflg : false,
		cmenuGroupflg:false,
		cmenuColChangeflg:false,
		cmenuColSaveflg:false,
		cmenuColInitflg:false,
		height:'90%'
	});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		gridView.setFixedOptions({
			colCount : 2,
			resizable : true,
			colBarWidth : 1
		});
	});
};
//샘플excel 업로드파일 다운로드
function fn_excel_sample(){
	var $g = "trackingExcelList";
	
	RealGridJS.exportGrid({
		type: "excel"
		, target: "local"
		, fileName: "tracking_upload_sample" + ".xlsx"
		, showProgress: "Y"
		, applyDynamicStyles: true
		, progressMessage: "엑셀 Export중입니다."
		, header: "default"
		, footer: "default"
		, compatibility: "2010"
		, lookupDisplay:true
		, exportGrids: [
			{grid:$("#"+$g).gridView(), sheetName:"업로드샘플양식", indicator: "hidden"} // 행번호 visable 여부*
		]
		, done: function() {
		}
	});
};
</script>