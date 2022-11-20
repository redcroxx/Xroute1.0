<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : AtomyProductPop
    화면명   : 애터미 상품 등록 팝업
-->
<!-- 검색 시작 -->
<div id="atomyProductPop" class="pop_wrap">
    <!-- 검색조건영역 끝 -->
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">애터미 상품 목록
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
    var _GRIDCOLUMNS = ["TYPE", "KR_PRODUCT_NAME", "KR_PRODUCT_CODE", "ODP_CODE", "USA_FDA_PRODUCT_NO", "CANADA_FDA_PRODUCT_NO", "PRICE", "LENGTH", "WIDTH", "HEIGHT", "KG", "CBM", "VOLUME_WEIGHT", "EN_PRODUCT_NAME", "HS_CODE", "ORIGIN", "ZONE", "RACK"];
    
    // 초기 로드.
    $(function() {
        $("#atomyProductPop").lingoPopup({
            title : "애터미 상품 등록",
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
                name : "TYPE",
                header : {
                    text : "구분"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 150
            }, {
                name : "KR_PRODUCT_NAME",
                header : {
                    text : "상품명(한글)"
                },
                styles : {
                    textAlignment : "center",
                },
                width : 200,
                editable : true
            }, {
                name : "KR_PRODUCT_CODE",
                header : {
                    text : "한국 판매 제품 코드",
                },
                styles : {
                    textAlignment : "center",
                },
                width : 150,
                editable : true
            
            }, {
                name : "ODP_CODE",
                header : {
                    text : "역직구몰 판매코드"
                },
                styles : {
                    textAlignment : "center",
                },
                width : 150,
                editable : true
            }, {
                name : "USA_FDA_PRODUCT_NO",
                header : {
                    text : "미국 FDA 제품 등록번호"
                },
                styles : {
                    textAlignment : "center",
                },
                width : 150,
                editable : true
            }, {
                name : "CANADA_FDA_PRODUCT_NO",
                header : {
                    text : "캐나다 FDA 제품 등록번호"
                },
                styles : {
                    textAlignment : "center",
                },
                width : 150,
                editable : true
            }, {
                name : "PRICE",
                header : {
                    text : "판매수량당 평균 제품단가(원)"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "LENGTH",
                header : {
                    text : "L(mm)"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "WIDTH",
                header : {
                    text : "W(mm)"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "HEIGHT",
                header : {
                    text : "H(mm)"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "KG",
                header : {
                    text : "제품 개당 총 중량(KG)"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "CBM",
                header : {
                    text : "CBM"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            },{
                name : "VOLUME_WEIGHT",
                header : {
                    text : "부피 중량(KG)"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 100,
                editable : true
            }, {
                name : "EN_PRODUCT_NAME",
                header : {
                    text : "상품명(영문)"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 200,
                editable : true
            }, {
                name : "HS_CODE",
                header : {
                    text : "HS CODE(국가별 필요여부 확인)/수입통관시"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 200,
                editable : true
            }, {
                name : "ORIGIN",
                header : {
                    text : "원산지"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 150,
                editable : true
            }, {
                name : "ZONE",
                header : {
                    text : "ZONE"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 150,
                editable : true
            }, {
                name : "RACK",
                header : {
                    text : "실물기준"
                },
                styles : {
                    textAlignment : "center"
                },
                width : 150,
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
        
        var url = "/fulfillment/atomy/productList/pop/setSave.do";
        var param = cfn_getFormData("formPopSearch");
        var sendData = {"paramData" : param, "paramList" : gridDataList};
        
        gfn_ajax(url, true, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "애터미 상품 등록 완료");
                $("#atomyProductPop").lingoPopup("close", "OK");
            }
        });
    }

</script>