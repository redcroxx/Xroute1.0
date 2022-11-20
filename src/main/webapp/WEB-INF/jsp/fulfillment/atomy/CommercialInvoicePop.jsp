<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : CommercialInvoicePop
    화면명   : CommercialInvoice 업로드.
-->
<!-- 검색 시작 -->
<div id="commercialInvoicePop" class="pop_wrap">
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="grid_top_wrap">
            <div class="grid_top_left">Commercial Invoice
                <span>(총 0건)</span>
            </div>
            <div class="grid_top_right">
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
    var _GRIDCOLUMNS = [
            "xrtInvcSno",
            "신고자상호",
            "수출대행회사명",
            "수출화주상호", 
            "수출화주명", 
            "corporateRegistr",
            "수출화주통관부호",
            "수출화주소재지",
            "수출화주주소",
            "제조자명",
            "supplyNo",
            "신고구분",
            "거래구분",
            "결제방법",
            "recvNation",
            "shipPost",
            "shipAddr",
            "보세구역번호",
            "환급신청인",
            "wgt",
            "deliveryTerms",
            "recvCurrency",
            "excTotSum",
            "excAmt",
            "hsCode",
            "volumeWeight",
            "origin",
            "enProductName",
            "goodsCnt",
            "each",
            "price",
            "amount",
            "packingUnitCnt",
            "packingUnit", 
            "기타명1",
            "loadingPort",
            "기타명2",
            "제조사우편번호",
            "packingUnitAll",
            "ordNo",
            "expNo"
        ];
    
    // 초기 로드.
    $(function() {
        $("#commercialInvoicePop").lingoPopup({
            title : "CommercialInvoice 업로드",
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
                    gfn_handleXlsFile(e,"uploadPopGrid", _GRIDCOLUMNS);
                }); 
                
                setuploadPopGridData();
            }
        });
    });
    // 그리드 설정
    function setuploadPopGridData() {
        var gid = "uploadPopGrid";
        var columns = [
            {name:"xrtInvcSno", header:{text:"INVOICE번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"신고자상호", header:{text:"신고자상호"}, styles:{textAlignment:"center"}, width:100, editable:true},
            {name:"수출대행회사명", header:{text:"수출대행회사명"}, styles:{textAlignment:"center"}, width:100, editable:true},
            {name:"수출화주상호", header:{text:"수출화주상호"}, styles:{textAlignment:"center"}, width:100, editable:true},
            {name:"수출화주명", header:{text:"수출화주명"}, styles:{textAlignment:"center"}, width:100, editable:true},
            {name:"corporateRegistrationNo", header:{text:"수출자사업번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"수출화주통관부호", header:{text:"수출화주통관부호"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"수출화주소재지", header:{text:"수출화주소재지"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"수출화주주소", header:{text:"수출화주주소"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"제조자명", header:{text:"제조자명"}, styles:{textAlignment:"center"}, width:100, editable:true},
            {name:"supplyNo", header:{text:"해외공급자번호(구매자이름/영문)"}, styles:{textAlignment:"center"}, width:200, editable:true},
            {name:"신고구분", header:{text:"신고구분"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"거래구분", header:{text:"거래구분"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"결제방법", header:{text:"결제방법"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"recvNation", header:{text:"목적국"}, styles:{textAlignment:"center"}, width:50, editable:true},
            {name:"shipPost", header:{text:"물품소재지우편번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"shipAddr", header:{text:"물품소재지주소"}, styles:{textAlignment:"center"}, width:350, editable:true},
            {name:"보세구역번호", header:{text:"보세구역번호"}, styles:{textAlignment:"center"}, width:100, editable:true},
            {name:"환급신청인", header:{text:"환급신청인"}, styles:{textAlignment:"center"}, width:100, editable:true},
            {name:"wgt", header:{text:"총중량"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"deliveryTerms", header:{text:"인도조건"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"recvCurrency", header:{text:"통화단위"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"excTotSum", header:{text:"총결제금액(USD)"}, styles:{textAlignment:"center"}, width:120, editable:true},
            {name:"excAmt", header:{text:"상품금액(USD)"}, styles:{textAlignment:"center"}, width:120, editable:true},
            {name:"hsCode", header:{text:"세번부호"}, styles:{textAlignment:"center"}, width:300, editable:true},
            {name:"volumeWeight", header:{text:"순중량"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"origin", header:{text:"원산지"}, styles:{textAlignment:"center"}, width:100, editable:true},
            {name:"enProductName", header:{text:"모델"}, styles:{textAlignment:"center"}, width:500, editable:true},
            {name:"goodsCnt", header:{text:"수량"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"each", header:{text:"단위"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"price", header:{text:"단가(원)"}, styles:{textAlignment:"center"}, width:280, editable:true},
            {name:"amount", header:{text:"소계(원)"}, styles:{textAlignment:"center"}, width:280, editable:true},
            {name:"packingUnitCnt", header:{text:"란포장개수"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"packingUnit", header:{text:"란포장개수단위"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"기타명1", header:{text:"기타명1"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"loadingPort", header:{text:"적재항"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"기타명2", header:{text:"기타명2"}, styles:{textAlignment:"center"}, width:80, editable:true},
            {name:"제조사우편번호", header:{text:"제조사우편번호"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"packingUnitAll", header:{text:"총포장개수단위"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"ordNo", header:{text:"송품장부호(란)"}, styles:{textAlignment:"center"}, width:150, editable:true},
            {name:"expNo", header:{text:"수출신고필증번호"}, styles:{textAlignment:"center"}, width:150, editable:true}
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
        
        var url = "/fulfillment/atomy/commercialInvoice/pop/updateCommercialInvoice.do";
        var param = cfn_getFormData("formPopSearch");
        var sendData = {"paramData" : param, "paramList" : gridDataList};
        
        gfn_ajax(url, true, sendData, function(data, xhr) {
            if (data.CODE == "1") {
                cfn_msg("INFO", "수출신고필증번호 등록 완료");
                $("#commercialInvoicePop").lingoPopup("close", "OK");
            }
        });
    }

</script>