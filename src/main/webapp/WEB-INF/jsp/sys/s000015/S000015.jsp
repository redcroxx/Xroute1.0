<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : S000015
	화면명    : 공지사항
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<ul class="sech_ul">
			<li class="sech_li">
				<div>작성일자</div>
				<div>
					<input type="text" id="S_ADDDATETIME_FROM" name="S_ADDDATETIME_FROM" class="cmc_date periods required" /> ~ 	
					<input type="text" id="S_ADDDATETIME_TO" name="S_ADDDATETIME_TO" class="cmc_date periode" />		
				</div>
			</li>
			<li class="sech_li">
				<div>공지유형</div>
				<div>
					<select id="S_NTTYPE" class="cmc_combo">
						<option value="">전체</option>
						<c:forEach var="i" items="${CODE_NTTYPE}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li">
				<div>공지대상</div>
				<div>
					<select id="S_NTTARGET" class="cmc_combo">
						<option value="">전체</option>
						<c:forEach var="i" items="${CODE_NTTARGET}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
		</ul>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>공지번호</div>
				<div>
					<input type="text" id="S_NTKEY" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li">
				<div>등록자</div>
				<div>
					<input type="text" id="S_USERCD" class="cmc_code" />
					<input type="text" id="S_USERNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
			<li class="sech_li">
				<div>사용여부</div>
				<div>
					<select id="S_ISUSING" class="cmc_combo">
						<option value="">전체</option>
						<c:forEach var="i" items="${CODE_ISUSING}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
		</ul>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>제목</div>
				<div style="width:623px">
					<input type="text" id="S_NTTITLE" class="cmc_txt" style="width:574px"/>
				</div>
			</li>
			<li class="sech_li">
				<div>공지여부</div>
				<div>
					<select id="S_ISACTIVE" class="cmc_combo">
						<option value="ALL">전체</option>
						<option value="ACTIVE">공지중</option>
					</select>
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">공지사항 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
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

	setCommBtn("save", null, "수정");
	
	$("#S_ISUSING").val("Y");
	$("#S_ISACTIVE").val("ACTIVE");
	
	/* 공통코드 코드/명 (등록자) */
	pfn_codeval({
		url:"/alexcloud/popup/popS010/view.do",codeid:"S_USERCD",
		inparam:{S_USERCD:"S_USERCD,S_USERNM"},
		outparam:{USERCD:"S_USERCD",NAME:"S_USERNM"}
	});
	
	grid1_Load();
	
	cfn_retrieve();
	
});

