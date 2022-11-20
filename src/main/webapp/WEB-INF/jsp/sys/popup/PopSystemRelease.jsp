<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : PopSystemRelease
	화면명    : 팝업-시스템 업데이트 정보
-->
<div id="popSystemRelease" class="pop_wrap">
	<div class="ct_left_wrap">
		<h3>* LFW2 업데이트 Release</h3>
		<h4 class="line">--------------------------------------------------------------</h4>
		<h4 class="title">- 2017-11-14 (화) -</h4>
		<ul>
			<li style="font-weight:bold">
				1. 공통 관련
				<ul>
					<li>1) </li>
					<li>&nbsp;&nbsp;</li>
					<li>&nbsp;&nbsp;</li>
					<li></li>
				</ul>
			</li>
		</ul>
		<h4 class="line">--------------------------------------------------------------</h4>
	</div>
	<div class="ct_right_wrap">
		<h3>* LFW2 이슈사항</h3>
		<h4 class="line">--------------------------------------------------------------</h4>
		<ul>
			<li style="font-weight:bold">
				1. 리얼그리드 관련
				<ul>
					<li style="color:red"></li>
					<li>&nbsp;&nbsp;</li>
					<li></li>
				</ul>
			</li>
		</ul>
	</div>
</div>

<style type="text/css">
h4 {font-weight:normal;margin:5px 0 0 0}
h4.line {margin:10px 0 0 0}
h4.title {margin:10px 0 5px 0;font-weight:bold}
ul {list-style:none;}
ul li ul {margin:5px 0 5px 10px;list-style:none;font-weight:normal}
</style>

<script type="text/javascript">
$(function() {
	$('#popSystemRelease').lingoPopup({
		title: '시스템 업데이트 정보',
		width: 1200,
		buttons: {
			'닫기': {
				text: '닫기',
				click: function() {
					$(this).lingoPopup('setData', '');
					$(this).lingoPopup('close');
				}
			}
		},
		open: function(data) {
		}
	});
});
</script>