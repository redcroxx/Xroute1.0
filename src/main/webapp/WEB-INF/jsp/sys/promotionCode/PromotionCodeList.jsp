<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : PromotionCodeList
    화면명   : 쿠폰 관리 목록
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <ul class="sech_ul">
            <li class="sech_li required">
                <div>기간</div>
                <div style="width: 350px;">
                    <input type="text" class="cmc_date periods required" id="sToDate">
                    ~
                    <input type="text" class="cmc_date periode required" id="sFromDate">
                </div>
            </li>
            <li class="sech_li">
                <div>프로모션 코드</div>
                <div style="width: 350px;">
                    <input type="text" class="cmc_txt" id="sPromotionCode">
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
            프로모션 코드 목록
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <input type="button" class="cmb_plus" onclick="openLayerPopup('create')" />
            <input type="button" class="cmb_minus" onclick="popDeleteRow()" />
           
        </div>
    </div>
    <div id="grid"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    // 초기 로드
    $(function() {
        // 1. 화면레이아웃 지정 (리사이징)
        initLayout();
        // 2. 최초 실행
        cfn_init();
        // 3. 그리드 설정
        setGridData();
    });
    // 공통버튼 - 초기화 클릭
    function cfn_init() {
        $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
    }
    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        // $("#grid").gridView().cancel();

        gv_searchData = cfn_getFormData("frmSearch");
        var sid = "sid_getSearch";
        var url = "/sys/promotionCode/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }

    //요청한 데이터 처리 callback.
    function gfn_callback(sid, data) {
        //검색.
        if (sid == "sid_getSearch") {
            $("#grid").gfn_setDataList(data.resultList);
            $("#grid").gfn_focusPK();
        }
    }
    // 그리드 설정
    function setGridData() {
        var gid = "grid";
        var columns = [
                {
                    name : "promotionCode",
                    header : {
                        text : "코드명"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "codePeriod",
                    header : {
                        text : "코드명유효기간"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 250
                }, {
                    name : "codeCount",
                    header : {
                        text : "코드유효수량"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "discountPeriod",
                    header : {
                        text : "할인적용기간"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 250
                }, {
                    name : "premium",
                    header : {
                        text : "프리미엄 할인율"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "dhl",
                    header : {
                        text : "익스프레스 할인율"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "content",
                    header : {
                        text : "내용"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 250
                }, {
                    name : "promotionCodeSeq",
                    visible : false
                },
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
            // 체크박스 설정
            gridView.setCheckBar({
                visible : true,
                exclusive : false,
                showAll : true
            });
        });
        //그리드설정 및 이벤트처리
        $("#" + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            // 더블클릭 이벤트.
            gridView.onDataCellClicked = function(grid, data) {
                var promotionCodeSeq = grid.getValue(data.dataRow, "promotionCodeSeq");
                openLayerPopup("update", promotionCodeSeq);
            };
        });
    }
    
    // 그리드 행 삭제.
    function popDeleteRow() {
        var checkRows = $("#grid").gridView().getCheckedRows().reverse();
        var gridData = $("#grid").gfn_getDataRows(checkRows);
        var deleteList = [];
        if (checkRows.length == 0) {
            cfn_msg("WARNING", "선택된 행이 없습니다.");
            return;
        }

        if (confirm("정말로 삭제하시겠습니까?") == false) {
            return;
        }
        

        for (var i = 0; i < gridData.length; i++) {
            var promotionCodeSeq = $("#grid").gfn_getValue(checkRows[i], "promotionCodeSeq");
            
            deleteList.push({
                "promotionCodeSeq" : promotionCodeSeq
            });
        }
        
        for (var i = 0; i < checkRows.length; i++) {
            $("#grid").gfn_delRow(checkRows[i]);
        }

        var url = "/sys/promotionCode/pop/deletePromotionCode.do";
        var sendData = {
            dataList : deleteList
        };

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "삭제되었습니다..");
                cfn_retrieve();
            }
        });
       
    }

    // 팝업 호출.
    function openLayerPopup(type, data) {
        var url = "";
        var pid = "";
        var params = {};

        if (type == "create") {
            url = "/sys/promotionCode/pop/create/view.do";
            pid = "promotionCodePop";
        } else if (type == "update") {
            url = "/sys/promotionCode/pop/update/view.do?promotionCodeSeq="+ data;
            pid = "promotionCodeMPop";
        } else {
            cfn_msg("WARNING", "지정되지 않은 팝업입니다.");
        }

        pfn_popupOpen({
            url : url,
            pid : pid,
            params : params,
            returnFn : function(data, type) {
                if (type == "OK") {
                    cfn_retrieve();
                }
            }
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />