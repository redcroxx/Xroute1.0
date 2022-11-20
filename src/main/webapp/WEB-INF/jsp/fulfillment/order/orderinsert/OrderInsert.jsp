<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst" %>
<!-- 
	화면코드 : orderinsert
	화면명    : 일괄오더등록
-->
<div id="OrderInsert" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_orderinsert" action="#" onsubmit="return false">
			<p id="lbl_name" style=" padding-left: 10px;"><b>오더등록</b></p>
			<input type="hidden" id="COMPCD" class="cmc_txt" />
			<input type="hidden" id="PGMID" class="cmc_txt" value="ORDERLIST"/>
			<input type="hidden" id="FILE_YMD" />
			<ul class="sech_ul">
				<li class="sech_li required">
					<div>셀러</div>
					<div>
						<input type="text" id="ORGCD" name="ORGCD" class="cmc_code required" />
						<input type="text" id="ORGNM" name="ORGNM" class="cmc_value" />
						<button type="button" id="btn_ORGCD" class="cmc_cdsearch"></button>
					</div>
				</li>
				<li class="sech_li required">
					<div>창고코드/명</div>
					<div>
						<input type="text" id="WHCD" class="cmc_code required" />
						<input type="text" id="WHNM" class="cmc_value" />
						<button type="button" id="WHCD_BTN" class="cmc_cdsearch"></button>
					</div>
				</li>
				<li class="sech_li required">
					<div>오더양식</div>
					<div>
						<select id="SITE_CD" class="cmc_combo required">
							<option value="">선택</option>
						</select>
					</div>
				</li>
			</ul>
			<br>
			<ul style="padding-left: 10px;">
				<li>
					<div style="border: 1px solid gray; width:1000px; height: 140px;">
						<p>
							<b style="padding-left: 10px;">Xroute 샘플 파일 다운로드</b>
						</p>
						<p style="padding-left: 20px;">
							Xroute의 오더 샘플 파일을 다운로드하시고 오더 내용을 기입 후 업로드하시면 더욱 빠르게
							오더를 생성할 수 있습니다.&emsp;&emsp;&emsp;&emsp;&emsp;<input style="width:150px;" type="button" value="샘플 Excel 다운로드"	onclick="fn_excel_sample();" />
						</p>
						<p style="padding-left: 20px;">
							국가 코드와 통화 코드는 다운로드한 엑셀파일의 2번, 3번 시트를 참고하셔서 작성해주시면 됩니다.<br>
							미국 주(State)는 다운로드한 엑셀파일의 4번 시트를 참고하셔서 작성해주시면 됩니다.<br>
							<font color="red">※ 결제금액과 상품수량은 반드시 숫자로만 입력해주세요.</font><br>
							<font color="red">※ 물품 배송방식은 [PREMIUM, UPS] 중에서 이용 가능합니다. </font><br>
							<font color="red">※ PREMIUM은 미국, 대만, 일본, 홍콩, 싱가폴, 필리핀, 말레이시아 선택이 가능합니다. </font><br>
						</p>
					</div>
				</li>
			</ul>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	<!-- 업로드 리스트 그리드 -->
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">업로드 리스트<span>(총 0건)</span></div>
			<div class="grid_top_right">
				<button type="button" id="btn_uploadAdd" class="cmb_plus" onclick="fn_uploadAddRow()"></button>
				<button type="button" id="btn_uploadDel" class="cmb_minus" onclick="fn_uploadDelRow()"></button>
			</div>
		</div>
		<div id="grid_OrderInsert"></div>
	</div> 
	
	<!-- 국가코드 리스트(export 하기 위한 그리드, 화면에는 보여주지 않는다)-->
	<div class="ct_top_wrap" style="display:none">
		<div class="grid_top_wrap">
			<div class="grid_top_left">국가코드 리스트<span>(총 0건)</span></div>
		</div>
		<div class="grid_top_right"></div>
		<div id="grid_CountryCode"></div>
	</div>
	
	<!-- 통화코드 리스트(export 하기 위한 그리드, 화면에는 보여주지 않는다 -->
	<div class="ct_top_wrap" style="display:none">
		<div class="grid_top_wrap">
			<div class="grid_top_left">통화코드 리스트<span>(총 0건)</span></div>
		</div>
		<div id="grid_CurrencyCode"></div>
	</div>

	<!-- 주(State) 리스트(export 하기 위한 그리드, 화면에는 보여주지 않는다 -->
	<div class="ct_top_wrap" style="display:none">
		<div class="grid_top_wrap">
			<div class="grid_top_left">주(State) 리스트<span>(총 0건)</span></div>
		</div>
		<div id="grid_USStateCode"></div>
	</div>
	
</div>
<script type="text/javascript">
var chk=0;
$(function() {
	
	$("#FILE_YMD").val(cfn_getDateFormat(new Date(), "yyyyMMdd"));
	$("#COMPCD").val("<c:out value='${sessionScope.loginVO.compcd}' />");
	$("#ORGCD").val("<c:out value='${sessionScope.loginVO.orgcd}' />");
	$("#ORGNM").val("<c:out value='${sessionScope.loginVO.orgnm}' />");
	$("#WHCD").val("<c:out value='${sessionScope.loginVO.whcd}' />");
	$("#WHNM").val("<c:out value='${sessionScope.loginVO.whnm}' />");
	
	var usergroup = "<c:out value='${sessionScope.loginVO.usergroup}' />";
	var sellerGroup = "<c:out value='${SELLER_ADMIN}' />";
	var propFalse = {"readonly": false, "disabled": false};
	var propTrue = {"readonly": true, "disabled": true};

	if (usergroup > sellerGroup) {
		$("#WHCD").removeClass("disabled").prop(propFalse);
		$("#WHNM").removeClass("disabled").prop(propFalse);
		$("#WHNM").next().removeClass("disabled").prop(propFalse);
		
		$("#ORGCD").removeClass("disabled").prop(propFalse);
		$("#ORGNM").removeClass("disabled").prop(propFalse);
		$("#ORGNM").next().removeClass("disabled").prop(propFalse);
	} else if (usergroup <= sellerGroup) {
		$("#WHCD").addClass("disabled").prop(propTrue);
		$("#WHNM").addClass("disabled").prop(propTrue);
		$("#WHNM").next().addClass("disabled").prop(propTrue);
		
		$("#ORGCD").addClass("disabled").prop(propTrue);
		$("#ORGNM").addClass("disabled").prop(propTrue);
		$("#ORGNM").next().addClass("disabled").prop(propTrue);
	}
	
	fn_sitecd(); // 주문서양식불러오기
	
	$("#OrderInsert").lingoPopup({
		title: "오더등록"
		, width: 1350
		, height: 900
		, buttons: {
			"체크": {
				text: "체크"
				, class: "popbtnExcel"
				, click: function() {
					//검색조건 필수입력 체크
					if (cfn_isFormRequireData("frm_search_orderinsert") == false) return; 
					
					var param = cfn_getFormData("frm_search_orderinsert");
					var url = "/fulfillment/order/OrderInsert/getSiteColEdit.do";
					var sendData = {"paramData": param};
					
					gfn_ajax(url, false, sendData, function (data, xhr) {
						ck1 = data.resultList1;
						ck2 = data.resultList2;
						var $g = $("#grid_OrderInsert"); 
						var gridData = $g.gfn_getDataList(true, false);
						var columns = $g.gridView().getColumns();
						var colNames = [], excludeColumns = [];
						if (cfn_isEmpty(gridData)) {
							cfn_msg("WANRING", "데이터가 없습니다.");
							return false;
						}
						
						for (var i=0, len=gridData.length; i<len; i++) {
							// 치환
							for (var k=0, len2=ck2.length; k<len2; k++) {
								if (cfn_isEmpty(ck2[k].REPLACES1)) {
									if (cfn_isEmpty(gridData[i][ck2[k].TGT_COL]))
										gridData[i][ck2[k].TGT_COL] = ck2[k].REPLACES2;
								} else {
									gridData[i][ck2[k].TGT_COL] = cfn_replaceAll(gridData[i][ck2[k].TGT_COL], ck2[k].REPLACES1, ck2[k].REPLACES2);
								}
							}
							// 병합
							for (var j=0, len1=ck1.length; j<len1; j++) {
								if (!cfn_isEmpty(ck1[j].TGT_COL)) {
									var c1 = cfn_isEmpty(ck1[j].SRC_COLS1)? "":(cfn_isEmpty(gridData[i][ck1[j].SRC_COLS1])? "":gridData[i][ck1[j].SRC_COLS1]);
									var c2 = cfn_isEmpty(ck1[j].SEPS1)? "":ck1[j].SEPS1.toString();
									var c3 = cfn_isEmpty(ck1[j].SRC_COLS2)? "":(cfn_isEmpty(gridData[i][ck1[j].SRC_COLS2])? "":gridData[i][ck1[j].SRC_COLS2]);
									var c4 = cfn_isEmpty(ck1[j].SEPS2)? "":ck1[j].SEPS2.toString();
									var c5 = cfn_isEmpty(ck1[j].SRC_COLS3)? "":(cfn_isEmpty(gridData[i][ck1[j].SRC_COLS3])? "":gridData[i][ck1[j].SRC_COLS3]);
									gridData[i][ck1[j].TGT_COL] = c1 + c2 + c3 + c4 + c5;
								}
							}
						}
						$("#grid_OrderInsert").gfn_setDataList(gridData);
					})
					
					$("#grid_OrderInsert").gridView().commit(true);
					$("body").css("cursor", "wait");
					loadingStart();
					// 메시지 초기화
					ckmsg = [];
					var columns = $("#grid_OrderInsert").gridView().getColumns();
					var gridDataRows = $("#grid_OrderInsert").gfn_getDataList();
					for (var i=0, len = gridDataRows.length; i<len; i++) {
						$("#grid_OrderInsert").gfn_setValue(i, "CHKMSG", "");
					}
					// 자릿수 체크
					var failData = $("#grid_OrderInsert").gridView().checkValidateCells();
					$("#grid_OrderInsert").gridView().clearInvalidCellList();
					
					var collen = columns.length;
					var rowlen = gridDataRows.length;
					
					var j=0;
					for (var i=0, len=ckmsg.length; i<len; i++) {
						j = parseInt(i / collen);
						if (!cfn_isEmpty(ckmsg[i])) {
							$("#grid_OrderInsert").gfn_setValue(j, "CHKMSG", $("#grid_OrderInsert").gfn_getValue(j, "CHKMSG") + ckmsg[i].message + ",");
						}
					}
					
					loadingEnd();
					$("body").css("cursor", "default");
					
					var gridDataList = $("#grid_OrderInsert").gfn_getDataList(true, false);
					if (gridDataList.length < 1) {
						cfn_msg("WARNING", "등록된 내역이 없습니다.");
						return false;
					}
					
					var param = cfn_getFormData("frm_search_orderinsert");
					var url = "/fulfillment/order/OrderInsert/setCheck.do";
					var sendData = {"paramData":param, "paramList":gridDataList};
					
					gfn_ajax(url, true, sendData, function(data, xhr) {
						var gridData = data.resultList;
						$("#grid_OrderInsert").gfn_setDataList(gridData);
						// 체크 확인
						chk = 1;
						for (var i=0, len=gridDataList.length; i<len; i++) {
							if (!cfn_isEmpty($("#grid_OrderInsert").gfn_getValue(i, "CHKMSG"))) {
								chk = 0;
								cfn_msg("ERROR", "에러내역이 있습니다.");
								return;
							}
						}
						cfn_msg("INFO", "체크가 완료되었습니다.");
					});
				}
			}
			, "오더 저장": {
				text: "오더 저장"
				, click: function() {
					//검색조건 필수입력 체크
					if(cfn_isFormRequireData("frm_search_orderinsert") == false) return;
					
					var gridDataList = $("#grid_OrderInsert").gfn_getDataList();
					
					// 등록내역이 없다면 처리 불가
					if (gridDataList.length < 1) {
						cfn_msg("WARNING", "등록된 내역이 없습니다.");
						return false;
					}
					
					if (chk == 0) {
						cfn_msg("WARNING", "체크 확인후 업로드 하시기 바랍니다.");
						return;
					}
					
					var paramData = cfn_getFormData("frm_search_orderinsert");
					paramData.FILE_NM_REAL = $("#xlf").val()
					
					var sendData = {"paramData" : paramData};
					var url = "/fulfillment/order/OrderInsert/upload.do";
					if (confirm("오더가 저장됩니다. 저장하시겠습니까?")){
						gfn_ajax(url, true, sendData, function(data, xhr) {
							cfn_msg("INFO", "오더 저장 처리되었습니다.");
							fn_orderInsertclose(data);
						});
					}
				}
			}
			, "닫기": {
				text: "취소"
				, click: function() {
					$(this).lingoPopup("setData", "");
					$(this).lingoPopup("close");
				}
			}
		} ,
		open: function(data) {
			cfn_bindFormData("frm_search_orderinsert", data);	
			//엑셀업로드
			$(".popbtnExcel").before("<form id='frmupload' action='#' method='post' enctype='multipart/form-data'>"
			+ "<input type='file' accept='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel'"
			+ "name='excelfile' id='xlf' class='popbtnleft' style='margin:10px 0 0 5px;' /></form>");
			
			$("#xlf").bind("click", function(e) {
				//검색조건 필수입력 체크
				if (cfn_isFormRequireData("frm_search_orderinsert") == false) return false;
				this.value = null; 
			});

			$("#xlf").bind("change", function(e) {
				gfn_handleXlsFile(e, "grid_OrderInsert", gcolumns);
			});
			
			
			// 업로드 화면에 따른 그리드 정보 조회 
			grid_CountryCode();
			grid_CurrencyCode();
			grid_USStateCode();
			fn_init_orderinsert(); 
		} 
	});
	
	/* 화주 */
	pfn_codeval({
		url: "/alexcloud/popup/popP002/view.do"
		, codeid: "ORGCD"
		, inparam: {S_COMPCD:"COMPCD", S_COMPCD:"ORGCD,ORGNM"}
		, outparam: {ORGCD:"ORGCD", NAME:"ORGNM"}
		, returnFn: function(data, type) {}
	});
	
	/* 창고 */
	pfn_codeval({
		url: "/alexcloud/popup/popP004/view.do"
		, codeid: "WHCD"
		, inparam: {S_COMPCD:"COMPCD", S_COMPCD:"WHCD,WHNM"}
		, outparam: {WHCD:"WHCD", NAME:"WHNM"}
	});

});

function fn_orderInsertclose(data){
	$("#OrderInsert").lingoPopup("setData", data.resultData);
	$("#OrderInsert").lingoPopup("close", "OK");
}

var ckmsg = [];
var gcolumns = [];
// 그리드 생성
function grid_Load_orderinsert(data) {
	var gid = "grid_OrderInsert";
	var columns = [];
	
	columns.push({name:"CHKMSG", header:{text:"체크메시지"}, width:250});
	gcolumns.push("CHKMSG");
	for(var i=0; i<data.length; i++){
		
		var req = (data[i].ISCHECK == "Y"); 
		columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:120,editable:true,editor:{maxLength:data[i].MAXLEN},required:req});
		gcolumns.push(data[i].COLUM);
	}
	
	//그리드 생성
	$("#"+ gid).gfn_createGrid(columns,{
		pasteflg:true
		, cmenuGroupflg:false
		, cmenuColChangeflg:false
		, cmenuColSaveflg:false
		, cmenuColInitflg:false
	});
	//그리드설정 및 이벤트처리
	$("#"+ gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		gridView.onValidateColumn = function(grid, column, inserting, value) {
			
			var gCols = $("#grid_OrderInsert").columns();
			
			var error = {};
			for (var i=0, len=gCols.length; i<len; i++) {
				if (column.fieldName == gCols[i].fieldName) {
					if (!cfn_isEmpty(gCols[i].editor) && !cfn_isEmpty(gCols[i].editor.maxLength)) {
						if (!cfn_isEmpty(value) && value.length > gCols[i].editor.maxLength) {
							error.level = RealGridJS.ValidationLevel.ERROR;
							error.message = column.header.text +" 자릿수 초과["+ gCols[i].editor.maxLength +"]";
						}	
					}
				}
			}
			ckmsg.push(error);
			return null;
		};
	});
}

/* 국가코드 그리드 */
function grid_CountryCode() {
	var gid = "grid_CountryCode";
	var columns = [
		{name:"COUNTRY_ENG", header:{text:"국가명"}, styles:{textAlignment:"center"}, width:150}
		, {name:"COUNTRY_CD", header:{text:"국가코드"}, styles:{textAlignment:"center"}, width:150}
	];

	//그리드 생성 (realgrid 써서)
	$("#"+ gid).gfn_createGrid(columns, {
		footerflg : false
	});
}

/* 통화코드 그리드 */
function grid_CurrencyCode() {
	var gid = "grid_CurrencyCode";
	var columns = [
		{name:"CURRENCY_CD", header:{text:"통화코드"}, styles:{textAlignment:"center"}, width:150}
		, {name:"CURRENCY_NAME1", header:{text:"명칭1"}, styles:{textAlignment:"center"}, width:150}
		, {name:"CURRENCY_NAME2", header:{text:"명칭2"}, styles:{textAlignment:"center"}, width:150}
	];

	//그리드 생성 (realgrid 써서)
	$("#"+ gid).gfn_createGrid(columns, {
		footerflg : false
	});
}

/* 주(State) 그리드 */
function grid_USStateCode() {
	var gid = "grid_USStateCode";
	var columns = [
		{name:"STATE_CD", header:{text:"코드"}, styles:{textAlignment:"center"}, width:150}
		, {name:"STATE_NAME1", header:{text:"명칭1"}, styles:{textAlignment:"center"}, width:150}
	];

	//그리드 생성 (realgrid 써서)
	$("#"+ gid).gfn_createGrid(columns, {
		footerflg : false
	});
}

//그리드 행추가 버튼 클릭
function fn_uploadAddRow() {
	$("#grid_OrderInsert").gfn_addRow();
}

//그리드 행삭제 버튼 클릭
function fn_uploadDelRow() {
	var $grid1 = $("#grid_OrderInsert");
	var rowidx = $grid1.gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg("WARNING", "선택된 항목이 없습니다.");
		return false;
	}
	
	var state = $grid1.dataProvider().getRowState(rowidx);
	$grid1.gfn_delRow(rowidx);
}

/* 업로드 화면에 따른 그리드 정보 조회 */
function fn_init_orderinsert(){
	var paramData = cfn_getFormData("frm_search_orderinsert");
	
	var sendData = {"paramData": paramData};
	var url = "/fulfillment/order/OrderInsert/init.do";
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		grid_Load_orderinsert(data.paramList);
		$("#grid_CountryCode").gfn_setDataList(data.countryList);
		$("#grid_CurrencyCode").gfn_setDataList(data.currencyList);
		$("#grid_USStateCode").gfn_setDataList(data.usstateList);
	});
}

//주문서양식명 가져오기(SELECTBOX)
function fn_sitecd(){
	var orgcd = $("#ORGCD").val();
	var url = "/fulfillment/order/OrderInsert/getSiteCd.do";
	var sendData = {"paramData": {"COMPCD": "<c:out value='${sessionScope.loginVO.compcd}' />", "ORGCD":"C0001", "SITE_NM":"신규오더"}};
	
	gfn_ajax(url, false, sendData, function (data, xhr) {
		var list = data.resultList;
		var siteHtml = "";
		for (var i=0; i<list.length; i++) {
			siteHtml += "<option value='"+ list[i].CODE +"'>"+ list[i].VALUE +"</option>";
		}
		$("#SITE_CD").html(siteHtml);
	});
} 

//샘플excel 업로드파일 다운로드
function fn_excel_sample(){
	var $g = "grid_OrderInsert";
	var $g2 = "grid_CountryCode";
	var $g3 = "grid_CurrencyCode";
	var $g4 = "grid_USStateCode";
	
	RealGridJS.exportGrid({
		type:"excel"
		, target: "local"
		, fileName:"upload_sample.xlsx"
		, showProgress: "Y"
		, applyDynamicStyles: true
		, progressMessage: "엑셀 Export중입니다."
		, header: "default"
		, footer: "default"
		, compatibility: "2010"
		, lookupDisplay: true
		, exportGrids: [
			{grid:$("#"+ $g).gridView(), sheetName:"업로드샘플양식", indicator:"hidden"} // 행번호 visable 여부*
			, {grid:$("#"+ $g2).gridView(), sheetName:"국가코드", indicator:"hidden"}
			, {grid:$("#"+ $g3).gridView(), sheetName:"통화코드", indicator:"hidden"}
			, {grid:$("#"+ $g4).gridView(), sheetName:"주(State)", indicator:"hidden"}
		]
		, done: function() {
		}
	});
}
</script>