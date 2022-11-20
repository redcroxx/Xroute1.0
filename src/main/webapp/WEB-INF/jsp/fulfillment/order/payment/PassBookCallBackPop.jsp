<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="init()">
    <c:choose>
        <c:when test="${resultCd eq '0'}">
            <b>인증이 처리되었습니다.</b>
        </c:when>
        <c:otherwise>
            <b><c:out value="${errCd}" /></b>
        </c:otherwise>
    </c:choose>
    <%--     <ul>
        <li>
            <c:out value="${resultCd}" />
        </li>
        <li>
            <c:out value="${errCd}" />
        </li>
        <li>
            <c:out value="${ordNo}" />
        </li>
        <li>
            <c:out value="${authNo}" />
        </li>
    </ul> --%>
</body>
<script type="text/javascript">
    function init() {
        var resultCd = "<c:out value='${resultCd}' />";
        var errCd = "<c:out value='${errCd}' />";
        var etcNo = "";
        if (resultCd == "0") {
            etcNo = "<c:out value='${authNo}' />";
        } else {
            etcNo = "<c:out value='${ordNo}' />";
        }
        
        opener.parent.getCallBack(resultCd, etcNo, errCd);
        setTimeout("self.close()", "2000");
    }
</script>
</html>