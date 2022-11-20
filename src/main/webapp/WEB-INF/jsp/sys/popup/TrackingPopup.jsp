<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst"%>
<html>
<head>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<style type="text/css">
@import
	url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css")
	;

.track_tbl td.track_dot {
	width: 50px;
	position: relative;
	padding: 0;
	text-align: center;
}

.track_tbl td.track_dot:after {
	content: "\f111";
	font-family: FontAwesome;
	position: absolute;
	margin-left: -5px;
	top: 11px;
}

.track_tbl td.track_dot span.track_line {
	background: #000;
	width: 3px;
	min-height: 50px;
	position: absolute;
	height: 101%;
}

.track_tbl tbody tr:first-child td.track_dot span.track_line {
	top: 30px;
	min-height: 25px;
}

.track_tbl tbody tr:last-child td.track_dot span.track_line {
	top: 0;
	min-height: 25px;
	height: 10%;
}
</style>
<title>트랙킹 조회 팝업</title>
</head>
<body>
	<div id="container">
		<div class="p-4">
			<h4>
				<b>배송정보 및 추적(SHIPMENT PROGRESS)</b>
			</h4>
			<div class="input-group"
				style="margin-top: 20px; margin-bottom: 20px;">
				<input type="search" id="invcSno" name="invcSno" value="${invcSno}"
					class="form-control rounded" placeholder="운송장 번호를 입력하세요."
					aria-label="Search" aria-describedby="search-addon" />
				<button type="button" class="btn btn-primary"
					onclick="trackingSearch()"
					style="background-color: #ef8200; color: black;">
					<b>AWB(AirWayBill)</b>
				</button>
			</div>

			<table class="table table-bordered">
				<colgroup>
					<col width="20%">
					<col width="40%">
					<col width="20%">
					<col width="20%">
				</colgroup>
				<thead style="background-color: #ef8200; color: black;">
					<tr>
						<th scope="col">주문번호(ORDER NR.)</th>
						<th scope="col">상품명(ITEM)</th>
						<th scope="col">수량(Q'TY/BOX)</th>
						<th scope="col">택배사(COURIER)</th>
					</tr>
				</thead>
				<tbody id="productInfo">
					<tr>
						<td colspan="4" style="text-align: center;">조회가 되지 않았습니다. 운송장
							번호를 다시 확인해주세요.</td>
					</tr>
				</tbody>
			</table>

			<table class="table table-bordered">
				<colgroup>
					<col width="50%">
					<col width="50%">
				</colgroup>
				<thead style="background-color: #ef8200; color: black;">
					<tr>
						<th scope="col">출발지(Place of Origin)</th>
						<th scope="col">목적지(Place of Delivery)</th>
					</tr>
				</thead>
				<tbody id="addressInfo">
					<tr>
						<td colspan="2" style="text-align: center;">조회가 되지 않았습니다. 운송장
							번호를 다시 확인해주세요.</td>
					</tr>
				</tbody>
			</table>

			<table class="table table-bordered track_tbl">
				<colgroup>
					<col width="20%">
					<col width="30%">
					<col width="40%">
					<col width="10%">
				</colgroup>
				<thead style="background-color: #ef8200; color: black;">
					<tr>
						<th scope="col" style='text-align: center;'>날짜 및 시간(DATE/TIME)</th>
						<th scope="col" style='text-align: center;'>배송상태</th>
						<th scope="col" style='text-align: center;'>DELIVERY STATUS</th>
						<th scope="col" style='text-align: center;'>배송위치</th>
					</tr>
				</thead>
				<tbody id="trackingList" style='text-align: center;'>
					<tr>
						<td colspan="3" style="text-align: center;">조회가 되지 않았습니다. 운송장
							번호를 다시 확인해주세요.</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		// 초기 로드
		$(function() {
			if ($("#invcSno").val() != "") {
				trackingSearch();
			}
		});

		function trackingSearch() {
			var invcSno = $("#invcSno").val();
			if (invcSno == "") {
				alert("운송장 번호를 입력하세요.");
				$("#invcSno").focus();
				return false;
			}

			var invcSno = $("#invcSno").val() || "";
			var sendData = {
				"invcSno" : invcSno
			};

			$
					.ajax({
						url : "/sys/tracking/pop/getProductSearch.do",
						type : "POST",
						data : JSON.stringify(sendData),
						contentType : "application/json",
						success : function(result) {
							var info = "";
							var addrInfo = "";
							if (result == "") {
								info += "<tr>";
								info += "<td colspan='4' style='text-align: center;'><b>조회가 되지 않았습니다. 운송장 번호를 다시 확인해주세요.</b></td>";
								info += "</tr>";
								addrInfo += "<tr>";
								addrInfo += "<td colspan='2' style='text-align: center;'><b>조회가 되지 않았습니다. 운송장 번호를 다시 확인해주세요.</b></td>";
								addrInfo += "</tr>";
							} else {
								info += "<tr>";
								info += "<td>" + (result.ordNo || "") + "</td>"; // 주문번호.
								info += "<td>" + (result.goodsNm || "")
										+ "</td>"; // 상품명.
								info += "<td>" + (result.goodsCnt || "")
										+ "</td>"; // 수량.
								info += "<td>" + (result.localShipper || "")
										+ "</td>"; // 택배사.
								info += "</tr>";
								addrInfo += "<tr>";
								addrInfo += "<td>" + (result.shipAddr || "")
										+ "</td>"; // 출발지.
								addrInfo += "<td>" + (result.recvAddr || "")
										+ "</td>"; // 도착지.
								addrInfo += "</tr>";
							}
							$("#productInfo").empty().append(info);
							$("#addressInfo").empty().append(addrInfo);
						}
					});

			$
					.ajax({
						url : "/sys/tracking/pop/getOrderSearch.do",
						type : "POST",
						data : JSON.stringify(sendData),
						contentType : "application/json",
						success : function(data) {
							var results = data.resultList;
							var addrStr = "";
							var str = "";
							if (data.resultList == "") {
								str += "<tr>";
								str += "<td colspan='4' style='text-align: center;'><b>조회가 되지 않았습니다. 운송장 번호를 다시 확인해주세요.</b></td>";
								str += "</tr>";
							} else {
								$.each(results, function(i) {
									str += "<tr class='active'>";
									str += "<td>" + results[i].adddatetime
											+ "</td>";
									results[i].statusCd > 50 && results[i].statusCd < 60 ? str += "<td>" + "배송중" + "</td>" : str += "<td>" + results[i].statusNm
									str += "<td>" + results[i].statusEnNm
									+ "</td>";
									str += "<td>" 
									!results[i].eNation && results[i].statusCd < 53 ? str+= "KOR" : str+= results[i].eNation
									+ "</td>";
									/*                     switch (results[i].statusCd) {
									 case "10" : // 주문등록.
									 case "11" : // 발송대기.
									 case "12" : // 발송완료.
									 case "20" : // 입금대기.
									 case "21" : // 입금완료.
									 case "22" : // 결제대기.
									 case "23" : // 결제실패.
									 case "30" : // 입고완료.
									 case "31" : // 창고보관.
									 case "32" : // 출고대기.
									 case "33" : // 검수완료.
									 case "34" : // 검수취소.
									 case "35" : // 선적대기.
									 case "40" : // 츨고완료.
									 case "50" : // 인천공항 출발예정.
									 case "51" : // 인천공항 출발완료.
									 case "95" : // 입고취소.
									 case "97" : // 발송보류.
									 case "98" : // 입금대기,입금완료 취소.
									 case "99" : // 주문취소.
									 str += "<td>" + "KR" + "</td>";
									 break;
									 default :
									 str += "<td>" + results[i].eNation + "</td>";
									 break;
									 } */

									str += "</tr>";
								});
							}
							$("#trackingList").empty().append(str);
						},
						error : function(data) {
							alert("에러");
						}
					});
		}
	</script>
</body>
</html>
