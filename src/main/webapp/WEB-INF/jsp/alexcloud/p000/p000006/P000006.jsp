<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000006
	화면명    : 품목 관리
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<ul class="sech_ul">
			<li class="sech_li required">
				<div>회사</div>
				<div>
					<input type="text" id="S_COMPCD" class="cmc_code required" readonly="readonly" disabled /> 
					<input type="text" id="S_COMPNM" class="cmc_value" readonly="readonly" disabled />
					<button type="button" class="cmc_cdsearch disabled" disabled></button>
				</div>
			</li>
			<li class="sech_li required">
				<div>셀러</div>
				<div>
					<input type="text" id="S_ORGCD" class="cmc_code required" />				
					<input type="text" id="S_ORGNM" class="cmc_value" />
					<button type="button" id="S_ORGCD_BTN" class="cmc_cdsearch" id="btn_S_ORGCD"></button>
				</div>
			</li>
			<li class="sech_li">
				<div>사용여부</div>
				<div>
					<select id="S_ISUSING" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_ISUSING}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
			<%-- <li class="sech_li">
				<div>소형품목여부</div>
				<div>
					<select id="S_SMALL_YN" class="cmc_combo">
						<option value="">--전체--</option>
						<c:forEach var="i" items="${CODE_YNNUMBER}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li> --%>
		</ul>
		<ul class="sech_ul">
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
		<ul style="padding-top: 10px;">
			<li>
			<div>
				<p style="padding-left: 20px;">
							<font color="red">※ 품목은 상품의 옵션별로 각 한개씩 등록하여야 합니다. 예) 품목명 : 제품 / 컬러 / 사이즈</font>
				</p>
			</div>
			</li>		
		</ul>
		<%-- <div id="sech_extbtn" class="down"></div>
		<div id="sech_extline"></div>
		<div id="sech_extwrap">
			<!-- 회사별 상품정보 조회조건 -->
			<c:import url="/comm/compItemSearch.do" />
			<ul class="sech_ul">
				<li class="sech_li">
					<div>바코드</div>
					<div>
						<input type="text" id="S_BARCODE" class="cmc_txt" />
					</div>
				</li>
				<li class="sech_li">
					<div>시리얼관리여부</div>
					<div>
						<select id="S_SERIAL_SCAN_YN" class="cmc_combo">
							<option value="">--전체--</option>
							<c:forEach var="i" items="${CODE_YN}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>
					</div>
				</li>
				<li class="sech_li">
					<div>보관온도</div>
					<div>
						<select id="S_STKTMP" class="cmc_combo">
							<option value="">--전체--</option>
							<c:forEach var="i" items="${CODE_STKTMP}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>
					</div>
				</li>
			</ul>
		</div> --%>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_top_wrap fix" style="height:65%">
	<div class="grid_top_wrap">
		<div class="grid_top_left">품목<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="button" id="btn_upload" class="cmb_normal" value="업로드" onclick="pfn_upload('P000006');" />
			<button type="button" id="btn_grid1Add" class="cmb_plus" onclick="fn_grid1AddRow()"></button>
			<button type="button" id="btn_grid1Del" class="cmb_minus" onclick	="fn_grid1DelRow()"></button>
		</div>		
	</div>
	<div id="grid1"></div>
</div>

<!-- 그리드 시작 -->
<div class="ct_bot_wrap">
	<div class="ct_left_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">품목바코드<span>(총 0건)</span></div>
			<div class="grid_top_right">
				<button type="button" id="btn_grid2Add" class="cmb_plus" onclick="fn_grid2AddRow()"></button>	
				<button type="button" id="btn_grid2Del" class="cmb_minus" onclick="fn_grid2DelRow()"></button>	
			</div>		
		</div>
		<div id="grid2"></div>
	</div>
	
	 <div class="ct_right_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">대입코드<span>(총 0건)</span></div>
			<div class="grid_top_right">
				<button type="button" id="btn_grid3Add" class="cmb_plus" onclick="fn_grid3AddRow()"></button>	
				<button type="button" id="btn_grid3Del" class="cmb_minus" onclick="fn_grid3DelRow()"></button>			
			</div>
		</div>
		<div id="grid3"></div>
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

	setCommBtn('del', null, '미사용');
	/* setCommBtn('print', null, '라벨출력'); */
	
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
	$('#S_ISUSING').val('Y');
	
	grid1_Load();
	grid2_Load();
	grid3_Load();
	
	authority_Load();
	
	//셀러
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	//품목분류
	pfn_codeval({
		url:'/alexcloud/popup/popP017/view.do',codeid:'S_ITEMCATCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ITEMCAT:'S_ITEMCATCD,S_ITEMCATNM'},
		outparam:{ITEMCATCD:'S_ITEMCATCD',NAME:'S_ITEMCATNM'}
	});

});

function authority_Load(){
	
	if (cfn_loginInfo().USERGROUP == '${SELLER_ADMIN}' || cfn_loginInfo().USERGROUP == '${CENTER_ADMIN}' || cfn_loginInfo().USERGROUP == '${CENTER_USER}') {
		$('#S_ORGCD').prop("disabled",true);
		$('#S_ORGNM').prop("disabled",true);
		$('#S_ORGCD_BTN').prop("disabled",true);
 	}
};

