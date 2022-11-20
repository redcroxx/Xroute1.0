<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/comm/contentTop.do">
</c:import>
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<ul class="sech_ul">
			<li class="sech_li widpx600">
				<div>기간</div>
				<div class="widpx400">
					<select id="sPeriodType" style="width: 100px;">
						<c:forEach var="i" items="${periodType}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
					<input type="text" id="sToDate" class="cmc_date periods" /> ~ 
					<input type="text" id="sFromDate" class="cmc_date periode" />
				</div>
			</li>
			<li class="sech_li">
				<div>셀러</div>
				<div>
					<input type="text" id="sOrgCd" class="cmc_code" /> <input
						type="text" id="sOrgNm" class="cmc_value" />
					<button type="button" class="cmc_cdsearch"></button>
				</div>
			</li>
		</ul>
		<ul class="sech_ul">
			<li class="sech_li widpx600">
				<div>검색어</div>
				<div class="widpx400">
					<select id="sKeywordType" style="width: 100px;">
						<option selected="selected" value="total">--전체--</option>
						<c:forEach var="i" items="${shippingkeyword}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select> <input type="text" id="sKeyword" class="cmc_code" style="width : 218px;" />
				</div>
			</li>
			
			<li class="sech_li">
				<div>배송업체</div>
				<div>
					<select id="sShipCompany" style="width: 100px;">
						<option selected="selected" value="total">--전체--</option>
						<c:forEach var="i" items="${shipcompanylist}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
		</ul>
	</form>
</div>
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">정산조회결과<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<form id="frmPriceSearch" action="#" onsubmit="return false">
			<input type="text" id="shipToDate" class="cmc_date periods" /> ~ <input type="text" id="shipFromDate" class="cmc_date periode" />
			<select id="shipCompany" style="width: 100px;">
				<option value="EFS">EFS</option>
				<option value="ETOMARS">ETOMARS</option>
				<option value="QXPRESS">QXPRESS</option>
			</select>		
			<input type="button" id="btn_upload" class="cmb_normal" value="업체별 판매가갱신" onclick="pfn_shipprice('test');" />
			</form>
		</div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->

