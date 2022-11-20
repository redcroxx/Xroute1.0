<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : kseRatePop
    화면명   : KSE 요율 등록 팝업
-->
<!-- 검색 시작 -->
<div id="kseRatePop" class="pop_wrap">
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">
                요율 목록
                <span>(총 0건)</span>
            </div>
            <div class="grid_top_right">
                <input type="button" class="cmb_plus" onclick="popAddRow()" />
                <input type="button" class="cmb_minus" onclick="popDeleteRow()" />
            </div>
        </div>
        <div id="popGrid"></div>
    </div>
    <!-- 그리드 끝 -->
</div>
<script type="text/javascript">

    var _GRIDCOLUMNS = ["wgt", "sagawa", "nekopos", "smallCargo", "kPacket"];
    // 초기 로드
    $(function() {
        $("#kseRatePop").lingoPopup({
            title : "요율 등록",
            width : 1000,
            height : 800,
            buttons : {
                "저장" : {
                    class : "popbtnExcel",
                    text : "저장",
                    click : function() {
                        setSave();
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
            open : function() {
              //엑셀업로드
                $(".popbtnExcel").before("<form id='frmupload' action='#' method='post' enctype='multipart/form-data'>"
                + "<input type='file' accept='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel'"
                + "name='excelfile' id='xlf' class='popbtnleft' style='margin:10px 0 0 5px;' /></form>");
                
                $("#xlf").bind("click", function(e) {
                    //검색조건 필수입력 체크
                    if (cfn_isFormRequireData("frm_search_orderinsert") == false){
                        return false;
                    }
                    this.value = null; 
                });
                
                $("#xlf").bind("change", function(e){
                    gfn_handleXlsFile(e,"popGrid", _GRIDCOLUMNS);
                }); 
                
                setPopGridData();
            }
        });
    });
    // 그리드 설정
    function setPopGridData() {
        var gid = "popGrid";
        var columns = [
                {
                    name : "wgt",
                    header : {
                        text : "WGT"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "sagawa",
                    header : {
                        text : "SAGAWA"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true,
                    width : 150
                }, {
                    name : "nekopos",
                    header : {
                        text : "NEKOPOS"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true,
                    width : 150
                }, {
                    name : "smallCargo",
                    header : {
                        text : "SMALLCARGO"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true,
                    width : 150
                }, {
                    name : "kPacket",
                    header : {
                        text : "K-PACKET"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true,
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

            // 체크박스 설정
            gridView.setCheckBar({
                visible : true,
                exclusive : false,
                showAll : true
            });
        });
    }
    
    // 그리드 행 추가.
    function popAddRow() {
        $("#popGrid").gfn_addRow();
    }
    
    // 그리드 행 삭제.
    function popDeleteRow() {
        var checkRows = $("#popGrid").gridView().getCheckedRows().reverse();
        var gridData = $("#popGrid").gfn_getDataRows(checkRows);
        console.log(checkRows);
        console.log(gridData);
        if (checkRows.length == 0) {
            cfn_msg("WARNING", "선택된 행이 없습니다.");
            return;
        }

        if (confirm("정말로 삭제하시겠습니까?") == false) {
            return;
        }
        
        for (var i = 0; i < checkRows.length; i++) {
            $("#popGrid").gfn_delRow(checkRows[i]);
        }
       
    }
    
    // 요율표 등록 및 저장.
    function setSave() {
        // grid에 있는 데이터 목록.
        var gridDataList = $("#popGrid").gfn_getDataList(true, false);
        
        if (gridDataList.length < 1) {
            cfn_msg("WARNING", "등록된 내역이 없습니다.");
            return false;
        }
        
        var url = "/fulfillment/system/kseRate/pop/setSave.do";
        var sendData = {"paramList" : gridDataList};
        
        gfn_ajax(url, true, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "요율표 등록 완료");
                $("#kseRatePop").lingoPopup("close", "OK");
            }
        });
    }

</script>