<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100301
	화면명    : 입고등록2
-->
<c:import url="/comm/contentTop.do" />

<!-- 입력폼 시작 -->
<div class="ct_top_wrap">
	<form id="frmDetail" action="#" onsubmit="return false">
	<input type="hidden" id="COMPCD" name="COMPCD" class="cmc_code" />
	<input type="hidden" id="COMPNM" name="COMPNM" class="cmc_code" />
	<table class="tblForm">
		<caption>입고기본정보</caption>
		<colgroup>
			<col width="120px" />
			<col width="245px" />
			<col width="120px" />
			<col width="245px" />
			<col width="120px" />
			<col />
		</colgroup>
		<tr>
			<th class="required">입고요청일자</th>
			<td><input type="text" id="WISCHDT" name="WISCHDT" class="cmc_date required" /></td>
			<th>입고일자</th>
			<td><input type="text" id="WIDT" name="WIDT" class="cmc_txt disabled" readonly="readonly" /></td>
			<th>입고번호</th>
			<td><input type="text" id="WIKEY" name="WIKEY" class="cmc_txt disabled" readonly="readonly" /></td>
		</tr>
		<tr>
			<th class="required">창고</th>
			<td>	
				<input type="text" id="WHCD" name="WHCD" class="cmc_code required" />
				<input type="text" id="WHNM" name="WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
		
			</td>
			<th>입고유형</th>
			<td>
				<select id="WITYPE" name="WITYPE" class="cmc_combo">
					<c:forEach var="i" items="${codeWITYPE}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</td>
			<th>입고상태</th>
			<td>
				<select id="WISTS" name="WISTS" class="cmc_combo disabled" disabled="disabled">
					<c:forEach var="i" items="${codeWISTS}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<%-- <tr>
			<th class="required">거래처</th>
			<td>	
				<input type="text" id="CUSTCD" name="CUSTCD" class="cmc_code required" />
				<input type="text" id="CUSTNM" name="CUSTNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</td>
			<th>거래처담당자</th>
			<td><input type="text" id="CUSTUSERNM" name="CUSTUSERNM" class="cmc_txt disabled" readonly="readonly" /></td>
			<th>담당자연락처</th>
			<td><input type="text" id="CUSTTEL" name="CUSTTEL" class="cmc_txt disabled" readonly="readonly" /></td>
		</tr>
		<tr>
			<th>거래처주소</th>
			<td colspan="3">
				<input type="text" id="CUSTPOST" name="CUSTPOST" class="cmc_post disabled" readonly="readonly"  />
				<input type="text" id="CUSTADDR" name="CUSTADDR" class="cmc_address disabled" readonly="readonly"  />
			</td>
			<th>과세구분</th>
			<td>
				<select id="VATFLG" name="VATFLG" class="cmc_combo">
					<c:forEach var="i" items="${codeVATFLG}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</td>
		</tr> --%>
		<tr >
			<th class="required">셀러</th>
			<td colspan="5">	
				<input type="text" id="ORGCD" name="ORGCD" class="cmc_code disabled" readonly="readonly"  />
				<input type="text" id="ORGNM" name="ORGNM" class="cmc_value disabled" readonly="readonly"  />
			</td>
		</tr>
		<tr>
			<th>전자결재번호</th>
			<td><input type="text" id="EAKEY" name="EAKEY" class="cmc_txt disabled" readonly="readonly" /></td>
			<th>결재상태</th>
			<td>
				<select id="DOCSTS" name="DOCSTS" class="cmc_combo disabled" disabled="disabled">
					<option value="">없음</option>
					<c:forEach var="i" items="${codeDOCSTS}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</td>
			<th>입고지시번호</th>
			<td><input type="text" id="WDKEY" name="WDKEY" class="cmc_txt disabled" readonly="readonly" /></td>		
		</tr>
		<tr>
			<th>입고차량번호</th>
			<td><input type="text" id="CARNO" name="CARNO" class="cmc_txt" /></td>
			<th>차량운전자</th>
			<td><input type="text" id="DRIVER" name="DRIVER" class="cmc_txt" /></td>	
			<th>운전자연락처</th>
			<td><input type="text" id="DRIVERTEL" name="DRIVERTEL" class="cmc_txt" /></td>			
		</tr>
		<tr>
			<th>비고</th>
			<td colspan="5">
				<textarea id="REMARK" name="REMARK" class="cmc_area" style="width:870px;"></textarea>
			</td>
		</tr>
	</table>
	</form>
</div>
<!-- 입력폼 끝 -->

<div class="ct_bot_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고 상세 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="button" id="btn_setPoPopup" class="cmb_normal" value="발주적용" onclick="pfn_PoPopup();" />
			<input type="button" id="btn_detailAdd" class="cmb_plus" onclick="fn_grid1RowAdd()"/>
			<input type="button" id="btn_detailDel" class="cmb_minus" onclick="fn_grid1RowDel()"/>
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
	initLayout();
	
	setCommBtn('del', null, '취소');
	setCommBtn('print', null, '출력');

	
	$('#WISCHDT').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	//로그인 정보로 세팅
	$('#DEPTCD').val(cfn_loginInfo().DEPTCD); 
	$('#DEPTNM').val(cfn_loginInfo().DEPTNM); 
	$('#USERCD').val(cfn_loginInfo().USERCD); 
	$('#USERNM').val(cfn_loginInfo().USERNM); 
	$('#COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#COMPNM').val(cfn_loginInfo().COMPNM); 
	$('#ORGCD').val(cfn_loginInfo().ORGCD);
	$('#ORGNM').val(cfn_loginInfo().ORGNM);

	grid2_Load();

	var wikey = '${param.wikey}';
	if(cfn_isEmpty(wikey)){
		fn_initDetail(gv_paramData);
	} else {
		cfn_setIDUR('U');
		gv_paramData.WIKEY = wikey;
		fn_initDetail(gv_paramData);
	}
	
	/* 공통코드 코드/명 (창고) */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'WHCD',
		inparam:{S_COMPCD:'COMPCD',S_WHCD:'WHCD,WHNM'},
		outparam:{WHCD:'WHCD',NAME:'WHNM'}
	});
	
	/* 공통코드 코드/명 (담당자) */
	pfn_codeval({
		url:'/alexcloud/popup/popS010/view.do',codeid:'USERCD',
		inparam:{S_USERCD:'USERCD,USERNM'},
		outparam:{USERCD:'USERCD',NAME:'USERNM', DEPTCD:'DEPTCD', DEPTNM:'DEPTNM'}
	});
	
	/* 공통코드 코드/명 (거래처) */
	/* pfn_codeval({
		url:'/alexcloud/popup/popP003/view.do',codeid:'CUSTCD',
		inparam:{S_CUSTCD:'CUSTCD,CUSTNM',S_COMPCD:'COMPCD',S_ORGCD:'ORGCD',S_ORGNM:'ORGNM'},
		outparam:{CUSTCD:'CUSTCD',NAME:'CUSTNM',POST:'CUSTPOST',ADDR1:'CUSTADDR',REFUSERNM:'CUSTUSERNM',REFUSERPHONE:'CUSTTEL'},
		params:{CODEKEY:'ISSUPPLIER'},
		returnFn: function(data, type) {
			var maxRowid = $('#grid2').dataProvider().getRowCount();
			if(maxRowid >= 0) {
				for(var i=0; i<maxRowid; i++){
					var grid2rowidx = $('#grid2').gridView().getDataRow(i);
					$('#grid2').gfn_setValue(grid2rowidx, 'CUSTCD', $('#CUSTCD').val());
				}
			}
		}
	}); */

});

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:120,formatter:'popup',editable:true,required:true,
			popupOption:{url:'/alexcloud/popup/popP006/view.do',
				inparam:{S_ITEMCD:'ITEMCD',/* CUSTCD:'CUSTCD', */S_COMPCD:'COMPCD',S_ORGCD:'ORGCD',S_ORGNM:'ORGNM'},
				outparam:{ITEMCD:'ITEMCD',NAME:'ITEMNM',ITEMSIZE:'ITEMSIZE',UNITCD:'UNITCD'},
				returnFn: function(data, type) {
					var rowidx = $('#' + gid).gfn_getCurRowIdx();
					/* var custcd = $('#CUSTCD').val(); */
					for (var i=0; i<data.length; i++) {
						if (i === 0) {
							$('#' + gid).gfn_setValue(rowidx, 'ITEMCD', data[i].ITEMCD);
							$('#' + gid).gfn_setValue(rowidx, 'ITEMNM', data[i].NAME);
							$('#' + gid).gfn_setValue(rowidx, 'ITEMSIZE', data[i].ITEMSIZE);
							$('#' + gid).gfn_setValue(rowidx, 'UNITCD', data[i].UNITCD);
							$('#' + gid).gfn_setValue(rowidx, 'LOT4', '');
							$('#' + gid).gfn_setValue(rowidx, 'LOT5', '');
							$('#' + gid).gfn_setValue(rowidx, 'UNITPRICE', data[i].UNITCOST);
							/* $('#' + gid).gfn_setValue(rowidx, 'CUSTCD', custcd); */
						} else {
							$('#' + gid).gfn_addRow({
								ITEMCD: data[i].ITEMCD
								, ITEMNM: data[i].NAME
								, ITEMSIZE: data[i].ITEMSIZE
								, UNITCD: data[i].UNITCD
								, LOT4: ''
								, LOT5: ''
								, UNITPRICE: data[i].UNITCOST
							});	
						}
					}
				}
			}
		},
		{name:'ITEMNM',header:{text:'품목명'},width:150},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'WISCHQTY_BOX',header:{text:'예정[BOX]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},			
		{name:'WISCHQTY_EA',header:{text:'예정[EA]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WISCHQTY',header:{text:'예정수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editable:true,required:true,editor:{maxLength:11,type:"number",positiveOnly:true,integerOnly: true},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY_BOX',header:{text:'입고[BOX]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},			
		{name:'WIQTY_EA',header:{text:'입고[EA]'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'WIQTY',header:{text:'입고수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'UNITPRICE',header:{text:'단가'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editable:true,editor:{maxLength:11,type:"number",positiveOnly:true,integerOnly: true},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'SUPPLYAMT',header:{text:'입고금액'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editable:true,editor:{maxLength:11,type:"number",positiveOnly:true,integerOnly: true},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
		{name:'REMARK',header:{text:'비고'},width:200,editable:true},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1), editor:{maxLength:50}, editable:true, show:cfn_getLotVisible(1)},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2), editor:{maxLength:50}, editable:true, show:cfn_getLotVisible(2)},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3), editor:{maxLength:50}, editable:true, show:cfn_getLotVisible(3)},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, editable:true, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},editable:true,comboValue:'${gCodeLOT4}'},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, editable:true, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},editable:true,comboValue:'${gCodeLOT5}'},
		{name:'POKEY',header:{text:'발주번호'},width:110},
		{name:'POSEQ',header:{text:'발주순번'},width:70,styles:{textAlignment:'right'}},
		{name:'WIKEY',header:{text:'입고번호'},width:110},
		{name:'SEQ',header:{text:'입고순번'},width:70,styles:{textAlignment:'right'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'WHCD',header:{text:'창고코드'},width:100},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}},
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
		

		{name:'ORIGINQTY',header:{text:'최초입고예정수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},visible:false,show:false},
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:110,visible:false,show:false}, */
		{name:'COMPCD',header:{text:'회사코드'},width:110,visible:false,show:false}
		];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {editable:true});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 수정 이벤트
		gridView.onEditChange = function(grid, column, value) {
			if (column.column === 'WISCHQTY') {
				var UNITPRICE = $('#' + gid).gfn_getValue(column.dataRow, 'UNITPRICE');
				$('#' + gid).gfn_setValue(column.dataRow, 'SUPPLYAMT', value * UNITPRICE);
			} else if (column.column === 'UNITPRICE') {
				var WISCHQTY = $('#' + gid).gfn_getValue(column.dataRow, 'WISCHQTY');
				$('#' + gid).gfn_setValue(column.dataRow, 'SUPPLYAMT', WISCHQTY * value);
			}
		};
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			 if( ($('#WISTS').val() !== '100')){				
				$('#' + gid).gfn_setColDisabled(['ITEMCD', 'WISCHQTY', 'UNITPRICE', 'SUPPLYAMT', 'REMARK', 'LOT1', 'LOT2', 'LOT3', 'LOT4', 'LOT5'], false);
			 }
			 var pokeyChk = cfn_isEmpty($('#' + gid).gfn_getValue(newRowIdx, 'POKEY')) && $('#WISTS').val() == '100';
			 $('#' + gid).gfn_setColDisabled(['ITEMCD'], pokeyChk);
			 			
		};
		//셀 수정 완료 이벤트
		/* gridView.onCellEdited = function(grid, itemIdx, dataRow, fieldIdx) {
	         if (dataProvider.getFieldName(fieldIdx) === 'ITEMCD') {
	         	var custcd = $('#CUSTCD').val();
	            if (cfn_isEmpty(custcd)) {
	               cfn_msg('WARNING', '거래처코드를 입력해 주세요.');
	               return false;
	            }
	    		$('#' + gid).gfn_setValue(dataRow, 'CUSTCD', custcd);
	         }
		}; */
		/* 버튼클릭 */
		/* gridView.onImageButtonClicked = function(grid, itemIdx, column, btnIdx, name) {
	         if (column.name === 'ITEMCD') {
	        	var custcd = $('#CUSTCD').val();
	            if (cfn_isEmpty(custcd)) {
		               cfn_msg('WARNING', '거래처코드를 입력해 주세요.');
		               return false;
	            }
	    		$('#' + gid).gfn_setValue($('#grid2').gridView().getDataRow(itemIdx), 'CUSTCD', custcd);
	         }
		}; */
	});
	
}
//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//상세검색
	if (sid == 'sid_getDetail') {
		var formData = data.resultData;
		var gridData = data.resultList;		
		if(formData.WISTS !== '100'){
			//폼 disabled시키는 부분 어떻게 풀어나갈지 생각하기
			var formIds = ['frmDetail'];
			var gridIDs = ['grid2'];
			cfn_formAllDisable(formIds, gridIDs);	
			$('#btn_setPoPopup').hide();
			         
		} 
		
		//발주적용된 전표에 한해 거래처, 창고 disabled 처리
		var cnt = 0;
		for(var i=0; i<gridData.length; i++ ){
			if(!cfn_isEmpty(gridData[i].POKEY)){
				cnt ++;
			}
		}
		if(cnt > 0){
			$('#WHCD').attr('readonly','readonly').addClass('disabled');
			$('#WHNM').attr('readonly','readonly').addClass('disabled');
			$('#btn_WHCD').attr('disabled','disabled').addClass('disabled');
			/* $('#CUSTCD').attr('readonly','readonly').addClass('disabled');
			$('#CUSTNM').attr('readonly','readonly').addClass('disabled');
			$('#btn_CUSTCD').attr('disabled','disabled').addClass('disabled');		 */	
		}
		cfn_bindFormData('frmDetail', formData);
		$('#grid2').gfn_setDataList(data.resultList);
	}
	if(sid == 'sid_setSave'){
		var formData = data.resultData;
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_setIDUR('U');
		fn_initDetail(formData);  		
	}
	if(sid == 'sid_setDelete'){
		var formData = data.resultData;
		cfn_msg('INFO', '정상적으로 취소되었습니다.');
		fn_initDetail(formData);
	}
	if(sid == 'sid_getPrint'){
	/* 	var formData = data.resultData;
		var wists = formData.WISTS;
		var wikey = formData.WIKEY;
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
			
		} */
	}
}

//상세 검색
function fn_initDetail(paramData) {
	
	if (cfn_getIDUR() === 'U') {
		$('#WIKEY').prop('readonly', true).addClass('disabled');
		var sid = 'sid_getDetail';
		var url = '/alexcloud/p100/p100301/getDetail.do';
		var sendData = {'paramData':paramData};
	
		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 목록 클릭
function cfn_list() {
	var param = {realurl:'/alexcloud/p100/p100380/view.do'};	
	parent.add_tab('/alexcloud/p100/p100380/view.do', '입고현황', '', '', 'P100380',param);
} 

/* 공통버튼 - 신규 클릭 */
function cfn_new(){
	gfn_pageMove('/alexcloud/p100/p100301/view.do');
}

/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg){
	//폼 필수입력 체크
	if (!cfn_isFormRequireData('frmDetail')) return false;
	gv_searchData = cfn_getFormData('frmDetail');
	
	if($('#WISTS').val() != '100') {
		cfn_msg('WARNING', '예정 상태일 때만 저장할 수 있습니다.');
		return;
	}

	var realRowData = $('#grid2').gfn_getDataList(true, false); //삭제된 행은 카운트하지 않는다.
	
	if(realRowData.length < 1) {
		cfn_msg('WARNING', '품목을 추가하세요.');
		return;
	}
	
	//디테일 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;
	
	var rowData = $('#grid2').gfn_getDataList();
	
	if (confirm('저장하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p100/p100301/setSave.do';
		var sendData = {'paramData':gv_searchData, 'paramList':rowData};
		
		gfn_sendData(sid, url, sendData);
	}
	
}

/* 공통버튼 - 취소 클릭 */
function cfn_del(){
	gv_searchData = cfn_getFormData('frmDetail');

	if($('#WISTS').val() != '100' || cfn_isEmpty($('#WIKEY').val())){
		cfn_msg('WARNING', '예정 상태일 때만 취소할 수 있습니다.');
		return false;
	}
	
	if (confirm('취소하시겠습니까?')) {

		var sid = 'sid_setDelete';
		var url = '/alexcloud/p100/p100301/setDelete.do';
		var sendData = {'paramData':gv_searchData};

		gfn_sendData(sid, url, sendData);
	}
}

/* 공통버튼 - 출력 클릭 */
function cfn_print(){
	var wikey = $('#WIKEY').val();
	
	pfn_popupOpen({
		url: '/alexcloud/p100/p100380/popReportView.do',
		pid: 'P100380_reportPop',
		returnFn: function(data, type) {
			var reportTitle,reportName;
			
			if(type === 'OK') {
				if(data.P100380_R === '1') { //입고요청서
						reportTitle = '입고요청서';
						reportName = 'P100300_R01';

				} else if(data.P100380_R === '2') {//거래명세서
						reportTitle = '거래명세서';
						reportName = 'P100300_R02';
						
				} else if(data.P100380_R === '3') {//입고요청서(빈양식)
						reportTitle = '입고요청서(빈양식)';
						reportName = 'P100300_R01';
						wikey = '';
				} else if(data.P100380_R === '4') {//거래명세서(빈양식)
					reportTitle = '거래명세서(빈양식)';
					reportName = 'P100300_R02';
					wikey = '';
				}	
				
				rfn_reportView({
					title: reportTitle,
					jrfName: reportName,
					args: {'WIKEY':wikey, 'PRINTUSERNM':cfn_loginInfo().USERNM}
				});		
			}
		}
	});
}

/* 그리드 행추가 버튼 클릭 */
function fn_grid1RowAdd() {
	if ($('#WISTS').val() !== '100') {
		alert('예정전표에서만 추가 가능합니다.');
		return false;
	}
	var whcd = $('#WHCD').val();
	if (cfn_isEmpty(whcd)) {
		cfn_msg('WARNING', '창고를 입력해주세요.');
		return false;
	}

	/* var custcd = $('#CUSTCD').val();
	var compcd = $('#COMPCD').val();
    if (cfn_isEmpty(custcd)) {
		cfn_msg('WARNING', '거래처를 입력해주세요.');
		return false;
	} */
	$('#grid2').gfn_addRow({'LOT4':'','LOT5':'',/* 'CUSTCD':custcd, */'COMPCD':compcd});
}	

/* 그리드 행삭제 버튼 클릭 */
function fn_grid1RowDel() {
	var rowidx = $('#grid2').gfn_getCurRowIdx();
	var state = $('#grid2').dataProvider().getRowState(rowidx);
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 행이 없습니다.');
		return false;
	}

	if ($('#WISTS').val() !== '100') {
		cfn_msg('WARNING', '예정전표에서만 삭제 가능합니다.');
		return false;
	}
	
	$('#grid2').gfn_delRow(rowidx);		
}
	

//발주 적용 팝업 오픈
function pfn_PoPopup() {
	if ($('#WISTS').val() != '100') {
		cfn_msg('WARNING', '예정 상태의 전표만 발주적용  할 수 있습니다.');
		return;
	}
	
	if (cfn_isEmpty($('#WHCD').val())) {
		cfn_msg('WARNING', '창고를 입력해 주세요.');
		return;
	}
	
	/* if(cfn_isEmpty($('#CUSTCD').val())) {
		cfn_msg('WARNING', '거래처를 입력해 주세요.');
		return;
	} */
	 
	/* var custcd = $('#CUSTCD').val();
	var custnm = $('#CUSTNM').val(); */
	var whcd = $('#WHCD').val();
	var whnm = $('#WHNM').val();
	 
	pfn_popupOpen({
		url:'/alexcloud/p100/p100300_popup/view.do',
		pid:'P100300_popup',
		params:{/* 'S_CUSTCD':custcd, 'S_CUSTNM':custnm, */ 
				'S_WHCD':whcd, 'S_WHNM':whnm},
		returnFn: function(data) {
			if (data.length > 0) {
				for (var i=0; i<data.length; i++) {
					$('#grid2').gfn_addRow({
						'ITEMCD':data[i].ITEMCD
						, 'ITEMNM':data[i].ITEMNM
						, 'WISCHQTY':data[i].AVAILABLEQTY
						, 'UNITPRICE':data[i].UNITPRICE
						, 'SUPPLYAMT':data[i].AVAILABLEQTY * data[i].UNITPRICE
						, 'REMARK':data[i].REMARK
						, 'POKEY':data[i].POKEY
						, 'POSEQ':data[i].SEQ
						, 'COMPCD':data[i].COMPCD
						, 'LOT4': ''
						, 'LOT5': ''
					});
					
				}
				
				$('#WHCD').attr('readonly','readonly').addClass('disabled');
				$('#WHNM').attr('readonly','readonly').addClass('disabled');
				$('#btn_WHCD').attr('disabled','disabled').addClass('disabled');
			}
		}		
	});	
}


</script>

<c:import url="/comm/contentBottom.do" />