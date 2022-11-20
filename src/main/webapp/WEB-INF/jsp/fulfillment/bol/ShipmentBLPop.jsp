<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : shipmentBLPop
    화면명   : SBL 수정 팝업
-->
<!-- 검색 시작 -->
<div id="shipmentBlPop" class="pop_wrap">
    <div id="ct_sech_wrap">
        <form id="frmPopSearch" action="#" onsubmit="return false">
            <input type="hidden" id="compcd" value="<c:out value='${sessionScope.loginVO.compcd}' />" />
            <input type="hidden" id="shipmentBlSeq" />
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>SBL 번호</div>
                    <div style="width: 200px;">
                        <input type="text" class="cmc_value disabled" id="shipmentBlNo" disabled="disabled" />
                    </div>
                </li>
                <li class="sech_li">
                    <div>HBL 번호</div>
                    <div id="houseBlNo" style="padding-top: 3px; padding-right: 5px; width: 195px;"></div>
                </li>
                <li class="sech_li">
                    <div>선적 상태</div>
                    <div id="closeYnNm" style="padding-top: 3px; padding-right: 5px; width: 195px;"></div>
                </li>
            </ul>
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>국가</div>
                    <div id="country" style="padding-top: 3px; padding-right: 5px; width: 195px;"></div>
                </li>
                <li class="sech_li">
                    <div>통관구분</div>
                    <div id="customsClearanceNm" style="padding-top: 3px; padding-right: 5px; width: 195px;"></div>
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
            <button type="button" class="cmb_pop_search" onclick="getOrderList()"></button>
        </form>
    </div>
    <!-- 검색조건영역 끝 -->
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">
                주문 목록
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
        $("#shipmentBlPop").lingoPopup({
            title : "SBL 수정",
            width : 1000,
            height : 800,
            buttons : {
                "상태변경" : {
                    text : "상태변경",
                    click : function() {
                        setSave("closeYn");
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
                if (cfn_isEmpty(data.shipmentBlNo)) {
                    cfn_msg("ERROR", "오류가 발생하였습니다.");
                    return;
                }

                $("#compcd").val("<c:out value='${sessionScope.loginVO.compcd}' />");
                $("#shipmentBlNo").val(data.shipmentBlNo);
                getShipmentBL();
                setPopGridData();
                getOrderList();
            }
        });
    });
    // 그리드 설정
    function setPopGridData() {
        var gid = "popGrid";
        var columns = [
                {
                    name : "xrtInvcSno",
                    header : {
                        text : "송장번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "orgcd",
                    header : {
                        text : "셀러코드"
                    },

                    styles : {
                        textAlignment : "center"
                    },
                    width : 80
                }, {
                    name : "stockDate",
                    header : {
                        text : "입고 일자"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "statusCdKr",
                    header : {
                        text : "주문배송상태"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 140
                }, {
                    name : "shipMethodCd",
                    header : {
                        text : "서비스 타입"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "eNation",
                    header : {
                        text : "도착국가"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 70
                }, {
                    name : "shipName",
                    header : {
                        text : "송화인명"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "shipTel",
                    header : {
                        text : "송화인 연락처"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "shipAddr",
                    header : {
                        text : "송화인 주소"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 200
                }, {
                    name : "recvName",
                    header : {
                        text : "수화인명"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "recvTel",
                    header : {
                        text : "수화인 전화번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 130
                }, {
                    name : "recvMobile",
                    header : {
                        text : "수화인 핸드폰 번호"
                    },
                    width : 130
                }, {
                    name : "recvAddr1",
                    header : {
                        text : "수화인 주소1"
                    },
                    width : 200
                }, {
                    name : "recvAddr2",
                    header : {
                        text : "수화인 주소2"
                    },
                    width : 200
                }, {
                    name : "recvPost",
                    header : {
                        text : "수화인 우편번호"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "recvCity",
                    header : {
                        text : "수화인 도시"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "recvState",
                    header : {
                        text : "수화인 주"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 120
                }, {
                    name : "recvCurrency",
                    header : {
                        text : "통화"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
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
            cfn_msg("WARNING", "완료된 선적입니다.");
            return;
        }

        if (checkRows.length == 0) {
            cfn_msg("WARNING", "선택된 행이 없습니다.");
            return;
        }

        if (confirm("정말로 삭제하시겠습니까") == false) {
            return;
        }

        var xrtInvcSnoList = [];
        for (var i = 0; i < gridData.length; i++) {
            var xrtInvcSno = $("#popGrid").gfn_getValue(checkRows[i], "xrtInvcSno");
            xrtInvcSnoList.push({
                "xrtInvcSno" : xrtInvcSno
            });
        }

        var url = "/fulfillment/bol/shipment/bl/pop/deleteTOrder.do";
        var sendData = {
            shipmentBlNo : $("#shipmentBlNo").val() || "",
            statusCd : "30",
            dataList : xrtInvcSnoList
        };

        gfn_ajax(url, true, sendData, function(result, xhr) {
            if (result.CODE == 1) {
                cfn_msg("INFO", "정상적으로 처리되었습니다.");
                getOrderList();
            } else {
                cfn_msg("ERROR", "오류가 발생하였습니다.");
            }
        });
    }
    // 선적 된 주문 정보 가져오기
    function getOrderList() {
        $("#popGrid").gridView().cancel();
        gv_searchData = cfn_getFormData("frmPopSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/bol/shipment/bl/pop/getOrderList.do";
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
    // 선적 정보 가져오기
    function getShipmentBL() {
        var url = "/fulfillment/bol/shipment/bl/pop/getShipmentBl.do";
        var sendData = {
            compcd : $("#compcd").val(),
            shipmentBlNo : $("#shipmentBlNo").val()
        };

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                if (cfn_isEmpty(data.resultData)) {
                    cfn_msg("INFO", "데이터가 없습니다.");
                    return;
                }
                _CLOSE_YN = data.resultData[0].closeYn.trim().toUpperCase();
                $("#shipmentBlSeq").val(data.resultData[0].shipmentBlSeq || "");
                $("#houseBlNo").text(data.resultData[0].houseBlNo || "");
                $("#closeYnNm").text(data.resultData[0].closeYnNm || "");
                $("#country").text(data.resultData[0].country || "");
                $("#customsClearanceNm").text(data.resultData[0].customsClearanceNm || "");
                $("#remark").text(data.resultData[0].remark || "");
            }
        });
    }
    // 선적 수정 및 선적 완료 저장
    function setSave(type) {

        var stop = false;
        if (type == "data" && _CLOSE_YN == "Y") {
            cfn_msg("WARNING", "완료된 SBL입니다.");
            return;
        }

        if (type == "closeYn") {
            if (confirm("현재 상태는 '" + $("#closeYnNm").text() + "' 입니다.\n상태를 변경 하시겠습니까?") == false) {
                stop = true;
            }
        }

        if (stop) {
            return;
        }

        var url = "/fulfillment/bol/shipment/bl/pop/setSave.do";
        var sendData = {
            shipmentBlNo : $("#shipmentBlNo").val(),
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
                $("#shipmentBlPop").lingoPopup("setData", "");
                $("#shipmentBlPop").lingoPopup("close", "OK");
            }
        });
    }
    // 비고 변경 사항 확인
    function changeCheck() {
        _CHANGED = true;
    }
</script>