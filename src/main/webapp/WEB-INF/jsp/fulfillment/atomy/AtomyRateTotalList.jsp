<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/comm/contentTop.do" />
<!-- 그리드 시작 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">애터미 요율 목록 (종합)
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <input type="button" class="cmb_normal_new cbtn_upload" value="업로드" onclick="openLayerPopup();" style="min-width: 90px !important;text-align: right;margin-top: 4px;">
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
        $("#country").val("");
    }
    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        gv_searchData = cfn_getFormData("formSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/atomy/rateList/total/getSearch.do";
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
                    name : "kg",
                    header : {
                        text : "무게(KG)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 70
                }, {
                    name : "italy",
                    header : {
                        text : "Italy"
                    },
                    styles : {
                        textAlignment : "center",
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "australia",
                    header : {
                        text : "Australia",
                    },
                    styles : {
                        textAlignment : "center",
                    },
                    width : 100,
                    editable : true
                
                }, {
                    name : "hongKong",
                    header : {
                        text : "HongKong"
                    },
                    styles : {
                        textAlignment : "center",
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "japan",
                    header : {
                        text : "Japan"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "malaysia",
                    header : {
                        text : "Malaysia"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "mongolia",
                    header : {
                        text : "Mongolia"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "newZealand",
                    header : {
                        text : "NewZealand"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "singapore",
                    header : {
                        text : "Singapore"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "taiwan",
                    header : {
                        text : "Taiwan"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "usa",
                    header : {
                        text : "USA"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "canada",
                    header : {
                        text : "Canada"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "france",
                    header : {
                        text : "France"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "germany",
                    header : {
                        text : "Germany"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "switzerland",
                    header : {
                        text : "Switzerland"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "unitedKingdom",
                    header : {
                        text : "UnitedKingdom"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "guam",
                    header : {
                        text : "GUAM"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "saipan",
                    header : {
                        text : "SAIPAN"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "cambodia",
                    header : {
                        text : "Cambodia"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "thailand",
                    header : {
                        text : "Thailand"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "philippines",
                    header : {
                        text : "Philippines"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "spain",
                    header : {
                        text : "Spain"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "portugal",
                    header : {
                        text : "Portugal"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "russia",
                    header : {
                        text : "Russia"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
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
                    width : 150
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
                    width : 150
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

            // 더블클릭 이벤트.
            gridView.onDataCellDblClicked = function (grid, data) {
                var selectedRowIndex = $("#grid").gfn_getCurRowIdx();
                var rowData = $("#grid").gfn_getDataRow(selectedRowIndex);
            }
        });
    }
    
    // 저장.
    function cfn_save() {
        
        $("#grid").gridView().commit(true);
        var $grid = $("#grid");
        var dataList = $grid.gfn_getDataList(false);
        console.log(dataList);
        
        if (dataList.length < 1) {
            cfn_msg("WARNING", "변경된 항목이 없습니다.");
            return false;
        }
        
        // 변경 행 추출.
        var state = $grid.dataProvider().getAllStateRows();
        var stateRowIndex = state.updated;

        var selectedRowIndex = $("#grid").gfn_getCurRowIdx();
        var rowData = $("#grid").gfn_getDataRow(selectedRowIndex);
        if (selectedRowIndex < 0) {
            cfn_msg("WARNING", "저장할 정보가 없습니다.");
            return false;
        }
        
        if ($("#grid").gfn_checkValidateCells()){
            return false;
        }
        if (confirm("수정하시겠습니까?")) {
            var sid = "updateAtomyRateList";
            var url = "/fulfillment/atomy/rateList/total/updateAtomyRate.do";
            var param = cfn_getFormData("formSearch");
            var sendData = {"paramData" : param, "paramList" : dataList};
            gfn_sendData(sid, url, sendData);
            gfn_ajax(url, true, sendData, function(data, xhr) {
                if (data.CODE == "1") {
                    cfn_msg("INFO", "요율표 수정 완료");
                    cfn_retrieve();
                }
            });
        }
    }

    // 팝업 호출.
    function openLayerPopup() {
        var url = "/fulfillment/atomy/rateList/total/pop/view.do";
        var pid = "atomyRateTotalPop";
        var params = {};

        pfn_popupOpen({
            url : url,
            pid : pid,
            params : params,
            returnFn : function(data, type) {
            }
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />