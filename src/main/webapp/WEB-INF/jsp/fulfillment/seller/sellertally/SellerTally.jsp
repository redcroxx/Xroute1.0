<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.concurrent.ScheduledThreadPoolExecutor" %>
<%@page import="java.util.concurrent.TimeUnit" %>
<%@page import="xrt.alexcloud.common.CommonConst" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : StockInsert
	화면명 : 입고스캔
-->
<c:import url="/comm/contentTop.do" />

<!-- 검색 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<input type="hidden" id="COMP_FLG" class="cmc_txt" />
		<input type="hidden" id="ORD_CD" class="cmc_txt" />
		<input type="hidden" id="ORGCD" class="cmc_txt" />
		<input type="hidden" id="COMPCD" class="cmc_txt" />
		<input type="hidden" id="WGT_ST_CD" class="cmc_txt" />
		<ul class="sech_ul">
			<li class="sech_li required">
				<div style="width: 200px">XROUTE 송장번호</div>
				<div>
					<input type="text" style="width: 200px;" id="XRT_INVC_NO" class="cmc_code required" maxlength="13" onkeyup="fn_str_convert()" tabindex="-1" />
				</div>
			</li>
			<li class="sech_li">
				<div style="width: 120px">품목 바코드</div>
				<div>
					<input type="text" style="width: 200px;" id="GOODS_BARCODE" class="cmc_code" maxlength="13" onkeyup="fn_str_convert2()" />
				</div>
			</li>
		</ul>
	</form>
	<br>
	<!-- 송장 정보 -->
	<form id="frmSongjang" style="padding-left: 10px;" action="#" onsubmit="return false">
		<table>
			<tr>
				<th align="left" style="width: 130px">XROUTE송장번호</th>
				<td style="width: 200px"><span id='xrouteCd'></span></td>
				<th style="width: 130px">주문번호</th>
				<td style="width: 200px"><span id="lbOrdCd"></span></td>
				<th style="width: 130px">셀러 ID</th>
				<td style="width: 200px"><span id="lbOrgCd"></span></td>
			</tr>
			<tr>
				<th align="left" style="width: 130px">총수량 / 타입</th>
				<td style="width: 200px"><span id="lbOrdCntType"></span></td>
				<th style="width: 130px">도착 국가</th>
				<td style="width: 200px"><span id="lbENation"></span></td>
				<th style="width: 130px">오더등록일</th>
				<td style="width: 200px"><span id="lbUploadDate"></span></td>
				<th style="width: 100px"><div id="div_save1"><input type="button" class="cmb_normal_new cbtn_save" value="    미스캔 품목 수량 맞음" id="btn_matchcnt" onclick="cfn_matchcnt();" /></div></th>
				<th style="width: 2px">&nbsp;</th>
				<th style="width: 100px"><div id="div_save2"><input type="button" class="cmb_normal_new cbtn_save" value="    검수(출고)완료" id="btn_tallycomp" onclick="cfn_tallycomp();" /> </div></th>
				<th style="width: 2px">&nbsp;</th>
				<th style="width: 100px"><div id="div_save3"><input type="button" class="cmb_normal_new cbtn_save" value="    송장 스캔 재시작" onclick="cfn_scanrestart();" /> </div></th>
				<th style="width: 2px">&nbsp;</th>
			</tr>
		</table>
		<table>
			<tr>
				<th align="left" style="width: 130px">송화인 이름</th>
				<td style="width: 200px"><span id="shipName"></span></td>
				<th style="width: 130px">송화인 연락처</th>
				<td style="width: 200px"><span id="shipTell"></span></td>
				<th style="width: 130px">송화인 주소</th>
				<td style="width: 1000px"><span id="shipAddr"></span></td>
			</tr>
		</table>
		<table>
			<tr>
				<th align="left" style="width: 130px">수취인 이름</th>
				<td style="width: 200px"><span id="recvName"></span></td>
				<th style="width: 130px">수취인 연락처</th>
				<td style="width: 200px"><span id="recvTell"></span></td>
				<th style="width: 130px">수취인 주소</th>
				<td style="width: 1000px"><span id="recvAddr"></span></td>
			</tr>
		</table>
	</form>
		<!-- 송장정보 끝 -->
</div>

<!-- 그리드 시작 -->
<div class="ct_left_wrap fix" style="width:50%;">
	<div class="grid_top_wrap">
		<div class="grid_top_left">주문상품상세<span>(총 0건)</span></div>		
	</div>
	<div id="grid1"></div>
</div>
<div class="ct_right_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">품목 리스트<span>(총 0건)</span></div>	
	</div>
	<div id="grid2"></div>
</div>
<!-- 그리드 끝 -->

<script type="text/javascript">
	var scan = false;
	//초기 로드
	$(function() {
		//1. 화면레이아웃 지정 (리사이징) 
		initLayout();
		
		//2. 그리드 초기화
		grid1_Load();
		grid2_Load();
		$("#XRT_INVC_NO").focus(); 
		
		if(cfn_loginInfo().USERGROUP == '${SELLER_ADMIN}'){
			
			$('#sellerSelect').hide();
			$('#ORGCD').val(cfn_loginInfo().ORGCD);
			$("#COMPCD").val(cfn_loginInfo().COMPCD);
		}
		
	});

	var playAlert;
	
	function grid1_Load() {
		var gid = 'grid1';
		var columns = [
			{name : 'GOODS_CD', header : {text : '상품코드'}, width : 130},
			{name : 'GOODS_NM', header : {text : '상품명'}, width : 250},
			{name : 'GOODS_OPTION',header : {text : '상품옵션'},width : 300},
			{name : 'TYPE', header : {text : '구분'}, styles:{textAlignment:'center'}, width : 50},
			{name : 'ORD_CNT', header : {text : '수량'}, width : 55, styles:{textAlignment:'center',numberFormat:'#,##0'}, dataType:'number'}
		];

		//그리드 생성 (realgrid 써서)
		$('#' + gid).gfn_createGrid(columns, {
			footerflg : false
		});

		//그리드설정 및 이벤트처리
		$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
			// gridView.setStyles(basicBlackSkin);
			//열고정 설정
			gridView.setFixedOptions({
				colCount : 2,
				resizable : true,
				colBarWidth : 1
			});

		});
	}
	
	function grid2_Load() {
		var gid = 'grid2', $grid = $('#' + gid);
		var columns = [
			{name:'GOODS_CD',header:{text:'단품코드'},width:150},
			{name:'GOODS_NM',header:{text:'품목명'},width:300},
			{name:'GOODS_CNT',header:{text:'주문'},width:90,dataType:'number',styles:{textAlignment:'center',numberFormat:'#,##0'}},
			{name:'SCAN_CNT',header:{text:'스캔'},width:90,dataType:'number',styles:{textAlignment:'center',numberFormat:'#,##0'}},
			{name:'LACK_CNT',header:{text:'부족'},width:90,dataType:'number',styles:{textAlignment:'center',numberFormat:'#,##0'}},
			{name : 'ORD_SEQ', header : {text : 'ORD_SEQ'}, width : 80,	styles : {textAlignment : 'center'}, visible : false, show : false}
		];
		
		$grid.gfn_createGrid(columns,{mstGrid:'grid1', footerflg : false});
	}
	
	//한글 입력 -> 영문 변환
	function fn_str_convert(){
	
		var str = $('#XRT_INVC_NO').val();
		var convertStr = cfn_lngg_convert(str, 'eng');
		
		if (window.event.keyCode == 13 && str != '9999') {
			strVal = convertStr;
			$('#XRT_INVC_NO').val(convertStr.replace(/ /gi, ""));
			cfn_retrieve();
		}
	}	
	
	function fn_str_convert2(){
		
		var str = $('#GOODS_BARCODE').val();
		var convertStr = cfn_lngg_convert(str, 'eng');

		if (window.event.keyCode == 13 && str != '9999') {
			strVal = convertStr;
			$('#GOODS_BARCODE').val(convertStr.replace(/ /gi, ""));
			cfn_goods_retrieve();
			//console.log('test_goods');
			$('#GOODS_BARCODE').val('');
		} else if (str == "9999") {
			if (window.event.keyCode == 13) {
				cfn_tallycomp();
			}
		}
	}
	
	//공통버튼 - 검색 클릭
	function cfn_retrieve() {
		if(cfn_isFormRequireData('frmSearch') == false) return;
		
		var param = cfn_getFormData('frmSearch');
		var sid = 'sid_getSearch';
		var url = '/fulfillment/seller/sellerTally/getSearch.do';
		var sendData ={'paramData': param};
		gfn_sendData(sid, url, sendData, true);
		
		$("#alert").html('');
		$('#XRT_INVC_NO').val('');
	}
	
	//상품 바코드 검색
	function cfn_goods_retrieve() {
		$("#alert").html('');
		
		var compFlg = $('#COMP_FLG').val();
		if (window.event.keyCode == 13 && compFlg == 'Y' ) {
			cfn_msg('WARNING', '이미 검수처리가 완료된 송장입니다.');
			return false;
		}
				
		var param = cfn_getFormData('frmSearch');
		var sid = 'sid_getGoodsSearch';
		var url = '/fulfillment/seller/sellerTally/getGoodsSearch.do';
		var sendData ={'paramData': param};
		gfn_sendData(sid, url, sendData, true);
	}
	
	//미스캔 품목 수량 맞음
	function cfn_matchcnt() {
		$("#alert").html('');
		var param = cfn_getFormData('frmSearch');

		var sid = 'sid_setMatchCnt';
		var url = '/fulfillment/seller/sellerTally/setMatchCnt.do';
		var sendData ={'paramData': param};
		gfn_sendData(sid, url, sendData, true);
	}
	
	//검수(출고)완료
	function cfn_tallycomp() {
		$("#alert").html('');
		var param = cfn_getFormData('frmSearch');

		var sid = 'sid_setTallyComp';
		var url = '/fulfillment/seller/sellerTally/setTallyComp.do';
		var sendData ={'paramData': param};
		gfn_sendData(sid, url, sendData, true);
	}
	
	//송장 스캔 재시작
	function cfn_scanrestart() {
		window.location.reload();
	}
	
	//요청한 데이터 처리 callback
	function gfn_callback(sid, data) {
		//검색
		if (sid == 'sid_getSearch') {
			if (cfn_isEmpty(data)) {
				cfn_msg('WARNING', '검색결과가 존재하지 않습니다.');
				return false;
			}
			
			$('#grid1').gfn_setDataList(data.resultList);
			$('#grid2').gfn_setDataList(data.resultListDtl);
			$('#grid1').gfn_focusPK();
			$("#alert").html('');
			cfn_outPutData(data.resultData);
			
			// 검수처리를 한경우
			if (data.compFlg == 'Y') {
				$('#COMP_FLG').val('Y');
				$("#div_save1").css("display", "none");
				$("#div_save2").css("display", "none");	
			} else {
				$('#COMP_FLG').val('N');
				$("#div_save1").css("display", "block");
				$("#div_save2").css("display", "block");	
			}
			
			$("#GOODS_BARCODE").focus();
			
		// 상품검색	
		} else if (sid == 'sid_getGoodsSearch') {
			
			if (cfn_isEmpty(data)) {
				cfn_msg('WARNING', '검색결과가 존재하지 않습니다.');
				return false;
			}
			$('#grid2').gfn_setDataList(data.resultListDtl);
			$('#grid2').gfn_focusPK();
			$("#alert").html('');
			$("#GOODS_BARCODE").focus();
			
		// 미스캔품목 맞춤
		} else if (sid == 'sid_setMatchCnt') {
			if (cfn_isEmpty(data)) {
				cfn_msg('WARNING', '검색결과가 존재하지 않습니다.');
				return false;
			}
			$('#grid2').gfn_setDataList(data.resultList);
			$('#grid2').gfn_focusPK();
			$("#alert").html('');
			$("#GOODS_BARCODE").focus();
			
		// 검수(출고)완료
		} else if (sid == 'sid_setTallyComp') {
			if (cfn_isEmpty(data)) {
				cfn_msg('WARNING', '검색결과가 존재하지 않습니다.');
				return false;
			}
			window.location.reload();
		}
	}
	

	function cfn_outPutData(data) {
		
		if (data != null) {
			$('#ORD_CD').val(data.ORD_CD);			//오더넘버 Hid
			$('#xrouteCd').text(data.XRT_INVC_SNO);	//XROUTE송장번호
			$('#WGT_ST_CD').val(data.STATUS_CD);
			$('#ORGCD').val(data.ORGCD);			//셀러코드
			$('#COMPCD').val(data.COMPCD);			//회사코드
			
			var uploadDate = cfn_getDateFormat(data.UPLOAD_DATE, 'yyyy-MM-dd');
			
			$("#lbUploadDate").text(uploadDate);
			$("#lbOrgCd").text(data.ORGCD);
			$("#lbOrdCd").text(data.ORD_CD);
			$("#lbENation").text(data.E_NATION);
			$("#lbOrdCntType").text(data.ORD_CNT + " / " + data.SHIP_METHOD_CD);
			$("#shipName").text(data.SHIP_NAME);
			$("#shipTell").text(data.SHIP_TEL);
			$("#shipAddr").text(data.SHIP_ADDR);
			$("#recvName").text(data.RECV_NAME);
			$("#recvTell").text(data.RECV_TEL);
			$("#recvAddr").text(data.RECV_ADDR1 + ' ' + data.RECV_ADDR2);
		}
	}
</script>
<c:import url="/comm/contentBottom.do" />
