<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popS014
	화면명    : 팝업-공지사항
-->
<div id="popS014" class="pop_wrap">
	<!-- 기본정보영역 시작 -->
	<form id="frmNotice" action="#" onsubmit="return false">
		<table class="tblForm" style="min-width: 780px;">
			<colgroup>
				<col width="90px" />
				<col width="140px" />
				<col width="90px" />
				<col width="140px" />
				<col width="90px" />
				<col width="140px" />
				<col width="90px" />
		        <col />
		    </colgroup>
			<tr>
				<th>공지번호</th>
				<td><input type="text" id="NTKEY" name="NTKEY" class="cmc_txt disabled" readonly="readonly" style="width:120px; border:0px; background-color:#ffffff !important;"/></td>
				<th>공지유형</th>
				<td><input type="text" id="NTTYPE" name="NTTYPE" class="cmc_txt disabled" readonly="readonly" style="width:120px; border:0px; background-color:#ffffff !important;"/></td>
				<th>사용여부</th>
				<td><input type="text" id="ISUSING" name="ISUSING" class="cmc_txt disabled" readonly="readonly" style="width:120px; border:0px; background-color:#ffffff !important;"/></td>
				<th>조회수</th>
				<td><input type="text" id="HITS" name="HITS" class="cmc_txt disabled" readonly="readonly" style="width:120px; border:0px; background-color:#ffffff !important;"/></td>
			</tr>
			<tr>
				<th>시작일자</th>
				<td><input type="text" id="STARTDT" name="STARTDT" class="cmc_txt disabled" readonly="readonly" style="width:120px; border:0px; background-color:#ffffff !important;"/></td>
				<th>종료일자</th>
				<td><input type="text" id="ENDDT" name="ENDDT" class="cmc_txt disabled" readonly="readonly" style="width:120px; border:0px; background-color:#ffffff !important;"/></td>
				<th>등록자</th>
				<td><input type="text" id="ADDUSERCD" name="ADDUSERCD" class="cmc_txt disabled" readonly="readonly" style="width:120px; border:0px; background-color:#ffffff !important;"/></td>
				<th>등록일시</th>
				<td><input type="text" id="ADDDATETIME" name="ADDDATETIME" class="cmc_txt disabled" readonly="readonly" style="width:180px; border:0px; background-color:#ffffff !important;"/></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="7"><input type="text" id="TITLE" name="TITLE" class="cmc_txt disabled" readonly="readonly" style="width:800px; border:0px; background-color:#ffffff !important;"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="7">
					<div id="CONTENTS"></div>
<!-- 					<textarea id="CONTENTS" name="CONTENTS" class="cmc_area disabled" readonly="readonly" style="width:885px; min-height:400px; border:0px; background-color:#ffffff !important;"> -->
<!-- 					</textarea> -->
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="7">
					<div id="attachfiledown_wrap"></div>
<!-- 					첨부파일1.zip<br /> -->
<!-- 					첨부파일2.zip<br /> -->
<!-- 					첨부파일3.zip<br /> -->
<!-- 					첨부파일4.zip<br /> -->
<!-- 					첨부파일5.zip<br /> -->
				</td>
			</tr>
		</table>
	</form>
	<!-- 기본정보영역 끝 -->
</div>


<script type="text/javascript">
$(function() {
	$('#popS014').lingoPopup({
		title: '공지사항',
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					$(this).lingoPopup('close', 'OK');
				}
			},
		},
		open: function(data) {

			var sendData = {'paramData':{'NTKEY': data.NTKEY}};
			
			//내용 바인딩
			var url = '/alexcloud/popup/popS014/getSearch.do';

			gfn_ajax(url, true, sendData, function(data, xhr) {
				cfn_bindFormData('frmNotice', data.resultData);
				$('#CONTENTS').html(data.resultData.CONTENTS);
			});
			
			//첨부파일 바인딩
			var urlFile = '/alexcloud/popup/popS014/getFile.do';
			
			gfn_ajax(urlFile, true, sendData, function(data, xhr) {
				for(var i = 0; i < data.resultList.length; i++) {
					$('#attachfiledown_wrap').append('<a href="#" onclick="window.open(encodeURI(\'/alexcloud/popup/popS014/noticeDownloadFile.do?realFilename=' 
							+ data.resultList[i].ORIGINFILENM + '&filename=' 
							+ data.resultList[i].FILENM + '\'))"><img src="/images/attachfile.png" width="20" alt="" /><span class="bold">' 
							+ data.resultList[i].FILENM + '</span></a><br>');
				}
			});
		}
	});
});

</script>