<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : OrderAmazon
	화면명   : 아마존 업로드 등록
-->
<div id="OrderAmazon" class="pop_wrap">
    <!-- 검색조건영역 시작 -->
    <div id="ct_sech_wrap">
        <p id="lbl_name" style="padding-left: 10px;">
            <b>아마존 등록</b>
        </p>
        <form id="frmSearchOrderAmazon" action="#" onsubmit="return false">
            <input type="hidden" id="amazonCompcd" class="cmc_txt" value=<c:out value='${sessionScope.loginVO.compcd}' /> />
            <input type="hidden" id="amazonPgmid" class="cmc_txt" value='ORDERLIST' />
            <input type="hidden" id="amazonFileYmd" />
            <ul class="sech_ul">
                <li class="sech_li required">
                    <div>셀러</div>
                    <div>
                        <input type="text" id="amazonOrgcd" name="amazonOrgcd" class="cmc_code required" />
                        <input type="text" id="amazonOrgnm" name="amazonOrgnm" class="cmc_value" />
                        <button type="button" id="btnAmazonOrgcd" class="cmc_cdsearch"></button>
                    </div>
                </li>
                <li class="sech_li required">
                    <div>창고코드/명</div>
                    <div>
                        <input type="text" id="amazonWhcd" class="cmc_code required" />
                        <input type="text" id="amazonWhnm" class="cmc_value" />
                        <button type="button" id="btnAmazonWhcd" class="cmc_cdsearch"></button>
                    </div>
                </li>
                <li class="sech_li required">
                    <div>오더양식</div>
                    <div>
                        <select id=amazonSiteCd class="cmc_combo required">
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
                            <b style="padding-left: 10px;">아마존 샘플 파일 다운로드</b>
                        </p>
                        <p style="padding-left: 20px;">
                            아마존 샘플 파일을 다운로드하시고 아마존 txt 파일의 내용을 복사 후 붙여넣기 후 업로드하시면 더욱 빠르게 오더를 생성할 수 있습니다.<br /> order-item-id 데이터 앞에 '를 입력해주시길 바랍니다. 예) '11112222333 &emsp;&emsp;&emsp;&emsp;&emsp;
                            <input style="width: 150px;" type="button" value="샘플 Excel 다운로드" onclick="fn_excel_sample();" />
                            <br> <font color="red">※ 결제금액과 상품수량은 반드시 숫자로만 입력해주세요.</font><br> <font color="red">※ 상품명은 반드시 영문, 숫자만 입력해주세요.</font><br> <font color="red">※ 물품 배송방식은
                                [PREMIUM] 사용가능 합니다.</font><br> <font color="red">※ 현재 국가는 미국, 일본만 가능 합니다.</font><br>
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
            <div class="grid_top_left">
                업로드 리스트
                <span>(총 0건)</span>
            </div>
            <div class="grid_top_right">
                배송 타입 :
                <select class="cmc_code required" id="amazonShipMethod">
                    <option value="">선택</option>
                    <option value="PREMIUM">PREMIUM</option>
                </select>
            </div>
        </div>
        <div id="gridOrderAmazon"></div>
    </div>
</div>
<script type="text/javascript">
var chk=0;
var amazonGridColumns = [
	'itemPrice', 'orderId', 'orderItemId', 'purchaseDate', 'paymentsDate', 'reportingDate',
	'promiseDate', 'daysPastPromise', 'buyerEmail', 'buyerName', 'buyerPhoneNumber', 
	'sku', 'productName', 'quantityPurchased', 'quantityShipped', 'quantityToShip', 
	'shipServiceLevel', 'recipientName', 'shipAddress1', 'shipAddress2', 'shipAddress3', 
	'shipCity', 'shipState', 'shipPostalCode', 'shipCountry'
];

