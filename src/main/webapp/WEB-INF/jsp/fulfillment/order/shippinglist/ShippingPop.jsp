<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
화면코드 : ShippingListDtl
화면명   : ShippingListDtl
-->
<div id="shippingPop" class="pop_wrap">
    <!-- 검색조건영역 시작 -->
    <div id="ct_sech_wrap">
        <form id="frmPopSearch" action="#" onsubmit="return false">
            <p id="lbl_name">배송조회</p>
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>송장번호</div>
                    <div>
                        <input style="width: 240px;" type="text" id="popXrtInvcSno" />
                    </div>
                </li>
                <li>
                    <div>
                        <input type="button" class="cmb_normal" value="검색" onclick="getPopSearch()" />
                    </div>
                </li>
            </ul>
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>수화인명</div>
                    <div>
                        <label id="popRecvName"></label>
                    </div>
                </li>
            </ul>
        </form>
    </div>
    <!-- 검색조건영역 끝 -->
    <!-- 그리드 시작 -->
    <div class="ct_top_wrap">
        <div class="ct_top_wrap fix botfix" style="height: 40px">
            <div id="popGrid"></div>
        </div>
    </div>
    <!-- 그리드 끝 -->
</div>
<script type="text/javascript">
    var _INVNO = {};

    $(function() {
        $("#shippingPop").lingoPopup({
            title : "배송조회",
            width : 850,
            height : 700,
            buttons : {
                "취소" : {
                    text : "닫기",
                    click : function() {
                        $(this).lingoPopup("setData", "");
                        $(this).lingoPopup("close", "CANCEL");
                    }
                }
            },
            open : function(data) {
                $("#popRecvName").text(data.recvName);
                $("#popXrtInvcSno").val(data.xrtInvcSno);

                setPopGridData();
                getPopSearch();
            }
        });
    });

    /* 검색 */
    function getPopSearch() {
        if ($("#popXrtInvcSno").val() == "") {
            return;
        }

        var url = "/fulfillment/order/shippingList/pop/getSearch.do";
        var sendData = {
            "xrtInvcSno" : $("#popXrtInvcSno").val()
        };

        gfn_ajax(url, true, sendData, function(data, xhr) {
            console.log(data, data.resultList);
            if (cfn_isEmpty(data.resultList)) {
                cfn_msg("WARNING", "검색결과가 존재하지 않습니다.");
                return false;
            }

            $("#popGrid").gfn_setDataList(data.resultList);
            if (data.CODE == "1") {
                var docId = $("#main_contents").find("#tabs").find("[aria-hidden=false]").find("iframe").prop("id");
                document.getElementById(docId).contentWindow.cfn_retrieve();
            } 
        });
    }

    function setPopGridData() {
        var gid = "popGrid";
        var columns = [
                {
                    name : "adddatetime",
                    header : {
                        text : "일자"
                    },
                    styles:{textAlignment:"center"},
                    width : 150
                },
                {
                    name : "statusNm",
                    header : {
                        text : "배송상태"
                    },
                    styles:{textAlignment:"center"},
                    width : 150
                }, {
                    name : "statusEnNm",
                    header : {
                        text : "Delivery Status"
                    },
                    styles:{textAlignment:"center"},
                    width : 150
                }
        ];

        //그리드 생성 (realgrid 써서)
        $("#" + gid).gfn_createGrid(columns, {
            footerflg : false
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />