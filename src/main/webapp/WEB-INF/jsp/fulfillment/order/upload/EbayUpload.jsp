<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst" %>

<div id="ebayUpload" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frmSearchEbayUpload" action="#" onsubmit="return false">
			<p id="lbl_name" style=" padding-left: 10px;"><b>이베이 등록</b></p>
			<input type="hidden" id="compcd" class="cmc_txt" />
			<input type="hidden" id="pgmid" class="cmc_txt" value='ORDERLIST'/>
			<input type="hidden" id="fileYmd" />
			<ul class="sech_ul">
				<li class="sech_li required">
					<div>셀러</div>
					<div>
						<input type="text" id="orgcd" name="orgcd" class="cmc_code required" />
						<input type="text" id="orgnm" name="orgnm" class="cmc_value" />
						<button type="button" id="btnorgcd" class="cmc_cdsearch"></button>
					</div>
				</li>
				<li class="sech_li required">
					<div>창고코드/명</div>
					<div>
						<input type="text" id="whcd" class="cmc_code required" />
						<input type="text" id="whnm" class="cmc_value" />
						<button type="button" id="btnwhcd" class="cmc_cdsearch"></button>
					</div>
				</li>
				<li class="sech_li required">
					<div>오더양식</div>
					<div>
						<select id=siteCd class="cmc_combo required">
							<option value="">선택</option>
						</select>
					</div>
				</li>
			</ul>
			<br>
			<ul style="padding-left: 10px;">
				<li>
					<div style="border: 1px solid gray; width: 1000px;">
						<p>
							<b style="padding-left: 10px;">이베이 샘플 파일 다운로드</b>
							&emsp;&emsp;&emsp;&emsp;&emsp; <input style="width: 150px;" type="button" value="샘플 Excel 다운로드"	onclick="fn_excel_sample();" />
						</p>
						<p style="padding-left: 20px;">
							transactionId, itemNumber 데이터 앞에 '를 입력해주시길 바랍니다. 예) '11112222333 <br>
							<font color="red">※ 결제금액과 상품수량은 반드시 숫자로만 입력해주세요.</font><br>
							<font color="red">※ ItemTitle은 반드시 영문, 숫자만 입력해주세요.</font><br>
							<font color="red">※ 물품 배송방식은 [PREMIUM] 사용가능 합니다.</font><br>
							<font color="red">※ 현재 국가는 미국만 가능 합니다.</font><br>
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
				배송 타입 : 
				<select class='cmc_code required' id="shipMethod">
					<option value="">선택</option>
					<option value="PREMIUM">PREMIUM</option>
				</select>
			</div>
		</div>
		<div id="gridEbayUpload"></div>
	</div>
</div>
<script type="text/javascript">
var chk=0;
var _columName = [
	"salesRecordNumber", "orderNumber", "buyerUsername", "buyerName", "buyerEmail", "buyerNote", 
	"buyerAddress1", "buyerAddress2", "buyerCity", "buyerState", "buyerZip", "buyerCountry", 
	"shipToName", "shipToPhone", "shipToAddress1", "shipToAddress2", "shipToCity", "shipToState", 
	"shipToZip", "shipToCountry", "itemNumber", "itemTitle", "customLabel", "soldViaPromotedListings", 
	"quantity", "soldFor", "shippingAndHandling", "sellerCollectedTax", "eBayCollectedTax", 
	"electronicWasteRecyclingFee", "mattressRecyclingFee", "additionalFee", "totalPrice", 
	"eBayCollectedTaxAndFeesIncludedInTotal", "paymentMethod", "saleDate", "paidOnDate", "shipByDate", 
	"minimumEstimatedDeliveryDate", "maximumEstimatedDeliveryDate", "shippedOnDate", "feedbackLeft", 
	"feedbackReceived", "myItemNote", "payPalTransactionId", "shippingService", "trackingNumber", 
	"transactionId", "variationDetails", "globalShippingProgram", "globalShippingReferenceId",
	"clickAndCollect", "clickAndCollectReferenceNumber", "eBayPlus"
];

