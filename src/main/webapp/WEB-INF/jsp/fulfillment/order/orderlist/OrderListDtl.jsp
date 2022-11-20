<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst" %>
<div id="OrderListDtl" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frmOrderListDtl" action="#" onsubmit="return false">
			<input type="hidden" id="oldPgmid" class="cmc_txt" value='ORDERLIST'/>
			<table class="tblForm" style="min-width:300px">
				<colgroup>
					<col width="130px" />
					<col />
				</colgroup>
				<tr>
					<th>엑스루트 송장번호</th>
					<td><input type="text" id="oldXrtInvcSno" class="cmc_txt disabled"  style="width:80%;" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>상태</th>
					<td>
                        <select id="oldStatusCd" style="width: 100px">
                            <option selected="selected" value="">--전체--</option>
                            <option value="10">주문등록</option>
                            <option value="11">발송대기</option>
                            <option value="12">발송완료</option>
                            <option value="20">입금대기</option>
                            <option value="21">결제완료</option>
                            <option value="22">결제대기</option>
                            <option value="23">결제실패</option>
                            <option value="30">입고완료</option>
                            <option value="31">창고보관</option>
                            <option value="32">출고대기</option>
                            <option value="33">검수완료</option>
                            <option value="34">검수취소</option>
                            <option value="35">선적대기</option>
                            <option value="40">출고완료</option>
                            <option value="50">공항출발(예정)</option>
                            <option value="51">공힝출발(완료)</option>
                            <option value="52">해외공항도착(예정)</option>
                            <option value="53">해외공항도착(완료)</option>
                            <option value="54">통관대기</option>
                            <option value="55">통관완료</option>
                            <option value="56">배송시작</option>
                            <option value="57">배송중</option>
                            <option value="60">배송완료</option>
                            <option value="80">API오류</option>
                            <option value="98">입금취소</option>
                            <option value="99">주문취소</option>
                        </select>
                    </td>
				</tr>
				<tr>
                    <th>결제타입</th>
                    <td>
                        <select id="oldPaymentType" style="width: 100px">
                            <option selected="selected" value="3">정기결제</option>
                            <option value="4">신용결제</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>쇼핑몰</th>
                    <td><input type="text" id="oldMallNm" class="cmc_txt" style="width:80%;"/></td>
                </tr>
                <tr>
                    <th>서비스타입</th>
                    <td>
                        <select id="oldShipMethodCd" style="width: 100px">
                            <option selected="selected" value="">--선택--</option>
                            <option value="PREMIUM">PREMIUM</option>
                            <option value="DHL">DHL</option>
                            <option value="UPS">UPS</option>
                        </select>
                    </td>
                </tr>
				<tr>
					<th>도착국가</th>
					<td><input type="text" id="oldENation" class="cmc_txt disabled" style="width:80%;" readonly="readonly" /></td>
				</tr>
				<tr>
                    <th>송화인 이름</th>
                    <td><input type="text" id="oldShipName" class="cmc_txt" style="width:80%;" /></td>
                </tr>
                <tr>
                    <th>송화인 전화번호</th>
                    <td><input type="text" id="oldShipTel" class="cmc_txt" style="width:80%;" /></td>
                </tr>
				<tr>
					<th>수화인 이름</th>
					<td><input type="text" id="oldRecvName" class="cmc_txt" style="width:80%;" /></td>
				</tr>
				<tr>
					<th>수화인 전화번호</th>
					<td><input type="text" id="oldRecvTel" class="cmc_txt" style="width:80%;" /></td>
				</tr>
				<tr>
					<th>수화인 도시</th>
					<td><input type="text" id="oldRecvCity" class="cmc_txt" style="width:80%;" /></td>
				</tr>
				<tr>
					<th>수화인 주</th>
					<td><input type="text" id="oldRecvState" class="cmc_txt" style="width:80%;" /></td>
				</tr>
				<tr>
					<th>수화인 우편번호</th>
					<td><input type="text" id="oldRecvPost" class="cmc_txt" style="width:80%;" /></td>
				</tr>
				<tr>
					<th>수화인 주소</th>
					<td><input type="text" id="oldRecvAddr1" class="cmc_txt" style="width:80%;" /></td>
				</tr>
				<tr>
					<th>수화인 상세 주소</th>
					<td><input type="text" id="oldRecvAddr2" class="cmc_txt" style="width:80%;" /></td>
				</tr>
				<tr>
                    <th>구매자 결제금액</th>
                    <td><input type="text" id="oldTotPaymentPrice" class="cmc_txt" style="width:80%;" /></td>
                </tr>
				<tr>
                    <th>구매 URL</th>
                    <td><input type="text" id="oldPurchaseUrl" class="cmc_txt" style="width:80%;" /></td>
                </tr>
				<tr>
					<th>상품</th>
					<td>
						<table class="tblForm" style="min-width:300px">
							<tbody id="oldItemList"></tbody>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
