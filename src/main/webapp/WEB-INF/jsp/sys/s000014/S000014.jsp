<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : S000014
	화면명    : 공지사항 등록
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div class="ct_top_wrap" style="overflow: auto;">
	<div class="ct_top_wrap">
		<!-- 기본정보영역 시작 -->
		<form id="frmNotice" action="#" onsubmit="return false">
			<input type="hidden" id="S_COMPCD" class="cmc_code" />
			<input type="hidden" id="S_COMPNM" class="cmc_value" />
<!-- 			<input type="hidden" id="ORIGINFILENM" class="cmc_value" /> -->
			<input type="hidden" id="SEQ" class="cmc_value" />
			<table class="tblForm">
				<caption>공지사항 기본정보</caption>
				<colgroup>
					<col width="140px" />
					<col width="280x" />
					<col width="140px" />
					<col width="280px" />
					<col width="140px" />
			        <col />
			    </colgroup>
				<tr>
					<th>공지번호</th>
					<td><input type="text" id="NTKEY" name="NTKEY" class="cmc_txt disabled" readonly="readonly"/></td>
					<th>공지유형</th>
					<td>
						<select id="NTTYPE" class="cmc_combo required">
							<c:forEach var="i" items="${CODE_NTTYPE}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>
					</td>
					<th>사용여부</th>
					<td>
						<select id="ISUSING" class="cmc_combo required">
							<c:forEach var="i" items="${CODE_ISUSING}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th class="required">공지기간</th>
					<td>
					<input type="text" id="STARTDT" class="cmc_date periods required" /> ~
					<input type="text" id="ENDDT" class="cmc_date periode required" />
					</td>
					<th>공지대상</th>
					<td>
						<select id="TARGET" class="cmc_combo required" onchange="fn_targetChange();">
							<c:forEach var="i" items="${CODE_NTTARGET}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>
					</td>
					<th>메인팝업여부</th>
					<td>
						<select id="POPFLG" class="cmc_combo required">
							<c:forEach var="i" items="${CODE_YN}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th class="required">제목</th>
					<td colspan="5"><input type="text" id="TITLE" name="TITLE" class="cmc_txt required" style="width:100%;"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="5">
						<textarea name="CONTENTS" id="CONTENTS" rows="30" cols="100" style="width:100%; height:350px;"></textarea>
					</td>
				</tr>
			</table>
		</form>
		<!-- 기본정보영역 끝 -->
	</div>
	<div class="ct_bot_wrap fix" style="height:220px">
		<div class="ct_left_wrap">
			<div class="grid_top_wrap">
				<div class="grid_top_left">첨부파일
					<input type="button" id="btn_rowAdd1" class="cmb_plus" onclick="fn_fileAdd()" />  
				</div>
				<div class="grid_top_right" style="display:none;">전체 용량 : <span id="totalFileSize">0</span> KB</div>
			</div>
			<div id="attachfiledown_wrap"></div>
			<table id="fileTable" class="tblForm" style="min-width:400px" >
				<tr id="tr0">
					<td><input type="file" id="FILENM" name="FILENM" onchange="fn_fileChange(0)"/></td>
					<td>
						파일 용량 :
						<input type="text" id="file0Size" name="FILESZ" value="0" readonly="readonly" style="text-align:right; "/> KB<input type="button" class="cmb_minus" onclick="fn_deletetr(0)" ></input>
					</td>
				</tr>
				<tbody></tbody>
			</table>
		</div>
		
		<div class="ct_right_wrap">
			<div class="grid_top_wrap">
				<div class="grid_top_left">공지대상</div>
				<div class="grid_top_right">
					<input type="button" id="btn_rowAdd2" class="cmb_plus" onclick="fn_grid2RowAdd()" />  
					<input type="button" id="btn_rowDel2" class="cmb_minus" onclick="fn_grid2RowDel()" />
				</div>
			</div>
			<div id="grid2"></div>
		</div>
	</div>
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

