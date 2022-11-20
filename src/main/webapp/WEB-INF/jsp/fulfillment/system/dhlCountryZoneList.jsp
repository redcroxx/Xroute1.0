<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : DhlCountryZoneList
    화면명   : DHL 국가 존 목록
-->
<c:import url="/comm/contentTop.do" />
<!-- 그리드 시작 -->
<div id="ct_sech_wrap">
    <form id="formSearch" action="#">
        <ul class="sech_ul">
            <li class="sech_li">
                <div style="width: 70px;">국가명</div>
                <div>
                    <input type="text" id="sKeyword" name="sKeyword" class="cmc_code" style="width:100px;" />
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 70px;">국가 코드</div>
                <div>
                    <input type="text" id="sCountryCode" name="sCountryCode" class="cmc_code" style="width:100px;" />
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 70px;">ZONE</div>
                <div>
                    <input type="text" id="sZone" name="sZone" class="cmc_code" style="width:100px;" />
                </div>
            </li>
        </ul>
    </form>
</div>
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">국가코드
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
        // 3. 그리드 설정
        setGridData();
    });
    
    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        gv_searchData = cfn_getFormData("formSearch");
        var sid = "getSearch";
        var url = "/fulfillment/system/dhlCountryZone/getSearch.do";
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
                    name : "dhlCountryZoneSeq",
                    header : {
                        text : "존시퀀스"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
                    show : false
                }, {
                    name : "countryName",
                    header : {
                        text : "국가명"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 180,
                    editable : true
                }, {
                    name : "countryCode",
                    header : {
                        text : "국가코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "zone",
                    header : {
                        text : "ZONE"
                    },
                    styles : {
                        textAlignment : "center",
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
            var url = "/fulfillment/system/dhlCountryZone/updateCountryZone.do";
            var sendData = {"paramList" : dataList};
            gfn_ajax(url, true, sendData, function(data, xhr) {
                if (data.CODE == "1") {
                    cfn_msg("INFO", "DHL 국가 & 존 목록 수정 완료");
                    cfn_retrieve();
                }
            });
        }
    }
    
    /* 공통버튼 - 삭제 클릭 */
    function cfn_del() {
        var rowidx = $("#grid").gfn_getCurRowIdx();
        
        if (rowidx < 0) {
            cfn_msg("WARNING", "삭제할 행을 클릭하세요.");
            return false;
        }
        
        var countryData = $("#grid").gfn_getDataRow(rowidx);
        
        if (confirm("해당 국가 [" + countryData.countryName + "] 항목을 삭제 하시겠습니까?")) {
            var sid = "sid_setDelete";
            var url = "/fulfillment/system/dhlCountryZone/setDelete.do";
            var sendData = {"paramData":countryData};
            gfn_sendData(sid, url, sendData);
        }
    }

    // 상품 등록 팝업 호출.
    function openLayerPopup() {
        var url = "/fulfillment/system/dhlCountryZone/popView.do";
        var pid = "dhlCountryZonePop";
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