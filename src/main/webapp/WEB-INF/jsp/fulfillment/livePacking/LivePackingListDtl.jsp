<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst" %>
<div id="livePackingListDtl" class="pop_wrap">
<video id="video" autoplay="autoplay" width="640px" height="480px"></video>
</div>
<script type="text/javascript">
var _S3URL = "";
$(function() {
	$("#livePackingListDtl").lingoPopup({
		title: "라이브 패킹"
		, width: 680
		, height: 600
		, buttons: {
			"닫기": {
				text: "닫기"
				, click: function() {
					$(this).lingoPopup("setData", "");
					$(this).lingoPopup("close");
				}
			}
		} ,
		open: function(data) {
			_S3URL = data.s3Url;
			
			$("#video").prop("src", _S3URL);
		} 
	});
});

</script>