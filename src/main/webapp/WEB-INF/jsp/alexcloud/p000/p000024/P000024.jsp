<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000024
	화면명    : 창고별 피킹렉
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="S_COMPCD" class="cmc_code" />
		<ul class="sech_ul">
			<li class="sech_li required">
				<div>셀러</div>
				<div>
					<input type="text" id="S_ORGCD" name="S_ORGCD" class="cmc_code required" />
					<input type="text" id="S_ORGNM" name="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li required">
				<div>창고</div>
				<div>
					<input type="text" id="S_WHCD" name="S_WHCD" class="cmc_code required" />
					<input type="text" id="S_WHNM" name="S_WHNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>		
			<li class="sech_li">
				<div>등록여부</div>
				<div>
					<select id="S_REGFLG" name="S_REGFLG" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${codeP009TYPE}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
		</ul>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>품목코드/명</div>
				<div>		
					<input type="text" id="S_ITEMCD" name="S_ITEMCD" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li">
				<div>카트렉번호</div>
				<div>		
					<input type="text" id="S_CART_RACK_NO" name="S_CART_RACK_NO" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li">
				<div>DPS렉번호</div>
				<div>		
					<input type="text" id="S_DPS_RACK_NO" name="S_DPS_RACK_NO" class="cmc_txt" />
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">창고별 품목<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<select id="RACKNO" class="cmc_combo" style="width:110px">
				<option value="CART">카트렉번호</option>
				<option value="DPS">DPS렉번호</option>
			</select>
			<input type="text" id="RACKAPPLY" class="cmc_code" />
			<input type="button" id="btn_rackApply" class="cmb_normal" value="일괄등록" onclick="fn_rackApply();" />
			<input type="button" id="btn_upload" class="cmb_normal" value="업로드" onclick="pfn_upload('P000024');" />
		</div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

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

	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	
 	/* 셀러 */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	/* 창고 */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'S_WHCD,S_WHNM'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
		
	/* if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
		$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
		$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	} 
 	
 	if(!cfn_isEmpty(cfn_loginInfo().WHCD)){
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
		$('#S_WHCD').val(cfn_loginInfo().WHCD);
		$('#S_WHNM').val(cfn_loginInfo().WHNM);
	}  */
	
	
	authority_Load();
	grid1_Load();
});

function authority_Load(){
	if (cfn_loginInfo().USERGROUP = '${CENTER_ADMIN}') {
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	} else if(cfn_loginInfo().USERGROUP = '${CENTER_SUPER}') {
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	} else if(cfn_loginInfo().USERGROUP = '${CENTER_USER}') {
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	} else if(cfn_loginInfo().USERGROUP = '${SELLER_ADMIN}') {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	} else if(cfn_loginInfo().USERGROUP = '${SELLER_SUPER}') {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	} else if(cfn_loginInfo().USERGROUP = '${SELLER_USER}') {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	};
};

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'ISREG',header:{text:'등록여부'},width:90,formatter:'combo',comboValue:'${gCodeP009TYPE}',
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = "Y"',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = "N"',styles:{figureBackground:cfn_getStsColor(0)}}
			]
		},
		{name:'WHCD',header:{text:'창고코드'},width:80},
		{name:'WHNM',header:{text:'창고명'},width:100,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'셀러코드'},width:100},
		{name:'ORGNM',header:{text:'셀러명'},width:120,styles:{textAlignment:'center'}},
		{name:'ITEMCD',header:{text:'품목코드'},width:120,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:300},
		
		
		{name:'CART_GROUP',header:{text:'카트작업그룹'},width:120,editable:true,editor:{maxLength:30}},	
		{name:'CART_RACK_NO',header:{text:'카트렉번호'},width:120,editable:true,editor:{maxLength:30}},	
		{name:'DPS_GROUP',header:{text:'DPS작업그룹'},width:120,editable:true,editor:{maxLength:30}},	
		{name:'DPS_RACK_NO',header:{text:'DPS렉번호'},width:120,editable:true,editor:{maxLength:30}},	
		{name:'REMARK',header:{text:'비고'},width:200,editable:true,editor:{maxLength:200}},	
		
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true,footerflg:false});
	
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid1').gridView().commit();
		var gridData = data.resultList;
		$('#grid1').gfn_setDataList(gridData);
				
		//검색결과에 따른 마스터 데이터 포커스 이동 처리
		$('#grid1').gfn_focusPK();
	}
	//저장
	else if (sid === 'sid_setSave') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','ORGCD','WHCD','ITEMCD']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//삭제
	else if (sid === 'sid_setDelete') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','ORGCD','WHCD','ITEMCD']);
		cfn_msg('INFO', '정상적으로 처리되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('#grid1').gridView().commit();
	
	if (!cfn_isFormRequireData('frmSearch')) return false; //필수입력 체크
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000024/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 저장 클릭 */
function cfn_save() {
	$('#grid1').gridView().commit();
	
	var checkRows = $('#grid1').gridView().getCheckedRows();
	if (checkRows.length < 1) {
		alert('선택된 행이 없습니다.');
		return false;
	}
	
	if ($('#grid1').gfn_checkValidateCells(checkRows)) return false; //필수입력 체크
	
	var gridData = $('#grid1').gfn_getDataRows(checkRows);
	
	if (confirm('저장하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/p000024/setSave.do';
		var sendData = {'paramList':gridData};
		
		gfn_sendData(sid, url, sendData);
	}
}

/* 공통버튼 - 삭제 클릭 */
function cfn_del() {
	$('#grid1').gridView().commit();
	
	var checkRows = $('#grid1').gridView().getCheckedRows();
	if (checkRows.length < 1) {
		alert('선택된 행이 없습니다.');
		return false;
	}
	
	var gridData = $('#grid1').gfn_getDataRows(checkRows);
		
	if (confirm('삭제하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000024/setDelete.do';
		var sendData = {'paramList':gridData};

		gfn_sendData(sid, url, sendData);
	}
}

//일괄등록
function fn_rackApply(){
	$('#grid1').gridView().commit();
	
	var rackApply = $('#RACKAPPLY').val();
	if(cfn_isEmpty(rackApply)){
		cfn_msg('WARNING','렉번호를 입력하세요.');
		return;
	}
	
	var rackno = $('#RACKNO').val();
	
	var checkRows = $('#grid1').gridView().getCheckedRows();
	if (checkRows.length < 1) {
		alert('선택된 행이 없습니다.');
		return false;
	}
	
	if(rackno === 'CART') {
		rackno = 'CART_RACK_NO';	
	} else if (rackno === 'DPS') {
		rackno = 'DPS_RACK_NO';
	} else {
		return false;
	}
	
	for (var i=0, len=checkRows.length; i<len; i++) {
		$('#grid1').gfn_setValue(checkRows[i], rackno, rackApply);
	}
}
</script>

<c:import url="/comm/contentBottom.do" />