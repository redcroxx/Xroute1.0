<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst" %>
<div id="etsyUpload" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frmSearchEtsyUpload" action="#" onsubmit="return false">
			<p id="lbl_name" style=" padding-left: 10px;"><b>엣시 등록</b></p>
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
							<b style="padding-left: 10px;">엣시 샘플 파일 다운로드</b>
							&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
							&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
							<input style="width: 150px;" type="button" value="샘플 Excel 다운로드" onclick="fn_excel_sample();" />
						</p>
						<p style="padding-left: 20px;"> 
							<font color="red">※ 결제금액과 상품수량은 반드시 숫자로만 입력해주세요.</font><br>
							<font color="red">※ 상품명은 반드시 영문, 숫자만 입력해주세요.</font><br>
							<font color="red">※ 물품 배송방식은 [PREMIUM]만 사용가능 합니다.</font><br>
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
		<div id="gridEtsyUpload"></div>
	</div>
</div>
<script type="text/javascript">
var chk=0;
var _GRID_COLUMNS = [
	"saleDate", "itemName", "buyer", "quantity", "price", "couponCode", "couponDetails",
	"discountAmount", "shippingDiscount", "orderShipping", "orderSalesTax", "itemTotal", "currency",
	"transactionId", "listingId", "datePaid", "dateShipped", "shipName", "shipAddress1", "shipAddress2",
	"shipCity", "shipState", "shipZipcode", "shipCountry", "orderId", "variations", "orderType",
	"listingsType", "paymentType", "inpersonDiscount", "inpersonLocation", "vatPaidByBuyer", "sku"
]

