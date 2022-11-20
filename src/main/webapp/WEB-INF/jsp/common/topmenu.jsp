<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
    화면코드 : topmenu
    화면명   : 탑메뉴
-->
<script type="text/javascript">
    //정보변경 클릭
    function fn_edituser() {
        pfn_popupOpen({
            url : "/sys/popup/popPwChange/view.do",
            params : {
                "COMPCD" : "<c:out value='${sessionScope.loginVO.compcd}' />",
                "USERCD" : "<c:out value='${sessionScope.loginVO.usercd}' />"
            },
            returnFn : function(data, type) {
                if (type == "OK") {
                    cfn_msg("INFO", "정상적으로 처리되었습니다.");
                }
            }
        });
    }
    //프린터설정 클릭
    function fn_editprint() {
        pfn_popupOpen({
            url : "/sys/popup/popPrint/view.do",
            params : {
                "COMPCD" : "<c:out value='${sessionScope.loginVO.compcd}' />",
                "USERCD" : "<c:out value='${sessionScope.loginVO.usercd}' />"
            },
            returnFn : function(data, type) {
                if (type == "OK") {
                    cfn_msg("INFO", "정상적으로 처리되었습니다.");
                }
            }
        });
    }
    //업데이트정보 클릭
    function fn_release() {
        pfn_popupOpen({
            url : "/sys/popup/popSystemRelease/view.do"
        });
    }

    //로그아웃 클릭
    function logout() {
        location.href = "/comm/logout.do";
    }
</script>
<div id="top_wrap">
    <div id="toplogo">
        <img src="/images/logo/top_logo.png" alt="xroute" style="width: 160px; padding-top: 0px; padding-left: 20px;" />
    </div>
    <div id="topmenu">
        <ul>
            <c:forEach var="menul1" items="${resultMenuL1List}" varStatus="theCount">
                <c:choose>
                    <c:when test="${theCount.index == 0}">
                        <li class="on" onclick="topmenu_onclick(this, '<c:out value="${menul1.MENUL1KEY}" />', '<c:out value="${menul1.L1TITLE}" />');">
                            <c:out value="${menul1.L1TITLE}" />
                        </li>
                        <input type="hidden" id="hdn_fMenuKey" value="<c:out value='${menul1.MENUL1KEY}'/>" />
                        <input type="hidden" id="hdn_fl1title" value="<c:out value='${menul1.L1TITLE}'/>" />
                    </c:when>
                    <c:otherwise>
                        <li onclick="topmenu_onclick(this, '<c:out value="${menul1.MENUL1KEY}" />', '<c:out value="${menul1.L1TITLE}" />');">
                            <c:out value="${menul1.L1TITLE}" />
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
    </div>
    <div id="toplogininfo">
        <img src="/images/icon_userinfo.png" width="16" alt="" />
        <span>
            <c:out value="${loginVO.usercd}" />
            [
            <c:out value="${loginVO.name}" />
            ]
        </span>
        | 소속 :
        <c:out value="${loginVO.deptnm}" />
        | 권한 :
        <c:out value="${loginVO.usergroupnm}" />
        |
        <a href="#" onclick="fn_edituser();">정보변경</a>
        |
        <a href="#" onclick="fn_editprint();">프린터설정</a>
        |
        <a href="#" onclick="logout();">로그아웃</a>
    </div>
</div>
<div class="cls"></div>