<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="init()">
    <c:choose>
        <c:when test="${rsultData eq 'OK'}">
            <b>정상적으로 처리되었습니다.</b>
        </c:when>
        <c:when test="${rsultData eq 'FALSE'}">
            <b>오류가 발생하였습니다.</b>
        </c:when>
    </c:choose>
</body>
<script type="text/javascript">
    function init() {
        opener.parent.listReset();
        opener.parent.cancel();
        setTimeout("self.close()", "2000");
    }
</script>
</html>