</div>
<script type="text/javascript">
var _statusCd = "";
$(function() {
	$("#OrderListDtl").lingoPopup({
		title: "오더 수정",
		width: 800,
		height: 640,
		buttons: {
			"확인": {
				text: "저장",
				click: function() {
					orderSave();
				}
			}
			, "닫기": {
				text: "취소",
				click: function() {
					$("#OrderListDtl").find("input").val("");
					$("#oldItemList").empty();
					$(this).lingoPopup("setData", "");
					$(this).lingoPopup("close");
				}
			}
		} ,
		open: function(data) {
			getOrderDtl(data);
			getOrderItems(data);
		} 
	});
});
/* 오더 정보 조회 */
function getOrderDtl(data) {
	var url = "/fulfillment/order/orderListDtl/getOrderDtl.do";
	var jsonObj = {};
	jsonObj.xrtInvcSno = data.xrtInvcSno;
	gfn_ajax(url, true, jsonObj, function(result, xhr) {
		var resultData = result.resultList[0];
		$("#oldXrtInvcSno").val(resultData.xrtInvcSno);
		$("#oldPaymentType").val(resultData.paymentType);
		$("#oldMallNm").val(resultData.mallNm);
		$("#oldShipMethodCd").val(resultData.shipMethodCd);
		$("#oldENation").val(resultData.eNation);
		$("#oldShipName").val(resultData.shipName);
		$("#oldShipTel").val(resultData.shipTel);
		$("#oldRecvName").val(resultData.recvName);
		$("#oldRecvTel").val(resultData.recvTel);
		$("#oldRecvAddr1").val(resultData.recvAddr1);
		$("#oldRecvAddr2").val(resultData.recvAddr2);
		$("#oldRecvCity").val(resultData.recvCity);
		$("#oldRecvPost").val(resultData.recvPost);
		$("#oldRecvState").val(resultData.recvState);
		$("#oldTotPaymentPrice").val(resultData.totPaymentPrice);
		$("#oldPurchaseUrl").val(resultData.purchaseUrl);
		$("#oldStatusCd").val(resultData.statusCd);
		$("#oldPaymentType").data("paymentType", resultData.paymentType);
		$("#oldMallNm").data("mallNm", resultData.mallNm);
		$("#oldShipMethodCd").data("shipMethodCd", resultData.shipMethodCd);
		$("#oldShipName").data("shipName", resultData.shipName);
		$("#oldShipTel").data("shipTel", resultData.shipTel);
		$("#oldRecvName").data("recvName", resultData.recvName);
		$("#oldRecvTel").data("recvTel", resultData.recvTel);
		$("#oldRecvAddr1").data("recvAddr1", resultData.recvAddr1);
		$("#oldRecvAddr2").data("recvAddr2", resultData.recvAddr2);
		$("#oldRecvCity").data("recvCity", resultData.recvCity);
		$("#oldRecvPost").data("recvPost", resultData.recvPost);
		$("#oldRecvState").data("recvState", resultData.recvState);
		$("#oldStatusCd").data("statusCd", resultData.statusCd);
		$("#oldTotPaymentPrice").data("totPaymentPrice", resultData.totPaymentPrice);
		$("#oldPurchaseUrl").data("purchaseUrl", resultData.purchaseUrl);
	});
}
/* 상품데이터 조회 */
function getOrderItems(data) {
	var url = "/fulfillment/order/orderListDtl/getOrderItems.do";
	var jsonObj = {};
	jsonObj.xrtInvcSno = data.xrtInvcSno;
	gfn_ajax(url, true, jsonObj, function(result, xhr) {
		
		var resultData = result.resultList;
		var htmlString = "";
		var styleWidth = "width:80%;";
		var styleMargin = "margin-left: 14px;";
		for (var i=0; i<resultData.length; i++) {
			var ordSeq = (resultData[i].ordSeq||"");
			var goodsCd = (resultData[i].goodsCd||"");
			var goodsNm = (resultData[i].goodsNm||"");
			var goodsOption = (resultData[i].goodsOption||"");
			htmlString += "<tr>";
			htmlString += "<td>";
			htmlString += "<ul>";
			htmlString += "<li style='display:block;'>상품 "+ ordSeq +"</li>";
			htmlString += "<li style='display:block;'>상품코드 : <input type='text' id='goodsCd"+ i +"' class='cmc_txt' value='"+ goodsCd +"' style='"+ styleWidth + "' /></li>";
			htmlString += "<li style='display:block;'>상품명 : <input type='text' id='goodsNm"+ i +"' class='cmc_txt' value='"+ goodsNm +"' style='"+ styleWidth + styleMargin +"' /></li>";
			htmlString += "<li style='display:block;'>상품옵션 : <input type='text' id='goodsOption"+ i +"' class='cmc_txt' value='"+ goodsOption +"' style='"+ styleWidth + "' /></li>";
			htmlString += "<li style='display:block;'>상품수량 : <span id='goodsCnt"+ i +"'>"+ resultData[i].goodsCnt +"</span></li>";
			htmlString += "</ul>";
			htmlString += "</td>";
			htmlString += "</tr>";	
		}
		$("#oldItemList").empty().append(htmlString);
		
		for (var i=0; i<resultData.length; i++) {
			var goodsCd = (resultData[i].goodsCd||"");
			var goodsNm = (resultData[i].goodsNm||"");
			var goodsOption = (resultData[i].goodsOption||"");
			var ordSeq = (resultData[i].ordSeq||"");
			var ordCd = (resultData[i].ordCd||"");
			$("#goodsCd"+ i +"").data("goodsCd", goodsCd);
			$("#goodsCd"+ i +"").data("ordCd", ordCd);
			$("#goodsCd"+ i +"").data("ordSeq", ordSeq);
			$("#goodsNm"+ i +"").data("goodsNm", goodsNm);
			$("#goodsOption"+ i +"").data("goodsOption", goodsOption);
		}
	});
}