$(function() {
	
	$("#amazonCompcd").val("<c:out value='${sessionScope.loginVO.compcd}' />");
	$("#amazonFileYmd").val(cfn_getDateFormat(new Date(), 'yyyyMMdd'));
	
	if (!cfn_isEmpty(cfn_loginInfo().ORGCD)) {
		$("#amazonOrgcd").addClass('disabled').prop({'readonly':'readonly', 'disabled':true});
		$("#amazonOrgnm").addClass('disabled').prop({'readonly':'readonly', 'disabled':true});
		$("#btnAmazonOrgcd").addClass('disabled').prop({'disabled':true});
		$("#amazonOrgcd").val(cfn_loginInfo().ORGCD);
		$("#amazonOrgnm").val(cfn_loginInfo().ORGNM);
	}
	
	if (cfn_loginInfo().USERGROUP == '${SELLER_ADMIN}') {
		$("#amazonWhcd").val(cfn_loginInfo().WHCD);
		$("#amazonWhnm").val(cfn_loginInfo().WHNM);
		$("#amazonWhcd").prop("disabled",true);
		$("#amazonWhnm").prop("disabled",true);
		$("#btnAmazonWhcd").prop("disabled",true);
	}
	
	fn_sitecd();//주문서양식불러오기
	
	$('#OrderAmazon').lingoPopup({
		title: '아마존오더등록',
		width: 1350,
		height: 900,
		buttons: {
			'오더 저장': {
				text: '오더 저장',
				class: 'popbtnExcel',
				click: function() {
					var shipMethod = $("#amazonShipMethod").val()||"";
					//검색조건 필수입력 체크
					if (cfn_isFormRequireData("frmSearchOrderAmazon") == false) return;
					if (shipMethod == "") {
						cfn_msg('WARNING', "배송타입을 지정하십시오.");
						$("#amazonShipMethod").focus();
						return;
					};
					
					var gridDataList = $('#gridOrderAmazon').gfn_getDataList(true, false);
					
					if (gridDataList.length < 1) {
						cfn_msg('WARNING', '등록된 내역이 없습니다.');
						return false;
					}
					
					var param = cfn_getFormData('frmSearchOrderAmazon');
					param.shipMethod = shipMethod;
					var url = '/fulfillment/order/OrderAmazon/upload.do';
					var sendData = {'paramData':param,'paramList':gridDataList};
					
					gfn_ajax(url, true, sendData, function(data, xhr) {
						if (data.CODE == "1") {
							cfn_msg("info", data.MESSAGE);
							fn_orderAmazonclose();
						}
					});
				}
			}
			, '닫기': {
				text: '취소',
				click: function() {
					$(this).lingoPopup('setData', '');
					$(this).lingoPopup('close');
				}
			}
		} ,
		open: function(data) {
			cfn_bindFormData("frmSearchOrderAmazon", data);	
			
			fn_griOrderAmazonList();
			
			//엑셀업로드
			$('.popbtnExcel').before('<form id="frmupload" action="#" method="post" enctype="multipart/form-data">' +
					'<input type="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" ' +
					'name="excelfile" id="xlf" class="popbtnleft" style="margin:10px 0 0 5px;" />' +
					'</form>');
			
			$("#xlf").bind("click", function(e){
				//검색조건 필수입력 체크
				if (cfn_isFormRequireData("frmSearchOrderAmazon") == false) return false;
				
				this.value = null; 
			});

			$("#xlf").bind("change", function(e){
				gfn_handleXlsFile(e,"gridOrderAmazon", amazonGridColumns);
			}); 
		} 
	});
	
	/* 화주 */
	pfn_codeval({
		url: "/alexcloud/popup/popP002/view.do"
		, codeid: "amazonOrgcd"
		, inparam: {S_COMPCD:"amazonCompcd", S_COMPCD:"amazonOrgcd,amazonOrgnm"}
		, outparam: {ORGCD:"amazonOrgcd", NAME:"amazonOrgnm"},
		returnFn: function(data, type) {}
	});
	
	/* 창고 */
	pfn_codeval({
		url: "/alexcloud/popup/popP004/view.do"
		, codeid: "amazonWhcd"
		, inparam: {S_COMPCD:"amazonCompcd", S_COMPCD: "amazonWhcd,amazonWhnm"}
		, outparam: {WHCD:"amazonWhcd", NAME:"amazonWhnm"}
	});
});

function fn_orderAmazonclose(){
	$('#OrderAmazon').lingoPopup('setData', "");
	$('#OrderAmazon').lingoPopup('close', 'OK');
}

function authority_Load(){
	if (cfn_loginInfo().USERGROUP == '${XROUTE_ADMIN}') {
	} else {	
		$("#amazonWhcd").val(cfn_loginInfo().WHCD);
		$("#amazonWhcd").prop("disabled",true);
	}
};

