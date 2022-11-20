<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst"%>
<!--
    화면코드 : AtomyApiOrderList
    화면명   : 애터미 Api 오더리스트.
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <ul class="sech_ul">
            <li class="sech_li required">
                <div>주문등록일자</div>
                <div>
                    <input type="text" id="sToDate" class="cmc_date periods required" /> ~
                    <input type="text" id="sFromDate" class="cmc_date periods required" />
                </div>
            </li>
            
            <li class="sech_li">
                <div>SaleNum</div>
                <div>
                    <input type="text" id="sOrdNo" class="cmc_code" style="width: 150px;"/>
                </div>
            </li>
            <li class="sech_li">
                <div>검색어</div>
                <div>
                    <select id="sKeywordType" style="width: 120px;">
                        <option selected="selected" value="">--전체--</option>
                        <option value="ORDER_YN">ORDER_YN</option>
                        <option value="INVOICE_YN">INVOICE_YN</option>
                    </select>
                    <select id="sKeyword" style="width: 100px;">
                        <option selected="selected" value="">--전체--</option>
                        <option value="Y">Y</option>
                        <option value="N">N</option>
                    </select>
                </div>
            </li>
        </ul>
    </form>
</div>
<!-- 검색 끝 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
                     주문 목록
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <input type="button" class="cmb_normal_new cbtn_save" id="btnAtomyOrder" value="     신규출고목록" onclick="apiOpen('getAtomyOrderInfo')"/>
            <input type="button" class="cmb_normal_new cbtn_save" id="btnUps" value="     UPS 송장 발번" onclick="upsApiOpen()"/>
            <input type="button" class="cmb_normal_new cbtn_save" id="btnXrouteOrder" value="     XROUTE 주문서 생성" onclick="apiOpen('setAtomyOrder')"/>
            <input type="button" class="cmb_normal_new cbtn_upload" id="btnAtomyApi" value="     신규출고확인 상태변경" onclick="apiOpen('setAtomyStatusUpdate')"/>
        </div>
    </div>
    <div id="apiGrid"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">

    var usercd = "<c:out value='${usercd}'/>";
    console.log(usercd);

    // 초기 로드
    $(function() {
        // 1. 화면레이아웃 지정 (리사이징)
        initLayout();
        // 3. 기초검색 조건 설정
        cfn_init();
        // 4. 그리드 초기화
        setGridData();
    });

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        if (cfn_isFormRequireData("frmSearch") == false) {
            return;
        }

        gv_searchData = cfn_getFormData("frmSearch");

        var sid = "sid_getSearch";
        var url = "/fulfillment/atomy/apiOrderList/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }

    //공통버튼 - 초기화
    function cfn_init() {
        $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        if (usercd == "XROUTE" || usercd == "XROUTE41") {
            $("#btnAtomyOrder").show();
            $("#btnUps").show();
            $("#btnXrouteOrder").show();
            $("#btnAtomyApi").show();
        }else {
            $("#btnAtomyOrder").hide();
            $("#btnUps").hide();
            $("#btnXrouteOrder").hide();
            $("#btnAtomyApi").hide();
        }
    }

    function setGridData() {
        var gid = "apiGrid";
        var columns = [
                {
                    name : "saleDate",
                    header : {
                        text : "SaleDate"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "orderId",
                    header : {
                        text : "OrderId"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "saleNum",
                    header : {
                        text : "SaleNum"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "seq",
                    header : {
                        text : "Seq"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 50
                }, {
                    name : "orderDate",
                    header : {
                        text : "OrderDate"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "custNo",
                    header : {
                        text : "CustNo"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "orderName",
                    header : {
                        text : "OrderName"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "materialCode",
                    header : {
                        text : "MaterialCode"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "materialName",
                    header : {
                        text : "MaterialName"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 300
                }, {
                    name : "saleQty",
                    header : {
                        text : "SaleQty"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 70
                }, {
                    name : "deliName",
                    header : {
                        text : "DeliName"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "phoneNo",
                    header : {
                        text : "PhoneNo"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "handPhone",
                    header : {
                        text : "HandPhone"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "postNo",
                    header : {
                        text : "PostNo"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "packingMemo",
                    header : {
                        text : "PackingMemo"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "deliMemo",
                    header : {
                        text : "DeliMemo"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "deliGubun",
                    header : {
                        text : "DeliGubun"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "bookYn",
                    header : {
                        text : "BookYn"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "reqNum",
                    header : {
                        text : "ReqNum"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 70
                }, {
                    name : "temp",
                    header : {
                        text : "Temp"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "subOrderName",
                    header : {
                        text : "SubOrderName"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "regDate",
                    header : {
                        text : "RegDate"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "birthDay",
                    header : {
                        text : "BirthDay"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "address",
                    header : {
                        text : "Address"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "thanksLetterYn",
                    header : {
                        text : "ThanksLetterYn"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 50
                }, {
                    name : "centerName",
                    header : {
                        text : "CenterName"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 200
                }, {
                    name : "pricePrint",
                    header : {
                        text : "PricePrint"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "custPrice",
                    header : {
                        text : "CustPrice"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "salePrice",
                    header : {
                        text : "SalePrice"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "custPv",
                    header : {
                        text : "CustPv"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "totalPv",
                    header : {
                        text : "TotalPv"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "nationCode",
                    header : {
                        text : "NationCode"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "addr1",
                    header : {
                        text : "Addr1"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "addr2",
                    header : {
                        text : "Addr2"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "addr3",
                    header : {
                        text : "Addr3"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 200
                }, {
                    name : "addr4",
                    header : {
                        text : "Addr4"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 200
                }, {
                    name : "boxSize",
                    header : {
                        text : "BoxSize"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "orderYn",
                    header : {
                        text : "OrderYn"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "invoiceYn",
                    header : {
                        text : "InvoiceYn"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "excRate",
                    header : {
                        text : "ExcRate"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "excCur",
                    header : {
                        text : "ExcCur"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "excAmt",
                    header : {
                        text : "ExcAmt"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "excTagSum",
                    header : {
                        text : "ExcTagSum"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                },{
                    name : "excTotSum",
                    header : {
                        text : "ExcTotSum"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "saleTagSum",
                    header : {
                        text : "SaleTagSum"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                },{
                    name : "saleTotSum",
                    header : {
                        text : "SaleTotSum"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "shipments",
                    header : {
                        text : "Shipments"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "orderCancel",
                    header : {
                        text : "OrderCancel"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "addusercd",
                    header : {
                        text : "등록자"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100 
                }, {
                    name : "adddatetime",
                    header : {
                        text : "등록일시"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 200
                }, {
                    name : "updusercd",
                    header : {
                        text : "수정자"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "upddatetime",
                    header : {
                        text : "수정일시"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 200
                }
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false,
            cmenuGroupflg : false,
            cmenuColChangeflg : false,
            cmenuColSaveflg : false,
            cmenuColInitflg : false,
            height : "99%"
        });
        
        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            // 체크박스 설정
            var bVisible = false;
            if ("<c:out value='${sessionScope.loginVO.usergroup}'/>" >= "<c:out value='${constMap.SELLER_ADMIN}'/>") {
                bVisible = true;
            }
            gridView.setCheckBar({
                visible : bVisible,
                exclusive : false,
                showAll : true
            });
        });
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            $("#apiGrid").gfn_setDataList(data.resultList);
            $("#apiGrid").gfn_focusPK();
        }
    }
    
    function apiOpen(type) {
        if (cfn_isFormRequireData("frmSearch") == false) {
            return;
        }
        
        if (type == "getAtomyOrderInfo") {
            url = "/fulfillment/atomy/apiOrderList/getOrderInfo.do";
        } else if(type == "setAtomyOrder") {
            url = "/fulfillment/atomy/apiOrderList/setAtomyOrder.do";
        } else if (type == "setAtomyStatusUpdate") {
            url = "/fulfillment/atomy/apiOrderList/setAtomyStatusUpdate.do";
        } else if (type == "setUpsShipments") {
            url = "/fulfillment/atomy/apiOrderList/setUpsShipments.do";
        }
        
        var sendData = cfn_getFormData("frmSearch");
        
        $.ajax({
            url : url,
            type : "POST",
            data : JSON.stringify(sendData),
            contentType: "application/json",
            beforeSend: function(request) {
                $("body").css("cursor","wait");
                loadingStart();
            },
            success : function(data) {
                loadingEnd();
                code = data.code;
                message = data.message;
                if (data.code == "1") {
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
                loadingEnd();
                cfn_msg("ERROR", "API Error");
            }
        });
    }
    
    function upsApiOpen() {
        var checkRows = $("#apiGrid").gridView().getCheckedRows(); // 체크 박스 데이터.
        var gridData = $("#apiGrid").gfn_getDataRows(checkRows);
        var upsApiList = [];
        
        if (checkRows.length == 0) {
            cfn_msg("WARNING", "선택된 행이 없습니다.");
            return;
        }
        
        for (var i = 0; i < gridData.length; i++) {
            var saleNum = $("#apiGrid").gfn_getValue(checkRows[i], "saleNum");
            upsApiList.push({
                "saleNum" : saleNum
            });
        }
        
        var sendData = {
            "dataList" : upsApiList
        };
        
        url = "/fulfillment/atomy/apiOrderList/setUpsShipments.do";
        
        $.ajax({
            url : url,
            type : "POST",
            data : JSON.stringify(sendData),
            contentType: "application/json",
            beforeSend: function(request) {
                $("body").css("cursor","wait");
                loadingStart();
            },
            success : function(data) {
                loadingEnd();
                code = data.code;
                message = data.message;
                if (data.code == "1") {
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
                loadingEnd();
                cfn_msg("ERROR", "API Error");
            }
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />