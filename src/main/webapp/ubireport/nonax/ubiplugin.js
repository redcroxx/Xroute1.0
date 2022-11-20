//====================================================================================================
// 모든 변수와 함수는 JavaScript 응용 프로그램과의 충돌을 막기 위하여 Ubi_ 로 시작.
//====================================================================================================

//----------------------------------------------------------------------------------------------------
// Context / Viewer 설정
//----------------------------------------------------------------------------------------------------
var Ubi_App = "";
var Ubi_ViewerType = "UNICODE";				// UNICODE / BCQRE / BCQREUNI / MARKANY

var Ubi_PluginFile = "UbiViewer.exe";		// 플러그인 통합설치 파일명
var Ubi_ViewerFile = "UbiViewerXUniP.cab";	// 뷰어 파일명

if( Ubi_ViewerType == "BCQRE" ) {
	Ubi_PluginFile = "UbiViewerBcqre.exe";
	Ubi_ViewerFile = "UbiViewerXBcqreP.cab";
}
else if( Ubi_ViewerType == "BCQREUNI" ) {
	Ubi_PluginFile = "UbiViewerBcqreUni.exe";
	Ubi_ViewerFile = "UbiViewerXBcqreUniP.cab";
}
else if( Ubi_ViewerType == "MARKANY" ) {
	Ubi_PluginFile = "UbiViewerMarkAny.exe";
	Ubi_ViewerFile = "UbiViewerXMarkAnyP.cab";
}
var Ubi_PluginVersion = "2.502.1703.302";
var Ubi_ViewerVersion = "2.502.1703.302";	 // 뷰어 파일 버전

var Ubi_IE_AutoDownload = false;	// 미설치시 설치화면에서 자동으로 다운로드할지의 여부 ( true : 설치화면으로 이동시 자동으로 다운로드 실행  / false : 다운로드 클릭 버튼을 이용해야만 다운로드 )
var Ubi_IE_AutoInstall = false;	// IE 에서 설치 후 새로고침 자동 여부 ( true : F5 나 새로고침 누를 필요가 없이 바로 리포트 표시한다. IE만 해당되며, GET 방식 화면에서만 지원된다. / false : F5 나 새로고침 누르라는 이미지가 표시된다.(IE 도 FireFox 나 크롬 처럼 동일하게 동작)



//----------------------------------------------------------------------------------------------------
// 배포 설치본 관리
//----------------------------------------------------------------------------------------------------
var Ubi_Host = self.location.host;
var Ubi_BaseUrl = self.location.protocol + "//" + Ubi_Host + (Ubi_App==""?"":("/" + Ubi_App));	// WebApplication URL.

var Ubi_InstallPagePath = Ubi_BaseUrl + "/ubireport/nonax/guide/plugin_install.html";	// 미설치 시 제공되는 설치 페이지
var Ubi_WarningPagePath = Ubi_BaseUrl + "/ubireport/nonax/guide/plugin_warning.html";	// 플러그인 미지원 브라우저 사용 시 안내 페이지
var Ubi_InstallImagePath = Ubi_BaseUrl + "/ubireport/nonax/guide";						// 제공되는 설치 페이지에서 사용되는 이미지 경로
var Ubi_InstallPath = Ubi_BaseUrl + "/ubireport/" + Ubi_PluginFile;		// 플러그인 통합본 설치
var Ubi_InstallCabPath = Ubi_BaseUrl + "/ubireport/" + Ubi_ViewerFile;	// 뷰어 파일 설치

var Ubi_UpdateXml = "";
Ubi_UpdateXml += "<update>";
Ubi_UpdateXml += "<file title='UbiViewer' url='" + Ubi_InstallCabPath + "' version='" + Ubi_ViewerVersion + "'/>";
Ubi_UpdateXml += "</update>";



