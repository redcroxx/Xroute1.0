<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="xrt.alexcloud.common.CommonConst"%>
<html>
<head>
<title>로지포커스</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<style>
body {
	background-color: #000000;
}

.contact {
	padding: 4%;
	height: 400px;
}

.col-md-3 {
	background: #ff9b00;
	padding: 4%;
	border-top-left-radius: 0.5rem;
	border-bottom-left-radius: 0.5rem;
}

.contact-info {
	margin-top: 10%;
}

.contact-info img {
	margin-bottom: 15%;
}

.contact-info h2 {
	margin-bottom: 10%;
}

.col-md-9 {
	background: #fff;
	padding: 3%;
	border-top-right-radius: 0.5rem;
	border-bottom-right-radius: 0.5rem;
}

.contact-form label {
	font-weight: 600;
}

.contact-form button {
	background: #000000;
	color: #fff;
	font-weight: 600;
	width: 25%;
}

.contact-form button:focus {
	box-shadow: none;
}
</style>
</head>
<body>
	<div class="container contact">
		<form id="memoUpdateForm" name="memoUpdateForm" action="post" onsubmit="return false" enctype="multipart/form-data">
			<div class="row">
				<div class="col-md-3">
					<div class="contact-info">
						<img src="https://image.ibb.co/kUASdV/contact-image.png" alt="image" />
						<h2>메모 수정</h2>
					</div>
				</div>
				<div class="col-md-9">
					<div class="contact-form">
						<div class="form-group">
							<label class="control-label col-sm-5" for="xrtInvcSno">송장번호</label> <label class="control-label col-sm-5" for="name">작성자</label>
							<div class="col-sm-10">
								<input type="hidden" id="orderMemoSeq" name="orderMemoSeq" value="${orderMemoSeq}">
								<input type="text" class="form-control" id="xrtInvcSno" name="xrtInvcSno" value="<c:out value='${xrtInvcSno}'/>" readonly="readonly" style="width: 50%; display: inline-block;">
								<input type="text" class="form-control" id="addusercd" name="addusercd" value="<c:out value='${addusercd}'/>" readonly="readonly" style="width: 49%; display: inline-block;">
							</div>
						</div>
						<div class="form-group">
							<c:choose>
								<c:when test="${sessionScope.loginVO.usergroup <= SELLER_ADMIN}">
										<label class="control-label col-sm-10" for="memoType">메모 구분</label>
										<div class="col-sm-10">
											<select id="memoType" name="memoType" class="custom-select">
												<option value="shipping" selected="selected">배송관련문의</option>
                                                <option value="payment">결제관련문의</option>
                                                <option value="others">기타문의</option>
											</select>
										</div>
								</c:when>
								<c:otherwise>
										<label class="control-label col-sm-5" for="memoType">메모 구분</label> 
										<label class="control-label col-sm-5" for="memoAuthority">메모 권한</label>
										<div class="col-sm-10">
											<select id="memoType" name="memoType" class="custom-select" style="width: 50%;">
												<option value="shipping" selected="selected">배송관련문의</option>
                                                <option value="payment">결제관련문의</option>
                                                <option value="others">기타문의</option>
											</select>
											<select id="memoAuthority" name="memoAuthority" class="custom-select" style="width: 49%;">
												<option value="total" selected="selected">전체</option>
												<option value="admin">관리자</option>
											</select>
										</div>
								</c:otherwise>
							</c:choose>
						</div>

						<div class="form-group">
							<label class="control-label col-sm-10" for="memoMultiFile">첨부 파일<b style="color: red;">&nbsp;&nbsp;* 첨부파일은 1개만 첨부 가능합니다.</b></label>
							<div class="col-sm-10">
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text">첨부파일</span>
									</div>
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="memoMultiFile" name="memoMultiFile" onchange="fn_fileChange(this)" max="1">
										<label class="custom-file-label" for="inputGroupFile01" id="inputGroupFile01"></label>
									</div>
								</div>
								<div class="input-group-prepend">
									<span class="input-group-text" id="addon-wrapping">파일목록</span>
									<div class="form-control" id="memoFilePath">${memoFilePath}</div>
								</div>
							</div>
						</div>
	
						<div class="form-group">
							<label class="control-label col-sm-2" for="contents">내용</label>
							<div class="col-sm-10">
								<textarea class="form-control" rows="5" id="contents" name="contents">${contents}</textarea>
							</div>
						</div> 
						<footer style="text-align: right;">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-default" onclick="updateMemo()">메모 수정</button>
								<button type="submit" class="btn btn-default" onclick="deleteMemo()">메모 삭제</button>
								<button type="button" class="btn btn-default" onclick="windowClose()">닫기</button>
							</div>
						</footer>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
		$("#memoType").val("<c:out value='${memoType}'/>");
		$("#memoAuthority").val("<c:out value='${memoAuthority}'/>");
		// 메모 수정.
		function updateMemo() {
			if (confirm("메모를 수정하시겠습니까?") == false) {
				return;
			}
			if ($("#contents").val() == "") {
				cfn_msg("WARNING", "내용을 입력하세요.");
				$("#contents").focus();
				return;
			}
			
			var xrtInvcSno = $("#xrtInvcSno").val();
			var fileData = new FormData();
			fileData.append("orderMemoSeq", $("#orderMemoSeq").val());
			fileData.append("xrtInvcSno", $("#xrtInvcSno").val()); 
			fileData.append("addusercd", $("#addusercd").val()); 
			fileData.append("memoType", $("#memoType").val()); 
			fileData.append("memoAuthority", $("#memoAuthority").val()); 
			
			var fileCheck = document.getElementById("memoMultiFile").value;
			if (fileCheck) {
				fileData.append("memoMultiFile", $("#memoMultiFile")[0].files[0]);
			} 
			
			fileData.append("contents", $("#contents").val()); 

			$.ajax({
				url : "/fulfillment/order/orderMemoInsert/updateMemo.do",
				type : "POST",
				processData: false,
				contentType: false,
				data : fileData,
				success : function(data) {
					console.log(data);
					if (data.result == true) {
						alert("[메모 수정 완료] 메모가 수정되었습니다.");
						// self.location = "/fulfillment/order/orderMemoListDtl/view.do?xrtInvcSno=" + xrtInvcSno;
						history.pushState(null, null, "");
                        var prevUrl = document.referrer;
                        if(prevUrl.indexOf("/fulfillment/order/orderMemoList/infoView.do") < 0){ //뒤로가기를 한 페이지가 test.do 페이지가 아니면 뒤로가기, test.do 페이지면 새로고침합니다.
                            history.back();
                        }else{
                            location.href= prevUrl;
                        }
					} else {
						alert("[메모 수정 실패] 다시 확인해주시기 바랍니다.");
					}
				},
				error : function(data) {
					alert("[메모 수정 오류] 관리자에게 문의하시기 바랍니다.");
				}
			});
		};
		
		// 메모 삭제.
		function deleteMemo() {
			if (confirm("메모를 삭제하시겠습니까?") == false) {
				return;
			}
			var jsonObj = {};
			jsonObj.xrtInvcSno = $("#xrtInvcSno").val();
			jsonObj.orderMemoSeq = $("#orderMemoSeq").val();
			
			$.ajax({
				url : "/fulfillment/order/orderMemoInsert/deleteMemo.do",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify(jsonObj),
				success : function(data) {
					console.log(data);
					if (data.result == true) {
						alert("[메모 삭제] 메모 삭제 처리되었습니다.");
						self.location = "/fulfillment/order/orderMemoListDtl/view.do?xrtInvcSno=" + xrtInvcSno;
					} else {
						alert("[메모 삭제 실패] 다시 확인해주시기 바랍니다.");
					}
				},
				error : function(data) {
					alert("[메모 삭제 오류] 관리자에게 문의하시기 바랍니다.");
				}
			});	
		};
		
		// 윈도우 팝업 종료.
		function windowClose() {
			window.open("about:blank", "_self").close();
		};
		
		// 파일 첨부.
		function fn_fileChange(obj) {
			var file = $("#memoMultiFile").val();
			var fileName = file.split("\\")[2];
			// $(obj).next().next().text(fileName);
			$("#memoFilePath").text(fileName);
		}
	</script>
</body>
</html>