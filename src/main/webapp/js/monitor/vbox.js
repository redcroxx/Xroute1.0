var _vbox_builderpath = "..";


try {
	if (vbd) {}
} catch (e) {
	vbd = false;
};


var jsscript = {
    default_path: getPath(),
    setPath: function (url) {
        this.default_path = url;
    },
	initfun : function(){
		var omap = getPath("omap");
		var gmap = getPath("gmap");
		if(omap == 1){
			this.jsInclude("js","OpenLayers.js");
		}
		if(gmap == 1){
			this.jsInclude("webjs","http://maps.google.com/maps/api/js?sensor=false&language=ko");
		}
	},
    jsInclude: function () {

        var jsList = this.jsInclude.arguments;
        var linkurl = this.default_path;

        var loc = window.location;
		if (loc.protocol == "file:") {
			if(_vbox_builderpath != "null"){
				linkurl  = getPath(); //_vbox_builderpath;
			}
		}

        for (var i = 1; i < jsList.length; i++) {
		
			var tagJS = "<script languge=\"javascript\"";
			var tagCss = "<link rel=\"stylesheet\" type=\"text/css\" media=\"screen\"";
		
            if (jsList[0] == "js") {
                tagJS += " src=\"" + linkurl  + "/js/" + jsList[i] + "\"></script>";
                document.write(tagJS);
            } else if (jsList[0] == "css") {
				if((vbd == false && jsList[i].indexOf("temp.css")>-1)){
				}else{
					tagCss += " id=\"c_" + i + "\" href=\"" + linkurl   + "/css/" + jsList[i] + "\">";		
					document.write(tagCss);					
				}			
            } else if (jsList[0] == "rootjs") {
                tagJS += " src=\"" + linkurl   + "/" + jsList[i] + "\"></script>";
                document.write(tagJS);
            }else  if (jsList[0] == "pjs") {
                tagJS += " src=\"" + this.default_path+ "js/" + jsList[i] + "\"></script>";
                document.write(tagJS);
            } else if (jsList[0] == "pcss") {
                tagCss += " href=\"" + this.default_path+ "css/" + jsList[i] + "\">";
                document.write(tagCss);
             }else  if (jsList[0] == "webjs") {
                tagJS += " src=\"" +  jsList[1] + "\"></script>";
                document.write(tagJS);
			}
        }
    }
}

function getPath(arg) {

    var rtn = "";//"../js/"
	
	var strurl="";
    var scriptList = document.getElementsByTagName("script");
    for (var i = 0; i < scriptList.length; i++) {
		var vboxlen =  scriptList[i].src.lastIndexOf("js/vbox.js");
        if (vboxlen > 0) {
			rtn = scriptList[i].src.substr(0,vboxlen);
			strurl = scriptList[i].src.substr(vboxlen,scriptList[i].src.length-1).split("?");
        }
    }
	
	if(arg != null){
		rtn = "";
		if(strurl[1]!=null){
				rtn = getQueryVariable(strurl[1], arg);
		}
	}

    return rtn;
}

function getQueryVariable(query, name) {
    if (query.indexOf("?") == 0) { query = query.substr(1); }
    var pairs = query.split("&");
    for (var i = 0; i < pairs.length; i++) {
        var pair = pairs[i].split("=");
        if (pair[0] == name) {
            return pair[1];
        }
    }
    return "";
}

jsscript.jsInclude("css", "monitor/jquery-ui-1.8.23.custom.css", "monitor/skin/ui.dynatree.css","monitor/temp.css");
jsscript.jsInclude("css", "monitor/global.css","monitor/theme.css");

jsscript.initfun();
jsscript.jsInclude("js", "monitor/jquery-1.9.1.js", "monitor/jquery-ui-1.10.3.custom.js","highcharts/highcharts.js");
jsscript.jsInclude("js", "monitor/jquery.vbox.service.js");
jsscript.jsInclude("js", "monitor/jquery.vbox.component.js", "monitor/jquery.vbox.component2.js");
jsscript.jsInclude("js", "monitor/jquery.vbox.js","monitor/jquery.vbox.util.js");

function domReady() {

}

// Mozilla, Opera, Webkit 
if (document.addEventListener) {
    document.addEventListener("DOMContentLoaded", function () {
        document.removeEventListener("DOMContentLoaded", arguments.callee, false);
        domReady();
    }, false);

// If IE event model is used
} else if (document.attachEvent) {
    // ensure firing before onload
    document.attachEvent("onreadystatechange", function () {
        if (document.readyState === "complete") {
            document.detachEvent("onreadystatechange", arguments.callee);
            domReady();
        }
    });
}
