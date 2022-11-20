<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : S000006
	화면명    : 권한
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<ul class="sech_ul">
		<li class="sech_li">
			<div>회사</div>
			<div>
				<input type="text" id="S_COMPCD" class="cmc_code" readonly="readonly" disabled />
				<input type="text" id="S_COMPNM" class="cmc_value" readonly="readonly" disabled />
				<button type="button" class="cmc_cdsearch disabled" disabled></button>
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
			<div>대메뉴명</div>
			<div>
				<select id="S_MENUL1" class="cmc_combo" onchange="cfn_retrieve()">
					<option value="">전체</option>
					<c:forEach var="i" items="${codeMENUL1}">
						<option value="${i.CODE}">${i.VALUE}</option>
					</c:forEach>
				</select>
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		
		<li class="sech_li">
			<div>사용자</div>
			<div>
				<input type="text" id="S_USERCD" class="cmc_code" />				
				<input type="text" id="S_USERNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<li class="sech_li">
			<div>권한</div>
			<div>
				<select id="S_USERGROUP" class="cmc_combo">
					<option value="">--전체--</option>
					<c:forEach var="i" items="${CODE_USERGROUP}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
		<li class="sech_li">
			<div>소속</div>
			<div>
				<select id="S_DEPTCD" class="cmc_combo">
					<option value="">--전체--</option>
					<c:forEach var="i" items="${CODE_DEPTCD}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
		<li class="sech_li">
			<div>창고</div>
			<div>
				<input type="text" id="S_WHCD" name="S_WHCD" class="cmc_code" />
				<input type="text" id="S_WHNM" name="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>	
	</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div style="float:left;width:calc(54.5%);height:calc(100% - 82px);padding-top:10px;margin-right:10px;">
	<div class="grid_top_wrap">
		<div class="grid_top_left">사용자 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="button" id="btn_g1Copy" class="cmb_normal" value="권한복사" onclick="btn_authCopy_onClick();"/>
		</div>
	</div>
	<div id="grid1"></div>
</div>
<div style="float:left;width:calc(17%);height:calc(100% - 82px);padding-top:10px;margin-right:10px;">
	<div class="grid_top_wrap">
		<div class="grid_top_left">메뉴 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="button" id="btn_g2Add" class="cmb_plus" onclick="btn_authAdd_onClick();"/>
		</div>
	</div>
	<div id="grid2"></div>
</div>
<div style="float:left;width:calc(27%);height:calc(100% - 82px);padding-top:10px;">
	<div class="grid_top_wrap">
		<div class="grid_top_left">
			<div style="float:left;color:#555555;">사용가능 권한 리스트<span>(총 0건)</span></div>
			<div style="float:left;width:15px;height:15px;margin-left:15px;background-color:#f7aa5a;"></div>
			<div style="float:left;padding:0 5px 0 5px;font-weight:normal;color:#555555;">: 대메뉴</div>
			<div style="float:left;width:15px;height:15px;background-color:#92d2ff;"></div>
			<div style="float:left;padding:0 5px 0 5px;font-weight:normal;color:#555555;">: 중메뉴</div>
			<div class="cls"></div>
		</div>
		<div class="grid_top_right">
			<input type="button" id="btn_g3Del" class="cmb_minus" onclick="btn_authDel_onClick();"/>
		</div>
	</div>
	<div id="grid3"></div>
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
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);
	
	grid1_Load();
	grid2_Load();
	grid3_Load();
	
	/* 공통코드 코드/명 (회사) */
	pfn_codeval({
		url:'/alexcloud/popup/popP001/view.do',codeid:'S_COMPCD',
		inparam:{S_COMPCD:'S_COMPCD,S_COMPNM'},
		outparam:{COMPCD:'S_COMPCD',NAME:'S_COMPNM'}
	});
	
	/* 공통코드 코드/명 (사업장) */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'}
	});
	
	/* 공통코드 코드/명 (사용자) */
	pfn_codeval({
		url:'/alexcloud/popup/popS010/view.do',codeid:'S_USERCD',
		inparam:{S_USERCD:'S_USERCD,S_USERNM'},
		outparam:{USERCD:'S_USERCD',NAME:'S_USERNM'}
	});
	
	/* 창고 */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'S_WHCD,S_WHNM'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	
	cfn_retrieve();
});



function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'USERGROUP',header:{text:'사용자그룹'},width:100,formatter:'combo',comboValue:'${GCODE_USERGROUP}',styles:{textAlignment:'center'}},
		{name:'DEPTCD',header:{text:'소속'},width:150,formatter:'combo',comboValue:'${GCODE_DEPTCD}',styles:{textAlignment:'center'}},
		{name:'USERCD',header:{text:'사용자ID'},width:170},
		{name:'NAME',header:{text:'사용자명'},width:180},
		{name:'ORGNM',header:{text:'셀러명'},width:120,styles:{textAlignment:'center'}},
		{name:'POSITION',header:{text:'직급'},width:100,styles:{textAlignment:'center'}},
		{name:'USERGROUPNM',header:{text:'사용자그룹명'},width:70,visible:false,show:false,styles:{textAlignment:'center'}},
		{name:'ORGCD',header:{text:'셀러코드'},width:70,visible:false,show:false,styles:{textAlignment:'center'}},
		{name:'COMPCD',header:{text:'회사코드'},width:50,visible:false,show:false,styles:{textAlignment:'center'}},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {panelflg:false,footerflg:false});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		gridView.setRowGroup({
		    headerStatement: '$'+'{groupValue}' + ' - ' + '$'+'{rowCount}' + ' 건',
		    sorting:false,
		    levels:[  
		 	   {  
		 		  headerStyles:{  
		 			 background:"#f7aa5a",
		 			 foreground:"#555555",
		 			 fontBold:true
		 		  },
		 		  
		 		  barStyles:{  
		 			 background:"#dfebf7"
		 		  }
		 	   }
		 	]
		});
		
		gridView.groupBy(["USERGROUPNM"]);
		
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			
			var s_menul1 = $('#S_MENUL1').val();
			var compcd = $('#' + gid).gfn_getValue(newRowIdx, 'COMPCD');
			var orgcd = $('#' + gid).gfn_getValue(newRowIdx, 'ORGCD');
			var usercd = $('#' + gid).gfn_getValue(newRowIdx, 'USERCD');
			if(!cfn_isEmpty(usercd)) {
				var param = {'S_MENUL1':s_menul1, 'COMPCD':compcd, 'ORGCD':orgcd, 'USERCD':usercd};
				fn_getAuthlList(param);
				fn_getAllMenu(compcd);
			}
		};
	});
}

function grid2_Load() {
	var gid = 'grid2';
	var columns = [
		{name:'TITLE',header:{text:'메뉴'},width:220},
		{name:'MENUL1KEY',header:{text:'대메뉴키'},width:20,visible:false},
		{name:'MENUL2KEY',header:{text:'중메뉴키'},width:20,visible:false},
		{name:'APPKEY',header:{text:'프로그램키'},width:20,visible:false}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true,panelflg:false,footerflg:false,indicator:false});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		var newDynamicStyles = [{
		    criteria: "value['MENUL2KEY'] is empty",
		    styles: {background:'#f7aa5a',textAlignment:'center'}
		},
		{
		    criteria: "(value['MENUL2KEY'] is not empty) and (value['APPKEY'] is empty)",
		    styles: {background:'#92d2ff',textAlignment:'center'}
		}
		];

		gridView.setStyles({
		    body: {
		        dynamicStyles: newDynamicStyles
		    }
		});
		
		
		gridView.onItemChecked = function(grid, itemIndex, checked) {
			var menul1key = $('#' + gid).gfn_getValue(itemIndex, 'MENUL1KEY');
			var menul2key = $('#' + gid).gfn_getValue(itemIndex, 'MENUL2KEY');
			var appkey = $('#' + gid).gfn_getValue(itemIndex, 'APPKEY');
			var checkstate = gridView.isCheckedRow(itemIndex);
			
			if (cfn_isEmpty(menul2key)) {
				var grid2Data = $('#' + gid).gfn_getDataList();
				for (var i=0; i<grid2Data.length; i++ ) {
					if (grid2Data[i].MENUL1KEY == menul1key && checkstate === true) {
						gridView.checkItem([i], true);
					} else if (grid2Data[i].MENUL1KEY == menul1key && checkstate === false) {
						gridView.checkItem([i], false);
					}
				}
			} else if (!cfn_isEmpty(menul2key) && cfn_isEmpty(appkey)) {
				var grid2Data = $('#' + gid).gfn_getDataList();
				for (var i=0; i<grid2Data.length; i++ ) {
					if (grid2Data[i].MENUL1KEY == menul1key && grid2Data[i].MENUL2KEY == menul2key && checkstate === true) {
						gridView.checkItem([i], true);
					} else if (grid2Data[i].MENUL1KEY == menul1key && grid2Data[i].MENUL2KEY == menul2key && checkstate === false) {
						gridView.checkItem([i], false);
					}
				}
			}
		}
	});
}

