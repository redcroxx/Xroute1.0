<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P700400
	화면명    : 로트속성변경 - RealGrid 마스터 디테일 그리드 2개 패턴
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="C_CHKWHCD" class="cmc_code" />
	<input type="hidden" id="C_CHKWHNM" class="cmc_code" />
	
	<ul class="sech_ul">
		<li class="sech_li">
			<div>변경일자</div>
			<div>
				<input type="text" id="S_CLDT_FROM" class="cmc_date periods" /> ~
				<input type="text" id="S_CLDT_TO" class="cmc_date periode" />
			</div>
		</li>
		<li class="sech_li">
			<div>변경번호</div>
			<div>				
				<input type="text" id="S_SEARCH" class="cmc_txt" />
			</div>
		</li>
		<li class="sech_li">
			<div>품목코드/명</div>
			<div>		
				<input type="text" id="S_ITEM" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<li class="sech_li">
			<div>창고</div>
			<div>
				<input type="text" id="S_WHCD" class="cmc_code" />
				<input type="text" id="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<li class="sech_li">
			<div>이동전로케이션</div>
			<div>
				<input type="text" id="S_BEFORELOCCD" class="cmc_code" />
			</div>
		</li>
		<li class="sech_li">
			<div>이동후로케이션</div>
			<div>
				<input type="text" id="S_AFTERLOCCD" class="cmc_code" />
			</div>
		</li>
	</ul>
	<div id="sech_extbtn" class="down"></div>
	<div id="sech_extline"></div>
	<div id="sech_extwrap">
		<ul class="sech_ul">
			<li class="sech_li">
				<div>화주</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code" />
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
		</ul>
		<!-- 회사별 상품정보 조회조건 -->
		<c:import url="/comm/compItemSearch.do" />
	</div>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">로트속성변경 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- 그리드 시작 -->
<div class="ct_bot_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">로트속성변경 상세리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="text" id="A_LOCCD" class="cmc_code" />
			<input type="hidden" id="A_LOCCD_R" class="cmc_value" />
			<button type="button" class="cmc_cdsearch"></button>
			<input type="button" id="btn_applyAll" class="cmb_normal" value="일괄적용" onclick="fn_applyAll();"/>
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
	
	$('#S_CLDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_CLDT_TO').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	
	//로그인 정보로 세팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_WHCD').val(cfn_loginInfo().WHCD);
	$('#S_WHNM').val(cfn_loginInfo().WHNM);
	
	grid1_Load();
	grid2_Load();
	
	/* 공통코드 코드/명 (화주) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});

	/* 공통코드 코드/명 (창고) */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_WHCD:'S_WHCD,S_WHNM',S_COMPCD:'S_COMPCD'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	
	/* 공통코드 코드/명 (이동전로케이션) 
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'S_BEFORELOCCD',
		inparam:{S_LOCCD:'S_BEFORELOCCD',S_WHCD:'S_WHCD'},
		outparam:{LOCCD:'S_BEFORELOCCD'},
		beforeFn: function() { 
			if(cfn_isEmpty($('#S_WHCD').val())) {
				cfn_msg('WARNING', '창고를 선택하세요.');
				return false;
			}
		}
	});*/
	
	/* 공통코드 코드/명 (이동후로케이션) 
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'S_AFTERLOCCD',
		inparam:{S_LOCCD:'S_AFTERLOCCD',S_WHCD:'S_WHCD'},
		outparam:{LOCCD:'S_AFTERLOCCD'},
		beforeFn: function() { 
			if(cfn_isEmpty($('#S_WHCD').val())) {
				cfn_msg('WARNING', '창고를 선택하세요.');
				return false;
			}
		}
	});*/
	
	/* 공통코드 코드/명 (로케이션 일괄적용) */
	pfn_codeval({
		url:'/alexcloud/popup/popP005/view.do',codeid:'A_LOCCD',
		inparam:{S_COMPCD:'S_COMPCD',S_LOCCD:'A_LOCCD,A_LOCCD_R',S_WHCD:'C_CHKWHCD',S_WHNM:'C_CHKWHNM'},
		outparam:{LOCCD:'A_LOCCD,A_LOCCD_R'},
		beforeFn: function() { 
			var c_chkwhcd = $('#C_CHKWHCD').val();
			var c_chkwhnm = $('#C_CHKWHCD').val();
			
			
			//전체 행의 개수
			var endidx = $('#grid2').dataProvider().getRowCount();
			
			if(endidx < 1) {
				cfn_msg('WARNING', '품목을 추가하세요.');
	        	return false;
			}
			
			if(cfn_isEmpty($('#C_CHKWHCD').val())) {
				cfn_msg('WARNING', '창고를 선택하세요.');					
	        	return false;
			}

		}
	});
	
 	if($('#S_ORGCD').val().length > 0){
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}
	
	if($('#S_WHCD').val().length > 0){
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	}		
	
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'CLKEY',header:{text:'변경번호'},width:150,styles:{textAlignment:'center'}},
		{name:'CLDT',header:{text:'변경일자'},width:110,formatter:'date',styles:{textAlignment:'center'},editable:true,required:true},
		{name:'WHCD',header:{text:'창고코드'},width:110,styles:{textAlignment:'center'},editable:true,required:true,formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP004/view.do',
						 inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD',S_WHNM:'WHNM'},
						 outparam:{WHCD:'WHCD',NAME:'WHNM'}}},
		{name:'WHNM',header:{text:'창고명'},width:110,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'화주코드'},width:100,styles:{textAlignment:'center'},editable:true,required:true,formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP002/view.do',
				 inparam:{S_ORGCD:'ORGCD',S_COMPCD:'COMPCD'},
				 outparam:{ORGCD:'ORGCD',NAME:'ORGNM'}}},
		{name:'ORGNM',header:{text:'화주명'},width:100,styles:{textAlignment:'center'}},
		{name:'REMARK',header:{text:'비고'},width:300,editable:true,editor:{maxLength:200}},
		{name:'ITEMCNT',header:{text:'품목수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'TOTQTY',header:{text:'총수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
				footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,show:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			
			if (oldIndex.dataRow !== -1 && oldIndex.dataRow !== newIndex.dataRow) {
				var grid2Data = $('#grid2').gfn_getDataList(false);
				var state = dataProvider.getRowState(oldIndex.dataRow);
				
				if (state === 'updated' || state === 'created' || grid2Data.length > 0) {
					if (confirm('변경된 내용이 있습니다. 로트속성을 변경하시겠습니까?')) {
						cfn_save('Y');
					}
					return false;
				}
			} 
		};
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				//신규행 제외 모두 변경 불가
				var state = dataProvider.getRowState(newRowIdx);
				
				var editable = (state === 'created')
				
				$('#' + gid).gfn_setColDisabled(['CLDT', 'WHCD','ORGCD', 'REMARK'], editable);
				$('#grid2').gfn_setColDisabled(['ITEMCD','AFTLOCCD', 'CLQTY','REMARK',
												'LOT1','LOT2','LOT3','LOT4','LOT5'], editable);
				
			    if(!cfn_isEmpty(cfn_loginInfo().WHCD)){
					$('#' + gid).gfn_setColDisabled(['WHCD'], false);
				} 
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#' + gid).gfn_setColDisabled(['ORGCD'], false);
				}
				/*if(editable == false) {
					$('#A_LOCCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
					$('#A_LOCCD_R').next('button.cmc_cdsearch').hide();
					$('#btn_applyAll').hide();
				} else {
					$('#A_LOCCD').attr('disabled',false).removeClass('disabled').attr('readonly',false);
					$('#A_LOCCD_R').next('button.cmc_cdsearch').show();
					$('#btn_applyAll').show();
				}*/
			}
			
			var clkey = $('#' + gid).gfn_getValue(newRowIdx, 'CLKEY');
			$('#C_CHKWHCD').val($('#' + gid).gfn_getValue(newRowIdx, 'WHCD'));
			$('#C_CHKWHNM').val($('#' + gid).gfn_getValue(newRowIdx, 'WHNM'));
			
			if(!cfn_isEmpty(clkey)) {
				var param = {'CLKEY':clkey};
				fn_getDetailList(param);
			}
		};
	});
	
	/* 그리드 컬럼 이벤트
		'PRINTBTN': {
			formatclick: function(val, rowid, colkey, e) {
				var wists = $('#' + gid).gfn_getCell(rowid, 'WISTS');
				var wikey = $('#' + gid).gfn_getCell(rowid, 'WIKEY');
				
		  		if (!cfn_isEmpty(wikey) && wists != '99') {
	  				fn_getReport(wists, wikey);
		  		} else if(cfn_isEmpty(wikey) && wists == '100'){
		  			alert('신규 상태에서는 출력할 수 없습니다.');
		  			return false;
		  		} else {
		  			alert('취소 상태에서는 출력할 수 없습니다.');
		  			return false;
		  		}
			}
		}
	}); */
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'},required:true,editable:true,formatter:'popup',
			popupOption:{url:'/alexcloud/popup/popP810/view.do',
						 inparam:{S_ITEM:'ITEMCD',S_COMPCD:'COMPCD',S_ORGCD:'ORGCD',S_ORGNM:'ORGNM',S_WHCD:'WHCD',S_WHNM:'WHNM',S_LOCCD:'BEFLOCCD',S_LOTKEY:'BEFLOTKEY'},
						 outparam:{ITEMCD:'ITEMCD',ITEMNM:'ITEMNM',ITEMSIZE:'ITEMSIZE',UNITCD:'UNITCD',INBOXQTY:'INBOXQTY',UNITTYPE:'UNITTYPE',
						 		LOT1:'LOT1',LOT2:'LOT2',LOT3:'LOT3',LOT4:'LOT4',LOT5:'LOT5'},
						 returnFn: function(data, type) {
							 if(data.length > 0) {
								 var rowidx1 = $('#grid1').gfn_getCurRowIdx();
								 var masterData = $('#grid1').gfn_getDataRow(rowidx1);
								 
								 var rowidx2 = $('#' + gid).gfn_getCurRowIdx();
									for (var i=0; i<data.length; i++) {
										if (i === 0) {
											$('#' + gid).gfn_setValue(rowidx2, 'ITEMCD', data[i].ITEMCD);
											$('#' + gid).gfn_setValue(rowidx2, 'ITEMNM', data[i].ITEMNM);
											$('#' + gid).gfn_setValue(rowidx2, 'ITEMSIZE', data[i].ITEMSIZE);
											$('#' + gid).gfn_setValue(rowidx2, 'UNITCD', data[i].UNITCD);
											$('#' + gid).gfn_setValue(rowidx2, 'UNITTYPE', data[i].UNITTYPE);
											$('#' + gid).gfn_setValue(rowidx2, 'INBOXQTY', data[i].INBOXQTY);
											$('#' + gid).gfn_setValue(rowidx2, 'CLQTY_BOX', '');
											$('#' + gid).gfn_setValue(rowidx2, 'CLQTY_EA', '');
											$('#' + gid).gfn_setValue(rowidx2, 'CLQTY', '');
											$('#' + gid).gfn_setValue(rowidx2, 'BEFLOCCD', data[i].LOCCD);
											$('#' + gid).gfn_setValue(rowidx2, 'AFTLOCCD', data[i].LOCCD);
											$('#' + gid).gfn_setValue(rowidx2, 'TOTAVAILQTY', data[i].TOTAVAILQTY);
											$('#' + gid).gfn_setValue(rowidx2, 'BEFAVAILQTY', data[i].AVAILQTY);
											$('#' + gid).gfn_setValue(rowidx2, 'LOT1', data[i].LOT1);
											$('#' + gid).gfn_setValue(rowidx2, 'LOT2', data[i].LOT2);
											$('#' + gid).gfn_setValue(rowidx2, 'LOT3', data[i].LOT3);
											$('#' + gid).gfn_setValue(rowidx2, 'LOT4', data[i].LOT4);
											$('#' + gid).gfn_setValue(rowidx2, 'LOT5', data[i].LOT5);
											$('#' + gid).gfn_setValue(rowidx2, 'BEFLOT1', data[i].LOT1);
											$('#' + gid).gfn_setValue(rowidx2, 'BEFLOT2', data[i].LOT2);
											$('#' + gid).gfn_setValue(rowidx2, 'BEFLOT3', data[i].LOT3);
											$('#' + gid).gfn_setValue(rowidx2, 'BEFLOT4', data[i].LOT4);
											$('#' + gid).gfn_setValue(rowidx2, 'BEFLOT5', data[i].LOT5);
											$('#' + gid).gfn_setValue(rowidx2, 'BEFLOTKEY', data[i].LOTKEY);
											$('#' + gid).gfn_setValue(rowidx2, 'COMPCD', masterData.COMPCD);
											$('#' + gid).gfn_setValue(rowidx2, 'COMPNM', masterData.COMPNM);
											$('#' + gid).gfn_setValue(rowidx2, 'WHCD', masterData.WHCD);
											$('#' + gid).gfn_setValue(rowidx2, 'WHNM', masterData.WHNM);
											$('#' + gid).gfn_setValue(rowidx2, 'ORGCD', masterData.ORGCD);
											$('#' + gid).gfn_setValue(rowidx2, 'ORGNM', masterData.ORGNM);
											
										} else {
											$('#' + gid).gfn_addRow({
												ITEMCD: data[i].ITEMCD,
										  		ITEMNM: data[i].ITEMNM,
										  		ITEMSIZE: data[i].ITEMSIZE,
								                UNITCD: data[i].UNITCD,
								                UNITTYPE:data[i].UNITTYPE,
								                INBOXQTY: data[i].INBOXQTY,
								                CLQTY_BOX:'',
								                CLQTY_EA:'',
								                CLQTY: '',								                
								                BEFLOCCD: data[i].LOCCD,
								                AFTLOCCD: data[i].LOCCD,
								                TOTAVAILQTY: data[i].TOTAVAILQTY,
								                BEFAVAILQTY: data[i].AVAILQTY,
								                LOT1: data[i].LOT1,
								                LOT2: data[i].LOT2,
								                LOT3: data[i].LOT3,
								                LOT4: data[i].LOT4,
								                LOT5: data[i].LOT5,
								                BEFLOT1: data[i].LOT1,
								                BEFLOT2: data[i].LOT2,
								                BEFLOT3: data[i].LOT3,
								                BEFLOT4: data[i].LOT4,
								                BEFLOT5: data[i].LOT5,
								                BEFLOTKEY: data[i].LOTKEY,
								                COMPCD:masterData.COMPCD,
								                COMPNM:masterData.COMPNM,
								                WHCD:masterData.WHCD,
								                WHNM:masterData.WHNM,
								                ORGCD:masterData.ORGCD,
								                ORGNM:masterData.ORGNM
											});	
										}
									}
							 }
							 
							}
						}
		},
		{name:'ITEMNM',header:{text:'품명'},width:250},
		{name:'ITEMSIZE',header:{text:'규격'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},styles:{textAlignment:'center'}},
		{name:'BEFLOCCD',header:{text:'변경전로케이션'},formatter:'popup',width:110,styles:{textAlignment:'center'}},
		{name:'AFTLOCCD',header:{text:'변경후로케이션'},formatter:'popup',width:110, editable:true, required:true,styles:{textAlignment:'center'},
			popupOption:{url:'/alexcloud/popup/popP005/view.do',
						 inparam:{S_COMPCD:'COMPCD',S_LOCCD:'AFTLOCCD',S_WHCD:'WHCD',S_WHNM:'WHNM'},
						 outparam:{LOCCD:'AFTLOCCD'}}},
		{name:'TOTAVAILQTY',header:{text:'변경전총가용수량'},width:120,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'BEFAVAILQTY',header:{text:'변경전가용수량'},dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'CLQTY_BOX',header:{text:'변경[BOX]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'CLQTY_EA',header:{text:'변경[EA]'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'CLQTY',header:{text:'변경수량'},width:110,required:true,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editor:{maxLength:11,type:"number",positiveOnly:true,integerOnly:true},minVal:1,
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'REMARK',header:{text:'비고'},width:200,editable:true,editor:{maxLength:200}},
		{name:'BEFLOTKEY',header:{text:'변경전로트번호'},width:100,styles:{textAlignment:'center'}},
		{name:'BEFLOT1',header:{text:'변경전 ' + cfn_getLotLabel(1)},width:100, show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'BEFLOT2',header:{text:'변경전 ' + cfn_getLotLabel(2)},width:100, show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'BEFLOT3',header:{text:'변경전 ' + cfn_getLotLabel(3)},width:100, show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'BEFLOT4',header:{text:'변경전 ' + cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
		{name:'BEFLOT5',header:{text:'변경전 ' + cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
		{name:'AFTLOTKEY',header:{text:'변경후로트번호'},width:100,styles:{textAlignment:'center'}},
		{name:'LOT1',header:{text:'변경후 ' + cfn_getLotLabel(1)},width:100,editable:true,editor:{maxLength:50},formatter:cfn_getLotType(1),show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
		{name:'LOT2',header:{text:'변경후 ' + cfn_getLotLabel(2)},width:100,editable:true,editor:{maxLength:50},formatter:cfn_getLotType(2), show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
		{name:'LOT3',header:{text:'변경후 ' + cfn_getLotLabel(3)},width:100,editable:true,editor:{maxLength:50},formatter:cfn_getLotType(3), show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
		{name:'LOT4',header:{text:'변경후 ' + cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4,editable:true},
		{name:'LOT5',header:{text:'변경후 ' + cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5,editable:true},	
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
		{name:'WHCD',header:{text:'창고코드'},width:100,show:false},
		{name:'WHNM',header:{text:'창고명'},width:100,show:false},
		{name:'ORGCD',header:{text:'화주코드'},width:100,show:false},
		{name:'ORGNM',header:{text:'화주명'},width:100,show:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,show:false}
		
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
	  	//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				
				$('#grid1').gfn_setColDisabled(['WHCD','ORGCD'], false); //행추가되면 무조건 disable
				
			} else { //품목이 다 지워지면 edit 가능
				$('#grid1').gfn_setColDisabled(['WHCD','ORGCD'], true);
			
				if(!cfn_isEmpty(cfn_loginInfo().WHCD)){
					$('#grid1').gfn_setColDisabled(['WHCD'], false);
				}
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#grid1').gfn_setColDisabled(['ORGCD'], false);
				}
			}
		};
		//셀 수정 이벤트
	    gridView.onEditChange = function(grid, column, value) {
	    	if (column.column === 'CLQTY') {
	    		//var AFTAVAILQTY = $('#' + gid).gfn_getValue(column.dataRow, 'AFTAVAILQTY_R');
	    		//$('#' + gid).gfn_setValue(column.dataRow, 'AFTAVAILQTY', value + AFTAVAILQTY);
	    		
	    		var INBOXQTY = $('#' + gid).gfn_getValue(column.dataRow, 'INBOXQTY'); //BOX입수량
	    		var UNITTYPE = $('#' + gid).gfn_getValue(column.dataRow, 'UNITTYPE'); //관리단위
	    		
	    		if (INBOXQTY <= 0){
	    			$('#' + gid).gfn_setValue(column.dataRow, 'CLQTY_BOX', 0); 
		    		$('#' + gid).gfn_setValue(column.dataRow, 'CLQTY_EA', 0);
		    		
		    		cfn_msg('ERROR', '품목의 박스입수량이 잘못되었습니다.');
		    		return false;
	    		}
	    		
	    		if (UNITTYPE == 'BOXEA'){
	    			$('#' + gid).gfn_setValue(column.dataRow, 'CLQTY_BOX', parseInt(value / INBOXQTY)); 
		    		$('#' + gid).gfn_setValue(column.dataRow, 'CLQTY_EA', parseInt(value % INBOXQTY));	
	    		} else if (UNITTYPE == 'EA'){
	    			$('#' + gid).gfn_setValue(column.dataRow, 'CLQTY_BOX', 0); 
		    		$('#' + gid).gfn_setValue(column.dataRow, 'CLQTY_EA', value);	
	    		}	    		
	    	} 
	    };		
		
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').dataProvider().clearRows();
		$('#A_LOCCD').val('');
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//확정
	if(sid == 'sid_setExecute') {
		var resultData = data.resultData;
		$('#grid1').gfn_setFocusPK(resultData, ['CLKEY']);
		cfn_msg('INFO', '정상적으로 확정되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('#grid1').gridView().cancel();
	$('#grid2').gridView().cancel();

	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p700/p700400/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p700/p700400/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 신규 클릭 */
function cfn_new() {
	$('#C_CHKWHCD').val('');
	$('#C_CHKWHNM').val('');
	$('#A_LOCCD').val('');
	
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);

	var grid2Data = $('#grid2').gfn_getDataList(false);
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx >= 0) {
		var state = $('#grid1').dataProvider().getRowState(rowidx);
		if (state === 'created') {
			cfn_msg('INFO', '신규 입력 상태입니다.');
			return false;
		} else if (state === 'updated' || grid2Data.length > 0) {
			if (confirm('변경된 내용이 있습니다. 로트속성을 변경하시겠습니까?')) {
				cfn_save('Y');
			}
			return false;
		}
	}
	
	$('#grid2').dataProvider().clearRows();
	
	$('#grid1').gfn_addRow({CLDT:cfn_getDateFormat(new Date(), 'yyyyMMdd'),
						  COMPCD:cfn_loginInfo().COMPCD,
						  COMPNM:cfn_loginInfo().COMPNM,
						  ORGCD:cfn_loginInfo().ORGCD,
						  ORGNM:cfn_loginInfo().ORGNM,
						  WHCD:cfn_loginInfo().WHCD,
						  WHNM:cfn_loginInfo().WHNM
	});
}

/* 공통버튼 - 확정 클릭 */
function cfn_execute(directmsg) {
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);

	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 전표가 없습니다.');
		return false;
	}
	
	//마스터 필수입력 체크
	if ($('#grid1').gfn_checkValidateCells([rowidx])) return false;
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	
	if (!cfn_isEmpty(masterData.CLKEY)) {
		cfn_msg('WARNING', '신규전표만 확정할 수 있습니다.');
		return false;
	}
	
	var detailData = $('#grid2').gfn_getDataList();
	
	if (detailData.length < 1) {
		cfn_msg('WARNING', '품목이 없습니다.');
		return false;
	}
	
	//디테일 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;
	
	for (var i = 0; i < detailData.length; i++) { 
		if(detailData[i].BEFAVAILQTY < detailData[i].CLQTY) {
			cfn_msg('WARNING', '변경수량이 변경전가용수량보다 많습니다.');
			$('#grid2').gfn_setFocusPK(detailData[i], ['COMPCD','ORGCD','ITEMCD','CLQTY']);
			$('#grid2').gfn_focusPK();
			return;
		}
	}
	
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('로트속성을 변경하시겠습니까?');
	}

	if (flg) {
		var sid = 'sid_setExecute';
		var url = '/alexcloud/p700/p700400/setExecute.do';
		var sendData = {'mGridData':masterData,'dGridList':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//디테일 그리드 추가 버튼 이벤트
function fn_detailAdd() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	if (!cfn_isEmpty(masterData.CLKEY)) {
		cfn_msg('WARNING', '신규전표에서만 추가 가능합니다.');
		return false;
	} else if(cfn_isEmpty(masterData.WHCD)) {
		cfn_msg('WARNING', '창고를 선택하세요.');
		return false;
	} else if(cfn_isEmpty(masterData.ORGCD)) {
		cfn_msg('WARNING', '화주를 선택하세요.');
		return false;
	}

	$('#C_CHKWHCD').val(masterData.WHCD);
	$('#C_CHKWHNM').val(masterData.WHNM);
	
	
	$('#grid2').gfn_addRow({'COMPCD':masterData.COMPCD,
							'COMPNM':masterData.COMPNM,                    
							'WHCD':masterData.WHCD,
							'WHNM':masterData.WHNM,
							'ORGCD':masterData.ORGCD,
							'ORGNM':masterData.ORGNM,
							'LOT1':'',
							'LOT2':'',
							'LOT3':'',
							'LOT4':'',
							'LOT5':''
							});
}  

//디테일 그리드 삭제 버튼 이벤트
function fn_detailDel() {
	var rowidx = $('#grid2').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow($('#grid1').gfn_getCurRowIdx());
	if (!cfn_isEmpty(masterData.CLKEY)) {
		cfn_msg('WARNING', '신규전표에서만 삭제 가능합니다.');
		return false;
	}
	
	$('#grid2').gfn_delRow(rowidx);
}  

/* 로케이션 일괄적용 */
function fn_applyAll() {
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	var state = $('#grid1').dataProvider().getRowState(rowidx);
	
	if(state != 'created')  {
		cfn_msg('WARNING','신규상태에서만 적용 가능합니다.');
		return;
	}
	
	var loccd = $('#A_LOCCD_R').val();
	
	if(cfn_isEmpty(loccd)) {
		cfn_msg('WARNING','로케이션을 확인하세요.');
		return;
	}
	
	//전체 행의 개수
	var endidx = $('#grid2').dataProvider().getRowCount();
	
	if(endidx > 0) {
		for(var i=0; i < endidx; i++) {
			$('#grid2').gfn_setValue(i,'AFTLOCCD', loccd);
		}
	}
	
	$('#A_LOCCD').val('');
	$('#A_LOCCD_R').val('');
}




/*입고의뢰서, 거래명세서 출력
function fn_getReport(wists, wikey) {
	//리포트 띄우기	
	if(wists == '100' || wists == '200' || wists == '300'){
		rfn_reportView({
			title: '입고의뢰서',
			jrfName: 'P100300_R01',
			args: {'WIKEY':wikey}
		});
	} else if(wists == '400') {
		rfn_reportView({
			title: '거래명세서',
			jrfName: 'P100300_R02',
			args: {'WIKEY':wikey}
		});
		
	}
}*/
</script>

<c:import url="/comm/contentBottom.do" />