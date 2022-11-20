<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P800100
	화면명    : 재고조회 
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="S_COMPCD" class="cmc_code" /> <input
			type="hidden" id="S_COMPNM" class="cmc_code" />

		<ul class="sech_ul">
			<li class="sech_li">
				<div>창고</div>
				<div>
					<input type="text" id="S_WHCD" class="cmc_code" /> 
					<input type="text" id="S_WHNM" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
<!-- 			<li class="sech_li"> -->
<!-- 				<div>로케이션</div> -->
<!-- 				<div> -->
<!-- 					<input type="text" id="S_LOCCD" class="cmc_code" /> -->
<!-- 				</div> -->
<!-- 			</li> -->
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
			
<!-- 			<li class="sech_li" id="SEARCHWHINVTYPE"> -->
<!-- 				<div>창고재고유형</div> -->
<!-- 				<div> -->
<!-- 					<select id="S_WHINVTYPE" class="cmc_combo"> -->
<!-- 						<option value="">--전체--</option> -->
<%-- 						<c:forEach var="i" items="${codeWHINVTYPE}"> --%>
<%-- 							<option value="${i.code}">${i.value}</option> --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</li> -->
		</ul>
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div id="tab1" class="ct_tab">

<!-- 		<div id="tab1Cont1"> -->
			<div class="grid_top_wrap">
				<div class="grid_top_left">
					셀러별 재고 리스트<span>(총 0건)</span>
				</div>
				<div class="grid_top_right"></div>
			</div>
			<div id="grid1"></div>
<!-- 		</div> -->
<!-- 		<div id="tab1Cont2"> -->
<!-- 			<div class="grid_top_wrap"> -->
<!-- 				<div class="grid_top_left"> -->
<!-- 					화주X창고별 재고 리스트<span>(총 0건)</span> -->
<!-- 				</div> -->
<!-- 				<div class="grid_top_right"></div> -->
<!-- 			</div> -->
<!-- 			<div id="grid2"></div> -->
<!-- 		</div> -->
<!-- 		<div id="tab1Cont3"> -->
<!-- 			<div class="grid_top_wrap"> -->
<!-- 				<div class="grid_top_left"> -->
<!-- 					화주X창고X로케이션별 재고 리스트<span>(총 0건)</span> -->
<!-- 				</div> -->
<!-- 				<div class="grid_top_right"></div> -->
<!-- 			</div> -->
<!-- 			<div id="grid3"></div> -->
<!-- 		</div> -->
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

	//로그인 정보로 세팅
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD); 
	$('#S_COMPNM').val(cfn_loginInfo().COMPNM); 
	$('#S_WHCD').val(cfn_loginInfo().WHCD);
	$('#S_WHNM').val(cfn_loginInfo().WHNM);
	$('#S_ORGCD').val(cfn_loginInfo().ORGCD); 
	$('#S_ORGNM').val(cfn_loginInfo().ORGNM); 
	$('#S_GUBUN').val("1"); 
// 	$('#S_CUSTCD').val(cfn_loginInfo().CUSTCD);
// 	$('#S_CUSTNM').val(cfn_loginInfo().CUSTNM);
	
	grid1_Load();
// 	grid2_Load();
// 	grid3_Load();

	if(cfn_loginInfo().USERGROUP == '${SELLER_ADMIN}' || cfn_loginInfo().USERGROUP == '${CENTER_ADMIN}'){
   	    $('#S_WHCD').val(cfn_loginInfo().WHCD);
   	    $('#S_WHNM').val(cfn_loginInfo().WHNM);
		$('#S_WHCD').prop("disabled",true);
		$('#S_WHNM').prop("disabled",true);
		$('#S_WHCD_BTN').prop("disabled",true);
		
		$('#sOrgCd').prop("disabled",true);
		$('#sOrgNm').prop("disabled",true);
 	}
		
	/* 공통코드 코드/명 (화주) */
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

	/* 공통코드 코드/명 (거래처) */
//  	pfn_codeval({
// 		url:'/alexcloud/popup/popP003/view.do',codeid:'S_CUSTCD',
// 		inparam:{S_CUSTCD:'S_CUSTCD,S_CUSTNM',S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD',S_ORGNM:'S_ORGNM'},
// 		outparam:{CUSTCD:'S_CUSTCD',NAME:'S_CUSTNM'}
// 	});	 
	
 	if($('#S_ORGCD').val().length > 0){
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
	}
	if($('#S_WHCD').val().length > 0){
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
	}
	
// 	if($('#S_CUSTCD').val().length > 0){
// 		$('#S_CUSTCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
// 		$('#S_CUSTNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
// 		$('#btn_S_CUSTCD').attr('disabled','disabled').addClass('disabled');
// // 		$('#thirdTab').hide();
// // 	}else{
// // 		$('#thirdTab').show();
// 	}
	
	/* if ($("#tab1").tabs("option", "active") == 1){
		
	} else {
		
	} */
	
	$('#firstTab').click(function () {
		$('#SEARCHWHINVTYPE').show();
    });
    $('#secondTab').click(function () {
			$('#SEARCHWHINVTYPE').hide();
	});
	$('#thirdTab').click(function () {
		$('#SEARCHWHINVTYPE').hide();
    });
	
	
});

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
		{name:'COMPNM',header:{text:'회사명'},width:100,show:false},
		{name:'ORGCD',header:{text:'셀러코드'},width:100,show:false},
		{name:'ORGNM',header:{text:'셀러명'},width:100,styles:{textAlignment:'center'}},
// 		{name:'CUSTCD',header:{text:'거래처코드'},width:100,show:false},
// 		{name:'CUSTNM',header:{text:'거래처명'},width:150},
		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
		{name:'ITEMNM',header:{text:'품목명'},width:250},
		{name:'ITEMSIZE',header:{text:'규격'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITCD',header:{text:'단위'},width:60,styles:{textAlignment:'center'}},
		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
		{name:'INPLTQTY',header:{text:'PLT입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'INBOXQTY',header:{text:'BOX입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
		{name:'AVAILABLEQTY',header:{text:'가용수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'QTY',header:{text:'재고수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'ALLOCQTY',header:{text:'할당수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		}

		/*
		{name:'WEEK_STOCK',header:{text:'평균출고'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		{name:'WEEK_STOCK_TODAY',header:{text:'가능일수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},
		*/
		/* {name:'ORDERQTY',header:{text:'미할당'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		}
		{name:'EXPECTATION_QTY',header:{text:'GAP'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
		},*/
// 		{name:'SECURITY_STOCK',header:{text:'안전재고'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
// 		{name:'STATUSNM',header:{text:'상태'},width:60,styles:{textAlignment:'center'}},
		
// 		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(1)},
// 		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(2)},
// 		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(3)},
// 		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(4)},
// 		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(5)},
// 		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100, show:cfn_getCompItemVisible(11)},
// 		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100, show:cfn_getCompItemVisible(12)},
// 		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100, show:cfn_getCompItemVisible(13)},
// 		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100, show:cfn_getCompItemVisible(14)},
// 		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100, show:cfn_getCompItemVisible(15)}
	];
	
	$('#' + gid).gfn_createGrid(columns, {});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
// 		//셀 더블 클릭 이벤트
// 		gridView.onDataCellDblClicked = function(gridview, index) {
// 			$("#tab1").tabs( "option", "active", 1 );
			
// 			var sid = 'sid_getSearch2';
// 			var url = '/alexcloud/p800/p800100/getSearch2.do';
// 			var sendData = {'paramData':{'S_COMPCD':$('#' + gid).gfn_getValue(index.itemIndex, 'COMPCD')
// 				                       , 'S_ORGCD':$('#' + gid).gfn_getValue(index.itemIndex, 'ORGCD')
// 				                       , 'S_ITEMCD':$('#' + gid).gfn_getValue(index.itemIndex, 'ITEMCD')
// 				                       , 'S_GUBUN':$('#S_GUBUN').val()
// 				                       , 'S_WHCD':$('#S_WHCD').val()
// 				                        }
// 							};
			
// 			gfn_sendData(sid, url, sendData);
// 		}
	});
	
// 	$('#'+gid).gridView().setStyles({
// 	    body: {
// 	        dynamicStyles: [{
// 	            criteria: [
// 	            	"values['STATUSNM'] = '과다'",
// 	            	"values['STATUSNM'] = '부족'"		            	
// 	            ],
// 	            styles: [
// 	            	"background=#F8E0E6",
// 	            	"background=#F3F781"	   
// 	            ]
// 	        }]
// 	    }
// 	});
	
}

// function grid2_Load() {
// 	var gid = 'grid2';
// 	var columns = [
// 		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
// 		{name:'COMPNM',header:{text:'회사명'},width:100,show:false},
// 		{name:'ORGCD',header:{text:'화주코드'},show:false},
// 		{name:'ORGNM',header:{text:'화주명'},width:100,styles:{textAlignment:'center'}},
// 		{name:'WHCD',header:{text:'창고코드'},show:false},
// 		{name:'WHNM',header:{text:'창고명'},width:100,styles:{textAlignment:'center'}},
// 		{name:'CUSTCD',header:{text:'거래처코드'},show:false},
// 		{name:'CUSTNM',header:{text:'거래처명'},width:150},
// 		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
// 		{name:'ITEMNM',header:{text:'품목명'},width:250},
// 		{name:'ITEMSIZE',header:{text:'규격'},width:60,styles:{textAlignment:'center'}},
// 		{name:'UNITCD',header:{text:'단위'},width:60,styles:{textAlignment:'center'}},
// 		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
// 		{name:'INPLTQTY',header:{text:'PLT입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
// 		{name:'INBOXQTY',header:{text:'BOX입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
// 		{name:'AVAILABLEQTY',header:{text:'가용수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
// 			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
// 		},
// 		{name:'QTY',header:{text:'재고수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
// 			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
// 		},
// 		{name:'ALLOCQTY',header:{text:'할당수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
// 			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
// 		},
// 		/*
// 		{name:'WEEK_STOCK',header:{text:'평균출고'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
// 			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
// 		},
// 		{name:'WEEK_STOCK_TODAY',header:{text:'가능일수'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
// 			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
// 		},
// 		*/
// 		/* {name:'ORDERQTY',header:{text:'미할당'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
// 			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
// 		}, 
// 		{name:'EXPECTATION_QTY',header:{text:'GAP'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
// 			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
// 		},*/
// // 		{name:'SECURITY_STOCK',header:{text:'안전재고'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
// // 		{name:'STATUSNM',header:{text:'상태'},width:60,styles:{textAlignment:'center'}},
		
// 		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(1)},
// 		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(2)},
// 		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(3)},
// 		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(4)},
// 		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(5)},
// 		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100, show:cfn_getCompItemVisible(11)},
// 		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100, show:cfn_getCompItemVisible(12)},
// 		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100, show:cfn_getCompItemVisible(13)},
// 		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100, show:cfn_getCompItemVisible(14)},
// 		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100, show:cfn_getCompItemVisible(15)}
// 	];
	
// 	$('#' + gid).gfn_createGrid(columns, {});
	
	
// 	if($('#S_CUSTCD').val().length < 0){
// 		//그리드설정 및 이벤트처리
// 		$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
			
// 			//셀 더블 클릭 이벤트
// 			gridView.onDataCellDblClicked = function(gridview, index) {
// 				$("#tab1").tabs( "option", "active", 2 );
				
// 				var sid = 'sid_getSearch3';
// 				var url = '/alexcloud/p800/p800100/getSearch3.do';
// 				var sendData = {'paramData':{'S_COMPCD':$('#' + gid).gfn_getValue(index.itemIndex, 'COMPCD')
// 					                       , 'S_ORGCD':$('#' + gid).gfn_getValue(index.itemIndex, 'ORGCD')
// 					                       , 'S_WHCD':$('#' + gid).gfn_getValue(index.itemIndex, 'WHCD')
// 					                       , 'S_ITEMCD':$('#' + gid).gfn_getValue(index.itemIndex, 'ITEMCD')
// 					                       , 'S_GUBUN':$('#S_GUBUN').val()
// 					                        }
// 								};
				
// 				gfn_sendData(sid, url, sendData);
// 			}
// 		});
// 	}
	
// // 	$('#'+gid).gridView().setStyles({
// // 	    body: {
// // 	        dynamicStyles: [{
// // 	            criteria: [
// // 	            	"values['STATUSNM'] = '과다'",
// // 	     	        	"values['STATUSNM'] = '부족'"
// // 	            ],
// // 	            styles: [
// // 	                "background=#F8E0E6",
// // 	            	"background=#F3F781"	                
// // 	            ]
// // 	        }]
// // 	    }
// // 	});
	
	
	
// }

// function grid3_Load() {
// 	var gid = 'grid3';
// 	var columns = [
// 		{name:'COMPCD',header:{text:'회사코드'},width:100,show:false},
// 		{name:'COMPNM',header:{text:'회사명'},width:100,show:false},
// 		{name:'ORGCD',header:{text:'화주코드'},width:100,show:false},
// 		{name:'ORGNM',header:{text:'화주명'},width:100,styles:{textAlignment:'center'}},
// 		{name:'WHCD',header:{text:'창고코드'},width:100,show:false},
// 		{name:'WHNM',header:{text:'창고명'},width:100,styles:{textAlignment:'center'}},
// 		{name:'CUSTCD',header:{text:'거래처코드'},width:100,show:false},
// 		{name:'CUSTNM',header:{text:'거래처명'},width:150},
// 		{name:'LOCCD',header:{text:'로케이션'},width:100,styles:{textAlignment:'center'}},
// 		{name:'ITEMCD',header:{text:'품목코드'},width:100,styles:{textAlignment:'center'}},
// 		{name:'ITEMNM',header:{text:'품목명'},width:250},
// 		{name:'ITEMSIZE',header:{text:'규격'},width:60,styles:{textAlignment:'center'}},
// 		{name:'UNITCD',header:{text:'단위'},width:60,styles:{textAlignment:'center'}},
// 		{name:'UNITTYPE',header:{text:'관리단위'},width:80,formatter:'combo',comboValue:'${gCodeUNITTYPE}',styles:{textAlignment:'center'}},
// 		{name:'INPLTQTY',header:{text:'PLT입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
// 		{name:'INBOXQTY',header:{text:'BOX입수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'}},
// 		{name:'AVAILABLEQTY',header:{text:'가용수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
// 			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
// 		},
// 		{name:'QTY',header:{text:'재고수량'},width:100,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
// 			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
// 		},
// 		{name:'ALLOCQTY',header:{text:'할당수량'},width:70,dataType:'number',styles:{textAlignment:'far',numberFormat:'#,##0'},
// 			footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}
// 		},
// 		{name:'HISTORY',header:{text:'이력'},width:35,formatter:'btnsearch'},
// 		{name:'LOTKEY',header:{text:'로트키'},width:100,styles:{textAlignment:'center'}},
// 		{name:'LOT1',header:{text:cfn_getLotLabel(1)},width:100, formatter:cfn_getLotType(1),show:cfn_getLotVisible(1),styles:{textAlignment:'center'}},
// 		{name:'LOT2',header:{text:cfn_getLotLabel(2)},width:100, formatter:cfn_getLotType(2),show:cfn_getLotVisible(2),styles:{textAlignment:'center'}},
// 		{name:'LOT3',header:{text:cfn_getLotLabel(3)},width:100, formatter:cfn_getLotType(3),show:cfn_getLotVisible(3),styles:{textAlignment:'center'}},
// 		{name:'LOT4',header:{text:cfn_getLotLabel(4)},width:100, show:cfn_getLotVisible(4),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT4},
// 		{name:'LOT5',header:{text:cfn_getLotLabel(5)},width:100, show:cfn_getLotVisible(5),formatter:'combo',styles:{textAlignment:'center'},comboValue:gCodeLOT5},
// 		{name:'F_USER01',header:{text:cfn_getCompItemLabel(1)},width:100,formatter:'combo',comboValue:gCodeFUSER01,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(1)},
// 		{name:'F_USER02',header:{text:cfn_getCompItemLabel(2)},width:100,formatter:'combo',comboValue:gCodeFUSER02,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(2)},
// 		{name:'F_USER03',header:{text:cfn_getCompItemLabel(3)},width:100,formatter:'combo',comboValue:gCodeFUSER03,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(3)},
// 		{name:'F_USER04',header:{text:cfn_getCompItemLabel(4)},width:100,formatter:'combo',comboValue:gCodeFUSER04,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(4)},
// 		{name:'F_USER05',header:{text:cfn_getCompItemLabel(5)},width:100,formatter:'combo',comboValue:gCodeFUSER05,styles:{textAlignment:'center'}, show:cfn_getCompItemVisible(5)},
// 		{name:'F_USER11',header:{text:cfn_getCompItemLabel(11)},width:100, show:cfn_getCompItemVisible(11)},
// 		{name:'F_USER12',header:{text:cfn_getCompItemLabel(12)},width:100, show:cfn_getCompItemVisible(12)},
// 		{name:'F_USER13',header:{text:cfn_getCompItemLabel(13)},width:100, show:cfn_getCompItemVisible(13)},
// 		{name:'F_USER14',header:{text:cfn_getCompItemLabel(14)},width:100, show:cfn_getCompItemVisible(14)},
// 		{name:'F_USER15',header:{text:cfn_getCompItemLabel(15)},width:100, show:cfn_getCompItemVisible(15)}
// 		];
	
// 	$('#' + gid).gfn_createGrid(columns, {});
	
// 	//그리드설정 및 이벤트처리
// 	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
// 		//이력 조회 버튼 클릭 이벤트
// 		gridView.onImageButtonClicked = function(grid, itemIndex, column, buttonIndex, name) {
// 			pfn_popupOpen({
// 				url:'/alexcloud/p800/p800100_popup/view.do',
// 				pid:'P800100_popup',
// 				params: {'S_COMPCD':$('#' + gid).gfn_getValue(itemIndex, 'COMPCD')
// 					   , 'S_ORGCD':$('#' + gid).gfn_getValue(itemIndex, 'ORGCD')
// 					   , 'S_WHCD':$('#' + gid).gfn_getValue(itemIndex, 'WHCD')
// 					   , 'S_LOCCD':$('#' + gid).gfn_getValue(itemIndex, 'LOCCD')
// 					   , 'S_ITEMCD':$('#' + gid).gfn_getValue(itemIndex, 'ITEMCD')
// 					   , 'S_LOTKEY':$('#' + gid).gfn_getValue(itemIndex, 'LOTKEY')
// 					    },
// 				returnFn: function(data) {
// 				}		
// 			});	
			
// 		};
// 	});
// }

/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch1') {
		$('#grid1').gfn_setDataList(data.resultList);
// 	} else if (sid == 'sid_getSearch2') {
// 		$('#grid2').gfn_setDataList(data.resultList);
// 	} else if (sid == 'sid_getSearch3') {
// 		$('#grid3').gfn_setDataList(data.resultList);
	}  
}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	gv_searchData = cfn_getFormData('frmSearch');
	
	var sid = 'sid_getSearch1';
	var url = '/alexcloud/p800/p800100/getSearch1.do';

// 	if ($("#tab1").tabs("option", "active") == 1){
// 		sid = 'sid_getSearch2';
// 		url = '/alexcloud/p800/p800100/getSearch2.do';
// 	} else if ($("#tab1").tabs("option", "active") == 2){
// 		sid = 'sid_getSearch3';
// 		url = '/alexcloud/p800/p800100/getSearch3.do';
// 	}
	var sendData = {'paramData':gv_searchData};
	
	gfn_sendData(sid, url, sendData);
}

</script>

<c:import url="/comm/contentBottom.do" />