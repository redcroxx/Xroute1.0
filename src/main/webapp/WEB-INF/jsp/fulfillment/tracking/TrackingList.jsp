<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/comm/contentTop.do" />
<div id="ct_sech_wrap">
    <form id="frmTrackingListSearch" action="#" onsubmit="return false">
        <ul class="sech_ul">
            <li class="sech_li widpx600">
                <div>기간</div>
                <div class="widpx400">
                    <select id="sPeriodType" style="width: 100px;">
                        <c:forEach var="i" items="${periodType}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                    <input type="text" id="sToDate" class="cmc_date periods" />
                    ~
                    <input type="text" id="sFromDate" class="cmc_date periode" />
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
                    </select>
                    <input type="text" id="sKeyword" class="cmc_code" style="width: 218px;" />
                </div>
            </li>
            <li class="sech_li">
                <div>셀러</div>
                <div>
                    <input type="text" id="sOrgCd" class="cmc_code" />
                    <input type="text" id="sOrgNm" class="cmc_value" />
                    <button type="button" class="cmc_cdsearch"></button>
                </div>
            </li>
        </ul>
    </form>
</div>
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
            트랙킹 리스트
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <input type="button" id="excelUpload" class="cmb_normal_new cbtn_upload" value="    업로드" onclick="openPopup();" style="min-width: 100px;" />
        </div>
    </div>
    <div id="trackingListGrid"></div>
