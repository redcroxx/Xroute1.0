<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000020
	화면명    : 회사별 품목지정 설정
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<ul class="sech_ul">
		<li class="sech_li">
			<div>회사코드/명</div>
			<div>		
				<input type="text" id="S_COMP" class="cmc_txt" />
			</div>
		</li>
	</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">회사별 품목지정 리스트<span>(총 0건)</span></div>
		<div class="grid_top_right"></div>
	</div>
	<div id="grid1"></div>
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
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:90},
		{name:'COMPNM',header:{text:'회사명'},width:150},
		{name:'LOT1_YN',header:{text:'로트1'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'LOT1_LABEL',header:{text:'로트1라벨'},width:100,editable:true},
		{name:'LOT1_TYPE',header:{text:'로트1유형'},width:100,editable:true,formatter:'combo',comboValue:'${gCodeLOTTYPE}',styles:{textAlignment:'center'}},
		{name:'LOT2_YN',header:{text:'로트2'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'LOT2_LABEL',header:{text:'로트2라벨'},width:100,editable:true},
		{name:'LOT2_TYPE',header:{text:'로트2유형'},width:100,editable:true,formatter:'combo',comboValue:'${gCodeLOTTYPE}',styles:{textAlignment:'center'}},
		{name:'LOT3_YN',header:{text:'로트3'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'LOT3_LABEL',header:{text:'로트3라벨'},width:100,editable:true},
		{name:'LOT3_TYPE',header:{text:'로트3유형'},width:100,editable:true,formatter:'combo',comboValue:'${gCodeLOTTYPE}',styles:{textAlignment:'center'}},
		{name:'LOT4_YN',header:{text:'로트4'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'LOT4_LABEL',header:{text:'로트4라벨'},width:100,editable:true},
		{name:'LOT5_YN',header:{text:'로트5'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'LOT5_LABEL',header:{text:'로트5라벨'},width:100,editable:true},
		{name:'F_USER01_YN',header:{text:'속성01'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'F_USER01_LABEL',header:{text:'속성01라벨'},width:100,editable:true},
		{name:'F_USER02_YN',header:{text:'속성02'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'F_USER02_LABEL',header:{text:'속성02라벨'},width:100,editable:true},
		{name:'F_USER03_YN',header:{text:'속성03'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'F_USER03_LABEL',header:{text:'속성03라벨'},width:100,editable:true},
		{name:'F_USER04_YN',header:{text:'속성04'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'F_USER04_LABEL',header:{text:'속성04라벨'},width:100,editable:true},
		{name:'F_USER05_YN',header:{text:'속성05'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'F_USER05_LABEL',header:{text:'속성05라벨'},width:100,editable:true},
		{name:'F_USER11_YN',header:{text:'속성11'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'F_USER11_LABEL',header:{text:'속성11라벨'},width:100,editable:true},
		{name:'F_USER12_YN',header:{text:'속성12'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'F_USER12_LABEL',header:{text:'속성12라벨'},width:100,editable:true},
		{name:'F_USER13_YN',header:{text:'속성13'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'F_USER13_LABEL',header:{text:'속성13라벨'},width:100,editable:true},
		{name:'F_USER14_YN',header:{text:'속성14'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'F_USER14_LABEL',header:{text:'속성14라벨'},width:100,editable:true},
		{name:'F_USER15_YN',header:{text:'속성15'},width:50,formatter:'checkbox',renderer:{editable:true,trueValues:"Y",falseValues:"N"}},
		{name:'F_USER15_LABEL',header:{text:'속성15라벨'},width:100,editable:true},
		{name:'ADDUSERCD',header:{text:'등록자'},width:100},
		{name:'ADDDATETIME',header:{text:'등록일시'},width:120},
		{name:'UPDUSERCD',header:{text:'수정자'},width:100},
		{name:'UPDDATETIME',header:{text:'수정일시'},width:120},
		{name:'TERMINALCD',header:{text:'IP'},width:100}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg:false});
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//열고정 설정
		gridView.setFixedOptions({colCount:2,resizable:true,colBarWidth:1});
	});
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		$('#grid1').gfn_setDataList(data.resultList);
		
		//검색결과에 따른 마스터 데이터 포커스 이동 처리 (저장처리 이후 발생 gfn_setFocusPK함수 처리)
		$('#grid1').gfn_focusPK();
	}
	//저장
	if(sid == 'sid_setSave') {
		var resultData = data.resultData;
		//마스터 데이터 PK 설정
		$('#grid1').gfn_setFocusPK(resultData, ['COMPCD']);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p000/p000020/getSearch.do';
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {
	
	var masterData = cfn_getFormData('frmSearch');
	var detailData = $('#grid1').gfn_getDataList();

	if (confirm('저장하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/alexcloud/p000/p000020/setSave.do';
		var sendData = {'mGridData':masterData,'dGridData':detailData};
		
		gfn_sendData(sid, url, sendData);
	}
}
</script>

<c:import url="/comm/contentBottom.do" />