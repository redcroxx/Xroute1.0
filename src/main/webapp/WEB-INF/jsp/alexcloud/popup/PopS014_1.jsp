<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
    화면코드 : popS014
    화면명    : 팝업-공지사항
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>공지사항</title>
<link href="/css/common.css" rel="stylesheet">
<script type="text/javascript">
    function setCookie(name, value, expiredays) {
        var todayDate = new Date();
        todayDate.setDate(todayDate.getDate() + expiredays);
        document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
    }
    function closePop() {
        if (document.frm.pop.checked) {
            setCookie($('#NTKEY').val(), "done", 1);
        }
        self.close();
    }
</script>
</head>
<body style="background-color: #f0f0f0;">
    <div id="popS014" class="pop_wrap ui-dialog-content ui-widget-content" style="margin: 20px;">
        <nav class="navbar navbar-light" style="margin-bottom: 30px; background-color: #e1e1e1; text-align: left; padding: 10px 10px 10px 10px;">
              <img src="/images/main/documents.png" width="30" height="30" class="d-inline-block align-top" alt="">
              <label for="notice" style="font-size: 25px; margin-top: 10px; margin-right: 670px;"><b>공지사항</b></label>
        </nav>
        <!-- 기본정보영역 시작 -->
        <form id="frmNotice" name="frm" action="#" onsubmit="return false">
            <input type="hidden" id="NTKEY" value="${NTKEY}" />
            <div class="ct_top_wrap"></div>
            <table class="tblForm" style="min-width: 800px; border: 1 solid;">
                <colgroup>
                    <col width="15%" />
                    <col width="85%" />
                </colgroup>
                <tr>
                    <th style="text-align: center; padding: 10px 10px 10px 10px;"><b>제목</b></th>
                    <td>
                        <div>
                            <c:out value="${TITLE}" escapeXml="false" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <th style="text-align: center; vertical-align: middle; padding: 10px 10px 10px 10px;"><b>작성자</b></th>
                    <td>
                        <div>
                            <c:out value="${ADDUSERCD}" escapeXml="false" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <th style="text-align: center; vertical-align: middle; padding: 10px 10px 10px 10px;"><b>작성일시</b></th>
                    <td>
                        <div>
                            <c:out value="${ADDDATETIME}" escapeXml="false" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <th style="text-align: center; vertical-align: middle;"><b>내용</b></th>
                    <td>
                        <div style="min-height: 250px">
                            <c:out value="${CONTENTS}" escapeXml="false" />
                        </div>
                    </td>
                </tr>
            </table>
            <div style="padding-bottom: 10px;">
                <footer style="text-align:left; margin-bottom: 15px; font-size: 15px;">
                    <input class="cmc_checkbox" type="checkbox" name="pop" id="closecheckbox" onclick="closePop();" style="width: 20px;">
                    <label for="closecheckbox" style="position: relative; top: -1.5px;"><b>1일동안 이 창을 열지 않음 [닫기]</b></label>
                </footer>
            </div>
        </form>
    </div>
</body>
</html>
