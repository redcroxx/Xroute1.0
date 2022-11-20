<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!--
화면코드 : Interfaces
화면명 : API에 사용할 사용자 별 특정 사이트 계정을 등록하는 화면.
-->
<!-- 고정탭 구분을 위한 체크 값-->
<c:import url="/comm/contentTop.do"/>

<div class="ct_top_wrap" style="background-color:#f3f3f3 !important;">
	<div>
		<div class="grid_top_wrap" style="margin-top:10px;"background-color:#f3f3f3 !important;>
			<div class="grid_top_left">Shopee</div>
			<div class="grid_top_right">
				<%-- ISD = Insert Shopee Data --%>
				<input type="button" id="btnISD" class="cmb_normal_new" value="저장" onclick="saveShoppData()" />
			</div>
		</div>
		<div style="background-color:#f3f3f3 !important;">
			<span style="margin:0 10px 0 10px">partner id : </span><input type="text" id="shopeePartnerId" value="${shopeeData.authId}" style="margin-right:10px;">
			<span style="margin:0 10px 0 10px">partner key : </span><input type="text" id="shopeePartnerKey" value="${shopeeData.authKey}" style="margin-right:10px;">
			<span style="margin:0 10px 0 10px">배송타입 : </span><input type="text" id="shopeeShipMethod" value="${shopeeData.shipMethod}" style="margin-right:10px;">
			<span style="margin:0 10px 0 10px">연락처 : </span><input type="text" id="shopeePhoneNumber" value="${shopeeData.phoneNumber}" style="margin-right:10px;"> <br />
			<span style="margin:0 10px 0 10px">우편번호 : </span><input type="text" id="shopeePost" value="${shopeeData.post}" style="margin-right:10px;">
			<span style="margin:0 10px 0 10px">한글 주소 : </span><input type="text" id="shopeeKoAddrress" value="${shopeeData.koAddress}" style="margin-right:10px;">
			<span style="margin:0 10px 0 10px">영문 주소 : </span><input type="text" id="shopeeEnAddrress" value="${shopeeData.enAddress}" style="margin-right:10px;">

			<ul id="countryList">
				<c:if test="${fn:length(shopeeList) == 0}">
					<li style="margin: 0 0 15px 0;">
						<span style="margin:0 10px 0 10px">국가 : </span>
						<select name="countryBox" style="width: 100px;">
							<option selected="selected" value="">--선택--</option>
							<c:forEach var="i" items="${shopeeCountry}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>
						<span style="margin:0 10px 0 10px">shop id : </span> <input type="text" name="shopId" value="" style="margin-right:10px;">
							<%-- ISD = Add Shopee Etc Data --%>
						<input type="button" name="btnAHED" value="추가" style="background:#f3f3f3 url('/images/icon_topnew.png') 3px 2px no-repeat; background-size:18px auto;padding-left:24px;min-width:60px;" onclick="addShopeeEtcData();" />
							<%-- ISD = Delete Shopee Etc Data --%>
						<input type="button" name="btnDHED" value="삭제" style="background:#f3f3f3 url('/images/icon_topdel.png') 3px 2px no-repeat; background-size:18px auto;padding-left:24px;min-width:60px;" data="" onclick="deleteShopeeEtcData(this);" />
					</li>
				</c:if>
				<c:forEach var="i" items="${shopeeList}">
					<li style="margin: 0 0 15px 0;">
						<span style="margin:0 10px 0 10px">국가 : </span>
						<select name="countryBox" style="width: 100px;">
							<option selected="selected" value="">--선택--</option>

							<c:forEach var="j" items="${shopeeCountry}">
								<c:if test="${i.mappingKey == j.code}">
									<option value="${j.code}" selected="selected">${j.value}</option>
								</c:if>
								<c:if test="${i.mappingKey != j.code}">
									<option value="${j.code}">${j.value}</option>
								</c:if>
							</c:forEach>
						</select>
						<span style="margin:0 10px 0 10px">shop id : </span> <input type="text" name="shopId" value="${i.etcKey}" style="margin-right:10px;">
							<%-- ISD = Add Shopee Etc Data --%>
						<input type="button" name="btnAHED" value="추가" style="background:#f3f3f3 url('/images/icon_topnew.png') 3px 2px no-repeat; background-size:18px auto;padding-left:24px;min-width:60px;" onclick="addShopeeEtcData();" />
							<%-- ISD = Delete Shopee Etc Data --%>
						<input type="button" name="btnDHED" value="삭제" style="background:#f3f3f3 url('/images/icon_topdel.png') 3px 2px no-repeat; background-size:18px auto;padding-left:24px;min-width:60px;" data="${i.interfaceDtlSeq}" onclick="deleteShopeeEtcData(this);" />
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>