var savedCnt = 0;
//초기 로드
var oEditors = [];

$(function() {
	initLayout();
	
	$("#S_COMPCD").val(cfn_loginInfo().COMPCD);
	$("#S_COMPNM").val(cfn_loginInfo().COMPNM);
	$("#NTTYPE").val("NOM");
	$("#TARGET").val("COMP");
	$("#ISUSING").val("Y");
	$("#POPFLG").val("N");
	
	grid2_Load();
	
	var ntkey = "${param.NTKEY}";
	if(cfn_isEmpty(ntkey)){
		fn_initLoad(gv_paramData);
		fn_targetChange();
	} else {
		cfn_setIDUR("U");
		gv_paramData.NTKEY = ntkey;
		fn_initLoad(gv_paramData);
	}
	
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "CONTENTS",
        sSkinURI: "/sys/s000014/editor.do",
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,            
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : false,    
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,
        }
    });
});


function grid2_Load() {
	var gid = "grid2";
	var columns = [
		{name:"TARGET",header:{text:"대상유형"},width:100},
		{name:"TARGETCD",header:{text:"대상코드"},width:150},
		{name:"TARGETNM",header:{text:"대상명"},width:200},
		{name:"TARGETTYPECD",header:{text:"대상유형코드"},width:100,visible:false,show:false},
		{name:"COMPCD",header:{text:"회사코드"},width:100,visible:false,show:false},
		{name:"ORGCD",header:{text:"셀러코드"},width:100,visible:false,show:false},
	];
	
	//그리드 생성
	$("#" + gid).gfn_createGrid(columns, {footerflg:false});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	
	if (sid == "sid_getInfo") {
		var formData = data.resultData;
		var gridData = data.resultList;		
		cfn_bindFormData("frmNotice", formData);
		$("#grid2").gfn_setDataList(data.resultList);
		
		//저장된 첨부파일 바인딩
		savedCnt = 0;
	}
	if(sid == "sid_setSave"){
		var formData = data.resultData;
		cfn_msg("INFO", "정상적으로 저장되었습니다.");
		cfn_setIDUR("U");
		fn_initLoad(formData);
	}
	if(sid == "sid_setFileDel"){
		var formData = data.resultData;
		cfn_setIDUR("U");
		fn_initLoad(formData);
	}
}

//공통버튼 - 목록 클릭
function cfn_list() {
	
	var ntkey = $("#NTKEY").val();

	var param = {NTKEY:ntkey,realurl:"/sys/s000015/view.do"};	
	parent.add_tab("/sys/s000015/view.do", "공지사항", "", "", "S000015",param);
}

//공통버튼 - 저장 클릭 
function cfn_save(directmsg){
	
	oEditors.getById["CONTENTS"].exec("UPDATE_CONTENTS_FIELD", []);

	//폼 필수입력 체크
	if (!cfn_isFormRequireData("frmNotice")) return false;

	var infoData = cfn_getFormData("frmNotice");
	var targetData = $("#grid2").gfn_getDataList();
	
	//빈 첨부파일 제거 
	for(var i = 4, j = $("#fileTable tr").length; j - i <= j; i--) {
		if($("#fileTable tr").eq(i).attr("id")){
			if(!$("#fileTable").find("input:file")[i].files[0]){
				$("#fileTable tr").eq(i).remove();
			}
		}
	}
	fn_idxModify();
	
	if (confirm("저장하시겠습니까?")) {
		
		if (!cfn_isEmpty($("#FILENM").length > 0)) {
						
			var fileData = new FormData();
			$("input[name=FILENM]").each(function(i, tag) {
				fileData.append("uploadFile" + i, $(tag)[0].files[0]);
			});

			$.ajax({
				url: "/sys/s000014/setFile.do",
				data: fileData,
				processData: false,
				contentType: false,
				type: "POST",
				success: function (data) {
					
					var resultAttachFile = data.resultAttachFile;
					
					var sid = "sid_setSave";
					var url = "/sys/s000014/setSave.do";
					var sendData = {"paramData":infoData, "paramList":targetData, "paramFile":resultAttachFile};

					gfn_sendData(sid, url, sendData);

			    },
			    	error: function (jqXHR) {
			    }
		    });
		} else {
	
			var sid = "sid_setSave";
			var url = "/sys/s000014/setSave.do";
			var sendData = {"paramData":infoData, "paramList":targetData};
			
		  	gfn_sendData(sid, url, sendData);
		}
	}
	
}

