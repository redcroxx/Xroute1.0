<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 
	화면코드 : sampletest
	화면명 : EFS API 테스트
-->
<c:import url="/comm/contentTop.do" />

<script type="text/javascript">
	//공통버튼 - 검색 클릭
	function cfn_retrieve() {
		
		var keyData = $("#KEY").val();
		var paramData = {'KEY':keyData};
		
		var sid = 'sid_getSend';
		var url = '/test/getShippoSend.do';
		var sendData = {'paramData':paramData};
		
		gfn_sendData(sid, url, sendData);
	}
	
	/* 요청한 데이터 처리 callback */
	function gfn_callback(sid, data) {
		//검색
		if (sid == 'sid_getSend') {

			$('#RESULT').text("결과 : " + data.result.resultData.trackingNumber);
		}
	}
</script>

	<table width="1000">
	<form action="/test/getShippoSend.do" method="post" id="frm">
		<tr>
			<td colspan="2">SHIPPO TEST </td>
		</tr>
        <tr>
            <td style="width:100px">
            	API KEY
            </td>
            <td>
            	<input type="text" name="KEY" id="KEY" value="shippo_test_cf1b6d0655e59fc6316880580765066038ef20d8" style="width:300px">
            </td>
        </tr>
		<tr>
			<td colspan="2"><input type="button" value="보내기" onclick="cfn_retrieve();" /></td>
			
		</tr>
        </form>
       </table>
       
       <a name="RESULT" id="RESULT">결과 :</a>

       <c:import url="/comm/contentBottom.do" />