//----------------------------------------------------------------------------------------------------
// 안내 메세지
//----------------------------------------------------------------------------------------------------
var Ubi_HelpSafari = "ㆍSafari 브라우저에서는 설치후에 브라우저를 닫았다가 <font color='#ff6600'>다시 접속</font>하시기 바랍니다.<br>";
var Ubi_HelpFireFox = "ㆍFireFox 브라우저에서 실행 권한을 요구하는 경우 반드시 <font color='#ff6600'>[허가]→[허가하고 기억]</font> 버튼을 차례대로 눌러주십시오.<br>ㆍ설치가 안된다면 플러그인 차단 여부를 확인해 주십시오.<br>";
var Ubi_HelpChrome = "ㆍChrome 브라우저에서 실행 권한이 필요하다고 요구하는 경우 반드시 <font color='#ff6600'>[이 사이트에서 항상 실행]</font> 버튼을 눌러주십시오.<br>ㆍ설치가 안된다면 플러그인 차단 여부를 확인해 주십시오.<br>";
var Ubi_HelpOpera = "ㆍOpera 브라우저입니다. 다운로드 받은 파일을 직접 실행하여 주십시오.<br>";
var Ubi_HelpIE = "ㆍIE 브라우저에서 파일 다운로드가 차단된 경우 [직접 다운로드] 로 실행하여 주십시오.<br>";



//----------------------------------------------------------------------------------------------------
// 안내 메세지 이미지
//----------------------------------------------------------------------------------------------------
var Ubi_HelpRefresh = "<table width='100%' height='100%' style='z-index:99999999;'><tr><td align='center'><img src='"+Ubi_InstallImagePath+"/complete.png'></td></tr></table>";
var Ubi_Help64bit = "<table width='100%' height='100%' style='z-index:99999999;'><tr><td align='center'><img src='"+Ubi_InstallImagePath+"/64bit.png'></td></tr></table>";



//====================================================================================================
// 플러그인 모듈 관리 프로그램 - 아래를 수정하거나 지우지 마십시오.
//====================================================================================================
var Ubi_CurrentInstalledVersion = "";
var Ubi_Object = null;
var Ubi_PluginId = "UbiViewerPlugin";
var Ubi_IsUpgrade = false;

var Ubi_IsIE = /*@cc_on!@*/false || !!document.documentMode;
var Ubi_IsIE10 = document.all && !window.atob;
var Ubi_IsIE11 = navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1;
var Ubi_IsEdge = navigator.userAgent.indexOf("AppleWebKit") >= 0 && navigator.userAgent.indexOf("Edge") != -1;
var Ubi_IsOpera = !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
var Ubi_IsFirefox = typeof InstallTrigger !== 'undefined';
var Ubi_IsSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;
var Ubi_IsChrome = !!window.chrome && !Ubi_IsOpera;



//----------------------------------------------------------------------------------------------------
// 플러그인의 설치가 필요하면 설치를 유도한다.
//----------------------------------------------------------------------------------------------------
function Ubi_PluginCheck() {

	if( Ubi_IsNotAvailableBrowser() ) {

		Ubi_ShowWarningPage();	// 플러그인 미지원 브라우져 안내 페이지로 이동
	}
	else {

		if( Ubi_InstallCheck(Ubi_PluginChecker(), "UbiDecision.UbiViewerPlugin.1") ) {

			if( Ubi_UpgradeCheck() ) {

				Ubi_UpdateCheck();
				return true;
			}
			else {

				Ubi_ShowInstallPage(true);	// 플러그인 설치 버전 업데이트로 인해 설치 페이지로 이동
			}
		}
		else {

			Ubi_ShowInstallPage(false);		// 플러그인 미설치로 인해 설치 페이지로 이동
			if( !Ubi_IsUpgrade ){

				setTimeout(function(){Ubi_WaitForInstall(true);},1000);
			}
		}
	}
}



//----------------------------------------------------------------------------------------------------
// 플러그인 미지원 브라우져 여부
//----------------------------------------------------------------------------------------------------
function Ubi_IsNotAvailableBrowser() {

	// Edge or Chrome 45 이상 버전이면 플러그인 미지원 브라우져
	if( Ubi_IsEdge || ( Ubi_IsChrome && Ubi_GetBrowserVersion() > 44 ) )
		return true;
	return false;
}