function grid3_Load() {
	var gid = 'grid3';
	var columns = [
		{name:'TITLE',header:{text:'사용가능한메뉴'},width:230},
		{name:'AUTHUPD',header:{text:'수정'},width:40,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'AUTHDEL',header:{text:'삭제'},width:40,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'AUTHEXEC',header:{text:'실행'},width:40,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'AUTHPRINT',header:{text:'출력'},width:40,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'AUTHSEARCH',header:{text:'검색권한'},width:120,editable:true,formatter:'combo',comboValue:'${gCodeAUTHSEARCH}',visible:false},
		{name:'MENUL1KEY',header:{text:'대메뉴키'},width:20,visible:false},
		{name:'MENUL2KEY',header:{text:'중메뉴키'},width:220,visible:false},
		{name:'APPKEY',header:{text:'프로그램키'},width:220,visible:false},
		{name:'USERCD',header:{text:'사용자코드'},width:220,visible:false},
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {checkBar:true,panelflg:false,footerflg:false,indicator:false});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		var newDynamicStyles = [{
		    criteria: "(value['MENUL2KEY'] is not empty) and (value['APPKEY'] is empty)",
		    styles: {background:'#92d2ff',textAlignment:'center'}
		},
		{
		    criteria: "value['MENUL2KEY'] is empty",
		    styles: {background:'#f7aa5a',textAlignment:'center'}
		}
		];

		gridView.setStyles({
		    body: {
		        dynamicStyles: newDynamicStyles
		    }
		});
		
		gridView.onItemChecked = function(grid, itemIndex, checked) {
			var menul1key = $('#' + gid).gfn_getValue(itemIndex, 'MENUL1KEY');
			var menul2key = $('#' + gid).gfn_getValue(itemIndex, 'MENUL2KEY');
			var appkey = $('#' + gid).gfn_getValue(itemIndex, 'APPKEY');
			var checkstate = gridView.isCheckedRow(itemIndex);
			
			if (cfn_isEmpty(menul2key)) {
				var grid3Data = $('#' + gid).gfn_getDataList();
				for (var i=0; i<grid3Data.length; i++ ) {
					if (grid3Data[i].MENUL1KEY == menul1key && checkstate === true) {
						gridView.checkItem([i], true);
					} else if (grid3Data[i].MENUL1KEY == menul1key && checkstate === false) {
						gridView.checkItem([i], false);
					}
				}
			} else if (!cfn_isEmpty(menul2key) && cfn_isEmpty(appkey)) {
				var grid3Data = $('#' + gid).gfn_getDataList();
				for (var i=0; i<grid3Data.length; i++ ) {
					if (grid3Data[i].MENUL1KEY == menul1key && grid3Data[i].MENUL2KEY == menul2key && checkstate === true) {
						gridView.checkItem([i], true);
					} else if (grid3Data[i].MENUL1KEY == menul1key && grid3Data[i].MENUL2KEY == menul2key && checkstate === false) {
						gridView.checkItem([i], false);
					}
				}
			}
		};
		
		 //셀 수정 이벤트
	    gridView.onEditChange = function(grid, column, value) {
	    	if (column.column === 'AUTHSEARCH') {
	    		var menul1key = $('#' + gid).gfn_getValue(column.dataRow, 'MENUL1KEY');
				var menul2key = $('#' + gid).gfn_getValue(column.dataRow, 'MENUL2KEY');
				var appkey = $('#' + gid).gfn_getValue(column.dataRow, 'APPKEY');
				
				var updateList = [];
				var grid3Data = $('#' + gid).gfn_getDataList();
				var dataRow;
				
				if (cfn_isEmpty(menul2key)) {
					for (var i=0; i<grid3Data.length; i++ ) {
						dataRow = grid3Data[i];
						if (grid3Data[i].MENUL1KEY == menul1key) {
							if(column.dataRow != i){
								$('#' + gid).gfn_setValue([i], column.column, value);
								dataRow[column.column] = value;
							}
							updateList.push(dataRow);
						}
					}
				} else if (!cfn_isEmpty(menul2key) && cfn_isEmpty(appkey)) {
					for (var i=0; i<grid3Data.length; i++ ) {
						dataRow = grid3Data[i];
						if (grid3Data[i].MENUL1KEY == menul1key && grid3Data[i].MENUL2KEY == menul2key) {
							if(column.dataRow != i){
								$('#' + gid).gfn_setValue([i], column.column, value);
								dataRow[column.column] = value;
							}
							updateList.push(dataRow);
						}
					}
				} else {
					dataRow = $('#' + gid).gfn_getDataRow(column.itemIndex);
					dataRow[column.column] = (value);
					updateList.push(dataRow);
				}
				
				var sid = 'sid_updateAuthSearch';
				var url = '/sys/s000006/updateAuthSearch.do';
				var sendData = {'paramDataList':updateList};
		
				gfn_sendData(sid, url, sendData);
	    	};	
	    };
		
		//셀 클릭 이벤트
		gridView.onDataCellClicked = function (grid, index) {
			
			if(index.column == 'AUTHUPD' || index.column == 'AUTHDEL' || index.column == 'AUTHEXEC' || index.column == 'AUTHPRINT') {
				var menul1key = $('#' + gid).gfn_getValue(index.itemIndex, 'MENUL1KEY');
				var menul2key = $('#' + gid).gfn_getValue(index.itemIndex, 'MENUL2KEY');
				var appkey = $('#' + gid).gfn_getValue(index.itemIndex, 'APPKEY');
				var checkValue = $('#' + gid).gfn_getValue(index.itemIndex, index.column);
				
				var updateList = [];
				var grid3Data = $('#' + gid).gfn_getDataList();
				var dataRow;
				
				if (cfn_isEmpty(menul2key)) {
					for (var i=0; i<grid3Data.length; i++ ) {
						dataRow = grid3Data[i];
						if (grid3Data[i].MENUL1KEY == menul1key) {
							if(index.itemIndex != i){
								$('#' + gid).gfn_setValue([i], index.column, checkValue=='Y' ? 'N':'Y');
								dataRow[index.column] = checkValue=='Y' ? 'N':'Y';
							}
							updateList.push(dataRow);
						}
					}
				} else if (!cfn_isEmpty(menul2key) && cfn_isEmpty(appkey)) {
					for (var i=0; i<grid3Data.length; i++ ) {
						dataRow = grid3Data[i];
						if (grid3Data[i].MENUL1KEY == menul1key && grid3Data[i].MENUL2KEY == menul2key) {
							if(index.itemIndex != i){
								$('#' + gid).gfn_setValue([i], index.column, checkValue=='Y' ? 'N':'Y');
								dataRow[index.column] = checkValue=='Y' ? 'N':'Y';
							}
							updateList.push(dataRow);
						}
					}
				} else {
					dataRow = $('#' + gid).gfn_getDataRow(index.itemIndex);
					dataRow[index.column] = (checkValue=='Y' ? 'N':'Y');
					updateList.push(dataRow);
				}
				
				var sid = 'sid_updateUserXAuthDtAuth';
				var url = '/sys/s000006/updateUserXAuthDtAuth.do';
				var sendData = {'paramDataList':updateList};
		
				gfn_sendData(sid, url, sendData);
			}
		};
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid2').dataProvider().clearRows();
		$('#grid3').dataProvider().clearRows();
		
		$('#grid1').gfn_setDataList(data.resultUserList);
	}
	if (sid == 'sid_getAllMenu'){
		$('#grid2').gfn_setDataList(data.resultMenuList);
	}
	//사용자별 권한 검색
	if (sid == 'sid_getAuthList') {
		$('#grid3').gfn_setDataList(data.resultAuthList);
		$('#grid1').gfn_focusPK();
	}
	//권한 추가
	if (sid == 'sid_setAuth') {
		$('#grid1').gfn_setFocusPK(data.resultData, ['COMPCD','USERCD']);
		
		cfn_retrieve();
	}
	//권한 삭제
	if (sid == 'sid_delAuth') {
		$('#grid1').gfn_setFocusPK(data.resultData, ['COMPCD','USERCD']);
		
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	//if(cfn_isFormRequireData('frmSearch') == false) return;
	
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/sys/s000006/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 검색 클릭 */
function fn_getAllMenu(compcd) {
	
	var sid = 'sid_getAllMenu';
	var url = '/sys/s000006/getAllMenu.do';
	var sendData = {'paramData':{'S_COMPCD':compcd}};
	
	gfn_sendData(sid, url, sendData);
}

 
//권한 상세 리스트 검색
function fn_getAuthlList(param) {
	
	var sid = 'sid_getAuthList';
	var url = '/sys/s000006/getAuthList.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

//권한 추가(+) 버튼 이벤트
function btn_authAdd_onClick() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 메뉴가 없습니다.');
		return false;
	}
	
	var grid1Data = $('#grid1').gfn_getDataRow(rowidx);
	var checkRows = $('#grid2').gridView().getCheckedRows();
	var grid2Data = $('#grid2').gfn_getDataRows(checkRows);

	if (cfn_isEmpty(checkRows)) {
		alert('메뉴를 선택해주세요.');
		return false;
	}

	var sid = 'sid_setAuth';
	var url = '/sys/s000006/setAuth.do';
	var sendData = {'grid1Data':grid1Data, 'grid2Data':grid2Data};

	gfn_sendData(sid, url, sendData);
	
}

