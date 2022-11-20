<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : masterBlPop
    화면명   : MBL 팝업
-->
<!-- 검색 시작 -->
<div id="masterBlPop" class="pop_wrap">
    <div id="ct_sech_wrap">
        <form id="frmPopSearch" action="#" onsubmit="return false">
            <input type="hidden" id="compcd" value="<c:out value='${sessionScope.loginVO.compcd}' />" />
            <input type="hidden" id="shipmentBlSeq" />
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>MBL 번호</div>
                    <div>
                        <input type="text" class="cmc_value disabled" id="masterBlNo" disabled="disabled">
                    </div>
                </li>
                <li class="sech_li">
                    <div>AWB</div>
                    <div>
                        <input type="text" class="cmc_value" id="airwayBill">
                    </div>
                </li>
                <li class="sech_li">
                    <div>출발시간(예정)</div>
                    <div>
                        <input type="text" class="cmc_date" id="etd">
                    </div>
                </li>
                <li class="sech_li">
                    <div>출발시간(완료)</div>
                    <div>
                        <input type="text" class="cmc_date" id="etdComp">
                    </div>
                </li>
                <li class="sech_li">
                    <div>도착시간(예정)</div>
                    <div>
                        <input type="text" class="cmc_date" id="eta">
                    </div>
                </li>
                <li class="sech_li">
                    <div>도착시간(완료)</div>
                    <div>
                        <input type="text" class="cmc_date" id="etaComp">
                    </div>
                </li>
                <li class="sech_li" style="width: 300px;">
                    <div>상태</div>
                    <div id="closeYnNm" style="padding-top: 3px; padding-right: 5px; width: 150px;"></div>
                </li>
            </ul>
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>비고</div>
                    <div>
                        <textarea id="remark" rows="3" cols="130" onchange="changeCheck()"></textarea>
                    </div>
                </li>
            </ul>
            <button type="button" class="cmb_pop_search" onclick="getHouseBLList()"></button>
        </form>
    </div>
    <!-- 검색조건영역 끝 -->
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">
                HBL 목록
                <span>(총 0건)</span>
            </div>
            <div class="grid_top_right">
                <input type="button" class="cmb_minus" onclick="popDeleteRow()" />
            </div>
        </div>
        <div id="popGrid"></div>
    </div>
    <!-- 그리드 끝 -->
</div>
<script type="text/javascript">
    var _CHANGED = false;
    var _CLOSE_YN = "N";
    // 초기 로드
    $(function() {

        $("#masterBlPop").lingoPopup({
            title : "MBL 수정",
            width : 1000,
            height : 800,
            buttons : {
                "출발완료" : {
                    text : "출발완료",
                    click : function() {
                        setSave("etdComp");
                    }
                },
                "도착완료" : {
                    text : "도착완료",
                    click : function() {
                        setSave("etaComp");
                    }
                },
                "수정" : {
                    text : "수정",
                    click : function() {
                        setSave("data");
                    }
                },
                "닫기" : {
                    text : "닫기",
                    click : function() {
                        $(this).lingoPopup("setData", "");
                        $(this).lingoPopup("close", "CANCEL");
                    }
                }
            },
            open : function(data) {
                if (cfn_isEmpty(data.masterBlNo)) {
                    cfn_msg("ERROR", "오류가 발생하였습니다.");
                    return;
                }
                $("#masterBlNo").val(data.masterBlNo);
                getMasterBl();
                setPopGridData();
                getHouseBLList();
            }
        });
    });
    // 그리드 설정
    function setPopGridData() {
        var gid = "popGrid";
        var columns = [
                {
                    name : "houseBlNo",
                    header : {
                        text : "HBL 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "scacCode",
                    header : {
                        text : "scac코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "masterBlNo",
                    header : {
                        text : "MBL 번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "customsClearanceNm",
                    header : {
                        text : "통관구분"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 80
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
                    name : "houseBlSeq",
                    visible : false
                }, {
                    name : "closeYn",
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
            //열고정 설정
            gridView.setFixedOptions({
                colCount : 2,
                resizable : true,
                colBarWidth : 1
            });
            // 체크박스 설정
            gridView.setCheckBar({
                visible : true,
                exclusive : false,
                showAll : true
            });
        });
    }
    // 그리드 행 삭제
    function popDeleteRow() {
        var checkRows = $("#popGrid").gridView().getCheckedRows();
        var gridData = $("#popGrid").gfn_getDataRows(checkRows);

        if (_CLOSE_YN == "Y") {
            cfn_msg("WARNING", "완료된 MBL 입니다.");
            return;
        }

        if (checkRows.length == 0) {
            cfn_msg("WARNING", "선택된 행이 없습니다.");
            return;
        }

        if (confirm("정말로 삭제하시겠습니까?") == false) {
            return;
        }

        var houseBlNos = [];
        for (var i = 0; i < gridData.length; i++) {
            var houseBlNo = $("#popGrid").gfn_getValue(checkRows[i], "houseBlNo");
            houseBlNos.push({
                "houseBlNo" : houseBlNo
            });
        }

        var url = "/fulfillment/bol/master/bl/pop/deleteHouseBL.do";
        var sendData = {
            masterBlNo : $("#masterBlNo").val() || "",
            dataList : houseBlNos
        };

        gfn_ajax(url, true, sendData, function(result, xhr) {
            if (result.CODE == 1) {
                cfn_msg("INFO", "정상적으로 처리되었습니다.");
                getHouseBLList();
            } else {
                cfn_msg("ERROR", "오류가 발생하였습니다.");
            }
        });
    }
    // HBL 정보 가져오기
    function getHouseBLList() {
        $("#popGrid").gridView().cancel();
        gv_searchData = cfn_getFormData("frmPopSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/bol/master/bl/pop/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }
    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            $("#popGrid").gfn_setDataList(data.resultList);
        }
    }
    // MBL 정보 가져오기
    function getMasterBl() {
        var url = "/fulfillment/bol/master/bl/pop/getMasterBL.do";
        var sendData = {
            compcd : $("#compcd").val(),
            masterBlNo : $("#masterBlNo").val()
        };

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                if (cfn_isEmpty(data.resultData)) {
                    cfn_msg("INFO", "데이터가 없습니다.");
                    return;
                }
                _CLOSE_YN = data.resultData[0].closeYn.trim().toUpperCase();
                $("#masterBlNo").text(data.resultData[0].masterBlNo || "");
                $("#airwayBill").val(data.resultData[0].airwayBill || "");
                $("#etd").val(data.resultData[0].etd || "");
                $("#etdComp").val(data.resultData[0].etdComp || "");
                $("#eta").val(data.resultData[0].eta || "");
                $("#etaComp").val(data.resultData[0].etaComp || "");
                $("#remark").val(data.resultData[0].remark || "");
                $("#closeYnNm").text(data.resultData[0].closeYnNm || "");
            }
        });
    }
    // MBL 수정
    function setSave(type) {
        if (type == "data" && _CLOSE_YN == "Y") {
            cfn_msg("WARNING", "완료된 MBL입니다.");
            return;
        }

        if (confirm("정말로 수정하시겠습니까?") == false) {
            return;
        }

        if (type == "etdComp") {
            if ($("#etdComp").val() == "") {
                cfn_msg("ERROR", "출발 완료일자가 없습니다.");
                $("#etdComp").focus();
            }
        } else if (type == "etaComp") {
            if ($("#etaComp").val() == "") {
                cfn_msg("ERROR", "도착 완료일자가 없습니다.");
                $("#etaComp").focus();
            }
        }

        var url = "/fulfillment/bol/master/bl/pop/setSave.do";
        var sendData = {
            masterBlNo : $("#masterBlNo").val(),
            type : type
        };

        if (type == "data") {
            sendData.remark = (_CHANGED == true ? $("#remark").val() : "");
            sendData.airwayBill = $("#airwayBill").val() || "";
            sendData.etd = $("#etd").val();
            sendData.etdComp = $("#etdComp").val();
            sendData.eta = $("#eta").val();
            sendData.etaComp = $("#etaComp").val();
        } else if (type == "etdComp") {
            sendData.etdComp = $("#etdComp").val();
            sendData.eta = $("#eta").val();
        } else if (type == "etaComp") {
            sendData.etaComp = $("#etaComp").val();
        } else {
            cfn_msg("ERROR", "setSave에서 오류가 발생하였습니다.");
            return;
        }

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "저장되었습니다.");
                $("#masterBlPop").lingoPopup("setData", "");
                $("#masterBlPop").lingoPopup("close", "OK");
            }
        });
    }
    // 비고 변경 사항 확인
    function changeCheck() {
        _CHANGED = true;
    }
</script>