<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/comm/contentTop.do"/>
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" method="post">
        <input type="hidden" id="sCompCd" value="<c:out value='${sessionScope.loginVO.compcd}' />">
        <ul class="sech_ul">
            <li class="sech_li" style="width: 460px;">
                <div>기간</div>
                <div>
                    <input type="text" id="sToDate" class="cmc_date periods required" />
                    ~
                    <input type="text" id="sFromDate" class="cmc_date periode required" />
                </div>
            </li>
        </ul>
    </form>
</div>
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
            애터미역직구 출하상품정보
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right"></div>
    </div>
    <div id="grid1"></div>
</div>
<script type="text/javascript">
    //초기 로드
    $(function() {
        // 1. 화면레이아웃 지정 (리사이징)
        initLayout();
        // 2. 기초검색 조건 설정
        cfn_init();
        // 3. 그리드 초기화
        setGridLoad();
        // 4. 조회
        cfn_retrieve();
    });

    function cfn_init() {
        $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
    }

    function setGridLoad() {
        var gid = "grid1";
        var columns = [
                {
                    name : "goodsCd",
                    header : {
                        text : "상품코드"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
                }, {
                    name : "goodsNm",
                    header : {
                        text : "상품명"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 400
                }, {
                    name : "goodsCnt",
                    header : {
                        text : "상품수"
                    },
                    styles : {
                        textAlignment : "center"
                    },
                    width : 100
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
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        if (sid == "sid_getSearch") {
            $("#grid1").gfn_setDataList(data.resultList);
            $("#grid1").gfn_focusPK();
        }
    }

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        $("#grid1").gridView().cancel();
        gv_searchData = cfn_getFormData("frmSearch");
        
        if ($("#sToDate").val() != $("#sFromDate").val()) {
            cfn_msg("WARNING", "시작일과 종료일을 같은날짜로 변경하세요.");
            return;
        }
        
        var sid = "sid_getSearch";
        var url = "/fulfillment/atomy/orderProduct/getSearch.do";
        var sendData = gv_searchData;
        gfn_sendData(sid, url, sendData, true);
    }
</script>
<c:import url="/comm/contentBottom.do" />