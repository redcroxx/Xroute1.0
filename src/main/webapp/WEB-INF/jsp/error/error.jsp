<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<title>XROUTE</title>
</head>
</head>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="" >
	<div class="jumbotron">
		<div class="container">
			<h1>오류가 발생 하였습니다.</h1>
			<p>&nbsp;</p>
			<p><a class="btn btn-primary btn-lg" href="/comm/login.do" role="button">로그인 페이지 이동</a></p>
		</div>
	</div>
	<script type="text/javascript">
	window.history.forward();
	function noBack() {
		window.history.forward();
	}
	</script>
</body>
</html>