<script type="text/javascript">

	function addShopeeEtcData() {
		let countryList = $("#countryList");
		let liElemnt = countryList.find("li");
		let listCount = liElemnt.length;
		if (listCount > 7) {
			alert("Shopee shop id를 추가 할 수 없습니다.");
			return;
		}

		countryList.append(liElemnt.eq(0).clone());
		countryList.find("li:last-child").children("input[name='btnDHED']").attr("data", "");
		countryList.find("li:last-child").children("select[name='countryBox']").val("");
		countryList.find("li:last-child").children("input[name='shopId']").val("");
	}

	function deleteShopeeEtcData(elemt) {
		if (confirm("정말로 삭제 하시겠습니까?") == false) return;

		let countryList = $("#countryList");
		let liElemnt = countryList.find("li");
		let listCount = liElemnt.length;

		if (listCount == 1) {
			alert("더이상 삭제 할 수 없습니다.");
			return;
		}

		let shopeeObj = {};
		let countryBox = $(elemt).parents("li").find("select[name='countryBox']").val();
		let shopId = $(elemt).parents("li").find("input[name='shopId']").val();
		let seq = $(elemt).parents("li").find("input[name='btnDHED']").attr("data");

		console.log("seq : ", seq);

		if (countryBox == "" || shopId == "" && seq == "") {
			if (confirm('shop id 또는 국가가 선택되지 않았습니다. 진행하시겠습니까?') == false) return;
			$(elemt).parents("li").remove();
			return;
		}

		shopeeObj.interfaceDtlSeq = seq;

		$.ajax({
			url : "/interfaceSettings/shopee/delete.do",
			contentType : "application/json",
			method : "POST",
			dataType : "json",
			data : JSON.stringify(shopeeObj),
			success : function(result) {
				let code = result.code;
				let message = result.message;

				alert(message);
				if (code == "200") {
					$(elemt).parents("li").remove();
				}
			},
			error : function(result) {
				console.log("error result : ", result);
			}
		});
	}

	function saveShoppData() {
		if (confirm("정말로 수정 하시겠습니까?") == false) return;

		let shopeeObj = {};
		let etcDataList = [];
		let shopId = $("input[name='shopId']");
		let countryBox = $("select[name='countryBox']");
		let dhed = $("input[name='btnDHED']");

		console.log('countryBoxValue -- '+countryBox);
		for (let i=0; i<shopId.size(); i++) {
			console.log("shopId : "+ shopId.eq(i).val()||"");
			console.log("countryBox : "+ countryBox.eq(i).val()||"");
			let etcData = {};
			etcData.shopId = shopId.eq(i).val()||"";
			etcData.country = countryBox.eq(i).val()||"";
			etcData.seq = dhed.eq(i).attr("data")||0;
			
			if (etcData.shopId == "" || etcData.country == "") {
				if (confirm('shop id 또는 국가가 선택되지 않았습니다. 진행하시겠습니까?') == false) return;
			}

			etcDataList.push(etcData);
			
		}

		// 20200130 국가 중복체크 추가 최일규
		for(var j=0;j<etcDataList.length;j++){
			for(var k=j+1;k<etcDataList.length;k++){
				var j_country = etcDataList[j].country;
				var k_country = etcDataList[k].country;
				if (j_country == k_country){
					alert('중복된 국가가 존재합니다.');
					return;
				}
			}
		}
		
		shopeeObj.partnerId = $("#shopeePartnerId").val()||"";
		shopeeObj.partnerKey = $("#shopeePartnerKey").val()||"";
		shopeeObj.shipMethod = $("#shopeeShipMethod").val()||"";
		shopeeObj.phoneNumber = $("#shopeePhoneNumber").val()||"";
		shopeeObj.post = $("#shopeePost").val()||"";
		shopeeObj.koAddress = $("#shopeeKoAddrress").val()||"";
		shopeeObj.enAddress = $("#shopeeEnAddrress").val()||"";
		shopeeObj.interfaceType = "SHOPEE";
		shopeeObj.etcData = etcDataList;

		$.ajax({
			url : "/interfaceSettings/shopee/save.do",
			contentType : "application/json",
			method : "POST",
			dataType : "json",
			data : JSON.stringify(shopeeObj),
			success : function(result) {
				let code = result.code;
				let message = result.message;

				alert(message);
			},
			error : function(result) {
				console.log("error result  : ", result);
			}
		});
	}

</script>
<c:import url="/comm/contentBottom.do" />
