<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000021
	화면명    : 변수설정
-->
<c:import url="/comm/contentTop.do" />

<!-- 입력폼 시작 -->
<div class="ct_top_wrap">
	<form id="frmDetail" action="#" onsubmit="return false">
	<input type="hidden" id="COMPCD" name="COMPCD" class="cmc_code" />
	<input type="hidden" id="COMPNM" name="COMPNM" class="cmc_code" />
	<table class="tblForm">
		<caption>기본정보</caption>
		<colgroup>
			<col width="180px" />
			<col width="300px" />
			<col width="180px" />
			<col width="300px" />
			<col width="120px" />
			<col />
		</colgroup>
		<tr>
			<th class="required">셀러</th>
			<td colspan="6">
			<input type="text" id="S_ORGCD" name="S_ORGCD" class="cmc_code required" />
			<input type="text" id="S_ORGNM" name="S_ORGNM" class="cmc_value" />
			<button type="button" class="cmc_cdsearch"></button>
			</td>
		</tr>
		<tr>
			<th>송장출력순서</th>
			<td>	
				<select id="INVC_PRN_SEQ" name="INVC_PRN_SEQ" class="cmc_combo">
					<option value=""></option>
					<c:forEach var="i" items="${gCodeINVC}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
				
			</td>
			<th>상품코드등록</th>
			<td colspan="4">
				<select id="PROD_REG_YN" name="PROD_REG_YN" class="cmc_combo">
					<option value=""></option>
					<c:forEach var="i" items="${gCodeLPROD}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th class="required">DAS 슬롯수</th>
			<td>	
				<select id="DAS_ALLOC_CNT" name="DAS_ALLOC_CNT" class="cmc_combo required">
					<option value=""></option>
					<c:forEach var="i" items="${gCodeDAS}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</td>
			<th>픽업반편성 기준</th>
			<td colspan="4">
				<select id="PICKUP_ALLOC" name="PICKUP_ALLOC" class="cmc_combo">
					<option value=""></option>
					<c:forEach var="i" items="${gCodePICKUP}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th class="required">시리얼번호 내 제품자릿수</th>
			<td >
				<select id="SERIAL_NO_PROD" name="SERIAL_NO_PROD" class="cmc_combo required">
					<option value=""></option>
					<c:forEach var="i" items="${gCodeSERIALPROD}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</td>
			<th class="required">시리얼번호 총 자릿수</th>
			<td colspan="4">
				<select id="SERIAL_NO_NUM" name="SERIAL_NO_NUM" class="cmc_combo required">
					<option value=""></option>
					<c:forEach var="i" items="${gCodeSERIALNUM}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr >
			<th >거래명세서 자동출력</th>
			<td >	
				<select id="TRAN_PRINT_YN" name="TRAN_PRINT_YN" class="cmc_combo">
					<option value=""></option>
					<c:forEach var="i" items="${gCodeTRAN}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</td>
			<th >미출처리기준</th>
			<td colspan="4">	
				<select id="MICHUL_PROC" name="MICHUL_PROC" class="cmc_combo">
					<option value=""></option>
					<c:forEach var="i" items="${gCodeMICHUL}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
	
	</table>
	</form>
</div>
<!-- 입력폼 끝 -->

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
  * 버튼 순서 : setCommBtnSeq(['ret','list']) : ret,list,new,del,save,copy,init,execute,cancel,print,excelup,exceldown,user1,2,3,4,5
  * 버튼 표시/숨김 : setCommBtn('ret', true) : ret,list,new,del,save,copy,init,execute,cancel,print,excelup,exceldown,user1,2,3,4,5
  * ===============================
--%>
//초기 로드
$(function() {
	initLayout();
	
	setCommBtn('del', false, '취소');
	setCommBtn('new', false, '신규');	
	
	//로그인 정보로 세팅
	$('#COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_WHCD').val(cfn_loginInfo().WHCD);
	$('#S_WHNM').val(cfn_loginInfo().WHNM);
	
	if($('#S_ORGCD').val().length > 0){
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
		
		$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
		$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	} 
 	
	/* 공통코드 코드/명 (사업장) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	cfn_retrieve();
	
});


//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		var formData = data.resultData;
		cfn_bindFormData('frmDetail',formData);
	//저장
	}
	if (sid == 'sid_setSave') {
		var formData = data.resultData;
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
		
		//fn_initDetail(formData);  		
	}
	if (sid == 'sid_setDelete') {
		var formData = data.resultData;
		
		cfn_msg('INFO', '정상적으로 삭제되었습니다.');
		
		cfn_clearFormData('frmDetail');
		//fn_initDetail(formData);
		if ($('#S_ORGCD').val().length > 0) {
			$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
			$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
			
			$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
			$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
		} else {
			$('#S_ORGCD').removeAttr('disabled').removeClass('disabled').removeAttr('readonly');
			$('#S_ORGNM').removeAttr('disabled').removeClass('disabled').removeAttr('readonly');
			$('#btn_S_ORGCD').removeAttr('disabled').removeClass('disabled');
		}
		
		$('#S_COMPCD').val(cfn_loginInfo().WHCD);
		$('#S_COMPNM').val(cfn_loginInfo().WHNM);
	}

}

//검색
function cfn_retrieve() {
		
	if(cfn_isEmpty($('#S_ORGCD').val()) || cfn_isEmpty($('#S_ORGNM').val())){
		cfn_msg('WARNING', '셀러코드를 입력하여주세요');
		return false
	}
		
		gv_searchData = cfn_getFormData('frmDetail');
	
		var sid = 'sid_getSearch';
		var url = '/alexcloud/p000/p000021/getSearch.do';
		var sendData = {'paramData':gv_searchData};
	
		gfn_sendData(sid, url, sendData);

}

/* 공통버튼 - 신규 클릭 */
function cfn_new(){
	cfn_clearFormData('frmDetail');
	
	if($('#S_ORGCD').val().length > 0){
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
		
		$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
		$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	}else{
		$('#S_ORGCD').removeAttr('disabled').removeClass('disabled').removeAttr('readonly');
		$('#S_ORGNM').removeAttr('disabled').removeClass('disabled').removeAttr('readonly');
		$('#btn_S_ORGCD').removeAttr('disabled').removeClass('disabled');
	} 
 	
	
		$('#S_COMPCD').val(cfn_loginInfo().WHCD);
		$('#S_COMPNM').val(cfn_loginInfo().WHNM);

}

/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg){
	//폼 필수입력 체크
	if (!cfn_isFormRequireData('frmDetail')) return false;
	gv_searchData = cfn_getFormData('frmDetail');
	
	if (confirm('저장하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/p000021/setSave.do';
		var sendData = {'paramData':gv_searchData};
		
		gfn_sendData(sid, url, sendData);
	}
	
}

/* 공통버튼 - 취소 클릭 */
function cfn_del(){
	gv_searchData = cfn_getFormData('frmDetail');

	if(cfn_isEmpty($('#S_ORGCD').val()) || cfn_isEmpty($('#S_ORGNM').val())){
		cfn_msg('WARNING', '셀러코드를 입력하여주세요');
		return false
	}
	
	if (confirm('취소하시겠습니까?')) {

		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000021/setDelete.do';
		var sendData = {'paramData':gv_searchData};

		gfn_sendData(sid, url, sendData);
	}
}


</script>

<c:import url="/comm/contentBottom.do" />