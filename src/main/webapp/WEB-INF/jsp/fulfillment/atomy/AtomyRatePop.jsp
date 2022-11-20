<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : AtomyRatePop
    화면명   : 애터미 요율 등록 팝업
-->
<!-- 검색 시작 -->
<div id="atomyRatePop" class="pop_wrap">
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">애터미 요율 목록
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

    // 등록 컬럼.
    var _GRIDCOLUMNS = ["KG", "Italy", "Australia", "HongKong", "Japan", "Malaysia", "Mongolia", "NewZealand", "Singapore", "Taiwan", "USA", "Canada", "France", "Germany", "Switzerland", "UnitedKingdom", "Guam", "Saipan","Cambodia","Thailand","Philippines","Spain","Portugal","Russia"];
    
    // 초기 로드.
    $(function() {
        $("#atomyRatePop").lingoPopup({
            title : "애터미 요율 등록",
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
                // 엑셀업로드.
                $(".popbtnExcel").before("<form id='frmupload' action='#' method='post' enctype='multipart/form-data'>"
                + "<input type='file' accept='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel'"
                + "name='excelfile' id='xlf' class='popbtnleft' style='margin:10px 0 0 5px;' /></form>");
                
                $("#xlf").bind("click", function(e) {
                    // 검색조건 필수입력 체크/
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
                name : "KG",
                header : {
                    text : "무게(KG)"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 70
            }, {
                name : "Italy",
                header : {
                    text : "Italy"
                },
                styles : {
                    textAlignment : "center",
                },
                width : 100,
                editable : true
            }, {
                name : "Australia",
                header : {
                    text : "Australia",
                },
                styles : {
                    textAlignment : "center",
                },
                width : 100,
                editable : true
            
            }, {
                name : "HongKong",
                header : {
                    text : "HongKong"
                },
                styles : {
                    textAlignment : "center",
                },
                width : 100,
                editable : true
            }, {
                name : "Japan",
                header : {
                    text : "Japan"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Malaysia",
                header : {
                    text : "Malaysia"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Mongolia",
                header : {
                    text : "Mongolia"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "NewZealand",
                header : {
                    text : "NewZealand"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Singapore",
                header : {
                    text : "Singapore"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Taiwan",
                header : {
                    text : "Taiwan"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "USA",
                header : {
                    text : "USA"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Canada",
                header : {
                    text : "Canada"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "France",
                header : {
                    text : "France"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Germany",
                header : {
                    text : "Germany"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Switzerland",
                header : {
                    text : "Switzerland"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "UnitedKingdom",
                header : {
                    text : "UnitedKingdom"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Guam",
                header : {
                    text : "Guam"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Saipan",
                header : {
                    text : "Saipan"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Cambodia",
                header : {
                    text : "Cambodia"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Thailand",
                header : {
                    text : "Thailand"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Philippines",
                header : {
                    text : "Philippines"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Spain",
                header : {
                    text : "Spain"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Portugal",
                header : {
                    text : "Portugal"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "Russia",
                header : {
                    text : "Russia"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
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
        
        var url = "/fulfillment/atomy/rateList/pop/setSave.do";
        var param = cfn_getFormData("formPopSearch");
        var sendData = {"paramData" : param, "paramList" : gridDataList};
        
        gfn_ajax(url, true, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "애터미 요율표 등록 완료");
                $("#atomyRatePop").lingoPopup("close", "OK");
            }
        });
    }

</script>