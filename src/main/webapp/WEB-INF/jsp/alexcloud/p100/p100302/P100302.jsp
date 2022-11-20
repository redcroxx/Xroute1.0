<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P100302
	화면명    : 입고등록 - 그리드 +입력폼
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<ul class="sech_ul">
		<li class="sech_li">
			<div style="width:100px">입고요청일자</div>
			<div style="width:250px;">
				<input type="text" id="S_WISCHDT_FROM" class="cmc_date periods"/> ~
				<input type="text" id="S_WISCHDT_TO" class="cmc_date periods"/>
			</div>
		</li>
		<li class="sech_li">
			<div style="width:100px">입고상태</div>
			<div style="width:250px">
				<select id="S_WISTS" class="cmc_combo">
					<option value="NOT99"><c:out value="전체" /></option>
					<c:forEach var="i" items="${codeWISTS}">
						<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
					</c:forEach>
					<option value=""><c:out value="전체(취소포함)" /></option>
				</select>
			</div>
		</li>
		<li class="sech_li">
			<div style="width:100px">입고유형</div>
			<div style="width:250px">
				<select id="S_WITYPE" class="cmc_combo">
					<option value=""><c:out value="전체" /></option>
					<c:forEach var="i" items="${codeWITYPE}">
						<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
					</c:forEach>
				</select>
			</div>
		</li>
		<li class="cls"></li>
		<li class="sech_li">
			<div style="width:100px">입고일자</div>
			<div style="width:250px;">
				<input type="text" id="S_WIDT_FROM" class="cmc_date periods"/> ~
				<input type="text" id="S_WIDT_TO" class="cmc_date periods"/>
			</div>
		</li>
	<!-- 	<li class="sech_li">
			<div style="width:100px;">거래처</div>
			<div style="width:250px;">
				<input type="text" id="S_CUSTCD" class="cmc_code" />
				<input type="text" id="S_CUSTNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li> -->
		<li class="sech_li">
			<div style="width:100px;">
				<select id="S_SERACHCOMBO" class="cmc_combo" style="width:80px">
					<option value="WIKEY"><c:out value="입고번호"/></option>
					<option value="POKEY"><c:out value="발주번호"/></option>
				</select>
			</div>
			<div>				
				<input type="text" id="S_SEARCH" class="cmc_txt" />
			</div>
		</li>
		<li class="cls"></li>
		<li class="cls"></li>
		<li class="sech_li">
			<div style="width:100px;">창고</div>
			<div style="width:250px;">
				<input type="text" id="S_WHCD" class="cmc_code" />
				<input type="text" id="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<li class="sech_li">
			<div style="width:100px">품목코드/명</div>
			<div>		
				<input type="text" id="S_ITEM" class="cmc_txt" />
			</div>
		</li>
	</ul>
	<div id="sech_extbtn" class="down"></div>
	<div id="sech_extline"></div>
	<div id="sech_extwrap">
	<ul class="sech_ul">
		<li class="sech_li">
			<div style="width:100px;">담당자</div>
			<div style="width:250px;">
				<input type="text" id="S_USERCD" class="cmc_code" />				
				<input type="text" id="S_USERNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<li class="sech_li">
			<div style="width:100px;">부서</div>
			<div style="width:250px;">
				<input type="text" id="S_DEPTCD" class="cmc_code" />
				<input type="text" id="S_DEPTNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<li class="sech_li">
			<div style="width:100px;">사업장</div>
			<div style="width:250px;">
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
<div class="ct_left_wrap fix" style="width:500px">
	<div class="grid_top_wrap">
		<div class="grid_top_left">입고 리스트</div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<div class="ct_right_wrap">
	<div class="ct_top_wrap">
		<form id="frmDetail" action="#" onsubmit="return false">
		<input type="hidden" id="COMPCD" name="COMPCD" class="cmc_code" />
		<input type="hidden" id="POKEY" name="POKEY" class="cmc_code" />
		<table class="tblForm">
			<caption>기본정보</caption>
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
				<td><input type="text" id="WIDT" name="WIDT" class="cmc_date disabled" readonly="readonly"/></td>
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
				<th class="required">입고유형</th>
				<td>
					<select id="WITYPE" name="WITYPE" class="cmc_combo">
						<c:forEach var="i" items="${codeWITYPE}">
							<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
						</c:forEach>
					</select>
				</td>
				<th>입고상태</th>
				<td>
					<select id="WISTS" name="WISTS" class="cmc_combo disabled" disabled="disabled">
						<c:forEach var="i" items="${codeWISTS}">
							<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
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
					<input type="text" id="CUSTPOST" name="CUSTPOST" class="cmc_post disabled" readonly="readonly"/>
					<input type="text" id="CUSTADDR" name="CUSTADDR" class="cmc_address disabled" readonly="readonly"/>
				</td>
				<th class="required">과세구분</th>
				<td>
					<select id="VATFLG" name="VATFLG" class="cmc_combo required">
						<c:forEach var="i" items="${codeVATFLG}">
							<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
						</c:forEach>
					</select>
				</td>
			</tr> --%>
			<tr>
				<th class="required">담당자</th>
				<td>
					<input type="text" id="USERCD" name="USERCD" class="cmc_code required" />
					<input type="text" id="USERNM" name="USERNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</td>
				<th>부서</th>
				<td>
					<input type="text" id="DEPTCD" name="DEPTCD" class="cmc_code disabled" readonly="readonly"/>
					<input type="text" id="DEPTNM" name="DEPTNM" class="cmc_value disabled" readonly="readonly"/>
				</td>
				<th>사업장</th>
				<td>
					<input type="text" id="ORGCD" name="ORGCD" class="cmc_code disabled" readonly="readonly"/>
					<input type="text" id="ORGNM" name="ORGNM" class="cmc_value disabled" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th>전자결재번호</th>
				<td><input type="text" id="EAKEY" name="EAKEY" class="cmc_txt disabled" readonly="readonly" /></td>
				<th>결재상태</th>
				<td>
					<select id="DOCSTS" name="DOCSTS" class="cmc_combo disabled" disabled="disabled">
						<option value=""><c:out value="없음" /></option>
						<c:forEach var="i" items="${codeDOCSTS}">
							<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
						</c:forEach>
					</select>
				</td>
				<th>입고지시번호</th>
				<td><input type="text" id="WDKEY" name="WDKEY" class="cmc_txt disabled" readonly="readonly" /></td>
			</tr>
			<tr>
				<th>입고차량번호</th>
				<td><input type="text" id="CARNO" name="CARNO" class="cmc_txt" maxlength="20" /></td>
				<th>차량운전자</th>
				<td><input type="text" id="DRIVER" name="DRIVER" class="cmc_txt" maxlength="20" /></td>
				<th>운전자연락처</th>
				<td><input type="text" id="DRIVERTEL" name="DRIVERTEL" class="cmc_txt" maxlength="20" /></td>
			</tr>
			<tr>
				<th>비고</th>
				<td colspan="5">
					<textarea id="REMARK" name="REMARK" class="cmc_area"></textarea>
				</td>
			</tr>
		</table>
		</form>
	</div>
	
	<div class="ct_bot_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">입고 상세 리스트</div>
			<div class="grid_top_right">
				<input type="button" id="btn_setPoPopup" class="cmb_normal" value="발주적용" onclick="pfn_PoPopup();" />
				<input type="button" id="btn_detailAdd" class="cmb_plus"/>
				<input type="button" id="btn_detailDel" class="cmb_minus" />
			</div>
		</div>
		<div id="grid2"></div>
	</div>
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
	
	grid1_Load();
	grid2_Load();
	
	var fromdate = new Date();
	fromdate.setDate(fromdate.getDate() + 6);
	
	$('#S_WISCHDT_FROM').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_WISCHDT_TO').val(cfn_getDateFormat(fromdate, 'yyyy-MM-dd'));
	
	setCommBtn('del', null, '취소');
	setCommBtn('print', null, '출력');
		
	$('#S_WISTS').val('100');
	//로그인 정보로 세팅
	$('#S_DEPTCD').val(cfn_loginInfo().DEPTCD); 
	$('#S_DEPTNM').val(cfn_loginInfo().DEPTNM); 
	$('#S_USERCD').val(cfn_loginInfo().USERCD); 
	$('#S_USERNM').val(cfn_loginInfo().USERNM); 
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);

	/* 공통코드 코드/명 (사업장) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	/* 공통코드 코드/명 (창고) */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'S_WHCD,S_WHNM'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	
	/* 공통코드 코드/명 (부서) */
	pfn_codeval({
		url:'/alexcloud/popup/popP016/view.do',codeid:'S_DEPTCD',
		inparam:{S_DEPTCD:'S_DEPTCD,S_DEPTNM'},
		outparam:{DEPTCD:'S_DEPTCD',NAME:'S_DEPTNM'}
	});
	
	/* 공통코드 코드/명 (담당자) */
	pfn_codeval({
		url:'/alexcloud/popup/popS010/view.do',codeid:'S_USERCD',
		inparam:{S_USERCD:'S_USERCD,S_USERNM'},
		outparam:{USERCD:'S_USERCD',NAME:'S_USERNM'}
	});
	
	/* 공통코드 코드/명 (거래처) */
	/* pfn_codeval({
		url:'/alexcloud/popup/popP003/view.do',codeid:'S_CUSTCD',
		inparam:{S_COMPCD:'S_COMPCD',S_CUSTCD:'S_CUSTCD,S_CUSTNM'},
		outparam:{CUSTCD:'S_CUSTCD',NAME:'S_CUSTNM'},
		params:{CODEKEY:'ISSUPPLIER'}
	}); */
	
	/* 공통코드 코드/명 (창고) */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'WHCD,WHNM'},
		outparam:{WHCD:'WHCD',NAME:'WHNM'}
	});
	
	/* 공통코드 코드/명 (거래처) */
	/* pfn_codeval({
		url:'/alexcloud/popup/popP003/view.do',codeid:'CUSTCD',
		inparam:{S_COMPCD:'S_COMPCD',S_CUSTCD:'CUSTCD,CUSTNM'},
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
	
	/* 공통코드 코드/명 (담당자) */
	pfn_codeval({
		url:'/alexcloud/popup/popS010/view.do',codeid:'USERCD',
		inparam:{S_USERCD:'USERCD,USERNM'},
		outparam:{USERCD:'USERCD',NAME:'USERNM',DEPTCD:'DEPTCD',DEPTNM:'DEPTNM',ORGCD:'ORGCD',ORGNM:'ORGNM'}
	});
	
	//cfn_initSearch();
	
	/* 디테일 그리드 로우 추가 삭제 이벤트 */
	$('#btn_detailAdd').click(function() { btn_detailAdd_onClick(); });
	$('#btn_detailDel').click(function() { btn_detailDel_onClick(); });
	
	// 초기화면
	fn_viewDisable();
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'WIKEY',header:{text:'입고번호'},width:110},
		{name:'WISCHDT',header:{text:'입고요청일자'},width:110,styles:{textAlignment:'center'},formatter:'date',},
		{name:'WISTS',header:{text:'입고상태'},width:120,formatter:'combo',comboValue:'${gCodeWISTS}',styles:{textAlignment:'center'},
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = 100',styles:{figureBackground:'#FFFF00'}},
				{criteria:'(value = 200) or (value = 300)',styles:{figureBackground:'#FFA500'}},
				{criteria:'value = 400',styles:{figureBackground:'#008000'}},
				{criteria:'value = 99',styles:{figureBackground:'#ff0000'}}
			]		
		},
		/* {name:'CUSTNM',header:{text:'거래처명'},width:150}, */
		{name:'WIDT',header:{text:'입고일자'},width:90,styles:{textAlignment:'center'},formatter:'date'},
		{name:'WITYPE',header:{text:'입고유형'},width:100,styles:{textAlignment:'center'},formatter:'combo',comboValue:'${gCodeWITYPE}'},
		{name:'WHCD',header:{text:'창고코드'},width:100},
		{name:'WHNM',header:{text:'창고명'},width:80},
		/* {name:'CUSTCD',header:{text:'거래처코드'},width:100},
		{name:'CUSTPOST',header:{text:'우편번호'},width:100},
		{name:'CUSTADDR',header:{text:'주소'},width:100},
		{name:'CUSTUSERNM',header:{text:'거래처담당자'},width:100},
		{name:'CUSTTEL',header:{text:'거래처연락처'},width:100}, */
		{name:'VATFLG',header:{text:'과세구분'},width:70,styles:{textAlignment:'center'},formatter:'combo',comboValue:'${gCodeVATFLG}'},
		{name:'USERCD',header:{text:'담당자'},width:100},
		{name:'USERNM',header:{text:'담당자명'},width:70},
		{name:'REMARK',header:{text:'비고'},width:300},
		{name:'EAKEY',header:{text:'전자결재번호'},width:100},
		{name:'EASTS',header:{text:'결재상태'},width:70},
		{name:'ITEMCNT',header:{text:'품목수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'TOTQTY',header:{text:'총수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'TOTSUPPLYAMT',header:{text:'총입고금액'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'CARNO',header:{text:'입고차량번호'},width:100},
		{name:'DRIVER',header:{text:'차량운전자'},width:100},
		{name:'DRIVERTEL',header:{text:'운전자연락처'},width:100},
		{name:'POKEY',header:{text:'발주번호'},width:110},
		{name:'WDKEY',header:{text:'입고지시번호'},width:100},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'COMPNM',header:{text:'회사명'},width:100},
		{name:'ORGCD',header:{text:'사업장코드'},width:100},
		{name:'ORGNM',header:{text:'사업장명'},width:100},
		{name:'DEPTCD',header:{text:'부서코드'},width:100},
		{name:'DEPTNM',header:{text:'부서명'},width:100},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:120},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:120},
		{name:'TERMINALCD',header:{text:'IP'},width:100}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1){
				cfn_bindFormData('frmDetail', $('#' + gid).gfn_getDataRow(newRowIdx));
	
				if ($('#' + gid).gfn_getValue(newRowIdx, 'WISTS') != '100'){
					fn_viewDisable();
				} else {
					fn_viewEditable();
				}
				
				// 발주를 통한 등록 처리일경우 
				if(!cfn_isEmpty($('#POKEY').val())){
					$('#WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
					$('#WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
					$('#WHNM').next('button.cmc_cdsearch').hide();
					
				/* 	$('#CUSTCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
					$('#CUSTNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
					$('#CUSTNM').next('button.cmc_cdsearch').hide(); */
				}
	
				//if(!cfn_isEmpty($('#' + gid).gfn_getValue(newRowIdx, 'WIKEY'))) {
				//}
				var param = {'WIKEY':$('#' + gid).gfn_getValue(newRowIdx, 'WIKEY')};
				fn_getDetailList(param);	
			}
			
			
		};
	});
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'ITEMCD',header:{text:'품목코드'},width:100,editable:true,required:true,formatter:'popup',
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
							$('#' + gid).gfn_setValue(rowidx, 'UNITPRICE', data[i].UNITCOST);
							/* $('#' + gid).gfn_setValue(rowidx, 'CUSTCD', custcd); */
						
						} else {
							$('#' + gid).gfn_addRow({
								ITEMCD: data[i].ITEMCD
								, ITEMNM: data[i].NAME
								, ITEMSIZE: data[i].ITEMSIZE
								, UNITCD: data[i].UNITCD
								, UNITPRICE: data[i].UNITCOST
							});	
						}
					}
				}
			}
		},
		{name:'ITEMNM',header:{text:'품명'},width:200},
		{name:'ITEMSIZE',header:{text:'규격'},width:80,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:80,styles:{textAlignment:'center'}},
		{name:'WISCHQTY',header:{text:'예정수량'},width:80,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},required:true,
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'WIQTY',header:{text:'입고수량'},width:80,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'UNITPRICE',header:{text:'단가'},width:100,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},required:true,
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'SUPPLYAMT',header:{text:'입고금액'},width:100,editable:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},required:true,
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1), editor:{maxLength:50}, editable:true, show:cfn_getLotVisible(1)},
		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2), editor:{maxLength:50}, editable:true, show:cfn_getLotVisible(2)},
		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3), editor:{maxLength:50}, editable:true, show:cfn_getLotVisible(3)},
		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, editable:true, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},editable:true,comboValue:gCodeLOT4},
		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, editable:true, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},editable:true,comboValue:gCodeLOT5},
		{name:'REMARK',header:{text:'비고'},width:300,editable:true,maxlength:10},
		{name:'POKEY',header:{text:'발주번호'},width:110},
		{name:'POSEQ',header:{text:'발주순번'},width:100},
		{name:'WIKEY',header:{text:'입고번호'},width:110},
		{name:'SEQ',header:{text:'입고순번'},width:70},
		{name:'COMPCD',header:{text:'회사코드'},width:100},
		{name:'WHCD',header:{text:'창고코드'},width:100},
		{name:'ORIGINQTY',header:{text:'최초입고예정수량'},width:120,styles:{textAlignment:'right'}, visible:false},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:120},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:120},
		{name:'TERMINALCD',header:{text:'IP'},width:100},
		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'},show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100,show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100,show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100,show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100,show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100,show:cfn_getCompItemVisible(15)}/* ,
		{name:'CUSTCD',header:{text:'거래처코드'},width:110,visible:false,show:false} */
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
			if (newRowIdx > -1) {
				var editable = cfn_isEmpty(grid.getValue(newRowIdx, 'POKEY'));
				$('#' + gid).gfn_setColDisabled(['ITEMCD'], editable);
				
				if($('#WISTS').val() != '100'){
					$('#' + gid).gfn_setColDisabled(['ITEMCD'], false);
				} else {
					$('#' + gid).gfn_setColDisabled(['ITEMCD'], true);
				}
			}
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

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		cfn_clearFormData('frmDetail');

		$('#grid2').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
	}
	//디테일리스트검색
	if (sid == 'sid_getDetailList') {
		$('#grid2').gfn_setDataList(data.resultList);
	}
	//저장
	if(sid == 'sid_setSave') {
		var resultData = data.resultData;
		var wikey = data.wikey; // 신규등록 입고번호
		
		if(resultData['SCNT'] > 0) {
			cfn_msg('INFO','정상적으로 저장되었습니다.');
			
			// 검색내역 바인딩
			var gridData = data.resultList;
			var wikey = data.wikey;

			$('#grid2').dataProvider().clearRows();
			$('#grid1').gfn_setDataList(gridData);

			// 검색결과에 등록입고번호가 있다면 찾아서 바인딩
			 if (gridData.length > 0) {
				if(!cfn_isEmpty(wikey)) {
					var options = {
						    fields : ['WIKEY'],
						    values : [wikey]
						}
					var itemindex = $('#grid1').gridView().searchItem(options);
					
					$('#grid1').gridView().setCurrent(itemindex);
					$('#grid1').gridView().setFocus();
					return;
				}
			}
			
		} else {
			cfn_msg('WARNING','저장 오류');
		}
	}
	//삭제
	if(sid == 'sid_setDelete') {
		var resultData = data.resultData;
		
		if(resultData['SCNT'] > 0) {
			cfn_msg('INFO','정상적으로 취소되었습니다.');
			cfn_retrieve();
		} else {
			cfn_msg('WARNING','취소 오류');
		}
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p100/p100302/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 디테일 리스트 검색 */
function fn_getDetailList(param) {
	var sid = 'sid_getDetailList';
	var url = '/alexcloud/p100/p100302/getDetailList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 신규 클릭 */
function cfn_new() {
	
	fn_viewEditable();
	cfn_clearFormData('frmDetail');
	
	//로그인 정보로 세팅
	$('#DEPTCD').val(cfn_loginInfo().DEPTCD); 
	$('#DEPTNM').val(cfn_loginInfo().DEPTNM); 
	$('#USERCD').val(cfn_loginInfo().USERCD); 
	$('#USERNM').val(cfn_loginInfo().USERNM); 
	$('#COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#COMPNM').val(cfn_loginInfo().COMPNM); 
	$('#ORGCD').val(cfn_loginInfo().ORGCD);
	$('#ORGNM').val(cfn_loginInfo().ORGNM);

	$('#WISCHDT').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#WITYPE').val('STD');
	$('#WISTS').val('100');
	$('#VATFLG').val('0');
	
	$('#grid1').dataProvider().clearRows();
	$('#grid2').dataProvider().clearRows();
}

/* 공통버튼 - 저장 클릭 */
function cfn_save() {

	var formData = formIdAllToMap('frmDetail');
	
	if($('#WISTS').val() != '100') {
		cfn_msg('WARNING','예정 상태의 전표만 저장할 수 있습니다.');
		return;
	}

	//필수입력 체크
	if(!cfn_isFormRequireData('frmDetail')) return false;
	
	var realRowData = $('#grid2').gfn_getDataList(true, false); //삭제된 행은 카운트하지 않는다.
	
	if(realRowData.length < 1) {
		cfn_msg('WARNING','입고상세 품목을 추가하세요.');
		return;
	}
	
	//디테일 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;
	
	/*for (var i=0, len=gridDataRows.length; i<len; i++) {
		if($('#grid2').gfn_getValue(i, 'ITEMCD') == '' || $('#grid2').gfn_getValue(i, 'ITEMCD') == null) {
			var index = {dataRow:i,fieldName:'ITEMCD'};
			$('#grid2').gridView().setCurrent(index);
			$('#grid2').gridView().setFocus();
			alert('품목을 입력하세요.');
			return;
		}
		if($('#grid2').gfn_getValue(i, 'WISCHQTY') == 0 || $('#grid2').gfn_getValue(i, 'WISCHQTY') == '' || $('#grid2').gfn_getValue(i, 'WISCHQTY') == null) {
			var index = {dataRow:i,fieldName:'WISCHQTY'};
			$('#grid2').gridView().setCurrent(index);
			$('#grid2').gridView().setFocus();
			alert('예정수량을 입력하세요.');
			return;
		}
	}*/
	
	var gridDataRows = $('#grid2').gfn_getDataList();
	
	//검색조건
	gv_searchData = cfn_getFormData('frmSearch');
	
	if (confirm('저장하시겠습니까?')) {

		var sid = 'sid_setSave';
		var url = '/alexcloud/p100/p100302/setSave.do';
		var sendData = {'formData':formData, 'dGridData':gridDataRows, 'searchData':gv_searchData};
		
		gfn_sendData(sid, url, sendData);
	}
}

/* 공통버튼 - 취소 클릭 */
function cfn_del() {
	var formData = formIdAllToMap('frmDetail');
	var wikey = $('#WIKEY').val();
	if(cfn_isEmpty(wikey)){
		cfn_msg('WARNING','등록된 예정전표만 취소할수 있습니다.');
		return;
	}
	
	if($('#WISTS').val() != '100') {
		cfn_msg('WARNING','예정 상태의 전표만 취소할 수 있습니다.');
		return;
	}
	
	if(confirm('입고번호 : [' + wikey + '] 취소하시겠습니까?')) {			
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p100/p100302/setDelete.do';
		var sendData = {'paramData':formData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//디테일 그리드 추가 버튼 이벤트
function btn_detailAdd_onClick() {
	var wists = $('#WISTS').val();
	
	if (wists != '100') {
		cfn_msg('WARNING','예정 상태의 전표만 추가할 수 있습니다.');
		return;
	} else {
		var whcd = $('#WHCD').val();
		if (cfn_isEmpty(whcd)) {
			cfn_msg('WARNING', '창고를 입력해주세요.');
			return false;
		}
		
		$('#grid2').gfn_addRow({'COMPCD':cfn_loginInfo().COMPCD/* ,'CUSTCD':custcd */});
	}
}  

//디테일 그리드 삭제 버튼 이벤트
function btn_detailDel_onClick() {

	var rowidx = $('#grid2').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING','선택된 행이 없습니다.');
		return false;
	}
	
	if ($('#WISTS').val() !== '100') {
		cfn_msg('WARNING','예정전표에서만 삭제 가능합니다.');
		return false;
	}
	
	$('#grid2').gfn_delRow(rowidx);
}  

//발주 적용 팝업 오픈
function pfn_PoPopup() {
	
	if ($('#WISTS').val() != '100') {
		cfn_msg('WARNING','예정 상태의 전표만 발주적용 할 수 있습니다.');
		return;
	}

	if (cfn_isEmpty($('#WHCD').val())) {
		cfn_msg('WARNING','창고를 선택하고 적용하세요.');
		$('#WHCD').focus();
		return;
	}
	
	/* if(cfn_isEmpty($('#CUSTCD').val())) {
		cfn_msg('WARNING','거래처를 선택하고 적용하세요.');
		$('#CUSTCD').focus();
		return;
	} */
	
	pfn_popupOpen({
		url:'/alexcloud/p100/p100300_popup/view.do',
		pid:'P100300_popup',
		params:{/* 'S_CUSTCD':$('#CUSTCD').val(), 'S_CUSTNM':$('#CUSTCD').val(),  */
				'S_WHCD':$('#WHCD').val(), 'S_WHNM':$('#WHNM').val()},
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
					});
				}
				$('#POKEY').val(data[0].POKEY); //보통 발주전표 단위로 입고전표가 생성된다고 본다. 첫번째 발주번호만 넣어준다.
			}
		}
	});	
}

// 출력
function cfn_print(){
var wikey = $('#WIKEY').val();
	
	pfn_popupOpen({
		url: '/alexcloud/p100/p100380/popReportView.do',
		pid: 'P100380_reportPop',
		returnFn: function(data, type) {
			var reportTitle,reportName;
			
			if (type === 'OK') {
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

//막은거 풀어줌
function fn_viewEditable(){
	
	if (!$('#WISCHDT').hasClass('apply')) {
		$('#WISCHDT').after('<button type="button" class="cmb_calendar" tabindex="-1"></button>').addClass('apply').datetimepicker({
		language: 'ko'
		, format: 'yyyy-mm-dd'
		, autoclose: true
		, startView: 'month'
		, minView: 'month'
		, todayBtn: true
		, todayHighlight: true
		, forceParse: false}).attr({'maxlength':10}).on('blur', function(e) {
			var $t = $(this);
			if (cfn_isDateTime($t.val())) {
				$t.val(cfn_getDateFormat($t.val(), 'yyyy-MM-dd'));
			} else {
				$t.val('');
			}
		}).on('click', function(e) {
			$e = $(this);
			if ($e.hasClass('periods')) {
				var endDt = $($e.nextAll('input.periode')[0]).val();
				if (!cfn_isEmpty(endDt)) {
					$e.datetimepicker('setEndDate', endDt);
				}
			} else if ($e.hasClass('periode')) {
				var startDt = $($e.prevAll('input.periods')[0]).val();
				if (!cfn_isEmpty(startDt)) {
					$e.datetimepicker('setStartDate', startDt);
				}
			}
				$e.datetimepicker('update').datetimepicker('show');
		});
		$('#WISCHDT').next('button.cmb_calendar').on('click', function(e) {
			$e = $(this).prev('input.cmc_date');
			if ($e.hasClass('periods')) {
				var endDt = $($e.nextAll('input.periode')[0]).val();
				if (!cfn_isEmpty(endDt)) {
					$e.datetimepicker('setEndDate', endDt);
				}
			} else if ($e.hasClass('periode')) {
				var startDt = $($e.prevAll('input.periods')[0]).val();
				if (!cfn_isEmpty(startDt)) {
					$e.datetimepicker('setStartDate', startDt);
				}
			}
			$e.datetimepicker('update').datetimepicker('show');
		});
	} 
	$('#WISCHDT').attr('disabled',false).removeClass('disabled').attr('readonly',false);
	$('#grid2').gfn_setColDisabled(['ITEMCD', 'WISCHQTY', 'UNITPRICE', 'SUPPLYAMT', 'REMARK', 'LOT1', 'LOT2', 'LOT3', 'LOT4', 'LOT5'], true);
	$('#WHCD').attr('disabled',false).removeClass('disabled').attr('readonly',false);
	$('#WHNM').attr('disabled',false).removeClass('disabled').attr('readonly',false);
	$('#WITYPE').attr('disabled',false).removeClass('disabled');
	/* $('#CUSTCD').attr('disabled',false).removeClass('disabled').attr('readonly',false);
	$('#CUSTNM').attr('disabled',false).removeClass('disabled').attr('readonly',false); */
	$('#VATFLG').attr('disabled',false).removeClass('disabled');
	$('#USERCD').attr('disabled',false).removeClass('disabled').attr('readonly',false);
	$('#USERNM').attr('disabled',false).removeClass('disabled').attr('readonly',false);
	$('#CARNO').attr('disabled',false).removeClass('disabled').attr('readonly',false);
	$('#DRIVER').attr('disabled',false).removeClass('disabled').attr('readonly',false);
	$('#DRIVERTEL').attr('disabled',false).removeClass('disabled').attr('readonly',false);
	$('#REMARK').attr('disabled',false).removeClass('disabled').attr('readonly',false);
	
	$('#frmDetail').find('.cmc_cdsearch').show();
	$('#btn_setPoPopup').show();
	$('#btn_detailAdd').show();
	$('#btn_detailDel').show();
}

//disable
function fn_viewDisable(){
	
	$('#grid2').gfn_setColDisabled(['ITEMCD', 'WISCHQTY', 'UNITPRICE', 'SUPPLYAMT', 'REMARK', 'LOT1', 'LOT2', 'LOT3', 'LOT4', 'LOT5'], false);

	$('#WISCHDT').attr('disabled',true).addClass('disabled').attr('readonly','readonly').not('.nodis').attr('tabindex','-1').removeClass('apply').datetimepicker('remove').off('click');
	$('#WISCHDT').not('.nodis').next('button.cmb_calendar').remove();
	
	$('#WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	$('#WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	$('#WITYPE').attr('disabled',true).addClass('disabled');
	/* $('#CUSTCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	$('#CUSTNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly'); */
	$('#VATFLG').attr('disabled',true).addClass('disabled');
	$('#USERCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	$('#USERNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	$('#CARNO').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	$('#DRIVER').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	$('#DRIVERTEL').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	$('#REMARK').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
	
	$('#frmDetail').find('.cmc_cdsearch').hide();
	$('#btn_setPoPopup').hide();
	$('#btn_detailAdd').hide();
	$('#btn_detailDel').hide();
	
}
</script>

<c:import url="/comm/contentBottom.do" />