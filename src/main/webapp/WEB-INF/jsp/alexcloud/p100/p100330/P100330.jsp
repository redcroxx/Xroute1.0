<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100330
	화면명    : 입고관리 > 적치지시
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<ul class="sech_ul">
		<li class="sech_li required">
			<div style="width:100px">창고</div>
			<div style="width:250px">	
				<input type="text" id="S_WHCD" name="S_WHCD" class="cmc_code required"/>
				<input type="text" id="S_WHNM" name="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>	
		<li class="sech_li required">
			<div>셀러</div>
			<div>
				<input type="text" id="S_ORGCD" class="cmc_code required" />
				<input type="text" id="S_ORGNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<li class="sech_li">
			<div style="width:100px">품목코드/명</div>
			<div style="width:250px">		
				<input type="text" id="S_ITEM" name="S_ITEM" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<div id="sech_extbtn" class="down"></div>
	<div id="sech_extline"></div>
	<div id="sech_extwrap">
		<!-- 회사별 상품정보 조회조건 -->
		<c:import url="/comm/compItemSearch.do" />
	</div>
	
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고적치 지시 리스트</div>
		<div class="grid_top_right">
			<span style="font-size: 12px; font-weight: bold; padding-left:20px; padding-right:10px">※ 지시 로케이션 추천순서 ( 1 : 품목별  보관 지정 로케이션 | 2 : 해당 품목이 가장 많이 적치된 로케이션과 가장 가까운 로케이션 | 3 : 비어 있는 로케이션 중, 가장 가까운 로케이션 )</span>
			<input type="text" id="A_LOCCD" class="cmc_code" />
			<input type="hidden" id="A_LOCCD_R" class="cmc_value" />
			<button type="button" class="cmc_cdsearch"></button>
			<input type="button" id="btn_applyAll" class="cmb_normal" value="일괄적용" onclick="fn_applyAll();"/>
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
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_WHCD').val(cfn_loginInfo().WHCD); 
	$('#S_WHNM').val(cfn_loginInfo().WHNM); 
	
	grid1_Load();
		
	/* 공통코드 코드/명 (창고) */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'S_WHCD,S_WHNM'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});

	/* 공통코드 코드/명 (셀러) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	/* 공통코드 코드/명 (로케이션 일괄적용) */
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'A_LOCCD',
		inparam:{S_COMPCD:'S_COMPCD',S_LOCCD:'A_LOCCD,A_LOCCD_R',S_WHCD:'S_WHCD',S_WHNM:'S_WHNM'},
		outparam:{LOCCD:'A_LOCCD,A_LOCCD_R'},
		beforeFn: function() { 
			//전체 행의 개수
			var endidx = $('#grid1').dataProvider().getRowCount();
			
			if(endidx < 1) {
				cfn_msg('WARNING', '적치리스트가 존재하지 않습니다.');
				return false;
			}
			
			if(cfn_isEmpty($('#S_WHCD').val())) {
				cfn_msg('WARNING', '창고를 선택하세요.');					
				return false;
			}

		}
	});

	if ($('#S_ORGCD').val().length > 0) {
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
		{name:'WHCD',header:{text:'창고코드'},width:80,styles:{textAlignment:'center'}},
		{name:'WHNM',header:{text:'창고'},width:100,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'셀러코드'},width:80,styles:{textAlignment:'center'}},
		{name:'ORGNM',header:{text:'셀러명'},width:100,styles:{textAlignment:'center'}},
		
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:250},
		{name:'WHINLOCCD',header:{text:'입고존'},width:100,styles:{textAlignment:'center'}},
		{name:'SCHLOCCD',header:{text:'지시로케이션'},formatter:'popup',width:100,styles:{textAlignment:'center'},editable:true, required:true,
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
				inparam:{S_WHCD:'WHCD',S_WHNM:'WHNM',S_LOCCD:'SCHLOCCD'},
				outparam:{LOCCD:'SCHLOCCD'},
				returnFn: function(data, type) {
				}
			}
		},
		{name:'QTY',header:{text:'적치대상수량'},width:120,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'MVQTY',header:{text:'적치지시수량'},width:120,dataType:'number',minVal:1,styles:{textAlignment:'far',numberFormat:'#,##0'},editable:true, required:true,
			editor:{maxLength:11,type:'number',positiveOnly:true,integerOnly: true},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},/* 
		{name:'MVQTY_BOX',header:{text:'이동[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'MVQTY_EA',header:{text:'이동[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
			 */
		{name:'IMSCHQTY',header:{text:'적치진행수량'},width:120,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		
		{name:'LOTKEY',header:{text:'로트번호'},width:100,styles:{textAlignment:'center'}},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, editor:{maxLength:50},formatter:cfn_getLotType(1), show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, editor:{maxLength:50},formatter:cfn_getLotType(2), show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, editor:{maxLength:50},formatter:cfn_getLotType(3), show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		
		{name:'REMARK',header:{text:'비고'},width:300, editable:true, maxlength:200},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'박스입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'INPLTQTY',header:{text:'팔레트입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		
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
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true,editable:true,mstGrid:'grid1'});
	
	$('#' + gid).gridView().setCheckableExpression("values['QTY'] <> '0'", true);
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
	    //셀 수정 이벤트
	    gridView.onCellEdited = function(grid, itemIdx, dataRow, fieldIdx) {
    		var qty = $('#' + gid).gfn_getValue(dataRow, 'QTY');
    		var mvqty = $('#' + gid).gfn_getValue(dataRow, 'MVQTY');
    		if(qty < mvqty){
				$('#' + gid).gfn_setValue(dataRow, 'MVQTY', 0);
				cfn_msg('WARNING', '적치대상수량 이하로 입력하시기 바랍니다.');
			}
	    };
	    
	  	//셀 수정 이벤트
	    gridView.onEditChange = function(grid, column, value) {
	    	if (column.column === 'MVQTY') {
	    		var INBOXQTY = $('#' + gid).gfn_getValue(column.dataRow, 'INBOXQTY');
	    		var UNITTYPE = $('#' + gid).gfn_getValue(column.dataRow, 'UNITTYPE');
	    		
	    		if (INBOXQTY <= 0){
	    			$('#' + gid).gfn_setValue(column.dataRow, 'MVQTY_BOX', 0); 
		    		$('#' + gid).gfn_setValue(column.dataRow, 'MVQTY_EA', 0);
		    		
		    		cfn_msg('ERROR', '품목의 박스입수량이 잘못되었습니다.');
		    		return false;
	    		}
	    	
	    		if (UNITTYPE == 'BOXEA'){
	    			$('#' + gid).gfn_setValue(column.dataRow, 'MVQTY_BOX', parseInt(value / INBOXQTY)); 
		    		$('#' + gid).gfn_setValue(column.dataRow, 'MVQTY_EA', parseInt(value % INBOXQTY));	
	    		} else if (UNITTYPE == 'EA'){
	    			$('#' + gid).gfn_setValue(column.dataRow, 'MVQTY_BOX', 0); 
		    		$('#' + gid).gfn_setValue(column.dataRow, 'MVQTY_EA', value);	
	    		}
	    	} 
	    };
	    
	    //셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var editable = grid.getValue(newRowIdx, 'QTY') != 0
				$('#grid1').gfn_setColDisabled(['SCHLOCCD','MVQTY', 'REMARK'], editable);
			}
		};
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid1').gfn_setDataList(data.resultList);
	}
	//입고실적 처리 
	if (sid == 'sid_instruct') {
		cfn_msg('INFO', '적치지시 되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	
	$('#grid1').gridView().cancel();
	
	//검색조건 필수입력 체크
	if(cfn_isFormRequireData('frmSearch') == false) return; 
	
	gv_searchData = cfn_getFormData('frmSearch');

	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100330/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 입고 적치지시 처리 */
function cfn_execute() {
	
	var formdata = cfn_getFormData('frmSearch');

	$('#grid1').gridView().commit();
	
	var checkRows = $('#grid1').gridView().getCheckedRows();
	
	if (checkRows.length < 1) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	// 필수 입력 체크 
	if ($('#grid1').gfn_checkValidateCells(checkRows)) return false;
	
	var gridData = $('#grid1').gfn_getDataRows(checkRows);
	
	for(var i=0; i<gridData.length; i++){
		if(gridData[i].MVQTY > gridData[i].QTY ){
			cfn_msg('WARNING', '지시수량이 대상수량보다 많습니다.\n['+ gridData[i].ITEMCD + ']' + gridData[i].ITEMNM);
			return false;
		}
	}
	
	if (confirm('입고 적치지시 하시겠습니까?')) {
		var sid = 'sid_instruct';
		var url = '/alexcloud/p100/p100330/setMoveLoc.do';
		var sendData = {'paramData':{'ORGCD':gridData[0].ORGCD,'WHCD':gridData[0].WHCD}
		               ,'paramDataList':gridData};
		gfn_sendData(sid, url, sendData);
	}
}

/* 로케이션 일괄적용 */
function fn_applyAll() {
	var checkRows = $('#grid1').gridView().getCheckedRows();
	
	if(checkRows.length < 1) {
		cfn_msg('WARNING','체크된 품목이 없습니다.');
		return;
	}
	
	var loccd = $('#A_LOCCD').val();
	
	if(cfn_isEmpty(loccd)) {
		cfn_msg('WARNING','로케이션을 입력하세요.');
		return;
	}

	for (var i = 0; i < checkRows.length; i++) { 
		$('#grid1').gfn_setValue(checkRows[i], 'SCHLOCCD', loccd);
    }
	
	$('#A_LOCCD').val('');
}


</script>

<c:import url="/comm/contentBottom.do" />