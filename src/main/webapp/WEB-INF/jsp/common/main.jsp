<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>XROUTE</title>
<c:import url="/comm/commJsCsImpt.do" />
<script type="text/javascript">
    $(function() {
        getLanguage();

        $("#toplogo").on("click", function() {
            location.href = "/comm/main.do";
        }).css("cursor", "pointer");

        topmenu_onclick($("#topmenu ul li:first"), $("#hdn_fMenuKey").val(), $("#hdn_fl1title").val());

        //유저그룹에 따라 탭 화면 분리 2019. 10. 15 양동근 
        //기존 jsp 하단에서 생성 되던 탭 -> add_tab2()으로 생성되도록 변경
        //위의 함수로 탭을 생성해야 공통버튼관련 함수가 제대로 요청 됨
        var fixedtabCounter = 0;
        var fixedtabIndex = 0;
        var session = "<c:out value='${sessionScope.loginVO.print1}' />";

        //console.log(session);
        if ("<c:out value='${sessionScope.loginVO.usergroup}' />" == "<c:out value='${constMap.CENTER_USER}'/>") {
            $("#main_left_menu").hide();
            $("#main_contents").css({
                width : "100%",
                left : 0
            });

            add_tab2("/fulfillment/stock/stockList/view.do", "입고리스트", "20", "10", "StockList", "", 2, 1, false)

        } else {
            //화면 로드시 첫번째 대메뉴 클릭 이벤트 발생
            add_tab2("/fulfillment/order/shippingList/view.do", "주문배송조회", "7", "10", "ShippingList", "", 2, 1, false)
        }
    });

    // 메인메뉴 이동
    function topmenu_onclick(obj, menu, title) {
        $(".leftmenu_title").html(title);
        if ($("#chk_menu_hs").val() == "H") {
            $("#main_left_menu").attr("class", "left_wrap");
            $("#main_contents").attr("class", "content_wrap");
            $("#chk_menu_hs").val("S");
            $(".accordion_box").show();
        }
        $("#topmenu ul li").attr("class", "");
        $(obj).attr("class", "on");

        var url = "/comm/leftmenuLoad.do";
        var sendData = {
            "menu" : menu
        };

        gfn_ajax(
                url,
                false,
                sendData,
                function(data, xhr) {
                    var menuL2List = data.resultMenuL2List;
                    var menuL3List = data.resultMenuL3List;
                    var accoHtml = "<div id='accordion'>";

                    for (var i = 0; i < menuL2List.length; i++) {
                        accoHtml += "<h3>" + menuL2List[i].L2TITLE + "</h3><div style='overflow-x:hidden;'><ul class='leftmenu_list'>";

                        for (var j = 0; j < menuL3List.length; j++) {
                            if (menuL2List[i].MENUL2KEY == menuL3List[j].MENUL2KEY) {
                                accoHtml += '<li style="cursor:pointer;" onclick="add_tab(\''
                                    + menuL3List[j].APPURL
                                    + '\', \''
                                    + menuL3List[j].L3TITLE
                                    + '\', \''
                                    + menuL3List[j].MENUL1KEY
                                    + '\', \''
                                    + menuL3List[j].MENUL2KEY
                                    + '\', \''
                                    + menuL3List[j].APPKEY
                                    + '\');"><span style="white-space:nowrap;" title="' + menuL3List[j].L3TITLE + '">'
                                    + menuL3List[j].L3TITLE
                                    + '</span></li>';
                            }
                        }

                        accoHtml += "</ul></div>";
                    }
                    accoHtml += "</div>";
                    accoHtml += "<div style='margin-top: 20px;cursor: pointer'>";
                    accoHtml += "<img src='/images/new_promotion_code_banner.png' onclick='promotionPop()' style='width: 187px; height: 50px;' >";
                    accoHtml += "</div>";
                    accoHtml += "<div style='margin-top: 20px;cursor: pointer'>";
                    accoHtml += "<img src='/images/new_tracking_popup_banner.png' onclick='trackingPop()' style='width: 187px; height: 50px;' >";
                    accoHtml += "</div>";
                    
                    $(".accordion_box").html(accoHtml);

                    $("#accordion").accordion({
                        heightStyle : "content",
                        collapsible : false,
                        active : false
                    });

                    /*
                    $('#accordion .ui-accordion-content').show(); //메뉴 모두 펼치기
                     */
        });
    }

    //좌측 메뉴 접기
    function leftMenu_hide() {
        if ($("#chk_menu_hs").val() == "S") {
            $("#main_left_menu").attr("class", "left_wrap_min");
            $("#main_contents").attr("class", "content_wrap_min");
            $("#main_leftmenubtnImg").attr("src", "/images/btn_leftshow.png");
            $("#chk_menu_hs").val("H");
            $(".accordion_box").hide();
        } else {
            $("#main_left_menu").attr("class", "left_wrap");
            $("#main_contents").attr("class", "content_wrap");
            $("#main_leftmenubtnImg").attr("src", "/images/btn_lefthide.png");
            $("#chk_menu_hs").val("S");
            $(".accordion_box").show();
        }
    }

    //언어 쿠키 저장
    function saveLanguage(form) {
        var expdate = new Date();
        // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일

        setCookie("Language", $("#Language").val(), expdate);
    }

    // 쿠키에 저장된 언어 가져오기
    function getLanguage(form) {
        if (getCookie("Language") != null && getCookie("Language") != "") {
            $("#Language").val(getCookie("Language"));
        }
    }
    
    function promotionPop() {
        var url = "/sys/promotionCode/pop/input/view.do";
        var pid = "promotionCodeInputPop";
        var params = {};

        pfn_popupOpen({
            url : url,
            pid : pid,
            params : params,
            returnFn : function(data, type) {
                if (type == "OK") {
                    
                }
            }
        });
    }
    
    function trackingPop() {
        // 트랙킹 윈도우 팝업 호출.
        var width = "1000";
        var height = "690";
        var left = (window.screen.width/2) - (width/2);
        var top = (window.screen.height/2) - (height/2);
        var url = "/sys/tracking/pop/view.do?invcSno=";
        var option = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top + ", resizable=no, scrollbars=no, menubar=no, location=no, status=no";
        var openWin = window.open(url, "트랙킹팝업", option);
    }

    // 언어 변경 이벤트
    function changeLanguage() {
        saveLanguage();
        location.reload();
    }