</div>
<script type="text/javascript">
    //초기 로드
    $(function() {
        // 1. 화면레이아웃 지정 (리사이징)
        initLayout();
        // 2. 기초검색 조건 설정
        reset_Search();
        // 3. 그리드 초기화
        getList();
        // 4. 셀러 팝업 설정
        pfn_codeval({
            url : "/alexcloud/popup/popP002/view.do",
            codeid : "sOrgCd",
            inparam : {
                S_COMPCD : "S_COMPCD",
                S_ORGCD : "S_ORGCD"
            },
            outparam : {
                ORGCD : "sOrgCd",
                NAME : "sOrgNm"
            }
        });
    });

    function reset_Search() {
        $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));

        var compcd = "<c:out value='${sessionScope.loginVO.compcd}' />";
        var usergroup = "<c:out value='${sessionScope.loginVO.usergroup}' />";
        var sellerGroup = "<c:out value='${constMap.SELLER_ADMIN}' />";
        var xcompCd = "<c:out value='${constMap.XROUTE_CD}' />";

        if (usergroup > sellerGroup) {
            $("#sOrgCd").val('<c:out value="${sessionScope.loginVO.orgcd}" />');
            $("#sOrgNm").val('<c:out value="${sessionScope.loginVO.orgnm}" />');
            $("#sOrgCd").removeClass("disabled").prop({
                'readonly' : false,
                'disabled' : false
            });
            $("#sOrgNm").removeClass("disabled").prop({
                'readonly' : false,
                'disabled' : false
            });
            $("#sOrgNm").next().removeClass("disabled").prop({
                'readonly' : false,
                'disabled' : false
            });
        } else if (usergroup <= sellerGroup) {
            $("#sOrgCd").val('<c:out value="${sessionScope.loginVO.orgcd}" />');
            $("#sOrgNm").val('<c:out value="${sessionScope.loginVO.orgnm}" />');
            $("#sOrgCd").addClass("disabled").prop({
                'readonly' : true,
                'disabled' : true
            });
            $("#sOrgNm").addClass("disabled").prop({
                'readonly' : true,
                'disabled' : true
            });
            $("#sOrgNm").next().addClass("disabled").prop({
                'readonly' : true,
                'disabled' : true
            });
        }
    }
    // 그리드 로드
    function getList() {
        var gid = "trackingListGrid";
        var columns = [
                {
                    name : "orgcd",
                    header : {
                        text : "셀러코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80,
                    editable : false,
                    editor : {
                        maxLength : 80
                    }
                }, {
                    name : "mallNm",
                    header : {
                        text : "쇼핑몰"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : false,
                    editor : {
                        maxLength : 100
                    }
                }, {
                    name : "xrtInvcSno",
                    header : {
                        text : "송장번호"
                    },
                    button : 'action',
                    alwaysShowButton : true,
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
                    editable : false,
                    editor : {
                        maxLength : 150
                    }
                }, {
                    name : "statusCdKr",
                    header : {
                        text : "주문배송상태"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : false,
                    editor : {
                        maxLength : 140
                    },
                    dynamicStyles : [
                        {
                            criteria : "value like '%오류%'",
                            styles : "background=#FFFF00"
                        }
                    ]
                }, {
                    name : "uploadDate",
                    header : {
                        text : "업로드 일자"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : false,
                    editor : {
                        maxLength : 100
                    }
                }, {
                    name : "shipMethodCd",
                    header : {
                        text : "서비스 타입"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : false,
                    editor : {
                        maxLength : 100
                    }
                }, {
                    name : "localShipper",
                    header : {
                        text : "현지 배송사"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : false,
                    editor : {
                        maxLength : 100
                    }
                }, {
                    name : "sNation",
                    header : {
                        text : "출발국가"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 70,
                    editable : false,
                    editor : {
                        maxLength : 70
                    }
                }, {
                    name : "eNation",
                    header : {
                        text : "도착국가"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 70,
                    editable : false,
                    editor : {
                        maxLength : 70
                    }
                }, {
                    name : "recvName",
                    header : {
                        text : "수화인명"
                    },
                    width : 150,
                    editable : false,
                    editor : {
                        maxLength : 150
                    }
                }, {
                    name : "recvTel",
                    header : {
                        text : "수화인 전화번호"
                    },
                    width : 130,
                    editable : false,
                    editor : {
                        maxLength : 130
                    }
                }, {
                    name : "recvMobile",
                    header : {
                        text : "수화인 핸드폰 번호"
                    },
                    width : 130,
                    editable : false,
                    editor : {
                        maxLength : 130
                    }
                }, {
                    name : "recvAddr1",
                    header : {
                        text : "수화인 주소1"
                    },
                    width : 200,
                    editable : false,
                    editor : {
                        maxLength : 200
                    }
                }, {
                    name : "recvAddr2",
                    header : {
                        text : "수화인 주소2"
                    },
                    width : 200,
                    editable : false,
                    editor : {
                        maxLength : 200
                    }
                }, {
                    name : "recvPost",
                    header : {
                        text : "수화인 우편번호"
                    },
                    width : 150,
                    editable : false,
                    editor : {
                        maxLength : 150
                    }
                }, {
                    name : "recvCity",
                    header : {
                        text : "수화인 도시"
                    },
                    width : 150,
                    editable : false,
                    editor : {
                        maxLength : 150
                    }
                }, {
                    name : "recvState",
                    header : {
                        text : "수화인 주(State)"
                    },
                    width : 120,
                    editable : false,
                    editor : {
                        maxLength : 120
                    }
                }, {
                    name : "recvCurrency",
                    header : {
                        text : "통화"
                    },
                    width : 100,
                    editable : false,
                    editor : {
                        maxLength : 100
                    }
                }, {
                    name : "ordCd",
                    header : {
                        text : "오더코드"
                    },
                    show : false
                }
        ];
        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false,
            cmenuGroupflg : false,
            cmenuColChangeflg : false,
            cmenuColSaveflg : false,
            cmenuColInitflg : false
        });
        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            //gridView.setStyles(basicBlackSkin);
            //열고정 설정
            gridView.setFixedOptions({
                colCount : 3,
                resizable : true,
                colBarWidth : 1
            });
            gridView.onCellButtonClicked = function(grid, itemIndex, column) {
                if (column.fieldName == "xrtInvcSno") {
                    var xrtInvcSno = grid.getValue(itemIndex, column.fieldName);
                    var ordCd = grid.getValue(itemIndex, "ordCd");
                    var jsonObj = {};
                    jsonObj.xrtInvcSno = xrtInvcSno;
                    jsonObj.ordCd = ordCd;
                    popUpTrackingListDtl(jsonObj);
                }
            };
        });
    };
    // 단건등록 팝업
    function popUpTrackingListDtl(jsonObj) {
        pfn_popupOpen({
            url : "/fulfillment/tracking/trackingDtl/view.do",
            params : jsonObj,
            returnFn : function(data, type) {
            }
        });
    };
    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            $("#trackingListGrid").gfn_setDataList(data.resultList);
            $("#trackingListGrid").gfn_focusPK();
        }
    };
    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        $("#trackingListGrid").gridView().cancel();
        gv_searchData = cfn_getFormData("frmTrackingListSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/tracking/trackingList/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    };
    //공통버튼 - 초기화
    function cfn_init() {
        reset_Search();
    };
    // 엑셀 업로드 팝업
    function openPopup() {
        pfn_popupOpen({
            url : "/fulfillment/tracking/excel/view.do",
            pid : "trackingExcel",
            returnFn : function(data, type) {
                if (type === 'OK') {
                }
            }
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />