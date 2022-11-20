<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst"%>
<div id="passBookPayPop" class="pop_wrap">
    <!-- 검색조건영역 시작 -->
    <div id="ct_sech_wrap">
        <form id="frmPopSearch" action="#" onsubmit="return false">
            <p id="lbl_name" style="padding-left: 10px;">
                <b>추가 결제 업로드</b>
            </p>
        </form>
    </div>
    <!-- 업로드 리스트 그리드 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">
                업로드 리스트
                <span>(총 0건)</span>
            </div>
            <div class="grid_top_right">
                <input style="width: 150px;" type="button" value="샘플 Excel 다운로드" onclick="fn_excel_sample();" />
            </div>
        </div>
        <div id="popGrid"></div>
    </div>
</div>
<script type="text/javascript">
    var _COLUMNS = [
            "xrtInvcSno", "price", "productNm"
    ];
    
    $(function() {
        $("#passBookPayPop").lingoPopup({
            title: "추가 결제 업로드",
            width: 800,
            height: 640,
            buttons: {
                "확인": {
                    class: "popbtnExcel",
                    text: "저장",
                    click: function() {
                        var gridDataList = $("#popGrid").gfn_getDataList(true, false);
                        
                        if (gridDataList.length < 1) {
                            cfn_msg("WARNING", "등록된 내역이 없습니다.");
                            return false;
                        }
                        
                        var url = "/fulfillment/payment/passBookList/pop/setUpload.do";
                        var sendData = {
                                "type" : "etc",
                                "dataList" : gridDataList
                        };
                        
                        gfn_ajax(url, true, sendData, function(data, xhr) {
                            if (data.CODE == "1") {
                                cfn_msg("info", data.MESSAGE);
                                listReset();
                            } else {
                                cfn_msg("info", data.MESSAGE);
                            }
                        });
                    }
                }
                , "닫기": {
                    text: "취소",
                    click: function() {
                        $(this).lingoPopup("setData", "");
                        $(this).lingoPopup("close");
                    }
                }
            } ,
            open: function() {
                fn_grid();
                
                //엑셀업로드
                $(".popbtnExcel").before('<form id="frmupload" action="#" method="post" enctype="multipart/form-data">' +
                        '<input type="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" ' +
                        'name="excelfile" id="xlf" class="popbtnleft" style="margin:10px 0 0 5px;" />' +
                        '</form>');
    
                $("#xlf").bind("change", function(e){
                    gfn_handleXlsFile(e,"popGrid", _COLUMNS);
                });
            }
        });
    });


    function fn_grid() {
        var gid = "popGrid";
        var textAlignment = {
            textAlignment : "center"
        };
        var columns = [
                {
                    name : "xrtInvcSno",
                    header : {
                        text : "XRT송장번호"
                    },
                    style : textAlignment,
                    editable : true,
                    width : 120
                }, {
                    name : "price",
                    header : {
                        text : "가격"
                    },
                    style : textAlignment,
                    editable : true,
                    width : 100
                }, {
                    name : "productNm",
                    header : {
                        text : "비고"
                    },
                    style : textAlignment,
                    editable : true,
                    width : 120
                },
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false,
            cmenuGroupflg : false,
            cmenuColChangeflg : false,
            cmenuColSaveflg : false,
            cmenuColInitflg : false,
            height : "95%"
        });
    }

    function listReset() {
        var docId = $("#main_contents").find("#tabs").find("[aria-hidden=false]").find("iframe").prop("id");
        document.getElementById(docId).contentWindow.cfn_retrieve();
        $('#passBookPayPop').lingoPopup("setData", "");
        $('#passBookPayPop').lingoPopup("close", "OK");
    }

    //샘플excel 업로드파일 다운로드
    function fn_excel_sample() {
        var $g = "popGrid";

        RealGridJS.exportGrid({
            type : "excel",
            target : "local",
            fileName : "추가결제_업로드" + ".xlsx",
            showProgress : "Y",
            applyDynamicStyles : true,
            progressMessage : "엑셀 Export중입니다.",
            header : "default",
            footer : "default",
            compatibility : "2010",
            lookupDisplay : true,
            exportGrids : [
                {
                    grid : $("#" + $g).gridView(),
                    sheetName : "업로드샘플양식",
                    indicator : "hidden"
                }
            // 행번호 visable 여부*
            ],
            done : function() {
            }
        });
    }
</script>