function grid1_Load() {
	var gid = 'grid1', $grid = $('#' + gid);
	var columns = [
		{name:'ISUSING',header:{text:'사용여부'},width:80,required:true,formatter:'combo',comboValue:'${GCODE_ISUSING}',
			renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
			dynamicStyles:[
				{criteria:'value = "Y"',styles:{figureBackground:cfn_getStsColor(3)}},
				{criteria:'value = "N"',styles:{figureBackground:cfn_getStsColor(0)}}
	        ]
		},
		
		{name:'ITEMCD',header:{text:'품목코드'},width:100,editable:true,required:true,editor:{maxLength:20},styles:{textAlignment:'center'}},
		{name:'NAME',header:{text:'품목명'},width:350,editable:true,required:true,editor:{maxLength:100}},
		{name:'SNAME',header:{text:'품목명(약칭)'},width:200,editable:true,editor:{maxLength:100}},
		{name:'FNAME',header:{text:'품목명(별칭)'},width:200,editable:true,editor:{maxLength:100}},
		
		/* {name:'CUSTCD',header:{text:'매입처코드'},width:120,formatter:'popup',editable:true,required:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP003/view.do',
				inparam:{S_CUSTCD:'CUSTCD',S_COMPCD:'COMPCD',S_ORGCD:'ORGCD',S_ORGNM:'ORGNM'},
				outparam:{CUSTCD:'CUSTCD',NAME:'CUSTNM'},
				params:{CODEKEY:'ISSUPPLIER'}}
		},
		{name:'CUSTNM',header:{text:'매입처명'},width:160}, */
		
		/* {name:'SERIAL_SCAN_YN',header:{text:'시리얼\n관리여부'},width:100,formatter:'checkbox'}, */
		{name:'MAX_CLGO_QTY',header:{text:'개별\n품목여부'},width:100,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'SETYN',header:{text:'세트여부'},width:100,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		/* {name:'SMALL_YN',header:{text:'소형\n품목여부'},width:100,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		{name:'SEVENTY',header:{text:'70%\n품목여부'},width:100,formatter:'checkbox',renderer:{editable:true,trueValues:"1",falseValues:"0"}},
		
		{name:'ITEMTYPE',header:{text:'품목유형'},width:100,formatter:'combo',comboValue:'${GCODE_ITEMTYPE}',styles:{textAlignment:'center'},editable:true,editor:{maxLength:10}}, */
		{name:'STKTMP',header:{text:'보관온도'},width:100,formatter:'combo',comboValue:'${GCODE_STKTMP}',styles:{textAlignment:'center'},editable:true},
		{name:'SUPUNIT',header:{text:'보충단위'},width:100,formatter:'combo',comboValue:'${GCODE_SUPUNIT}',styles:{textAlignment:'center'},editable:true},
		{name:'SUPRATE',header:{text:'보충배율(%)'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editable:true,required:true,editor:{maxLength:10,type:"number",positiveOnly:true,integerOnly: true},minVal:100},
		/* {name:'EXPMONTH',header:{text:'유통기한(월)'},width:120,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editable:true,editor:{maxLength:10,type:"number",positiveOnly:true,integerOnly: true}}, */
		{name:'BARCODE',header:{text:'바코드'},width:300},
		
		{name:'UNITTYPE',header:{text:'관리단위'},width:100,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'},editable:true},
		{name:'INBOXQTY',header:{text:'박스입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editable:true,required:true,editor:{maxLength:10,type:"number",positiveOnly:true,integerOnly: true},minVal:1},
		{name:'INPLTQTY',header:{text:'팔레트\n입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},editable:true,editor:{maxLength:10,type:"number",positiveOnly:true,integerOnly: true},minVal:1},
		{name:'LENGTH',header:{text:'깊이'},width:100,dataType:'number',required:true,styles:{textAlignment:'far',numberFormat:'#,##0.###'},editable:true,editor:{maxLength:17, type: "number", positiveOnly: true, integerOnly: true}},
		{name:'WIDTH',header:{text:'폭'},width:100,dataType:'number',required:true,styles:{textAlignment:'far',numberFormat:'#,##0.###'},editable:true,editor:{maxLength:17, type: "number", positiveOnly: true, integerOnly: true}},
		{name:'HEIGHT',header:{text:'높이'},width:100,dataType:'number',required:true,styles:{textAlignment:'far',numberFormat:'#,##0.###'},editable:true,editor:{maxLength:17, type: "number", positiveOnly: true, integerOnly: true}},
		{name:'EA_MAX',header:{text:'최대길이'},width:100,dataType:'number',required:true,styles:{textAlignment:'far',numberFormat:'#,##0.###'},editable:true,editor:{maxLength:17, type: "number", positiveOnly: true, integerOnly: true}},
		{name:'CAPACITY',header:{text:'용량'},width:100,dataType:'number',required:true,styles:{textAlignment:'far',numberFormat:'#,##0.###'},editable:true,editor:{maxLength:17, type: "number", positiveOnly: true, integerOnly: true}},

		{name:'UNITCD',header:{text:'단위'},width:100,styles:{textAlignment:'center'},editable:true,editor:{maxLength:10}},
		{name:'ITEMSIZE',header:{text:'규격'},width:100,editable:true,editor:{maxLength:20},styles:{textAlignment:'center'}},
		/* {name:'UNITCOST',header:{text:'매입단가'},width:100,required:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			editable:true,editor:{maxLength:13,type:'number',positiveOnly:true,integerOnly:true,editFormat:'#,##0'}
		}, */
		/* {name:'UNITPRICE',header:{text:'판매단가'},width:100,required:true,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			editable:true,editor:{maxLength:13,type:'number',positiveOnly:true,integerOnly:true,editFormat:'#,##0'}
		}, */
		{name:'REMARK',header:{text:'비고'},width:400,editable:true,editor:{type: 'multiline', maxLength:255}},
		
		{name:'MANUFACTURE',header:{text:'제조사'},width:100,editable:true,editor:{maxLength:20}},
		{name:'MANUCOUNTRY',header:{text:'제조국'},width:100,editable:true,editor:{maxLength:20}},
		{name:'ITEMCAT1NM',header:{text:'대분류'},width:120},
		{name:'ITEMCAT2NM',header:{text:'중분류'},width:120},
		{name:'ITEMCAT3NM',header:{text:'소분류'},width:120,formatter:'popup',editable:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP017/view.do',
				inparam:{S_COMPCD:'COMPCD',S_ITEMCAT:'ITEMCAT3NM'},
				outparam:{ITEMCAT1NM:'ITEMCAT1NM',ITEMCAT2NM:'ITEMCAT2NM',ITEMCAT3CD:'ITEMCAT3CD',ITEMCAT3NM:'ITEMCAT3NM'},
				params:{S_LVL3:'Y'}}
		},
	/* 	{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20},show:cfn_getCompItemVisible(1)},
		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20},show:cfn_getCompItemVisible(2)},
		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20},show:cfn_getCompItemVisible(3)},
		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20},show:cfn_getCompItemVisible(4)},
		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'},editable:true,editor:{maxLength:20},show:cfn_getCompItemVisible(5)},
		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100,editable:true,editor:{maxLength:50},show:cfn_getCompItemVisible(11)},
		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100,editable:true,editor:{maxLength:50},show:cfn_getCompItemVisible(12)},
		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100,editable:true,editor:{maxLength:50},show:cfn_getCompItemVisible(13)},
		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100,editable:true,editor:{maxLength:50},show:cfn_getCompItemVisible(14)},
		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100,editable:true,editor:{maxLength:50},show:cfn_getCompItemVisible(15)}, */
		{name:'ORGCD',header:{text:'셀러코드'},width:100,formatter:'popup',editable:true,required:true,editor:{maxLength:20},
			popupOption:{url:'/alexcloud/popup/popP002/view.do',
				inparam:{S_COMPCD:'COMPCD',S_ORGCD:'ORGCD'},outparam:{ORGCD:'ORGCD',NAME:'ORGNM'}}
		},
		{name:'ORGNM',header:{text:'셀러명'},width:100},
		
		{name:'ADDUSERCD',header:{text:'등록자'},width:120,styles:{textAlignment:'center'}},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:150,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:100,visible:false},
		{name:'ITEMCAT3CD',header:{text:'소분류코드'},width:100,visible:false}
	];
	$grid.gfn_createGrid(columns, {editable:true,footerflg:false,checkBar:true});
	
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		//열고정 이벤트
		gridView.setFixedOptions({colCount:3,resizable:true,colBarWidth:1});
		
		$('#'+gid).gridView().setColumnProperty(
				gridView.columnByField("NAME"),
		    	 "dynamicStyles", [{
		            criteria: [
		            	"values['NAME'] <> ''"
		            ],
		            styles: [
		            	"background=#33ff33"
		            ]
		        }]
			)
		//셀 변경 중 이벤트
		gridView.onCurrentChanging =  function (grid, oldIndex, newIndex) {
			if (oldIndex.dataRow !== -1 && oldIndex.dataRow !== newIndex.dataRow) {
				$('#grid2').gridView().commit();
				$('#grid3').gridView().commit();
			} 
		};
		//셀 로우 변경 이벤트
	 	gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var state = dataProvider.getRowState(newRowIdx);
				var rowData = $grid.gfn_getDataRow(newRowIdx);
				
				if (rowData.ISUSING === 'N') {
					setCommBtn('del', null, '사용', {iconname:'btn_on.png'});
				} else {
					setCommBtn('del', null, '미사용', {iconname:'btn_del.png'});
				}
				
				var editable = state === 'created';
				$grid.gfn_setColDisabled(['ORGCD', 'ITEMCD','UNITCOST','UNITPRICE','UNITCOST','UNITPRICE','BARCODE'], editable);
				
				if (rowData.UNITTYPE === 'EA') {
					$grid.gfn_setColDisabled(['INBOXQTY'], false);
				} else {
					$grid.gfn_setColDisabled(['INBOXQTY'], true);
				}
				
				if(!cfn_isEmpty(cfn_loginInfo().ORGCD)){
					$('#' + gid).gfn_setColDisabled(['ORGCD'], false);
				}
				
				var itemcd = $('#' + gid).gfn_getValue(newRowIdx, 'ITEMCD');
				
				if(!cfn_isEmpty(itemcd)) {
					
					var rowidx = $('#' + gid).gfn_getCurRowIdx();
					var masterData = $('#' + gid).gfn_getDataRow(rowidx);
					
					fn_getItemDtlList(masterData);					
				}
			}
		};
		
		//셀 수정 완료 이벤트
		gridView.onCellEdited = function(grid, itemIdx, dataRow, fieldIdx) {
	        if (dataProvider.getFieldName(fieldIdx) === 'UNITTYPE') {
	        	if( $('#' + gid).gfn_getValue(dataRow, 'UNITTYPE') == 'EA'){
	        		$('#' + gid).gfn_setValue(dataRow, 'INBOXQTY', 1);
	        		$grid.gfn_setColDisabled(['INBOXQTY'], false);
	        	} else {
	        		$grid.gfn_setColDisabled(['INBOXQTY'], true);
	        	}
	        }
		};
		
		//셀 수정 이벤트
	    gridView.onEditChange = function(grid, column, value) {
			// 최대길이 값 구하기
	    	if (column.column === 'LENGTH' || column.column === 'WIDTH' || column.column === 'HEIGHT') {
	    		var LENGTH = (column.column === 'LENGTH') ? value : $('#' + gid).gfn_getValue(column.dataRow, 'LENGTH') ;
	    		var WIDTH = (column.column === 'WIDTH') ? value : $('#' + gid).gfn_getValue(column.dataRow, 'WIDTH');
	    		var HEIGHT = (column.column === 'HEIGHT') ? value : $('#' + gid).gfn_getValue(column.dataRow, 'HEIGHT');
	    		
	    		$('#' + gid).gfn_setValue(column.dataRow, 'EA_MAX', Math.max(cfn_isEmpty(LENGTH) ? 0 : LENGTH, cfn_isEmpty(WIDTH) ? 0 : WIDTH, cfn_isEmpty(HEIGHT) ? 0 : HEIGHT));
	    	}
	    };
	 });
}

function grid2_Load() {
	
	var gid = 'grid2',$grid = $('#' + gid);
	var columns = [
		{name:'BARCODE',header:{text:'바코드'},width:120,required:true,editable:true,editor:{maxLength:30}},
		{name:'BARCODE_NM',header:{text:'라벨명'},width:200,editable:true,editor:{maxLength:100}},
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,editor:{maxLength:20},visible:false},
		{name:'COMPCD',header:{text:'회사코드'},width:100,styles:{textAlignment:'center'},visible:false}
    ];	
	
	//그리드 생성
	$grid.gfn_createGrid(columns,{mstGrid:'grid1',footerflg:false}); 	
	
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
	 	gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var state = dataProvider.getRowState(newRowIdx);
				var rowData = $grid.gfn_getDataRow(newRowIdx);
				
				var editable = state === 'created';
				$grid.gfn_setColDisabled(['BARCODE'], editable);
			}
		};
	 });
}

function grid3_Load() {
	var gid = 'grid3',$grid = $('#' + gid);
	
	var columns = [
		{name:'MAP_PROD_CD',header:{text:'대입코드'},width:120,required:true,editable:true,editor:{maxLength:20},styles:{textAlignment:'center'}},
		{name:'PROD_TYPE_CD',header:{text:'구분'},width:100,formatter:'combo',comboValue:'${GCODE_PROD_TYPE_CD}',styles:{textAlignment:'center'}},
		{name:'ITEMCD',header:{text:'대입된코드'},width:100,styles:{textAlignment:'center'}},
		{name:'UPDUSERCD',header:{text:'수정자'},width:120,styles:{textAlignment:'center'}},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:150,styles:{textAlignment:'center'}},
		{name:'TERMINALCD',header:{text:'IP'},width:100,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,editor:{maxLength:20},visible:false},
		{name:'COMPCD',header:{text:'회사코드'},width:100,styles:{textAlignment:'center'},visible:false}
    ];	
	
	//그리드 생성
	$grid.gfn_createGrid(columns,{mstGrid:'grid1',footerflg:false});
	
	//그리드설정 및 이벤트처리
	$grid.gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
	 	gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				var state = dataProvider.getRowState(newRowIdx);
				var rowData = $grid.gfn_getDataRow(newRowIdx);
				
				var editable = state === 'created';
				$grid.gfn_setColDisabled(['MAP_PROD_CD'], editable);
			}
		};
	 });
}

//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').gridView().commit();
		$('#grid2').dataProvider().clearRows();
		$('#grid3').gridView().commit();
		$('#grid3').dataProvider().clearRows();
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	if (sid == 'sid_getSearchDtl'){
		$('#grid2').gfn_setDataList(data.resultBarcodeList);
		$('#grid3').gfn_setDataList(data.resultCItemList);
	}
	//저장
	else if (sid === 'sid_setSave') {
		$('#grid1').gfn_setFocusPK(data.resultData, ['COMPCD', 'ORGCD', 'ITEMCD']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	//삭제 (사용/미사용)
	else if (sid === 'sid_setDelete') {
		$('#grid1').gfn_setFocusPK(data.resultData, ['COMPCD', 'ORGCD','ITEMCD']);
		cfn_msg('INFO', '정상적으로 처리되었습니다.');
		cfn_retrieve();
	}
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	$('#grid1').gridView().cancel();
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000006/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

// 상세 품목바코드 / 대입코드 정보 조회
function fn_getItemDtlList(masterData){
	var sid = 'sid_getSearchDtl';
	var url = '/alexcloud/p000/p000006/getSearchDtl.do';
	var sendData = {'paramData':masterData};
	
	gfn_sendData(sid, url, sendData);
};

//공통버튼 - 신규 클릭
function cfn_new() {
	$('#grid1').gridView().commit(true);
	
	$('#grid1').gfn_addRow({COMPCD :cfn_loginInfo().COMPCD
						  , ORGCD :cfn_loginInfo().ORGCD
						  , ORGNM :cfn_loginInfo().ORGNM
						  , ITEMTYPE:'10'
						  , UNITCD:'EA'
						  , SETYN:'N'
						  , UNITTYPE:'EA'
						  , INBOXQTY:1
						  , INPLTQTY:1
						  , ISUSING:'Y'
						  , UNITCOST:0
						  , UNITPRICE:0
						  , SERIAL_SCAN_YN:'N'
						  , MAX_CLGO_QTY:'0'
						  , SUPRATE:100
						  , STKTMP:'STD'
						  , SUPUNIT:'PLT'
						  });
}

//공통버튼 - 저장 클릭
function cfn_save() {
	
	$('#grid1').gridView().commit(true);
	$('#grid2').gridView().commit(true);
	$('#grid3').gridView().commit(true);

	var cIdx = $('#grid1').gfn_getCurRowIdx();
	if($('#grid1').dataProvider().getRowState(cIdx) !== 'created')
		$('#grid1').dataProvider().setRowState(cIdx, "updated", false);
	
	var $grid1 = $('#grid1');
	var masterList = $grid1.gfn_getDataList(false);
	var dtlList2 = $('#grid2').gfn_getDataList(false);
	var dtlList3 = $('#grid3').gfn_getDataList(false);
	
	if (masterList.length < 1 && dtlList2.length < 1  && dtlList3.length < 1) {
		cfn_msg('WARNING', '변경된 항목이 없습니다.');
		return false;
	}

	//변경RowIndex 추출
	var states = $grid1.dataProvider().getAllStateRows();
	var stateRowidxs = states.updated;
	stateRowidxs = stateRowidxs.concat(states.created);
	
	//필수입력 체크
	if(masterList.length > 0)
		if ($grid1.gfn_checkValidateCells(stateRowidxs)) return false;
	//바코드 필수입력 체크
	if ($('#grid2').gfn_checkValidateCells()) return false;
	//대입코드 필수입력 체크
	if ($('#grid3').gfn_checkValidateCells()) return false;
	
	if (confirm('저장하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/p000006/setSave.do';
		var sendData = {'paramList':masterList,'barList':dtlList2,'cItemList':dtlList3};
		
		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 삭제 (사용/미사용) 클릭
function cfn_del() {
	$('#grid1').gridView().commit(true);
	
	var $grid1 = $('#grid1');
	var rowidx = $grid1.gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 품목이 없습니다.');
		return false;
	}
	
	var state = $grid1.dataProvider().getRowState(rowidx);
	
	if (state === 'created') {
		$grid1.gfn_delRow(rowidx);
		return false;
	}
	
	var rowData = $grid1.gfn_getDataRow(rowidx);
	var delstr = rowData.ISUSING === 'N' ? '사용' : '미사용';
	
	if (confirm('품목코드 [' + rowData.ITEMCD + '] 항목을 ' + delstr + ' 처리하시겠습니까?')) {
		var sid = 'sid_setDelete';
		var url = '/alexcloud/p000/p000006/setDelete.do';
		var sendData = {'paramData':rowData};
		
		gfn_sendData(sid, url, sendData);
	}
}

//그리드1 행추가 버튼 클릭
function fn_grid1AddRow() {
	cfn_new();
}	

//그리드1 행삭제 버튼 클릭
function fn_grid1DelRow() {
	cfn_del();
}

//그리드2 행추가 버튼 클릭
function fn_grid2AddRow() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 품목이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	if (cfn_isEmpty(masterData.ITEMCD)) {
		cfn_msg('WARNING', '품목코드를 입력해주세요.');
		return false;
	}
	
	$('#grid2').gfn_addRow({'COMPCD':masterData.COMPCD,
							'ORGCD':masterData.ORGCD,
							'ITEMCD':masterData.ITEMCD});
}
//그리드2 행삭제 버튼 클릭
function fn_grid2DelRow() {
	$('#grid2').gridView().commit(true);
	
	var $grid2 = $('#grid2');
	var rowidx = $grid2.gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 바코드가 없습니다.');
		return false;
	}
	
	$grid2.gfn_delRow(rowidx);
}

//그리드3 행추가 버튼 클릭
 function fn_grid3AddRow() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 품목이 없습니다.');
		return false;
	}
	
	var masterData = $('#grid1').gfn_getDataRow(rowidx);
	if (cfn_isEmpty(masterData.ITEMCD)) {
		cfn_msg('WARNING', '품목코드를 입력해주세요.');
		return false;
	}
	
	$('#grid3').gfn_addRow({'COMPCD':masterData.COMPCD,
							'ORGCD':masterData.ORGCD,
							'PROD_TYPE_CD':'00003',
							'ITEMCD':masterData.ITEMCD});
}
//그리드3 행삭제 버튼 클릭
 function fn_grid3DelRow() {
	$('#grid3').gridView().commit(true);
	
	var $grid3 = $('#grid3');
	var rowidx = $grid3.gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '대입코드가 없습니다.');
		return false;
	}
	
	$grid3.gfn_delRow(rowidx);
}