<script type="text/javascript">
	//초기 로드
	$(function() {
		initLayout();
		// 2. 기초검색 조건 설정
		reset_Search();
		
		// 3. 그리드 초기화
		grid1_Load();
		// 4. 셀러 팝업 설정
		pfn_codeval({
			url : '/alexcloud/popup/popP002/view.do',
			codeid : 'sOrgCd',
			inparam : {S_COMPCD : 'S_COMPCD', S_ORGCD : 'S_ORGCD'},
			outparam : {ORGCD : 'sOrgCd', NAME : 'sOrgNm'}
		});
	});

	function reset_Search() {
		$('#sToDate').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
		$('#sFromDate').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
		$('#shipToDate').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));
		$('#shipFromDate').val(cfn_getDateFormat(new Date(), 'yyyy-MM-dd'));

		var compcd = '<c:out value="${sessionScope.loginVO.compcd}" />';
		var usergroup = '<c:out value="${sessionScope.loginVO.usergroup}" />';
		var sellerGroup = '<c:out value="${constMap.SELLER_ADMIN}" />';

		if (usergroup > sellerGroup) {
			$('#sOrgCd').val('<c:out value="${sessionScope.loginVO.orgcd}" />');
			$('#sOrgNm').val('<c:out value="${sessionScope.loginVO.orgnm}" />');
			$('#sOrgCd').removeClass('disabled').prop({'readonly' : false, 'disabled' : false});
			$('#sOrgNm').removeClass('disabled').prop({ 'readonly' : false, 'disabled' : false});
			$('#sOrgNm').next().removeClass('disabled').prop({'readonly' : false, 'disabled' : false});
		} else if (usergroup <= sellerGroup) {
			$('#sOrgCd').val('<c:out value="${sessionScope.loginVO.orgcd}" />');
			$('#sOrgNm').val('<c:out value="${sessionScope.loginVO.orgnm}" />');
			$('#sOrgCd').addClass('disabled').prop({'readonly' : true, 'disabled' : true});
			$('#sOrgNm').addClass('disabled').prop({'readonly' : true, 'disabled' : true});
			$('#sOrgNm').next().addClass('disabled').prop({'readonly' : true, 'disabled' : true});
		}
	}

	function grid1_Load() {
		var gid = 'grid1';
		var columns = [
			{name : 'orgcd', header : {text : '셀러코드'}, styles:{textAlignment:'center'}, width : 80, editable : false, editor : {maxLength : 80}},
			{name : 'mallNm', header : {text : '쇼핑몰'}, styles:{textAlignment:'center'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'sellerName', header : {text : '셀러명'}, styles:{textAlignment:'center'}, width : 100, editable : false, editor : {maxLength : 200}},
			{name : 'xrtInvcSno', header : {text : '송장번호'}, styles:{textAlignment:'center'}, width : 150, editable : false, editor : {maxLength : 150}},
			{name : 'invcSno1', header : {text : '배송No1'}, width : 200, editable : false, editor : {maxLength : 200}},
			{name : 'invcSno2', header : {text : '배송No2'}, width : 200, editable : false, editor : {maxLength : 200}},
			{name : 'uploadDate', header : {text : '업로드 일자'}, styles:{textAlignment:'center'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'shipMethodCd', header : {text : '서비스 타입'}, styles:{textAlignment:'center'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'localShipper', header : {text : '현지 배송사'}, styles:{textAlignment:'center'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'sNation', header : {text : '출발국가'}, styles:{textAlignment:'center'}, width : 70, editable : false, editor : {maxLength : 70}},
			{name : 'eNation', header : {text : '도착국가'}, styles:{textAlignment:'center'}, width : 70, editable : false, editor : {maxLength : 70}},
			{name : 'xrtShippingPrice', header:{text:'XRT 판매가 (KRW)'}, width:120,dataType:'number', styles:{textAlignment:'far', numberFormat:'#,##0'}, footer:{styles:{textAlignment:'far',numberFormat:'#,##0'},text:'0',expression:'sum',groupExpression:'sum'}},
			{name : 'cShippingPrice', header:{text:'업체 판매가'}, width:100, editable : false, styles:{textAlignment:'far',numberFormat:'#,##0'}, editor:{maxLength:11}},
			{name : 'cShippingPriceUnit', header : {text : '업체판매가 단위'}, styles:{textAlignment:'center'}, width : 120, editable : false, editor : {maxLength : 120}},
			{name : 'recvName', header : {text : '수화인명'}, width : 150, editable : false, editor : {maxLength : 150}},
			{name : 'recvTel', header : {text : '수화인 전화번호'}, width : 130, editable : false, editor : {maxLength : 130}},
			{name : 'recvMobile', header : {text : '수화인 핸드폰 번호'}, width : 130, editable : false, editor : {maxLength : 130}},
			{name : 'recvAddr1', header : {text : '수화인 주소1'}, width : 200, editable : false, editor : {maxLength : 200}},
			{name : 'recvAddr2', header : {text : '수화인 주소2'}, width : 200, editable : false, editor : {maxLength : 200}},
			{name : 'recvPost', header : {text : '수화인 우편번호'}, width : 150, editable : false, editor : {maxLength : 150}},
			{name : 'recvCity', header : {text : '수화인 도시'}, width : 150, editable : false, editor : {maxLength : 150}},
			{name : 'recvState', header : {text : '수화인 주(State)'}, width : 120, editable : false, editor : {maxLength : 120}},
			{name : 'recvCurrency', header : {text : '통화'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'ordCnt', header : {text : '주문수량'}, styles:{textAlignment:'center'}, width : 30, editable : false, editor : {maxLength : 30}},
			{name : 'ordNo', header : {text : '주문번호'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'cartNo', header : {text : '장바구니 번호'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'goodsCd', header : {text : '상품번호'}, width : 150, editable : false, editor : {maxLength : 150}},
			{name : 'goodsNm', header : {text : '상품명'}, width : 200, editable : false, editor : {maxLength : 200}},
			{name : 'goodsOption', header : {text : '상품옵션'}, width : 200, editable : false, editor : {maxLength : 200}},
			{name : 'goodsCnt', header : {text : '상품수량'}, styles:{textAlignment:'center'}, width : 60, editable : false, editor : {maxLength : 60}},
			{name : 'totPaymentPrice', header : {text : '구매자 결제금액'}, width : 100, editable : false, styles:{textAlignment:'far', numberFormat:'#,##0'}, editor:{maxLength:11}},
			{name : 'statusCd', header : {text : '배송상태'}, styles:{textAlignment:'center'}, width : 60, editable : false, editor : {maxLength : 60}},
			{name : 'cWgtCharge', header : {text : '실제 과금 중량(Kg)'}, styles:{textAlignment:'center'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'cWgtReal', header : {text : '실제 중량(Kg)'}, styles:{textAlignment:'center'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'cBoxWidth', header : {text : '실제 가로(cm)'}, styles:{textAlignment:'center'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'cBoxLength', header : {text : '실제 세로(cm)'}, styles:{textAlignment:'center'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'cBoxHeight', header : {text : '실제 높이(cm)'}, styles:{textAlignment:'center'}, width : 100, editable : false, editor : {maxLength : 100}},
			{name : 'xWgt', header : {text : 'XROUTE_중량(Kg)'}, styles:{textAlignment:'center'}, width : 110, editable : false, editor : {maxLength : 100}},
			{name : 'xBoxWidth', header : {text : 'XROUTE_가로(cm)'}, styles:{textAlignment:'center'}, width : 110, editable : false, editor : {maxLength : 100}},
			{name : 'xBoxLength', header : {text : 'XROUTE_세로(cm)'}, styles:{textAlignment:'center'}, width : 110, editable : false, editor : {maxLength : 100}},
			{name : 'xBoxHeight', header : {text : 'XROUTE_높이(cm)'}, styles:{textAlignment:'center'}, width : 110, editable : false, editor : {maxLength : 100}},
			{name : 'upddatetime', header : {text : '날짜/시간'}, styles:{textAlignment:'center'}, width : 180, editable : false, editor : {maxLength : 180}},
			{name : 'shipName', header : {text : '송화인'}, width : 100, editable : false, editor : {maxLength : 100}}
		];

		//그리드 생성 (realgrid 써서)
		$('#' + gid).gfn_createGrid(columns, {
			cmenuGroupflg:false,
			cmenuColChangeflg:false,
			cmenuColSaveflg:false,
			cmenuColInitflg:false
		});

		//그리드설정 및 이벤트처리
		$('#' + gid).gfn_setGridEvent(
			function(gridView, dataProvider) {
				//gridView.setStyles(basicBlackSkin);
				//열고정 설정
				gridView.setFixedOptions({colCount : 3, resizable : true, colBarWidth : 1});
			}
		);
	}
	
	//요청한 데이터 처리 callback
	function gfn_callback(sid, data) {
		//검색
		if (sid == 'sid_getSearch') {
			$('#grid1').gfn_setDataList(data.resultList);
			$('#grid1').gfn_focusPK();
		} else if (sid == 'sid_getPriceSearch') {
			cfn_msg('WARNING', '업체별 판매가를 갱신했습니다.');
			$('#grid1').gfn_setDataList(data.resultList);
			$('#grid1').gfn_focusPK();
			return false;
		}
	}
	
	//공통버튼 - 검색 클릭
	function cfn_retrieve() {
		$('#grid1').gridView().cancel();
		gv_searchData = cfn_getFormData('frmSearch');

		var sid = 'sid_getSearch';
		var url = '/fulfillment/settlement/settlementList/getSearch.do';
		var sendData = gv_searchData;

		gfn_sendData(sid, url, sendData, true);
	}
	
	//공통버튼 - 초기화
	function cfn_init() {
		reset_Search();
	}
	
	/**
	 * 업로드 팝업
	 * @param {string} pgmid : 프로그램ID
	 */
	function pfn_shipprice(pgmid){
		$('#grid1').gridView().cancel();
		gv_searchData = cfn_getFormData('frmPriceSearch');

		var sid = 'sid_getPriceSearch';
		var url = '/fulfillment/settlement/settlementList/getPriceSearch.do';
		var sendData = gv_searchData;

		gfn_sendData(sid, url, sendData, true);
	}
</script>

<c:import url="/comm/contentBottom.do" />