//권한 삭제(-) 버튼 이벤트
function btn_authDel_onClick() {
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 메뉴가 없습니다.');
		return false;
	}
	
	var grid1Data = $('#grid1').gfn_getDataRow(rowidx);
	var checkRows = $('#grid3').gridView().getCheckedRows();
	var grid3Data = $('#grid3').gfn_getDataRows(checkRows);

	if (cfn_isEmpty(checkRows)) {
		alert('메뉴를 선택해주세요.');
		return false;
	}
	
	var sid = 'sid_delAuth';
	var url = '/sys/s000006/delAuth.do';
	var sendData = {'grid1Data':grid1Data, 'grid3Data':grid3Data};

	gfn_sendData(sid, url, sendData);

}

//권한복사 버튼 이벤트
function btn_authCopy_onClick() {
	
	var rowidx = $('#grid1').gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg('WARNING', '선택된 메뉴가 없습니다.');
		return false;
	}
	
	var rowData = $('#grid1').gfn_getDataRow(rowidx);
	
	pfn_popupOpen({
		url:'/alexcloud/popup/popS006/view.do',
		pid:'popS006',
		params:{'S_COMPCD':rowData.COMPCD, 'USERCD':rowData.USERCD},
		returnFn: function(data) {
			if (data.length > 0) {
				var sid = '';
				var url = '/sys/s000006/insertCopyAuth.do';
				var sendData = {'paramData':rowData, 'paramList':data};
				
				gfn_sendData(sid, url, sendData);
			} 
		}		
	});	
}



</script>

<c:import url="/comm/contentBottom.do" />