//공지대상 추가(+) 버튼 이벤트
function fn_grid2RowAdd() {
	
	if($("#TARGET").val() == "COMP"){
		var tgTypeCd = "COMP";
		var tgType = "회사";
		pfn_popupOpen({
			url:"/alexcloud/popup/popP001/view.do",
			pid:"popP001",
			params:{"S_COMPCD":$("#S_COMPCD").val()},
			returnFn: function(data) {
				if (data.length > 0) {
					for (var i=0; i<data.length; i++) {
						$("#grid2").gfn_addRow({"TARGETTYPECD":tgTypeCd,
												"TARGET":tgType,
												"TARGETCD":data[i].COMPCD,
												"TARGETNM":data[i].NAME,
												"COMPCD":data[i].COMPCD});
					}
				} 
			}		
		});
	} else if ($("#TARGET").val() == "ORG"){
		var tgTypeCd = "ORG";
		var tgType = "셀러";
		pfn_popupOpen({
			url:"/alexcloud/popup/popP002/view.do",
			pid:"popP002",
			params:{"S_COMPCD":$("#S_COMPCD").val(),"S_COMPNM":$("#S_COMPNM").val() },
			returnFn: function(data) {
				if (data.length > 0) {
					for (var i=0; i<data.length; i++) {
						$("#grid2").gfn_addRow({"TARGETTYPECD":tgTypeCd, 
												"TARGET":tgType, 
												"TARGETCD":data[i].ORGCD, 
												"TARGETNM":data[i].NAME,
												"COMPCD":data[i].COMPCD,
												"ORGCD":data[i].ORGCD});
						
					}
				} 
			}		
		});
	} 
}

//공지대상 삭제(-) 버튼 이벤트
function fn_grid2RowDel() {
	var rowidx = $("#grid2").gfn_getCurRowIdx();
	var state = $("#grid2").dataProvider().getRowState(rowidx);
	if (rowidx < 0) {
		cfn_msg("WARNING", "선택된 행이 없습니다.");
		return false;
	}
	$("#grid2").gfn_delRow(rowidx);
}

//공지대상 변경 이벤트
function fn_targetChange(){
	
	$("#grid2").gfn_clearData();
	if($("#TARGET").val() == "COMP"){
		$("#grid2").gfn_addRow({"TARGETTYPECD":"COMP",
								"TARGET":"회사", "TARGETCD":$("#S_COMPCD").val(),
								"TARGETNM":$("#S_COMPNM").val(),
								"COMPCD":$("#S_COMPCD").val()});
	}
}

//초기 로드(수정)
function fn_initLoad(paramData) {
	
	if (cfn_getIDUR() === "U") {
		var trLength = $("#fileTable tr").length;
			for(var i = 0; i < trLength; i++){
				$("#tr"+i).remove();
		}
		$("#attachfiledown_wrap").html("");
		
		var sid = "sid_getInfo";
		var url = "/sys/s000014/getInfo.do";
		var sendData = {"paramData":paramData};
	
		gfn_sendData(sid, url, sendData);

		//첨부파일 바인딩
		var urlFile = "/alexcloud/popup/popS014/getFile.do";
		
		gfn_ajax(urlFile, true, sendData, function(data, xhr) {
			for(var i = 0; i < data.resultList.length; i++) {
				var seq = data.resultList[i].SEQ;
				$('#attachfiledown_wrap').append('<a href="#" onclick="window.open(encodeURI(\'/alexcloud/popup/popS014/noticeDownloadFile.do?realFilename=' 
						+ data.resultList[i].ORIGINFILENM + '&filename=' 
						+ data.resultList[i].FILENM + '\'))"><img src="/images/attachfile.png" width="20" alt="" /><span class="bold">' 
						+ data.resultList[i].FILENM + '</span></a><input type="button" class="cmb_minus" onclick="fn_delFile('+ seq +')" ></input><br>');
			}
		});
	}
}

