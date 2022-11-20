<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html>
<head>
<title>UbiReport Preview</title>
<script language='javascript'>
<!--

	/* 기본 정보 */
	var host = self.location.host;							// ip:port
	var app = "myapp";										// WebApplication 명.
	var url = "http://" + host + (app==""?"":("/" + app));	// WebApplication URL.

	/* 환경 설정 정보 */
	var file_url = url + "/ubireport/";			// 리포트에서 사용되는 이미지 또는 공통 아이템 정보를 가져오기위한 정보.
	var form_url = url + "/UbiForm";			// Form Servlet URL
	var data_url = url + "/UbiData";			// Data Servlet URL
	var svr_url = url + "/UbiServer";			// UbiServer Servlet URL
	var jrf_dir = "/WAS/myapp/ubireport/work/";	// 리포트 파일 경로.
	var jrf = "ubi_sample.jrf";					// 리포트파일명.
	var ds  = "jdbc/tutorial";					// 데이타소스명.
	var scale = "120";							// 초기 배율
	var is_deflater = "true";					// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함).
	var is_base64 = "true";						// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함).
	var is_unicode = "false";					// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함).
	var utf_data = "true";						// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함).

	var codebase = url + "/ubireport/";			// UbiViewer 파일 경로
	var cab_ver = "2,502,1507,302";			// UbiViewer 버전.

	var w_gap = 12;	// 가로 크기 조정.
	var h_gap = 12;	// 세로 크기 조정.

	function getArg() { // 아규먼트 값 설정. 자동 호출.
	
		var args = 'arg1#arg1_value1#arg2#arg2_value#...#argn#argn_value#';
		return args;
	}

	function Ubi_Resize() { // 브라우저 리사이즈 시 오브젝트 크기 조정.

		var w = ((self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth)) - w_gap;
		var h = ((self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)) - h_gap;
		document.getElementById("UbiViewer").width = w + 'px';
		document.getElementById("UbiViewer").height = h + 'px';
	}

//-->
</script>
</head>
<body style='margin:3px' onresize="Ubi_Resize()">
<script type="text/javascript">
<!--

	var w = ((self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth)) - w_gap;
	var h = ((self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)) - h_gap;

	document.write("<object id='MAePageSAFER' classid='CLSID:4A3E00BC-05BB-4C6E-971E-BDAB21B044AA' codebase='" + url + "/ubireport/MAePageSAFERUB.cab#VERSION=5,0,10,1' width='0px' height='0px'></object>");
	document.write("<object id='UbiViewer' classid='CLSID:33D57A48-FF0D-46D1-83D3-6D5AE280BB91' codebase='" + codebase + "UbiViewerXMarkAny.cab#version=" + cab_ver + "' width='" + w + "px' height='" + h + "px'>");
	document.write("	<param name='fileURL'				value='" + file_url + "'>");
	document.write("	<param name='servletRootURL'		value='" + url + "'>");
	document.write("	<param name='servletURL1'			value='" + form_url + "'>");
	document.write("	<param name='servletURL2'			value='" + data_url + "'>");
	document.write("	<param name='jrfFileDir'			value='" + jrf_dir + "'>");
	document.write("	<param name='jrfFileName'			value='" + jrf + "'>");
	document.write("	<param name='dataSource'			value='" + ds + "'>");
	document.write("	<param name='scale'					value='" + scale + "'>");

	document.write("	<param name='isDeflater'			value='" + is_deflater + "'>");
	document.write("	<param name='isBase64'				value='" + is_base64 + "'>");
	document.write("	<param name='isUnicode'				value='" + is_unicode + "'>");
	document.write("	<param name='utfData'				value='" + utf_data + "'>");

	document.write("	<param name='execType'				value='TYPE4'>");	// 실행형태. 변경 불가.
	document.write("	<param name='margin'				value='true'>");	// 여백 마크 보임 여부 속성.
	document.write("	<param name='progress'				value='true'>");	// 프로그래스바 보임 여부 속성.
	document.write("	<param name='toolbar'				value='true'>");	// 툴바 보임 여부 속성.
	document.write("	<param name='fontRevision'			value='true'>");	// 폰트보정. 변경 불가.
	document.write("	<param name='printMarginRevision'	value='true'>");	// 출력보정. 변경 불가.

	document.write("	<param name='ubiServerURL'			value='" + svr_url + "'>");
	document.write("	<param name='IsDrm'					value='true'>");	// DRM 사용 여부.
	document.write("	<param name='DocName'				value='default'>");	// 변경 불가.
	document.write("</object>");

//-->
</script>

</body>
</html>
