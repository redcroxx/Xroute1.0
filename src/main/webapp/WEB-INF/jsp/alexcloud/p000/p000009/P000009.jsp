<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000009
	화면명    : 품목별로케이션 관리
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="C_CHKWHCD" class="cmc_code" />
		<ul class="sech_ul">
			<li class="sech_li required">
				<div>회사</div>
				<div>
					<input type="text" id="S_COMPCD" class="cmc_code required" readonly="readonly" disabled/>				
					<input type="text" id="S_COMPNM" class="cmc_value" readonly="readonly" disabled/>
					<button type="button" class="cmc_cdsearch" disabled></button>
				</div>
			</li>
			<li class="sech_li required">
				<div  style="width:120px">셀러</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code required" />				
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" id="S_ORGCD_BTN" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li required">
				<div>창고코드/명</div>
				<div>
					<input type="text" id="S_WHCD" class="cmc_code required" />
					<input type="text" id="S_WHNM" class="cmc_value" />
					<button type="button" id="S_WHCD_BTN" class="cmc_cdsearch"></button>
				</div>
			</li>
		</ul>
		<ul class="sech_ul">	
			<li class="sech_li">
				<div>품목분류</div>
				<div>
					<input type="text" id="S_ITEMCATCD" class="cmc_code" />				
					<input type="text" id="S_ITEMCATNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li">
				<div  style="width:120px">품목코드/명</div>
				<div>
					<input type="text" id="S_ITEM" class="cmc_txt" />
				</div>
				<li class="sech_li">
				<div>등록여부</div>
				<div>
					<select id="S_REGFLG" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_P009TYPE}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
		</ul>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>
					<select id="S_P009LOCTYPE" class="cmc_combo">
						<c:forEach var="i" items="${CODE_P009LOCTYPE}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
				<div>
					<input type="text" id="S_LOCCD" class="cmc_txt" />
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">창고별 품목<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="button" id="btn_upload" class="cmb_normal" value="업로드" onclick="pfn_upload('P000009');" />
			<select id="A_P009LOCTYPE" class="cmc_combo" style="width:110px">
				<c:forEach var="i" items="${CODE_P009LOCTYPE}">
					<option value="${i.code}">${i.value}</option>
				</c:forEach>
			</select>
			<input type="text" id="A_LOCAPPLY" class="cmc_code" />
			<input type="hidden" id="A_LOCAPPLY_R" class="cmc_value" />
			<button type="button" class="cmc_cdsearch" ></button>
			<button type="button" id="BTN_LOCAPPLY" class="cmb_normal" onclick="fn_locapply()">일괄등록</button>
		</div>
	</div>
	<div id="grid1"></div>
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
  * 버튼 순서 : setCommBtnSeq(['ret','list']) : ret,list,new,del,save,copy,init,execute,cancel,print,excelup,exceldown,user1,2,3,4,5
  * 버튼 표시/숨김 : setCommBtn('ret', true) : ret,list,new,del,save,copy,init,execute,cancel,print,excelup,exceldown,user1,2,3,4,5
  * ===============================
--%>
//초기 로드
$(function() {
	initLayout();
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_WHCD').val(cfn_loginInfo().WHCD);
	$('#S_WHNM').val(cfn_loginInfo().WHNM); 
	
	grid1_Load();
	authority_Load();

	//회사 코드/명
	pfn_codeval({
		url:'/alexcloud/popup/popP001/view.do',codeid:'S_COMPCD',
		inparam:{S_COMPCD:'S_COMPCD,S_COMPNM'},
		outparam:{COMPCD:'S_COMPCD',NAME:'S_COMPNM'}
	});
	//셀러
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD', S_COMPNM:'S_COMPNM', S_ORGCD:'S_ORGCD'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	//창고 코드/명
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'S_WHCD,S_WHNM'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	//품목분류 코드/명
	pfn_codeval({
		url:'/alexcloud/popup/popP017/view.do',codeid:'S_ITEMCATCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ITEMCAT:'S_ITEMCATCD,S_ITEMCATNM'},
		outparam:{ITEMCATCD:'S_ITEMCATCD',NAME:'S_ITEMCATNM'}
	});
	
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'A_LOCAPPLY',
		inparam:{S_COMPCD:'S_COMPCD',S_LOCCD:'A_LOCAPPLY,A_LOCAPPLY_R',S_WHCD:'S_WHCD', S_WHNM : 'S_WHNM'},
		outparam:{LOCCD:'A_LOCAPPLY,A_LOCAPPLY_R'},
	});	
	
 	/* if($('#S_ORGCD').val().length > 0){
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}
	
	if($('#S_WHCD').val().length > 0){
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	} */
	
	
	
});

function authority_Load(){
	if (cfn_loginInfo().USERGROUP == '${SELLER_ADMIN}' || cfn_loginInfo().USERGROUP == '${CENTER_ADMIN}' || cfn_loginInfo().USERGROUP == '${CENTER_USER}') {
		$('#S_WHCD').val(cfn_loginInfo().WHCD);
		$('#S_WHNM').val(cfn_loginInfo().WHNM);
		$('#S_WHCD').prop("disabled",true);
		$('#S_WHNM').prop("disabled",true);
		$('#S_WHCD_BTN').prop("disabled",true);
		$('#S_ORGCD_BTN').prop("disabled",true);
		$('#S_ORGCD').prop("disabled",true);
		$('#S_ORGNM').prop("disabled",true);
 	}
};

