<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<body>
<video id="video" autoplay="autoplay" controls="controls" width="450px" height="300px"></video>
<script>
const constraints = {
    "video": {
        width:{max: 640}
        , height:{max: 480}
    }
    , "audio" : false
    
};

var theStream;
var theRecorder;
var recordedChunks = [];

function startFunction() {
    navigator.mediaDevices.getUserMedia(constraints).then(getMedia).catch(e => {
        console.error("getUserMedia() failed: " + e);
        window.opener.livePackingReset();
        window.close();
    });
}

function getMedia(stream) {
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
    
    var xrtInvcSno =  window.parent.document.getElementById("xrtInvcSno").value;
    var orgcd = window.parent.document.getElementById("orgcd").value;
    
    var date = new Date();
    var video = new Blob(recordedChunks, {type: "video/webm; codecs='avc1.4d002a'"});
    var file = new File([video], xrtInvcSno +".webm", {lastModified: new Date().getTime(), type: video.type})
    var url = "/livePacking/upload.do";
    var xhr = new XMLHttpRequest();
    var formData = new FormData();
    formData.append("file", file);
    formData.append("orgcd", orgcd);
    
    xhr.open("POST", url);
    xhr.onreadystatechange = function() {
        if(xhr.readyState === XMLHttpRequest.DONE) {
            console.log("responseText : ", xhr.responseText);
            var resText = JSON.parse(xhr.responseText);
            if (resText.CODE == "1") {
            }
        }
    };
    // xhr.setRequestHeader("Content-type", "application/json; charset=utf-8");
    xhr.send(formData);
    return "ok";
}
</script>
</body>
</html>