//----------------------------------------------------------------------------------------------------
// 플러그인 미지원 브라우저 안내 메시지 보여주기 (Edge, Chrome45~)
//----------------------------------------------------------------------------------------------------
function Ubi_ShowWarningPage() {

	document.write("<div id='warningDesign' style='position:absolute;left:0px;top:0px;width:100%;height:100%;z-index:99999999;'></div>");
	Ubi_AjaxReq({
		url: Ubi_WarningPagePath,
		onSuccess: function(val) {
			var sysInfo = navigator.userAgent;
			document.getElementById('warningDesign').innerHTML = val.replace(/{BROWSER_INFO}/g,sysInfo);
		}
	});
}



//----------------------------------------------------------------------------------------------------
// 플러그인의 설치 버전 체크
//----------------------------------------------------------------------------------------------------
function Ubi_InstallCheck(mimetype, progid) {

	document.write("<iframe id='checkFrame' style='position:absolute;left:-100px;top:-100px;width:1px;height:1px;'></iframe>");
	document.write("<object id='" + Ubi_PluginId + "' type='"+Ubi_PluginChecker()+"' width='1px' height='1px' style='position:absolute;left:-1000px;top:-1000px;visibility:hidden'></object>");
	Ubi_Object = document.getElementById(Ubi_PluginId);
	try {

		Ubi_CurrentInstalledVersion = Ubi_Object.GetVersion();
		return true; // 설치버전 있음
	}
	catch(e) {

		return false; // 설치안됨
	}
	return false;
}



//----------------------------------------------------------------------------------------------------
// 플러그인의 업그레이드 버전 체크
//----------------------------------------------------------------------------------------------------
function Ubi_UpgradeCheck() {

	if( Ubi_PluginVersion == Ubi_CurrentInstalledVersion )
		return true;

	Ubi_CurrentInstalledVersion = Ubi_CurrentInstalledVersion.replace(/,/gi, ".");
	var ver1 = Ubi_CurrentInstalledVersion.split(".");
	var ver2 = Ubi_PluginVersion.split(".");
	if( parseInt(ver1[0])>parseInt(ver2[0]) ) {return true;}
	else if( parseInt(ver1[0])<parseInt(ver2[0]) ) {return false;}
	else if( parseInt(ver1[1])>parseInt(ver2[1]) ) {return true;}
	else if( parseInt(ver1[1])<parseInt(ver2[1]) ) {return false;}
	else if( parseInt(ver1[2])>parseInt(ver2[2]) ) {return true;}
	else if( parseInt(ver1[2])<parseInt(ver2[2]) ) {return false;}
	else if( parseInt(ver1[3])>parseInt(ver2[3]) ) {return true;}
	return false;
}



//----------------------------------------------------------------------------------------------------
// 플러그인의 모듈 업데이트 체크
//----------------------------------------------------------------------------------------------------
function Ubi_UpdateCheck() {

	var xmlDoc;
	var url;
	var title;
	var version;

	var XML = "";
	var resultXML = '';

	if( Ubi_IsIE ) {

		xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
		xmlDoc.async=false;
		xmlDoc.loadXML(Ubi_UpdateXml);
	}
	else {

		if( window.DOMParser ) {

			parser=new DOMParser();
			xmlDoc=parser.parseFromString(Ubi_UpdateXml,"text/xml");
		}
	}

	if( xmlDoc ) {

		for( i=0;i<xmlDoc.getElementsByTagName("file").length;i++ ) {

			title = xmlDoc.getElementsByTagName("file")[i].attributes[0].value; // title
			try {
				url = xmlDoc.getElementsByTagName("file")[i].attributes['url'].value; // url
				version = xmlDoc.getElementsByTagName("file")[i].attributes['version'].value; // version
			}
			catch(e) {
				url = xmlDoc.getElementsByTagName("file")[i].attributes[1].value; // url
				version = xmlDoc.getElementsByTagName("file")[i].attributes[2].value; // version
			}

			var result = Ubi_UpdateCheckVersion(Ubi_Object.getFileVersion(url.substring(url.lastIndexOf("/")+1,url.length)), version);

			if( result==false ) {

				XML += "<file title='"+title+"' url='"+url+"'>";
			}
		}
		resultXML = "<update>"+XML+"</update>";
	}

	if( XML=='' ) {

		return true;//업글없이 바로 표시
	}
	else {

		Ubi_Object.setUpdateXml(resultXML);
		return false;
	}
}



//----------------------------------------------------------------------------------------------------
// 설치 디자인을 가져와서 보여주기 / 설치 프로그램 다운로드
//----------------------------------------------------------------------------------------------------
function Ubi_ShowInstallPage(isupgrade) {

	Ubi_IsUpgrade = isupgrade;
	document.write("<div id='installDesign' style='position:absolute;left:0px;top:0px;width:100%;height:100%;z-index:99999999;'></div>");
	
	if(navigator.userAgent.indexOf('x64')>-1 && navigator.userAgent.indexOf('Win64')>-1) {

		document.getElementById('installDesign').innerHTML = Ubi_Help64bit;
	}
	else {

		if(Ubi_IE_AutoDownload) {

			document.write("<iframe id='frameDownload' src='"+Ubi_InstallPath+"' style='position:absolute;left:-100px;top:1px;width:10px;height:10px;'></iframe>");
		}

		Ubi_AjaxReq({
			url: Ubi_InstallPagePath,
			onSuccess: function(val) {
				var sysInfo = navigator.userAgent;
				var InstallGuide = Ubi_GetInstallGuide(Ubi_IsUpgrade); //업그레이드 설치
				var UpgradeTitle = (isupgrade)?"재설치":"설치";
				document.getElementById('installDesign').innerHTML = val.replace(/{DOWNLOAD_URL}/g,Ubi_InstallPath).replace(/{BROWSER_INFO}/g,sysInfo).replace(/{INSTALL_GUIDE}/g,InstallGuide).replace(/{UPGRADE_TITLE}/g,UpgradeTitle);
			}
		});
	}
}



//----------------------------------------------------------------------------------------------------
// 뷰어 버전 업데이트 유무 반환
//----------------------------------------------------------------------------------------------------
function Ubi_UpdateCheckVersion(cur, last) {

	last = last.replace(/,/gi, ".");

	if(last == cur) return true;
	var ver1 = cur.split(".");
	var ver2 = last.split(".");

	if(parseInt(ver1[0])>parseInt(ver2[0])) {return true;}
	else if(parseInt(ver1[0])<parseInt(ver2[0])) {return false;}
	else if(parseInt(ver1[1])>parseInt(ver2[1])) {return true;}
	else if(parseInt(ver1[1])<parseInt(ver2[1])) {return false;}
	else if(parseInt(ver1[2])>parseInt(ver2[2])) {return true;}
	else if(parseInt(ver1[2])<parseInt(ver2[2])) {return false;}
	else if(parseInt(ver1[3])>parseInt(ver2[3])) {return true;}
	return false;
}



//----------------------------------------------------------------------------------------------------
// 플러그인 버전 체크 모듈명 반환
//----------------------------------------------------------------------------------------------------
function Ubi_PluginChecker() {

	return "application/x-ubiviewerplugin";
}


//----------------------------------------------------------------------------------------------------
// 플러그인 모듈명 반환
//----------------------------------------------------------------------------------------------------
function Ubi_PluginType() {

	return "application/x-ubiviewer";
}



//----------------------------------------------------------------------------------------------------
// 설치여부 파악
//----------------------------------------------------------------------------------------------------
function Ubi_WaitForInstall(isFirst) {

	var doc = document.getElementById('checkFrame').contentWindow.document;
	var checkScript = "";
	checkScript += "<html><head><title></title>";
	checkScript += "</head><body><object id='checkObj' type='"+Ubi_PluginChecker()+"' width='1px' height='1px'></object>";
	checkScript += "<script type='text/javascript'>try{var Ubi_InstallCheckVersion='';Ubi_InstallCheckVersion=document.getElementById('checkObj').GetVersion();}catch(e){}";
	checkScript += "<"+"/script>";
	checkScript += "</body></html>";

	doc.open();
	doc.write(checkScript);
	doc.close();

	var checkResult = document.getElementById('checkFrame').contentWindow.Ubi_InstallCheckVersion;
	if( Ubi_IsUpgrade == false && checkResult != '' ) {

		if(document.getElementById('installDesign')) {

			document.getElementById('installDesign').innerHTML = Ubi_HelpRefresh;
		}
		if(Ubi_IsIE && Ubi_IE_AutoInstall) {

			try {

				document.location.href = document.location.href;
			}
			catch(e) {}
		}
	}
	else {

		setTimeout(function(){Ubi_WaitForInstall(false)},1000); // 더 기다려야됨.
	}
}



