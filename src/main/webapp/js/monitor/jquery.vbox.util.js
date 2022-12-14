//datepicker 사용자 수정 소스 (2014-06-20)
jQuery(function($){
	$.datepicker.regional[""] = { // Default regional settings
		closeText: "Done", // Display text for close link
		prevText: "Prev", // Display text for previous month link
		nextText: "Next", // Display text for next month link
		currentText: "Today", // Display text for current month link
		monthNames: ["1월","2월","3월","4월","5월","6월",
			"7월","8월","9월","10월","11월","12월"], // Names of months for drop-down and formatting
		monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"], // For formatting
		dayNames: ["일", "월", "화", "수", "목", "금", "토"], // For formatting
		dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"], // For formatting
		dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"], // Column headings for days starting at Sunday
		weekHeader: "Wk", // Column header for week of the year
		dateFormat: "mm/dd/yy", // See format options on parseDate
		firstDay: 0, // The first day of the week, Sun = 0, Mon = 1, ...
		isRTL: false, // True if right-to-left language, false if left-to-right
		showMonthAfterYear: true, // True if the year select precedes month, false for month then year
		yearSuffix: "년" // Additional text to append to the year in the month headers
	};
	$.datepicker.setDefaults($.datepicker.regional[""]);
});

/* 압축 암호화 필수 2015-09-16 */
var VBOX_LE_NU="1,2,3,4,5,6,7,8,9,0";var VBOX_LE_LW="a,b,c,d,e,f,g,h,i,j,k,l,m";var VBOX_LE_UP="N,O,P,Q,R,S,T,U,V,W,X,Y,Z";


//Timer 
/*
Repeat, execute, currentCount, currentRepeat

*/
;(function($){$.timer=function(func,time,autostart){this.set=function(func,time,autostart){this.init=true;if(typeof func=='object'){var paramList=['autostart','time'];for(var arg in paramList){if(func[paramList[arg]]!=undefined){eval(paramList[arg]+" = func[paramList[arg]]")}};func=func.action}if(typeof func=='function'){this.action=func}if(!isNaN(time)){this.intervalTime=time}if(autostart&&!this.isActive){this.isActive=true;this.setTimer()}return this};this.once=function(time){var timer=this;if(isNaN(time)){time=0}window.setTimeout(function(){timer.action()},time);return this};this.play=function(reset){if(!this.isActive){if(reset){this.setTimer()}else{this.setTimer(this.remaining)}this.isActive=true}return this};this.pause=function(){if(this.isActive){this.isActive=false;this.remaining-=new Date()-this.last;this.clearTimer()}return this};this.stop=function(){this.isActive=false;this.remaining=this.intervalTime;this.clearTimer();return this};this.toggle=function(reset){if(this.isActive){this.pause()}else if(reset){this.play(true)}else{this.play()}return this};this.reset=function(){this.isActive=false;this.play(true);return this};this.clearTimer=function(){window.clearTimeout(this.timeoutObject)};this.setTimer=function(time){var timer=this;if(isNaN(time)){time=this.intervalTime}this.remaining=time;this.last=new Date();this.clearTimer();this.timeoutObject=window.setTimeout(function(){timer.go()},time)};this.go=function(){if(this.isActive){this.$el.trigger("execute");this.setTimer()}};if(this.init){return new $.timer(func,time,autostart)}else{this.set(func,time,autostart);return this}}})(jQuery);

/*
 * 문자열 trim함수
 */
/*
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/gi, "");
};
String.prototype.ltrim = function() {
	return this.replace(/^\s+/, "");
};
String.prototype.rtrim = function() {
	return this.replace(/\s+$/, "");
};
*/

/* 디비에 저장할때 한글 깨지는 문제 해결위해 인코딩해주는 함수*/
function uriEncode(uri) {
    return escape(encodeURIComponent(uri));

}

/* 공백 문자 padding 
 * 암호화시에 16자리가 되어야하므로
 * 비밀번호가 16자리 이하이더라도 나머지를 공백으로 처리해야함. 

function padding16(sVal) {
	var nCount = 16 - (sVal.length % 16);
	for ( var i = 0; i < nCount; i++) {
		sVal += ' ';
	}
	return sVal;
}
 */
/*URL에서 파라마티값 가져오는 함수*/
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regexS = "[\\?&]" + name + "=([^&#]*)";
    var regex = new RegExp(regexS);
    var results = regex.exec(window.location.href);
    if (results == null)
        return "";
    else
        return decodeURIComponent(results[1].replace(/\+/g, " "));
}

// 날짜 누적일
function accrue(val1, val2) {
    var val1;
    var val2;
    var FORMAT = "-";
    var start_dt = val1.split(FORMAT);
    var end_dt = val2.split(FORMAT);

    start_dt[1] = (Number(start_dt[1]) - 1) + "";
    end_dt[1] = (Number(end_dt[1]) - 1) + "";
    var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2]);
    var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2]);
    return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60 / 60 / 24;
}

// 차트 실린더
function chartBarColor(cols, tcolor) {
    var a = hexToRgb(cols);
    var b = hexToRgb(tcolor);

    var steps = 2;
    var n = 1;

    var nr = Math.floor(a.r + (n * (b.r - a.r) / steps));
    var ng = Math.floor(a.g + (n * (b.g - a.g) / steps));
    var nb = Math.floor(a.b + (n * (b.b - a.b) / steps));


    return rgb2hex(nr, ng, nb);

}

/* color util*/
function hexToRgb(h) {
    /*
    var r = parseInt((cutHex(h)).substring(0, 2), 16), g = ((cutHex(h)).substring(2, 4), 16), b = parseInt((cutHex(h)).substring(4, 6), 16)
    return { "r": r, "g": g, "b": b };
    */

    if (h.substring(0, 1) == '#') h = h.substring(1, 7);
    var r = parseInt(h.substring(0, 2), 16);
    var g = parseInt(h.substring(2, 4), 16);
    var b = parseInt(h.substring(4, 6), 16);

    return { "r": r, "g": g, "b": b };

}
function cutHex(h) { return (h.charAt(0) == "#") ? h.substring(1, 7) : h }

function rgb2hex(r, g, b) {
    return '#' + this.byte2Hex(r) + this.byte2Hex(g) + this.byte2Hex(b);
}
function byte2Hex(n) {
    var nybHexString = "0123456789ABCDEF";
    return String(nybHexString.substr((n >> 4) & 0x0F, 1)) + nybHexString.substr(n & 0x0F, 1);
}

/*
;(function($){$.timer=function(func,time,autostart){this.set=function(func,time,autostart){this.init=true;if(typeof func=='object'){var paramList=['autostart','time'];for(var arg in paramList){if(func[paramList[arg]]!=undefined){eval(paramList[arg]+" = func[paramList[arg]]")}};func=func.action}if(typeof func=='function'){this.action=func}if(!isNaN(time)){this.intervalTime=time}if(autostart&&!this.isActive){this.isActive=true;this.setTimer()}return this};this.once=function(time){var timer=this;if(isNaN(time)){time=0}window.setTimeout(function(){timer.action()},time);return this};this.play=function(reset){if(!this.isActive){if(reset){this.setTimer()}else{this.setTimer(this.remaining)}this.isActive=true}return this};this.pause=function(){if(this.isActive){this.isActive=false;this.remaining-=new Date()-this.last;this.clearTimer()}return this};this.stop=function(){this.isActive=false;this.remaining=this.intervalTime;this.clearTimer();return this};this.toggle=function(reset){if(this.isActive){this.pause()}else if(reset){this.play(true)}else{this.play()}return this};this.reset=function(){this.isActive=false;this.play(true);return this};this.clearTimer=function(){window.clearTimeout(this.timeoutObject)};this.setTimer=function(time){var timer=this;if(typeof this.action!='function'){return}if(isNaN(time)){time=this.intervalTime}this.remaining=time;this.last=new Date();this.clearTimer();this.timeoutObject=window.setTimeout(function(){timer.go()},time)};this.go=function(){if(this.isActive){this.action();this.setTimer()}};if(this.init){return new $.timer(func,time,autostart)}else{this.set(func,time,autostart);return this}}})(jQuery);function uriEncode(uri){return escape(encodeURIComponent(uri))};function getParameterByName(name){name=name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");var regexS="[\\?&]"+name+"=([^&#]*)";var regex=new RegExp(regexS);var results=regex.exec(window.location.href);if(results==null)return"";else return decodeURIComponent(results[1].replace(/\+/g," "))};function accrue(val1,val2){var val1;var val2;var FORMAT="-";var start_dt=val1.split(FORMAT);var end_dt=val2.split(FORMAT);start_dt[1]=(Number(start_dt[1])-1)+"";end_dt[1]=(Number(end_dt[1])-1)+"";var from_dt=new Date(start_dt[0],start_dt[1],start_dt[2]);var to_dt=new Date(end_dt[0],end_dt[1],end_dt[2]);return(to_dt.getTime()-from_dt.getTime())/1000/ 60/60/24};function chartBarColor(cols,tcolor){var a=hexToRgb(cols);var b=hexToRgb(tcolor);var steps=2;var n=1;var nr=Math.floor(a.r+(n*(b.r-a.r)/steps));var ng=Math.floor(a.g+(n*(b.g-a.g)/steps));var nb=Math.floor(a.b+(n*(b.b-a.b)/steps));return rgb2hex(nr,ng,nb)};function hexToRgb(h){if(h.substring(0,1)=='#')h=h.substring(1,7);var r=parseInt(h.substring(0,2),16);var g=parseInt(h.substring(2,4),16);var b=parseInt(h.substring(4,6),16);return{"r":r,"g":g,"b":b}};function cutHex(h){return(h.charAt(0)=="#")?h.substring(1,7):h}function rgb2hex(r,g,b){return'#'+this.byte2Hex(r)+this.byte2Hex(g)+this.byte2Hex(b)};function byte2Hex(n){var nybHexString="0123456789ABCDEF";return String(nybHexString.substr((n>>4)&0x0F,1))+nybHexString.substr(n&0x0F,1)};
*/