</script>
</head>
<body class="mainbody">
    <!-- 현재 탭인덱스값 저장 -->
    <input type="hidden" id="mainTabsNo" />
    <!-- 좌측메뉴 접기 펴기 접기 : H, 펴기 : S -->
    <input type="hidden" id="chk_menu_hs" value="S">
    <!---------- 상단메뉴부분 ------------------->
    <c:import url="topmenu.jsp" />
    <!---------- 좌측메뉴부분 ------------------->
    <div id="main_left_menu" class="left_wrap">
        <p class="leftmenu_title"></p>
        <div id="main_leftmenubtn" onclick="leftMenu_hide();">
            <img src="/images/btn_lefthide.png" id="main_leftmenubtnImg" alt="">
        </div>
        <c:import url="/comm/leftmenu.do">
        </c:import>
    </div>
    <!---------- 상세부분 ------------------->
    <c:choose>
        <c:when test="${sessionScope.loginVO.usergroup <= constMap.SELLER_ADMIN}">
            <div id="main_contents" class="content_wrap">
                <div id="tabs">
                    <ul>
                        <li>
                            <a href="#tabs-1">&nbsp;메인&nbsp;</a>
                        </li>
                    </ul>
                    <div id="tabs-1">
                        <iframe src="/comm/mainContentSeller.do" id="icontent" name="icontent" style="width: 100%; height: 100%;"></iframe>
                    </div>
                </div>
            </div>
        </c:when>
        <c:when test="${sessionScope.loginVO.usergroup eq constMap.CENTER_USER}">
            <div id="main_contents" class="content_wrap">
                <div id="tabs">
                    <ul>
                        <li>
                            <a href="#tabs-1">입고스캔</a>
                        </li>
                    </ul>
                    <div id="tabs-1">
                        <iframe src="/fulfillment/stock/stockInsert/view.do" id="stockInsert" name="stockInsert" style="width: 100%; height: 100%;"></iframe>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div id="main_contents" class="content_wrap">
                <div id="tabs">
                    <div style="position: absolute; left: calc(100% - 73px); top: 8px;">
                        <input type="button" id="tabsAllClose" style="outline: none;" />
                    </div>
                    <ul>
                        <li>
                            <a href="#tabs-1">&nbsp;메인&nbsp;</a>
                        </li>
                    </ul>
                    <div id="tabs-1">
                        <iframe src="/comm/mainContent.do" id="icontent" name="icontent" style="width: 100%; height: 100%;"></iframe>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    <div class="cls"></div>
</body>
</html>