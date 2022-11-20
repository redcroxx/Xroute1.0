<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst"%>
<!-- 
    화면코드 : ParcelProof
    화면명   : ParcelProof
-->
<c:import url="/comm/contentTop.do" />
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" id="sCompCd" class="cmc_txt" />
        <ul class="sech_ul">
            <li class="sech_li required">
                <div>기간</div>
                <div>
                    <input type="text" id="sToDate" class="cmc_date required" /> ~ <input type="text" id="sFromDate" class="cmc_date required" />
                </div>
            </li>
            <li class="sech_li">
                <div>셀러</div>
                <div>
                    <input type="text" id="sOrgCd" class="cmc_code required" />
                    <input type="text" id="sOrgNm" class="cmc_value" />
                    <button type="button" class="cmc_cdsearch"></button>
                </div>
            </li>
        </ul>
        <ul class="sech_ul">
            <li class="sech_li">
                <div>년도</div>
                <div>
                    <select id="year" style="width: 80px;">
                        <option selected="selected" value="">--선택--</option>
                        <c:forEach var="i" items="${year}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </li>
            <li class="sech_li">
                <div>분기</div>
                <div>
                    <select id="quarter" style="width: 150px;">
                        <option selected="selected" value="">--선택--</option>
                        <c:forEach var="i" items="${quarter}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </li>
            <li>
                <div>
                    <input type="button" style="width: 200px;" value="해외배송 소포수령증 발급" onclick="fn_receipt_print()">
                </div>
            </li>
        </ul>
    </form>
</div>
<script type="text/javascript">
    //초기로드
    $(function() {
        //회사코드		
        $("#sCompCd").val("<c:out value='${sessionScope.loginVO.compcd}' />");

        //권한 설정
        reset_Search();

        //셀러코드
        pfn_codeval({
            url : "/alexcloud/popup/popP002/view.do",
            codeid : "sOrgCd",
            inparam : {
                S_COMPCD : "sCompCd",
                sOrgNm : "sOrgCd,sOrgNm"
            },
            outparam : {
                ORGCD : "sOrgCd",
                NAME : "sOrgNm"
            }
        });
    });

    function reset_Search() {
        var usergroup = '<c:out value="${sessionScope.loginVO.usergroup}" />';
        var sellerGroup = '<c:out value="${constMap.SELLER_ADMIN}" />';

        if (usergroup == sellerGroup) {
            $("#sOrgCd").val('<c:out value="${sessionScope.loginVO.orgcd}" />');
            $("#sOrgNm").val('<c:out value="${sessionScope.loginVO.orgnm}" />');

            $("#sOrgCd").removeClass("disabled").prop({
                "readonly" : true,
                "disabled" : true
            });
            $("#sOrgNm").removeClass("disabled").prop({
                "readonly" : true,
                "disabled" : true
            });
            $("#sOrgNm").next().removeClass("disabled").prop({
                "readonly" : true,
                "disabled" : true
            });
        }
    }

    function fn_receipt_print() {
        var sid = "sid_getPrint";
        var url = "/fulfillment/order/parcelProof/getPrint.do";
        //분기
        var quarter = $("#quarter").val();
        //회사
        var compCd = $("#sCompCd").val();
        //년도
        var year = $("#year").val();
        //셀러코드
        var orgCd = $("#sOrgCd").val();
        //년도,분기 데이터
        var s_quarter = year + "" + quarter.substring(0, 4);
        var e_quarter = year + "" + quarter.substring(4, 8);
        //기간 선택
        var sDate = $("#sToDate").val();
        var fDate = $("#sFromDate").val();
        
        var sToDate = sDate.replace(/-/gi, "");
        var sFromDate = fDate.replace(/-/gi,"");
        
        var sendData = {
            "COMPCD" : compCd,
            "ORGCD" : orgCd,
            "S_QUARTER" : s_quarter,
            "E_QUARTER" : e_quarter,
            "sToDate" : sToDate,
            "sFromDate" : sFromDate
        };
        
        gfn_sendData(sid, url, sendData, true);
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getPrint") {
            console.log(data.flagValue.COUNT);
            if (data.flagValue.COUNT > 0) {
                print();
            }
        }
    }

    function print() {
        //프린터 지정
        var print1 = cfn_printInfo().PRINT1;
        //회사
        var compCd = $("#sCompCd").val();
        //년도
        var year = $("#year").val();
        //분기
        var quarter = $("#quarter").val();
        //셀러코드
        var orgCd = $("#sOrgCd").val();
        
        //기간 검색
        var sToDate = $("#sToDate").val();
        var sFromDate = $("#sFromDate").val();
        
        var s_quarter;
        var e_quarter;
        
        if (year == "" && quarter == "") {
            s_quarter = sToDate.replace(/-/gi, "");
            e_quarter = sFromDate.replace(/-/gi, "");
        }else if (sDate == "" && fDate == "") {
            s_quarter = year + "" + quarter.substring(0, 4);
            e_quarter = year + "" + quarter.substring(4, 8);
        }
        
        if (confirm("[프린터] : " + print1 + "으로 출력합니다. 출력하시겠습니까?")) {
            rfn_reportLabel({
                title : "소포수령증",
                jrfName : "PARCELPROOF",
                isMultiReport : true,
                multicount : 1,
                args : {
                    "COMPCD" : compCd,
                    "ORGCD" : orgCd,
                    "S_QUARTER" : s_quarter,
                    "E_QUARTER" : e_quarter
                }
            });
        }
    }
</script>
<c:import url="/comm/contentBottom.do" />