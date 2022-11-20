<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : houseBlPop
    화면명   : HBL 팝업
-->
<!-- 검색 시작 -->
<div id="houseBlPop" class="pop_wrap">
    <div id="ct_sech_wrap">
        <form id="frmPopSearch" action="#" onsubmit="return false">
            <input type="hidden" id="compcd" value="<c:out value='${sessionScope.loginVO.compcd}' />" />
            <input type="hidden" id="shipmentBlSeq" />
            <ul class="sech_ul">
                <li class="sech_li" style="width: 300px;">
                    <div>HBL 번호</div>
                    <div style="width: 150px;">
                        <input type="text" class="cmc_value disabled" id="houseBlNo" disabled="disabled" />
                    </div>
                </li>
                <li class="sech_li"  style="width: 300px;">
                    <div>Scac Code</div>
                    <div id="scacCode" style="padding-top: 3px; padding-right: 5px; width: 150px;"></div>
                </li>
            </ul>
            <ul class="sech_ul">
                <li class="sech_li"  style="width: 300px;">
                    <div>MBL 번호</div>
                    <div id="masterBlNo" style="padding-top: 3px; padding-right: 5px; width: 150px;"></div>
                </li>
                <li class="sech_li"  style="width: 300px;">
                    <div>통관</div>
                    <div style="width: 150px;">
                        <select id="customsClearance">
                            <option value="">선택</option>
                            <option value="general">일반</option>
                            <option value="list">목록</option>
                        </select>
                    </div>
                </li>
                <li class="sech_li"  style="width: 300px;">
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
            <button type="button" class="cmb_pop_search" onclick="getShipmentBLList()"></button>
        </form>
    </div>
    <!-- 검색조건영역 끝 -->
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">
                SBL 목록 <span>(총 0건)</span>
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
        $("#houseBlPop").lingoPopup({
            title : "HBL 수정",
            width : 1000,
            height : 800,
            buttons : {
                "완료" : {
                    text : "상태변경",
                    click : function() {
                        setSave("closeYn");
                    }
                },
                "저장" : {
                    text : "수정",
                    click : function() {
                        setSave("data");
                    }
                },
                "취소" : {
                    text : "닫기",
                    click : function() {
                        $(this).lingoPopup("setData", "");
                        $(this).lingoPopup("close", "CANCEL");
                    }
                }
            },
            open : function(data) {
                if (cfn_isEmpty(data.houseBlNo)) {
                    cfn_msg("ERROR", "오류가 발생하였습니다.");
                    return;
                }
                $("#houseBlNo").val(data.houseBlNo);
                getHouseBl();
                setPopGridData();
                getShipmentBLList();
            }
        });
    });
    // 그리드 설정
    function setPopGridData() {
        var gid = "popGrid";
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
            cfn_msg("WARNING", "완료된 SBL입니다.");
            return;
        }

        if (checkRows.length == 0) {
            cfn_msg("WARNING", "선택된 행이 없습니다.");
            return;
        }

        if (confirm("정말로 삭제하시겠습니까") == false) {
            return;
        }

        var shipmentBlNoList = [];
        for (var i = 0; i < gridData.length; i++) {
            var shipmentBlNo = $("#popGrid").gfn_getValue(checkRows[i], "shipmentBlNo");
            shipmentBlNoList.push({
                "shipmentBlNo" : shipmentBlNo
            });
        }

        var url = "/fulfillment/bol/house/bl/pop/deleteShipmentBL.do";
        var sendData = {
            houseBlNo : $("#houseBlNo").val() || "",
            dataList : shipmentBlNoList
        };

        gfn_ajax(url, true, sendData, function(result, xhr) {
            if (result.CODE == 1) {
                cfn_msg("INFO", "정상적으로 처리되었습니다.");
                getShipmentBLList();
            } else {
                cfn_msg("ERROR", "오류가 발생하였습니다.");
            }
        });
    }
    // SBL 목록 가져오기
    function getShipmentBLList() {
        $("#popGrid").gridView().cancel();
        gv_searchData = cfn_getFormData("frmPopSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/bol/house/bl/pop/getSearch.do";
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
    // HBL 정보 가져오기
    function getHouseBl() {
        var url = "/fulfillment/bol/house/bl/pop/getHouseBL.do";
        var sendData = {
            compcd : $("#compcd").val(),
            houseBlNo : $("#houseBlNo").val()
        };

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                if (cfn_isEmpty(data.resultData)) {
                    cfn_msg("INFO", "데이터가 없습니다.");
                    return;
                }
                _CLOSE_YN = data.resultData[0].closeYn.trim().toUpperCase();
                $("#scacCode").text(data.resultData[0].scacCode || "");
                $("#masterBlNo").text(data.resultData[0].masterBlNo || "");
                $("#customsClearance").val(data.resultData[0].customsClearance || "");
                $("#closeYnNm").text(data.resultData[0].closeYnNm || "");
                $("#remark").text(data.resultData[0].remark || "");
            }
        });
    }
    // HBL 수정 및 상태 완료 저장
    function setSave(type) {

        var stop = false;

        if (type == "data" && _CLOSE_YN == "Y") {
            cfn_msg("WARNING", "완료된 SBL 입니다.");
            return;
        }

        if (type == "closeYn") {
            if (confirm("현재 상태는 '" + $("#closeYnNm").text() + "' 입니다.\n상태를 변경 하시겠습니까?") == false) {
                stop = true;
            }
        } else {
            if (confirm("정말로 수정하시겠습니까") == false) {
                stop = true;
            }
        }

        if (stop) {
            return;
        }

        var url = "/fulfillment/bol/house/bl/pop/setSave.do";
        var sendData = {
            houseBlNo : $("#houseBlNo").val(),
            type : type
        };

        if (type == "data") {
            sendData.remark = (_CHANGED == true ? $("#remark").val() : "");
        } else if (type == "closeYn") {
            sendData.closeYn = (_CLOSE_YN == "Y" ? "N" : "Y");
        } else {
            cfn_msg("ERROR", "setSave에서 오류가 발생하였습니다.");
            return;
        }

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "저장되었습니다.");
                $("#houseBlPop").lingoPopup("setData", "");
                $("#houseBlPop").lingoPopup("close", "OK");
            }
        });
    }
    // 비고 변경 사항 확인
    function changeCheck() {
        _CHANGED = true;
    }
</script>