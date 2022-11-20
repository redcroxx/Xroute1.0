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
		
// 		var paramData = {'apiKey':document.getElementById("apiKey").value};

        var paramData = {'URL':document.getElementById("URL").value,'KEY':document.getElementById("KEY").value,'FUNCTION':document.getElementById("FUNCTION").value,'INVCSNO':document.getElementById("INVCSNO").value,'DATA':document.getElementById("DATA").value};
		
   		var sid = 'sid_getSend';
   		var url = '/test/getEfsSend.do';
   		var sendData = {'paramData':paramData};
	
		gfn_sendData(sid, url, sendData);
	}
	
	/* 요청한 데이터 처리 callback */
	function gfn_callback(sid, data) {
		//검색
		if (sid == 'sid_getSend') {

			$('#RESULT').text("결과 : " + data.result.resultData);
		}
	}
</script>

	<table width="1000">
	<form action="/test/getSend.do" method="post" id="frm">
		<tr>
			<td colspan="2">EFS TEST </td>
		</tr>
		<tr>
            <td style="width:100px">
            	URL
            </td>
            <td>
            	<input type="text" name="URL" id="URL" value="http://www.efs.asia:200/api/in/" style="width:300px">
            </td>
        </tr>
        <tr>
            <td style="width:100px">
            	API KEY
            </td>
            <td>
            	<input type="text" name="KEY" id="KEY" value="3d10ad45396a1cda654bc40498551eb0" style="width:300px">
            </td>
        </tr>
        <tr>
            <td style="width:100px">
            	기능
            </td>
            <td>
            	<select name="FUNCTION" id="FUNCTION">
            	   <option value="createShipment">createShipment</option>
            	   <option value="getTrackStatus">getTrackStatus</option>
            	</select>
            </td>
        </tr>
        <tr>
            <td style="width:100px">
            	Xroute 송장번호
            </td>
            <td>
            	<input type="text" name="INVCSNO" id="INVCSNO" style="width:300px">
            </td>
        </tr>
         <tr>
            <td style="width:100px">
            	데이터
            </td>
            <td>
            	<input type="text" name="DATA" id="DATA" style="width:300px">
            </td>
        </tr>
		<tr>
			<td colspan="2"><input type="button" value="보내기" onclick="cfn_retrieve();" /></td>
			
		</tr>
        </form>
       </table>
       
       <a name="RESULT" id="RESULT">결과 :</a>

       <c:import url="/comm/contentBottom.do" />