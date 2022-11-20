<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : AtomyProductList
    화면명   : 애터미 상품 목록
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="formSearch" action="#">
        <ul class="sech_ul">
            <li class="sech_li">
                <div style="width: 80px;">상품명(한글)</div>
                <div>
                    <input type="text" id="sKeyword" name="sKeyword" class="cmc_code" style="width:100px;" />
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 70px;">제품 코드</div>
                <div>
                    <input type="text" id="sKrProductCode" name="sKrProductCode" class="cmc_code" style="width:100px;" />
                </div>
            </li>
        </ul>
    </form>
</div>
<!-- 검색 끝 -->
<!-- 그리드 시작 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">애터미 상품 목록
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
        // $("#grid").gridView().cancel();
        
        /* var country = $("#country").val();
        if (country == "") {
            cfn_msg("WARNING", "국가를 선택하세요.");
            return false;
        } */
        
        gv_searchData = cfn_getFormData("formSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/atomy/productList/getSearch.do";
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
                    name : "atomyProductSeq",
                    header : {
                        text : "시퀀스"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
                    show : false
                }, {
                    name : "type",
                    header : {
                        text : "구분"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "krProductName",
                    header : {
                        text : "상품명(한글)"
                    },
                    styles : {
                        textAlignment : "center",
                    },
                    width : 250,
                    editable : true
                }, {
                    name : "krProductCode",
                    header : {
                        text : "한국 판매 제품 코드",
                    },
                    styles : {
                        textAlignment : "center",
                    },
                    width : 100,
                    editable : true
                
                }, {
                    name : "odpCode",
                    header : {
                        text : "역직구몰 판매코드"
                    },
                    styles : {
                        textAlignment : "center",
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "usaFdaProductNo",
                    header : {
                        text : "미국 FDA 제품 등록번호"
                    },
                    styles : {
                        textAlignment : "center",
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "canadaFdaProductNo",
                    header : {
                        text : "캐나다 FDA 제품 등록번호"
                    },
                    styles : {
                        textAlignment : "center",
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "price",
                    header : {
                        text : "판매수량당 평균 제품단가(원)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "length",
                    header : {
                        text : "L(mm)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80,
                    editable : true
                }, {
                    name : "width",
                    header : {
                        text : "W(mm)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80,
                    editable : true
                }, {
                    name : "height",
                    header : {
                        text : "H(mm)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80,
                    editable : true
                }, {
                    name : "kg",
                    header : {
                        text : "제품 개당 총 중량(KG)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "cbm",
                    header : {
                        text : "CBM"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80,
                    editable : true
                },{
                    name : "volumeWeight",
                    header : {
                        text : "부피 중량(KG)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100,
                    editable : true
                }, {
                    name : "enProductName",
                    header : {
                        text : "상품명(영문)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 320,
                    editable : true
                }, {
                    name : "hsCode",
                    header : {
                        text : "HS CODE"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
                    editable : true
                }, {
                    name : "origin",
                    header : {
                        text : "원산지"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
                    editable : true
                }, {
                    name : "zone",
                    header : {
                        text : "ZONE"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
                    editable : true
                }, {
                    name : "rack",
                    header : {
                        text : "실물기준"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150,
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
            var url = "/fulfillment/atomy/productList/updateAtomyProduct.do";
            var param = cfn_getFormData("formSearch");
            var sendData = {"paramData" : param, "paramList" : dataList};
            gfn_sendData(sid, url, sendData);
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
        var url = "/fulfillment/atomy/productList/pop/view.do";
        var pid = "atomyProductPop";
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