<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : DhlCountryZonePop
    화면명   : DHL 국가 존 등록
-->
<div id="dhlCountryZonePop" class="pop_wrap">
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">국가코드, 존 등록
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
    var _GRIDCOLUMNS = ["COUNTRY_NAME", "COUNTRY_CODE", "ZONE"];
    
    // 초기 로드.
    $(function() {
        $("#dhlCountryZonePop").lingoPopup({
            title : "국가코드, 존 등록",
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
                name : "COUNTRY_NAME",
                header : {
                    text : "국가명"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 150,
                editable : true
            }, {
                name : "COUNTRY_CODE",
                header : {
                    text : "국가코드"
                },
                styles : {
                    textAlignment : "center",
                },
                width : 100,
                editable : true
            }, {
                name : "ZONE",
                header : {
                    text : "ZONE",
                },
                styles : {
                    textAlignment : "center",
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
    
    // 상품표 등록 및 저장.
    function setSave() {
        // grid에 있는 데이터 목록.
        var gridDataList = $("#popGrid").gfn_getDataList(true, false);
        
        if (gridDataList.length < 1) {
            cfn_msg("WARNING", "등록된 내역이 없습니다.");
            return false;
        }
        
        var url = "/fulfillment/system/dhlCountryZone/setSave.do";
        var param = cfn_getFormData("formPopSearch");
        var sendData = {"paramData" : param, "paramList" : gridDataList};
        
        gfn_ajax(url, true, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "DHL 국가 존 등록 완료");
                $("#dhlCountryZonePop").lingoPopup("close", "OK");
            }
        });
    }

</script>