//----------------------------------------------------------------------------------------------------
// 브라우저별 설치 가이드 얻기
//----------------------------------------------------------------------------------------------------
function Ubi_GetInstallGuide(isupgrade) {

	if(Ubi_IsSafari){return Ubi_HelpSafari;}
	if(Ubi_IsFirefox){return Ubi_HelpFireFox;}
	if(Ubi_IsChrome){return Ubi_HelpChrome;}
	if(Ubi_IsOpera){return Ubi_HelpOpera;}
	if(Ubi_IsIE){return Ubi_HelpIE;}
	return "";
}



//----------------------------------------------------------------------------------------------------
// 브라우저 버전을 반환한다.
//----------------------------------------------------------------------------------------------------
function Ubi_GetBrowserVersion() {

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
// 디자인 가져오기
//----------------------------------------------------------------------------------------------------
function Ubi_AjaxReq(options) {

	options={type: options.type || "POST", url: options.url || "", onComplete: options.onComplete || function(){}, onSuccess: options.onSuccess || function(){}};
	if(typeof XMLHttpRequest == "undefined"){XMLHttpRequest = function() {return new ActiveXObject(navigator.userAgent.indexOf("MSIE 5") >= 0 ? "Microsoft.XMLHTTP" : "Msxml2.XMLHTTP");};}
	var xml = new XMLHttpRequest();
	xml.open(options.type, options.url, true);
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
// 외부에서 사용되는 함수.
//====================================================================================================

//----------------------------------------------------------------------------------------------------
// 브라우저별로 메세지를 안전하게 표시한다.
//----------------------------------------------------------------------------------------------------
function Ubi_Alert(msg, title) {

	if( Ubi_IsIE ) {

		alert(msg); // IE 는 alert 함수 그대로 이용.
	}
	else {

		if(!title) {

			title='UbiReport';
		}
		var obj = document.createElement("div");
		var objtag = "<object id='UbiViewerPluginVersion' type='"+Ubi_PluginType()+"' width='1' height='1' style='display:hidden'></object>";
		obj.innerHTML = objtag;
		document.documentElement.appendChild(obj);

		Ubi_CurrentInstalledVersion = document.getElementById('UbiViewerPluginVersion').Alert(msg,title); //브라우저 특성상 내부 메세지 창 이용
		document.documentElement.removeChild(obj);
	}
}



//----------------------------------------------------------------------------------------------------
// 뷰어 타입 반환
//----------------------------------------------------------------------------------------------------
function Ubi_ActiveXEdition() {

	var cab_edition = "";
	if( Ubi_UpdateXml.indexOf("UbiViewerXP.cab")>=0 ) {
		cab_edition = "MBCS";
	}
	else if( Ubi_UpdateXml.indexOf("UbiViewerXUniP.cab")>=0 ) {
		cab_edition = "UNICODE";
	}
	else if( Ubi_UpdateXml.indexOf("UbiViewerXMarkAnyP.cab")>=0 ) {
		cab_edition = "MARKANY";
	}
	else if( Ubi_UpdateXml.indexOf("UbiViewerXBcqreP.cab")>=0 ) {
		cab_edition = "BCQRE";
	}
	else if( Ubi_UpdateXml.indexOf("UbiViewerXBcqreUniP.cab")>=0 ) {
		cab_edition = "BCQREUNI";
	}
	return cab_edition;
}



//----------------------------------------------------------------------------------------------------
// 이벤트 추가.
//----------------------------------------------------------------------------------------------------
function Ubi_AddEvent(obj, name, func) {

	if(obj) {
		if(obj.attachEvent) {
			obj.attachEvent("on"+name,func);
		}
		else{ obj.addEventListener(name,func,false);
		}
	}
}