$(function() {
	
	$("#compcd").val(cfn_loginInfo().COMPCD);
	$("#fileYmd").val(cfn_getDateFormat(new Date(), "yyyyMMdd"));
	
	if (!cfn_isEmpty(cfn_loginInfo().ORGCD)) {
		$("#orgcd").addClass("disabled").prop({"readonly":"readonly", "disabled":true});
		$("#orgnm").addClass("disabled").prop({"readonly":"readonly", "disabled":true});
		$("#btnorgcd").addClass("disabled").prop({"disabled":true});
		$("#orgcd").val(cfn_loginInfo().ORGCD);
		$("#orgnm").val(cfn_loginInfo().ORGNM);
	}
	
	if (cfn_loginInfo().USERGROUP == "${SELLER_ADMIN}") {
		$("#whcd").val(cfn_loginInfo().WHCD);
		$("#whnm").val(cfn_loginInfo().WHNM);
		$("#whcd").prop("disabled",true);
		$("#whnm").prop("disabled",true);
		$("#btnwhcd").prop("disabled",true);
	}
	
	fn_sitecd();//주문서양식불러오기
	
	$("#ebayUpload").lingoPopup({
		title : "이베이 업로드"
		, width : 1350
		, height : 900
		, buttons: {
			"오더 저장":{
				text:"오더 저장"
				, class:"popbtnExcel"
				, click:function() {
					var shipMethod = $("#shipMethod").val()||"";
					//검색조건 필수입력 체크
					if (cfn_isFormRequireData("frmSearchEbayUpload") == false) return;
					if (shipMethod == "") {
						cfn_msg('WARNING', "배송타입을 지정하십시오.");
						$("#shipMethod").focus();
						return;
					};
					
					var gridDataList = $('#gridEbayUpload').gfn_getDataList(true, false);
					
					if (gridDataList.length < 1) {
						cfn_msg("WARNING", "등록된 내역이 없습니다.");
						return false;
					}
					
					var param = cfn_getFormData("frmSearchEbayUpload");
					param.shipMethod = shipMethod;
					var url = "/fulfillment/order/ebay/upload.do";
					var sendData = {"paramData":param, "paramList":gridDataList};
					
					gfn_ajax(url, true, sendData, function(data, xhr) {
						if (data.CODE == "1") {
							cfn_msg("info", data.MESSAGE);
							fn_ebayUploadclose();
						}
					});
				}
			}
			, "닫기": {
				text:"취소",
				click:function() {
					$(this).lingoPopup("setData", "");
					$(this).lingoPopup("close");
				}
			}
		} ,
		open: function(data) {
			cfn_bindFormData("frmSearchEbayUpload", data);	
			
			fn_griebayUploadList();
			
			//엑셀업로드
			$(".popbtnExcel").before("<form id='frmupload' action='#' method='post' enctype='multipart/form-data'>"
					+ "<input type='file' accept='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel'"
					+ "name='excelfile' id='xlf' class='popbtnleft' style='margin:10px 0 0 5px;' /></form>");
			
			$("#xlf").bind("click", function(e){
				//검색조건 필수입력 체크
				if (cfn_isFormRequireData("frmSearchEbayUpload") == false) return false;
				
				this.value = null; 
			});

			$("#xlf").bind("change", function(e){
				gfn_handleXlsFile(e, "gridEbayUpload", _columName);
			}); 
		} 
	});
	/* 화주 */
	pfn_codeval({
		url: "/alexcloud/popup/popP002/view.do"
		, codeid: "orgcd"
		, inparam: {S_COMPCD:"compcd", S_COMPCD:"orgcd,orgnm"}
		, outparam: {ORGCD:"orgcd", NAME:"orgnm"},
		returnFn: function(data, type) {}
	});
	
	/* 창고 */
	pfn_codeval({
		url: "/alexcloud/popup/popP004/view.do"
		, codeid: "whcd"
		, inparam: {S_COMPCD:"compcd", S_COMPCD: "whcd,whnm"}
		, outparam: {WHCD:"whcd", NAME:"whnm"}
	});
});

function fn_ebayUploadclose(){
	$("#ebayUpload").lingoPopup("setData", "");
	$("#ebayUpload").lingoPopup("close", "OK");
}

function authority_Load(){
	if (cfn_loginInfo().USERGROUP == "${XROUTE_ADMIN}") {
	} else {	
		$("#whcd").val(cfn_loginInfo().WHCD);
		$("#whcd").prop("disabled", true);
	}
};

function fn_griebayUploadList() {
	var gid = "gridEbayUpload";
	var textAlignment = {textAlignment:"center"};
	var columns = [
		{name:"salesRecordNumber", header:{text:"salesRecordNumber"}, style:textAlignment, editable:false, width:150}
		, {name:"orderNumber", header:{text:"orderNumber"}, style:textAlignment, editable:false, width:120}
		, {name:"buyerUsername", header:{text:"buyerUsername"}, style:textAlignment, editable:false, width:120}
		, {name:"buyerName", header:{text:"buyerName"}, style:textAlignment, editable:false, width:120}
		, {name:"buyerEmail", header:{text:"buyerEmail"}, style:textAlignment, editable:false, width:120}
		, {name:"buyerNote", header:{text:"buyerNote"}, style:textAlignment, editable:false, width:120}
		, {name:"buyerAddress1", header:{text:"buyerAddress1"}, style:textAlignment, editable:false, width:120}
		, {name:"buyerAddress2", header:{text:"buyerAddress2"}, style:textAlignment, editable:false, width:120}
		, {name:"buyerCity", header:{text:"buyerCity"}, style:textAlignment, editable:false, width:120}
		, {name:"buyerState", header:{text:"buyerState"}, style:textAlignment, editable:false, width:120}
		, {name:"buyerZip", header:{text:"buyerZip"}, style:textAlignment, editable:false, width:120}
		, {name:"buyerCountry", header:{text:"buyerCountry"}, style:textAlignment, editable:false, width:120}
		, {name:"shipToName", header:{text:"shipToName"}, style:textAlignment, editable:false, width:120}
		, {name:"shipToPhone", header:{text:"shipToPhone"}, style:textAlignment, editable:false, width:120}
		, {name:"shipToAddress1", header:{text:"shipToAddress1"}, style:textAlignment, editable:false, width:120}
		, {name:"shipToAddress2", header:{text:"shipToAddress2"}, style:textAlignment, editable:false, width:120}
		, {name:"shipToCity", header:{text:"shipToCity"}, style:textAlignment, editable:false, width:120}
		, {name:"shipToState", header:{text:"shipToState"}, style:textAlignment, editable:false, width:120}
		, {name:"shipToZip", header:{text:"shipToZip"}, style:textAlignment, editable:false, width:120}
		, {name:"shipToCountry", header:{text:"shipToCountry"}, style:textAlignment, editable:false, width:120}
		, {name:"itemNumber", header:{text:"itemNumber"}, style:textAlignment, editable:false, width:120}
		, {name:"itemTitle", header:{text:"itemTitle"}, style:textAlignment, editable:false, width:120}
		, {name:"customLabel", header:{text:"customLabel"}, style:textAlignment, editable:false, width:120}
		, {name:"soldViaPromotedListings", header:{text:"soldViaPromotedListings"}, style:textAlignment, editable:false, width:150}
		, {name:"quantity", header:{text:"quantity"}, style:textAlignment, editable:false, width:120}
		, {name:"soldFor", header:{text:"soldFor"}, style:textAlignment, editable:false, width:120}
		, {name:"shippingAndHandling", header:{text:"shippingAndHandling"}, style:textAlignment, editable:false, width:120}
		, {name:"sellerCollectedTax", header:{text:"sellerCollectedTax"}, style:textAlignment, editable:false, width:120}
		, {name:"eBayCollectedTax", header:{text:"eBayCollectedTax"}, style:textAlignment, editable:false, width:120}
		, {name:"electronicWasteRecyclingFee", header:{text:"electronicWasteRecyclingFee"}, style:textAlignment, editable:false, width:150}
		, {name:"mattressRecyclingFee", header:{text:"mattressRecyclingFee"}, style:textAlignment, editable:false, width:150}
		, {name:"additionalFee", header:{text:"additionalFee"}, style:textAlignment, editable:false, width:120}
		, {name:"totalPrice", header:{text:"totalPrice"}, style:textAlignment, editable:false, width:120}
		, {name:"eBayCollectedTaxAndFeesIncludedInTotal", header:{text:"eBayCollectedTaxAndFeesIncludedInTotal"}, style:textAlignment, editable:false, width:220}
		, {name:"paymentMethod", header:{text:"paymentMethod"}, style:textAlignment, editable:false, width:120}
		, {name:"saleDate", header:{text:"saleDate"}, style:textAlignment, editable:false, width:120}
		, {name:"paidOnDate", header:{text:"paidOnDate"}, style:textAlignment, editable:false, width:120}
		, {name:"shipByDate", header:{text:"shipByDate"}, style:textAlignment, editable:false, width:120}
		, {name:"minimumEstimatedDeliveryDate", header:{text:"minimumEstimatedDeliveryDate"}, style:textAlignment, editable:false, width:150}
		, {name:"maximumEstimatedDeliveryDate", header:{text:"maximumEstimatedDeliveryDate"}, style:textAlignment, editable:false, width:150}
		, {name:"shippedOnDate", header:{text:"shippedOnDate"}, style:textAlignment, editable:false, width:120}
		, {name:"feedbackLeft", header:{text:"feedbackLeft"}, style:textAlignment, editable:false, width:120}
		, {name:"feedbackReceived", header:{text:"feedbackReceived"}, style:textAlignment, editable:false, width:120}
		, {name:"myItemNote", header:{text:"myItemNote"}, style:textAlignment, editable:false, width:120}
		, {name:"payPalTransactionId", header:{text:"payPalTransactionId"}, style:textAlignment, editable:false, width:120}
		, {name:"shippingService", header:{text:"shippingService"}, style:textAlignment, editable:false, width:120}
		, {name:"trackingNumber", header:{text:"trackingNumber"}, style:textAlignment, editable:false, width:120}
		, {name:"transactionId", header:{text:"transactionId"}, style:textAlignment, editable:false, width:120}
		, {name:"variationDetails", header:{text:"variationDetails"}, style:textAlignment, editable:false, width:120}
		, {name:"globalShippingProgram", header:{text:"globalShippingProgram"}, style:textAlignment, editable:false, width:120}
		, {name:"globalShippingReferenceId", header:{text:"globalShippingReferenceId"}, style:textAlignment, editable:false, width:120}
		, {name:"clickAndCollect", header:{text:"clickAndCollect"}, style:textAlignment, editable:false, width:120}
		, {name:"clickAndCollectReferenceNumber", header:{text:"clickAndCollectReferenceNumber"}, style:textAlignment, editable:false, width:180}
		, {name:"eBayPlus", header:{text:"eBayPlus"}, style:textAlignment, editable:false, width:120}
	];

	//그리드 생성 (realgrid 써서)
	$("#"+ gid).gfn_createGrid(columns, {
		footerflg: false
		, cmenuGroupflg: false
		, cmenuColChangeflg: false
		, cmenuColSaveflg: false
		, cmenuColInitflg: false
		, height:"95%"
	});

	//그리드설정 및 이벤트처리
	$("#"+ gid).gfn_setGridEvent(function(gridView, dataProvider) {
		gridView.setFixedOptions({
			colCount: 2
			, resizable: true
			, colBarWidth: 1
		});
	});
}

