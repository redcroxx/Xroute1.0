<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : AtomyBarcordList
    화면명   : 애터미 상품 바코드 정보
-->
<c:import url="/comm/contentTop.do" />
<!-- 그리드 시작 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
            애터미 상품 바코드 정보
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <input type="button" class="cmb_normal_new cbtn_upload" value="업로드" onclick="openLayerPopup();" style="min-width: 90px !important; text-align: right; margin-top: 4px;">
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
        // 3. 그리드 설정
        setGridData();
    });

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        gv_searchData = cfn_getFormData("formSearch");
        var sid = "getSearch";
        var url = "/fulfillment/atomy/barcord/getSearch.do";
        var sendData = gv_searchData;
        gfn_sendData(sid, url, sendData, true);
    }

    //요청한 데이터 처리 callback.
    function gfn_callback(sid, data) {
        //검색.
        if (sid == "getSearch") {
            $("#grid").gfn_setDataList(data.resultList);
            $("#grid").gfn_focusPK();
        }
    }
    // 그리드 설정
    function setGridData() {
        var gid = "grid";
        var columns = [
                {
                    name : "atomyBarcordSeq",
                    show : false
                }, {
                    name : "krProductCode",
                    header : {
                        text : "상품코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
                }, {
                    name : "krProductName",
                    header : {
                        text : "상품이름"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
                }, {
                    name : "barcord",
                    header : {
                        text : "바코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
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
            gridView.onDataCellDblClicked = function(grid, data) {
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

        if ($("#grid").gfn_checkValidateCells()) {
            return false;
        }
        if (confirm("수정하시겠습니까?")) {
            var url = "/fulfillment/atomy/barcord/setUpdate.do";
            var sendData = {
                "paramList" : dataList
            };
            gfn_ajax(url, true, sendData, function(data, xhr) {
                if (data.CODE == "1") {
                    cfn_msg("INFO", "목록 수정 완료");
                    cfn_retrieve();
                }
            });
        }
    }

    // 상품 등록 팝업 호출.
    function openLayerPopup() {
        var url = "/fulfillment/atomy/barcord/pop/view.do";
        var pid = "atomyBarcordPop";
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