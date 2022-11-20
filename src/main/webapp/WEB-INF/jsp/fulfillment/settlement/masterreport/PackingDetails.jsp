<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <ul class="sech_ul">
            <li class="sech_li">
                <div style="width: 50px;">기간</div>
                <div>
                    <input type="text" id="DATE_TO" class="cmc_date periods" readonly="readonly" />
                    ~
                    <input type="text" id="DATE_FROM" class="cmc_date periode" readonly="readonly" />
                </div>
            </li>
            <li class="sech_li">
	            <div style="width: 60px;">SBL 번호</div>
	            <div style="width: 150px;">
	                <input type="text" id="shipmentBlNo" class="cmc_value" onchange="inputClear('shipmentBlNo')">
	                <button type="button" class="cmc_cdsearch" onclick="openLayerPopup('sblNo')"></button>
	            </div>
            </li>
            <li class="sech_li">
                <div style="width: 50px;">국가</div>
                <div>
                    <select id="country" onchange="changeSelect()" style="width: 220px;">
                        <c:forEach var="i" items="${countrylist}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </li>
            <li id="stateSelect" class="sech_li">
                <div style="width: 70px;">주(STATE)</div>
                <div style="width: 50px;">
                    <select id="usState" class="cmc_combo">
                        <option value="TOTAL">전체</option>
                        <option value="US_STATE_EAST">동부</option>
                        <option value="US_STATE_WEST">서부</option>
                    </select>
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 80px;">서비스 타입</div>
                <div>
                    <select id="sKeywordType">
                        <option selected="selected" value="PREMIUM">PREMIUM</option>
                        <option value="DHL">DHL</option>
                        <option value="UPS">UPS</option>
                    </select>
                </div>
            </li>
        </ul>
        <br>
        <ul style="padding-left: 10px;">
            <li>
                <div>
                    <P>
                        <font color="#FF000">※ 기준정보 > 셀러에서 대표자 영문이름과 영문주소를 입력하지않으면 대표자이름과 주소가 표시되지 않습니다.</font>
                    </P>
                </div>
            </li>
        </ul>
    </form>
</div>
<!-- 검색 끝 -->
<!-- 그리드 시작 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
            PackingDetails 목록
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right"></div>
    </div>
    <div id="grid1"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    //초기 로드
    $(function() {
        initLayout();
        //그리드 초기화
        grid1_Load();
        $("#DATE_TO").val(cfn_getDateFormat(new Date, "yyyy-MM-dd"));
        $("#DATE_FROM").val(cfn_getDateFormat(new Date, "yyyy-MM-dd"));
        // 미국 선택.
        $("#country").val("US");
    });

    function grid1_Load() {
        var gid = "grid1";
        var columns = [
                {
                    name : "XRT_INVC_SNO",
                    header : {
                        text : "Ref.no"
                    },
                    width : 150,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true,
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "INVC_SNO",
                    header : {
                        text : "Tracking No"
                    },
                    width : 250,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "WGT",
                    header : {
                        text : "Weight(Kg)"
                    },
                    width : 80,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "GOODS",
                    header : {
                        text : "Contents"
                    },
                    width : 300,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "SELLER_CEO",
                    header : {
                        text : "Seller.CEO"
                    },
                    width : 100,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "SELLER_ADDR",
                    header : {
                        text : "Seller.Address"
                    },
                    width : 300,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true,
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "SELLER_TEL",
                    header : {
                        text : "Seller.Tel"
                    },
                    width : 130,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "RECV_NAME",
                    header : {
                        text : "Recipient.Name"
                    },
                    width : 130,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "RECV_ADDR1",
                    header : {
                        text : "Recipient.Address"
                    },
                    width : 300,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "RECV_ADDR2",
                    header : {
                        text : "Address Detail"
                    },
                    width : 200,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "RECV_CITY",
                    header : {
                        text : "Recipient City"
                    },
                    width : 190,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "RECV_STATE",
                    header : {
                        text : "STATE"
                    },
                    width : 80,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "RECV_TEL",
                    header : {
                        text : "Recipient.Tel"
                    },
                    width : 150,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "RECV_POST",
                    header : {
                        text : "ZIP CODE"
                    },
                    width : 120,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }, {
                    name : "ZONE",
                    header : {
                        text : "Zone"
                    },
                    width : 120,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true
                }
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false,
            cmenuGroupflg : false,
            cmenuColChangeflg : false,
            cmenuColSaveflg : false,
            cmenuColInitflg : false,
            cmenuExcelflg : false,
            cmenuCsvflg : false
        });

        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            var options = gridView.getDisplayOptions();

            options.columnResizable = !options.columnResizable;
            //gridView.setDisplayOptions(options);
            
            //열고정 설정
            gridView.setFixedOptions({
                colCount : 2,
                resizable : true,
                colBarWidth : 1
            });
            gridView.setContextMenu([
                {
                    label : "Excel Export"
                }
            ]);
            gridView.onContextMenuItemClicked = function(grid, label, index) {
                fn_excel_export();
            };
        });
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            $("#grid1").gfn_setDataList(data.resultList);
            $("#grid1").gfn_focusPK();
        }
    }

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {

        $("#grid1").gridView().cancel();
        param = cfn_getFormData("frmSearch");
        
        console.log(param);

        var sid = "sid_getSearch";
        var url = "/fulfillment/settlement/packingDetails/getSearch.do";
        var sendData = {
            "paramData" : param
        };

        gfn_sendData(sid, url, sendData, true);
    }

    function changeSelect() {
        if ($("#country").val() != "US") {
            $("#stateSelect").hide();
            $("#usState").val("");
        }

        if ($("#country").val() == "US") {
            $("#stateSelect").show();
            $("#usState").val("US_STATE_EAST");
        }
    }

    // excel파일 다운로드
    function fn_excel_export() {

        var $g = "grid1";

        RealGridJS.exportGrid({
            type : "excel",
            target : "local",
            fileName : "PackingDetails" + ".xlsx",
            showProgress : "Y",
            documentTitle : { //제목
                message : "MANIFEST",
                visible : true,
                styles : {
                    fontSize : 40,
                    fontBold : true,
                    textAlignment : "center",
                    lineAlignment : "center",
                    background : "#FFFFFF"
                },
                spaceTop : 1,
                spaceBottom : 0,
                height : 60
            },
            applyDynamicStyles : true,
            progressMessage : "엑셀 Export중입니다.",
            header : "default",
            footer : "default",
            compatibility : "2010",
            lookupDisplay : true,
            exportGrids : [
                {
                    grid : $("#" + $g).gridView(),
                    sheetName : "PackingDetails"
                }
            ],
            done : function() {
            }
        });
    }
    
    // 레이어 팝업 호출 공통
    function openLayerPopup(elemId) {
        var url = "/fulfillment/settlement/packingDetails/pop/view.do";
        var pid = "shipmentBlNoPop";
        
        var params = {
            DATE_TO : ($("#DATE_TO").val() || ""),
            DATE_FROM : ($("#DATE_FROM").val() || ""),
            country : ($("#country").val() || ""),
            usState : ($("#usState").val() || "")
        };

        pfn_popupOpen({
            url : url,
            pid : pid,
            params : params,
            returnFn : function(data, type) {
                if (type == "OK") {
                    $("#sKeywordType").val(data.shipMethodCd || "");
                    $("#shipmentBlNo").val(data.shipmentBlNos || "");
	                $("#DATE_TO").val(data.DATE_TO || "");
	                $("#DATE_FROM").val(data.DATE_FROM || "");
	                cfn_retrieve();
                }
            }
        });
    }
    
    // shipmentBlNo 변경시 초기화
    function inputClear(elemId) {
        $("#" + elemId).val("");
    }
</script>
<c:import url="/comm/contentBottom.do" />