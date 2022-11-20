<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : AtomyBoxSizePop
    화면명   : 애터미 국제 택배 사이즈 정보 등록
-->
<div id="atomyBoxSizePop" class="pop_wrap">
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">애터미 국제 택배 사이즈 정보 등록
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
    var _GRIDCOLUMNS = ["NO", "LENGTH", "WIDTH", "HEIGHT", "CBM", "WEIGHT"];
    
    // 초기 로드.
    $(function() {
        $("#atomyBoxSizePop").lingoPopup({
            title : "애터미 국제 택배 사이즈 정보 등록",
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
                name : "NO",
                header : {
                    text : "사이즈번호"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 150,
                editable : true
            }, {
                name : "LENGTH",
                header : {
                    text : "L(mm)"
                },
                styles : {
                    textAlignment : "center",
                },
                width : 100,
                editable : true
            }, {
                name : "WIDTH",
                header : {
                    text : "W(mm)",
                },
                styles : {
                    textAlignment : "center",
                },
                width : 100,
                editable : true
            
            }, {
                name : "HEIGHT",
                header : {
                    text : "H(mm)"
                },
                styles : {
                    textAlignment : "center",
                },
                width : 100,
                editable : true
            }, {
                name : "CBM",
                header : {
                    text : "CBM(체적)"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "WEIGHT",
                header : {
                    text : "볼륨중량(KG)"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 80,
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
    
    // 상품표 등록 및 저장.
    function setSave() {
        // grid에 있는 데이터 목록.
        var gridDataList = $("#popGrid").gfn_getDataList(true, false);
        
        if (gridDataList.length < 1) {
            cfn_msg("WARNING", "등록된 내역이 없습니다.");
            return false;
        }
        
        var url = "/fulfillment/atomy/boxSize/pop/setSave.do";
        var param = cfn_getFormData("formPopSearch");
        var sendData = {"paramData" : param, "paramList" : gridDataList};
        
        gfn_ajax(url, true, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "애터미 국제 택배 사이즈 정보 등록 완료");
                $("#atomyBoxSizePop").lingoPopup("close", "OK");
            }
        });
    }

</script>