//공통버튼 - 라벨출력 클릭
/* function cfn_print() {
	
	var gridRowidx = $('#grid1').gfn_getCurRowIdx();
	var checkRows = $('#grid1').gridView().getCheckedRows();
	var gridList = $('#grid1').gfn_getDataRows(checkRows);
	var itemargs = '';
	
	if (gridRowidx < 0) {
		cfn_msg('WARNING', '데이터가 없습니다.');
		return false;
	}
	
	if(cfn_isEmpty(checkRows)) {
		cfn_msg('WARNING','선택된 데이터가 없습니다.');
		return false;
	}
	
	
	for(var a=0; a<gridList.length; a++){
		if(a != 0){
			itemargs += ','
		}
		itemargs += gridList[a].ITEMCD.trim();
	}
	
	rfn_reportView({
		title: '품목별 바코드',
		jrfName: 'P000006_R01',
		args: {
			   'COMPCD'		: cfn_loginInfo().COMPCD,
			   'ORGCD' 		: cfn_loginInfo().ORGCD,
			   'ORGNM'  	: cfn_loginInfo().ORGNM,
			   'ITEMCD'     : itemargs,
			   'USERNM'     : cfn_loginInfo().USERNM
			   }
	});
} */
</script>

<c:import url="/comm/contentBottom.do" />