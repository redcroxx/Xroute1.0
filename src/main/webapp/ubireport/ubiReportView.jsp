<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>리포트</title>
<!--[if IE]><script src="http://localhost:8088/ubireport/ajax/js4/excanvas.js"></script><![endif]-->
<script src="/ubireport/ajax/js4/ubiajax.js"></script>

<script type="text/javascript">
/* 기본 정보 
 */
var host = self.location.host;							// ip:port
var app = '';										// WebApplication 명.
var url = 'https://' + host + (app==''?'':('/' + app));	// WebApplication URL.
/* 환경 설정 정보 */;
var key = 'key';													// 사용자 세션 유지용 값. 일반적으로 JSP에서 session.getId() 사용.
var jrf = '${param.jrf}';											// 리포트파일명.
//var arg = "arg1#아규먼트테스트#";	// 아규먼트
var arg = '${param.arg}';	// 아규먼트
var viewer_id = 'UbiAjaxViewer';									// 뷰어 DIV 아이디.
var res_id = 'UBIAJAX';												// ubidaemon.property에 등록된 리소스 아이디.
var scale = '140';													// 최초 미리보기 배율.
var timeout = '600000';												// 응답시간 타임아웃(1분).
var print2 = '${loginVO.print2}';

var w_gap = 20; // 가로 크기 조정.
var h_gap = 20; // 세로 크기 조정.

function Ubi_Resize() { // 브라우저 리사이즈 시 오브젝트 크기 조정.
	var w = ((self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth)) - w_gap;
	var h = ((self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)) - h_gap;
	document.getElementById(viewer_id).style.width = w + 'px';
	document.getElementById(viewer_id).style.height = h + 'px';
}

function Ubi_LoadReport() {// 리포트 로드.
	document.title = arg.substring(arg.indexOf('TITLE#') + 6, arg.indexOf('#', arg.indexOf('TITLE#') + 6));
	var w = ((self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth)) - w_gap;
	var h = ((self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)) - h_gap;
	document.getElementById(viewer_id).style.width = w + 'px';
	document.getElementById(viewer_id).style.height = h + 'px';

	var viewer = new UbiViewer( {
		key       : '<%= session.getId() %>',
		gatewayurl: url + '/UbiGateway',
		resource  : url + '/ubireport/ajax/js4',
		jrffile   : jrf,
		arg       : arg,
		resid     : res_id,
		divid     : viewer_id,
		scale     : scale,
		timeout   : timeout
	});
	viewer.showReport();
}
</script>
</head>
<body onload="Ubi_LoadReport()" onresize="Ubi_Resize()">
<div id="UbiAjaxViewer" style="border:solid 1px #aaa;position:relative;"></div>
</body>
</html>