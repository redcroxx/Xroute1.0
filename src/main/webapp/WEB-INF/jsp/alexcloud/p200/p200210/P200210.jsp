<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P200100
	화면명 : 주문서등록(예정)
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
	<input type="hidden" id="S_COMPCD" class="cmc_code" />
	<input type="hidden" id="S_REG_SEQ" class="cmc_code" />	
	<input type="hidden" id="S_STATUS_CD" class="cmc_code" />	<!-- 주문서상태 -->
	<input type="hidden" id="S_ORG_DELI_CD" class="cmc_code" />	<!-- 원주문 택배사 -->
	<input type="hidden" id="S_INVCNUM" class="cmc_code" /> <!-- 송장발번플래그 -->
	<input type="hidden" id="ADDRYNCNT" class="cmc_code" /> <!-- 주소정재 유무  -->
	<input type="hidden" id="INVCYNCNT" class="cmc_code" /> <!-- 송장발번 유무  -->
	<input type="hidden" id="INVPRNCNT" class="cmc_code" /> <!-- 송장출력횟수  -->
	
	
	<ul class="sech_ul">
		<li class="sech_li required">
			<div>화주</div>
			<div>
				<input type="text" id="S_ORGCD" class="cmc_code required" />
				<input type="text" id="S_ORGNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
		<li class="sech_li required">
			<div>주문일자</div>
			<div>
				<input type="text" id="S_FILE_YMD" class="cmc_date required"/> 
			</div>
		</li>
		<li class="sech_li">
			<div>창고</div>
			<div>
				<input type="text" id="S_WHCD" class="cmc_code" />
				<input type="text" id="S_WHNM" class="cmc_value" />
				<button type="button" class="cmc_cdsearch"></button>
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<li class="sech_li required">
			<div>차수</div>
			<div>
				<input type="text" id="S_FILE_SEQ" class="num required" />
			</div>
		</li>
		<li class="sech_li">
			<div>차수명</div>
			<div>
				<input type="text" id="S_FILE_NM" class="cmc_txt"/> 
			</div>
		</li>
		<li class="sech_li">
			<div>주문서양식</div>
			<div>
				<select id="S_SITE_CD" class="cmc_combo">
					
				</select>
			</div>
		</li>
	</ul>
	<ul class="sech_ul">
		<li class="sech_li">
			<div>택배사</div>
			<div>
				<select id="S_DELI_CD" class="cmc_combo" onChange="fn_deliChg()">
					<option value="">선택</option>
					<c:forEach var="i" items="${codeDELI}">
						<option value="${i.CODE}">${i.VALUE}</option>
					</c:forEach>
				</select>
			</div>
		</li>
		<li class="sech_li">
			<div>출고라인</div>
			<div>
				<select id="S_RELEASE_LINE" class="cmc_combo">
					<option value="">선택</option>
					<c:forEach var="i" items="${codeRELEASE_LINE}">
						<option value="${i.code}">${i.value}</option>
					</c:forEach>
				</select>
			</div>
		</li>
		<li class="sech_li">
			<div>송장출력 테스트</div>
			<div>
				<input type="button" id="btn_upload20" class="cmb_normal" value="송장출력" onclick="fn_test();" />
			</div>
		</li>
	</ul>

	<div id="sech_extwrap">
		<!-- 회사별 상품정보 조회조건 -->
		<c:import url="/comm/compItemSearch.do" />
	</div>
	
	</form>
</div>
<!-- 검색조건 영역 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">원주문리스트<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="hidden" id="RESULTFLG" class="cmc_code" />
			<div style="float:right;padding:0 5px 0 5px;font-weight:bold;color:#555555;">: 통합에러체크 오류(합포장)</div>
			<div style="float:right;width:15px;height:15px;margin-left:15px;background-color:#ffff1a;"></div>
			<div style="float:right;padding:0 5px 0 5px;font-weight:bold;color:#555555;">: 통합에러체크 오류</div>
			<div style="float:right;width:15px;height:15px;margin-left:15px;background-color:#ff6464;"></div>
		</div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<!-- 그리드 시작 -->
<div class="ct_bot_wrap">
	<div class="ct_top_wrap fix botfix" style="height:40px">               
		<div style="position:relative; float:left; ">
			<!-- <input type="button" id="btn_upload9" class="cmb_normal" value="할당순위변경" onclick="pfn_alocPopup();" /> 팝업 -->
			<input type="button" id="btn_upload14" class="cmb_normal cmc_btn" value="통합에러체크" onclick="fn_chkerrmerge();" />
			<input type="button" id="btn_upload13" class="cmb_normal" value="중복주문삭제" style="display:none" onclick="fn_DelOrdNoDup();" />
			<input type="button" id="btn_upload15" class="cmb_normal" value="강제발주서생성" style="display:none" onclick="fn_makeordersheet2();" />
			<input type="button" id="btn_upload12" class="cmb_normal cmc_btn" value="발주서생성" onclick="fn_makeordersheet();" />
		</div>
		<div style="position:relative; float:right; text-align:right">
			<input type="button" id="btn_upload10" class="cmb_normal cmc_btn" value="재고부족품목분리" onclick="pfn_stockdivide();" />
			<input type="button" id="btn_upload11" class="cmb_normal cmc_btn" value="주문삭제" onclick="fn_delOrderDtl();" />
			<!-- <input type="button" id="btn_upload11" class="cmb_normal" value="가능수량으로 주문수량변경" onclick="fn_alocupdate();" /> -->
			<!-- <input type="button" id="btn_upload6" class="cmb_normal" value="주문액조회" onclick="pfn_saPopup();" /> 팝업 -->
		</div>
	
	</div>
	<div class="ct_bot_wrap">
		<div class="ct_top_wrap fix botfix" style="height:40px">      
		<div class="grid_top_wrap">
			<div class="grid_top_left">발주서 리스트<span>(총 0건)</span>
			</div>
			<div class="grid_top_right">
				<div style="float:right;padding:0 5px 0 5px;font-weight:bold;color:#555555;">: 주소정재/송장발번 완료</div>
				<div style="float:right;width:15px;height:15px;margin-left:15px;background-color:#33ff33;"></div>
				<div style="float:right;padding:0 5px 0 5px;font-weight:bold;color:#555555;">: 주소정재/송장발번 오류</div>
				<div style="float:right;width:15px;height:15px;margin-left:15px;background-color:#ff6464;"></div>
				<div style="float:right;padding:0 5px 0 5px;font-weight:bold;color:#555555;">: 주소정재/송장발번 대기</div>
				<div style="float:right;width:15px;height:15px;background-color:#ffff1a;"></div>			
			</div>
		</div>
		<div id="grid2"></div>
		</div>
		<div class="ct_bot_wrap fix botfix" style="height:40px">
				<input type="button" id="btn_upload18" class="cmb_normal" value="송장발번" onclick="fn_makeinvcnum();" />
				<input type="button" id="btn_upload19" class="cmb_normal" value="주소정재" onclick="fn_makeinvcaddr();" />
				<input type="text" id="S_INVCSTART" class="cmc_int" style="width:30px"/>
				<p id="S_INVC"style="display:inline">~</p>
				<input type="text" id="S_INVCEND" class="cmc_int" style="width:30px"/>
				<input type="button" id="btn_upload20" class="cmb_normal" value="송장출력" onclick="fn_invcprint();" />
				<input type="button" id="btn_upload21" class="cmb_normal" value="택배사송장파일매핑" onclick="pfn_invcPopup();" /> <!-- 팝업 -->
				<input type="text" id="S_DASSTART" class="cmc_int" style="width:30px"/>
				<p id="S_DAS"style="display:inline">~</p>
				<input type="text" id="S_DASEND" class="cmc_int" style="width:30px"/>
				<input type="button" id="btn_upload22" class="cmb_normal" value="상품포장지시서" onclick="fn_itempackprint();" />
				<input type="text" id="S_SMSTART" class="cmc_int" style="width:30px"/>
				<p id="S_SM"style="display:inline">~</p>
				<input type="text" id="S_SMEND" class="cmc_int" style="width:30px"/>
				<input type="button" id="btn_upload23" class="cmb_normal" value="거래내역서출력" onclick="fn_tfprint();" />
				<!-- <input type="button" id="btn_upload23_each" class="cmb_normal" value="거래내역서출력(개별)" onclick="fn_tfprint_each();" /> -->
				<input type="text" id="S_BOOKSTART" class="cmc_int" style="width:30px"/>
				<p id="S_BOOK"style="display:inline">~</p>
				<input type="text" id="S_BOOKEND" class="cmc_int" style="width:30px"/>
				<input type="button" id="btn_upload24" class="cmb_normal" value="등록증출력" onclick="fn_memberprint()" />
				<input type="button" id="btn_upload25" class="cmb_normal" value="감사카드출력" onclick="fn_cardprint();" />
				<input type="button" id="btn_upload26" class="cmb_normal" value="기존데이터모두삭제" onclick="ordercancel();" />	
		</div>
	</div>