function orderSave() {
	
	if (confirm("저장 하시겠습니까?") == false) {
		return;
	}
	
	if (dataValid() == false) {
		return;
	}
	
	var url = "/fulfillment/order/orderListDtl/update.do";
	var jsonList = [];
	var itemList = $("#oldItemList").find("tr");
	for (i=0; i<itemList.length; i++) {
		var itemObj = {};
		itemObj.prevGoodsCd = $("#goodsCd"+ i +"").data("goodsCd")||"";
		itemObj.prevGoodsNm = $("#goodsNm"+ i +"").data("goodsNm")||"";
		itemObj.prevGoodsOption = $("#goodsOption"+ i +"").data("goodsOption")||"";
		itemObj.ordCd = $("#goodsCd"+ i +"").data("ordCd")||"";
		itemObj.ordSeq = $("#goodsCd"+ i +"").data("ordSeq")||"";
		itemObj.goodsCd = $("#goodsCd"+ i +"").val()||"";
		itemObj.goodsNm = $("#goodsNm"+ i +"").val()||"";
		itemObj.goodsOption = $("#goodsOption"+ i +"").val()||"";
		jsonList.push(itemObj);
	}
	
	var jsonObj = {};
	jsonObj.xrtInvcSno = $("#oldXrtInvcSno").val()||"";
	jsonObj.prevPaymentType = $("#oldPaymentType").data("paymentType")||"";
	jsonObj.prevMallNm = $("#oldMallNm").data("mallNm")||"";
	jsonObj.prevShipMethodCd = $("#oldShipMethodCd").data("shipMethodCd")||"";
	jsonObj.prevShipName = $("#oldShipName").data("shipName")||"";
	jsonObj.prevShipTel = $("#oldShipTel").data("shipTel")||"";
	jsonObj.prevRecvName = $("#oldRecvName").data("recvName")||"";
	jsonObj.prevRecvTel = $("#oldRecvTel").data("recvTel")||"";
	jsonObj.prevRecvCity = $("#oldRecvCity").data("recvCity")||"";
	jsonObj.prevRecvState = $("#oldRecvState").data("recvState")||"";
	jsonObj.prevRecvPost = $("#oldRecvPost").data("recvPost")||"";
	jsonObj.prevRecvAddr1 = $("#oldRecvAddr1").data("recvAddr1")||"";
	jsonObj.prevRecvAddr2 = $("#oldRecvAddr2").data("recvAddr2")||"";
	jsonObj.prevStatusCd = $("#oldStatusCd").data("statusCd")||"";
	jsonObj.prevTotPaymentPrice = $("#oldTotPaymentPrice").data("totPaymentPrice")||"";
	jsonObj.prevPurchaseUrl = $("#oldPurchaseUrl").data("purchaseUrl")||"";
	jsonObj.paymentType = $("#oldPaymentType").val()||"";
	jsonObj.mallNm = $("#oldMallNm").val()||"";
	jsonObj.shipMethodCd = $("#oldShipMethodCd").val()||"";
	jsonObj.shipName = $("#oldShipName").val()||"";
	jsonObj.shipTel = $("#oldShipTel").val()||"";
	jsonObj.recvName = $("#oldRecvName").val()||"";
	jsonObj.recvTel = $("#oldRecvTel").val()||"";
	jsonObj.recvCity = $("#oldRecvCity").val()||"";
	jsonObj.recvState = $("#oldRecvState").val()||"";;
	jsonObj.recvPost = $("#oldRecvPost").val()||"";
	jsonObj.recvAddr1 = $("#oldRecvAddr1").val()||"";
	jsonObj.recvAddr2 = $("#oldRecvAddr2").val()||"";
	jsonObj.totPaymentPrice = $("#oldTotPaymentPrice").val()||"";
	jsonObj.purchaseUrl = $("#oldPurchaseUrl").val()||"";
	jsonObj.statusCd = $("#oldStatusCd").val()||"";
	jsonObj.items = jsonList;
	
	gfn_ajax(url, true, jsonObj, function(result, xhr) {
		if (result.CODE == "1") {
			cfn_msg("info", "정상적으로 처리되었습니다.");
			listReset();
			$("#OrderListDtl").find("input").val("");
			$("#oldItemList").empty();
			$("#OrderListDtl").lingoPopup("setData", "");
			$("#OrderListDtl").lingoPopup("close");
		};
	});
}