//주문서양식명 가져오기(SELECTBOX)
function fn_sitecd() {
	var orgcd = $("#orgcd").val();
	var url = "/fulfillment/order/ebay/getSiteCd.do";
	var sendData = {"paramData":{"COMPCD":cfn_loginInfo().COMPCD, "ORGCD":"C0001", "SITE_NM":"신규오더"}};
	
	gfn_ajax(url, false, sendData, function (data, xhr) {
		var list = data.resultList;
		var htmlString = "";
		for (var i = 0; i<list.length; i++) {
			htmlString += "<option value='"+list[i].CODE+"'>"+ list[i].VALUE +"</option>"
		}
		
		$("#siteCd").html(htmlString);
	});
} 

//샘플excel 업로드파일 다운로드
function fn_excel_sample(){
	var $g = "gridEbayUpload";
	
	RealGridJS.exportGrid({
		type: "excel"
		, target: "local"
		, fileName: "ebay_upload_sample.xlsx"
		, showProgress: "Y"
		, applyDynamicStyles: true
		, progressMessage: "엑셀 Export중입니다."
		, header: "default"
		, footer: "default"
		, compatibility: "2010"
		, lookupDisplay:true
		, exportGrids: [
			{grid:$("#"+ $g).gridView(), sheetName:"업로드샘플양식",indicator:"hidden"} // 행번호 visable 여부*
		]
		, done: function() {
		}
	});
}
</script>