<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
화면코드 : SHOPEEORDERLIST
화면명 : 쇼피오더리스트
-->

<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
	<form id="frmSearch" action="#" onsubmit="return false">
		<ul class="sech_ul">
			<li class="sech_li widpx600">
				<div>일자</div>
				<div class="widpx400">
					<input type="text" id="sToDate" class="cmc_date periods" />
				</div>
			</li>
			<li class="sech_li">
				<div>건수</div>
				<div>
					<select id="sCount" style="width: 100px;">
						<option value="">- 선택 -</option>
						<option value="100">100</option>
						<option value="200">200</option>
						<option value="300">300</option>
						<option value="400">400</option>
						<option value="500">500</option>
						<option value="600">600</option>
						<option value="700">700</option>
						<option value="800">800</option>
						<option value="900">900</option>
						<option value="1000">1000</option>
					</select>
				</div>
			</li>
		</ul>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>국가</div>
				<div class="widpx400">
					<select id="sCountry" style="width: 100px;">
						<option selected="selected" value="">--선택--</option>
						<c:forEach var="i" items="${shopeeCountry}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select>
				</div>
			</li>
		</ul>
	</form>
</div>
<!-- 검색 끝 -->

<!-- 그리드 시작 -->
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">쇼피 오더목록<span>(총 0건)</span></div>
		<div class="grid_top_right">
			<input type="button" id="getOrderList" class="cmb_normal_new" value="주문정보 가져오기" onclick="getOrderList()" />
			<input type="button" id="insertOrder" class="cmb_normal_new" value="주문정보 저장" onclick="insertOrder()" />
			<input type="button" id="getInvoicNumber" class="cmb_normal_new" value="송장번호 발급" onclick="getInvoicNumber()" />
		</div>
	</div>
	<div id="grid1"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
	//초기 로드
	$(function() {
		// 1. 화면레이아웃 지정 (리사이징)
		initLayout();
		// 2. 그리드 초기화
		grid1_Load();
		// 3. 기초검색 조건 설정
		cfn_init();
	});
	// 초기화
	function cfn_init() {
		$("#grid1").gfn_clearData();

		$("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
		$("#sCount").val("");
		$("#sCountry").val("");
	}
	// 그리드 생성
	function grid1_Load() {
		let gid = 'grid1';
		let columns = [
			{name: "ordersn", header: {text: "오더번호"}, styles: {textAlignment: "center"}, width: 150, editable: false, editor: {maxLength: 80}},
			{name: "regYn", header: {text: "XROUTE 오더등록여부"}, styles: {textAlignment: "center"}, width: 150, editable: false, editor: {maxLength: 80}},
			{name: "trackingNo", header: {text: "송장번호"}, styles: {textAlignment: "center"}, width: 150, editable: false, editor: {maxLength: 80}},
			{name: "orderStatus", header: {text: "주문상태"}, styles: {textAlignment: "center"}, width: 150, editable: false, editor: {maxLength: 80}},
			{name: "currency", header: {text: "통화"}, styles: {textAlignment: "center"}, width: 60, editable: false, editor: {maxLength: 80}},
			{name: "totalAmount", header: {text: "전체금액"}, styles: {textAlignment: "center"}, width: 80, editable: false, editor: {maxLength: 80}},
			{name: "recvName", header: {text: "수취인 이름"}, styles: {textAlignment: "center"}, width: 150, editable: false, editor: {maxLength: 80}},
			{name: "recvCountry", header: {text: "수취인 국가"}, styles: {textAlignment: "center"}, width: 80, editable: false, editor: {maxLength: 80}},
			{name: "recvZipcode", header: {text: "수취인 우편번호"}, styles: {textAlignment: "center"}, width: 150, editable: false, editor: {maxLength: 80}},
			{name: "recvCity", header: {text: "수취인 도시"}, styles: {textAlignment: "center"}, width: 150, editable: false, editor: {maxLength: 80}},
			{name: "recvTown", header: {text: "수취인 마을"}, styles: {textAlignment: "center"}, width: 150, editable: false, editor: {maxLength: 80}},
			{name: "recvFullAddress", header: {text: "수취인 전체 주소"}, styles: {textAlignment: "left"}, width: 500, editable: false, editor: {maxLength: 80}}
		];

		//그리드 생성 (realgrid 써서)
		$('#' + gid).gfn_createGrid(columns, {
			footerflg: false,
			cmenuGroupflg: false,
			cmenuColChangeflg: false,
			cmenuColSaveflg: false,
			cmenuColInitflg: false
		});

		//그리드설정 및 이벤트처리
		$('#' + gid).gfn_setGridEvent(
			function(gridView, dataProvider) {
				//gridView.setStyles(basicBlackSkin);
				//열고정 설정
				gridView.setFixedOptions({
					colCount: 3,
					resizable: true,
					colBarWidth: 1
				});
			}
		);
	}
	//요청한 데이터 처리 callback
	function gfn_callback(sid, data) {
		//검색
		if (sid == 'sid_getSearch') {
			$('#grid1').gfn_setDataList(data.resultList);
			$('#grid1').gfn_focusPK();
		}
	}
	//공통버튼 - 검색 클릭
	function cfn_retrieve() {

		$("#grid1").gridView().cancel();

		// 검색 조건 확인
		if (searchValid() == false) {
			return;
		}

		let jsonObj = {};
		jsonObj.sToDate = $("#sToDate").val()||"";
		jsonObj.sCountry = $("#sCountry").val()||"";
		jsonObj.sCount = $("#sCount").val()||"";

		let sid = "sid_getSearch";
		let url = "/interfaceShopee/getSearch.do";
		let sendData = jsonObj;

		gfn_sendData(sid, url, sendData, true);
	}
	// Shopp 오더정보 가져오기
	function getOrderList() {
		// 쇼피정보 호출 확인
		if (!confirm("쇼피 정보를 가져오겠습니까?")) {
			return;
		}
		// 검색 조건 확인
		if (searchValid() == false) {
			return;
		}

		let jsonObj = {};
		jsonObj.sToDate = $("#sToDate").val()||"";
		jsonObj.sCountry = $("#sCountry").val()||"";
		jsonObj.sCount = $("#sCount").val()||"";

		let data = jsonObj;

		$.ajax({
			url : "/interfaceShopee/getShopeeOrderList.do",
			contentType : "application/json",
			method : "POST",
			dataType : "json",
			data : JSON.stringify(data),
			beforeSend: function(request) {
				$('body').css('cursor','wait');
				loadingStart();
			},
			success : function(result) {
				console.log("result : "+ result);

				loadingEnd();
				$('body').css('cursor','default');

				if (result.code == "200") {
					$("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
					cfn_retrieve();
				} else {
					cfn_msg('ERROR', '에러코드 : ' + result.code + '\n에러메시지 :\n' + result.message);
				}
			},
			error: function(xhr, status, error){
				sendcode = xhr.status;
				sendmsg = error;
			},
			complete: function(xhr, status) {

				sendcode = xhr.status;
				sendmsg = error;

				if (sendcode == '991') {
					loadingEnd();
					$('body').css('cursor','default');
					// 세션 만료시 로그인 이동
					parent.location.href = '/comm/login.do';
				} else if (sendcode != '200') {
					loadingEnd();
					$('body').css('cursor','default');
					cfn_msg('ERROR', '에러코드 : ' + sendcode + '\n에러메시지 :\n' + sendmsg);
				}
			}
		});
	}
	// 쇼피정보, xroute order 저장
	function insertOrder() {
		// 쇼피정보 호출 확인
		if (!confirm("쇼피 정보를 엑스루트에 저장하시곘습니까?")) {
			return;
		}
		// 검색 조건 확인
		if (searchValid() == false) {
			return;
		}

		let jsonObj = {};
		jsonObj.sToDate = $("#sToDate").val()||"";
		jsonObj.sFromDate = $("#sFromDate").val()||"";
		jsonObj.sCountry = $("#sCountry").val()||"";
		jsonObj.sCount = $("#sCount").val()||"";

		let data = jsonObj;

		$.ajax({
			url : "/interfaceShopee/save.do",
			contentType : "application/json",
			method : "POST",
			dataType : "json",
			data : JSON.stringify(data),
			beforeSend: function(request) {
				$('body').css('cursor','wait');
				loadingStart();
			},
			success : function(result) {
				console.log("result : "+ result);

				loadingEnd();
				$('body').css('cursor','default');

				if (result.code == "200") {
					cfn_msg('info', result.message);
				} else {
					cfn_msg('ERROR', '에러코드 : ' + result.code + '\n에러메시지 :\n' + result.message);
				}
			},
			error: function(xhr, status, error){
				sendcode = xhr.status;
				sendmsg = error;
			},
			complete: function(xhr, status) {

				sendcode = xhr.status;
				sendmsg = error;

				if (sendcode == '991') {
					loadingEnd();
					$('body').css('cursor','default');
					// 세션 만료시 로그인 이동
					parent.location.href = '/comm/login.do';
				} else if (sendcode != '200') {
					loadingEnd();
					$('body').css('cursor','default');
					cfn_msg('ERROR', '에러코드 : ' + sendcode + '\n에러메시지 :\n' + sendmsg);
				}
			}
		});
	}
	// 배송정보 호출
	function getInvoicNumber() {
		// 쇼피정보 호출 확인
		if (!confirm("배송정보를 가져오시겠습니까?")) {
			return;
		}

		let jsonObj = {};
		let data = jsonObj;

		$.ajax({
			url : "/interfaceShopee/getInvoicNumber.do",
			contentType : "application/json",
			method : "POST",
			dataType : "json",
			data : JSON.stringify(data),
			beforeSend: function(request) {
				$('body').css('cursor','wait');
				loadingStart();
			},
			success : function(result) {
				console.log("result : "+ result);

				loadingEnd();
				$('body').css('cursor','default');

				if (result.code == "200") {
					cfn_msg('info', result.message);
				} else {
					cfn_msg('ERROR', '에러코드 : ' + result.code + '\n에러메시지 :\n' + result.message);
				}
			},
			error: function(xhr, status, error){
				sendcode = xhr.status;
				sendmsg = error;
			},
			complete: function(xhr, status) {

				sendcode = xhr.status;
				sendmsg = error;

				if (sendcode == '991') {
					loadingEnd();
					$('body').css('cursor','default');
					// 세션 만료시 로그인 이동
					parent.location.href = '/comm/login.do';
				} else if (sendcode != '200') {
					loadingEnd();
					$('body').css('cursor','default');
					cfn_msg('ERROR', '에러코드 : ' + sendcode + '\n에러메시지 :\n' + sendmsg);
				}
			}
		});
	}
	// 조회 또는 쇼피정보 호출가 조건 체크
	function searchValid() {

		let sToDate = $("#sToDate").val()||"";
		let sCount = $("#sCount").val()||"";
		let sCountry = $("#sCountry").val()||"";

		if (sToDate == "") {
			alert("시작일자를 선택하세요.");
			$("#sToDate").focus();
			return false;
		}

		if (sCount == "") {
			alert("건수를 선택하세요.");
			$("#sCount").focus();
			return false;
		}

		if (sCountry == "") {
			alert("국가를 선택하세요.");
			$("#sCountry").focus();
			return false;
		}

		return true;
	}
</script>

<c:import url="/comm/contentBottom.do" />
