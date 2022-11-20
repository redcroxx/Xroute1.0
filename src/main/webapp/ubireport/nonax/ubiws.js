//====================================================================================================
// 모든 변수와 함수는 JavaScript 응용 프로그램과의 충돌을 막기 위하여 UbiWS_ 로 시작.
//====================================================================================================

//----------------------------------------------------------------------------------------------------
// UbiViewerWS 정보. port, protocol 수정 불가
//----------------------------------------------------------------------------------------------------
var UbiWS_Name = "UbiViewerWS";
var UbiWS_Port = "6886";
var UbiWS_Protocol = "ubi-protocol";


//----------------------------------------------------------------------------------------------------
// Context / Viewer 설정.
//----------------------------------------------------------------------------------------------------
var UbiWS_App = "";
var UbiWS_ViewerType = "UNICODE";// UNICODE, BCQRE, BCQREUNICODE

var UbiWS_SetupFile = "Setup_UbiViewerWS.exe";
if( UbiWS_ViewerType == "BCQRE" ) {
	UbiWS_SetupFile = "Setup_UbiViewerWS_bcqre.exe";
}
else if( UbiWS_ViewerType == "BCQREUNICODE" ) {
	UbiWS_SetupFile = "Setup_UbiViewerWS_bcqreunicode.exe";
}
//var UbiWS_Version = "2, 502, 1703, 302";
var UbiWS_Version = "2, 502, 1903, 1401";
var UbiWS_Msg_Flag = 'D';		// 실행 대기 메시지, D:DIV형태, P:Popup Window 형태, 그 외는 메시지 보이지 않음.


//----------------------------------------------------------------------------------------------------
// 배포 설치본 관리
//----------------------------------------------------------------------------------------------------
var UbiWS_Host = self.location.host;
var UbiWS_BaseUrl = self.location.protocol + "//" + UbiWS_Host + (UbiWS_App==""?"":("/" + UbiWS_App));	// WebApplication URL.

var UbiWS_InstallPagePath = UbiWS_BaseUrl + "/ubireport/nonax/guide/ws_install.html";	// 미설치 시 제공되는 설치 페이지
var UbiWS_MessagePagePath = UbiWS_BaseUrl + "/ubireport/nonax/guide/ws_message.html";	// WS 실행 전 안내 페이지
var UbiWS_WarningPagePath = UbiWS_BaseUrl + "/ubireport/nonax/guide/ws_warning.html";	// WS 미지원 브라우저 안내 페이지
var UbiWS_SetupFilePath   = UbiWS_BaseUrl + "/ubireport/" + UbiWS_SetupFile;			// WS 설치 파일

var UbiWS_InstallFlag = false;

var UbiWS_Install_Guide_Msg = "";	// 설치 페이지 내용
var UbiWS_MessageDiv;
var UbiWS_MessageWindow;

var UbiWS_IsIE = /*@cc_on!@*/false || !!document.documentMode;
var UbiWS_IsIE10 = document.all && !window.atob;
var UbiWS_IsIE11 = navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1;
var UbiWS_IsEdge = navigator.userAgent.indexOf("AppleWebKit") >= 0 && navigator.userAgent.indexOf("Edge") != -1;
var UbiWS_IsOpera = !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
var UbiWS_IsFirefox = typeof InstallTrigger !== 'undefined';
var UbiWS_IsSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;
var UbiWS_IsChrome = !!window.chrome && !UbiWS_IsOpera;

var UbiWS_Match = navigator.userAgent.match(/(CrOS\ \w+|Windows\ NT|Mac\ OS\ X|Linux)\ ([\d\._]+)?/);
var UbiWS_Os = (UbiWS_Match || [])[1] || "Unknown";
var UbiWS_OsVersion = (UbiWS_Match || [])[2] || "Unknown";

var UbiWS_RS_ = String.fromCharCode(30);
var UbiWS_CS_ = String.fromCharCode(31);
var UbiWS_EOF_ = String.fromCharCode(27);
var UbiWS_VER_EOF_ = String.fromCharCode(29); // version check용 eof


//----------------------------------------------------------------------------------------------------
// 뷰어 객체 정보
//----------------------------------------------------------------------------------------------------
var UbiViewer = function(websocket) {

	var ws = websocket;
	
	// property
	this.fileurl = "";
	this.servleturl1 = "",
	this.servleturl2 = "",
	this.jrffiledir = "",
	this.jrffilename = "",
	this.datasource = "",
	this.scale = "100",
	this.resource = "fixed",
	this.invisibletoolbar = "",
	this.rowdim = "",
	this.coldim = "",
	this.margin = "",
	this.progress = "",
	this.toolbar = "",
	this.isdeflater = "true",
	this.isunicode = "false",
	this.utfdata = "true",
	this.isbase64 = "true",
	this.popupmenu = "",
	this.servletrooturl = "",
	this.exportfilename = "",
	this.exportds = "",
	this.invisibleexporttypes = "",
	this.isurf = "",
	this.printcopies = "1",
	this.printleftmargin = "",
	this.printtopmargin = "",
	this.isencrypt = "false",
	this.isencrypt64 = "false",
	this.ubiserverurl = "",
	this.barcodeposition = "",
	this.cdposition = "",
	this.docname = "",
	this.pagenames = "",
	this.isdrm = "",
	this.reportid = "",
	this.printmarginrevision = "",
	this.printsetmode = "",
	this.printpapersize = "",
	this.fontelement = "",
	this.reporttitle = "",
	this.printautofit = "",
	this.fontrevision = "true",
	this.exportsetmode = "",
	this.ismultireport = "false",
	this.multicount = "1",
	this.ispluginasync = "false",
	this.arg = "",
	this.reqtype = "retrieve",
	this.variable = "",
	this.resize = "",
	
	// method
	this.retrieve = function() {
		// UbiServer와 연결되어 있는 지 체크
		//if (this.checkWebSocket() == false)
		//	return;
		
		var propery = this.GetUbiProperty();
		var msg = "reqtype" + UbiWS_CS_ + "retrieve" + UbiWS_RS_ + propery;

		// SetVariable을 통해 설정한 속성
		if (this.variable != '') {
			msg += this.variable;
			this.variable = '';
		}
		
		if (this.resize != '') {
			//msg += this.resize;
			msg = this.resize + msg;
			this.resize = '';
		}
		
		this.ubiWS_Send(msg);
		UbiWS_Sleep(100);
	};
	
	this.RetrieveBind = function() {
		var propery = this.GetUbiProperty();
		var msg = "reqtype" + UbiWS_CS_ + "retrievebind" + UbiWS_RS_ + propery;

		//SetVariable을 통해 설정한 속성
		if (this.variable != '') {
			msg += this.variable;
			this.variable = '';
		}
		
		if (this.resize != '') {
			msg = this.resize + msg;
			this.resize = '';
		}
		
		this.ubiWS_Send(msg);
		sleep(100);
	};
	
	this.GetUbiProperty = function() {
	var msg = "isPluginAsync" + UbiWS_CS_ +	this.ispluginasync + UbiWS_RS_
			+ "isPlugin" + UbiWS_CS_ +	"true" + UbiWS_RS_
			+ "isencrypt" + UbiWS_CS_ +	this.isencrypt + UbiWS_RS_
			+ "isencrypt64" + UbiWS_CS_ +	this.isencrypt64 + UbiWS_RS_
			+ "fileurl" + UbiWS_CS_ +	this.fileurl + UbiWS_RS_
			+ "servleturl1" + UbiWS_CS_ +	this.servleturl1 + UbiWS_RS_
			+ "servleturl2" + UbiWS_CS_ +	this.servleturl2 + UbiWS_RS_
			+ "jrffiledir" + UbiWS_CS_ +	this.jrffiledir + UbiWS_RS_
			+ "jrffilename" + UbiWS_CS_ +	this.jrffilename + UbiWS_RS_
			+ "datasource" + UbiWS_CS_ +	this.datasource + UbiWS_RS_
			+ "scale" + UbiWS_CS_ +	this.scale + UbiWS_RS_
			+ "resource" + UbiWS_CS_ +	this.resource + UbiWS_RS_
			+ "invisibletoolbar" + UbiWS_CS_ +	this.invisibletoolbar + UbiWS_RS_
			+ "rowdim" + UbiWS_CS_ +	this.rowdim + UbiWS_RS_
			+ "coldim" + UbiWS_CS_ +	this.coldim + UbiWS_RS_
			+ "margin" + UbiWS_CS_ +	this.margin + UbiWS_RS_
			+ "progress" + UbiWS_CS_ +	this.progress + UbiWS_RS_
			+ "toolbar" + UbiWS_CS_ +	this.toolbar + UbiWS_RS_
			+ "isdeflater" + UbiWS_CS_ +	this.isdeflater + UbiWS_RS_
			+ "isunicode" + UbiWS_CS_ +	this.isunicode + UbiWS_RS_
			+ "utfdata" + UbiWS_CS_ +	this.utfdata + UbiWS_RS_
			+ "isbase64" + UbiWS_CS_ +	this.isbase64 + UbiWS_RS_
			+ "popupmenu" + UbiWS_CS_ +	this.popupmenu + UbiWS_RS_
			+ "servletrooturl" + UbiWS_CS_ +	this.servletrooturl + UbiWS_RS_
			+ "exportfilename" + UbiWS_CS_ +	this.exportfilename + UbiWS_RS_
			+ "exportds" + UbiWS_CS_ +	this.exportds + UbiWS_RS_
			+ "invisibleexporttypes" + UbiWS_CS_ +	this.invisibleexporttypes + UbiWS_RS_
			+ "isurf" + UbiWS_CS_ +	this.isurf + UbiWS_RS_
			+ "printcopies" + UbiWS_CS_ +	this.printcopies + UbiWS_RS_
			+ "printleftmargin" + UbiWS_CS_ +	this.printleftmargin + UbiWS_RS_
			+ "printtopmargin" + UbiWS_CS_ +	this.printtopmargin + UbiWS_RS_
			+ "reportid" + UbiWS_CS_ +	this.reportid + UbiWS_RS_
			+ "printmarginrevision" + UbiWS_CS_ +	this.printmarginrevision + UbiWS_RS_
			+ "printsetmode" + UbiWS_CS_ +	this.printsetmode + UbiWS_RS_
			+ "printpapersize" + UbiWS_CS_ +	this.printpapersize + UbiWS_RS_
			+ "reporttitle" + UbiWS_CS_ +	this.reporttitle + UbiWS_RS_
			+ "fontelement" + UbiWS_CS_ +	this.fontelement + UbiWS_RS_
			+ "printautofit" + UbiWS_CS_ +	this.printautofit + UbiWS_RS_
			+ "fontrevision" + UbiWS_CS_ +	this.fontrevision + UbiWS_RS_
			+ "exportsetmode" + UbiWS_CS_ +	this.exportsetmode + UbiWS_RS_
			+ "ismultireport" + UbiWS_CS_ +	this.ismultireport + UbiWS_RS_
			+ "multicount" + UbiWS_CS_ +	this.multicount + UbiWS_RS_
			+ "arg" + UbiWS_CS_ + this.arg + UbiWS_RS_;
		
		return msg;
	};
	
	this.ExportFile = function(s1) {
		
		var filetype = s1;
		var msg = "reqtype" + UbiWS_CS_ + ("exportfile#"+filetype) + UbiWS_RS_
				+ "exportfilename" + UbiWS_CS_ + this.exportfilename + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.exportset = function() {
		var msg = "reqtype" + UbiWS_CS_ + "exportset" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.exportReport = function(s1, s2, s3) {
		var jrffilename = s1;
		var args = s2;
		var exporttype = s3;
		
		var msg = "reqtype" + UbiWS_CS_ + "exportreport" + UbiWS_RS_
				+ "jrffilename" + UbiWS_CS_ + jrffilename + UbiWS_RS_
				+ "args" + UbiWS_CS_ + args + UbiWS_RS_
				+ "exporttype" + UbiWS_CS_ + exporttype + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.exportsetReport = function(s1, s2, s3) {
		var jrffilename = s1;
		var args = s2;
		var exporttype = s3;
		
		var msg = "reqtype" + UbiWS_CS_ + "exportsetreport" + UbiWS_RS_
				+ "jrffilename" + UbiWS_CS_ + jrffilename + UbiWS_RS_
				+ "args" + UbiWS_CS_ + args + UbiWS_RS_
				+ "exporttype" + UbiWS_CS_ + exporttype + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.print = function() {
		var msg = "reqtype" + UbiWS_CS_ + "print" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.printset = function() {
		var msg = "reqtype" + UbiWS_CS_ + "printset" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.directPrint = function() {
		var msg = "reqtype" + UbiWS_CS_ + "directprint" + UbiWS_RS_;
		this.ubiWS_Send(msg);
		UbiWS_Sleep(100);
		
		this.close();
	};
	
	this.printReport = function(s1, s2) {
		var jrffilename = s1;
		var args = s2;
		
		var msg = "reqtype" + UbiWS_CS_ + "printreport" + UbiWS_RS_
				+ "jrffilename" + UbiWS_CS_ + jrffilename + UbiWS_RS_
				+ "args" + UbiWS_CS_ + args + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.printReportResizing = function(s1, s2, s3) {
		var jrffilename = s1;
		var args = s2;
		var papersize = s3;
		
		var msg = "reqtype" + UbiWS_CS_ + "printreportresizing" + UbiWS_RS_
				+ "jrffilename" + UbiWS_CS_ + jrffilename + UbiWS_RS_
				+ "args" + UbiWS_CS_ + args + UbiWS_RS_
				+ "papersize" + UbiWS_CS_ + papersize + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.printsetReport = function(s1, s2, s3) {
		var jrffilename = s1;
		var args = s2;
		var pagenum = s3;
		
		var msg = "reqtype" + UbiWS_CS_ + "printsetreport" + UbiWS_RS_
				+ "jrffilename" + UbiWS_CS_ + jrffilename + UbiWS_RS_
				+ "args" + UbiWS_CS_ + args + UbiWS_RS_
				+ "pagenum" + UbiWS_CS_ + pagenum + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.SetDataset = function(s1, s2) {
		var dsid = s1;
		var dsdata = s2;
	
		var msg = "reqtype" + UbiWS_CS_ + "setdataset" + UbiWS_RS_
				+ dsid + "#" + dsdata;
		this.ubiWS_Send(msg);
	};
	
	this.DrmStart = function() {
		var msg = "reqtype" + UbiWS_CS_ + "drmstart" + UbiWS_RS_
				+ "isencrypt" + UbiWS_CS_ +	this.isencrypt + UbiWS_RS_
				+ "isencrypt64" + UbiWS_CS_ +	this.isencrypt64 + UbiWS_RS_
				+ "ubiserverurl" + UbiWS_CS_ +	this.ubiserverurl + UbiWS_RS_
				+ "barcodeposition" + UbiWS_CS_ +	this.barcodeposition + UbiWS_RS_
				+ "cdposition" + UbiWS_CS_ +	this.cdposition + UbiWS_RS_
				+ "docname" + UbiWS_CS_ +	this.docname + UbiWS_RS_
				+ "pagenames" + UbiWS_CS_ +	this.pagenames + UbiWS_RS_
				+ "isdrm" + UbiWS_CS_ +	this.isdrm + UbiWS_RS_;
		this.ubiWS_Send(msg);
		UbiWS_Sleep(200);
	};
	
	this.firstPage = function() {
		var msg = "reqtype" + UbiWS_CS_ + "firstpage" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.previousPage = function() {
		var msg = "reqtype" + UbiWS_CS_ + "previouspage" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.nextPage = function() {
		var msg = "reqtype" + UbiWS_CS_ + "nextpage" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.lastPage = function() {
		var msg = "reqtype" + UbiWS_CS_ + "lastpage" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.setPage = function(s1) {
		var page = s1;
		var msg = "reqtype" + UbiWS_CS_ + ("setpage#" + page) + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.zoomIn = function() {
		var msg = "reqtype" + UbiWS_CS_ + "zoomin" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.zoomOut = function() {
		var msg = "reqtype" + UbiWS_CS_ + "zoomout" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.LoadTemplet = function(s1) {
		var jrffilename = s1;
		var msg = "reqtype" + UbiWS_CS_ + ("loadtemplet#" + jrffilename) + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.SetVariable = function(s1, s2) {
		if (s1 == 'Nexacro.DatasetInfos' || s1 == 'Nexacro.DesignData' || s1 == 'Nexacro.RuntimeData') {	
			var msg = "reqtype" + UbiWS_CS_ + "setvariable_nexacro" + UbiWS_RS_
					+ (s1 + "#" + s2);
			this.ubiWS_Send(msg);
		}
		else if (s1 == 'exportfilename') {
			this.exportfilename = s2;
			var msg = "reqtype" + UbiWS_CS_ + "setvariable" + UbiWS_RS_
					+ ('exportFileName' + UbiWS_CS_ + s2 + UbiWS_RS_);
			this.ubiWS_Send(msg);
		}
		else {
			this.variable += (s1 + UbiWS_CS_ + s2 + UbiWS_RS_);	
		}
	};
	
	this.refresh = function() {
		var msg = "reqtype" + UbiWS_CS_ + "refresh" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.sendVariable = function() {
		if (this.variable == '')
			return;
		
		var msg = "reqtype" + UbiWS_CS_ + "setvariable" + UbiWS_RS_
					+ this.variable;
		this.ubiWS_Send(msg);
		this.variable = "";
	};
	
	// Viewer의 버전 정보를 확인한다.
	this.aboutBox = function() {
		var msg = "reqtype" + UbiWS_CS_ + "aboutbox" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.checkWebSocket = function() {
		// 0 : CONNECTING
		// 1 : OPEN
		// 2 : CLOSING
		// 3 : CLOSED
		if (ws.readyState != 1) {
			alert('UbiViewerWS\uc640 \uc5f0\uacb0\ub418\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4.');
			return false;
		}
		
		return true;
	};
	
	// UbiServerWS 전체에 대한 버전을 확인한다.
	this.checkVersion = function() {
//		var msg = "reqtype" + UbiWS_CS_ + "checkversion#" + UbiWS_Version + UbiWS_RS_ + UbiWS_VER_EOF_;
		var msg = "reqtype" + UbiWS_CS_ + "checkversion#" + UbiWS_Version + UbiWS_RS_ + UbiWS_VER_EOF_ + UbiWS_EOF_;
		ws.send(msg);
	};
	
	this.close = function() {
		var msg = "reqtype" + UbiWS_CS_ + "close" + UbiWS_RS_;
		this.ubiWS_Send(msg);
	};
	
	this.setResize = function(s1, s2, s3, s4) {
		// 최대화
		if (s2 == undefined && s3 == undefined && s4 == undefined) {
			var max = s1;
			this.resize = '';
			this.resize = "resize" + UbiWS_CS_ + (max + "#") + UbiWS_RS_;
		} else {
			var top = s1; // x
			var left = s2; // y
			var width = s3;
			var height = s4;
		
			this.resize = '';
			this.resize = "resize" + UbiWS_CS_ + (left + "#" + top + "#" + width + "#" + height + "#") + UbiWS_RS_;
		}
	};

	this.ubiWS_Send = function(msg) {
		msg += UbiWS_EOF_;
		ws.send(msg);
	};
	
};



//----------------------------------------------------------------------------------------------------
// 웹소켓 초기화
//----------------------------------------------------------------------------------------------------
var ws = null;
function InitWebSocket(callback) {
	
	if( UbiWS_Msg_Flag == 'D' )
		UbiWS_ShowDivMsg();
	else if( UbiWS_Msg_Flag == 'P' )
		UbiWS_ShowWindowMsg();

	if( !UbiWS_CheckSupportWS() ) {

		UbiWS_ShowWarningPage();
		return;
	}
	else {

		if( UbiWS_Install_Guide_Msg == "" ) {

			// 설치 페이지 처리 시 Warning 페이지처럼 처리가 되지 않아(크로스브라우징 권한 에러) 이와 같이 처리함.
			UbiWS_AjaxReq({
				url: UbiWS_InstallPagePath,
				onSuccess: function(val) {
					UbiWS_Install_Guide_Msg = val;
				}
			});
		}
	}

	var checkTimer = setTimeout(UbiWS_StopCheck, 60000);
	var cur_protocolName = window.location.protocol;
	
	if (!ws) {
		if (cur_protocolName === 'https:')
			ws = new WebSocket('wss://127.0.0.1:' + UbiWS_Port, UbiWS_Protocol);
		else
			ws = new WebSocket('ws://127.0.0.1:' + UbiWS_Port, UbiWS_Protocol);
		
	} else {
		if (callback) 
		{
			callback(ws);
		}
	}
	
	/*var ws = null;
	if (cur_protocolName === 'https:')
		ws = new WebSocket('wss://127.0.0.1:' + UbiWS_Port, UbiWS_Protocol);
	else
		ws = new WebSocket('ws://127.0.0.1:' + UbiWS_Port, UbiWS_Protocol);*/

	ws.onopen = function(e) {

		//alert('onopen');
		UbiWS_Sleep(200);
		UbiWS_InstallFlag = true;
		
		// version check
//		var checkmsg = "reqtype" + UbiWS_CS_ + "checkversion#" + UbiWS_Version + UbiWS_RS_ + UbiWS_VER_EOF_;
		var checkmsg = "reqtype" + UbiWS_CS_ + "checkversion#" + UbiWS_Version + UbiWS_RS_ + UbiWS_VER_EOF_ + UbiWS_EOF_;
		ws.send(checkmsg);
	};

	ws.onmessage = function(e) {
		var message = e.data;
		//alert('onmessage:' + message);
		var result = '';
		
		if( message.indexOf('RETRIEVEEND') != -1 ) {

			if( UbiWS_Msg_Flag == 'D' )
				UbiWS_CloseDivMsg();
			else if( UbiWS_Msg_Flag == 'P' )
				UbiWS_CloseWindowMsg();
			RetrieveEnd();
		}
		else if( message.indexOf('EXPORTEND') != -1 ) {
			result = message.substring(message.indexOf('#')+1, message.length);
			ExportEnd(result);
		}
		/*else if( message.indexOf('PRINTEND') != -1 ) {
			result = message.substring(message.indexOf('#')+1, message.length);
			PrintEnd(result);
		}*/
		else if( message.indexOf('CHECKVERSION') != -1 ) {
			result = message.substring(message.indexOf('#')+1, message.length);
			if( result == 'true' ) {	// 설치 OK. 미리보기

				if( callback ) {
					callback(ws);
				}
			}
			else {	// 업데이트 설치

				if( UbiWS_Msg_Flag == 'D' ) UbiWS_CloseDivMsg();
				if( UbiWS_Msg_Flag == 'P' ) UbiWS_CloseWindowMsg();
				UbiWS_ShowInstallPage(true);
			}
		}
	};
	
	ws.onerror = function(e) {	// 최초 설치

		if( UbiWS_Msg_Flag == 'D' ) UbiWS_CloseDivMsg();
		if( UbiWS_Msg_Flag == 'P' ) UbiWS_CloseWindowMsg();
		
		if (!UbiWS_InstallFlag)
			UbiWS_ShowInstallPage(false);
	};
	
	ws.onclose = function(e) {
	};
}



//----------------------------------------------------------------------------------------------------
// 실행 시 대기 안내 메시지를  DIV 형태로 보여주기.
//----------------------------------------------------------------------------------------------------
function UbiWS_ShowDivMsg() {

	var ubi_Message = "";
	UbiWS_AjaxReq({
		url: UbiWS_MessagePagePath,
		onSuccess: function(val) {
			ubi_Message = val;
		}
	});

	var win_doc = window.top.document;
	var browserWidth = ((self.innerWidth || (win_doc.documentElement && win_doc.documentElement.clientWidth) || win_doc.body.clientWidth));
	var browserHeight = ((self.innerHeight || (win_doc.documentElement && win_doc.documentElement.clientHeight) || win_doc.body.clientHeight));

	if( browserWidth < 600 ) browserWidth = 600;
	if( browserHeight < 250 ) browserHeight = 250;

	UbiWS_MessageDiv = win_doc.createElement('div');
	UbiWS_MessageDiv.id = 'ubi_message_div';
	UbiWS_MessageDiv.name = 'ubi_message_div';
	UbiWS_MessageDiv.style.position = 'absolute';
	UbiWS_MessageDiv.style.left = (browserWidth - 600)/2 + 'px';
	UbiWS_MessageDiv.style.top = (browserHeight - 250)/2 + 'px';
	UbiWS_MessageDiv.style.width = '600px';
	UbiWS_MessageDiv.style.height= '250px';
	UbiWS_MessageDiv.style.zIndex = 1000;
	UbiWS_MessageDiv.style.border = 'solid 1px #808080';
	UbiWS_MessageDiv.innerHTML = ubi_Message;
	UbiWS_MessageDiv.style.display = '';

	win_doc.body.appendChild(UbiWS_MessageDiv);
}



//----------------------------------------------------------------------------------------------------
// DIV 형태로 보여주는 메시지 닫기.
//----------------------------------------------------------------------------------------------------
function UbiWS_CloseDivMsg() {

	var win_doc = window.top.document;
	win_doc.body.removeChild(UbiWS_MessageDiv);
}



//----------------------------------------------------------------------------------------------------
// 실행 시 대기 안내 메시지를  팝업 윈도우 형태로 보여주기.
//----------------------------------------------------------------------------------------------------
function UbiWS_ShowWindowMsg() {

	var left = ( screen.width  - 600 )/2;
	var top  = ( screen.height - 250 )/2;
	UbiWS_MessageWindow = window.open(UbiWS_MessagePagePath, 'Message_UbiViewer_WS', 'left=' + left + 'px, top=' + top + 'px, width=600px, height=250px, toolbar=no, menubar=no, scrollbars=no, location=no, resizable=no, fullscreen=no, status=no');
}



//----------------------------------------------------------------------------------------------------
// 팝업 윈도우 형태로 보여주는 메시지 닫기.
//----------------------------------------------------------------------------------------------------
function UbiWS_CloseWindowMsg() {

	UbiWS_MessageWindow.close();
}



//----------------------------------------------------------------------------------------------------
// 설치 디자인을 가져와서 보여주기 / 설치 프로그램 다운로드
//----------------------------------------------------------------------------------------------------
function UbiWS_ShowInstallPage(isupgrade) {

	document.write("<div id='installDesign' style='position:absolute;left:0px;top:0px;width:100%;height:100%;z-index:99999999;'></div>");

	var sysInfo = navigator.userAgent;
	var UpgradeTitle = (isupgrade)?"업데이트":"설치";
	document.getElementById('installDesign').innerHTML = UbiWS_Install_Guide_Msg.replace(/{DOWNLOAD_URL}/g,UbiWS_SetupFilePath).replace(/{BROWSER_INFO}/g,sysInfo).replace(/{UPGRADE_TITLE}/g,UpgradeTitle);

	UbiWS_Sleep(1000);
}



//----------------------------------------------------------------------------------------------------
// 웹소켓 미지원 브라우저 안내 메시지 보여주기 (Edge, Chrome45~ 이외)
//----------------------------------------------------------------------------------------------------
function UbiWS_ShowWarningPage() {

	document.write("<div id='warningDesign' style='position:absolute;left:0px;top:0px;width:100%;height:100%;z-index:99999999;'></div>");

	UbiWS_AjaxReq({
		url: UbiWS_WarningPagePath,
		onSuccess: function(val) {
			var sysInfo = navigator.userAgent;
			document.getElementById('warningDesign').innerHTML = val.replace(/{BROWSER_INFO}/g,sysInfo);
		}
	});

	if( UbiWS_Msg_Flag == 'D' ) UbiWS_CloseDivMsg();
	if( UbiWS_Msg_Flag == 'P' ) UbiWS_CloseWindowMsg();
	UbiWS_Sleep(1000);
}



//----------------------------------------------------------------------------------------------------
// 웹소켓 지원 가능 여부 반환.
//----------------------------------------------------------------------------------------------------
function UbiWS_CheckSupportWS() {
	
	if (!window.WebSocket) {
		return false;
	}
	
	if (!UbiWS_CheckBrowser()) {
		return false;
	}
	
	return true;
};



//----------------------------------------------------------------------------------------------------
// OS/브라우저별 웹소켓 지원 가능 여부 반환.
//----------------------------------------------------------------------------------------------------
function UbiWS_CheckBrowser() {

    if (UbiWS_Os === 'Windows NT' && UbiWS_GetBrowser() === 'MSIE' && UbiWS_GetBrowserVersion() < 10) {
		//IE 10 이상 지원 가능합니다.
		//alert('IE 10 \uc774\uc0c1 \uc9c0\uc6d0 \uac00\ub2a5\ud569\ub2c8\ub2e4.');
        return false;
    }

    if (UbiWS_Os === 'Windows NT' && UbiWS_GetBrowser() === 'Chrome' && UbiWS_GetBrowserVersion() < 19) {
		//Chrome 19 이상 지원 가능합니다.
		//alert('Chrome 19 \uc774\uc0c1 \uc9c0\uc6d0 \uac00\ub2a5\ud569\ub2c8\ub2e4.');
        return false;
    }

    if (UbiWS_Os === 'Windows NT' && UbiWS_GetBrowser() === 'Firefox' && UbiWS_GetBrowserVersion() < 18) {
    	//Firefox 18 이상 지원 가능합니다.
		//alert('Firefox 18 \uc774\uc0c1 \uc9c0\uc6d0 \uac00\ub2a5\ud569\ub2c8\ub2e4.');
        return false;
    }

    if (UbiWS_Os === 'Windows NT' && UbiWS_GetBrowser() === 'Safari') {
    	//해당 os의 Safari 미지원
		//alert('\ud574\ub2f9 os\uc758 Safari \ubbf8\uc9c0\uc6d0');
        return false;
    }

    if (UbiWS_Os === 'Windows NT' && UbiWS_GetBrowser() === 'Opera' && UbiWS_GetBrowserVersion() < 15) {
    	//Opera 15 이상 지원 가능
		//alert('Opera 15 \uc774\uc0c1 \uc9c0\uc6d0 \uac00\ub2a5\ud569\ub2c8\ub2e4.');
        return false;
    }
	 
	if (UbiWS_Os === 'Mac OS X' || UbiWS_Os === 'Linux') {
		//Mac OS 또는 Linux는 현재 지원하지 않습니다.
		//alert('Mac OS \ub610\ub294 Linux\ub294 \ud604\uc7ac \uc9c0\uc6d0\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4.');
		return false;
		//alert("os :" + os + ", UbiWS_GetBrowser :" + UbiWS_GetBrowser() + ", UbiWS_GetBrowserVersion :" +  UbiWS_GetBrowserVersion() +", vstrDownURL :" +  vstrDownURL);        
    }

	return true;
}



//----------------------------------------------------------------------------------------------------
// 지연 시간 발생.
//----------------------------------------------------------------------------------------------------
function UbiWS_Sleep(delay) {

    var start = new Date().getTime();
    while (new Date().getTime() < start + delay);
}



//----------------------------------------------------------------------------------------------------
// 브라우저명 반환.
//----------------------------------------------------------------------------------------------------
function UbiWS_GetBrowser() {

    var ua = navigator.userAgent, tem, M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
    if (/trident/i.test(M[1])) {
        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
        return 'MSIE';
    }
    if (M[1] === 'Chrome') {
        tem = ua.match(/\bOPR\/(\d+)/)
        if (tem != null) {
            return 'Opera';
        }
    }
    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
    if ((tem = ua.match(/version\/(\d+)/i)) != null) {
        M.splice(1, 1, tem[1]);
    }
    return M[0];
}



//----------------------------------------------------------------------------------------------------
// 브라우저 버전 반환.
//----------------------------------------------------------------------------------------------------
function UbiWS_GetBrowserVersion() {

    var ua = navigator.userAgent, tem, M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
    
    if (/trident/i.test(M[1])) {
        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
        return tem[1];
    }
    if (M[1] === 'Chrome') {
        tem = ua.match(/\bOPR\/(\d+)/)
        if (tem != null) {
            return tem[1];
        }
    }
    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
    if ((tem = ua.match(/version\/(\d+)/i)) != null) {
        M.splice(1, 1, tem[1]);
    }
    return M[1];
}



//----------------------------------------------------------------------------------------------------
// 설치여부 체크 후 처리.
//----------------------------------------------------------------------------------------------------
function UbiWS_StopCheck() {

	if( !UbiWS_InstallFlag ) {

		if( UbiWS_Msg_Flag == 'D' ) UbiWS_CloseDivMsg();
		if( UbiWS_Msg_Flag == 'P' ) UbiWS_CloseWindowMsg();
		UbiWS_ShowInstallPage(false);
	}
}



//----------------------------------------------------------------------------------------------------
// 디자인 가져오기
//----------------------------------------------------------------------------------------------------
function UbiWS_AjaxReq(options) {
	options={type: options.type || "GET", url: options.url || "", onComplete: options.onComplete || function(){}, onSuccess: options.onSuccess || function(){}};
	if(typeof XMLHttpRequest == "undefined"){XMLHttpRequest = function() {return new ActiveXObject(navigator.userAgent.indexOf("MSIE 5") >= 0 ? "Microsoft.XMLHTTP" : "Msxml2.XMLHTTP");};}

	var xml = new XMLHttpRequest();
	xml.open(options.type, options.url, false);	//sync
//	xml.open(options.type, options.url, true);	//async
	var requestDone = false;
	setTimeout(function() {requestDone = true;}, 20000);
	xml.onreadystatechange = function() {if( xml.readyState == 4 && !requestDone) {if(httpSuccess(xml) ) {options.onSuccess(xml.responseText);}options.onComplete();xml = null;}};
	xml.send();
	function httpSuccess(r) {
		try{return (!r.status && location.protocol == "file:") ||(r.status >= 200 && r.status < 300) || r.status == 304 || navigator.userAgent.indexOf("Safari") >= 0 && typeof r.status == "undefined;";}catch(e){}
		return false;
	}
}





//====================================================================================================
// 맥어드레스 체크 관련 내용
//====================================================================================================
var UbiWS_MacAddress = '';
function InitGetMacAddress() {

	if( UbiWS_Msg_Flag == 'D' )
		UbiWS_ShowDivMsg();
	else if( UbiWS_Msg_Flag == 'P' )
		UbiWS_ShowWindowMsg();

	if( !UbiWS_CheckSupportWS() ) {

		UbiWS_ShowWarningPage();
		return;
	}
	else {

		if( UbiWS_Install_Guide_Msg == "" ) {

			// 설치 페이지 처리 시 Warning 페이지처럼 처리가 되지 않아(크로스브라우징 권한 에러) 이와 같이 처리함.
			UbiWS_AjaxReq({
				url: UbiWS_InstallPagePath,
				onSuccess: function(val) {
					UbiWS_Install_Guide_Msg = val;
				}
			});
		}
	}
	
	var checkTimer = setTimeout(UbiWS_StopCheck, 60000);
	var cur_protocolName = window.location.protocol;
	
	var ws_mac = null;
	if (cur_protocolName === 'https:')
		ws_mac = new WebSocket('wss://127.0.0.1:' + UbiWS_Port, UbiWS_Protocol);
	else
		ws_mac = new WebSocket('ws://127.0.0.1:' + UbiWS_Port, UbiWS_Protocol);
	
	ws_mac.onopen = function(e) {

		UbiWS_Sleep(200);
		UbiWS_InstallFlag = true;
		
		// get Mac Address
		var msg = "reqtype" + UbiWS_CS_ + "getmac" + UbiWS_RS_ + UbiWS_EOF_;
		ws_mac.send(msg);
	};
	
	ws_mac.onmessage = function(e) {
		var message = e.data;
		UbiWS_SetMacAddress(message);
	};
	
	ws_mac.onerror = function(e) {
	};
	
	ws_mac.onclose = function(e) {
	};
}

function UbiWS_GetMacAddress() {

	return UbiWS_MacAddress;
}

function UbiWS_SetMacAddress(message) {
	
	UbiWS_MacAddress = message;
}
