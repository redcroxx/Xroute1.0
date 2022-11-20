<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P700300
	화면명    : 로케이션변경 - 마스터,디테일  RealGrid -> 총 2개 (장바구니 형태) 
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="S_COMPNM" class="cmc_code" />
	<input type="hidden" id="C_CHKWHCD" class="cmc_code" />
	<input type="hidden" id="C_CHKWHNM" class="cmc_code" />
	
	<ul class="sech_ul">
		<li class="sech_li required">
			<div class="required">창고</div>
			<div> 
				<input type="text" id="S_WHCD" class="cmc_code required"/>
				<input type="text" id="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<li class="sech_li">
			<div>로케이션그룹</div>
			<div>
				<select id="S_LOCGROUP" class="cmc_combo">
					<option value="">전체</option>
					<c:forEach var="i" items="${codeLOCGROUP}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
		<li class="sech_li">
			<div>로케이션</div>
			<div>
				<input type="text" id="S_LOCCD" class="cmc_code" />
			</div>
		</li>
	</ul>				
	<ul class="sech_ul">
		<li class="sech_li">
			<div>품목코드/명</div>
			<div>
				<input type="text" id="S_ITEM" class="cmc_txt" /> 
			</div>
		</li>
		<li class="sech_li">
			<div>로트키</div>
			<div>
				<input type="text" id="S_LOTKEY" class="cmc_txt" /> 
			</div>
		</li>
		
	</ul>
	<div id="sech_extbtn" class="down"></div>
	<div id="sech_extline"></div>
	<div id="sech_extwrap">
		<!-- 화주  조회조건 -->
		<ul class="sech_ul">
			<li class="sech_li required">
				<div class="required">화주</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code required" />
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
		</ul>
		<c:import url="/comm/compItemSearch.do" />
	</div>		
	</form>
</div>
<!-- 검색조건 영역 끝 -->


