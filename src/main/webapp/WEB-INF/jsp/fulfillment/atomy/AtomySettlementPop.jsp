<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 검색 시작 -->
<div id="atomySettlementPop" class="pop_wrap">
    <div id="ct_sech_wrap">
    <form id="formAtomySettlementInsertPop" action="#" onsubmit="return false">
        <p id="lbl_name" style=" padding-left: 10px;"><b>송장번호 별 매입액 등록</b></p>
        <ul style="padding-left: 10px;">
            <li>
                <div style="border: 1px solid gray;">
                    <p style="padding-left: 10px;">
                        <font color="red">※ 샘플 엑셀을 다운로드하여 송장번호, 운송사, 운송장, 매입액을 입력하여 업로드하세요.</font><br>
                    </p>
                </div>
            </li>
        </ul>
    </form>
    </div>
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">애터미 역직구 매입액 업로드
                <span>(총 0건)</span>
            </div>
            <div class="grid_top_right">
                <input style="width: 150px;" type="button" value="샘플 Excel 다운로드" onclick="fn_excel_sample();" />
                <input type="button" class="cmb_plus" onclick="popAddRow()" />
                <input type="button" class="cmb_minus" onclick="popDeleteRow()" />
            </div>
        </div>
        <div id="uploadPopGrid"></div>
    </div>
    <!-- 그리드 끝 -->
</div>
<script type="text/javascript">

    // 등록 컬럼.
    var _columnName = [
            "xrtInvcSno",
            "localShipper",
            "invcSno1",
            "purchasesPrice1",
            "purchasesPrice2",
            "purchasesPrice3"
    ];
    
    // 초기 로드.
    $(function() {
        $("#atomySettlementPop").lingoPopup({
            title : "애터미 역직구 매입액 업로드",
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
                fn_grid();
              //엑셀업로드
                $(".popbtnExcel").before('<form id="frmupload" action="#" method="post" enctype="multipart/form-data">' +
                        '<input type="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" ' +
                        'name="excelfile" id="xlf" class="popbtnleft" style="margin:10px 0 0 5px;" />' +
                        '</form>');
                
                $("#xlf").bind("change", function(e){
                    gfn_handleXlsFile(e,"uploadPopGrid", _columnName);
                });
            }
        });
    });
    // 그리드 설정
    function fn_grid() {
        var gid = "uploadPopGrid";
        var columns = [
            {name:"xrtInvcSno", header:{text:"XROUTE송장번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"localShipper", header:{text:"운송사"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"invcSno1", header:{text:"운송장"}, styles:{textAlignment:"center"}, width:200, editable:true},
            {name:"purchasesPrice1", header:{text:"매입액1(종합)"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"purchasesPrice2", header:{text:"매입액2(기본)"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"purchasesPrice3", header:{text:"매입액(기타)"}, styles:{textAlignment:"center"}, width:150, editable:true}
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
        $("#uploadPopGrid").gfn_addRow();
    }
    
    // 그리드 행 삭제.
    function popDeleteRow() {
        var checkRows = $("#uploadPopGrid").gridView().getCheckedRows().reverse();
        var gridData = $("#uploadPopGrid").gfn_getDataRows(checkRows);
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
            $("#uploadPopGrid").gfn_delRow(checkRows[i]);
        }
    }
    
    // 업데이트 및 저장.
    function setSave() {
        
        // grid에 있는 데이터 목록.
        var gridDataList = $("#uploadPopGrid").gfn_getDataList(true, false);
        
        if (gridDataList.length < 1) {
            cfn_msg("WARNING", "등록된 내역이 없습니다.");
            return false;
        }
        
        var url = "/fulfillment/atomy/settlement/pop/updateAtomySettlement.do";
        var param = cfn_getFormData("formPopSearch");
        var sendData = {"paramData" : param, "paramList" : gridDataList};
        
        gfn_ajax(url, true, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "매입액 등록 완료");
                $("#atomySettlementPop").lingoPopup("close", "OK");
            }
        });
    }
    
  //샘플excel 업로드파일 다운로드
    function fn_excel_sample(){
        var $g = "uploadPopGrid";
        
        RealGridJS.exportGrid({
            type: "excel"
            , target: "local"
            , fileName: "atomySettlementSample" + ".xlsx"
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