</div>
<!-- 그리드 끝 -->

<script type="text/javascript">
var errorChkflg = false;	//2019.01.29 통합에러체크 플래그
var stockdivflg = false;	//2019.01.29 통합에러체크 플래그
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
	
	$('#btn_upload1').hide();
	$('#btn_upload2').hide();
	
	setCommBtn('execute', null, '차수리스트',{'iconname':'icon_topsearch.png'});
	setCommBtnSeq(['ret','execute','excelup']);
	
	$('#S_FILE_YMD').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
	$('#S_COMPCD').val(cfn_loginInfo().COMPCD);		
	
	/* 화주 */
	pfn_codeval({
		url:'/alexcloud/popup/popP002/view.do',codeid:'S_ORGCD',
		inparam:{S_COMPCD:'S_COMPCD',S_ORGCD:'S_ORGCD,S_ORGNM'},
		outparam:{ORGCD:'S_ORGCD',NAME:'S_ORGNM'},
		returnFn: function(data, type) { fn_sitecd(); }
	});
	
	/* 창고 */
	pfn_codeval({
		url:'/alexcloud/popup/popP004/view.do',codeid:'S_WHCD',
		inparam:{S_COMPCD:'S_COMPCD',S_WHCD:'S_WHCD,S_WHNM'},
		outparam:{WHCD:'S_WHCD',NAME:'S_WHNM'}
	});
	
 	if (!cfn_isEmpty(cfn_loginInfo().ORGCD)) {
		$('#S_ORGCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_ORGNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_ORGCD').attr('disabled','disabled').addClass('disabled');
		
		$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
		$('#S_ORGNM').val(cfn_loginInfo().ORGNM);
		fn_sitecd();//2017.12.28 추가(주문서양식불러오기)
	} 
 	
 	if (!cfn_isEmpty(cfn_loginInfo().WHCD)) {
		$('#S_WHCD').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#S_WHNM').attr('disabled',true).addClass('disabled').attr('readonly','readonly');
		$('#btn_S_WHCD').attr('disabled','disabled').addClass('disabled');
		$('#S_WHCD').val(cfn_loginInfo().WHCD);
		$('#S_WHNM').val(cfn_loginInfo().WHNM);
	} 
	
 	grid1_Load();
 	grid2_init();
	
});

function fn_test() {
	var print1 = cfn_printInfo().PRINT1;
	var compcd=$('#S_COMPCD').val();
	var orgcd=$('#S_ORGCD').val();
	var whcd=$('#S_WHCD').val();
	var relay_seq_s=$('#S_INVCSTART').val();
	var relay_seq_e=$('#S_INVCEND').val();
	var deli_cd=$('#S_DELI_CD').val();
	
	if (confirm('[프린터] : ' + print1 + '으로 출력합니다. 출력하시겠습니까?')) {
		rfn_reportLabel({
			title: '송장테스트',
			jrfName: 'P200210_test',
			args: {'COMPCD':compcd, 'ORGCD':orgcd, 'WHCD':whcd,'REG_SEQ':8606755, 'RELAY_SEQ_S':relay_seq_s, 'RELAY_SEQ_E':relay_seq_e, 'WOKEY' : ''}
		});
	};
}


function grid1_Load() {
	var gid = 'grid1';
	var columns = [];
	
	var colArr = [  'C01','C02','C03','C04','C05','C06','C07','C08','C09','C10',
					'C11','C12','C13','C14','C15','C16','C17','C18','C19','C20',
					'C21','C22','C23','C24','C25','C26','C27','C28','C29','C30',
					'C31','C32','C33','C34','C35','C36','C37','C38','C39','C40',
					'C41','C42','C43','C44','C45','C46','C47','C48','C49','C50',
					'C51','C52','C53','C54','C55','C56','C57','C58','C59','C60',
					'C61','C62','C63','C64','C65','C66','C67','C68','C69','C70',
					'C71','C72','C73','C74','C75','C76','C77','C78','C79','C80'];
	
	for(var i=0; i<colArr.length; i++){
		 columns.push({name:colArr[i],header:{text:colArr[i],width:120}})
	}
	
	columns.push({name:'TAG',header:{text:'TAG'},width:80,show:false});
	columns.push({name:'C00',header:{text:'C00'},width:80,show:false});
		
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {footerflg: false});
	
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
	
		$('#'+gid).gridView().setStyles({
			body: {
				dynamicStyles: [{
					criteria: [
						"values['TAG'] = 'F'"
						, "values['TAG'] = 'N'"
						, "values['TAG'] = 'Y'"
						, "values['TAG'] = ''"
					]
					, styles: [
						"background=#ff6464"
						, "background=#ffff1a"
						, "background=#ffffff"
						, "background=#ffffff"
					]
				}]
			}
		});
	});
}

function grid2_init(){
	var gid = 'grid2';
	var columns = [];
	
	columns.push({name:'0' ,header:{text:''},width:150});
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns,{footerflg: false});
}

function grid2_Load(data) {
	
	var gid = 'grid2';
	var columns = [];
	columns.push({fieldName:'ERROR_MSG',name:'ERROR_MSG' ,header:{text:'에러메세지'},width:100})
	columns.push({fieldName:'INVC_SNO',name:'INVC_SNO' ,header:{text:'운송장번호'},width:120,styles:{textAlignment:'center'}})
	columns.push({fieldName:'INVC_SEQ',name:'INVC_SEQ' ,header:{text:'운송장순번'},width:100,styles:{textAlignment:'center'}})
	columns.push({fieldName:'INVC_SNO_YN',name:'INVC_SNO_YN' ,header:{text:'송장발번여부'},width:100,
		renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
		dynamicStyles:[
			{criteria:'value = "Y"',styles:{figureBackground:cfn_getStsColor(3)}},
			{criteria:'value = "N"',styles:{figureBackground:cfn_getStsColor(0)}}				
		]})
	columns.push({fieldName:'ADDRYN',name:'ADDRYN' ,header:{text:'주소정재유무'},width:100,
		renderer:{type:'shape'},styles:{textAlignment:'center',figureName:'ellipse',iconLocation:'left'},
		dynamicStyles:[
			{criteria:'value = "Y"',styles:{figureBackground:cfn_getStsColor(3)}},
			{criteria:'value = "N"',styles:{figureBackground:cfn_getStsColor(0)}}				
		]})
    columns.push({fieldName:'CLGO_SNO',name:'CLGO_SNO',header:{text:'CLGO_SNO'},width:100,show:false,visible:false,styles:{textAlignment:'center'}})
	
	for(var i=0; i<data.length; i++){
		if (data[i].COLUM =="WOKEY") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:160,styles:{textAlignment:'center'}})
		} else if(data[i].COLUM =="ORD_NM") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:120,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="ORD_ID") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:100,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="ORD_SNOS") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:140,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="ORD_ADDR") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:200})	
		} else if(data[i].COLUM =="ORD_ZIPCODE") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:120,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="SND_NM") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:120,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="SND_TEL1") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:100,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="SND_ADDR") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:200})	
		} else if(data[i].COLUM =="SND_ZIPCODE") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:120,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="SND_ETC") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:100,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="RCV_NM") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:150,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="RCV_TEL1") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:120,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="RCV_TEL2") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:120,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="RCV_ADDR") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:200})	
		} else if(data[i].COLUM =="RCV_ZIPCODE") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:120,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="ORD_QTY") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:100})	
		} else if(data[i].COLUM =="PROD_CDX") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:100,styles:{textAlignment:'center'}})	
		} else if(data[i].COLUM =="PROD_NMX") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:250})
		} else if(data[i].COLUM =="GUBUN1") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:120,styles:{textAlignment:'center'}})
		} else if(data[i].COLUM =="GUBUN2") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:120,styles:{textAlignment:'center'}})
		} else if(data[i].COLUM =="DELI_TYPE") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:80,styles:{textAlignment:'center'}})
		} else if(data[i].COLUM =="DELI_MSG") {
			columns.push({fieldName:data[i].COLUM,name:data[i].COLUM ,header:{text:data[i].COLUMNM},width:200,styles:{textAlignment:'center'}})
		} else {
			var colNm = '';
			if(cfn_isEmpty(data[i].COLUM))
				colNm = 'COLTMP'+i;
			else colNm = data[i].COLUM
			columns.push({fieldName:colNm,name:colNm ,header:{text:data[i].COLUMNM},width:100})	
		} 
	} 

	// 그리드 컬럼 재생성
	$('#' + gid).gridView().setColumns(columns);
	$('#' + gid).dataProvider().setFields(columns);
	
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		
		$('#'+gid).gridView().setColumnProperty(
			gridView.columnByField("INVC_SNO"),
			"dynamicStyles", [{
				criteria: [
					"(values['ADDRYN'] = 'N') AND (values['INVC_SNO_YN'] = 'N')"
					, "((values['ADDRYN'] = 'N') OR (values['INVC_SNO_YN'] = 'N')) AND (values['ERROR_MSG'] <> '')"
					, "(values['ADDRYN'] = 'Y') AND (values['INVC_SNO_YN'] = 'Y')"
				]
				, styles: [
					"background=#ffff1a"
					,  "background=#ff6464"
					, "background=#33ff33"
				]
			}]
		)
	});
}
/* 요청한 데이터 처리 callback */
function gfn_callback(sid, data) {
	//검색
	if (sid == 'sid_getSearch') {
		if (cfn_isEmpty(data)) {
			cfn_msg('WARNING', '검색결과가 존재하지 않습니다.');
			return false;
		}
		
		$('#grid1').gfn_clearData();
		$('#grid2').gfn_clearData();
		
		$('#btn_upload13').hide(); //중복주문삭제버튼
		$('#btn_upload15').hide(); //강제주문서생성버튼
		
		var orderFileMap = data.orderFileMap;        
		var orderFileDtlList = data.orderFileDtlList;
		var siteHeaderList = data.siteHeaderList;
		var deliDataList = data.deliDataList
		var deliHeaderList = data.deliHeaderList
		var invcPickSEQ=data.invcPickSEQ;
		
		cfn_bindFormData('frmSearch', orderFileMap);//폼 바인딩
		
		fn_headbinding(siteHeaderList); //헤더 바인딩
		grid2_Load(deliHeaderList); //헤더 바인딩

		//원주문이 존재할 경우
		if (!cfn_isEmpty(orderFileDtlList)) {
			$('#grid1').gfn_setDataList(orderFileDtlList);
		}
		
		//발주서가 존재할 경우
		if (!cfn_isEmpty(deliDataList)) {
			$('#grid2').gfn_setDataList(deliDataList);
			
			errorChkflg = true; //통합에러체크 플래그
			$('.cmc_btn').attr('disabled','disabled').attr('tabindex','-1').addClass('disabled');
		} else {
			errorChkflg = false; //통합에러체크 플래그
			$('.cmc_btn').removeAttr('disabled').removeAttr('tabindex').removeClass('disabled');
		}
		
		stockdivflg = false; //lot할당 불가로 인한 주문서 분리 flg
		
		//등록증출력
		if (orderFileMap.BOOK_YN == 'Y') {
			$('#btn_upload24').show();			
			$('#S_BOOKSTART').show();
			$('#S_BOOKEND').show();
			$('#S_BOOK').show();
			
		} else {
			$('#btn_upload24').hide();
			$('#S_BOOKSTART').hide();
			$('#S_BOOKEND').hide();
			$('#S_BOOK').hide();
		}
		
		//감사카드출력	
		if (orderFileMap.CARD_YN == 'Y') {
			$('#btn_upload25').show();		
		} else {
			$('#btn_upload25').hide();
		}
		
		/* //거래내역서(개별)
		if(orderFileMap.S_WHCD == '4000'  || orderFileDtlList.S_WHCD == '4290') {
			//$('#btn_upload23_each').show();		
			$('#btn_upload23_each').hide();
		} else {
			$('#btn_upload23_each').hide();
		} */
		
		//우체국인 경우
		if (orderFileMap.S_DELI_CD === 'D0005') {
			$('#btn_upload18').insertAfter("#btn_upload19");
			$("#btn_upload19").css("margin-right", "5px");
		} else {
			$('#btn_upload18').insertBefore("#btn_upload19");
			$("#btn_upload18").css("margin-right", "5px");
		}
		
		var ymd=orderFileMap.S_FILE_YMD.substring(0, 4) + '-' + orderFileMap.S_FILE_YMD.substring(4, 6) + '-' + orderFileMap.S_FILE_YMD.substring(6, 8)
		$('#S_FILE_YMD').val(ymd);
		$('#S_ORG_DELI_CD').val(orderFileMap.S_DELI_CD);
		
		//송장 시퀀스, 픽업 리스트 시퀀스 바인딩
		$('#S_INVCEND').val(invcPickSEQ.S_INVCEND);
		$('#S_INVCSTART').val(invcPickSEQ.S_INVCSTART);
		$('#S_DASSTART').val(invcPickSEQ.S_DASSTART);
		$('#S_DASEND').val(invcPickSEQ.S_DASEND);
		$('#S_SMSTART').val(invcPickSEQ.S_SMSTART);
		$('#S_SMEND').val(invcPickSEQ.S_SMEND);
		$('#S_BOOKSTART').val(invcPickSEQ.S_SMSTART);
		$('#S_BOOKEND').val(invcPickSEQ.S_SMEND);
	}

	//데이터 병합 및 치환
	/* if (sid == 'sid_getSiteColEdit'){
		// 병합
		ck1 = data.resultList1;
		// 치환
		ck2 = data.resultList2;
		
		var $g = $('#grid1'); 
		var gridData = $g.gfn_getDataList(true);
		var columns = $g.gridView().getColumns();
		var colNames = [], excludeColumns = [];

		if (cfn_isEmpty(gridData)) {
			cfn_msg('WANRING', '데이터가 없습니다.');
			return false;
		}
		
		for (var i=0, len=gridData.length; i<len; i++) {
			// 치환
			for (var k=0, len2=ck2.length; k<len2; k++) {

				if(cfn_isEmpty(ck2[k].REPLACES1)){
					if(cfn_isEmpty(gridData[i][ck2[k].TGT_COL]))
						gridData[i][ck2[k].TGT_COL] = ck2[k].REPLACES2;
				} else {
					gridData[i][ck2[k].TGT_COL] = cfn_replaceAll(gridData[i][ck2[k].TGT_COL], ck2[k].REPLACES1, ck2[k].REPLACES2);
				}
			}
			
			// 병합
			for (var j=0, len1=ck1.length; j<len1; j++) {
				
				if(!cfn_isEmpty(ck1[j].TGT_COL)){
					
					var c1 = cfn_isEmpty(ck1[j].SRC_COLS1) ? '' : (cfn_isEmpty(gridData[i][ck1[j].SRC_COLS1]) ? '' : gridData[i][ck1[j].SRC_COLS1]);
					var c2 = cfn_isEmpty(ck1[j].SEPS1) ? '' : ck1[j].SEPS1.toString();
					var c3 = cfn_isEmpty(ck1[j].SRC_COLS2) ? '' : (cfn_isEmpty(gridData[i][ck1[j].SRC_COLS2]) ? '' : gridData[i][ck1[j].SRC_COLS2]);
					var c4 = cfn_isEmpty(ck1[j].SEPS2) ? '' : ck1[j].SEPS2.toString();
					var c5 = cfn_isEmpty(ck1[j].SRC_COLS3) ? '' : (cfn_isEmpty(gridData[i][ck1[j].SRC_COLS3]) ? '' : gridData[i][ck1[j].SRC_COLS3]);
					gridData[i][ck1[j].TGT_COL] = c1 + c2 + c3 + c4 + c5;
					
				}
			}
		}
		$('#grid1').gfn_setDataList(gridData);
	} */
	//기존데이터 삭제
	if (sid == 'sid_setOrderCancel') {
		
		$('#grid1').gfn_clearData();
		$('#grid2').gfn_clearData();
		
		cfn_msg('INFO', '삭제되었습니다.');
		
	}
	
	//주문삭제(한행)
	if (sid == 'sid_delOrderDtl') {
		if (cfn_isEmpty(data)) {
			cfn_msg('WARNING', '작업이 실패하였습니다.');
			return false;
		}
		
		cfn_retrieve();
		
		cfn_msg('INFO', '삭제가 완료되었습니다.\n통합에러체크를 다시 진행해주세요.');
		
	}
	
	//중복주문삭제
	if (sid == 'sid_delOrdNoDup') {
		if (cfn_isEmpty(data)) {
			cfn_msg('WARNING', '작업이 실패하였습니다.');
			return false;
		}
		
		cfn_retrieve();
		
		cfn_msg('INFO', '총 ' + data.resultData.SCNT + '건의 중복주문이 삭제되었습니다.\n통합에러체크를 다시 진행해주세요.');
		
	}
	
	//가능수량으로 주문수량변경
	/* if (sid == 'sid_setalocupdate') {
		var grid='grid1';
		var resultData = data.resultData;
		var msg=resultData.MSG;
		
		gfn_setColumnEmpty(grid,'TAG','');
		cfn_retrieve();
		cfn_msg('INFO', msg);
	} */
	//주문서생성
	if (sid == 'sid_setmakeordersheet') {
		var grid='grid1';
		var resultData = data.resultData;
		var msg=resultData.MSG;
		
		cfn_retrieve();
		cfn_msg('INFO', msg);
		
	}
	//강제주문서생성
	if (sid == 'sid_setmakeordersheet2') {
		var grid='grid1';
		var resultData = data.resultData;
		var msg=resultData.MSG;
		
		cfn_retrieve();
		cfn_msg('INFO', msg);
		
	}
	//송장발번
	if (sid == 'sid_setCheckGenInvc') {
		var resultData = data.resultData;
		
		cfn_msg('INFO', resultData.MSG);
		cfn_retrieve();
	}
	//주소정재
	if (sid == 'sid_setMakeInvcAddr') {
		var resultData = data.resultData;
		
		cfn_msg('INFO', resultData.MSG);
		cfn_retrieve();
		
	}
	//에러체크 통합
	if (sid == 'sid_setchkerrmerge') {
		var msgid = data.result.msgid; //메세지 아이디
		var msg = data.result.MSG; //메세지
		var packorder_msg = data.packorder_msg //합포장메세지
		var resultList = data.result.resultList; //에러체크 결과가 매핑된 그리드에 SET할 데이터리스트

		if (!cfn_isEmpty(msgid)) {
			if(msgid != '700'){
				if (msgid == '100') {
					//묶음배송  오류
					cfn_msg('ERROR', '묶음배송 오류 : ' + msg);
					
					errorChkflg = false; //통합에러체크 플래그
					$('#btn_upload14').removeAttr('disabled').removeAttr('tabindex').removeClass('disabled');
					
				}
				if (msgid == '300') {
					//상품코드 오류
					cfn_msg('ERROR',
							'묶음배송 : ' + packorder_msg + '\n'
							+ '상품코드 오류 : ' + msg
					);
					
					errorChkflg = false; //통합에러체크 플래그
					$('#btn_upload14').removeAttr('disabled').removeAttr('tabindex').removeClass('disabled');
					$('#grid1').gfn_clearData();
					$('#grid1').gfn_setDataList(resultList);
					
				}
				if (msgid == '400') {
					//재고할당 오류
					cfn_msg('ERROR',
							'묶음배송 : ' + packorder_msg + '\n'
							+ '상품코드 체크 : OK\n'
							+ '재고할당 불가  : ' + msg 
					);
					
					errorChkflg = false; //통합에러체크 플래그
					stockdivflg = true; //lot할당 불가로 인한 주문서 분리 flg
					$('#btn_upload14').removeAttr('disabled').removeAttr('tabindex').removeClass('disabled');
					$('#grid1').gfn_clearData();
					$('#grid1').gfn_setDataList(resultList);
				}
				if (msgid == '600') {
					//중복주문  오류
					cfn_msg('ERROR',
							'묶음배송 : ' + packorder_msg + '\n'
							+ '상품코드 체크 : OK\n'
							+ '재고할당 체크 : OK\n' 
							+ '중복주문 오류 : ' + msg
					);
					
					errorChkflg = false; //통합에러체크 플래그
					$('#btn_upload14').removeAttr('disabled').removeAttr('tabindex').removeClass('disabled');
					
					$('#btn_upload13').show(); //중복주문삭제버튼
					$('#btn_upload15').show(); //강제발주서생성버튼
					
					$('#grid1').gfn_clearData();
					$('#grid1').gfn_setDataList(resultList);
				}
			} else {
				cfn_msg('INFO',
						'묶음배송 : ' + packorder_msg + '\n'
						+ '상품코드 체크 : OK\n'
						+ '재고할당 체크 : OK\n' 
						+ '중복주문 체크 : OK' 
				);
				
				errorChkflg = true; //통합에러체크 플래그
				$('#btn_upload14').attr('disabled','disabled').attr('tabindex','-1').addClass('disabled');
				$('#btn_upload13').hide(); //중복주문삭제버튼
				$('#btn_upload15').hide(); //강제주문서생성버튼
				
			}
		}
		
	}

	//송장발번 / 주소정재 CNT
	if (sid == 'sid_getInvcCNTAddrCNT') {
		var resultData = data.resultData;
		$('#INVCYNCNT').empty()
		$('#INVCYNCNT').val(resultData.INVCYNCNT);
		$('#ADDRYNCNT').empty()
		$('#ADDRYNCNT').val(resultData.ADDRYNCNT);
	}

}

/* 공통버튼 - 검색 클릭 */
function cfn_retrieve() {
	//검색조건 필수입력 체크
	if(cfn_isFormRequireData('frmSearch') == false) return;
	
	var param = cfn_getFormData('frmSearch');
	var sid = 'sid_getSearch';
	var url = '/alexcloud/p200/p200210/getSearch.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData);
}

//애터미 주문서 내역가져오기
function cfn_execute(){
		var compcd=$('#S_COMPCD').val();
		var orgcd=$('#S_ORGCD').val();
		var orgnm=$('#S_ORGNM').val();
		var fileymd=$('#S_FILE_YMD').val();
		var whcd=$('#S_WHCD').val();
		var whnm=$('#S_WHNM').val();
		
		pfn_popupOpen({
			url: '/alexcloud/p200/p200210_Atomypopup/view.do',
			pid: 'P200210_Atomy',
			params: {'COMPCD':compcd,'ORGCD':orgcd,'FILE_YMD':fileymd,'ORGNM':orgnm,'WHCD':whcd,'WHNM':whnm},
			returnFn: function(data, type) { 
				if (!cfn_isEmpty(data) && data.length > 0) {
					$('#S_ORGCD').val(data[0].ORGCD);
					$('#S_ORGNM').val(data[0].ORGNM);
					$('#S_FILE_YMD').val(data[0].FILE_YMD);
					$('#S_FILE_SEQ').val(data[0].FILE_SEQ);
					$('#S_REG_SEQ').val(data[0].REG_SEQ);
					
					fn_sitecd();
					cfn_retrieve();
				}
			}
		});
}

//엑셀업로드
function cfn_excelup(){
	if (cfn_isEmpty($('#S_ORGCD').val())) {
		cfn_msg('WARNING', '화주를 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_WHCD').val())) {
		cfn_msg('WARNING', '출고창고를 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_SITE_CD').val())) {
		cfn_msg('WARNING', '주문서양식을 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_DELI_CD').val())) {
		cfn_msg('WARNING', '택배사를 선택해 주세요.');
		return false;
	}
	
	if (cfn_isEmpty($('#S_FILE_YMD').val())) {
		cfn_msg('WARNING', '날짜를 선택해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_FILE_SEQ').val())) {
		cfn_msg('WARNING', '차수를 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_FILE_NM').val())) {
		cfn_msg('WARNING', '차수명을 입력해 주세요.');
		return false;
	}
	
	if (cfn_isEmpty($('#S_RELEASE_LINE').val())) {
		cfn_msg('WARNING', '카트/DPS를 입력해 주세요.');
		return false;
	} 
	
	var compcd = $('#S_COMPCD').val()
	var orgcd = $('#S_ORGCD').val()
	var whcd = $('#S_WHCD').val()
	var whnm = $('#S_WHNM').val()
	var sitecd = $('#S_SITE_CD').val()
	var delicd = $('#S_DELI_CD').val()
	var fileymd = $('#S_FILE_YMD').val()
	var fileseq = $('#S_FILE_SEQ').val()
	var filenm = $('#S_FILE_NM').val()
	var releaseline = $('#S_RELEASE_LINE').val()
	
	pfn_popupOpen({
		url: '/alexcloud/popup/popEP200210/view.do',
		params : {
			  'COMPCD' : compcd
			, 'ORGCD' : orgcd 
			, 'WHCD' : whcd
			, 'WHNM' : whnm
			, 'SITE_CD' : sitecd
			, 'DELI_CD' : delicd
			, 'FILE_YMD' : fileymd
			, 'FILE_SEQ' : fileseq
			, 'FILE_NM' : filenm
			, 'DELI_CD' : delicd
			, 'RELEASE_LINE' : releaseline
		},
		returnFn: function(data, type) {
			if(type === 'OK') {
				$('#S_COMPCD').val(data.COMPCD);
				$('#S_ORGCD').val(data.ORGCD);
				$('#S_WHCD').val(data.WHCD);
				$('#S_SITE_CD').val(data.SITE_CD);
				$('#S_DELI_CD').val(data.DELI_CD);
				$('#S_FILE_YMD').val(data.FILE_YMD);
				$('#S_FILE_SEQ').val(data.FILE_SEQ);
				
				cfn_retrieve();
			}
		}
	});		
}

 /*주문액조회*/
/* function pfn_saPopup(){
	if(cfn_isEmpty($('#S_FILE_YMD').val())){
		cfn_msg('WARNING', '날짜를 선택해 주세요.');
		return false;
	}
	if(cfn_isEmpty($('#S_FILE_SEQ').val())){
		cfn_msg('WARNING', '차수를 입력해 주세요.');
		return false;
	}
	if(!$.isNumeric($('#S_FILE_SEQ').val())){
		cfn_msg('WARNING', '차수입력란에 숫자를 입력해 주세요.');
		return false;
	}
	if(cfn_isEmpty($('#S_FILE_NM').val())){
		cfn_msg('WARNING', '차수명을 입력해 주세요.');
		return false;
	}
	if(cfn_isEmpty($('#S_SITE_CD').val())){
		cfn_msg('WARNING', '주문서양식을 입력해 주세요.');
		return false;
	}
	if(cfn_isEmpty($('#S_WHCD').val())){
		cfn_msg('WARNING', '출고창고를 입력해 주세요.');
		return false;
	}
	if(cfn_isEmpty($('#S_ORGCD').val())){
		cfn_msg('WARNING', '화주를 입력해 주세요.');
		return false;
	} 	 
	 
	var reg_seq=$('#S_REG_SEQ').val();
	var site_cd=$('#S_SITE_CD').val();

	pfn_popupOpen({
		url: '/alexcloud/p200/p200210_Sapopup/view.do',
		pid: 'P200210_Sapopup',
		params: {'S_REG_SEQ':reg_seq,'S_SITE_CD':site_cd},
		returnFn: function(data, type) { 
		}
	});
}	  */
/*할당순위 변경*/
/* function pfn_alocPopup(){
	pfn_popupOpen({
		url: '/alexcloud/p200/p200210_Alocpopup/view.do',
		pid: 'P200210_Alocpopup',
		params: {}
	});
} */
/*택배사송장파일매핑*/
function pfn_invcPopup(){
	
	var gridData = $('#grid1').gfn_getDataList();
	var gridData1 = $('#grid2').gfn_getDataList();
	var param = cfn_getFormData('frmSearch');
	
	if (cfn_isEmpty(gridData) || cfn_isEmpty(gridData1)) {
		cfn_msg('WARNING', '데이터가 존재하지 않습니다.');
		return false;
	}
	if (($('#S_STATUS_CD').val() == '00005')) {
		cfn_msg('WARNING', '이미 매핑완료된 차수입니다.');
		return false;
	}
	if (($('#S_STATUS_CD').val() == '00001')) {
		cfn_msg('WARNING', '발주서가 존재하지 않습니다.');
		return false;
	}
	var file_ymd=$('#S_FILE_YMD').val();
	var file_seq=$('#S_FILE_SEQ').val();
	var reg_seq =$('#S_REG_SEQ').val();
	var compcd  =$('#S_COMPCD').val();
	var orgcd   =$('#S_ORGCD').val();
	
	pfn_popupOpen({
		url: '/alexcloud/p200/p200210_Invcpopup/view.do',
		pid: 'P200210_Invcpopup',
		params: {'S_REG_SEQ':reg_seq,'S_FILE_SEQ':file_seq,'S_FILE_YMD':file_ymd,'S_COMPCD':compcd,'S_ORGCD':orgcd},
		returnFn: function(data, type) { 
		}
	});
}	
/*재고부족 차수분리*/
function pfn_stockdivide(){
	//검색조건 필수입력 체크
	if (cfn_isFormRequireData('frmSearch') == false) return;
	
	if ($('#S_STATUS_CD').val() != '00001') {
		cfn_msg('WARNING', '이미 처리 된 차수입니다.');
		return;
	}
	if (!stockdivflg) {
		cfn_msg('WARNING', '재고할당 불가일 경우에만 가능합니다.');
		return;
	}
	
	var compcd=$('#S_COMPCD').val();
	var orgcd=$('#S_ORGCD').val();
	var reg_seq=$('#S_REG_SEQ').val();
	var sitecd=$('#S_SITE_CD').val();
	var whcd=$('#S_WHCD').val();	
	
	pfn_popupOpen({
		url: '/alexcloud/p200/p200210_Divpopup/view.do',
		pid: 'P200210_Divpopup',
		params: {'COMPCD':compcd,'ORGCD':orgcd,'WHCD':whcd, 'REG_SEQ':reg_seq,'SITE_CD':sitecd},
		returnFn: function(data, type) {
			if(data == 'OK'){
				cfn_retrieve();
			}
		}
	});
}	

/*버튼 이벤트*/
//가능수량으로 주문수량변경
/* function fn_alocupdate(){
	if(!errorChkflg){
		cfn_msg('WARNING', '통합에러체크 후 시도해주세요.');
		return;
	}
	if(cfn_isEmpty($('#S_FILE_YMD').val())){
		cfn_msg('WARNING', '날짜를 선택해 주세요.');
		return false;
	}
	if(cfn_isEmpty($('#S_FILE_SEQ').val())){
		cfn_msg('WARNING', '차수를 입력해 주세요.');
		return false;
	}
	if(!$.isNumeric($('#S_FILE_SEQ').val())){
		cfn_msg('WARNING', '차수입력란에 숫자를 입력해 주세요.');
		return false;
	}
	if(cfn_isEmpty($('#S_SITE_CD').val())){
		cfn_msg('WARNING', '주문서양식을 입력해 주세요.');
		return false;
	}
	if(cfn_isEmpty($('#S_ORGCD').val())){
		cfn_msg('WARNING', '화주를 입력해 주세요.');
		return false;
	} 
	if(($('#S_STATUS_CD').val() != '00001')){
		cfn_msg('WARNING', '이미 처리 된 차수입니다.');
		return false;
	}
	if(cfn_isEmpty($('#S_WHCD').val())){
		cfn_msg('WARNING', '창고를 입력해 주세요.');
		return false;
	}
	var param = cfn_getFormData('frmSearch');
	var gridData = $('#grid1').gfn_getDataList();
	
	if(cfn_isEmpty(gridData)){
		cfn_msg('WARNING', '데이터가 존재하지 않습니다.');
		return false;
	}
	
	var sid = 'sid_setalocupdate';
	var url = '/alexcloud/p200/p200210/setalocupdate.do';
	var sendData = {'paramData':param,'gridData':gridData};
	gfn_sendData(sid, url, sendData);
	
} */
//주문서생성
function fn_makeordersheet(){
	
	var param = cfn_getFormData('frmSearch');
	var gridData = $('#grid1').gfn_getDataList();
	
	if (!errorChkflg) {
		cfn_msg('WARNING', '통합에러체크 후 시도해주세요.');
		return;
	}
	if (cfn_isEmpty($('#S_FILE_YMD').val())) {
		cfn_msg('WARNING', '날짜를 선택해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_FILE_SEQ').val())) {
		cfn_msg('WARNING', '차수를 입력해 주세요.');
		return false;
	}
	if (!$.isNumeric($('#S_FILE_SEQ').val())) {
		cfn_msg('WARNING', '차수입력란에 숫자를 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_FILE_NM').val())) {
		cfn_msg('WARNING', '차수명을 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_SITE_CD').val())) {
		cfn_msg('WARNING', '주문서양식을 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_ORGCD').val())) {
		cfn_msg('WARNING', '화주를 입력해 주세요.');
		return false;
	} 
	if (($('#S_STATUS_CD').val() != '00001')) {
		cfn_msg('WARNING', '이미 처리 된 차수입니다.');
		return false;
	}
	if (cfn_isEmpty($('#S_WHCD').val())) {
		cfn_msg('WARNING', '창고를 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_DELI_CD').val())) {
		cfn_msg('WARNING', '택배사를 입력해 주세요.');//
		return false;
	}

	for (var i=0; i<gridData.length; i++) {
		if (gridData[i].TAG == 'F' || gridData[i].TAG == 'Y') {
			cfn_msg('WARNING', '통합에러체크 오류 주문이 존재합니다.');
			return false;
		}
	}
	
	var sid = 'sid_setmakeordersheet';
	var url = '/alexcloud/p200/p200210/setmakeordersheet.do';
	var sendData = {'paramData':param,'gridData':gridData};
	gfn_sendData(sid, url, sendData);

}

//강제 주문서생성
function fn_makeordersheet2(){
	
	var param = cfn_getFormData('frmSearch');
	var gridData = $('#grid1').gfn_getDataList();
	
	if (cfn_isEmpty($('#S_FILE_YMD').val())) {
		cfn_msg('WARNING', '날짜를 선택해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_FILE_SEQ').val())) {
		cfn_msg('WARNING', '차수를 입력해 주세요.');
		return false;
	}
	if (!$.isNumeric($('#S_FILE_SEQ').val())) {
		cfn_msg('WARNING', '차수입력란에 숫자를 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_FILE_NM').val())) {
		cfn_msg('WARNING', '차수명을 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_SITE_CD').val())) {
		cfn_msg('WARNING', '주문서양식을 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_ORGCD').val())) {
		cfn_msg('WARNING', '화주를 입력해 주세요.');
		return false;
	} 
	if (($('#S_STATUS_CD').val() != '00001')) {
		cfn_msg('WARNING', '이미 처리 된 차수입니다.');
		return false;
	}
	if (cfn_isEmpty($('#S_WHCD').val())) {
		cfn_msg('WARNING', '창고를 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_DELI_CD').val())) {
		cfn_msg('WARNING', '택배사를 입력해 주세요.');//
		return false;
	}
	
	if (confirm('발주서를 강제 생성 합니다. 생성 하시겠습니까?\n')) {

		var sid = 'sid_setmakeordersheet2';
		var url = '/alexcloud/p200/p200210/setmakeordersheet.do';
		var sendData = {'paramData':param,'gridData':gridData};
	
		gfn_sendData(sid, url, sendData);
	}
}

//송장발번
function fn_makeinvcnum(){
	
	var param = cfn_getFormData('frmSearch');
	var gridList = $('#grid2').gfn_getDataList();
	//var paramList = [];
	
	if (cfn_isEmpty(gridList)) {
		cfn_msg('WARNING', '출고 전표가 존재하지 않습니다.');
		return false;
	}
	
	if (cfn_isEmpty($('#S_WHCD').val())) {
		cfn_msg('WARNING', '창고를 입력해 주세요.');
		return false;
	}
	
	if ($('#S_DELI_CD').val() != 'D0004' && $('#S_DELI_CD').val() != 'D0005') {
		cfn_msg('WARNING', 'CJ택배, 우체국택배만 송장발번이 가능합니다.');//
		return false;
	}
	
	if ($('#S_ORG_DELI_CD').val() !== $('#S_DELI_CD').val()) {
		cfn_msg('WARNING','선택한 택배사와 주문서 택배사가 \n일치하지 않습니다.');
		return false;
	}
	
	if ($('#S_DELI_CD').val() === 'D0005') {
		fn_getInvcCNTAddrCNT();
		var addrCountYN = $('#ADDRYNCNT').val();
		
		if (addrCountYN != 0) {
			cfn_msg('WARNING', '주소정재 되지 않은 전표가 ' + addrCountYN +' 건 존재합니다.');
			return false;
		}
	}
	
	if (confirm('송장발번 하시겠습니까?')) {
		
		var sid = 'sid_setCheckGenInvc';
		var url = '/alexcloud/p200/p200210/setmakeinvcnum.do';
		var sendData = {'paramData':param/* ,'gridList':paramList */};
		gfn_sendData(sid, url, sendData);	
	}
}

//주소정재
function fn_makeinvcaddr(){
	
	var param = cfn_getFormData('frmSearch');
	var gridList = $('#grid2').gfn_getDataList();
	var paramList = [];
	
	if (cfn_isEmpty(gridList)) {
		cfn_msg('WARNING', '출고 전표가 존재하지 않습니다.');
		return false;
	}
	
	if ($('#S_DELI_CD').val() != 'D0004' && $('#S_DELI_CD').val() != 'D0005') {
		cfn_msg('WARNING', 'CJ택배, 우체국택배만 주소정재가 가능합니다.');
		return false;
	}
	
	if ($('#S_ORG_DELI_CD').val() !== $('#S_DELI_CD').val()) {
		cfn_msg('WARNING','선택한 택배사와 주문서 택배사가 \n일치하지 않습니다.');
		return false;
	}
	
	if ($('#S_DELI_CD').val() === 'D0004') {
		fn_getInvcCNTAddrCNT(); //주소정재 CNT, 송장발번 CNT
		
		var invcCountYN = $('#INVCYNCNT').val();
		
		if (invcCountYN != 0) {
			cfn_msg('WARNING', '송장발번 되지 않은 전표가 ' + invcCountYN +' 건 존재합니다.');
			return false;
		}
	}

	var sid = 'sid_setMakeInvcAddr';
	var url = '/alexcloud/p200/p200210/setMakeInvcAddr.do';
	var sendData = {'paramData':param,'gridData':paramList};
	gfn_sendData(sid, url, sendData);	
	
}

//주소정재 송장발번 CNT
function fn_getInvcCNTAddrCNT(){
	var regseq=$('#S_REG_SEQ').val();
	
	var sid = 'sid_getInvcCNTAddrCNT';
	var param={'REG_SEQ':regseq};
	var url = '/alexcloud/p200/p200210/getInvcCNTAddrCNT.do';
	var sendData = {'paramData':param};
	
	gfn_sendData(sid, url, sendData, false);
}

//송장출력
function fn_invcprint(){
	var print1 = cfn_printInfo().PRINT1;
	var gridData1 = $('#grid1').gfn_getDataList();
	var gridData2 = $('#grid2').gfn_getDataList();
	var deliCD = $('#S_DELI_CD').val();
	var msg;
	
	if (deliCD !== 'D0004' && deliCD !== 'D0005') {
		cfn_msg('WARNING', 'CJ택배, 우체국택배만 송장출력이 가능합니다.');
		return false;
	}
	
	if (cfn_isEmpty(gridData1)) {
		cfn_msg('WARNING', '원주문리스트가 존재하지않습니다.');
		return false;
	}
	
	if (cfn_isEmpty(gridData2)) {
		cfn_msg('WARNING', '출고 전표가 존재하지 않습니다.');
		return false;
	} 
	
	fn_getInvcCNTAddrCNT(); //주소정재 CNT, 송장발번 CNT
	
	var addrCountYN = $('#ADDRYNCNT').val();
	var invcCountYN = $('#INVCYNCNT').val();
	
	if (addrCountYN != '0') {
		cfn_msg('WARNING', '주소정재 되지 않은 전표가 ' + addrCountYN +' 건 존재합니다.');
		return false;
	} else if(invcCountYN != '0') {
		cfn_msg('WARNING', '송장발번 되지 않은 전표가 ' + invcCountYN +' 건 존재합니다.');
		return false;
	}
	
	if (confirm('[프린터] : ' + print1 + '으로 출력합니다. 출력하시겠습니까?')) {	
		
		var compcd=$('#S_COMPCD').val();
		var orgcd=$('#S_ORGCD').val();
		var whcd=$('#S_WHCD').val();
		var reg_seq=$('#S_REG_SEQ').val();
		var relay_seq_s=$('#S_INVCSTART').val();
		var relay_seq_e=$('#S_INVCEND').val();
		var deli_cd=$('#S_DELI_CD').val();
		
		if (whcd == '4000' || whcd == '4290') { //안성센터
			pfn_popupOpen({
				url: '/alexcloud/p200/p200210/viewPopup.do',
				pid: 'P200210_InvcPrnpopup',
				params: {'COMPCD':compcd, 'ORGCD':orgcd, 'WHCD':whcd,'REG_SEQ':reg_seq, 'RELAY_SEQ_S':relay_seq_s, 'RELAY_SEQ_E':relay_seq_e, 'DELI_CD' : deli_cd}
			});
	
		} else if(whcd == '2000') {//용인센터
			rfn_reportLabel({
				title: '송장(용인센터)',
				jrfName: 'P200210_R_LARGE_2000',
				args: {'COMPCD':compcd, 'ORGCD':orgcd, 'WHCD':whcd,'REG_SEQ':reg_seq, 'RELAY_SEQ_S':relay_seq_s, 'RELAY_SEQ_E':relay_seq_e, 'WOKEY' : ''}
			});
		}  
	}
}

//상품포장지시서
function fn_itempackprint(){
	var print3 = cfn_printInfo().PRINT3;
	
	var gridData1 = $('#grid1').gfn_getDataList();
	
	if(cfn_isEmpty(gridData1)){
		cfn_msg('WARNING', '원주문리스트가 존재하지않습니다.');
		return false;
	}
	
	var gridData = $('#grid2').gfn_getDataList();
	
	if(cfn_isEmpty(gridData)){
		cfn_msg('WARNING', '출고 전표가 존재하지 않습니다.');
		return false;
	} 
	
	fn_getInvcCNTAddrCNT(); //주소정재 CNT, 송장발번 CNT
	
	var addrCountYN = $('#ADDRYNCNT').val();
	var invcCountYN = $('#INVCYNCNT').val();
	
	if (addrCountYN != '0') {
		cfn_msg('WARNING', '주소정재 되지 않은 전표가 ' + addrCountYN +' 건 존재합니다.');
		return false;
	} else if(invcCountYN != '0') {
		cfn_msg('WARNING', '송장발번 되지 않은 전표가 ' + invcCountYN +' 건 존재합니다.');
		return false;
	}
	
	if (confirm('[프린터] : ' + print3 + '으로 출력합니다. 출력하시겠습니까?')) {
	
		var compcd=$('#S_COMPCD').val();
		var orgcd=$('#S_ORGCD').val();
		var whcd=$('#S_WHCD').val();
		var reg_seq=$('#S_REG_SEQ').val();
		var das_seq_s=$('#S_DASSTART').val();
		var das_seq_e=$('#S_DASEND').val();
		
		rfn_reportLabel({
			title: '상품포장지시서',
			jrfName: 'P200210_R_PICKUPLIST',
			args: {'COMPCD':compcd, 'ORGCD':orgcd, 'WHCD':whcd, 'REG_SEQ':reg_seq, 'PRINTUSERNM':cfn_loginInfo().USERNM, 'DAS_SEQ_S':das_seq_s, 'DAS_SEQ_E':das_seq_e}
		});
	}
	
}

//거래내역서
function fn_tfprint(){
	var print4 = cfn_printInfo().PRINT4;
	
	var gridData1 = $('#grid1').gfn_getDataList();
	
	if (cfn_isEmpty(gridData1)) {
		cfn_msg('WARNING', '원주문리스트가 존재하지않습니다.');
		return false;
	}
	
	var gridData = $('#grid2').gfn_getDataList();
	
	if (cfn_isEmpty(gridData)) {
		cfn_msg('WARNING', '출고 전표가 존재하지 않습니다.');
		return false;
	} 
	
	fn_getInvcCNTAddrCNT(); //주소정재 CNT, 송장발번 CNT
	
	var addrCountYN = $('#ADDRYNCNT').val();
	var invcCountYN = $('#INVCYNCNT').val();
	
	if (addrCountYN != '0') {
		cfn_msg('WARNING', '주소정재 되지 않은 전표가 ' + addrCountYN +' 건 존재합니다.');
		return false;
	} else if(invcCountYN != '0') {
		cfn_msg('WARNING', '송장발번 되지 않은 전표가 ' + invcCountYN +' 건 존재합니다.');
		return false;
	}
	
	if (confirm('[프린터] : ' + print4 + '으로 출력합니다. 출력하시겠습니까?')) {
	
		var compcd=$('#S_COMPCD').val();
		var orgcd=$('#S_ORGCD').val();
		var whcd=$('#S_WHCD').val();
		var reg_seq=$('#S_REG_SEQ').val();
		var relay_seq_s=$('#S_SMSTART').val();
		var relay_seq_e=$('#S_SMEND').val();
		
		if (whcd == '4000' || whcd == '4290') { //안성센터
			rfn_reportLabel({
				title: '상품구매계약서(애터미)',
				jrfName: 'P200210_R_TRLIST_4000',
				args: {'COMPCD':compcd, 'ORGCD':orgcd, 'WHCD':whcd, 'REG_SEQ':reg_seq, 'RELAY_SEQ_S':relay_seq_s, 'RELAY_SEQ_E':relay_seq_e}
			});
	
		} else if (whcd == '2000') { //용인센터
			rfn_reportLabel({
				title: '상품구매계약서(애터미)',
				jrfName: 'P200210_R_TRLIST_2000',
				args: {'COMPCD':compcd, 'ORGCD':orgcd, 'WHCD':whcd, 'REG_SEQ':reg_seq, 'RELAY_SEQ_S':relay_seq_s, 'RELAY_SEQ_E':relay_seq_e}
			});
		}
	}
}

/* 
 * 
 * 미사용 2018. 11. 16 양동근
 *거래내역서(개별)
function fn_tfprint_each(){

	var gridData1 = $('#grid1').gfn_getDataList();
	
	if(cfn_isEmpty(gridData1)){
		cfn_msg('WARNING', '원주문리스트가 존재하지않습니다.');
		return false;
	}
	
	var gridData = $('#grid2').gfn_getDataList();
	
	if(cfn_isEmpty(gridData)){
		cfn_msg('WARNING', '출고상세페이지가 존재하지않습니다.');
		return false;
	} 
	
	var compcd=$('#S_COMPCD').val();
	var orgcd=$('#S_ORGCD').val();
	var reg_seq=$('#S_REG_SEQ').val();
	var whcd=$('#S_WHCD').val();
	var relay_seq_s=$('#S_SMSTART').val();
	var relay_seq_e=$('#S_SMEND').val();
	var fileymd=$('#S_FILE_YMD').val();
	
	rfn_reportView({
		title: '상품구매계약서(개별)',
		jrfName: 'P200210_R09',
		args: {'COMPCD':compcd, 'WHCD':whcd, 'REG_SEQ':reg_seq, 'PRINTUSERNM':cfn_loginInfo().USERNM, 'RELAY_SEQ_S':relay_seq_s, 'RELAY_SEQ_E':relay_seq_e}
	});

} */

//등록증출력
function fn_memberprint(){
	var print2 = cfn_printInfo().PRINT2;
	var gridData1 = $('#grid1').gfn_getDataList();
	
	if (cfn_isEmpty(gridData1)) {
		cfn_msg('WARNING', '원주문리스트가 존재하지않습니다.');
		return false;
	}
	
	var gridData = $('#grid2').gfn_getDataList();
	
	if (cfn_isEmpty(gridData)) {
		cfn_msg('WARNING', '출고 전표가 존재하지 않습니다.');
		return false;
	} 
	
	fn_getInvcCNTAddrCNT(); //주소정재 CNT, 송장발번 CNT
	
	var addrCountYN = $('#ADDRYNCNT').val();
	var invcCountYN = $('#INVCYNCNT').val();
	
	if (addrCountYN != '0') {
		cfn_msg('WARNING', '주소정재 되지 않은 전표가 ' + addrCountYN +' 건 존재합니다.');
		return false;
	} else if(invcCountYN != '0') {
		cfn_msg('WARNING', '송장발번 되지 않은 전표가 ' + invcCountYN +' 건 존재합니다.');
		return false;
	}
	
	if (confirm('[프린터] : ' + print2 + '으로 출력합니다. 출력하시겠습니까?')) {

		var compcd=$('#S_COMPCD').val();
		var orgcd=$('#S_ORGCD').val();
		var whcd=$('#S_WHCD').val();
		var reg_seq=$('#S_REG_SEQ').val();
		var relay_seq_s=$('#S_BOOKSTART').val();
		var relay_seq_e=$('#S_BOOKEND').val();
		
		
		if (whcd == '4000' || whcd == '4290') { //안성센터
			rfn_reportLabelEtc({
				title: '애터미 회원 등록증',
				jrfName: 'P200210_R_BOOK_4000',
				args: {'COMPCD':compcd, 'ORGCD':orgcd, 'WHCD':whcd, 'REG_SEQ':reg_seq, 'RELAY_SEQ_S':relay_seq_s, 'RELAY_SEQ_E':relay_seq_e}
			});
		} else if(whcd == '2000') {
			rfn_reportLabelEtc({
				title: '애터미 회원 등록증',
				jrfName: 'P200210_R_BOOK_2000',
				args: {'COMPCD':compcd, 'ORGCD':orgcd, 'WHCD':whcd, 'REG_SEQ':reg_seq, 'RELAY_SEQ_S':relay_seq_s, 'RELAY_SEQ_E':relay_seq_e}
			});
		}
    }
}

//감사카드출력
function fn_cardprint(){
	var print2 = cfn_printInfo().PRINT2;
	var gridData1 = $('#grid1').gfn_getDataList();
	
	if (cfn_isEmpty(gridData1)) {
		cfn_msg('WARNING', '원주문리스트가 존재하지않습니다.');
		return false;
	}
	
	var gridData = $('#grid2').gfn_getDataList();
	
	if (cfn_isEmpty(gridData)) {
		cfn_msg('WARNING', '출고 전표가 존재하지 않습니다.');
		return false;
	} 
	
	fn_getInvcCNTAddrCNT(); //주소정재 CNT, 송장발번 CNT
	
	var addrCountYN = $('#ADDRYNCNT').val();
	var invcCountYN = $('#INVCYNCNT').val();
	
	if (addrCountYN != '0') {
		cfn_msg('WARNING', '주소정재 되지 않은 전표가 ' + addrCountYN +' 건 존재합니다.');
		return false;
	} else if(invcCountYN != '0') {
		cfn_msg('WARNING', '송장발번 되지 않은 전표가 ' + invcCountYN +' 건 존재합니다.');
		return false;
	}
	
	if (confirm('[프린터] : ' + print2 + '으로 출력합니다. 출력하시겠습니까?')) {

		var compcd=$('#S_COMPCD').val();
		var orgcd=$('#S_ORGCD').val();
		var whcd=$('#S_WHCD').val();
		var reg_seq=$('#S_REG_SEQ').val();
		

		if (whcd == '4000' || whcd == '4290') { //안성센터
			rfn_reportLabelEtc({
				title: '감사카드',
				jrfName: 'P200210_R_CARD_4000',
				args: {'COMPCD':compcd, 'ORGCD':orgcd, 'WHCD':whcd, 'REG_SEQ':reg_seq}
			});
		} else if(whcd == '2000') {
			rfn_reportLabelEtc({
				title: '감사카드',
				jrfName: 'P200210_R_CARD_2000',
				args: {'COMPCD':compcd, 'ORGCD':orgcd, 'WHCD':whcd, 'REG_SEQ':reg_seq}
			});
		}
	}
}

//기존데이터모두삭제
function ordercancel(){
	
	//검색조건 필수입력 체크
	if(cfn_isFormRequireData('frmSearch') == false) return;
	
	//날짜
	var fileymd=$('#S_FILE_YMD').val();
	var fileseq=$('#S_FILE_SEQ').val();
	//차수
	var msg='기존정보를 모두 삭제하며 복구될 수 없습니다.\n정말 삭제하시겠습니까? 날짜: '+fileymd+' ,차수: '+fileseq;
	if (confirm(msg)) {
		
		var param = cfn_getFormData('frmSearch');
		
		var sid = 'sid_setOrderCancel';
		var url = '/alexcloud/p200/p200210/setOrderCancel.do';
		var sendData = {'paramData':param};
		gfn_sendData(sid, url, sendData);	
	}
}



//헤더 바인딩
function fn_headbinding(data){
	for (var i=0, len=data.length; i<len; i++) {
		
		var headColumn=String(data[i].DB_COL_NM);
		var headNm=data[i].COL_NM;
		
		if (headColumn.length==1) {
			if(!cfn_isEmpty(headNm)){
				$('#grid1').gridView().setColumnProperty(headColumn,"header",{text:data[i].COL_NM});
			}
		} else {
			if(!cfn_isEmpty(headNm)){
				$('#grid1').gridView().setColumnProperty(headColumn,"header",{text:data[i].COL_NM});
			}
		}
	}
}
//행데이터 일괄변경
function gfn_setColumnEmpty(grid,colkey,val) {
	var gridData=$('#'+grid).gfn_getDataList();
	for (var i=0; i<gridData.length; i++) {
		$('#grid1').gfn_setValue(i, colkey, val);
	}
}

//주문서양식명 가져오기(SELECTBOX)
function fn_sitecd(){
	var orgcd = $('#S_ORGCD').val();
	var url = '/alexcloud/p000/p000022/getSiteCd.do';
	var sendData = {'paramData':{'COMPCD':cfn_loginInfo().COMPCD, 'ORGCD':orgcd}};
	
	gfn_ajax(url, false, sendData, function (data, xhr) {
		var list = data.resultList;
		var siteHtml = '';
		siteHtml = '<option value="">'+'선택'+'</option>';
		for (var i = 0; i<list.length; i++) {
			siteHtml += '<option value="'+list[i].CODE+'">'+list[i].VALUE+'</option>' 
		}
		$('#S_SITE_CD').html(siteHtml);	
	});

}

//에러체크 통합 버튼
function fn_chkerrmerge(){
	//검색조건 필수입력 체크
	if (cfn_isFormRequireData('frmSearch') == false) return;
	
	if (($('#S_STATUS_CD').val() != '00001')) {
		cfn_msg('WARNING', '이미 처리 된 차수입니다.');
		return false;
	}
	if (cfn_isEmpty($('#S_SITE_CD').val())) {
		cfn_msg('WARNING', '주문서양식을 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_WHCD').val())) {
		cfn_msg('WARNING', '창고를 입력해 주세요.');
		return false;
	}
	if (cfn_isEmpty($('#S_DELI_CD').val())) {
		cfn_msg('WARNING', '택배사를 입력해 주세요.');//
		return false;
	}
	
	var param = cfn_getFormData('frmSearch');
	var gridData = $('#grid1').gfn_getDataList();
	
	var sid = 'sid_setchkerrmerge';
	var url = '/alexcloud/p200/p200210/setchkerrmerge.do';
	var sendData = {'paramData':param,'gridData':gridData};
	gfn_sendData(sid, url, sendData);		
}

//택배사콤보박스 변경이벤트
function fn_deliChg(){
	var deliCD = $('#S_DELI_CD').val();
	
	if (deliCD === 'D0005') {
		$('#btn_upload18').insertAfter("#btn_upload19");
		$("#btn_upload19").css("margin-right", "5px");
	} else if(deliCD === 'D0004') {
		$('#btn_upload18').insertBefore("#btn_upload19");
		$("#btn_upload18").css("margin-right", "5px");
	}
}

//주문삭제(1행)
function fn_delOrderDtl() {
	var current = $('#grid1').gridView().getCurrent();
	var itemIndex = current.itemIndex;
	
	if (itemIndex < 0) {
		cfn_msg('WARNING', '선택된 데이터가 없습니다.');
		return false;
	}
	
	if ($('#S_STATUS_CD').val() != '00001') {
		cfn_msg('WARNING', '이미 처리 된 차수입니다.');
		return;
	}
	
	var c00 = $('#grid1').gfn_getValue(itemIndex, 'C00');
	var c02 = $('#grid1').gfn_getValue(itemIndex, 'C02');
	
	if (confirm("주문번호 [" + c02 + "] 를 정말 삭제하시겠습니까?")) {
		var param = cfn_getFormData('frmSearch');
		param.C00 = c00;
		
		var sid = 'sid_delOrderDtl';
		var url = '/alexcloud/p200/p200210/deleteOrderDtl.do';
		var sendData = {'paramData':param};
		gfn_sendData(sid, url, sendData);		
	}
}


//중복주문삭제
function fn_DelOrdNoDup(){
	//검색조건 필수입력 체크
	if (cfn_isFormRequireData('frmSearch') == false) return;
	
	if ($('#S_STATUS_CD').val() != '00001') {
		cfn_msg('WARNING', '이미 처리 된 차수입니다.');
		return;
	}
	
	if (confirm("중복주문이 삭제되어 복구할 수 없습니다.\n정말 삭제하시겠습니까?")) {
		
		var param = cfn_getFormData('frmSearch');
		
		var sid = 'sid_delOrdNoDup';
		var url = '/alexcloud/p200/p200210/deleteOrdNoDup.do';
		var sendData = {'paramData':param};
	
		gfn_sendData(sid, url, sendData);
	}
	
}

</script>

<c:import url="/comm/contentBottom.do" />
