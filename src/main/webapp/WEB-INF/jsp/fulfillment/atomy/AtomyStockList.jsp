<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/comm/contentTop.do">
    <c:param name="fixedTab" value="5" />
</c:import>
<div id="ct_sech_wrap">
    <form id="frmSearch" name="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" id="atomyOrgcd" name="atomyOrgcd" class="cmc_txt" value="${atomyOrgcd}"/>
        <ul class="sech_ul">
            <li class="sech_li">
                <div>입고일자</div>
                <div>
                    <input type="text" id="sToStock" class="cmc_date periods" readonly="readonly"/>
                    ~
                    <input type="text" id="sFromStock" class="cmc_date periode" readonly="readonly"/>
                </div>
            </li>
            <li class="sech_li">
                <div>입고상태</div>
                <div>
                    <select id="STATUS" class="cmc_combo">
                        <option value="0" selected>전체</option>
                        <c:forEach var="i" items="${CODE_STOCK_YN}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 130px;">XROUTE 송장번호</div>
                <div>
                    <input type="text" id="XRTSNO" class="cmc_txt">
                </div>
            </li>
        </ul>
    </form>
</div>
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
                     입고리스트
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right"></div>
    </div>
    <div id="grid1"></div>
</div>
<script type="text/javascript">
    //초기 로드
    $(function() {
        $("#sToStock").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromStock").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        //1. 화면레이아웃 지정 (리사이징) 
        initLayout();

        //2. 그리드 초기화
        grid1_Load();
    });

    function grid1_Load() {
        var gid = "grid1";
        var columns = [
                {
                    name : "status",
                    header : {
                        text : "입고상태"
                    },
                    width : 60,
                    formatter : "combo",
                    comboValue : "${GCODE_STOCK_YN}",
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 60
                    }
                }, {
                    name : "uploadDate",
                    header : {
                        text : "오더등록일"
                    },
                    width : 150,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 150
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "fileSeq",
                    header : {
                        text : "차수"
                    },
                    width : 50,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 50
                    }
                }, {
                    name : "xrtInvcSno",
                    header : {
                        text : "송장번호"
                    },
                    width : 180,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 180
                    }
                }, {
                    name : "paymentType",
                    header : {
                        text : "결제타입구분"
                    },
                    width : 100,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 100
                    }
                }, {
                    name : "statusCdKr",
                    header : {
                        text : "주문배송상태"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
                    editable : false,
                    editor : {
                        maxLength : 150
                    },
                    dynamicStyles : [
                        {
                            criteria : "value like '%오류%'",
                            styles : "background=#FFFF00"
                        }
                    ]
                }, {
                    name : "statusCdEn",
                    header : {
                        text : "Delivery Status"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 250,
                    editable : false,
                    editor : {
                        maxLength : 250
                    },
                    dynamicStyles : [
                        {
                            criteria : "value like '%오류%'",
                            styles : "background=#FFFF00"
                        }
                    ]
                }, {
                    name : "addusercd",
                    header : {
                        text : "셀러코드"
                    },
                    width : 120,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 120
                    }
                }, {
                    name : "shipName",
                    header : {
                        text : "송화인"
                    },
                    width : 150,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 150
                    }
                }, {
                    name : "shipMethodCd",
                    header : {
                        text : "배송방식"
                    },
                    width : 100,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 100
                    }
                }, {
                    name : "eNation",
                    header : {
                        text : "도착국가"
                    },
                    width : 60,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 60
                    }
                }, {
                    name : "stockDate",
                    header : {
                        text : "입고일"
                    },
                    width : 150,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 150
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "stockUserCd",
                    header : {
                        text : "입고처리ID"
                    },
                    width : 120,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 120
                    }
                }, {
                    name : "invcSno1",
                    header : {
                        text : "배송No1"
                    },
                    width : 200,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 200
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "invcSno2",
                    header : {
                        text : "배송No2"
                    },
                    width : 200,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 200
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "ordCnt",
                    header : {
                        text : "총수량"
                    },
                    width : 50,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 50
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "goodsNm",
                    header : {
                        text : "상품명"
                    },
                    width : 300,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 300
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "goodsOption",
                    header : {
                        text : "상품옵션"
                    },
                    width : 250,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 250
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "goodsCnt",
                    header : {
                        text : "상품수량"
                    },
                    width : 150,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 150
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "totPaymentPrice",
                    header : {
                        text : "구매자 결제금액"
                    },
                    width : 100,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 100
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "wgt",
                    header : {
                        text : "무게"
                    },
                    width : 50,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 50
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "boxWidth",
                    header : {
                        text : "가로"
                    },
                    width : 50,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 50
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "boxLength",
                    header : {
                        text : "세로"
                    },
                    width : 50,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 50
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "boxHeight",
                    header : {
                        text : "높이"
                    },
                    width : 50,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 50
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }, {
                    name : "statusCd",
                    header : {
                        text : "입고상태히든"
                    },
                    width : 50,
                    styles : {
                        textAlignment : "center"
                    },
                    editable : false,
                    editor : {
                        maxLength : 50
                    },
                    styles : {
                        textAlignment : "center"
                    }
                }
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false,
            cmenuGroupflg : false,
            cmenuColChangeflg : false,
            cmenuColSaveflg : false,
            cmenuColInitflg : false,
        });

        // 그리드 설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            //열고정 설정
            gridView.setFixedOptions({
                colCount : 2,
                resizable : true,
                colBarWidth : 1
            });

            // 특정 컬럼 숨기기
            gridView.setColumnProperty("statusCd", "visible", false);
        });
    }

    // 공통버튼 - 검색 클릭
    function cfn_retrieve() {
        $("#grid1").gridView().cancel();

        gv_searchData = cfn_getFormData("frmSearch");

        var atomyOrgcd = $("#atomyOrgcd").val();
        console.log("atomyOrgcd : " + atomyOrgcd);
        
        var sid = "sid_getSearch";
        var url = "/fulfillment/atomy/stockList/getSearch.do";
        var sendData = {
            "paramData" : gv_searchData
        };

        gfn_sendData(sid, url, sendData, true);
    }

    function gfn_callback(sid, data) {
        // 검색
        if (sid == "sid_getSearch") {
            $("#grid1").gfn_setDataList(data.resultList);
            $("#grid1").gfn_focusPK();
        }
    }

    // 공통버튼 - 초기화
    function cfn_init() {
        $("form[name='frmSearch']").each(function() {
            this.reset();
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />