<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat, java.text.DateFormat" %>
<%
    Calendar calendar = Calendar.getInstance();
    Date nowdt = calendar.getTime();
    // 현재일자
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    String to_dt = dateFormat.format(nowdt);
    calendar.add(Calendar.MONTH, -1);
    calendar.add(Calendar.DAY_OF_MONTH, 1);
    String from_dt = dateFormat.format(calendar.getTime());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Search</title>
<style>
body {
	font-size:10pt;
	font-family: Arial;
	color: #000000;
	line-height:18px;
}
</style>
<body>
<form name="frm_search" method="POST" action="./LogReport.jsp" target="REPORT_FRAME">
    <input type="text" name="from_dt" value="<%=from_dt%>"> ~ <input type="text" name="to_dt" value="<%=to_dt%>"> &nbsp; <input type="submit" value="조회">
</form>
<iframe name="REPORT_FRAME" src="" width="100%" height="95%" frameborder="0"></iframe>
</body>
</html>