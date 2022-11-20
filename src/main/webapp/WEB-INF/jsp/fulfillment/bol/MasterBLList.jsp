<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : MasterBLList
    화면명   : MBL 목록
-->
<c:import url="/comm/contentTop.do" />
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
                <div style="width: 100px;">MBL/AWB</div>
                <div>
                    <input type="text" id="sKeyword" class="cmc_value" style="width: 150px;">
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 60px;">상태</div>
                <div>
                    <select id="sStatusCd">
                        <option value="">전체</option>
                        <option value="N">진행 중</option>
                        <option value="Y">완료</option>
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
            MBL 목록
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <input type="button" class="cmb_normal_new" value="완료 처리" onclick="setComplete()" />
            <input type="button" class="cmb_normal_new" value="등록" onclick="openLayerPopup('create')" />
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
        var url = "/fulfillment/bol/master/bl/getSearch.do";
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
                    name : "masterBlNo",
                    header : {
                        text : "MBL 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "airwayBill",
                    header : {
                        text : "항공화물 운송장"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "etd",
                    header : {
                        text : "출발 예정시간"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "etdComp",
                    header : {
                        text : "출발 완료시간"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "eta",
                    header : {
                        text : "도착 예정시간"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "etaComp",
                    header : {
                        text : "도착 완료시간"
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
                    name : "masterBlSeq",
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
                var masterBlNo = grid.getValue(data.dataRow, "masterBlNo");
                openLayerPopup("modify", masterBlNo);
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
            var masterBlNo = $("#grid").gfn_getValue(checkRows[i], "masterBlNo");
            var closeYn = $("#grid").gfn_getValue(checkRows[i], "closeYn");

            if (closeYn.trim().toUpperCase() == "N") {
                completeList.push({
                    "masterBlNo" : masterBlNo
                });
            }
        }

        if (completeList.length == 0) {
            cfn_msg("WARNING", "완료할 HBL이 없습니다.");
            return;
        }

        var url = "/fulfillment/bol/master/bl/setComplete.do";
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
    function openLayerPopup(obj, param) {
        var url = "";
        var pid = "";
        var params = {};

        if (obj == "create") {
            url = "/fulfillment/bol/master/bl/pop/create/view.do";
            pid = "createMasterBlPop";
        } else if (obj == "modify") {
            url = "/fulfillment/bol/master/bl/pop/view.do";
            pid = "masterBlPop";
            params.masterBlNo = param;
        } else {
            cfn_msg("ERROR", "오류가 발생하였습니다.");
            return;
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