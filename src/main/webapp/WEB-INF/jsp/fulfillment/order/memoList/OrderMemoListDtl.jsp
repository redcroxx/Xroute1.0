<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst"%>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<title>로지포커스</title>
</head>
<body>
<div id="container">
	<form id="orderMenoListForm" name="orderMenoListForm" action="/fulfillment/order/orderMemoInsert/view.do" method="post">
		<div class="container mt-4">
			<div class="card mb-4">
				<div class="card-body">
					<div class="row">
						<div class="col-md-12">
							<div class="input-group md-form form-sm form-2 pl-0">
								<span class="input-group-text" id="basic-addon1">송장번호 OR 주문번호</span>
								<input type="hidden" id="sStatusCd" value="<c:out value='${closeYn}'/>"/>
								<input type="hidden" id="sEtcCd1" value="<c:out value='${sEtcCd1}'/>"/>
								<input class="form-control my-0 py-1 pl-3 purple-border" type="text" placeholder="송장번호 또는 주문번호를 입력하세요." aria-label="Search" id="sXrtInvcSno" name="sXrtInvcSno" value="${xrtInvcSno}">
								<button type="button" class="btn btn-secondary" onclick="getSearchMemo();">검색</button>
							</div>
						</div>
					</div>
					<table class="table table-hover" style="text-align: center; margin-top: 10px; border: 1px solid;">
						<colgroup>
							<col width="15%">
							<col width="15%">
							<col width="10%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
						</colgroup>
						<thead class="thead-dark">
							<tr>
								<th scope="col">송장번호</th>
								<th scope="col">주문번호</th>
								<th scope="col">작성자</th>
								<th scope="col">유형</th>
								<th scope="col">작성일시</th>
								<th scope="col">배송상태</th>
								<th scope="col">메모상태</th>
							</tr>
						</thead>
						<tbody id="memoList">
						</tbody>
					</table>
					<footer style="text-align: right;">
						<button type="button" class="btn btn-default" onclick="insertMemoView();">메모 입력</button>
						<button type="submit" class="btn btn-default" onclick="javascript:window.close();">닫기</button>
					</footer>
				</div>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
$(function () {
	getSearchMemo();
});

function insertMemoView() {
    var sXrtInvcSno = $("#sXrtInvcSno").val();
    if (sXrtInvcSno == "") {
        alert("송장번호를 입력하세요.");
        return;
    }
	$("#orderMenoListForm").submit();
}

function getSearchMemo() {
	var param = {};
	var sEtcCd1 = "shippingMemo";
	var sXrtInvcSno = $("#sXrtInvcSno").val()||"";
	var sStatusCd = $("#sStatusCd").val()||"";
	param.sXrtInvcSno = sXrtInvcSno;
	param.sStatusCd = sStatusCd;
	param.sEtcCd1 = $("#sEtcCd1").val()||"";
	param = JSON.stringify(param);
	
	$.ajax({
		url : "/fulfillment/order/orderMemoListDtl/getSearchMemo.do",
		data : param,
		type : "POST",
		contentType: "application/json",
		success : function (data) {
			var results = data.resultList;
			var str = "";
			if (data.resultList == "" || data.resultList == null) {
			    str += "<tr>";
                str += "<td colspan='7'>등록된 메모가 없습니다.</td>";
                str += "</tr>";
			}else {
			    $.each(results , function(i){
	                if (results[i].memoType == "shipping") {
	                    results[i].memoType = "배송관련문의";
	                }
	                if (results[i].memoType == "payment") {
	                    results[i].memoType = "결제관련문의";
	                }
	                if (results[i].memoType == "others") {
	                    results[i].memoType = "기타문의";
	                }
	                str += "<tr>";
	                str += "<td><a href='#' onClick='fn_orderMemoInfoView(\""+ results[i].orderMemoSeq + "\")'>" + results[i].xrtInvcSno + "</a></td>";
	                str += "<td>" + results[i].ordNo + "</td>";
	                str += "<td>" + results[i].addusercd + "</td><td>" + (results[i].memoType || "") + "</td>";
	                str += "<td>" + (results[i].adddatetime || "") + "</td><td>" + results[i].shippingStatus + "</td>" + "<td>" + results[i].statusCd + "</td>";
	                str += "</tr>";
	            });
			}
			$("#memoList").empty().append(str);
		},
		error : function (data) {
			alert("에러");
		}
	});
}

function fn_orderMemoInfoView(orderMemoSeq) {
	var sXrtInvcSno = "";
	if ($("#sXrtInvcSno").val() == "") {
		sXrtInvcSno = "";
	}else {
		sXrtInvcSno = $("#sXrtInvcSno").val();
	}
	var url = "/fulfillment/order/orderMemoList/infoView.do";
	url += "?xrtInvcSno=" + sXrtInvcSno + "&orderMemoSeq=" + orderMemoSeq;
	location.href = url;
}
</script>
</body>
</html>
