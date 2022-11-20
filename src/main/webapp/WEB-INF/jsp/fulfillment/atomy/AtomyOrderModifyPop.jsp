<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst" %>
<div id="atomyOrderModifyPop" class="pop_wrap">
    <!-- 검색조건영역 시작 -->
    <div id="ct_sech_wrap">
    <form id="formAtomyOrderModifyPop" action="#" onsubmit="return false">
        <p id="lbl_name" style=" padding-left: 10px;"><b>배송송장입력 상태변경</b></p>
        <ul style="padding-left: 10px;">
            <li>
                <div style="border: 1px solid gray;">
                    <p style="padding-left: 10px;">
                        <font color="red">※ EXP_NO(수출신고필증번호) 등록 후 진행.</font><br>
                        <font color="red">※ DHL송장번호 등록 시 애터미 배송 송장 입력 상태변경 API가 실행됩니다.</font><br>
                        <font color="red">※ EXP_NO(수출신고필증번호)가 없을 시 애터미 배송송장입력 상태변경 API 실행불가</font><br>
                    </p>
                </div>
            </li>
        </ul>
    </form>
    </div>
    <!-- 업로드 리스트 그리드 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">업로드 리스트<span>(총 0건)</span></div>
            <div class="grid_top_right">
                <input style="width: 150px;" type="button" value="샘플 Excel 다운로드" onclick="fn_excel_sample();" />
            </div>
        </div>
        <div id="gridAtomyOrderModify"></div>
    </div>
</div>
<script type="text/javascript">
var _columnName = ["xrtInvcSno", "invcSno1"];
$(function() {
    $("#atomyOrderModifyPop").lingoPopup({
        title: "배송송장입력 상태변경",
        width: 800,
        height: 640,
        buttons: {
            "확인": {
                class: "popbtnExcel",
                text: "저장",
                click: function() {
                    var gridDataList = $("#gridAtomyOrderModify").gfn_getDataList(true, false);
                    
                    if (gridDataList.length < 1) {
                        cfn_msg("WARNING", "등록된 내역이 없습니다.");
                        return false;
                    }
                    
                    var url = "/fulfillment/atomy/orderList/upload.do";
                    var sendData = {"dataList":gridDataList};
                    
                    gfn_ajax(url, true, sendData, function(data, xhr) {
                        if (data.CODE == "1") {
                            cfn_msg("info", data.MESSAGE);
                            listReset();
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
                gfn_handleXlsFile(e,"gridAtomyOrderModify", _columnName);
            });
        }
    });
});

function fn_grid() {
    var gid = "gridAtomyOrderModify";
    var textAlignment = {textAlignment: "center"};
    var columns = [
        {name:"xrtInvcSno", header:{text:"xrtInvcSno"}, style:textAlignment, editable:true, width:120}
        , {name:"invcSno1", header:{text:"invcSno1"}, style:textAlignment, editable:true, width:120}
    ];

    // 그리드 생성 (realgrid 써서)
    $("#" + gid).gfn_createGrid(columns, {
        footerflg : false,
        cmenuGroupflg:false,
        cmenuColChangeflg:false,
        cmenuColSaveflg:false,
        cmenuColInitflg:false,
        height:"95%"
    });
}

function listReset() {
    var docId = $("#main_contents").find("#tabs").find("[aria-hidden=false]").find("iframe").prop("id");
    document.getElementById(docId).contentWindow.cfn_retrieve();
    $("#atomyOrderModifyPop").lingoPopup("setData", "");
    $("#atomyOrderModifyPop").lingoPopup("close", "OK");
}

// 샘플excel 업로드파일 다운로드
function fn_excel_sample(){
    var $g = "gridAtomyOrderModify";
    
    RealGridJS.exportGrid({
        type: "excel"
        , target: "local"
        , fileName: "order_modify_sample" + ".xlsx"
        , showProgress: "Y"
        , applyDynamicStyles: true
        , progressMessage: "엑셀 Export중입니다."
        , header: "default"
        , footer: "default"
        , compatibility: "2010"
        , lookupDisplay:true
        , exportGrids: [
            {grid:$("#"+$g).gridView(), sheetName:"업로드샘플양식",indicator: "hidden"} // 행번호 visable 여부*
        ]
        , done: function() {
        }
    });
}
</script>