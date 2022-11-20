<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<body onload="startFunction();">
<video id="video" autoplay="autoplay" width="640px" height="480px"></video>
<input type="button" value="저장" onclick="save();">
<script>
const constraints = {
	"video": {
		width:{max: 640}
		, height:{max: 480}
	}
	, "audio" : false
	
};

var _XRT_INVC_SNO = "<c:out value='${xrtInvcSno}' />";
var _ORGCD = "<c:out value='${orgcd}' />";
var theStream;
var theRecorder;
var recordedChunks = [];

function startFunction() {
	navigator.mediaDevices.getUserMedia(constraints).then(gotMedia).catch(e => {
		console.error("getUserMedia() failed: " + e);
		window.opener.livePackingReset();
		window.close();
	});
}

function gotMedia(stream) {
	theStream = stream;
	var options = {
		mimeType: 'video/webm; codecs="avc1.4d002a"'
		// mimeType: 'video/webm'
		, bitsPerSecond: 800 * 1024 * 1024
		
	}
	var video = document.querySelector("video");
	video.srcObject = stream;
	try {
		recorder = new MediaRecorder(stream, options);
	} catch (e) {
		console.error("Exception while creating MediaRecorder: " + e);
		window.opener.livePackingReset();
		window.close();
		return;
	}
	
	theRecorder = recorder;
	recorder.ondataavailable = (event) => { recordedChunks.push(event.data); };
	recorder.start(100);
}
// From @samdutton's "Record Audio and Video with MediaRecorder"
// https://developers.google.com/web/updates/2016/01/mediarecorder
function save() {
	theRecorder.stop();
	theStream.getTracks().forEach(track => { track.stop(); });
	
	var date = new Date();
	var video = new Blob(recordedChunks, {type: "video/webm; codecs='avc1.4d002a'"});
	var file = new File([video], _XRT_INVC_SNO +".webm", {lastModified: new Date().getTime(), type: video.type})
	var url = "/livePacking/upload.do";
	var xhr = new XMLHttpRequest();
	var formData = new FormData();
	formData.append("file", file);
	formData.append("orgcd", _ORGCD);
	
	xhr.open("POST", url);
	xhr.onreadystatechange = function() {
		if(xhr.readyState === XMLHttpRequest.DONE) {
			console.log("responseText : ", xhr.responseText);
			var resText = JSON.parse(xhr.responseText);
			if (resText.CODE == "1") {
				window.close();
			}
		}
	};
	// xhr.setRequestHeader("Content-type", "application/json; charset=utf-8");
	xhr.send(formData); 
}
</script>
</body>
</html>