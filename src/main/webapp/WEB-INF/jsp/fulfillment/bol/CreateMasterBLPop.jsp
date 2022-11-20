<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : createMasterBlPop
    화면명   : MBL 등록 팝업
-->
<!-- 검색 시작 -->
<div id="createMasterBlPop" class="pop_wrap">
    <div id="ct_sech_wrap">
        <form id="frmCPopSearch" action="#" onsubmit="return false">
            <input type="hidden" id="compcd" value="<c:out value='${sessionScope.loginVO.compcd}' />" />
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>MBL No</div>
                    <div>
                        <input type="text" class="cmc_value required" id="masterBlNo">
                    </div>
                </li>
            </ul>
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>출발시간(예정)</div>
                    <div>
                        <input type="text" class="cmc_date periods" id="etd">
                    </div>
                </li>
                <li class="sech_li">
                    <div>도착시간(예정)</div>
                    <div>
                        <input type="text" class="cmc_date periods" id="eta">
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
        </div>
        <div id="cPopGrid"></div>
    </div>
    <!-- 그리드 끝 -->
</div>
<script type="text/javascript">
    var _CHANGED = false;
    var _CLOSE_YN = "N";
    // 초기 로드
    $(function() {
        
        $("#etd").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#eta").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        
        $("#createMasterBlPop").lingoPopup({
            title : "MBL 등록",
            width : 1000,
            height : 800,
            buttons : {
                "저장" : {
                    text : "저장",
                    click : function() {
                        setSave("N");
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
            open : function() {
                setcPopGridData();
                getHouseBLList();
            }
        });
    });
    // 그리드 설정
    function setcPopGridData() {
        var gid = "cPopGrid";
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
                    width : 60
                }, {
                    name : "closeYnNm",
                    header : {
                        text : "상태"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 60
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
    // HBL 정보 가져오기
    function getHouseBLList() {
        $("#cPopGrid").gridView().cancel();
        gv_searchData = cfn_getFormData("frmCPopSearch");
        var sid = "sid_getSearch";
        var url = "/fulfillment/bol/master/bl/pop/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }
    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            $("#cPopGrid").gfn_setDataList(data.resultList);
        }
    }
    // HBL 수정 및 HBL 완료 저장
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

        var checkRows = $("#cPopGrid").gridView().getCheckedRows();
        var gridData = $("#cPopGrid").gfn_getDataRows(checkRows);
        var houseBlNos = [];
        var remark = "";

        if (cfn_isEmpty(checkRows)) {
            cfn_msg("WARNING", "항목이 선택되지 않았습니다.");
            return;
        }

        for (var i = 0; i < gridData.length; i++) {
            var houseBlNo = $("#cPopGrid").gfn_getValue(checkRows[i], "houseBlNo");
            houseBlNos.push({
                "houseBlNo" : houseBlNo
            });
        }

        if (_CHANGED == true) {
            remark = $("#remark").val() || "";
        }

        var url = "/fulfillment/bol/master/bl/pop/create/setSave.do";
        var sendData = {
            masterBlNo : $("#masterBlNo").val(),
            etd : $("#etd").val(),
            eta : $("#eta").val(),
            masterBlNo : $("#masterBlNo").val(),
            remark : remark,
            closeYn : type,
            dataList : houseBlNos
        };

        gfn_ajax(url, false, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "저장되었습니다.");
                $("#createMasterBlPop").lingoPopup("setData", "");
                $("#createMasterBlPop").lingoPopup("close", "OK");
            }
        });
    }
    // 비고 변경 사항 확인
    function changeCheck() {
        _CHANGED = true;
    }
</script>