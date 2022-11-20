<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/comm/contentTop.do">
	<c:param name="fixedTab" value="1" />
</c:import>
<div id="ct_sech_wrap">
	<form id="frmSearch"
		action="/fulfillment/order/orderMemoListDtl/view.do" method="post">
		<input type="hidden" id="sCompCd"
			value="<c:out value='${sessionScope.loginVO.compcd}' />">
		<ul class="sech_ul">
			<li class="sech_li" style="width: 460px;">
				<div>기간</div>
				<div style="width: 350px;">
					<select id="sPeriodType" style="width: 100px;">
						<c:forEach var="i" items="${periodType}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select> <input type="text" id="sToDate" class="cmc_date periods required" />
					~ <input type="text" id="sFromDate"
						class="cmc_date periode required" />
				</div>
			</li>
			<li class="sech_li" style="width: 450px;">
				<div>검색어</div>
				<div>
					<select id="sKeywordType" style="width: 100px;">
						<option selected="selected" value="total">--전체--</option>
						<c:forEach var="i" items="${shippingkeyword}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</select> <input type="text" id="sKeyword" class="cmc_code"
						style="width: 140px;" />
				</div>
			</li>
			<li class="sech_li">
				<div>배송 국가</div>
				<div>
					<input type="text" id="sFromNation" list="countrylist">
					<datalist id="countrylist">
						<c:forEach var="i" items="${countrylist}">
							<option value="${i.code}">${i.value}</option>
						</c:forEach>
					</datalist>
				</div>
			</li>
		</ul>
		<ul class="sech_ul">
			<c:choose>
				<c:when
					test="${sessionScope.loginVO.usergroup <= constMap.SELLER_ADMIN}">
					<li class="sech_li" style="width: 460px;">
						<div>상태</div>
						<div>
							<select id="sStatusCd" style="width: 100px">
								<option selected="selected" value="">--전체--</option>
								<option value="order">오더등록</option>
								<option value="warehouse">창고입고</option>
								<option value="warehousing">창고보관</option>
								<option value="shipped">출고</option>
								<option value="delivery">배송중</option>
								<option value="delivered">배송완료</option>
								<option value="error">배송취소/오류</option>
							</select> <input type="hidden" id="sWhcd"
								value="<c:out value='${sessionScope.loginVO.whcd}' />">
							<input type="hidden" id="sOrgCd"
								value="<c:out value='${sessionScope.loginVO.orgcd}' />">
						</div>
					</li>
					<li class="sech_li">
						<div>서비스 타입</div>
						<div>
							<input type="text" id="sShipCompany" list="serviceType">
							<datalist id="serviceType">
								<c:forEach var="i" items="${serviceType}">
									<option value="${i.code}">${i.value}</option>
								</c:forEach>
							</datalist>
						</div>
					</li>
				</c:when>
				<c:otherwise>
					<li class="sech_li" style="width: 460px;">
						<div>창고</div>
						<div>
							<input type="text" id="sWhcd" class="cmc_code disabled"
								disabled="disabled"> <input type="text" id="sWhnm"
								class="cmc_value" onchange="inputClear('sWhcd')">
							<button type="button" class="cmc_cdsearch"
								onclick="openLayerPopup('sWhcd')"></button>
						</div>
					</li>
					<li class="sech_li" style="width: 450px;">
						<div>셀러</div>
						<div>
							<input type="text" id="sOrgCd" class="cmc_code disabled"
								disabled="disabled"> <input type="text" id="sOrgNm"
								class="cmc_value" onchange="inputClear('sOrgCd')">
							<button type="button" class="cmc_cdsearch"
								onclick="openLayerPopup('sOrgCd')"></button>
						</div>
					</li>
					<li class="sech_li">
						<div>결제 타입</div>
						<div>
							<select id="sPaymentType" style="width: 100px">
								<option selected="selected" value="">-- 전체 --</option>
								<c:forEach var="p" items="${paymentType}">
									<option value="${p.code}">${p.value}</option>
								</c:forEach>
							</select>
						</div>
					</li>
					<li class="sech_li" style="width: 460px;">
						<div>상태</div>
						<div>
							<select id="sStatusCd" style="width: 200px">
								<option selected="selected" value="">-- 전체 --</option>
								<option value="10">주문등록</option>
								<option value="11">발송대기</option>
								<option value="12">발송완료</option>
								<option value="20">입금대기</option>
								<option value="21">결제완료</option>
								<option value="22">결제대기</option>
								<option value="23">결제실패</option>
								<option value="30">입고완료</option>
								<option value="31">창고보관</option>
								<option value="32">출고대기</option>
								<option value="33">검수완료</option>
								<option value="34">검수취소</option>
								<option value="35">선적대기</option>
								<option value="40">출고완료</option>
								<option value="50">공항출발(예정)</option>
								<option value="51">공항출발(완료)</option>
								<option value="52">해외공항도착(예정)</option>
								<option value="53">해외공항도착(완료)</option>
								<option value="54">통관대기</option>
								<option value="55">통관완료</option>
								<option value="56">OutForDelivery</option>
								<option value="57">InTransit</option>
								<option value="60">배송완료</option>
								<option value="80">API오류</option>
								<option value="98">입금취소</option>
								<option value="99">주문취소</option>
							</select>
						</div>
					</li>
					<li class="sech_li">
						<div>서비스 타입</div>
						<div>
							<input type="text" id="sShipCompany" list="serviceType">
							<datalist id="serviceType">
								<c:forEach var="i" items="${serviceType}">
									<option value="${i.code}">${i.value}</option>
								</c:forEach>
							</datalist>
						</div>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</form>
</div>
<div class="ct_top_wrap">
	<div class="grid_top_wrap">
		<div class="grid_top_left">
			주문리스트 <span>(총 0건)</span>
		</div>
		<div class="grid_top_right">
			<input id="btn_refresh" class="cmb_normal_new" type="button"
				value="주문배송상태 갱신" onclick="apiOpen1()" />
		</div>
	</div>
	<div id="grid"></div>
</div>
<script type="text/javascript">
    //초기 로드
    $(function() {
        // 1. 화면레이아웃 지정 (리사이징)
        initLayout();
        // 2. 기초검색 조건 설정
        cfn_init();
        // 3. 그리드 초기화
        setGridData();
        // 4. 조회
        cfn_retrieve();
    });

    function cfn_init() {
        // 기간이 null이 아니면, 기간을 검색 조건에 따라 세팅.
        if ("<c:out value='${sToDate}'/>" != "") {
            $("#sToDate").val("<c:out value='${sToDate}'/>");
            $("#sFromDate").val("<c:out value='${sFromDate}'/>");
        } else {
            $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
            $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        }

        if ("<c:out value='${sStatusCd}'/>" != "") {
            if ("<c:out value='${sStatusCd}'/>" == "totalCount") {
                $("#sStatusCd").val("");
            } else {
                $("#sStatusCd").val("<c:out value='${sStatusCd}'/>");
            }
        }
    }
    
    function setGridData() {
        var gid = "grid";
        var btn = "/images/btn_memo.png";
        "<c:out value='${constMap.USER_GROUP}' />"
        "<c:out value='${constMap.SELLER_ADMIN_INT}' />"
        var sellerColumns = [
            {
                name : "memo",
                header : {
                    text : "메모"
                },
                button : "image",
                alwaysShowButton : true,
                imageButtons : {
                    width : 45,
                    images : [
                        {
                            name : "메모",
                            up : btn,
                            hover : btn,
                            down : btn
                        }
                    ]
                },
                width : 60
            }, {
                name : "orgcd",
                header : {
                    text : "셀러코드"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                show : false
            }, {
                name : "xrtInvcSno",
                header : {
                    text : "송장번호"
                },
                button : "action",
                alwaysShowButton : true,
                styles : {
                    textAlignment : "center"
                },
                width : 150
            }, {
                name : "statusCdKr",
                header : {
                    text : "주문배송상태"
                },
                styles : {
                    textAlignment : "center"
                },
                dynamicStyles : [
                    {
                        criteria : "value like '%오류%'",
                        styles : "background=#FFFF00"
                    }
                ],
                width : 140
            }, {
                name : "localShipper",
                header : {
                    text : "현지 배송사"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100
            }, {
                name : "invcSno1",
                header : {
                    text : "배송No1"
                },
                width : 150
            }, {
                name : "ordNo",
                header : {
                    text : "주문번호"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 150
            },{
                name : "stockDate",
                header : {
                    text : "입고일자"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 130
            },{
                name : "xrtShippingPrice",
                header : {
                    text : "배송비(운임)"
                },
                styles : {
                    textAlignment : "center"
                },
                idth : 80
            },{
                name : "shipMethodCd",
                header : {
                    text : "배송구분"
                },
                styles : {
                    textAlignment : "center"
                },
                idth : 80
            }, {
                name : "sNation",
                header : {
                    text : "출발국가"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 60
            }, {
                name : "eNation",
                header : {
                    text : "도착국가"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 60
            }, {
                name : "ordCnt",
                header : {
                    text : "주문수량"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 60
            }, {
                name : "recvName",
                header : {
                    text : "수화인명"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 150
            }, {
                name : "recvTel",
                header : {
                    text : "수화인 전화번호"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 130
            }, {
                name : "recvMobile",
                header : {
                    text : "수화인 핸드폰 번호"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 130
            }, {
                name : "recvAddr1",
                header : {
                    text : "수화인 주소1"
                },
                width : 200
            }, {
                name : "recvAddr2",
                header : {
                    text : "수화인 주소2"
                },
                width : 200
            }, {
                name : "recvPost",
                header : {
                    text : "수화인 우편번호"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 130
            }, {
                name : "recvCity",
                header : {
                    text : "수화인 도시"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 150
            }, {
                name : "recvState",
                header : {
                    text : "수화인 주(State)"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 130
            }
        ]
        
        var adminColumns = [
            {name:"memo", header:{text:"메모"}, button:"image", alwaysShowButton:true, imageButtons:{width:45, images:[{name:"메모", up:btn, hover:btn, down:btn}]}, styles:{textAlignment:"center"}, width:60}
            , {name:"orgcd", header:{text:"셀러코드"}, styles:{textAlignment:"center"}, width:80}
            , {name:"mallNm", header:{text:"쇼핑몰"}, styles:{textAlignment:"center"}, width:100}
            , {name:"xrtInvcSno", header:{text:"송장번호"}, button:"action", alwaysShowButton:true, styles:{textAlignment:"center"}, width:150}
            , {name:"paymentType", header:{text:"결제타입구분"}, styles:{textAlignment:"center"}, width:100}
            , {name:"statusCdKr", header:{text:"주문배송상태"}, styles:{textAlignment:"center"}, dynamicStyles: [{criteria:"value like '%오류%'", styles:"background=#FFFF00"}], width:180}
            , {name:"statusCdEn", header:{text:"Delivery Status"}, styles:{textAlignment:"center"}, width:250}
            , {name:"unipass_tkofdt", header:{text:"선적완료일"}, styles:{textAlignment:"center"}, width:100}
            , {name:"invcSno1", header:{text:"배송No1"}, width:200}
            , {name:"invcSno2", header:{text:"배송No2"}, width:200}
            , {name:"uploadDate", header:{text:"업로드 일자"}, styles:{textAlignment:"center"}, width:100}
            , {name:"shipMethodCd", header:{text:"서비스 타입"}, styles:{textAlignment:"center"}, width:100}
            , {name:"localShipper", header:{text:"현지 배송사"}, styles:{textAlignment:"center"}, width:100}
            , {name:"sNation", header:{text:"출발국가"}, styles:{textAlignment:"center"}, width:70}
            , {name:"eNation", header:{text:"도착국가"}, styles:{textAlignment:"center"}, width:70}
            , {name:"shipName", header:{text:"송화인명"}, width:150}
            , {name:"shipTel", header:{text:"송화인 연락처"}, width:150}
            , {name:"shipAddr", header:{text:"송화인 주소"}, width:300}
            , {name:"recvName", header:{text:"수화인명"}, width:150}
            , {name:"recvTel", header:{text:"수화인 전화번호"}, width:130}
            , {name:"recvMobile", header:{text:"수화인 핸드폰 번호"}, width:130}
            , {name:"recvAddr1", header:{text:"수화인 주소1"}, width:300}
            , {name:"recvAddr2", header:{text:"수화인 주소2"}, width:300}
            , {name:"recvPost", header:{text:"수화인 우편번호"}, width:150}
            , {name:"recvCity", header:{text:"수화인 도시"}, width:150}
            , {name:"recvState", header:{text:"수화인 주(State)"}, width:120}
            , {name:"recvCurrency", header:{text:"통화"}, width:100}
            , {name:"ordCnt", header:{text:"주문수량"}, styles:{textAlignment:"center"}, width:100}
            , {name:"ordNo", header:{text:"주문번호"}, width:100}
            , {name:"cartNo", header:{text:"장바구니 번호"}, width:150}
            , {name:"goodsCd", header:{text:"상품번호"}, width:150}
            , {name:"goodsNm", header:{text:"상품명"}, width:300}
            , {name:"goodsOption", header:{text:"상품옵션"}, width:200}
            , {name:"goodsCnt", header:{text:"상품수량"}, styles:{textAlignment:"center"}, width:60}
            , {name:"totPaymentPrice", header:{text:"구매자 결제금액"}, styles:{textAlignment:"far", numberFormat:"#,##0"}, width:100}
            , {name:"cWgtCharge", header:{text:"실제 과금 중량(Kg)"}, styles:{textAlignment:"center"}, width:100}
            , {name:"cWgtReal", header:{text:"실제 중량(Kg)"}, styles:{textAlignment:"center"}, width:100}
            , {name:"cBoxWidth", header:{text:"실제 가로(cm)"}, styles:{textAlignment:"center"}, width:100}
            , {name:"cBoxLength", header:{text:"실제 세로(cm)"}, styles:{textAlignment:"center"}, width:100}
            , {name:"cBoxHeight", header:{text:"실제 높이(cm)"}, styles:{textAlignment:"center"}, width:100}
            , {name:"xWgt", header:{text:"XROUTE_중량(Kg)"}, styles:{textAlignment:"center"}, width:110}
            , {name:"xBoxWidth", header:{text:"XROUTE_가로(cm)"}, styles:{textAlignment:"center"}, width:110}
            , {name:"xBoxLength", header:{text:"XROUTE_세로(cm)"}, styles:{textAlignment:"center"}, width:110}
            , {name:"xBoxHeight", header:{text:"XROUTE_높이(cm)"}, styles:{textAlignment:"center"}, width:110}
            , {name:"upddatetime", header:{text:"날짜/시간"}, styles:{textAlignment:"center"}, width:180}
            , {name:"xrtShippingPrice", header:{text:"xroute 판매가"}, width:100}
            , {name:"purchaseUrl", header:{text:"구매 URL"}, width:300}
        ]
        var columns = [];
        if ("<c:out value='${sessionScope.loginVO.usergroup}' />" <= "<c:out value='${constMap.SELLER_ADMIN}' />") {
            columns = sellerColumns;
        }else {
            columns = adminColumns;
        }
  
        //그리드 생성 (realgrid 써서)
        $("#"+ gid).gfn_createGrid(columns, {
            footerflg: false,
            cmenuGroupflg: false,
            cmenuColChangeflg: false,
            cmenuColSaveflg: false,
            cmenuColInitflg: false,
        });
        //그리드설정 및 이벤트처리
        $("#"+ gid).gfn_setGridEvent(
            function(gridView, dataProvider) {
                //gridView.setStyles(basicBlackSkin);
                //열고정 설정
                gridView.setFixedOptions({colCount:4, resizable:true, colBarWidth:1});
                gridView.onImageButtonClicked = function (grid, itemIndex, column, buttonIndex, name) {
                    var xrtInvcSno = grid.getValue(itemIndex, "xrtInvcSno");
                    openWindowPopup(xrtInvcSno);
                };
                gridView.onCellButtonClicked = function(grid, itemIndex, column) {
                    if (column.fieldName == "xrtInvcSno") {
                        var xrtInvcSno = grid.getValue(itemIndex, column.fieldName);
                        var recvName = grid.getValue(itemIndex, "recvName");
                        var jsonObj = {};
                        jsonObj.xrtInvcSno = xrtInvcSno;
                        jsonObj.recvName = recvName;
                        openLayerPopup("shipping", jsonObj);
                    }
                };
            }
        );
    }
    // 레이어 팝업 호출 공통
    function openLayerPopup(elemId, jsonObj) {
        var url = "";
        var pid = "";
        var params = {
            S_COMPCD : ($("#S_COMPCD").val() || ""),
            gridData : []
        };

        if (elemId == "sWhcd") {
            url = "/alexcloud/popup/popP004/view.do";
            pid = "popP004";
            params.S_WHCD = $("#sWhnm").val() || "";
        } else if (elemId == "sOrgCd") {
            url = "/alexcloud/popup/popP002/view.do";
            pid = "popP002";
            params.S_ORGCD = $("#sOrgNm").val() || "";
        } else if (elemId == "shipping") {
            url = "/fulfillment/order/shippingList/pop/view.do";
            pid = "shippingPop";
            params = jsonObj;
        } else {
            cfn_msg("ERROR", "오류가 발생 하였습니다.");
            return;
        }
        
        pfn_popupOpen({
            url : url,
            pid : pid,
            params : params,
            returnFn : function(data, type) {
                if (type == "OK") {
                    if (elemId == "sWhcd") {
                        $("#sWhcd").val(data[0].WHCD || "");
                        $("#sWhnm").val(data[0].NAME || "");
                    } else if (elemId == "sOrgCd") {
                        $("#sOrgCd").val(data[0].ORGCD || "");
                        $("#sOrgNm").val(data[0].NAME || "");
                    } else if (elemId == "shipping") {
                        cfn_retrieve();
                    } else {
                    }
                }
            }
        });
    }
    // 메모 윈도우 팝업 호출
    function openWindowPopup(xrtInvcSno) {
        var width = "1000";
        var height = "690";
        var left = (window.screen.width/2) - (width/2);
        var top = (window.screen.height/2) - (height/2);
        var url = "/fulfillment/order/orderMemoListDtl/view.do?xrtInvcSno=" + xrtInvcSno;
        var option = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top + ", resizable=no, scrollbars=no, menubar=no, location=no, status=no";
        var openWin = window.open(url, "로지포커스", option);
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        if (sid == "sid_getSearch") {
            $("#grid").gfn_setDataList(data.resultList);
            $("#grid").gfn_focusPK();
        }
    }

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        $("#grid").gridView().cancel();
        gv_searchData = cfn_getFormData("frmSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/order/shippingList/getSearch.do";
        var sendData = gv_searchData;
        gfn_sendData(sid, url, sendData, true);
    }
    // 창고 및 셀러 이름 변경시 초기화
    function inputClear(elemId) {
        $("#" + elemId).val("");
    }
    
    // 갱신버튼 ajax
    function apiOpen1() {
        url = "/fulfillment/order/shippingList/statusRefresh.do";
        
        $.ajax({
            url : url,
            type : "POST",
            contentType: "application/json",
            beforeSend: function(request) {
                $("body").css("cursor","wait");
                loadingStart();
            },
            success : function(data) {
                loadingEnd();
                code = data.code;
                message = data.cnt;
                if (data.code == "200") {
                    cfn_msg("INFO", "Code : " + code + "\nMessage : " + message);
                    $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
                    $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
                } else {
                    cfn_msg("WARNING", "Code : " + code + "\nMessage : " + message);
                    $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
                    $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
                }
                
            },
            error : function(data) {
                // loadingEnd();
                // cfn_msg("ERROR", "API Error");
            }
        });
    }
    
    // 갱신버튼 관리자권한 - 08/26 배송상태값갱신은 xroute 계정에서만 visible
    if ("<c:out value='${sessionScope.loginVO.usergroup}'/>" >= "<c:out value='80'/>") {
        $("#btn_refresh").css("display","visiblity");        
    } else {
        $("#btn_refresh").css("display","none");
    }
    
</script>
<c:import url="/comm/contentBottom.do" />