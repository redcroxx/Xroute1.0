<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000011
	화면명    : 판매 단가
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">	
		<ul class="sech_ul">
			<li class="sech_li">
				<div>회사</div>
				<div>
					<input type="text" id="S_COMPCD"  class="cmc_code" readonly="readonly" disabled/>				
					<input type="text" id="S_COMPNM"  class="cmc_value" readonly="readonly" disabled/>
					<button type="button" class="cmc_cdsearch" disabled></button>
				</div>
			</li>
			<li class="sech_li">
				<div>셀러</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code" />				
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>	
			<li class="sech_li">
				<div>품목코드/명</div>
				<div>
					<input type="text" id="S_ITEM" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li">
				<div>품목분류</div>
				<div>
					<input type="text" id="S_ITEMCATCD" class="cmc_code" />
					<input type="text" id="S_ITEMCATNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>			
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_left_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">품목 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>		
	</div>
	<div id="grid1"></div>
</div>

<div class="ct_right_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">기간별 판매단가</div>
		<div class="grid_top_right">
			<input type="button" id="btn_upload" class="cmb_normal" value="업로드" onclick="pfn_upload('P000011');" />
			<button type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid2RowAdd()"></button>	
			<input type="button" id="btn_detailDel" class="cmb_minus" onclick="fn_detailDel();" />			
		</div>
	</div>
	<div id="grid2"></div>
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
  	
	//화면레이아웃 지정
	initLayout();
  	
	//로그인정보 셋팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
  	
	//회사
	pfn_codeval({
		url:'/alexcloud/popup/popP001/view.do',codeid:'S_COMPCD',
		inparam:{S_COMPCD:'S_COMPCD,S_COMPNM'},
		outparam:{COMPCD:'S_COMPCD',NAME:'S_COMPNM'}
	});
	
	//셀러
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_ORGCD:'S_ORGCD'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});

	//품목분류
	pfn_codeval({
		url:'/alexcloud/popup/popP017/view.do',codeid:'S_ITEMCATCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ITEMCAT:'S_ITEMCATCD,S_ITEMCATNM'},
		outparam:{ITEMCATCD:'S_ITEMCATCD',NAME:'S_ITEMCATNM'}
	});  

	//그리드 초기화
	grid1_Load();
	grid2_Load();
	
 	if($('#S_ORGCD').val().length > 0){
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}	
});

function grid1_Load() {
	
	var gid = 'grid1';
	var columns = [
		{name:'ORGCD',header:{text:'셀러코드'},width:100,editor:{maxLength:20}},
		{name:'ORGNM',header:{text:'셀러명'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMCD',header:{text:'품목코드'},width:120,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:180},
		{name:'ITEMTYPE',header:{text:'품목유형'},width:100,formatter:'combo',comboValue:'${GCODE_ITEMTYPE}',styles:{textAlignment:'center'},editor:{maxLength:10}},
		{name:'UNITCD',header:{text:'단위'},width:80,formatter:'combo',comboValue:'${GCODE_UNITCD}',styles:{textAlignment:'center'},editor:{maxLength:10}},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'ITEMCAT1NM',header:{text:'대분류'},width:120,styles:{textAlignment:'center'}},
		{name:'ITEMCAT2NM',header:{text:'중분류'},width:120,styles:{textAlignment:'center'}},
		{name:'ITEMCAT3NM',header:{text:'소분류'},width:120,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,styles:{textAlignment:'center'},visible:false}	
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false}); 	
	
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//열고정 설정
		gridView.setFixedOptions({colCount:4,resizable:true,colBarWidth:1});
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var param = {
					'COMPCD':$('#' + gid).gfn_getValue(newRowIdx, 'COMPCD')
					, 'ORGCD':$('#' + gid).gfn_getValue(newRowIdx, 'ORGCD')
					, 'ITEMCD':$('#' + gid).gfn_getValue(newRowIdx, 'ITEMCD')}
				fn_getDetailList(param);
			}
		};
		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			
			if (oldIndex.dataRow !== -1 && oldIndex.dataRow !== newIndex.dataRow) {
				var grid2Data = $('#grid2').gfn_getDataList(false);
				var state = dataProvider.getRowState(oldIndex.dataRow);
				
				if (state === 'updated' || state === 'created'|| grid2Data.length > 0 ) {
					if (confirm('변경된 내용이 있습니다. 저장하시겠습니까?')) {
						cfn_save('Y');
					}
					return false;
				}
			} 
		};		
	});
	
}
function grid2_Load() {
	var gid = 'grid2',$grid = $('#' + gid);
	
	var columns = [
		{name:'STARTDT',header:{text:'시작일자'},required:true,editable:true,width:120,formatter:'date',styles:{textAlignment:'center'},editor:{maxLength:8},			
			calFn: function(e) {
				var date = new Date();
				date.setDate(date.getDate() + 1);
				e.datetimepicker('setStartDate', cfn_getDateFormat(date, 'yyyy-MM-dd'));
			}
		},
		{name:'ENDDT',header:{text:'종료일자'},required:true,editable:true,width:120,formatter:'date',styles:{textAlignment:'center'},editor:{maxLength:8},
			calFn: function(e) {
				var date = new Date();
				date.setDate(date.getDate() + 1);
				e.datetimepicker('setStartDate', cfn_getDateFormat(date, 'yyyy-MM-dd'));
			}
		},
		{name:'UNITPRICE',header:{text:'판매단가'},required:true,width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},minVal:0,
			editable:true,editor:{maxLength:11,type:'number',positiveOnly:true,integerOnly:true,editFormat:'#,##0'}
		},
		{name:'REMARK',header:{text:'비고'},editable:true,width:200},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,visible:false},
		{name:'ITEMCD',header:{text:'품목코드'},width:100,visible:false},
		{name:'ISTODAY',header:{text:'오늘여부'},width:100,visible:false}
		
    ];	
	
	//그리드 생성
	$grid.gfn_createGrid(columns,{mstGrid:'grid1',footerflg:false});
	

	
	//그리드설정 및 이벤트 처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		
		//셀 로우 변경 이벤트
		var newDynamicStyles = [
				{criteria: "(value['ISTODAY'] = 'T')", styles: {background:'#b6dd61'}
			},
		];

		gridView.setStyles({
			body: {
				dynamicStyles: newDynamicStyles
			}
		});
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				
				var rowData = $grid.gfn_getDataRow(newRowIdx);
				var state = $grid.dataProvider().getRowState(newRowIdx);
				var today = new Date();

				if(state === 'created') {
					$grid.gfn_setColDisabled(['STARTDT', 'ENDDT','UNITPRICE'],true);
				}
				else if(rowData.ENDDT === '99991231'){
					$grid.gfn_setColDisabled(['STARTDT', 'ENDDT'],false);
					$grid.gfn_setColDisabled(['UNITPRICE'],true);
					
				}
				else if(rowData.ENDDT > cfn_getDateFormat(today,'yyyyMMdd')) {
					$grid.gfn_setColDisabled(['ENDDT','UNITPRICE'],true);
					$grid.gfn_setColDisabled(['STARTDT'],false);
				}
				else {
					$grid.gfn_setColDisabled(['STARTDT','ENDDT','UNITPRICE'],false);
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
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	//디테일리스트 검색
	else if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
		$('#grid2').gfn_focusPK();
	}
	//디테일 저장
	else if (sid == 'sid_setSave') {
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		fn_getDetailList(data.resultData);
		$('#grid1').gfn_setFocusPK(data.resultData, ['ITEMCD']);
	}
}

/* 공통버튼 - 검색  */
function cfn_retrieve() {
	$('#grid2').gridView().cancel();
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000011/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);	
	
}

/* 공통버튼 - 저장  */
function cfn_save(directmsg) {
	$('#grid2').gridView().commit(true);
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	var $grid2 = $('#grid2');
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '저장할 내역이 없습니다.');
		return false;
	}	
	
	var detailData = $grid2.gfn_getDataList(false);
	
	if (detailData.length < 1) {
		cfn_msg('WARNING', '저장할 내역이 없습니다.');
		return false;
	}	
	
	//디테일 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;
	
	for(i=0; i<detailData.length; i++) {		
		if( (detailData[i].STARTDT <=cfn_getDateFormat(new Date(), 'yyyyMMdd')) && (detailData[i].ENDDT <=cfn_getDateFormat(new Date(), 'yyyyMMdd') ) ) {
			cfn_msg('WARNING','시작일자,종료일자는 오늘날짜 이후로 지정해주세요.');
			$grid2.gfn_setFocusPK(detailData[i], ['COMPCD','ITEMCD','STARTDT']);
			$grid2.gfn_focusPK();
			return false;	
		}
		if(detailData[i].STARTDT > detailData[i].ENDDT) {
 			cfn_msg('WARNING','종료일자는 시작일자 이상으로 지정해주세요.');
			$grid2.gfn_setFocusPK(detailData[i], ['COMPCD','ITEMCD','STARTDT']);
			$grid2.gfn_focusPK(); 
			return false;
		}
		if(detailData[i].STARTDT <= cfn_getDateFormat(new Date(), 'yyyyMMdd')){
			cfn_msg('WARNING','시작일자는 오늘날짜 이후로 지정해주세요.');
			$grid2.gfn_setFocusPK(detailData[i], ['COMPCD','ITEMCD','STARTDT']);
			$grid2.gfn_focusPK();
			return false;
		} 
		if(detailData[i].ENDDT <= cfn_getDateFormat(new Date(), 'yyyyMMdd')){
			cfn_msg('WARNING','종료일자는 오늘날짜 이후로 지정해주세요.');
			$grid2.gfn_setFocusPK(detailData[i], ['COMPCD','ITEMCD','STARTDT']);
			$grid2.gfn_focusPK();
			return false;
		}
	}
	
	var flg = true;
	if (directmsg !== 'Y') {
		flg = confirm('저장하시겠습니까?');
	}

	if (flg) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/p000011/setSave.do';
		var sendData = {'DetailData':detailData};
		
		gfn_sendData(sid, url, sendData);
	}		
}

//그리드2 검색
function fn_getDetailList(param) {
	
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p000/p000011/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);	
}
//그리드2 신규행 추가 
function fn_grid2RowAdd(){
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if(rowidx < 0) {
		cfn_msg('WARNING','선택한 품목이 없습니다.');
		return false;
	}
	
	$('#grid2').gfn_addRow({
		'COMPCD': $('#grid1').gfn_getValue(rowidx,'COMPCD'),
		'ORGCD' : $('#grid1').gfn_getValue(rowidx,'ORGCD'),
		'ITEMCD': $('#grid1').gfn_getValue(rowidx,'ITEMCD'),
		'UNITPRICE': 0
	});
}
//그리드2 신규행 삭제
function fn_detailDel(){
	
	var rowidx = $('#grid2').gfn_getCurRowIdx();

	if(rowidx2 < 0) {
		cfn_msg('WARNING','선택된  행이 없습니다.');
		return false;
	}
	
	var state = $('#grid2').dataProvider().getRowState(rowidx);
	
	if(state === 'created'){
		$('#grid2').gfn_delRow(rowidx);
		return false;		
	}else {
		cfn_msg('WARNING', '기등록된 내역은 삭제불가합니다.');
	}	
}
</script>

<c:import url="/comm/contentBottom.do" />