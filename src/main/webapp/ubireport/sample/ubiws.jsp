<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>UbiViewerWS Test Page</title>
<script type="text/javascript" src="/myapp/ubireport/plugin/ubiviewer.js"></script>
<script type="text/javascript" src="/myapp/ubireport/ubiws/ubiws.js"></script>
<script language="javascript" type="text/javascript">
<!--

	/* 기본 정보 */
	var host = self.location.host;				// ip:port
	var app = "myapp";							// WebApplication 명.
	var wasRoot = "/usr/tomcat/webapps/";		// WAS WebRoot
	var url = "http://" + host + (app==""?"":("/" + app));	// WebApplication URL.
	var arg = "arg_name#arg_value#...#";
		
	/* 환경 설정 정보 */
	var file_url = url + url + "/ubireport/";	// 리포트에서 사용되는 이미지 또는 공통 아이템 정보를 가져오기위한 정보.
	var form_url = url + "/UbiForm";			// Form Servlet URL
	var data_url = url + "/UbiData";			// Data Servlet URL
	var jrf_dir = wasRoot+app+"/ubireport/work/";	// 리포트 파일 경로.
	var jrf = "ubi_sample.jrf";					// 리포트파일명.
	var ds  = "jdbc/tutorial";					// 데이타소스명.
	var scale = "120";							// 초기 배율
	var is_deflater = "true";					// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함).
	var is_base64 = "true";						// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함).
	var is_unicode = "false";					// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함).
	var utf_data = "true";						// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함).

	function UbiWS_CheckInstall() {
	//IE 10 이하에서는 호출하지 않게 체크
		if(Ubi_isIE || Ubi_isIE10 ) {
			//alert("해당 브라우저에서는 WS 모듈을 동작시킬 수 없습니다.");
			return false;
		}else{
			//alert("해당 브라우저에서는 PlugIn 모듈을 동작시킬 수 없습니다.");
			return true;
		}
	}
	
	//UbiPlugin
	var w_gap = 12;	// 가로 크기 조정.
	var h_gap = 12;	// 세로 크기 조정.

	function getArg() {			// 아규먼트 값 설정. 자동 호출.
	
		var args = arg;
		return args;
	}

	function Ubi_Resize() {		// 브라우저 리사이즈 시 오브젝트 크기 조정.

		var w = ((self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth)) - w_gap;
		var h = ((self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)) - h_gap;
		document.getElementById("UbiViewer").width = w + 'px';
		document.getElementById("UbiViewer").height = h + 'px';
	}

	//UbiWs	
	var viewer = null;
	var preViewFlag = false; //

	function UbiWS_Init() {
		
		if(preViewFlag){
			ubi_ShowWindowMsg();	// 새창으로 메시지 보이기			
		}else{
			ubi_ShowDivMsg();		// DIV 형태로 메시지 보이기
		}
		// 웹소켓 초기화 및 미리보기 콜백
		InitWebSocket(ShowReport);
	}

	function ShowReport(ws) {
		
		viewer = new UbiViewer(ws);

		viewer.servletrooturl = url;
		viewer.servleturl1 = form_url;
		viewer.servleturl2 = data_url;
		viewer.jrffiledir = jrf_dir;
		viewer.jrffilename = jrf;
		viewer.datasource = ds;
		viewer.arg = arg;		
		
		viewer.fontrevision = 'true';
		viewer.isdeflater = 'true';
		viewer.isunicode = 'false';
		viewer.utfdata = 'true';
		viewer.isbase64 = 'true';

		viewer.retrieve();
	}

	function checkViewerVersion() {
		viewer.aboutBox();
	}

	function RetrieveEnd() {

		if(preViewFlag){
			ubi_CloseWindowMsg();	// 메시지 창 닫기			
		}else{
			ubi_CloseDivMsg();		// 메지지 DIV 닫기
		}	
		//viewer.directPrint();
		//autoExport();
		
	}

	function ExportEnd(message) {
		/*var filepath = message;
		if (filepath.length > 0) {
			alert("Export success : " + filepath);
		} else {
			alert("Export fail");
		}*/
	}

	function PrintEnd(message) {
		/*var result = message;
		if (result == 0) {
			alert("print success!");
		} else {
			alert("print fail!");
		}*/
		
		// 뷰어 닫기 (먼저)
		/*viewer.close();
		// 브라우저 닫기
		self.close();*/
	}

	function autoExport() {
		/*
		viewer.exportfilename = "D:/test.pdf";
		viewer.ExportFile('PDF');
		*/
	}

//-->
</script>
</head>
<body style='margin:10px'>
<script type="text/javascript">
<!--

	if(UbiWS_CheckInstall()) {
		
		InitWebSocket(UbiWS_Init);	
		
	}else{
		
		if( Ubi_PluginCheck() ) {

			var w = ((self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth)) - w_gap;
			var h = ((self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)) - h_gap;

			document.write("<object id='UbiViewer' type='" + Ubi_PluginType() + "' width='" + w + "px' height='" + h + "px'>");
			document.write("	<param name='ocxtype'				value='" + Ubi_ActiveXEdition() + "'>");
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
			document.write("</object>");
		}	
		
	}
	
//-->
</script>
</body>
</html>