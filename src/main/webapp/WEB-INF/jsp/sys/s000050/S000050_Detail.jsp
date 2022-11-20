<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
	화면코드 : S000050
	화면명 : 프로그램관리
-->
<c:import url="/comm/contentTop.do" />

<div class="ct_top_wrap">
	<form id="frmDetail" action="#" onsubmit="return false">
	<table class="tblForm">
		<caption>프로그램 정보</caption>
		<colgroup>
			<col width="130px" />
	        <col />
	    </colgroup>
		<tr>
			<th>프로그램코드</th>
			<td><input type="text" id="APPKEY" class="cmc_txt required" maxlength="20" /></td>
		</tr>
		<tr>
			<th>프로그램명</th>
			<td><input type="text" id="APPNM" class="cmc_txt required" maxlength="20" /></td>
		</tr>
		<tr>
			<th>URL</th>
			<td><input type="text" id="APPURL" class="cmc_txt" style="width:500px" maxlength="100" /></td>
		</tr>
		<tr>
			<th>비고</th>
			<td>
				<textarea id="REMARK" class="cmc_area" maxlength="200"></textarea>
			</td>
		</tr>
	</table>

	<table class="tblForm">
		<caption>공통버튼 사용여부</caption>
		<colgroup>
			<col width="130px" />
	        <col width="240px" />
	        <col width="130px" />
	        <col width="240px" />
	        <col width="130px" />
	        <col />
	    </colgroup>
		<tr>
			<th>검색</th>
			<td>
				<label for="BTNSEARCH1"><input type="radio" name="BTNSEARCH" id="BTNSEARCH1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNSEARCH0"><input type="radio" name="BTNSEARCH" id="BTNSEARCH0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
			<th>신규</th>
			<td>
				<label for="BTNNEW1"><input type="radio" name="BTNNEW" id="BTNNEW1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNNEW0"><input type="radio" name="BTNNEW" id="BTNNEW0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
			<th>목록</th>
			<td>
				<label for="BTNLIST1"><input type="radio" name="BTNLIST" id="BTNLIST1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNLIST0"><input type="radio" name="BTNLIST" id="BTNLIST0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
		</tr>
		<tr>
			<th>저장</th>
			<td>
				<label for="BTNSAVE1"><input type="radio" name="BTNSAVE" id="BTNSAVE1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNSAVE0"><input type="radio" name="BTNSAVE" id="BTNSAVE0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
			<th>삭제</th>
			<td>
				<label for="BTNDELETE1"><input type="radio" name="BTNDELETE" id="BTNDELETE1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNDELETE0"><input type="radio" name="BTNDELETE" id="BTNDELETE0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
			<th>초기화</th>
			<td>
				<label for="BTNINIT1"><input type="radio" name="BTNINIT" id="BTNINIT1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNINIT0"><input type="radio" name="BTNINIT" id="BTNINIT0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
		</tr>
		<tr>
			<th>실행</th>
			<td>
				<label for="BTNEXECUTE1"><input type="radio" name="BTNEXECUTE" id="BTNEXECUTE1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNEXECUTE0"><input type="radio" name="BTNEXECUTE" id="BTNEXECUTE0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
			<th>취소</th>
			<td>
				<label for="BTNCANCEL1"><input type="radio" name="BTNCANCEL" id="BTNCANCEL1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNCANCEL0"><input type="radio" name="BTNCANCEL" id="BTNCANCEL0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
			<th>복사</th>
			<td>
				<label for="BTNCOPY1"><input type="radio" name="BTNCOPY" id="BTNCOPY1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNCOPY0"><input type="radio" name="BTNCOPY" id="BTNCOPY0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
		</tr>
		<tr>
			<th>엑셀업로드</th>
			<td>
				<label for="BTNEXCELUP1"><input type="radio" name="BTNEXCELUP" id="BTNEXCELUP1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNEXCELUP0"><input type="radio" name="BTNEXCELUP" id="BTNEXCELUP0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
			<th>엑셀다운로드</th>
			<td>
				<label for="BTNEXCELDOWN1"><input type="radio" name="BTNEXCELDOWN" id="BTNEXCELDOWN1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNEXCELDOWN0"><input type="radio" name="BTNEXCELDOWN" id="BTNEXCELDOWN0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
			<th>출력</th>
			<td>
				<label for="BTNPRINT1"><input type="radio" name="BTNPRINT" id="BTNPRINT1" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNPRINT0"><input type="radio" name="BTNPRINT" id="BTNPRINT0" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
		</tr>
		<tr>
			<th>사용자1</th>
			<td>
				<label for="BTNUSER11"><input type="radio" name="BTNUSER1" id="BTNUSER11" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNUSER10"><input type="radio" name="BTNUSER1" id="BTNUSER10" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
			<th>사용자2</th>
			<td>
				<label for="BTNUSER21"><input type="radio" name="BTNUSER2" id="BTNUSER21" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNUSER20"><input type="radio" name="BTNUSER2" id="BTNUSER20" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
			<th>사용자3</th>
			<td>
				<label for="BTNUSER31"><input type="radio" name="BTNUSER3" id="BTNUSER31" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNUSER30"><input type="radio" name="BTNUSER3" id="BTNUSER30" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
		</tr>
		<tr>
			<th>사용자4</th>
			<td>
				<label for="BTNUSER41"><input type="radio" name="BTNUSER4" id="BTNUSER41" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNUSER40"><input type="radio" name="BTNUSER4" id="BTNUSER40" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
			<th>사용자5</th>
			<td colspan="3">
				<label for="BTNUSER51"><input type="radio" name="BTNUSER5" id="BTNUSER51" class="cmc_radio" value="1" />
					예
				</label>
				<label for="BTNUSER50"><input type="radio" name="BTNUSER5" id="BTNUSER50" class="cmc_radio" value="0" checked="checked" />
					아니오
				</label>
			</td>
		</tr>
	</table>

	<div id="form_extbtn" class="down"></div>
	<div id="form_extline"></div>

	<div id="form_extwrap">
		<table class="tblForm">
			<caption>시스템정보</caption>
			<colgroup>
				<col width="130px" />
		        <col width="240px" />
		        <col width="130px" />
		        <col width="240px" />
		        <col width="130px" />
		        <col />
		    </colgroup>
			<tr>
				<th>등록자</th>
				<td><input type="text" id="ADDUSERCD" class="cmc_txt disabled" readonly="readonly" /></td>
				<th>등록일시</th>
				<td colspan="3"><input type="text" id="ADDDATETIME" class="cmc_datetime disabled" readonly="readonly" /></td>
			</tr>
			<tr>
				<th>변경자</th>
				<td><input type="text" id="UPDUSERCD" class="cmc_txt disabled" readonly="readonly" /></td>
				<th>변경일시</th>
				<td><input type="text" id="UPDDATETIME" class="cmc_datetime disabled" readonly="readonly" /></td>
				<th>단말코드</th>
				<td><input type="text" id="TERMINALCD" class="cmc_txt disabled" readonly="readonly" /></td>
			</tr>
		</table>
	</div>
	</form>
</div>

<script type="text/javascript">
<%--
  * ========= 공통버튼 클릭함수 =========
  * 검색 : cfn_retrieve()
  * 목록 : cfn_list()
  * 신규 : cfn_new()
  * 삭제 : cfn_del()
  * 저장 : cfn_save()
  * 복사 : cfn_copy()
  * 초기화 : cfn_init()
  * 실행 : cfn_execute()
  * 취소 : cfn_cancel()
  * 엑셀업로드 : cfn_excelup()
  * 엑셀다운 : cfn_exceldown()
  * 출력 : cfn_print()
  * 사용자버튼 : cfn_userbtn1() ~ cfn_userbtn5()
  * -------------------------------
  * 버튼 순서 : setCommBtnSeq(['ret','list']) : ret,list,new,del,save,copy,init,execute,print,excelup,exceldown,user1,2,3,4,5
  * 버튼 표시/숨김 : setCommBtn('ret', true) : ret,list,new,del,save,copy,init,execute,print,excelup,exceldown,user1,2,3,4,5
  * ===============================
--%>
//초기 로드
$(function() {
	initLayout();

	setCommBtn('ret', false);
	setCommBtn('new', false);

	fn_initDetail(gv_paramData);
});

// 요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//상세검색
	if (sid == 'sid_getDetail') {
		cfn_bindFormData('frmDetail', data.resultData);
	}
	//저장
	else if (sid == 'sid_setSave') {
		alert('정상적으로 저장되었습니다.');
		cfn_list();
	}
	//삭제
	else if (sid == 'sid_setDelete') {
		alert('정상적으로 삭제되었습니다.');
		cfn_list();
	}
}

//상세조회
function fn_initDetail(param) {
	if (cfn_getIDUR() === 'U') {
		$('#APPKEY').prop('readonly', true).addClass('disabled');
		
		var sid = 'sid_getDetail';
		var url = '/sys/s000050/getDetail.do';
		var sendData = {'paramData':param};
	
		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 목록 클릭
function cfn_list() {
	gfn_pageMove('/sys/s000050/view.do');
}

//공통버튼 - 저장 클릭
function cfn_save() {
	//필수입력 체크
	//if (!gfn_inputCheck('frmDetail')) return false;
	
	if (confirm('저장하시겠습니까?')) {
		var formdata = cfn_getFormData('frmDetail');

		var sid = 'sid_setSave';
		var url = '/sys/s000050/setSave.do';
		var sendData = {'paramData':formdata};

		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 삭제 클릭
function cfn_del() {
	if (cfn_getIDUR() === 'I') {
		alert('신규상태에서는 삭제할 수 없습니다.');
		return false;
	}
	
	if (confirm('삭제하시겠습니까?')) {
		var appkey = $('#APPKEY').val();

		var sid = 'sid_setDelete';
		var url = '/sys/s000050/setDelete.do';
		var sendData = {'paramData':{'APPKEY':appkey}};

		gfn_sendData(sid, url, sendData);
	}
}
</script>

<c:import url="/comm/contentBottom.do" />