<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst"%>
<!--
	화면코드 : OrderList
	화면명 : OrderList
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" id="sCompCd" class="cmc_txt" value="<c:out value='${sessionScope.loginVO.compcd}' />" />
        <input type="hidden" id="sInvcStart" class="cmc_txt" />
        <input type="hidden" id="sInvcEnd" class="cmc_txt" />
        <ul class="sech_ul">
            <li class="sech_li required">
                <div>오더등록일자</div>
                <div>
                    <input type="text" id="sToDate" class="cmc_date periods required" />
                    ~
                    <input type="text" id="sFromDate" class="cmc_date periods required" />
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 160px;">송장,주문,장바구니번호</div>
                <div>
                    <input type="text" id="sKeyword" class="cmc_code" style="width: 200px;" />
                </div>
            </li>
            <li class="sech_li">
                <div>배송국가</div>
                <div>
                    <select id="sToNation" style="width: 100px;">
                        <option selected="selected" value="">--선택--</option>
                        <c:forEach var="i" items="${countrylist}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                    >>
                    <select id="sFromNation" style="width: 100px;">
                        <option selected="selected" value="">--선택--</option>
                        <c:forEach var="i" items="${countrylist}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </li>
        </ul>
        <ul class="sech_ul">
            <li class="sech_li">
                <div>창고</div>
                <div>
                    <input type="text" id="sWhcd" class="cmc_code" />
                    <input type="text" id="sWhnm" class="cmc_value" />
                    <button type="button" class="cmc_cdsearch"></button>
                </div>
            </li>
            <li class="sech_li">
                <div style="width: 160px;">셀러</div>
                <div>
                    <input type="text" id="sOrgCd" class="cmc_code" />
                    <input type="text" id="sOrgNm" class="cmc_value" />
                    <button type="button" class="cmc_cdsearch"></button>
                </div>
            </li>
            <li class="sech_li">
                <div>업로드 차수</div>
                <div>
                    <select id="sFileSeq" style="width: 100px;">
                        <option selected="selected" value="">--전체--</option>
                        <c:forEach var="i" items="${fileseqlist}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </li>
        </ul>
    </form>