$(function() {
	
	$("#compcd").val(cfn_loginInfo().COMPCD);
	$("#fileYmd").val(cfn_getDateFormat(new Date(), 'yyyyMMdd'));
	
	if (!cfn_isEmpty(cfn_loginInfo().ORGCD)) {
		$("#orgcd").addClass('disabled').prop({'readonly':'readonly', 'disabled':true});
		$("#orgnm").addClass('disabled').prop({'readonly':'readonly', 'disabled':true});
		$("#btnorgcd").addClass('disabled').prop({'disabled':true});
		$("#orgcd").val(cfn_loginInfo().ORGCD);
		$("#orgnm").val(cfn_loginInfo().ORGNM);
	}
	
	if (cfn_loginInfo().USERGROUP == '${SELLER_ADMIN}') {
		$("#whcd").val(cfn_loginInfo().WHCD);
		$("#whnm").val(cfn_loginInfo().WHNM);
		$("#whcd").prop("disabled",true);
		$("#whnm").prop("disabled",true);
		$("#btnwhcd").prop("disabled",true);
	}
	
	fn_sitecd();//주문서양식불러오기
	
	$("#etsyUpload").lingoPopup({
		title: "엣시 오더등록",
		width: 1350,
		height: 900,
		buttons: {
			"오더 저장": {
				text: "오더 저장",
				class: "popbtnExcel",
				click: function() {
					var shipMethod = $("#shipMethod").val()||"";
					//검색조건 필수입력 체크
					if (cfn_isFormRequireData("frmSearchEtsyUpload") == false) return;
					if (shipMethod == "") {
						cfn_msg("WARNING", "배송타입을 지정하십시오.");
						$("#shipMethod").focus();
						return;
					};
					
					var gridDataList = $("#gridEtsyUpload").gfn_getDataList(true, false);
					
					if (gridDataList.length < 1) {
						cfn_msg("WARNING", "등록된 내역이 없습니다.");
						return false;
					}
					
					var param = cfn_getFormData('frmSearchEtsyUpload');
					param.shipMethod = shipMethod;
					var url = "/fulfillment/order/etsy/upload.do";
					var sendData = {"paramData": param, "paramList": gridDataList};
					
					gfn_ajax(url, true, sendData, function(data, xhr) {
						if (data.CODE == "1") {
							cfn_msg("info", data.MESSAGE);
							etsyUploadclose();
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
		open: function(data) {
			cfn_bindFormData("frmSearchEtsyUpload", data);	
			
			etsyUploadList();
			
			//엑셀업로드
			$(".popbtnExcel").before("<form id='frmupload' action='#' method='post' enctype='multipart/form-data'>"
					+ "<input type='file' accept='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel'"
					+ "name='excelfile' id='xlf' class='popbtnleft' style='margin:10px 0 0 5px;' /></form>");
			
			$("#xlf").bind("click", function(e){
				//검색조건 필수입력 체크
				if (cfn_isFormRequireData("frmSearchEtsyUpload") == false) return false;
				
				this.value = null; 
			});

			$("#xlf").bind("change", function(e){
				gfn_handleXlsFile(e,"gridEtsyUpload", _GRID_COLUMNS);
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

function etsyUploadclose(){
	$("#etsyUpload").lingoPopup("setData", "");
	$("#etsyUpload").lingoPopup("close", "OK");
}

function authorityLoad(){
	if (cfn_loginInfo().USERGROUP == "${XROUTE_ADMIN}") {
	} else {	
		$("#whcd").val(cfn_loginInfo().WHCD);
		$("#whcd").prop("disabled", true);
	}
};

function etsyUploadList() {
	var gid = "gridEtsyUpload";
	var textAlignment = {textAlignment: "center"};
	var columns = [
		{name:"saleDate", header:{text:"saleDate"}, style:textAlignment, editable:false, width:120}
		, {name:"itemName", header:{text:"itemName"}, style:textAlignment, editable:false, width:120}
		, {name:"buyer", header:{text:"buyer"}, style:textAlignment, editable:false, width:120}
		, {name:"quantity", header:{text:"quantity"}, style:textAlignment, editable:false, width:120}
		, {name:"price", header:{text:"price"}, style:textAlignment, editable:false, width:120}
		, {name:"couponCode", header:{text:"couponCode"}, style:textAlignment, editable:false, width:120}
		, {name:"couponDetails", header:{text:"couponDetails"}, style:textAlignment, editable:false, width:120}
		, {name:"discountAmount", header:{text:"discountAmount"}, style:textAlignment, editable:false, width:120}
		, {name:"shippingDiscount", header:{text:"shippingDiscount"}, style:textAlignment, editable:false, width:120}
		, {name:"orderShipping", header:{text:"orderShipping"}, style:textAlignment, editable:false, width:120}
		, {name:"orderSalesTax", header:{text:"orderSalesTax"}, style:textAlignment, editable:false, width:120}
		, {name:"itemTotal", header:{text:"itemTotal"}, style:textAlignment, editable:false, width:120}
		, {name:"currency", header:{text:"currency"}, style:textAlignment, editable:false, width:120}
		, {name:"transactionId", header:{text:"transactionId"}, style:textAlignment, editable:false, width:120}
		, {name:"listingId", header:{text:"listingId"}, style:textAlignment, editable:false, width:120}
		, {name:"datePaid", header:{text:"datePaid"}, style:textAlignment, editable:false, width:120}
		, {name:"dateShipped", header:{text:"dateShipped"}, style:textAlignment, editable:false, width:120}
		, {name:"shipName", header:{text:"shipName"}, style:textAlignment, editable:false, width:120}
		, {name:"shipAddress1", header:{text:"shipAddress1"}, style:textAlignment, editable:false, width:120}
		, {name:"shipAddress2", header:{text:"shipAddress2"}, style:textAlignment, editable:false, width:120}
		, {name:"shipCity", header:{text:"shipCity"}, style:textAlignment, editable:false, width:120}
		, {name:"shipState", header:{text:"shipState"}, style:textAlignment, editable:false, width:120}
		, {name:"shipZipcode", header:{text:"shipZipcode"}, style:textAlignment, editable:false, width:120}
		, {name:"shipCountry", header:{text:"shipCountry"}, style:textAlignment, editable:false, width:120}
		, {name:"orderId", header:{text:"orderId"}, style:textAlignment, editable:false, width:120}
		, {name:"variations", header:{text:"variations"}, style:textAlignment, editable:false, width:120}
		, {name:"orderType", header:{text:"orderType"}, style:textAlignment, editable:false, width:120}
		, {name:"listingsType", header:{text:"listingsType"}, style:textAlignment, editable:false, width:120}
		, {name:"paymentType", header:{text:"paymentType"}, style:textAlignment, editable:false, width:120}
		, {name:"inpersonDiscount", header:{text:"inpersonDiscount"}, style:textAlignment, editable:false, width:120}
		, {name:"inpersonLocation", header:{text:"inpersonLocation"}, style:textAlignment, editable:false, width:120}
		, {name:"vatPaidByBuyer", header:{text:"vatPaidByBuyer"}, style:textAlignment, editable:false, width:120}
		, {name:"sku", header:{text:"sku"}, style:textAlignment, editable:false, width:120}
	];

	//그리드 생성 (realgrid 써서)
	$("#"+ gid).gfn_createGrid(columns, {
		footerflg: false
		, cmenuGroupflg: false
		, cmenuColChangeflg: false
		, cmenuColSaveflg: false
		, cmenuColInitflg: false
		, height: "95%"
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
	var url = "/fulfillment/order/etsy/getSiteCd.do";
	var sendData = {"paramData":{"COMPCD":cfn_loginInfo().COMPCD, "ORGCD":"C0001", "SITE_NM":"신규오더"}};
	
	gfn_ajax(url, false, sendData, function (data, xhr) {
		var list = data.resultList;
		var htmlString = "";
		for (var i = 0; i<list.length; i++) {
			htmlString += "<option value='"+list[i].CODE+"'>"+ list[i].VALUE +"</option>";
		}
		
		$("#siteCd").html(htmlString);
	});
} 

//샘플excel 업로드파일 다운로드
function fn_excel_sample(){
	var $g = "gridEtsyUpload";
	
	RealGridJS.exportGrid({
		type: "excel"
		, target: "local"
		, fileName: "etsy_upload_sample.xlsx"
		, showProgress: "Y"
		, applyDynamicStyles: true
		, progressMessage: "엑셀 Export중입니다."
		, header: "default"
		, footer: "default"
		, compatibility: "2010"
		, lookupDisplay:true
		, exportGrids: [
			{grid:$("#" +$g).gridView(), sheetName: "업로드샘플양식", indicator: "hidden"} // 행번호 visable 여부*
		]
		, done: function() {
		}
	});
}
</script>