function dataValid() {
    
    if ($("#oldShipMethodCd").val() == "") {
        cfn_msg('WARNING', "서비스 타입을 입력하세요.");
        $("#oldShipMethodCd").focus();
        return false;
    }
	
	if ($("#oldRecvPost").val() == "") {
		cfn_msg('WARNING', "우편번호를 입력 하십시오.");
		$("#oldRecvPost").focus();
		return false;
	}

	if ($("#oldRecvAddr1").val() == "") {
		cfn_msg('WARNING', "주소를 입력하십시오.");
		$("#oldRecvAddr1").focus();
		return false;
	}
	/* var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"]/gi; */
	var itemList = $("#oldItemList").find("tr");
	for (i=0; i<itemList.length; i++) {
		if ($("#goodsNm"+ i +"").val() == "") {
			cfn_msg('WARNING', "상품명을 입력하십시오.");
			$("#goodsNm"+ i +"").focus();
			return false;
		/* } else if (regExp.test($("#goodsNm"+ i +"").val())) {
			cfn_msg('WARNING', "특수문자는 입력 할 수 업습니다.");
			$("#goodsNm"+ i +"").focus();
			return false; */
		}
	}
	
	return true;
}

function listReset() {
	var docId = $("#main_contents").find("#tabs").find("[aria-hidden=false]").find("iframe").prop("id");
	document.getElementById(docId).contentWindow.cfn_retrieve();
}
</script>