//파일 추가
function fn_fileAdd(){
	var trLength = $('#fileTable tr').length;
	savedCnt = $('#attachfiledown_wrap img').length;
	
	var posbCnt = 5-savedCnt;
	
	if(trLength < posbCnt) {
		$('#fileTable > tbody:last').append('<tr id="tr'+ trLength +'"><td><input type="file" id="FILENM" name="FILENM" onchange="fn_fileChange('+ trLength +')"/></td>'+
											'<td>파일 용량 : <input type="text" id="file'+ trLength +'Size" name="FILESZ" readonly="readonly" style="text-align:right;"/> KB<input type="button" class="cmb_minus" onclick="fn_deletetr('+ trLength +')" ></input></td>'+
											'</tr>');
	fn_fileChange(trLength);
	}
}

//선택 파일 삭제
function fn_deletetr(rown){
	
	$("#tr"+rown).remove();
	fn_idxModify();
	fn_fileTotalSize();
}

//파일 삭제 시 번호 재지정
function fn_idxModify(){
	for(var i = 0; i < $("#fileTable tr").length; i++) {
		var trId = "tr"+ i;
		var textId = "file" + i + "Size";
		var onChange = "fn_fileChange(" + i + ")";
		var onClick = "fn_deletetr(" + i + ")";
		
		$("#fileTable tr").eq(i).attr("id",trId);
		$("#fileTable").find("input:file").eq(i).attr("onChange",onChange);
		$("#fileTable").find("input:text").eq(i).attr("id",textId);
		$("#fileTable").find("input:button").eq(i).attr("onClick",onClick);
	}
}

//파일 변경사항 반영
function fn_fileChange(idx){
	if($("#fileTable").find("input:file")[idx].files[0]){
		var f = $("#fileTable").find("input:file")[idx].files[0].size;
		var fM = Math.round(f/1000)/1000;
		if(fM > 20){
			cfn_msg("WARNING", "파일 1개 용량은 20MB를 넘을 수 없습니다.");
			$("#fileTable").find("input:file")[idx].value = "";
			f = 0;
			$("#file"+[idx]+"Size").val(Math.round(f/1000));
		}
		$("#file"+[idx]+"Size").val(Math.round(f/1000));
	} else {
		var f = 0;
		$("#file"+[idx]+"Size").val(Math.round(f/1000));
	}
	
	fn_fileTotalSize();
}

//파일 전체 용량
function fn_fileTotalSize(){
	if($("#fileTable tr").length != 0) {
		var tfs = 0;
		for(var i = 0; i < $("#fileTable tr").length; i++) {
			if($("#fileTable").find("input:file")[i].files[0]){
				var f = $("#fileTable").find("input:file")[i].files[0].size;
				tfs = tfs + f;
			}
			$("#totalFileSize").text(Math.round(tfs/1000));
		} 
	} else {
		$("#totalFileSize").text(0);
	}	
}


//선택 파일 삭제
function fn_delFile(seq){
	$("#SEQ").val(seq);
	var infoData = cfn_getFormData("frmNotice");
	if (confirm("파일을 삭제하시겠습니까?")) {
		var sid = "sid_setFileDel";
		var url = "/sys/s000014/setFileDel.do";
		var sendData = {"paramData":infoData};
	
		gfn_sendData(sid, url, sendData);
	}
}
</script>

<c:import url="/comm/contentBottom.do" />