</div>
<!-- 검색 끝 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
            오더리스트
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <input type="button" class="cmb_normal_new cbtn_upload" value="엣시 업로드" onclick="openPopup('etsy');" style="min-width: 120px !important; text-align: right;" />
            <input type="button" class="cmb_normal_new cbtn_upload" value="이베이 업로드" onclick="openPopup('ebay');" style="min-width: 130px !important; text-align: right;" />
            <input type="button" class="cmb_normal_new cbtn_upload" value="아마존 업로드" onclick="openPopup('amazon');" style="min-width: 130px !important; text-align: right;" />
            <input type="button" class="cmb_normal_new cbtn_upload" value="업로드" onclick="openPopup('etc');" style="min-width: 90px !important; text-align: right;" />
        </div>
    </div>
    <div id="grid1"></div>
    <div class="ct_bot_wrap fix botfix" style="padding: 5px 0 0 0 !important;">
        <b>SEQ: </b>
        <input type="text" id="S_INVCSTART" class="cmc_int" style="width: 30px" />
        <p id="S_INVC" style="display: inline">~</p>
        <input type="text" id="S_INVCEND" class="cmc_int" style="width: 30px" />
        <input type="button" class="cmb_normal_new cbtn_print" value="패킹리스트" onclick="fn_invcprint();" style="min-width: 120px !important; text-align: right;" />
        <input type="button" class="cmb_normal_new cbtn_print" value="라벨프린트" onclick="paperPrint('L1x1');" style="min-width: 120px !important; text-align: right;" />
        <span>
            <font color="red">※ 삭제된 오더(DELETED)는 송장출력 대상에서 제외됩니다.</font>
        </span>
    </div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    // 초기 로드
    $(function() {
        // 1. 화면레이아웃 지정 (리사이징)
        initLayout();
        // 2. 화면 공통버튼 설정
        setCommBtn("del", null, "삭제");
        // 3. 기초검색 조건 설정
        reset_Search();
        // 4. 그리드 초기화
        grid1_Load();
        /* 창고 */
        pfn_codeval({
            url : "/alexcloud/popup/popP004/view.do",
            codeid : "sWhcd",
            inparam : {
                sCompCd : "sCompCd",
                sWhcd : "sWhcd,sWhnm"
            },
            outparam : {
                WHCD : "sWhcd",
                NAME : "sWhnm"
            },
        });
        /* 셀러 */
        pfn_codeval({
            url : "/alexcloud/popup/popP002/view.do",
            codeid : "sOrgCd",
            inparam : {
                sCompCd : "sCompCd",
                sOrgNm : "sOrgCd,sOrgNm"
            },
            outparam : {
                ORGCD : "sOrgCd",
                NAME : "sOrgNm"
            }
        });
    });

    function reset_Search() {
        $("#sToDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));
        $("#sFromDate").val(cfn_getDateFormat(new Date(), "yyyy-MM-dd"));

        var usergroup = "<c:out value='${sessionScope.loginVO.usergroup}' />";
        var sellerGroup = "<c:out value='${SELLER_ADMIN}' />";
        var propFalse = {
            "readonly" : false,
            "disabled" : false
        };
        var propTrue = {
            "readonly" : true,
            "disabled" : true
        };

        if (usergroup > sellerGroup) {
            $("#sWhcd").removeClass("disabled").prop(propFalse);
            $("#sWhnm").removeClass("disabled").prop(propFalse);
            $("#sWhnm").next().removeClass("disabled").prop(propFalse);

            $("#sOrgCd").removeClass("disabled").prop(propFalse);
            $("#sOrgNm").removeClass("disabled").prop(propFalse);
            $("#sOrgNm").next().removeClass("disabled").prop(propFalse);
        } else if (usergroup <= sellerGroup) {
            $("#sWhcd").val("<c:out value='${sessionScope.loginVO.whcd}' />");
            $("#sWhnm").val("<c:out value='${sessionScope.loginVO.whnm}' />");
            $("#sOrgCd").val("<c:out value='${sessionScope.loginVO.orgcd}' />");
            $("#sOrgNm").val("<c:out value='${sessionScope.loginVO.orgnm}' />");
            $("#sWhcd").addClass("disabled").prop(propTrue);
            $("#sWhnm").addClass("disabled").prop(propTrue);
            $("#sOrgNm").next().addClass("disabled").prop(propTrue);

            $("#sOrgCd").addClass("disabled").prop(propTrue);
            $("#sOrgNm").addClass("disabled").prop(propTrue);
            $("#sOrgNm").next().addClass("disabled").prop(propTrue);
        }
    }

    function grid1_Load() {
        var gid = "grid1";
        var columns = [
            {name:"relaySeq", header:{text:"SEQ"}, styles:{textAlignment:"center"}, width:50}
            , {name:"uploadDate", header:{text:"오더등록일"}, styles:{textAlignment:"center"}, width:100}
            , {name:"delFlg", header:{text:"오더상태"}, styles:{textAlignment:"center"}, width:80}
            , {name:"fileNm", header:{text:"업로드차수"}, styles:{textAlignment:"center"}, width:70}
            , {name:"xrtInvcSno", header:{text:"송장번호"}, styles:{textAlignment:"center"}, width:160}
            , {name:"ordNo", header:{text:"주문번호"}, width:150, editor:{maxLength:150}}
            , {name:"paymentType", header:{text:"결제타입구분"}, styles:{textAlignment:"center"}, width:100}
            , {name:"statusCdKr", header:{text:"주문배송상태"}, styles:{textAlignment:"center"}, width:140, dynamicStyles:[{criteria:"value like '%오류%'", styles:"background=#FFFF00"}]}
            , {name:"shipName", header:{text:"송화인명"}, styles:{textAlignment:"center"}, width:150}
            , {name:"shipTel", header:{text:"송화인 연락처"}, styles:{textAlignment:"center"}, width:150}
            , {name:"shipAddr", header:{text:"송화인 주소"}, styles:{textAlignment:"center"}, width:200}
            , {name:"shipMethodCd", header:{text:"배송방식"}, styles:{textAlignment:"center"}, width:100}
            , {name:"sNation", header:{text:"출발국가"}, styles:{textAlignment:"center"}, width:60}
            , {name:"eNation", header:{text:"도착국가"}, styles:{textAlignment:"center"}, width:60}
            , {name:"recvName", header:{text:"수화인명"}, width:150}
            , {name:"recvTel", header:{text:"수화인 전화번호"}, styles:{textAlignment:"center"}, width:100}
            , {name:"recvMobile", header:{text:"수화인 핸드폰 번호"}, width:100}
            , {name:"recvAddr1", header:{text:"수화인 주소1"}, width:200}
            , {name:"recvAddr2", header:{text:"수화인 주소2"}, width:200}
            , {name:"recvCity", header:{text:"수화인 도시"}, width:150}
            , {name:"recvState", header:{text:"수화인 주(State)"}, width:120}
            , {name:"recvPost", header:{text:"수화인 우편번호"}, width:100}
            , {name:"recvCurrency", header:{text:"통화"}, width:60}
            , {name:"ordCnt", header:{text:"주문수량"}, styles:{textAlignment:"center"}, width:60}
            , {name:"mallNm", header:{text:"쇼핑몰명"}, styles:{textAlignment:"center"}, width:130}
            , {name:"cartNo", header:{text:"장바구니 번호"}, width:150}
            , {name:"goodsNm", header:{text:"상품명"}, width:200}
            , {name:"goodsOption", header:{text:"상품옵션"}, styles:{textAlignment:"center"}, width:200}
            , {name:"goodsCnt", header:{text:"상품수량"}, styles:{textAlignment:"center"}, width:60}
            , {name:"tallyDatetime", header:{text:"상품검수일"}, styles:{textAlignment:"center"}, width:120}
            , {name:"totPaymentPrice", header:{text:"구매자 결제금액"}, styles:{textAlignment:"far", numberFormat:"#,##0"}, width:100}
            , {name:"purchaseUrl", header:{text:"구매 URL"}, width:100}
            , {name:"statusCd",show:false}
        ];

        //그리드 생성 (realgrid 써서)
        $("#"+ gid).gfn_createGrid(columns, {
            footerflg : false
            , cmenuGroupflg : false
            , cmenuColChangeflg : false
            , cmenuColSaveflg : false
            , cmenuColInitflg : false
            , height : "95%"
        });

        //그리드설정 및 이벤트처리
        $("#"+ gid).gfn_setGridEvent(function(gridView, dataProvider) {
            //열고정 설정
            gridView.setFixedOptions({
                colCount: 2
                , resizable: true
                , colBarWidth: 1
            });
            // 더블클릭
            gridView.onDataCellDblClicked = function (grid, data) {
                if ("<c:out value='${sessionScope.loginVO.usergroup}' />" > "<c:out value='${SELLER_ADMIN}' />") {
                    var statusCd = grid.getValue(data.dataRow, "statusCd");
                    var xrtInvcSno = grid.getValue(data.dataRow, "xrtInvcSno");
                    switch (statusCd) {
                        case "10" :
                        case "11" :
                        case "12" :
                        case "20" :
                        case "21" :
                        case "22" :
                        case "23" :
                        case "30" :
                        case "80" :
                        case "98" :
                        case "88" :
                            var jsonObj = {};
                            jsonObj.xrtInvcSno = xrtInvcSno;
                            popUpOrderListDtl(jsonObj);
                            break;
                        default :
                            break;
                    }
                }
            };
        });
    }

    function popUpOrderListDtl(jsonObj) {
        pfn_popupOpen({
            url : "/fulfillment/order/orderListDtl/view.do"
            , pid : "OrderListDtl"
            , params : jsonObj
            , returnFn : function(data, type) {
                if (type === "OK") {
                }
            }
        });
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == "sid_getSearch") {
            $("#grid1").gfn_setDataList(data.resultList);
            $("#grid1").gfn_focusPK();
            if (cfn_isEmpty(data)) {
                cfn_msg("WARNING", "검색결과가 존재하지 않습니다.");
                return false;
            }

            var invcSeq = data.invcSeq;
            //송장 시퀀스 바인딩
            $("#S_INVCSTART").val(invcSeq.S_INVCSTART);
            $("#S_INVCEND").val(invcSeq.S_INVCEND);
            
        } else if (sid == "sid_getCnt") {
            //프린터 지정
            var print1 = cfn_printInfo().PRINT1;
            if (confirm("[프린터] : "+ print1 +"으로 출력합니다. 출력하시겠습니까?")) {
                
            var cnt = data.orderCnt;
                // 품목리스트 최대 5개 이하(2X4)
                if (cnt.MAX_COUNT <= 5) {
                    paperPrint("2x4");
                // 품목리스트 최소 5개 이상 최대 13개 이하(2x2)
                } else if (cnt.MIN_COUNT > 5 && cnt.MAX_COUNT <= 13) {
                    paperPrint("2x2");
                // 품목리스트 최소 13개 이상(2x1)
                } else if (cnt.MIN_COUNT > 13) {
                    paperPrint("2x1");
                // 품목리스트 최소 5개 이하 최대 13개 이하(2x4,2x2)
                } else if (cnt.MIN_COUNT <= 5 && cnt.MAX_COUNT <= 13) {
                    paperPrint("2x4x2");
                // 품목리스트 최소 5개 이상 최대 13개 이상(2x2,2x1)
                } else if (cnt.MIN_COUNT > 5 && cnt.MAX_COUNT > 13) {
                    paperPrint("2x2x1");
                // 품목리스트 최소 5개 이하 최대 13개 이상이지만 최소 5개 이상 최대 13개 이하의 송장은 없음(2x4,2x1)
                } else if (cnt.MIN_COUNT <= 5 && cnt.MAX_COUNT > 13 && cnt.WHY == '1') {
                    paperPrint("2x4x1");
                // 품목리스트 최소 5개 이하 최대 13개 이상이고 최소 5개 이상 최대 22개 이하 송장을 포함(2x4,2x2,2x1)
                } else if (cnt.MIN_COUNT <= 5 && cnt.MAX_COUNT > 13 && cnt.WHY == '0') {
                    paperPrint("all");
                }
            }
        } else if (sid == "sid_setDelete") {
            cfn_msg("INFO", "정상적으로 삭제되었습니다.");
            cfn_retrieve();
        }
    }
        
    function openPopup(urlType) {
        
        var url = "";
        var pid = "";
        
        if (urlType == "amazon") {
            url = "/fulfillment/order/OrderAmazon/view.do";
            pid = "OrderAmazon";
        } else if (urlType == "etsy") {
            url = "/fulfillment/order/etsy/view.do";
            pid = "etsyUpload";
        } else if (urlType == "ebay") {
            url = "/fulfillment/order/ebay/view.do";
            pid = "ebayUpload";
        } else {
            url = "/fulfillment/order/OrderInsert/view.do";
            pid = "OrderInsert";
        }
        
        pfn_popupOpen({
            url: url
            , pid: pid
            , returnFn: function(data, type) {
                if (type === "OK") {
                }
            }
        });
    }

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        if(cfn_isFormRequireData("frmSearch") == false) return;

        gv_searchData = cfn_getFormData("frmSearch");

        var sid = "sid_getSearch";
        var url = "/fulfillment/order/orderList/getSearch.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }

    //공통버튼 - 초기화
    function cfn_init() {
        reset_Search();
    }

    //공통버튼 - 삭제 클릭
    function cfn_del() {
        var rowidx = $("#grid1").gfn_getCurRowIdx();

        if (rowidx < 0) {
            cfn_msg("WARNING", "선택된 오더가 없습니다.");
            return false;
        }

        var masterData = $("#grid1").gfn_getDataRow(rowidx);

        if (masterData.delFlg == "DELETED") {
            cfn_msg("WARNING", "이미 삭제된 오더입니다.");
            return false;
        }

        if (confirm("송장번호[" + masterData.xrtInvcSno + "]를 삭제하시겠습니까?")) {
            var sid = "sid_setDelete";
            var url = "/fulfillment/order/orderList/setDelete.do";
            var sendData = {"paramData": masterData};

            gfn_sendData(sid, url, sendData);
        }
    }

    //송장 출력
    function fn_invcprint() {
        
        var sInvcStart = $("#S_INVCSTART").val()||"";
        var sInvcEnd = $("#S_INVCEND").val()||"";
        var sWhcd = $("#sWhcd").val()||"";
        var sOrgCd = $("#sOrgCd").val()||"";
        
        if (sWhcd == "") {
            cfn_msg("WARNING", "선택된 창고가 없습니다.");
            $("#sWhcd").focus();
            return;
        }
        
        if (sOrgCd == "") {
            cfn_msg("WARNING", "선택된 셀러가 없습니다.");
            $("#sOrgCd").focus();
            return;
        }

        if (sInvcStart == "" && sInvcEnd == "") {
            cfn_msg("WARNING", "선택된 송장이 없습니다.");
            return false;
        }
        
        $("#sInvcStart").val(sInvcStart);
        $("#sInvcEnd").val(sInvcEnd);
        gv_searchData = cfn_getFormData("frmSearch");

        var sid = "sid_getCnt";
        var url = "/fulfillment/order/orderList/getCnt.do";
        var sendData = gv_searchData;

        gfn_sendData(sid, url, sendData, true);
    }
    // 송장출력
    function paperPrint(type) {

        var sWhcd = $("#sWhcd").val(); // 창고코드
        var sOrgCd = $("#sOrgCd").val(); // 셀러코드
        var sToDate = $("#sToDate").val(); // 시작 날짜
        var sFromDate = $("#sFromDate").val(); // 종료 날짜
        var sFileSeq = $("#sFileSeq").val()||0; // 차수
        var sToNation = $("#sToNation").val()||""; // 출발 국가
        var sFromNation = $("#sFromNation").val()||""; //도착국가
        var sKeyword = $("#sKeyword").val()||""; // 송장,주문,장바구니번호
        var sINVCSTART = $("#S_INVCSTART").val()||""; // 시퀸스 start
        var sINVCEND = $("#S_INVCEND").val()||""; // 시퀸스 end
        var jrfName = "";
        
        switch (type) {
            case "2x4" :
                jrfName = "XROUTE_A4_2x4";
                break;
            case "2x2" :
                jrfName = "XROUTE_A4_2x2";
                break;
            case "2x1" :
                jrfName = "XROUTE_A4_2x1";
                break;
            case "L2x1" :
                jrfName = "XROUTE_LABEL_2x1";
                break;
            case "L1x1" :
                jrfName = "XROUTE_LABEL_1x1";
                break;
            case "all" :
                jrfName = "XROUTE_A4_2x4.jrf,XROUTE_A4_2x2.jrf,XROUTE_A4_2x1";
                break;
            case "2x4x2" :
                jrfName = "XROUTE_A4_2x4.jrf,XROUTE_A4_2x2";
                break;
            case "2x4x1" :
                jrfName = "XROUTE_A4_2x4.jrf,XROUTE_A4_2x1";
                break;
            case "2x2x1" :
                jrfName = "XROUTE_A4_2x2.jrf,XROUTE_A4_2x1";
                break;
            default:
                break;
        }
        
        if (jrfName == "") {
            alert("지정된 송장출력 파일이 없습니다.");
            return;
        }
        
        rfn_reportLabel({
            title:"XTOUTE송장"
            , jrfName: jrfName
            , isMultiReport: true
            , multicount: 1
            , args: {
                "S_WHCD": sWhcd
                , "S_ORGCD": sOrgCd
                , "S_UPLOADDATE": sToDate
                , "E_UPLOADDATE": sFromDate
                , "S_FILE_SEQ": sFileSeq
                , "S_NATION": sToNation
                , "E_NATION": sFromNation
                , "S_KEYWORD": sKeyword
                , "S_INVC_START": sINVCSTART
                , "S_INVC_END": sINVCEND
            }
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />