<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : PopPost
	화면명    : 팝업-우편번호
-->
<div id="popPost" class="pop_wrap">
</div>

<script type="text/javascript">
$(function() {
	$('#popPost').lingoPopup({
		title: '우편번호 검색',
		width: 500,
		height: 600,
		buttons: {
			'닫기': {
				text: '닫기',
				click: function() {
					$(this).lingoPopup('close');
				}
			}
		},
		open: function(data) {
			var element_wrap = document.getElementById('popPost');

		    new daum.Postcode({
		        oncomplete: function(data) {
					var fullAddr = ''; // 최종 주소 변수
					var extraAddr = ''; // 조합형 주소 변수

					// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						fullAddr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						fullAddr = data.jibunAddress;
					}

					// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
					if (data.userSelectedType === 'R') {
						//법정동명이 있을 경우 추가한다.
						if (data.bname !== '') {
							extraAddr += data.bname;
						}
						// 건물명이 있을 경우 추가한다.
						if (data.buildingName !== '') {
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
						fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
					}

		            // 우편번호와 주소 정보를 해당 필드에 넣는다.
		            popup.rtnData = [{'POST':data.zonecode,'ADDR':fullAddr}];
		            pfn_popupClose($('#popPost').data('pid'));
		        },
	            width : '100%',
	            height : '100%'
		    }).embed(element_wrap);
		}
	});
});
</script>