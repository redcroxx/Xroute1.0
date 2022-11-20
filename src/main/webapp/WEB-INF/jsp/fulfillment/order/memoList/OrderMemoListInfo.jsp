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
		<form id="orderMenoInfoForm" name="orderMenoInfoForm" action="/fulfillment/order/orderMemoList/updateView.do" method="POST">
			<div class="container mt-4">
				<div class="card mb-4">
					<div class="card-body">
                        <header style="text-align: right;">
                            <span style="font-weight:bold; color:blue; font-size: large; text-align: left; margin-right: 450px;" id="memoInfo"></span>
                            <button type="button" class="btn btn-default" onclick="goBack();">뒤로 가기</button>
                            <button type="button" class="btn btn-default" onclick="memoStatus();">메모 완료</button>
                            <button type="button" class="btn btn-default" onclick="updateMemoView();">메모 수정</button>
                            <button type="submit" class="btn btn-default" onclick="javascript:window.close();">닫기</button>
                        </header>
                    
						<div class="input-group mb-3" style="margin-top: 20px;">
							<input type="hidden" id="xrtInvcSno" name="xrtInvcSno" value="${xrtInvcSno}">
							<input type="hidden" id="orderMemoSeq" name="orderMemoSeq" value="${orderMemoSeq}">
							<c:choose>
								<c:when test="${sessionScope.loginVO.usergroup <= SELLER_ADMIN}">
									<div class="input-group-prepend">
										<span class="input-group-text" id="basic-addon1">송장번호</span>
									</div>
									<div class="form-control" id="xrtInvcSno"><c:out value="${xrtInvcSno}"/></div>
								</c:when>
								<c:otherwise>
									<div class="input-group-prepend" style="width: 90px;">
										<span class="input-group-text" id="basic-addon1">송장번호</span>
									</div>
									<div class="form-control" id="xrtInvcSno"><c:out value="${xrtInvcSno}"/></div>
									<div class="input-group-prepend" style="width: 90px;">
										<span class="input-group-text" id="basic-addon1">메모권한</span>
									</div>
									<div class="form-control" id="memoAuthority"><c:out value="${memoAuthority}"/></div>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1" style="width: 90px; text-align: center;">작성자</span>
							</div>
							<div class="form-control" id="addusercd"><c:out value="${addusercd}"/></div>
							<div class="input-group-prepend" style="width: 90px;">
								<span class="input-group-text" id="basic-addon1">작성일시</span>
							</div>
							<div class="form-control" id="adddatetime"><c:out value="${adddatetime}"/></div>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend" style="width: 90px;">
								<span class="input-group-text" id="basic-addon1">메모타입</span>
							</div>
							<div class="form-control" id="memoType"><c:out value="${memoType}"/></div>
                            <div class="input-group-prepend" style="width: 90px;">
                                <span class="input-group-text" id="basic-addon1">첨부파일</span>
                            </div>
                            <c:choose>
                                <c:when test="${memoFilePath == '첨부파일이 존재하지 않습니다.'}">
                                    <div class="form-control"><b>${memoFilePath}</b></div>
                                </c:when>
                                <c:otherwise>
                                    <div class="form-control" id="memoMultiFile"><a href="#" onclick="fn_fileDown('${xrtInvcSno}','${orderMemoSeq}'); return false;">${memoFilePath}</a><br></div>
                                </c:otherwise>
                            </c:choose>
						</div>
						<div class="input-group" style="margin-bottom: 2%;">
							<div class="input-group-prepend" style="width: 90px;">
								<span class="input-group-text" style="width: 90px; padding-left: 27px;">내용</span>
							</div>
                            <textarea class="form-control" rows="5" id="contents" name="contents" disabled="disabled"><c:out value="${contents}"/></textarea>
						</div>
                        
                        <!-- 답글 등록 -->
                        <div class="input-group" style="margin-bottom: 2%;">
                            <div class="input-group-prepend" style="width: 90px;">
                                <span class="input-group-text" style="width: 90px;">답글 입력</span>
                            </div> 
                            <textarea class="form-control" rows="5" id="replyContents" name="replyContents" style="height: 50px;"></textarea>
                            <c:choose>
                                <c:when test="${sessionScope.loginVO.usergroup <= SELLER_ADMIN}">
                                    <button type="button" class="btn btn-warning" onclick="insertReply();">답글 등록</button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="btn btn-info" onclick="insertReply();">답글 등록</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <!-- 답글 테이블 목록. -->
                        <table class="table table-hover" style="text-align: center; border: 1px solid;">
                            <colgroup>
                                <col width="10%">
                                <col width="15%">
                                <col width="15%">
                                <col width="60%">
                            </colgroup>
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">날짜</th>
                                    <th scope="col">작성자</th>
                                    <th scope="col">메모 답글</th>
                                </tr>
                            </thead>
                            <tbody id="replyTable"></tbody>
                        </table>
                        
                        <c:choose>
                             <c:when test="${sessionScope.loginVO.usergroup <= SELLER_ADMIN}">
                                 <footer style="text-align: right;">
                                     <button type="button" class="btn btn-default" onclick="goBack();">뒤로 가기</button>
                                     <button type="button" class="btn btn-default" onclick="updateMemoView();">메모 수정</button>
                                     <button type="submit" class="btn btn-default" onclick="javascript:window.close();">닫기</button>
                                 </footer>
                             </c:when>
                             <c:otherwise>
                                 <footer style="text-align: right;">
                                     <button type="button" class="btn btn-default" onclick="goBack();">뒤로 가기</button>
                                     <button type="button" class="btn btn-default" onclick="memoStatus();">메모 완료</button>
                                     <button type="button" class="btn btn-default" onclick="updateMemoView();">메모 수정</button>
                                     <button type="submit" class="btn btn-default" onclick="javascript:window.close();">닫기</button>
                                 </footer>
                             </c:otherwise>
                        </c:choose>
					</div>
				</div>
			</div>
		</form>
		<form id="fileDown" action="/fulfillment/order/orderMemoList/fileDownload.do" style="display: none;">
			<input type="hidden" name="xrtInvcSno" value="${xrtInvcSno}">
			<input type="hidden" name="orderMemoSeq" value="${orderMemoSeq}">
		</form>
	</div>
	<script type="text/javascript">
	
	    // 초기 로드. 
        $(document).ready(function () {
            getReplyList(); // 댓글 목록.
        });
	
		function updateMemoView() {
			$("#orderMenoInfoForm").submit();
		}
		
		function memoStatus() {
			if (confirm("메모 완료 처리를 하시겠습니까?") == false) {
				return;
			}
			var jsonObj = {};
			jsonObj.xrtInvcSno = $("#xrtInvcSno").val();
			jsonObj.orderMemoSeq = $("#orderMemoSeq").val();
			
			$.ajax({
				url : "/fulfillment/order/orderMemoList/updateMemoStatus.do",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify(jsonObj),
				success : function(data) {
					console.log(data);
					if (data.result == true) {
						alert("[메모 완료 처리] 메모 완료 처리되었습니다.");
						window.open("about:blank", "_self").close();
					} else {
						alert("[메모 완료 처리 실패] 다시 확인해주시기 바랍니다.");
					}
				},
				error : function(data) {
					alert("[메모 완료 처리 오류] 관리자에게 문의하시기 바랍니다.");
				}
			});	
		}
		
		function fn_fileDown(xrtInvcSno, orderMemoSeq) {
			var formObj = $("#fileDown");
			formObj.submit();
		}
		
		function goBack() {
			window.history.go(-1);
		};

		// 답글 등록.
		function insertReply() {
		    if (confirm("답글을 등록하시겠습니까?") == false) {
		        return;
		    }
		    
		    if ($("#replyContents").val() == "") {
		        alert("답글 내용을 입력하세요.");
		        $("#replyContents").focus();
		        return;
		    }
		    
		    var sendData = {};
		    sendData.orderMemoSeq = $("input[name='orderMemoSeq']").val();
		    sendData.contents = $("#replyContents").val();
		    
		    var sendData = {};
            sendData.orderMemoSeq = $("input[name='orderMemoSeq']").val();
            sendData.contents = $("#replyContents").val();
            
		    $.ajax({
		        url : "/fulfillment/order/orderMemoList/insertReply.do",
                type : "POST",
                data : JSON.stringify(sendData),
                contentType: "application/json",
                success : function(data) {
                    if (data.code == "200") {
                        alert("정상적으로 등록되었습니다.");
                        $("#replyContents").val("");
                        getReplyList();
                    }else {
                        alert("답글 등록 실패");
                    }
                },
                error : function (data) {
                    alert("답글 등록 에러")
                }
		    });
		}
		
		// 답글 목록.
		function getReplyList() {
            var sendData = {};
            sendData.orderMemoSeq = $("input[name='orderMemoSeq']").val();
            var str = "";
            
            $.ajax({
                url : "/fulfillment/order/orderMemoList/getReplyList.do",
                type : "POST",
                data : JSON.stringify(sendData),
                contentType: "application/json",
                success : function(data) {
                    var userGroup = data.userGroup;
                    var sellerAdmin = data.sellerAdmin;
                    var results = data.resultList;
                    if (data.resultList == "" || data.resultList == null) {
                        str += "<tr>";
                        str += "<td colspan='4'>등록된 답글이 없습니다.</td>";
                        str += "</tr>";
                    }else {
                        $.each(results, function (i) {
                            var orgcd = data.resultList[i].orgcd||"";
                            var number = data.resultList[i].number||"";
                            var adddatetime = data.resultList[i].adddatetime||"";
                            var addusercd = data.resultList[i].addusercd||"";
                            var contents = data.resultList[i].contents||"";
                            var memoType = data.resultList[i].memoType||"";
                            var shippingStatus = data.resultList[i].shippingStatus||"";
                            if (orgcd != "9999" && orgcd != "") {
                                bgcolor = "#ffcc80;";
                                auth = "고객사";
                            } else {
                                bgcolor = "#e0e0e0;";
                                auth = "관리자";
                            }
                            str += "<tr style=\"background-color:"+ bgcolor +"\">";
                            str += "<th scope='row'>" + number + "</th>"
                            str += "<td>" + adddatetime + "</td>";
                            str += "<td>" + "[" + auth + "]</br>" + addusercd + "</td>";
                            str += "<td>" + "[" + memoType + "]</br>" + contents + "</td>";
                            str += "</tr>";
                        });
                    }
                    $("#memoInfo").html("메모 정보");
                    $("#replyTable").empty("").append(str);
                },
                error : function (data) {
                    alert("답글 목록 조회 에러")
                }
            });
        }
	</script>
</body>
</html>
