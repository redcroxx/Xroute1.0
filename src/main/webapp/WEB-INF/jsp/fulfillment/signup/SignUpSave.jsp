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
			<h1>회원정보 등록 완료</h1>
			<p>승인 절차 후, 정상적으로 이용이 가능합니다.</p>
			<p style="color: red"><b>가입승인 완료 후 최초 로그인시 ID와 PW 동일 합니다.</b></p>
			<p>승인이 완료되면, 연락드리겠습니다.</p>
			<p>감사합니다.</p>
			<p><a class="btn btn-primary btn-lg" href="/comm/login.do" role="button">메인 화면 이동</a></p>
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