function grid1_Load() {
	var gid = "grid1";
	var columns = [
		{name:"NTKEY",header:{text:"공지번호"},width:120,styles:{textAlignment:"center"}},
		{name:"NTTYPE",header:{text:"공지유형"},width:70,formatter:"combo",comboValue:"${gCODE_NTTYPE}",styles:{textAlignment:"center"}},
		{name:"TARGET",header:{text:"공지대상"},width:70,formatter:"combo",comboValue:"${gCODE_NTTARGET}",styles:{textAlignment:"center"}},
		{name:"STARTDT",header:{text:"시작일자"},width:100,formatter:"date",styles:{textAlignment:"center"}},
		{name:"ENDDT",header:{text:"종료일자"},width:100,formatter:"date",styles:{textAlignment:"center"}},
		{name:"TITLE",header:{text:"제목"},width:400},
		{name:"FILEEXIST",header:{text:"첨부파일"},width:60,styles:{textAlignment:"center"},
			renderer:{type:"shape"},styles:{textAlignment:"center",figureName:"ellipse",iconLocation:"center"},
			dynamicStyles:[
				{criteria:"value = 1",styles:{figureBackground:"#003366"}},
				{criteria:"value <> 1",styles:{figureBackground:"#00000000"}}
	        ]		
	/* 		 button : "image",
		        imageButtons: {
		            width: 25,  // 없으면 기본값
		            margin: 15,
		            //imageGap: 20,
		            images: [{
		                name: "팝업버튼",
		                up: "/images/attachfile.png",
		                hover: "/images/attachfile.png",
		                down: "/images/attachfile.png"
		            }]
		        },
		        	 */	
		},
		{name:"HITS",header:{text:"조회수"},width:60,styles:{textAlignment:"center"}},
		{name:"POPFLG",header:{text:"메인팝업"},width:70,formatter:"combo",comboValue:"${gCODE_YN}",styles:{textAlignment:"center"},visible:false,show:false},
		{name:"ADDUSERCD",header:{text:"등록자"},width:100,styles:{textAlignment:"center"}},
		{name:"ISUSING",header:{text:"사용여부"},width:70,formatter:"combo",comboValue:"${gCODE_ISUSING}",styles:{textAlignment:"center"}},
		{name:"ADDDATETIME",header:{text:"등록일시"},width:150,styles:{textAlignment:"center"}},
		{name:"UPDUSERCD",header:{text:"수정자"},width:100,styles:{textAlignment:"center"}},
		{name:"UPDDATETIME",header:{text:"수정일시"},width:150,styles:{textAlignment:"center"}},
		{name:"TERMINALCD",header:{text:"IP"},width:100,styles:{textAlignment:"center"}}
	];
	
	//그리드 생성
	$("#" + gid).gfn_createGrid(columns, {panelflg:false,footerflg:false});

	//그리드설정 및 이벤트처리
	$("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 더블클릭
		gridView.onDataCellDblClicked = function (grid, index) {
			var rowidx = $("#grid1").gfn_getCurRowIdx();
			
			if (rowidx < 0) {
				cfn_msg("WARNING", "선택된 메뉴가 없습니다.");
				return false;
			}
			
			var rowData = $("#grid1").gfn_getDataRow(rowidx);
			pfn_popupOpen({
				url:"/alexcloud/popup/popS014/view.do",
				pid:"popS014",
				params:{"NTKEY":rowData.NTKEY}
			});
			var sid = "sid_setHits";
			var url = "/sys/s000015/setHits.do";
			var sendData = {"paramData":rowData};

			gfn_sendData(sid, url, sendData);
		};
	});
}

//요청한 데이터 처리 callback
function gfn_callback(sid, data) {
	//검색
	if (sid == "sid_getSearch") {
		$("#grid1").gfn_setDataList(data.resultList);
		
		var ntkey = "${param.NTKEY}";
		if(!cfn_isEmpty(ntkey)){
			$("#grid1").gfn_focusPK();
		}
		
	}
	//삭제
	if (sid == "sid_setDelete") {
		
		cfn_msg("INFO", "정상적으로 삭제되었습니다.");
		cfn_retrieve();
	}
	
}

//공통버튼 - 검색 클릭
function cfn_retrieve() {
	gv_searchData = cfn_getFormData("frmSearch");
	
	var sid = "sid_getSearch";
	var url = "/sys/s000015/getSearch.do";
	var sendData = {"paramData":gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

//공통버튼 - 신규 클릭
function cfn_new() {
	
	var param = {realurl:"/sys/s000014/view.do"};	
	parent.add_tab("/sys/s000014/view.do", "공지사항 등록", "", "", "S000014",param);
}

//공통버튼 - 삭제 클릭
function cfn_del() {
	var rowidx = $("#grid1").gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg("WARNING", "선택된 공지가 없습니다.");
		return false;
	}
	
	var masterData = $("#grid1").gfn_getDataRow(rowidx);
	
	if (confirm("공지번호[" + masterData.NTKEY + "]를 삭제하시겠습니까?")) {
		var sid = "sid_setDelete";
		var url = "/sys/s000015/setDelete.do";
		var sendData = {"paramData":masterData};

		gfn_sendData(sid, url, sendData);
	}
}

//공통버튼 - 수정 클릭
function cfn_save() {
	var rowidx = $("#grid1").gfn_getCurRowIdx();
	
	if (rowidx < 0) {
		cfn_msg("WARNING", "선택된 공지가 없습니다.");
		return false;
	}
	
    // var masterData = $("#grid1").gfn_getDataRow(rowidx);
	
	var ntkey = $("#grid1").gfn_getValue(rowidx, "NTKEY");

	var param = {NTKEY:ntkey,realurl:"/sys/s000014/view.do"};
	parent.add_tab("/sys/s000014/view.do", "공지사항 등록", "", "", "S000014",param);
}
</script>

<c:import url="/comm/contentBottom.do" />