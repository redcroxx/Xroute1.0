<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>UbiReport Preview</title>
<script type="text/javascript" src="/ubireport/nonax/ubiplugin.js"></script>
<script type="text/javascript" src="/ubireport/nonax/ubiws.js"></script>
<script language='javascript'>
<!--

	/* 기본 정보 */
	var host = self.location.host;
	var app = "";
	var url = self.location.protocol + "//" + host + (app==""?"":("/" + app));
	var viewertype = "UNICODE";	// UNICODE / BCQRE / BCQREUNI / MARKANY

	/* 환경 설정 정보 */
	var rooturl = url;							// Servlet UDS 기준 URL
	var fileurl = url + "/ubireport/";			// 이미지 또는 공통 아이템 기준 URL
	var formurl = url + "/UbiForm";				// UbiForm Servlet URL
	var dataurl = url + "/UbiData";				// UbiData Servlet URL
	var serverurl = url + "/UbiServer";			// UbiServer Servlet URL(DRM 연계용)

	var jrfdir = "C:/LingoFramework/workspace/RUBICORN/src/main/webapp/ubireport/work/";	// 리포트 파일 서버 경로
	var jrffile = "w_LBarcode_byitem.jrf";				// 리포트파일명
	var dsname = "";				// 데이타소스명
	var args = "SESSION_ID#84E9B96CAFBFAD142BD6B20FDC482C76#";	// 아규먼트 정보

	var isdeflater = "true";	// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함)
	var isbase64 = "true";		// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함)
	var isunicode = "false";	// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함)
	var utfdata = "true";		// 서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함)

	var scale = "-9999";	// 초기 배율
	var toolbar = "true";	// 툴바 보임 여부
	var margin = "true";	// 여백 표시 보임 여부
	var progress = "true";	// 프로그래스 바 보임 여부

	/* 플러그인용 변수 */
	var w_gap = 8; // 가로 크기 조정.
	var h_gap = 8; // 세로 크기 조정.

	/* 웹소켓용 변수 */
	var ws_viewer = null;										// 뷰어
	var ws_viewer_width = 600;									// 뷰어 너비
	var ws_viewer_height = screen.height - 200;					// 뷰어 높이
	var ws_viewer_left = (screen.width - ws_viewer_width)/2;	// 뷰어 좌측 위치
	var ws_viewer_top = (screen.height - ws_viewer_height)/2;	// 뷰어 상단 위치

	/* 실행 형태 설정 : 브라우저가 Edge이거나 Chrome(45이상)이면 플러그인으로 실행. ubiws.js 변수 사용 */
	var runPlugin = true;
	if( UbiWS_IsEdge || (UbiWS_IsChrome && UbiWS_GetBrowserVersion() > 44) ) {

		runPlugin = false;
	}


	/* 플러그인 초기화 및 미리보기 실행 */
	function UbiPlugin_Init() {

		if( viewertype == "MARKANY" ) {

			//마크애니 연동 시 마크애니 클라이언트 설치 설정이 필요함.
			//document.write("<OBJECT id='MAePageSAFER' classid='CLSID:4A3E00BC-05BB-4C6E-971E-BDAB21B044AA' width='0px' height='0px' codebase='./MAePageSAFERUB.cab#VERSION=5,0,10,1'><OBJECT>");
		}

		if( Ubi_PluginCheck() ) {

			var w = ((self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth)) - w_gap;
			var h = ((self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)) - h_gap;

			document.write("<object id='UbiViewer' type='" + Ubi_PluginType() + "' width='" + w + "px' height='" + h + "px'>");
			document.write("	<param name='ocxtype'				value='" + Ubi_ActiveXEdition() + "'>");
			document.write("	<param name='fileURL'				value='" + fileurl + "'>");
			document.write("	<param name='servletRootURL'		value='" + rooturl + "'>");
			document.write("	<param name='servletURL1'			value='" + formurl + "'>");
			document.write("	<param name='servletURL2'			value='" + dataurl + "'>");
			document.write("	<param name='jrfFileDir'			value='" + jrfdir + "'>");
			document.write("	<param name='jrfFileName'			value='" + jrffile + "'>");
			document.write("	<param name='dataSource'			value='" + dsname + "'>");

			document.write("	<param name='isDeflater'			value='" + isdeflater + "'>");
			document.write("	<param name='isBase64'				value='" + isbase64 + "'>");
			document.write("	<param name='isUnicode'				value='" + isunicode + "'>");
			document.write("	<param name='utfData'				value='" + utfdata + "'>");

			document.write("	<param name='scale'					value='" + scale + "'>");
			document.write("	<param name='toolbar'				value='" + toolbar + "'>");
			document.write("	<param name='margin'				value='" + margin + "'>");
			document.write("	<param name='progress'				value='" + progress + "'>");

			document.write("	<param name='execType'				value='TYPE4'>");	// 실행형태. 변경 불가.
			document.write("	<param name='fontRevision'			value='true'>");	// 폰트보정. 변경 불가.
			document.write("	<param name='printMarginRevision'	value='true'>");	// 출력보정. 변경 불가.

			if( viewertype == "BCQRE" || viewertype == "BCQREUNI" || viewertype == "MARKANY" ) {

				document.write("	<param name='ubiServerURL'			value='" + serverurl + "'>");
				document.write("	<param name='IsDrm'					value='false'>");	// DRM 사용 여부.
				document.write("	<param name='DocName'				value='default'>");	// DRM Config설정 확인
				document.write("	<param name='PageNames'				value='default$'>");// DRM Config설정 확인
				document.write("	<param name='CDPosition'			value='20,267'>");	// 복사방지마크 좌상단 위치.
				document.write("	<param name='BarcodePosition'		value='51,267'>");	// 2D 바코드 좌상단 위치.
			}
			document.write("</object>");
		}
	}

	/* 웹소켓 초기화 */
	function UbiWS_Init() {

		InitWebSocket(ShowReport);
	}

	/* 웹소켓 뷰어 미리보기 실행 */
	function ShowReport(ws) {
		
		ws_viewer = new UbiViewer(ws);

		ws_viewer.fileurl = fileurl;
		ws_viewer.servletrooturl = rooturl;
		ws_viewer.servleturl1 = formurl;
		ws_viewer.servleturl2 = dataurl;
		ws_viewer.jrffiledir = jrfdir;
		ws_viewer.jrffilename = jrffile;
		ws_viewer.datasource = dsname;

		ws_viewer.isdeflater = isdeflater;
		ws_viewer.isbase64 = isbase64;
		ws_viewer.isunicode = isunicode;
		ws_viewer.utfdata = utfdata;

		ws_viewer.scale = scale;
		ws_viewer.toolbar = toolbar;
		ws_viewer.margin = margin;
		ws_viewer.progress = progress;

		ws_viewer.fontrevision = "true";
		ws_viewer.printmarginrevision = "true";

		ws_viewer.arg = args;

		if( viewertype == "BCQRE" ) {

			ws_viewer.isdrm = 'true';
			ws_viewer.ubiserverurl = serverurl;
			ws_viewer.docname = 'default';
			ws_viewer.pagenames = 'default$';
			ws_viewer.cdposition = '20,267';
			ws_viewer.barcodeposition = '51,267';
			if( ws_viewer.isdrm == 'true' ) {

				ws_viewer.DrmStart();
			}
		}
		ws_viewer.setResize(ws_viewer_left, ws_viewer_top, ws_viewer_width, ws_viewer_height);
		ws_viewer.retrieve();
	}

	/* 아규먼트 값 설정. 리포트 조회 시 자동 호출. 플러그인 */
	function getArg() {

		return args;
	}

	/* 뷰어 로드 완료 후 호출. 플러그인 */
	function finishLoad() {

		Ubi_Version();
	}

	/* 뷰어 로드 완료 후 호출. 웹소켓 */
	function RetrieveEnd() {

		Ubi_Version();
	}

	/* 출력 완료 후 호출. 플러그인. 웹소켓 */
	function PrintEnd(status) {
/*
		if( runPlugin )
			Ubi_Alert("Print Status : " + document.getElementById("UbiViewer").getPrintStatus());
		else
			alert('Print Status : ' + status);
*/
	}

	/* 파일 저장 완료 후 호출. 플러그인. 웹소켓 */
	function ExportEnd(filepath) {
/*
		if( runPlugin )
			Ubi_Alert("File Path : " + document.getElementById("UbiViewer").GetVariable("exportFilePath"));
		else
			alert('File Path : ' + filepath);
*/
	}

	/* 뷰어 버전 확인. 플러그인. 웹소켓 */
	function Ubi_Version() {
/*
		if( runPlugin )
			Ubi_Alert("Plugin[ " + Ubi_Object.GetVersion() + " ] , OCX[ " + document.getElementById('UbiViewer').GetOcxVersion() + ", " + Ubi_ActiveXEdition() + " ]");
		else
			ws_viewer.aboutBox();
*/
	}

	/* 브라우저 리사이즈 시 뷰어 리사이즈 처리. 플러그인 */
	function Ubi_Resize() {

		if( runPlugin ) {

			var w = ((self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth)) - w_gap;
			var h = ((self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)) - h_gap;
			document.getElementById("UbiViewer").width = w + 'px';
			document.getElementById("UbiViewer").height = h + 'px';
		}
	}

//-->
</script>
</head>
<body style='margin:2px' onresize="Ubi_Resize()">
<script type="text/javascript">
<!--

	if( runPlugin ) {	// 플러그인 뷰어로 실행

		UbiPlugin_Init();
	}
	else {				// 웹소켓 뷰어로 실행

		UbiWS_Init();
	}

//-->
</script>
</body>
</html>