<!-- Mst그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">재고 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- Det그리드 시작 -->
<div class="ct_bot_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">이동 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="text" id="D_LOCCD" class="cmc_code" />
			<input type="hidden" id="D_LOCCD_R" class="cmc_value" />
			<button type="button" class="cmc_cdsearch"></button>	
			<input type="button" id="btn_applyAll" class="cmb_normal" value="일괄적용" onclick="fn_applyAll();"/>
			<input type="button" class="cmb_normal" value="수량자동세팅" onclick="fn_QtySetting();"/>				
			<input type="button" id="btn_detailAdd" class="cmb_plus" onclick="fn_detailAdd();"/>
			<input type="button" id="btn_detailDel" class="cmb_minus" onclick="fn_detailDel();" />
		</div>
	</div>
	<div id="grid2"></div>
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

	//로그인 정보로 셋팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM); 
	$('#S_WHCD').val(cfn_loginInfo().WHCD);
	$('#S_WHNM').val(cfn_loginInfo().WHNM);
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD); 
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	
	grid1_Load();
	grid2_Load();
	
	/* 공통코드 코드/명 (창고) */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_COMPNM:'S_COMPNM',S_WHCD:'S_WHCD,S_WHNM'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	
	/* 공통코드 코드/명 (화주) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_COMPNM:'S_COMPNM',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	/* 공통코드 코드/명 (로케이션) 
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'S_LOCCD',
		inparam:{S_LOCCD:'S_LOCCD',S_WHCD:'S_WHCD'},
		outparam:{LOCCD:'S_LOCCD'}, 
		beforeFn: function() {
			if(cfn_isEmpty($('#S_WHCD').val())){
				cfn_msg('WARNING','창고를 선택하세요.');
				return false;
			}
		}
	});*/
	
	/* 이동 리스트 로케이션 */
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do', codeid:'D_LOCCD',
		inparam:{S_COMPCD:'S_COMPCD',S_LOCCD:'D_LOCCD,D_LOCCD_R',S_WHCD:'C_CHKWHCD',S_WHNM:'C_CHKWHNM'},
		outparam:{LOCCD:'D_LOCCD,D_LOCCD_R'},
		beforeFn: function() { 
			var c_chkwhcd = $('#C_CHKWHCD').val();
			var c_chkwhnm = $('#C_CHKWHNM').val();
			
			//전체 행의 개수
			var endidx = $('#grid2').dataProvider().getRowCount();
			
			if (endidx < 1) {
				cfn_msg('WARNING', '품목을 추가하세요.');
				return false;
			}
			
			if (cfn_isEmpty(c_chkwhcd)) {
				cfn_msg('WARNING', '창고를 선택하세요.');					
				return false;
			}
		}
	})

 	if( $('#S_ORGCD').val().length > 0) {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}
	
	if ($('#S_WHCD').val().length > 0) {
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	}		
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품명'},width:250},
		{name:'ITEMSIZE',header:{text:'규격'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},styles:{textAlignment:'center'}},
		{name:'LOCCD',header:{text:'로케이션'},width:110,styles:{textAlignment:'center'}},
		{name:'AVAILQTY',header:{text:'가용수량'},width:120,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},		
		{name:'QTY',header:{text:'재고수량'},width:120,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},		
		{name:'ALLOCQTY',header:{text:'할당수량'},width:120,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'LOTKEY',header:{text:'로트키'},width:100,styles:{textAlignment:'center'}},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1),show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2),show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3),show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100,show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100,show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100,show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100,show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100,show:cfn_getCompItemVisible(15)},
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,show:false},
		{name:'ORGCD',header:{text:'화주코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ORGNM',header:{text:'화주명'},width:100,styles:{textAlignment:'center'}},
		{name:'WHCD',header:{text:'창고코드'},width:100,styles:{textAlignment:'center'}},
		{name:'WHNM',header:{text:'창고명'},width:100,styles:{textAlignment:'center'}}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true});
	
	//그리드 설정 및 이벤트 처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {

		//셀 더블클릭 (추가)
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $('#grid1').gfn_getCurRowIdx();
			var gridData = $('#grid1').gfn_getDataRow(rowidx);
			$('#C_CHKWHCD').val(gridData.WHCD);
			$('#C_CHKWHNM').val(gridData.WHNM);
			
			$('#grid2').gfn_addRow(gridData);
		};

	});
	
}
function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품명'},width:250},
		{name:'ITEMSIZE',header:{text:'규격'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'LOCCD',header:{text:'로케이션'},formatter:'popup',width:110,styles:{textAlignment:'center'}},
		{name:'AFTERLOCCD',header:{text:'변경 로케이션'},formatter:'popup',width:110, editable:true,required:true,styles:{textAlignment:'center'},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
						 inparam:{S_COMPCD:'COMPCD',S_LOCCD:'AFTERLOCCD',S_WHCD:'WHCD',S_WHNM:'WHNM'},
						 outparam:{LOCCD:'AFTERLOCCD'} }},
		{name:'AVAILQTY',header:{text:'변경 가능수량'},width:120,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},		
		{name:'AFTERQTY_BOX',header:{text:'변경[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'AFTERQTY_EA',header:{text:'변경[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'AFTERQTY',header:{text:'변경 수량'},width:120, editable:true, required:true, dataType:'number',editor:{maxLength:11,type:"number",positiveOnly:true,integerOnly:true},styles:{textAlignment:'far',numberFormat:'#,##0'},minVal:1,
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},		
		{name:'REMARK',header:{text:'비고'},width:300,editable:true,editor:{maxLength:200}},
		{name:'LOTKEY',header:{text:'로트키'},width:100,styles:{textAlignment:'center'}},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1),show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2),show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3),show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100,show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100,show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100,show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100,show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100,show:cfn_getCompItemVisible(15)},
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,show:false},
		{name:'ORGCD',header:{text:'화주코드'},width:100,show:false},
		{name:'ORGNM',header:{text:'화주명'},width:100,show:false},
		{name:'WHCD',header:{text:'창고코드'},width:100,show:false},
		{name:'WHNM',header:{text:'창고명'},width:100,show:false},
		{name:'TOTAVAILQTY',header:{text:'총가용수량'},width:120,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true,mstGrid:'grid1'});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		//셀 수정 이벤트
	    gridView.onEditChange = function(grid, column, value) {
	    	if (column.column === 'AFTERQTY') {
	    		//var AFTAVAILQTY = $('#' + gid).gfn_getValue(column.dataRow, 'AFTAVAILQTY_R');
	    		//$('#' + gid).gfn_setValue(column.dataRow, 'AFTAVAILQTY', value + AFTAVAILQTY);
	    		
	    		var INBOXQTY = $('#' + gid).gfn_getValue(column.dataRow, 'INBOXQTY'); //BOX입수량
	    		var UNITTYPE = $('#' + gid).gfn_getValue(column.dataRow, 'UNITTYPE'); //관리단위
	    		
	    		if (INBOXQTY <= 0){
	    			$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_BOX', 0); 
		    		$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_EA', 0);
		    		
		    		cfn_msg('ERROR', '품목의 박스입수량이 잘못되었습니다.');
		    		return false;
	    		}
	    		
	    		if (UNITTYPE == 'BOXEA'){
	    			$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_BOX', parseInt(value / INBOXQTY)); 
		    		$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_EA', parseInt(value % INBOXQTY));	
	    		} else if (UNITTYPE == 'EA'){
	    			$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_BOX', 0); 
		    		$('#' + gid).gfn_setValue(column.dataRow, 'AFTERQTY_EA', value);	
	    		}	    		
	    	} 
	    };		
		
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	
	//검색
	if(sid == 'sid_getSearch') {
		$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	
	//디테일리스트 검색
	if(sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//실행
	if(sid == 'sid_setExecute') {
		$('#grid1').gfn_setFocusPK(data.resultData, ['ITEMCD']); 
		cfn_msg('INFO', '정상적으로 실행되었습니다.');
		$('#grid1').gfn_clearData();
		$('#grid2').gfn_clearData();
		
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('C_CHKWHCD').val('');
	$('C_CHKWHNM').val('');

	$('#grid1').gridView().cancel();
	$('#grid2').gridView().cancel();
	
	//폼 필수입력 체크
	if (!cfn_isFormRequireData('frmSearch')) return false;
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p700/p700300/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p700/p700200/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 실행 클릭 */
function cfn_execute() {
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);

	var detailData = $('#grid2').gfn_getDataList();
	
	if (detailData.length < 1){
		cfn_msg("WARNING", '선택된 전표가 없습니다.');
		return false;
	}
	
	for (var i=0; i< detailData.length; i++) {
		if(detailData[i].AVAILQTY < detailData[i].AFTERQTY) { //AVAILQTY: 가용수량 , AFTERQTY: 이동수량
			cfn_msg('WARNING', '이동수량이 이동가용수량보다 많습니다.');
			$('#grid2').gfn_setFocusPK(detailData[i], ['COMPCD','ORGCD','ITEMCD','AFTERQTY']);
			$('#grid2').gfn_focusPK();
			return;			
		}else if(detailData[i].LOCCD == detailData[i].AFTERLOCCD) { //LOCCD: 이동 전 로케이션 , AFTERLOCCD: 이동 후 로케이션
			cfn_msg('WARNING', '현로케이션과 변경로케이션이 같습니다.');
			$('#grid2').gfn_setFocusPK(detailData[i], ['COMPCD','ORGCD','ITEMCD','AFTERLOCCD']);
			$('#grid2').gfn_focusPK();
			return;					
		}
	}
	
	//디테일 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;
	
	if (confirm('로케이션을 변경하시겠습니까?') == true) {
		var sid = 'sid_setExecute';
		var url = '/alexcloud/p700/p700300/setExecute.do';
		var sendData = {'paramDataList':detailData};
	
		gfn_sendData(sid, url, sendData);
	} 
}


/* 로케이션 일괄적용 */
function fn_applyAll() {
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);

	//디테일 로케이션
	var loccd = $('#D_LOCCD_R').val();
	
	if(loccd == null || loccd == '') {
		cfn_msg('WARNING', '이동할 로케이션을 검색해주세요.');
		return false;
	}
	
	
	//전체 행의 개수
	var endidx = $('#grid2').dataProvider().getRowCount();
	
	if(endidx == 0){
		cfn_msg('WARNING',' 적용할 내역이 없습니다.');
		return false;
	}
 	if(endidx > 0) {
		for(var i=0; i < endidx; i++) {
			$('#grid2').gfn_setValue(i,'AFTERLOCCD', loccd);
		}
	}
	
	$('#D_LOCCD').val(''); 
	$('#D_LOCCD_R').val('');
}
//디테일 그리드 추가 버튼 이벤트
function fn_detailAdd() {
	var checkRows = $('#grid1').gridView().getCheckedRows();
	var gridData = $('#grid1').gfn_getDataRows(checkRows);

	if(cfn_isEmpty(checkRows)) {
		cfn_msg('WARNING','선택된 품목이 없습니다.');
		return false;
	}
	
	$('#C_CHKWHCD').val(gridData[0].WHCD);
	$('#C_CHKWHNM').val(gridData[0].WHNM);
	
	for (var i=0;i<checkRows.length;i++) {
		$('#grid2').gfn_addRow(gridData[i]);
	}
	//체크해제
	$('#grid1').gridView().checkAll(false);
	

}  

//디테일 그리드 삭제 버튼 이벤트
function fn_detailDel() {
	var rowidx = $('#grid2').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	$('#grid2').gfn_delRow(rowidx);
}  

//수량자동세팅
function fn_QtySetting(){
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);

	var gridData = $('#grid2').gfn_getDataList();

 	for(var i=0; i<gridData.length;i++) {
		$('#grid2').gfn_setValue([i],'AFTERQTY',gridData[i].AVAILQTY);
	} 
}

</script>

<c:import url="/comm/contentBottom.do" />