function grid1_Load() {
	var gid = 'grid1', $grid = $('#' + gid);
	var columns = [
		{name:'REGFLG',header:{text:'등록여부'},width:100,formatter:'combo',comboValue:'${GCODE_P009TYPE}',
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = "Y"',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = "N"',styles:{figureBackground:cfn_getStsColor(0)}}
			]
		},
		{name:'COMPCD',header:{text:'회사코드'},width:80,visible:false,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,visible:false,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:80,visible:false,show:false},
		{name:'ORGNM',header:{text:'셀러명'},width:150,styles:{textAlignment:'center'}},
		{name:'WHCD',header:{text:'창고코드'},width:80},
		{name:'WHNM',header:{text:'창고명'},width:160,styles:{textAlignment:'center'}},
		{name:'ITEMCD',header:{text:'품목코드'},width:120,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:360},
		{name:'SLOTLOCCD',header:{text:'보관로케이션'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
				inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'WHNM',S_LOCCD:'SLOTLOCCD'},outparam:{LOCCD:'SLOTLOCCD'}}
		},
		{name:'PICKLOCCD',header:{text:'피킹로케이션'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
				inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'WHNM',S_LOCCD:'PICKLOCCD'},outparam:{LOCCD:'PICKLOCCD'}}
		},
		{name:'ITEMTYPE',header:{text:'품목유형'},width:100,formatter:'combo',comboValue:'${GCODE_ITEMTYPE}',styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'ITEMSIZE',header:{text:'규격'},width:80},
		{name:'ITEMCAT1NM',header:{text:'대분류'},width:120},
		{name:'ITEMCAT2NM',header:{text:'중분류'},width:120},
		{name:'ITEMCAT3NM',header:{text:'소분류'},width:120},
		{name:'SETYN',header:{text:'세트여부'},width:100,formatter:'combo',comboValue:'${GCODE_SETYN}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'박스입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'LENGTH',header:{text:'깊이'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0.###'}},
		{name:'WIDTH',header:{text:'폭'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0.###'}},
		{name:'HEIGHT',header:{text:'높이'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0.###'}},
		{name:'CAPACITY',header:{text:'용량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0.###'}},
		{name:'MANUFACTURE',header:{text:'제조사'},width:100},
		{name:'MANUCOUNTRY',header:{text:'제조국'},width:100},
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:'${gCodeFUSER01}',styles:{textAlignment:'center'},show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:'${gCodeFUSER02}',styles:{textAlignment:'center'},show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:'${gCodeFUSER03}',styles:{textAlignment:'center'},show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:'${gCodeFUSER04}',styles:{textAlignment:'center'},show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:'${gCodeFUSER05}',styles:{textAlignment:'center'},show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100,show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100,show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100,show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100,show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100,show:cfn_getCompItemVisible(15)},
		{name:'REMARK',header:{text:'비고'},width:400},
		{name:'ADDUSERCD',header:{text:'등록자'},width:120,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'},visible:false,show:false},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'},visible:false,show:false},
	];
	$grid.gfn_createGrid(columns, {checkBar:true,footerflg:false});
}

//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid1').gridView().commit();
		var gridData = data.resultList;
		$('#grid1').gfn_setDataList(gridData);
		
		$('#C_CHKWHCD').val(gridData.WHCD);
		
		//검색결과에 따른 마스터 데이터 포커스 이동 처리
		$('#grid1').gfn_focusPK();
	}
	//저장
	else if (sid === 'sid_setSave') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','WHCD','ITEMCD']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//삭제
	else if (sid === 'sid_setDelete') {
		var resultData = data.resultData;
		
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD','WHCD','ITEMCD']);
		cfn_msg('INFO', '정상적으로 처리되었습니다.');
		cfn_retrieve();
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	$('#grid1').gridView().commit();
	
	if (!cfn_isFormRequireData('frmSearch')) return false;
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000009/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

//공통버튼 - 저장 클릭
function cfn_save() {
	$('#grid1').gridView().commit();
	
	var $grid1 = $('#grid1');
	var checkRows = $grid1.gridView().getCheckedRows();
	
	if (checkRows.length < 1) {
		alert('선택된 행이 없습니다.');
		return false;
	}

	//필수입력 체크
	if ($grid1.gfn_checkValidateCells(checkRows)) return false;
	
	var gridData = $grid1.gfn_getDataRows(checkRows);
	
	if (confirm('저장하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/p000009/setSave.do';
		var sendData = {'paramList':gridData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 삭제 클릭
function cfn_del() {
	$('#grid1').gridView().commit(true);
	
	var $grid1 = $('#grid1');
	var checkRows = $grid1.gridView().getCheckedRows();
	
	if (checkRows.length < 1) {
		alert('선택된 행이 없습니다.');
		return false;
	}
	
	var gridData = $grid1.gfn_getDataRows(checkRows);
	
	if (confirm('삭제하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000009/setDelete.do';
		var sendData = {'paramList':gridData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//일괄등록 버튼 클릭
function fn_locapply() {
	var loccd = $('#A_LOCAPPLY_R').val();
	
	if(cfn_isEmpty(loccd)) {
		cfn_msg('WARNING','로케이션을 확인하세요.');
		return;
	}
	
	var $grid1 = $('#grid1');
	var loctype = $('#A_P009LOCTYPE').val();
	
	var checkRows = $grid1.gridView().getCheckedRows();
	
	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	if (loctype === 'SLOT') {
		loctype = 'SLOTLOCCD';
	} else if (loctype === 'PICK') {
		loctype = 'PICKLOCCD';
	} else {
		return false;
	}
	
	for (var i=0, len=checkRows.length; i<len; i++) {
		$grid1.gfn_setValue(checkRows[i], loctype, loccd);
	}
}

</script>

<c:import url="/comm/contentBottom.do" />