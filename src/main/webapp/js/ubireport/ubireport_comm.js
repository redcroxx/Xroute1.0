/***** 유비리포트 공통 js *****/
/**
 * 리포트 view 열기
 * 
 * @param {object}
 *            obj : key/value 형태 리포트 파라미터 title : 리포트 타이틀명 jrfName : 리포트파일명 args :
 *            리포트에 넘길 파라미터 key/value 형태 object
 */
function rfn_reportView(obj) {
	var rptVar = $.extend({
		title: 'Report',
		jrfName: '',
		args: {}
	}, obj);
	
	var args = '';
	$.each(rptVar.args, function(k, v) {
		args += k + '#' + v + '#';
	});
	
	var width = Math.floor(window.screen.width / 3) * 2;
	var height = window.screen.height - 150;
	var winX = window.screenX || window.screenLeft || 0;
	var winY = window.screenY || window.screenTop || 0;
	var posX = winX + Math.floor(window.screen.width / 2) - Math.floor(width / 2);
	var posY = winY + 40;

	window.open('/ubireport/ubiReportView.jsp?arg='
			+ encodeURIComponent('title#' + rptVar.title + '#')
			+ encodeURIComponent(args)
			+ '&jrf=' + rptVar.jrfName + '.jrf', 'window', 'left=' + posX + ',top=' + posY + ',width=' + width + ',height=' + height + ',toolbar=no,menubar=no,status=no');
}

/**
 * 리포트 라벨 열기
 * 
 * @param {object}
 *            obj : key/value 형태 리포트 파라미터 title : 리포트 타이틀명 jrfName : 리포트파일명 args :
 *            리포트에 넘길 파라미터 key/value 형태 object
 */
function rfn_reportLabel(obj) {
	var rptVar = $.extend({
		title: 'Report',
		jrfName: '',
		args: {}
	}, obj);
	
	var args = '';
	$.each(rptVar.args, function(k, v) {
		args += k + '#' + v + '#';
	});
	
	var width = 800;
	var height = 300;
	var winX = window.screenX || window.screenLeft || 0;
	var winY = window.screenY || window.screenTop || 0;
	var posX = winX + Math.floor(window.screen.width / 2) - Math.floor(width / 2);
	var posY = winY + 40;
	
	var print = cfn_printInfo().PRINT1;
	var print2 = cfn_printInfo().PRINT2;
	var print3 = cfn_printInfo().PRINT3;
	var print4 = cfn_printInfo().PRINT4;
	
	var invcType = 0;
	
	switch (rptVar.jrfName) {
	    case "STOCK_INSERT_P" :
	    case "STOCK_INSERT_F" :
	    case "XROUTE_A4_2x4" :
	    case "XROUTE_A4_2x2" :
	    case "XROUTE_A4_2x1" :
        case "STOCK_INSERT_P" :
        case "ATOMY_LABEL" :
            print = print;
            invcType = 0;
            break;
        case "UPS_LABEL":
            print = print;
            invcType = 0;
            break;
        case "ATOMY_INVOICE_PACKING_LIST" :
        case "ATOMY_PICKING_LIST" :
            print = print2;
            invcType = 3;
        default :
            break;
    }
	
	
	window.open('/comm/report/ubiReportLabel.do?print='+print+'&invcType='+invcType+'&arg=' +
			encodeURIComponent('title#' + rptVar.title + '#') +
			encodeURIComponent(args) +
			'&jrf=' + rptVar.jrfName + '.jrf', 'window', 'left=' + posX + ',top=' + posY + ',width=' + width + ',height=' + height + ',toolbar=no,menubar=no,status=no');
}



/**
 * 리포트 라벨 열기
 * 
 * @param {object}
 *            obj : key/value 형태 리포트 파라미터 title : 리포트 타이틀명 jrfName : 리포트파일명 args :
 *            리포트에 넘길 파라미터 key/value 형태 object
 */
function rfn_reportLabelEtc(obj) {
	var rptVar = $.extend({
		title: 'Report',
		jrfName: '',
		args: {}
	}, obj);
	
	var args = '';
	$.each(rptVar.args, function(k, v) {
		args += k + '#' + v + '#';
	});
	
	var width = 800;
	var height = 300;
	var winX = window.screenX || window.screenLeft || 0;
	var winY = window.screenY || window.screenTop || 0;
	var posX = winX + Math.floor(window.screen.width / 2) - Math.floor(width / 2);
	var posY = winY + 40;
	
	
	var print = cfn_printInfo().PRINT2;

	window.open('/comm/report/ubiReportLabelEtc.do?print='+print+'&arg=' +
			encodeURIComponent('title#' + rptVar.title + '#') +
			encodeURIComponent(args) +
			'&jrf=' + rptVar.jrfName + '.jrf', 'window', 'left=' + posX + ',top=' + posY + ',width=' + width + ',height=' + height + ',toolbar=no,menubar=no,status=no');
}