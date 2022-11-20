<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
화면코드 : PassBookList
화면명   : 내통장 결제 목록
-->
<!-- 고정탭 구분을 위한 체크 값-->
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" id="compcd" value="<c:out value='${sessionScope.loginVO.compcd}' />">
        <ul class="sech_ul">
            <li class="sech_li">
                <div>셀러</div>
                <div>
                    <input type="text" id="orgcd" class="cmc_code disabled" disabled="disabled">
                    <input type="text" id="orgnm" class="cmc_value" onchange="inputClear('orgcd')">
                    <button type="button" class="cmc_cdsearch" onclick="openLayerPopup('orgcd')"></button>
                </div>
            </li>
            <li class="sech_li">
                <div>셀러ID</div>
                <div>
                    <input type="text" class="cmc_code" id="usercd" style="width: 130px;">
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
            내통장 정기결제 목록
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <button type="button" id="regularCancel" onclick="regularCancel()">정기결제 취소</button>
        </div>
        <div class="grid_top_right"></div>
    </div>
    <div id="grid"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    //초기 로드
    $(function() {
        // 1. 화면레이아웃 지정 (리사이징)
        initLayout();
        // 2. 검색조건 기초설정
        cfn_init();
        // 3. 그리드 초기화
        setGridData();
        // 4. 초기검색
        cfn_retrieve();

    });

    function setGridData() {
        var gid = "grid";
        var columns = [
                {
                    name : "orgcd",
                    header : {
                        text : "셀러코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "usercd",
                    header : {
                        text : "셀러코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "ordNo",
                    header : {
                        text : "주문번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
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
                    name : "compcd",
                    visible : false
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
            // 체크박스 설정
            gridView.setCheckBar({
                visible : true,
                exclusive : false,
                showAll : true
            });
        });
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            // console.log(data.resultList);
            $("#grid").gfn_setDataList(data.resultList);
        }
    }

    function cfn_init() {
        $("#orgcd").val("");
        $("#orgnm").val("");
    }

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        $("#grid").gridView().cancel();
        gv_searchData = cfn_getFormData("frmSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/payment/passBookList/regular/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }

    // 레이어 팝업 호출 공통
    function openLayerPopup(elemId, jsonObj) {
        var url = "";
        var pid = "";
        var params = {
            S_COMPCD : ($("#compcd").val() || ""),
            gridData : []
        };

        if (elemId == "sWhcd") {
            url = "/alexcloud/popup/popP004/view.do";
            pid = "popP004";
            params.S_WHCD = $("#sWhnm").val() || "";
        } else if (elemId == "orgcd") {
            url = "/alexcloud/popup/popP002/view.do";
            pid = "popP002";
            params.S_ORGCD = $("#orgnm").val() || "";
        } else {
            cfn_msg("ERROR", "오류가 발생 하였습니다..");
            return;
        }

        pfn_popupOpen({
            url : url,
            pid : pid,
            params : params,
            returnFn : function(data, type) {
                if (type == "OK") {
                    if (elemId == "sWhcd") {
                        $("#sWhcd").val(data[0].WHCD || "");
                        $("#sWhnm").val(data[0].NAME || "");
                    } else if (elemId == "orgcd") {
                        $("#orgcd").val(data[0].ORGCD || "");
                        $("#orgnm").val(data[0].NAME || "");
                    } else {
                    }
                }
            }
        });
    }
    // 창고 및 셀러 이름 변경시 초기화
    function inputClear(elemId) {
        $("#" + elemId).val("");
    }

    function regularCancel() {

        var checkRows = $("#grid").gridView().getCheckedRows();
        var gridData = $("#grid").gfn_getDataRows(checkRows);
        var paramList = [];

        if (checkRows.length == 0) {
            cfn_msg("WARNING", "선택된 행이 없습니다.");
            return;
        }
        
        console.log("gridData.length", gridData.length);

        for (var i = 0; i < gridData.length; i++) {
            var orgcd = $("#grid").gfn_getValue(checkRows[i], "orgcd");
            var compcd = $("#grid").gfn_getValue(checkRows[i], "compcd");
            paramList.push({
                "compcd" : compcd,
                "orgcd" : orgcd
            });
        }

        var url = "/sys/passBook/regularCancel.do";
        var sendData = {
            dataList : paramList
        };

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "저장되었습니다.");
                cfn_retrieve();
            }
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />