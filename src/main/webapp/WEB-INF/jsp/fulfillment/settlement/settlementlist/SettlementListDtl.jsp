<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="SettlementListDtl" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_search_shippinglistdtl" action="#" onsubmit="return false">
		<p id="lbl_name">배송조회</p>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>송장번호</div>
				<div><input style="width: 240px;" type="text" id="xrtInvcSno" /></div>
			</li>
			<li>
				<div><input type="button" id="btn_upload" class="cmb_normal" value="검색" onclick="shippingListDtlGetSearch()" /></div>
			</li>
		</ul>
		<ul class="sech_ul">
			<li class="sech_li">
				<div>송화인명</div>
				<div><label id="shipName"></label></div>
			</li>
			<li class="sech_li">
				<div>수화인명</div>
				<div><label id="recvName"></label></div>
			</li>
		</ul>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<!-- 그리드 시작 -->
	<div class="ct_top_wrap">
		<div class="ct_top_wrap fix botfix" style="height: 40px">
			<div id="grid1"></div>
		</div>
	</div>
	<!-- 그리드 끝 -->
</div>
<script type="text/javascript">
var _INVNO = {};

$(function() {
	$('#ShippingListDtl').lingoPopup({
		title : '배송조회',
		width : 850,
		height : 700,
		buttons : {
			'취소' : {text : '닫기', 
			click : function() {
				$(this).lingoPopup('setData', '');
				$(this).lingoPopup('close', 'CANCEL');
				}
			}
		},
		open : function(data) {
			$("#shipName").text(data.shipName);
			$("#recvName").text(data.recvName);
			$("#xrtInvcSno").val(data.xrtInvcSno);
			
			grid1_Load();
			shippingListDtlGetSearch();
		}
	});
});

/* 검색 */
function shippingListDtlGetSearch() {

	if ($("#xrtInvcSno").val() == "" || $("#xrtInvcSno").val() === undefined || $("#xrtInvcSno").val() == "undefined") {
		return;
	}
	
	var url = '/fulfillment/order/shippingListDtl/getSearch.do';
	var sendData = {};
	sendData.xrtInvcSno = $("#xrtInvcSno").val();
	
	gfn_ajax(url, true, sendData, function(data, xhr) {
		console.log(data, data.resultList);
		if (cfn_isEmpty(data.resultList)) {
			cfn_msg('WARNING', '검색결과가 존재하지 않습니다.');
			return false;
		}
	
		$('#grid1').gfn_setDataList(data.resultList);
	});
}

function grid1_Load() {
	var gid = 'grid1';
	var columns = [
		{name : 'checkpoint_time', header : {text : '일자'}, width : 150, editable : false, editor : {maxLength : 200}},
		{name : 'country_name', header : {text : '국가'}, width : 150, editable : false, editor : {maxLength : 250}},
		{name : 'tag', header : {text : '배송상태'}, width : 150, editable : false, editor : {maxLength : 350}},
		{name : 'tag_kr', header : {text : '배송상태(한글)'}, width : 150, editable : false, editor : {maxLength : 350}}
	];

	//그리드 생성 (realgrid 써서)
	$('#' + gid).gfn_createGrid(columns, {
		footerflg : false
	});

}
</script>

<c:import url="/comm/contentBottom.do" />