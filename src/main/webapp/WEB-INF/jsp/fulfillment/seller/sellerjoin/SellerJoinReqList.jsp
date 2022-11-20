<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : SellerJoinReqList
	화면명    : 셀러가입 신청리스트(셀러)
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
                <div>셀러명</div>
                <div>
                    <input type="text" id="S_ITEM" class="cmc_txt" />
                </div>
            </li>
        </ul>
    </form>
</div>
<!-- 검색조건 영역 끝 -->
<!-- 그리드 시작 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
            총 신청 리스트
            <span>(총 0건)</span>
        </div>
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
	//화면레이아웃 지정 
	initLayout();
	
	//로그인정보로 초기화
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM);

	//그리드 초기화
	grid1_Load();
	
	cfn_retrieve();
 	
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [ {
		name:'ADDSELLER',
		header:{
			text:'승인'
			},
		width:50,
		buttonVisibility : 'always',
		renderer : {
			type : 'imageButtons',
			editable : false,
			images: [
				{
				name : 'addSeller',
				up: '/images/btn_addSeller.png',
				hover: '/images/btn_addSeller.png',
				down: '/images/btn_addSeller.png'
			}
				],
				alignment: 'center'
		}
	}, {
		name : 'ORGCD',
		header : {
			text : '셀러코드'
		},
		width : 80,
		editable : false,
		required : true,
		editor : {
			maxLength : 20
		}
	}, {
		name : 'NAME',
		header : {
			text : '셀러명'
		},
		width : 120,
		editable : false,
		required : true,
		editor : {
			maxLength : 50
		}
	}, {
		name : 'ADDDATETIME',
		header : {
			text : '등록일시'
		},
		width : 100,
		editable : false,
		required : false,
		editor : {
			maxLength : 20
		}
	},  {
		name : 'TEL1',
		header : {
			text : '전화번호1'
		},
		width : 110,
		editable : true,
		editor : {
			maxLength : 20
		}
	},  {
		name : 'TEL2',
		header : {
			text : '전화번호2'
		},
		width : 110,
		editable : true,
		editor : {
			maxLength : 20
		}
	}, {
		name : 'POST',
		header : {
			text : '우편번호'
		},
		width : 80,
		editable : true,
		editor : {
			maxLength : 15
		},
		formatter : 'popup',
		popupOption : {
			url : '/sys/popup/popPost/view.do',
			outparam : {
				POST : 'POST',
				ADDR : 'ADDR'
			}
		}
	}, {
		name : 'ADDR',
		header : {
			text : '주소'
		},
		width : 400,
		editable : true,
		editor : {
			maxLength : 200
		}
	}, {
		name : 'ADDR2',
		header : {
			text : '주소상세'
		},
		width : 200,
		editable : true,
		editor : {
			maxLength : 200
		}
	}, {
		name : 'CEO',
		header : {
			text : '대표자'
		},
		width : 100,
		editable : true,
		editor : {
			maxLength : 50
		},
		styles : {
			textAlignment : 'center'
		}
	}, {
		name : 'BIZNO1',
		header : {
			text : '사업자번호1'
		},
		width : 110,
		editable : true,
		editor : {
			maxLength : 50
		}
	}, {
		name:'BIZDOWN',
		header:{
			text:'사업자등록증 다운'
			},
		width:100,
		buttonVisibility : 'always',
		renderer : {
			type : 'imageButtons',
			editable : false,
			images: [
				{
				name : 'download',
				up: '/images/btn_download.png',
				hover: '/images/btn_download.png',
				down: '/images/btn_download.png'
			}
				],
				alignment: 'center'
		},
		cursor : 'pointer'
	},  {
		name : 'RTN_BANK_NAME',
		header : {
			text : '환불은행명'
		},
		width : 180,
		editable : true,
		editor : {
			maxLength : 80
		}
	},  {
		name : 'RTN_BANK_ACCOUNT',
		header : {
			text : '환불계좌번호'
		},
		width : 180,
		editable : true,
		editor : {
			maxLength : 80
		}
	},  {
		name : 'RTN_BANK_ACCOUNT_NAME',
		header : {
			text : '예금주'
		},
		width : 100,
		editable : true,
		editor : {
			maxLength : 80
		}
	},  {
		name : 'EMAIL',
		header : {
			text : '이메일'
		},
		width : 180,
		editable : true,
		editor : {
			maxLength : 80
		}
	},  {
		name : 'WEBADDR',
		header : {
			text : '홈페이지'
		},
		width : 180,
		editable : true,
		editor : {
			maxLength : 50
		}
		
	},  {
		name : 'NATION',
		header : {
			text : '국가'
		},
		width : 100,
		editable : true,
		editor : {
			maxLength : 50
		}
	},  {
		name : 'REMARKS',
		header : {
			text : '비고'
		},
		width : 180,
		editable : true,
		editor : {
			maxLength : 200
		}
		
	},  {
		name : 'COMPCD',
		header : {
			text : '회사코드'
		},
		styles : {
			textAlignment : 'center'
		},
		visible : false,
		show : false

	},  {
		name : 'MEM_USERCD',
		header : {
			text : '신청사용자ID'
		},
		styles : {
			textAlignment : 'center'
		},
		visible : false,
		show : false

	},  {
		name : 'FILENAME',
		header : {
			text : '업로드파일명'
		},
		styles : {
			textAlignment : 'center'
		},
		visible : false,
		show : false

	},  {
		name : 'ORIGINFILENM',
		header : {
			text : '실제저장파일명'
		},
		styles : {
			textAlignment : 'center'
		},
		visible : false,
		show : false

	}];

	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {
		footerflg : false
	});

	//disable할꺼
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//열고정 설정
		gridView.setFixedOptions({
			colCount : 1,
			resizable : true,
			colBarWidth : 1
		});
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid,
				oldRowIdx, newRowIdx) {
			
		};
		
		
		//셀 클릭 이벤트
		gridView.onDataCellClicked = function(gridView, column) {
			var rowidx = $('#'+gid).gfn_getCurRowIdx();
			//출력버튼 클릭
			if(column.column == 'ADDSELLER') {
				var orgCd = $('#' + gid).gfn_getValue(rowidx, 'ORGCD');
				var usercd = $('#' + gid).gfn_getValue(rowidx, 'MEM_USERCD');
				var email = $('#' + gid).gfn_getValue(rowidx, 'EMAIL');
				var name = $('#' + gid).gfn_getValue(rowidx, 'NAME');

				rfn_setApproval(orgCd, usercd, email, name);
			}
			//사업자등록증다운 버튼 클릭
			if(column.column == 'BIZDOWN') {
				var compcd = $('#' + gid).gfn_getValue(rowidx, 'COMPCD');
				var orgcd = $('#' + gid).gfn_getValue(rowidx, 'ORGCD');
				var filename = $('#' + gid).gfn_getValue(rowidx, 'FILENAME');
				var originfilenm = $('#' + gid).gfn_getValue(rowidx, 'ORIGINFILENM');
				
				window.open(encodeURI('/alexcloud/popup/popS014/noticeDownloadFile.do?realFilename='+ originfilenm + '&filename='+ filename))
			}
		}
	});	
}

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {

	//검색
	if (sid == 'sid_getSearch') {
		$('#grid1').gfn_setDataList(data.resultList);
		$('#grid1').gfn_focusPK();
	}
	
	//저장
	if (sid == 'sid_setSave') {
		$('#grid1').gfn_setFocusPK(data.resultData, [ 'COMPCD', 'ORGCD' ]);
		cfn_msg('INFO', '정상적으로 저장되었습니다.');
		cfn_retrieve();
	}
	
	//승인
	if (sid == 'sid_setApproval') {
		$('#grid1').gfn_setFocusPK(data.resultData, [ 'COMPCD', 'ORGCD' ]);
		cfn_msg('INFO', '정상적으로 승인처리가 되었습니다.');
		cfn_retrieve();
	}
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	$('#grid1').gridView().cancel();

	gv_searchData = cfn_getFormData('frmSearch');

	//서버 호출
	var sid = 'sid_getSearch';
	var url = '/fulfillment/sellerjoin/sellerJoinReqList/getSearch.do';
	var sendData = {
		'paramData' : gv_searchData
	};

	gfn_sendData(sid, url, sendData);
}

/* 공통버튼 - 저장 클릭 */
function cfn_save(directmsg) {
	$('#grid1').gridView().commit(true);

	var $grid1 = $('#grid1');
	var masterList = $grid1.gfn_getDataList(false);

	if (masterList.length < 1) {
		cfn_msg('WARNING', '변경된 항목이 없습니다.');
		return false;
	}

	//변경RowIndex 추출
	var states = $grid1.dataProvider().getAllStateRows();
	var stateRowidxs = states.updated;
	stateRowidxs = stateRowidxs.concat(states.created);

	//필수입력 체크
	if ($grid1.gfn_checkValidateCells(stateRowidxs))
		return false;

	if (confirm('저장하시겠습니까?')) {
		var sid = 'sid_setSave';
		var url = '/fulfillment/sellerjoin/sellerJoinReqList/setSave.do';
		var sendData = {
			'mGridList' : masterList
		};

		gfn_sendData(sid, url, sendData);
	}

}

//그리드 버튼관련
function rfn_setApproval(orgCd, usercd, email, name) {
	
		if (confirm('셀러코드['+ orgCd +']를 승인 하시겠습니까?')) {
			var sid = 'sid_setApproval';
			var url = '/fulfillment/sellerjoin/sellerJoinReqList/setApproval.do';
		var sendData = {'paramData':{COMPCD:cfn_loginInfo().COMPCD, ORGCD:orgCd, USERCD:usercd, NAME:name, EMAIL:email}};
			gfn_sendData(sid, url, sendData);
		}
}
</script>
<c:import url="/comm/contentBottom.do" />