function fn_griOrderAmazonList() {
	var gid = "gridOrderAmazon";
	var textAlignment = {textAlignment:'center'};
	var columns = [
		{name : 'itemPrice', header : {text : 'itemPrice'}, style : textAlignment, editable : false, width : 120}
		, {name : 'orderId', header : {text : 'orderId'}, style : textAlignment, editable : false, width : 120}
		, {name : 'orderItemId', header : {text : 'orderItemId'}, style : textAlignment, editable : false, width : 120}
		, {name : 'purchaseDate', header : {text : 'purchaseDate'}, style : textAlignment, editable : false, width : 120}
		, {name : 'paymentsDate', header : {text : 'paymentsDate'}, style : textAlignment, editable : false, width : 120}
		, {name : 'reportingDate',header : {text : 'reportingDate'}, style : textAlignment, editable : false, width : 120}
		, {name : 'promiseDate', header : {text : 'promiseDate'}, style : textAlignment, editable : false, width : 120}
		, {name : 'daysPastPromise', header : {text : 'daysPastPromise'}, style : textAlignment, editable : false, width : 120}
		, {name : 'buyerEmail', header : {text : 'buyerEmail'}, style : textAlignment, editable : false, width : 120}
		, {name : 'buyerName', header : {text : 'buyerName'}, style : textAlignment, editable : false, width : 120}
		, {name : 'buyerPhoneNumber', header : {text : 'buyerPhoneNumber'}, style : textAlignment, editable : false, width : 150}
		, {name : 'sku', header : {text : 'sku'}, style : textAlignment, editable : false, width : 120}
		, {name : 'productName', header : {text : 'productName'}, style : textAlignment, editable : false, width : 120}
		, {name : 'quantityPurchased', header : {text : 'quantityPurchased'}, style : textAlignment, editable : false, width : 120}
		, {name : 'quantityShipped', header : {text : 'quantityShipped'}, style : textAlignment, editable : false, width : 120}
		, {name : 'quantityToShip', header : {text : 'quantityToShip'}, style : textAlignment, editable : false, width : 120}
		, {name : 'shipServiceLevel', header : {text : 'shipServiceLevel'}, style : textAlignment, editable : false, width : 120}
		, {name : 'recipientName', header : {text : 'recipientName'}, style : textAlignment, editable : false, width : 120}
		, {name : 'shipAddress1', header : {text : 'shipAddress1'}, style : textAlignment, editable : false, width : 120}
		, {name : 'shipAddress2', header : {text : 'shipAddress2'}, style : textAlignment, editable : false, width : 120}
		, {name : 'shipAddress3', header : {text : 'shipAddress3'}, style : textAlignment, editable : false, width : 120}
		, {name : 'shipCity', header : {text : 'shipCity'}, style : textAlignment, editable : false, width : 120}
		, {name : 'shipState', header : {text : 'shipState'}, style : textAlignment, editable : false, width : 120}
		, {name : 'shipPostalCode', header : {text : 'shipPostalCode'}, style : textAlignment, editable : false, width : 120}
		, {name : 'shipCountry', header : {text : 'shipCountry'}, style : textAlignment, editable : false, width : 120}
	];

	//그리드 생성 (realgrid 써서)
	$('#' + gid).gfn_createGrid(columns, {
		footerflg : false,
		cmenuGroupflg:false,
		cmenuColChangeflg:false,
		cmenuColSaveflg:false,
		cmenuColInitflg:false,
		height:'95%'
	});

	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		gridView.setFixedOptions({
			colCount : 2,
			resizable : true,
			colBarWidth : 1
		});
	});
}

//주문서양식명 가져오기(SELECTBOX)
function fn_sitecd() {
	var orgcd = $("#amazonOrgcd").val();
	var url = "/fulfillment/order/OrderAmazon/getSiteCd.do";
	var sendData = {'paramData':{'COMPCD':"<c:out value='${sessionScope.loginVO.compcd}' />", 'ORGCD':'C0001', 'SITE_NM':'신규오더'}};
	
	gfn_ajax(url, false, sendData, function (data, xhr) {
		var list = data.resultList;
		var htmlString = '';
		for (var i = 0; i<list.length; i++) {
			htmlString += "<option value='"+list[i].CODE+"'>"+ list[i].VALUE +"</option>"
		}
		
		$("#amazonSiteCd").html(htmlString);
	});
} 

//샘플excel 업로드파일 다운로드
function fn_excel_sample(){
	var $g = "gridOrderAmazon";
	
	RealGridJS.exportGrid({
		type: 'excel'
		, target: 'local'
		, fileName: 'amazon_upload_sample' + '.xlsx'
		, showProgress: 'Y'
		, applyDynamicStyles: true
		, progressMessage: '엑셀 Export중입니다.'
		, header: 'default'
		, footer: 'default'
		, compatibility: '2010'
		, lookupDisplay:true
		, exportGrids: [
			{grid:$('#'+$g).gridView(), sheetName:"업로드샘플양식",indicator: 'hidden'} // 행번호 visable 여부*
		]
		, done: function() {
		}
	});
}
</script>