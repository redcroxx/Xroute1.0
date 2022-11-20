<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : premiumpremiumRatePop
    화면명   : 프리미엄 요율 등록 팝업
-->
<!-- 검색 시작 -->
<div id="premiumRatePop" class="pop_wrap">
    <div id="ct_sech_wrap">
        <form id="frmPopSearch" action="#">
            <ul class="sech_ul">
                <li class="sech_li required" style="width: 300px;">
                    <div>국가</div>
                    <div style="width: 150px;">
                        <select id="popCountry">
                            <option selected="selected" value="">--선택--</option>
                            <c:forEach var="i" items="${countrylist}">
                                <option value="${i.code}">${i.value}</option>
                            </c:forEach>
                        </select>
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

    var _GRIDCOLUMNS = ["WGT", "PREMIUM1", "PREMIUM2", "PREMIUM3", "PREMIUM4", "PREMIUM5"];
    // 초기 로드
    $(function() {
        $("#premiumRatePop").lingoPopup({
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
                    name : "WGT",
                    header : {
                        text : "무게(KG)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 150
                }, {
                    name : "PREMIUM1",
                    header : {
                        text : "Premium 가격(원)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true,
                    width : 150
                }, {
                    name : "PREMIUM2",
                    header : {
                        text : "Premium2 가격(원)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true,
                    width : 150
                }, {
                    name : "PREMIUM3",
                    header : {
                        text : "Premium3 가격(원)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true,
                    width : 150
                }, {
                    name : "PREMIUM4",
                    header : {
                        text : "Premium4 가격(원)"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    editable : true,
                    width : 150
                }, {
                    name : "PREMIUM5",
                    header : {
                        text : "Premium5 가격(원)"
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

        var selectedVal = $("#popCountry").val();
        if (selectedVal == "") {
            cfn_msg("WARNING", "국가를 선택하세요.");
            return false;
        }
        
        // grid에 있는 데이터 목록.
        var gridDataList = $("#popGrid").gfn_getDataList(true, false);
        
        if (gridDataList.length < 1) {
            cfn_msg("WARNING", "등록된 내역이 없습니다.");
            return false;
        }
        
        var url = "/fulfillment/system/premiumRate/pop/setSave.do";
        var param = cfn_getFormData("frmPopSearch");
        var sendData = {"paramData" : param, "paramList" : gridDataList};
        
        gfn_ajax(url, true, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "요율표 등록 완료");
                $("#premiumRatePop").lingoPopup("close", "OK");
            }
        });
    }

</script>