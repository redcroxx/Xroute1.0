<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>UbiReport Preview</title>
<!--[if IE]><script src="/myapp/ubireport/ajax/js4/excanvas.js"></script><![endif]-->
<script src="/myapp/ubireport/ajax/js4/ubiajax.js"></script>
<script language='javascript'>
<!--

	/* 기본 정보 */
	var host = self.location.host;							// ip:port
	var app = "myapp";										// WebApplication 명.
	var url = "http://" + host + (app==""?"":("/" + app));	// WebApplication URL.

	/* 환경 설정 정보 */
	var key = "key";													// 사용자 세션 유지용 값. 일반적으로 JSP에서 session.getId() 사용.
	var jrf = "ubi_sample.jrf";											// 리포트파일명.
	var arg = "arg1#arg1_value1#arg2#arg2_value#...#argn#argn_value#";	// 아규먼트
	var res_id = "UBIAJAX";												// ubidaemon.property에 등록된 리소스 아이디.
	var viewer_id = "UbiAjaxViewer";									// 뷰어 DIV 아이디.
	var scale = "120";													// 최초 미리보기 배율.
	var timeout = "600000";												// 응답시간 타임아웃(1분).

	var w_gap = 12; // 가로 크기 조정.
	var h_gap = 12; // 세로 크기 조정.

	function Ubi_Resize() { // 브라우저 리사이즈 시 오브젝트 크기 조정.

		var w = ((self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth)) - w_gap;
		var h = ((self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)) - h_gap;
		document.getElementById(viewer_id).style.width = w + 'px';
		document.getElementById(viewer_id).style.height = h + 'px';
	}

	function Ubi_LoadReport() {// 리포트 로드.

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
		
		consol.log("jrf파일 속성----------"+ viewer);
		viewer.showReport();
	}

//-->
</script>
</head>
<body style='margin:3px' onresize='Ubi_Resize()'>
<div id="UbiAjaxViewer" style="border: solid 1px #aaa; position:relative;"></div>
<script>Ubi_LoadReport();</script>
</body>
</html>
