<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
/**
 * 메인 탭메뉴
 */
var tabTitle = $("#tab_title"),
    tabContent = $("#tab_content"),
    tabTemplate = "<li menukey='#\{menukey\}' menul1key='#\{menul1key\}' menul2key='#\{menul2key\}' appkey='#\{appkey\}' class='li-add'><a href='#\{href\}'>#\{label\}</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>",
    tabTemplate2 = "<li menukey='#\{menukey\}' menul1key='#\{menul1key\}' menul2key='#\{menul2key\}' appkey='#\{appkey\}' class='li-add li-fixed'><a href='#\{href\}'>#\{label\}</a></li>"
    
var tabCounter = 3;
var tabIndex = 2; //탭 포커스를 위한 인덱스 저장

//탭화면 추가
function add_tab(addr, name, menul1key, menul2key, appkey, params) {
	if (typeof addr === 'undefined') {
		cfn_msg('WARNING', '이동될 경로가 없습니다.');
		return false;
	}
	
	/* 파라미터 셋팅 */
	var paramstr = '';
	var realurl = '';
	if (typeof params != 'undefined') {
		var i = 0;
		realurl = params.realurl;
		$.each(params, function(k, v) {
			if (k != 'realurl') {
				if (i === 0) {
					paramstr += '?' + k + '=' + v;
				} else {
					paramstr += '&' + k + '=' + v;
				}
			}
			i++;
		});
	}
	
	/* 기존에 탭화면이 있으면 탭생성하지 않고 이동 */
	var tabFlag = true;
	
	tabs.find(".ui-tabs-nav li").each(function(index, val) {
		if (addr == $(this).attr("menukey")) {
			if (!confirm('기존에 존재하는 화면이 있습니다.\n이동하시겠습니까?')) {
				tabFlag = false;
				return false;
			}
			
			tabs.tabs("refresh");
			tabs.tabs("option", "active", index);
			
			/* 해당 아이프레임의 초기화면으로 이동처리 */
			if (cfn_isEmpty(realurl)) {
				$('#' + $(val).attr('aria-controls') + ' iframe')[0].src = addr + paramstr;
			} else {
				$('#' + $(val).attr('aria-controls') + ' iframe')[0].src = realurl + paramstr;
			}
			tabFlag = false;
		}
	});
	
	if(tabFlag) {
		if(tabIndex <= 15) {
			var label = name,
		        id = "tabs-" + tabCounter,
		        li = $(tabTemplate.replace( /#\{href\}/g, "#" + id ).replace( /#\{label\}/g, label ).replace(/#\{menukey\}/g, addr).replace(/#\{menul1key\}/g, menul1key).replace(/#\{menul2key\}/g, menul2key).replace(/#\{appkey\}/g, appkey));
			var index = parseInt(tabIndex);
			
			tabs.find(".ui-tabs-nav").append( li );
			
			if (cfn_isEmpty(realurl)) {
				tabs.append("<div id='" + id + "' class='tabs-content tabContentD'><iframe src='" + addr + paramstr + "' id='icontent"+tabCounter+"' name='icontent"+tabCounter+"' style='width:100%;height:100%;' allowFullScreen></iframe></div>");
			} else {
				tabs.append("<div id='" + id + "' class='tabs-content tabContentD'><iframe src='" + realurl + paramstr + "' id='icontent"+tabCounter+"' name='icontent"+tabCounter+"' style='width:100%;height:100%;' allowFullScreen></iframe></div>");
			}
			
			tabs.tabs("refresh");
			tabs.tabs("option", "active", tabIndex);
			
			tabIndex++;
			tabCounter++;
		} else {
			cfn_msg('WARNING', '탭메뉴는 15개를 초과할 수 없습니다.');
		}
	}
}


/*
 * 2109. 10. 16
 * 탭 추가 함수 추가(추가 되는 탭의 경우 x 닫기 버튼이 포함되는데, 이를 포함하지 않음)
 * 고정탭 구분을 위해 fixedtabCounter, fixedtabIndex, active 파라미터 추가
 */
function add_tab2(addr, name, menul1key, menul2key, appkey, params, fixedtabCounter, fixedtabIndex, active) {
	if (typeof addr === 'undefined') {
		cfn_msg('WARNING', '이동될 경로가 없습니다.');
		return false;
	}
	
	/* 파라미터 셋팅 */
	var paramstr = '';
	var realurl = '';
	if (typeof params != 'undefined') {
		var i = 0;
		realurl = params.realurl;
		$.each(params, function(k, v) {
			if (k != 'realurl') {
				if (i === 0) {
					paramstr += '?' + k + '=' + v;
				} else {
					paramstr += '&' + k + '=' + v;
				}
			}
			i++;
		});
	}
	
	/* 기존에 탭화면이 있으면 탭생성하지 않고 이동 */
	var tabFlag = true;
	
	tabs.find(".ui-tabs-nav li").each(function(index, val) {
		if (addr == $(this).attr("menukey")) {
			if (!confirm('기존에 존재하는 화면이 있습니다.\n이동하시겠습니까?')) {
				tabFlag = false;
				return false;
			}
			
			tabs.tabs("refresh");
			tabs.tabs("option", "active", index);
			
			/* 해당 아이프레임의 초기화면으로 이동처리 */
			if (cfn_isEmpty(realurl)) {
				$('#' + $(val).attr('aria-controls') + ' iframe')[0].src = addr + paramstr;
			} else {
				$('#' + $(val).attr('aria-controls') + ' iframe')[0].src = realurl + paramstr;
			}
			tabFlag = false;
		}
	});
	
	if(tabFlag) {
		if(fixedtabCounter <= 15) {
			var label = name,
		        id = "tabs-" + fixedtabCounter,
		        li = $(tabTemplate2.replace( /#\{href\}/g, "#" + id ).replace( /#\{label\}/g, label ).replace(/#\{menukey\}/g, addr).replace(/#\{menul1key\}/g, menul1key).replace(/#\{menul2key\}/g, menul2key).replace(/#\{appkey\}/g, appkey));
			var index = parseInt(fixedtabCounter);
			
			tabs.find(".ui-tabs-nav").append( li );
			
			if (cfn_isEmpty(realurl)) {
				tabs.append("<div id='" + id + "' class='tabs-content tabContentD tabs-fixed'><iframe src='" + addr + paramstr + "' id='icontent"+fixedtabCounter+"' name='icontent"+fixedtabCounter+"' style='width:100%;height:100%;' allowFullScreen></iframe></div>");
			} else {
				tabs.append("<div id='" + id + "' class='tabs-content tabContentD tabs-fixed'><iframe src='" + realurl + paramstr + "' id='icontent"+fixedtabCounter+"' name='icontent"+fixedtabCounter+"' style='width:100%;height:100%;' allowFullScreen></iframe></div>");
			}
				
			tabs.tabs("refresh");
			tabs.tabs("option", "active", active);
			
			fixedtabIndex++;
			fixedtabCounter++;

		} else {
			cfn_msg('WARNING', '탭메뉴는 15개를 초과할 수 없습니다.');
		}
	}
}
</script>
<div class="accordion_box"><!-- 스크롤이 생기는 부분은 이부분에서 합니다. -->
	<div id="accordion">
	</div>
</div>
