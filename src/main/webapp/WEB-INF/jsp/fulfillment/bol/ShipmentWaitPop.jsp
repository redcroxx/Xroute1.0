<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : shipmentWaitPop
    화면명   : SBL 등록 팝업
-->
<!-- 검색 시작 -->
<div id="shipmentWaitPop" class="pop_wrap">
    <div id="ct_sech_wrap">
        <form id="frmPopSearch" action="#" onsubmit="return false">
            <ul class="sech_ul">
                <li class="sech_li required">
                    <div>국가</div>
                    <div>
                        <input type="text" id="country" list="countrylist">
                        <datalist id="countrylist">
                            <c:forEach var="i" items="${countrylist}">
                                <option value="${i.code}">${i.value}</option>
                            </c:forEach>
                        </datalist>
                    </div>
                </li>
                <li class="sech_li required">
                    <div>통관구분</div>
                    <div>
                        <select id="customsClearance">
                            <option value="">선택</option>
                            <option value="G">일반</option>
                            <option value="L">목록</option>
                        </select>
                    </div>
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
                <input type="button" id="btn_masterDel" class="cmb_minus" onclick="popDeleteRow()" />
            </div>
        </div>
        <div id="popGrid"></div>
    </div>
    <!-- 그리드 끝 -->
</div>
<script type="text/javascript">
    var _CHANGED = false;

    $(function() {
        $("#shipmentWaitPop").lingoPopup({
            title : "SBL 등록",
            width : 1000,
            height : 800,
            buttons : {
                "완료" : {
                    text : "완료",
                    click : function() {
                        if (confirm("정말로 등록하시겠습니까?") == false) {
                            return;
                        }
                        
                        var checkRows = $("#popGrid").gridView().getCheckedRows();
                        var gridData = $("#popGrid").gfn_getDataRows(checkRows);
                        var xrtInvcSnos = [];

                        if (cfn_isEmpty(checkRows)) {
                            cfn_msg("WARNING", "항목이 선택되지 않았습니다.");
                            return;
                        }

                        for (var i = 0; i < gridData.length; i++) {
                            var xrtInvcSno = $("#popGrid").gfn_getValue(checkRows[i], "xrtInvcSno");
                            xrtInvcSnos.push(xrtInvcSno);
                        }

                        var url = "/fulfillment/bol/shipment/wait/pop/setSave.do";
                        var sendData = {
                            remark : $("#remark").val() || "",
                            country : $("#country").val() || "",
                            customsClearance : $("#customsClearance").val() || "",
                            dataList : xrtInvcSnos,
                        };

                        gfn_ajax(url, false, sendData, function(data, xhr) {

                        });
                        setSave("Y");
                    }
                },
                "저장" : {
                    text : "등록",
                    click : function() {
                        setSave("N");
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
                setPopGridData();
                if (!cfn_isEmpty(data.gridData) && data.gridData.length > 0) {
                    $("#popGrid").gfn_setDataList(data.gridData);
                    $("#popGrid").gridView().checkAll(true, false);
                } else {
                    cfn_msg("ERROR", "데이터가 없습니다.");
                }
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
                    width : 100
                }, {
                    name : "shipTel",
                    header : {
                        text : "송화인 연락처"
                    },
                    width : 100
                }, {
                    name : "shipAddr",
                    header : {
                        text : "송화인 주소"
                    },
                    width : 200
                }, {
                    name : "recvName",
                    header : {
                        text : "수화인명"
                    },
                    width : 150
                }, {
                    name : "recvTel",
                    header : {
                        text : "수화인 전화번호"
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
                    width : 150
                }, {
                    name : "recvCity",
                    header : {
                        text : "수화인 도시"
                    },
                    width : 150
                }, {
                    name : "recvState",
                    header : {
                        text : "수화인 주"
                    },
                    width : 120
                }, {
                    name : "recvCurrency",
                    header : {
                        text : "통화"
                    },
                    width : 100
                }, {
                    name : "ordCnt",
                    header : {
                        text : "주문수량"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 30
                }, {
                    name : "cWgtCharge",
                    header : {
                        text : "실제 과금 중량(Kg)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "cWgtReal",
                    header : {
                        text : "실제 중량(Kg)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "xWgt",
                    header : {
                        text : "무게"
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
        var $gid = $("#popGrid");
        var rowidx = $gid.gfn_getCurRowIdx();

        if (rowidx == 0) {
            cfn_msg("WARNING", "선택된 행이 없습니다.");
            return false;
        }

        if (confirm("정말로 삭제하시겠습니까?") == false) {
            return;
        }

        $gid.gfn_delRow(rowidx);
    }
    // 선적 대기 및 선대 완료 저장
    function setSave(type) {

        var msg = "";

        if (type == "Y") {
            msg = "정말로 완료하시겠습니까?";
        } else {
            msg = "정말로 저장하시겠습니까?";
        }

        if (confirm(msg) == false) {
            return;
        }

        var checkRows = $("#popGrid").gridView().getCheckedRows();
        var gridData = $("#popGrid").gfn_getDataRows(checkRows);
        var orderList = [];
        var remark = "";
        var country = $("#country").val() || "";
        var customsClearance = $("#customsClearance").val() || "";

        if (cfn_isEmpty(checkRows)) {
            cfn_msg("WARNING", "항목이 선택되지 않았습니다.");
            return;
        }
        
        if (country == "") {
            cfn_msg("WARNING", "국가가 선택되지 않았습니다.");
            $("#country").focus();
            return;
        }
        
        if (customsClearance == "") {
            cfn_msg("WARNING", "통관이 선택되지 않았습니다.");
            $("#customsClearance").focus();
            return;
        }
        

        for (var i = 0; i < gridData.length; i++) {
            var xrtInvcSno = $("#popGrid").gfn_getValue(checkRows[i], "xrtInvcSno");
            var eNation = $("#popGrid").gfn_getValue(checkRows[i], "eNation");
            orderList.push({
                "xrtInvcSno" : xrtInvcSno,
                "eNation" : eNation,
            });
        }

        if (_CHANGED == true) {
            remark = $("#remark").val() || "";
        }

        var url = "/fulfillment/bol/shipment/wait/pop/setSave.do";
        var sendData = {
            customsClearance : customsClearance,
            country : country,
            remark : remark,
            closeYn : type,
            dataList : orderList
        };

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "저장되었습니다.");
                $("#shipmentWaitPop").lingoPopup("setData", "");
                $("#shipmentWaitPop").lingoPopup("close", "OK");
            }
        });
    }
    // 비고 변경 사항 확인
    function changeCheck() {
        _CHANGED = true;
    }
</script>