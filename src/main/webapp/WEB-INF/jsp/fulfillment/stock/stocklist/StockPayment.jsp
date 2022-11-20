<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
화면코드 : StockPayment
화면명 : StockPayment
-->
<div id="StockPayment" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search" action="#" onsubmit="return false">
			<ul class="sech_ul">
				<li class="sech_li">
					<div style="width: 100%;">
						<input type="hidden" id="h_xrtInvcSno">
						<p>
							송장번호 <b id="xrtInvcSno" style="color: red;" />의 금액은 <b id="amount" style="color: red;" />원 입니다.
						</p>
						<p>금액을 확인 후 아래의 금액 입력한에 등록하여 주십시오.</p>
					</div>
					<div style="width: 100%; padding-top: 15px;" id="div_stock_completion">
						입금금액 : <input type="text" id="pmAmount" style="width: 100px; padding-left: 20px; text-align: right;" onkeyup="amountFormat(this);">원&nbsp;&nbsp;&nbsp; 
						<input style="width: 70px;" type="button" class="cmb_normal_new cbtn_save" value="   확인" onclick="updataOrderStatus()" />
						<input style="width: 70px;" type="button" class="cmb_normal_new cbtn_cancel" value="   닫기" onclick="cancel()" />
					</div>
				</li>
			</ul>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->

</div>
<script type="text/javascript">
	$(function() {
		$("#StockPayment").lingoPopup({
			title : "금액확인",
			width : 410,
			height : 160,
			open : function(data) {
				$("#xrtInvcSno").text(data.xrtInvcSno);
				$("#h_xrtInvcSno").val(data.xrtInvcSno);
				paymentAmount();
			}
		});
	});

	function paymentAmount() {
		var url = "/fulfillment/stock/StockPayment/getAmount.do";
		var sendData = {};
		sendData.xrtInvcSno = $("#xrtInvcSno").text();
		gfn_ajax(url, true, sendData, function(data, xhr) {
			// 금액 포맷 후 표시
			var amount = data.AMOUNT
			amount = amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$("#amount").text(amount);
			$("#pmAmount").val(amount);
		});
	}

	function updataOrderStatus() {
		if (confirm("입금확인을 하시겠습니까?") == true) {
			var amount = $("#pmAmount").val();
			amount = amount.replace(/,/gi,"")||"0";
			if (amount > 0) {
				if ($("#amount").text() == $("#pmAmount").val()) {
					var param = cfn_getFormData("frm_search");
					var sid = "sid_amountUpdate";
					var url = "/fulfillment/stock/StockPayment/setAmountUpdate.do";
					var sendData = {
						"paramData" : param
					};
					gfn_sendData(sid, url, sendData, true);
				} else {
					alert("금액이 맞지 않습니다.");
				}
			} else {
				alert("금액은 0원 이상 입력하여야 합니다.");
			}
		}
	}
	
	function cancel(){
		$("#StockPayment").lingoPopup("setData", "");
		$("#StockPayment").lingoPopup("close", "OK");
	}

	function gfn_callback(sid, data) {
		if (sid == "sid_amountUpdate") {
			if (data.updateData.SCNT == "4") {
				alert("정상적으로 처리 되었습니다.");
				$("#StockPayment").lingoPopup("setData", "");
				$("#StockPayment").lingoPopup("close", "OK");
			}
		}
	}

	function amountFormat(obj) {
		//숫자만 입력
		var x = obj.value.replace(/[^0-9]/g, '');
		//금액 포맷
		obj.value = x.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
	}
</script>

<c:import url="/comm/contentBottom.do" />