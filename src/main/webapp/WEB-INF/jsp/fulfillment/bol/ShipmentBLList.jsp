<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : ShipmentBLList
    화면명   : SBL 목록
-->
<c:import url="/comm/contentTop.do" />
<style>
.likeabutton {
    text-decoration: none; 
    font: menu;
    display: inline-block; 
    padding: 2px 8px;
    background: ButtonFace; 
    color: ButtonText;
    border-style: solid; 
    border-width: 2px;
    border-color: ButtonHighlight ButtonShadow ButtonShadow ButtonHighlight;
}
.likeabutton:active {
    border-color: ButtonShadow ButtonHighlight ButtonHighlight ButtonShadow;
}
</style>
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" class="cmc_txt" id="sCompCd" value="<c:out value='${sessionScope.loginVO.compcd}' />" />
        <ul class="sech_ul">
            <li class="sech_li required">
                <div>생성 일자</div>
                <div>
                    <input type="text" id="sToDate" class="cmc_date periods required">
                    ~
                    <input type="text" id="sFromDate" class="cmc_date periods required">
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 160px;">번호(MBL 제외)</div>
                <div>
                    <input type="text" id="sKeyword" class="cmc_value" style="width: 200px;">
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 160px;">서비스 타입</div>
                <div>
                    <select id="sKeywordType">
                        <option selected="selected" value="PREMIUM">PREMIUM</option>
                        <option value="DHL">DHL</option>
                        <option value="UPS">UPS</option>
                    </select>
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
            SBL 목록
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <a class="likeabutton " onclick="excelDownload();" style="padding-bottom: 4px;">엑셀파일 저장</a>
            <input type="button" class="cmb_normal_new" value="완료 처리" onclick="setComplete()" />
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
        var url = "/fulfillment/bol/shipment/bl/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }
    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
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
                    name : "shipmentBlNo",
                    header : {
                        text : "SBL 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "houseBlNo",
                    header : {
                        text : "HBL 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "country",
                    header : {
                        text : "국가"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "customsClearanceNm",
                    header : {
                        text : "통관"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "closeYnNm",
                    header : {
                        text : "상태"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80
                }, {
                    name : "remark",
                    header : {
                        text : "비고"
                    },
                    width : 350
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
                    width : 130
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
                    width : 130
                }, {
                    name : "shipmentBlSeq",
                    visible : false
                }, {
                    name : "closeYn",
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
            gridView.onDataCellClicked = function(grid, data) {
                var shipmentBlNo = grid.getValue(data.dataRow, "shipmentBlNo");
                openLayerPopup(shipmentBlNo);
            };
        });
    }
    //
    function setComplete() {
        if (confirm("정말로 상태를 변경 하시겠습니까?") == false) {
            return;
        }

        var checkRows = $("#grid").gridView().getCheckedRows();
        var gridData = $("#grid").gfn_getDataRows(checkRows);
        var completeList = [];

        if (checkRows.length == 0) {
            cfn_msg("WARNING", "선택된 행이 없습니다.");
            return;
        }

        for (var i = 0; i < gridData.length; i++) {
            var shipmentBlNo = $("#grid").gfn_getValue(checkRows[i], "shipmentBlNo");
            var closeYn = $("#grid").gfn_getValue(checkRows[i], "closeYn");

            if (closeYn.trim().toUpperCase() == "N") {
                completeList.push({
                    "shipmentBlNo" : shipmentBlNo
                });
            }
        }

        if (completeList.length == 0) {
            cfn_msg("WARNING", "이미 완료된 선적입니다.");
            return;
        }

        var url = "/fulfillment/bol/shipment/bl/setComplete.do";
        var sendData = {
            dataList : completeList
        };

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "저장되었습니다.");
                cfn_retrieve();
            }
        });
    }
    // 팝업 호출 공통
    function openLayerPopup(obj) {
        var url = "/fulfillment/bol/shipment/bl/pop/view.do";
        var pid = "shipmentBlPop";
        var params = {
            shipmentBlNo : obj
        };

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
    
    // 선택한 행 정보 엑셀 다운로드.
    function excelDownload() {
        var checkRows = $("#grid").gridView().getCheckedRows();
        var gridData = $("#grid").gfn_getDataRows(checkRows);
        var shipmentBlNos = "";
        for (var i = 0; i < gridData.length; i++) {
            var shipmentBlNo = $("#grid").gfn_getValue(checkRows[i], "shipmentBlNo");
            if (i == 0) {
                shipmentBlNos += shipmentBlNo;
            }else {
                shipmentBlNos += ";" + shipmentBlNo;
            }
        }

        if (shipmentBlNos == "") {
            cfn_msg("ERROR", "선택된 데이터가 없습니다.");
            return;
        }
        
        var url = "/fulfillment/bol/shipment/bl/excelDownload.do?shipmentBlNos=" + shipmentBlNos;
        
        location.href = url;
    }
</script>
<c:import url="/comm/contentBottom.do" />