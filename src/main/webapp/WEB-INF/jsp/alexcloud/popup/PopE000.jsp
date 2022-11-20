<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : popE000
	화면명    : 업로드 공통팝업
-->
<div id="popE000" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_popE000" action="#" onsubmit="return false">
			<p id="lbl_name">업로드</p>
			<input type="hidden" id="S_PGMID" class="cmc_txt" />
			<input type="hidden" id="S_COMPCD" class="cmc_txt" />
			<input type="hidden" id="PROCNAME" class="cmc_txt" />
			<input type="hidden" id="USEORGCD" class="cmc_txt" />
			<input type="hidden" id="USEWHCD" class="cmc_txt" />
			<ul class="sech_ul">
				<li class="sech_li required" id="S_ORGYN">
			  		<div style="width:80px">셀러</div>
					<div style="width:250px">
						<input type="text" id="S_ORGCD" class="cmc_code" />
						<input type="text" id="S_ORGNM" class="cmc_value" />
						<button type="button" class="cmc_cdsearch"></button>
					</div>
				</li>
				<li class="sech_li required" id="S_WHYN">
			  		<div style="width:80px">창고</div>
					<div style="width:250px">
						<input type="text" id="S_WHCD" class="cmc_code" />
						<input type="text" id="S_WHNM" class="cmc_value" />
						<button type="button" class="cmc_cdsearch"></button>
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">	
					<div>
						<textarea id="popE000_REMARK" name="popE000_REMARK" class="cmc_area disabled" readonly="readonly" cols="45" style="width:800px;height:50px;"></textarea>
					</div>
				</li>
			</ul>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">업로드내역<span>(총 0건)</span></div>
			<div class="grid_top_right">
				<button type="button" id="btn_uploadAdd" class="cmb_plus" onclick="fn_uploadAddRow()"></button>
				<button type="button" id="btn_uploadDel" class="cmb_minus" onclick="fn_uploadDelRow()"></button>
			</div>
		</div>
		<div id="grid_popE000"></div>
	</div>
</div>

<script type="text/javascript">
var chk=0;
$(function() {
	$('#popE000').lingoPopup({
		title: '업로드',
		width: 1250,
		height: 930,
		buttons: {
			'체크': {
				text: '체크',
				class: 'popbtnExcel',
				click: function() {
					
					$('#grid_popE000').gridView().commit(true);

					$('body').css('cursor','wait');
		            loadingStart();
		            
					// 메시지 초기화
					ckmsg = [];
					var columns = $('#grid_popE000').gridView().getColumns();
					var gridDataRows = $('#grid_popE000').gfn_getDataList();
					for (var i=0, len=gridDataRows.length; i<len; i++) {
						$('#grid_popE000').gfn_setValue(i, 'CHKMSG', "");
					}
					
					// 자릿수 체크
					var failData = $('#grid_popE000').gridView().checkValidateCells();
					$('#grid_popE000').gridView().clearInvalidCellList();
					
					var collen = columns.length;
					var rowlen = gridDataRows.length;
					
					var j=0;
					for (var i=0, len=ckmsg.length; i<len; i++) {
						j = parseInt(i / collen);
						if(!cfn_isEmpty(ckmsg[i])){
							$('#grid_popE000').gfn_setValue(j, 'CHKMSG', $('#grid_popE000').gfn_getValue(j, 'CHKMSG') + ckmsg[i].message + "," );
						}						
					}
					
					loadingEnd();
			        $('body').css('cursor','default');
					
					var gridDataList = $('#grid_popE000').gfn_getDataList(true, false);
					
					if (gridDataList.length < 1) {
						cfn_msg('WARNING', '등록된 내역이 없습니다.');
						return false;
					}
					
					var pgmid = $('#S_PGMID').val();
					var orgcd = $('#S_ORGCD').val();
					var whcd = $('#S_WHCD').val();
					var url = '/alexcloud/popup/popE000/setCheck.do';
					var sendData = {'paramData':{'PGMID':pgmid,'ORGCD':orgcd,'WHCD':whcd},'paramList':gridDataList};
					
					gfn_ajax(url, true, sendData, function(data, xhr) {
						
						var gridData = data.resultList;
						$('#grid_popE000').gfn_setDataList(gridData);
						
						// 체크 확인
						chk = 1;
						for (var i=0, len=gridDataList.length; i<len; i++) {
							if(!cfn_isEmpty($('#grid_popE000').gfn_getValue(i, 'CHKMSG'))){
								chk = 0;
								cfn_msg('ERROR', '에러내역이 있습니다.');
								return;
							}
						}
						cfn_msg('INFO', '체크가 완료되었습니다.');
						
					});
				}
			},
			'업로드': {
				text: '업로드',
				click: function() {
					var gridDataList = $('#grid_popE000').gfn_getDataList();
					
					// 등록내역이 없다면 처리 불가
					if (gridDataList.length < 1) {
						cfn_msg('WARNING', '등록된 내역이 없습니다.');
						return false;
					}
					
					if(chk == 0){
						cfn_msg('WARNING', '체크 확인후 업로드 하시기 바랍니다.');
						return;
					}
					
					var pgmid = $('#S_PGMID').val();
					var procname = $('#PROCNAME').val();
					
					var paramData = cfn_getFormData('frm_search_popE000');
					var sendData = {'paramData':{'PGMID':pgmid,'PROCNAME':procname}};
					var url = '/alexcloud/popup/popE000/upload.do';
					
					gfn_ajax(url, true, sendData, function(data, xhr) {
						cfn_msg('INFO', '업로드 처리되었습니다.');
						fn_pope000close();
					});
				}
			},
			'닫기': {
				text: '취소',
				click: function() {
					$(this).lingoPopup('setData', '');
					$(this).lingoPopup('close');
				}
			}
		},
		open: function(data) {
			
			$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
			$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
			$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
			$('#S_WHCD').val(cfn_loginInfo().WHCD);
			$('#S_WHNM').val(cfn_loginInfo().WHNM);
			
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
			
			if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
				$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
				$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
				$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
			}
			
			if(!cfn_isEmpty(cfn_loginInfo().WHCD)){
				$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
				$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
				$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
			}
			//엑셀업로드
			$('.popbtnExcel').before('<form id="frmupload" action="#" method="post" enctype="multipart/form-data">' +
					'<input type="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" ' +
					'name="excelfile" id="xlf" class="popbtnleft" style="margin:10px 0 0 5px;" />' +
					'</form>');					
			
			$("#xlf").bind("click", function(e){
				if($('#USEORGCD').val() == 'Y' && cfn_isEmpty($('#S_ORGCD').val())){
					cfn_msg('WARNING', '셀러를 입력하세요.');
					return false;
				}
				if($('#USEWHCD').val() == 'Y' && cfn_isEmpty($('#S_WHCD').val())){
					cfn_msg('WARNING', '창고를 입력하세요.');
					return false;
				}
				this.value = null; 
			});

			$("#xlf").bind("change", function(e){gfn_handleXlsFile(e,'grid_popE000', gcolumns)});
			
			cfn_bindFormData('frm_search_popE000', data);			
			
			/* 업로드 화면에 따른 그리드 정보 조회 */
			fn_init_popE000();
		}
	});
});

function fn_pope000close(){
	$('#popE000').lingoPopup('setData', '');
	$('#popE000').lingoPopup('close', 'OK');
}

var ckmsg = [];
var gcolumns = [];
// 그리드 생성
function grid_Load_popE000(gridData) {
	var gid = 'grid_popE000';
	var columns = [];
	
	columns.push({name:'CHKMSG',header:{text:'체크메시지'},width:250,editable:false});
	gcolumns.push('CHKMSG');
	for(var i=0; i<gridData.length; i++){
		var req = (gridData[i].ISREQ === 'Y'); 
		if(gridData[i].VAL == 'LOT1'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getLotLabel(1)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getLotVisible(1),required:req});
			if(cfn_getLotVisible(1)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'LOT2'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getLotLabel(2)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getLotVisible(2),required:req});
			if(cfn_getLotVisible(2)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'LOT3'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getLotLabel(3)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getLotVisible(3),required:req});
			if(cfn_getLotVisible(3)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'LOT4'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getLotLabel(4)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getLotVisible(4),required:req});
			if(cfn_getLotVisible(4)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'LOT5'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getLotLabel(5)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getLotVisible(5),required:req});
			if(cfn_getLotVisible(5)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'F_USER01'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getCompItemLabel(1)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getCompItemVisible(1),required:req});
			if(cfn_getCompItemVisible(1)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'F_USER02'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getCompItemLabel(2)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getCompItemVisible(2),required:req});
			if(cfn_getCompItemVisible(2)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'F_USER03'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getCompItemLabel(3)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getCompItemVisible(3),required:req});
			if(cfn_getCompItemVisible(3)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'F_USER04'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getCompItemLabel(4)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getCompItemVisible(4),required:req});
			if(cfn_getCompItemVisible(4)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'F_USER05'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getCompItemLabel(5)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getCompItemVisible(5),required:req});
			if(cfn_getCompItemVisible(5)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'F_USER11'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getCompItemLabel(11)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getCompItemVisible(11),required:req});
			if(cfn_getCompItemVisible(11)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'F_USER12'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getCompItemLabel(12)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getCompItemVisible(12),required:req});
			if(cfn_getCompItemVisible(12)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'F_USER13'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getCompItemLabel(13)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getCompItemVisible(13),required:req});
			if(cfn_getCompItemVisible(13)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'F_USER14'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getCompItemLabel(14)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getCompItemVisible(14),required:req});
			if(cfn_getCompItemVisible(14)) gcolumns.push(gridData[i].COL_NM);
		} else if(gridData[i].VAL == 'F_USER15'){
			columns.push({name:gridData[i].COL_NM,header:{text:cfn_getCompItemLabel(15)},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},show:cfn_getCompItemVisible(15),required:req});
			if(cfn_getCompItemVisible(15)) gcolumns.push(gridData[i].COL_NM);
		} else {
			columns.push({name:gridData[i].COL_NM,header:{text:gridData[i].VAL},width:100,editable:true,editor:{maxLength:gridData[i].MAXLEN},required:req});
			gcolumns.push(gridData[i].COL_NM);
		}
	}
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns,{pasteflg:true
										,cmenuGroupflg:false
										,cmenuColChangeflg:false
										,cmenuColSaveflg:false
										,cmenuColInitflg:false});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
				$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
				$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
				
				$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
				$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
				$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
			} else {
				if(cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#S_ORGCD').removeAttr('disabled').removeClass('disabled').removeAttr('readonly');
					$('#S_ORGNM').removeAttr('disabled').removeClass('disabled').removeAttr('readonly');
					$('#btn_S_ORGCD').removeAttr('disabled').removeClass('disabled');
				}
				
				if(cfn_isEmpty(cfn_loginInfo().WHCD)){
					$('#S_WHCD').removeAttr('disabled').removeClass('disabled').removeAttr('readonly');
					$('#S_WHNM').removeAttr('disabled').removeClass('disabled').removeAttr('readonly');
					$('#btn_S_WHCD').removeAttr('disabled').removeClass('disabled');
				}
			}
		};
		
		gridView.onValidateColumn = function(grid, column, inserting, value) {
			
			var gCols = $('#grid_popE000').columns();
			
			var error = {};
			for (var i=0, len=gCols.length; i<len; i++) {
				if(column.fieldName == gCols[i].fieldName){
					if(!cfn_isEmpty(gCols[i].editor) && !cfn_isEmpty(gCols[i].editor.maxLength)){
						if(!cfn_isEmpty(value) && value.length > gCols[i].editor.maxLength){
							error.level = RealGridJS.ValidationLevel.ERROR;
				            error.message = column.header.text + " 자릿수 초과["+ gCols[i].editor.maxLength +"]";				            
						}	
					}					
				}
			}
			ckmsg.push(error);
			return null;
		};
		
	});
}

//그리드 행추가 버튼 클릭
function fn_uploadAddRow() {
	
	if($('#USEORGCD').val() == 'Y' && cfn_isEmpty($('#S_ORGCD').val())){
		cfn_msg('WARNING', '셀러를 입력하세요.');
		return false;
	}
	if($('#USEWHCD').val() == 'Y' && cfn_isEmpty($('#S_WHCD').val())){
		cfn_msg('WARNING', '창고를 입력하세요.');
		return false;
	}
	$('#grid_popE000').gfn_addRow();
}

//그리드 행삭제 버튼 클릭
function fn_uploadDelRow() {
	var $grid1 = $('#grid_popE000');
	var rowidx = $grid1.gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 항목이 없습니다.');
		return false;
	}
	
	var state = $grid1.dataProvider().getRowState(rowidx);
	$grid1.gfn_delRow(rowidx);
}

/* 업로드 화면에 따른 그리드 정보 조회 */
function fn_init_popE000(){
	var paramData = cfn_getFormData('frm_search_popE000');
	var sendData = {'paramData':paramData};
	var url = '/alexcloud/popup/popE000/init.do';
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		$('#PROCNAME').val(data.mstData.URL);
		$('#lbl_name').text(data.mstData.PGMNM);
		$('#popE000_REMARK').val(data.mstData.REMARK.replace(/\\r\\n/g, '\r\n'));
		grid_Load_popE000(data.resultList);
		
		if(data.mstData.USEORGCD !== 'Y'){
			$('#S_ORGYN').css('display','none');
		} else {
			$('#USEORGCD').val('Y');
		}
		if(data.mstData.USEWHCD !== 'Y'){
			$('#S_WHYN').css('display','none');
		}else {
			$('#USEWHCD').val('Y');
		}
	});
}
</script>