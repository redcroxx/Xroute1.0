<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>XROUTE</title>
<link href="/css/jquery/jquery-ui.min.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet">
<link href="/css/login.css" rel="stylesheet">
<script src="/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/js/jquery/jquery-ui-1.12.1.min.js" type="text/javascript"></script>
<script src="/js/shortcut.min.js" type="text/javascript"></script>
<script src="/js/common.js" type="text/javascript"></script>
<script src="/js/content.js" type="text/javascript"></script>
<script src="/js/popup.js" type="text/javascript"></script>
<link rel="SHORTCUT ICON" href="/images/logo/favicon.png">
</head>
<body class="mainbody">
    <div id="login_wrap">
        <div id="login_content_wrap">
            <div id="login_content">
                <table style="width: 500px;">
                    <tr>
                        <td style="height: 65px; background: url(/images/img_login_line.png) 0 14px repeat-x; vertical-align: middle;">
                            <img src="/images/logo/login_logo.png" alt="" style="width: 200px;" />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 27px;">
                            <form id="loginForm" name="loginForm" method="post" action="#" onsubmit="return false">
                                <table style="width: 100%;">
                                    <tr>
                                        <td style="padding: 0 20px 0 0px; vertical-align: top;">
                                            <img src="/images/img_login_user.png" width="180" height="182">
                                        </td>
                                        <td style="padding-top: 3px;">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td colspan="2">
                                                        <input type="hidden" name="Language" id="Language" value="kr" />
                                                        <input type="hidden" name="COMPCD" id="COMPCD" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <input type="text" id="USERCD" name="USERCD" class="idInput" placeholder="ID" tabindex="1"
                                                            onKeyPress="if(event.keyCode == 13) document.loginForm.PASSWD.focus();"
                                                        />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <input type="password" id="PASSWD" name="PASSWD" class="pwInput" placeholder="Password" tabindex="2"
                                                            onKeyPress="if(event.keyCode == 13) fn_login();"
                                                        />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 24px; vertical-align: top; padding-bottom: 30px;">
                                                        <label for="checkIdPw">
                                                            <input type="checkbox" id="checkIdPw" name="checkIdPw" onclick="saveid(document.loginForm);" />
                                                            &nbsp;&nbsp;ID 저장
                                                        </label>
                                                    </td>
                                                    <td style="vertical-align: top; text-align: right;">
                                                        <a href="#" onclick="location.href = '/signup/SignUp.do';">회원가입</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <input type="button" class="btn_login" onclick="fn_login();" value="Login" tabindex="3" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="login_bottom">
                <span style="padding-left: 100px; color: #a4a4a4; line-height: 21px; float: left;">주소 : 서울특별시 강서구 하늘길 210, 105호(김포공항 화물청사8-1 A창고)</span>
                <br />
                <span style="padding-left: 100px; color: #a4a4a4; line-height: 21px; float: left;">사업자등록번호 : 215-81-89514 | 대표 : 신상우 | 개인정보관리자 : 김광희</span>
                <br />
                <span style="padding-left: 100px; color: #a4a4a4; line-height: 21px; float: left;">대표번호 : 02-6956-6603 | 팩스 : 070-8233-6603 | 이메일 : info@xroute.co.kr</span>
                <br />
                <span style="padding-left: 100px; color: #a4a4a4; line-height: 21px; float: left;">© 2019 XROUTE IN LOGIFOCUS CORP. ALL RIGHTS RESERVED</span>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
    $(function() {
        
        var host = document.location.host;

        if (host.indexOf("localhost") < 0) {
            if (document.location.protocol == "http:") {
                document.location.href = document.location.href.replace("http:", "https:");
            }
        }

        getid(document.loginForm);
        getLanguage(document.loginForm);
        document.loginForm.USERCD.focus();
        var agent = navigator.userAgent.toLowerCase();
        if (agent.indexOf("chrome") == -1) {
            cfn_msg('ERROR', "XROUTE은 Google Chrome 브라우저를 \n기반으로 개발된 솔루션입니다. \n\n Chrome이 아닌 다른 브라우저의 환경에서는 \n화면깨짐, 작동오류, 멈춤현상, 기능오작동 \n등의 많은 문제가 발생할 수 있습니다.\n\n* <b>Chrome 사용을 권장합니다.<b>");
        }
    });

    function fn_login() {

        frm = document.loginForm;
        if (frm.USERCD.value === '') {
            cfn_msg('WARNING', '아이디를 입력하세요.');
            frm.USERCD.focus();
            return false;
        }
        if (frm.PASSWD.value === '') {
            cfn_msg('WARNING', '암호를 입력하세요.');
            frm.PASSWD.focus();
            return false;
        }

        var v_searchFormInfo = cfn_getFormData('loginForm');
        var url = '/comm/getLogin.do';
        var sendData = {
            'paramData' : v_searchFormInfo
        };

        gfn_ajax(url, true, sendData, function(data, xhr) {
            var loginFlg = data.resultLoginFlg;
            var loginFailCnt = data.resultFailCnt;

            if (loginFlg == 0) {
                cfn_msg('ERROR', '로그인 아이디가 없습니다.');
            } else if (loginFlg == 'P') {
                cfn_msg('ERROR', '로그인 비밀번호가 일치하지 않습니다. \n5회연속 실패시 계정잠김처리됩니다. \n(' + loginFailCnt + ')회 연속 실패');
            } else if (loginFlg == 'I') {
                alert('비밀번호 초기화로 변경 페이지로 이동합니다.');
                fn_modifyUserInfo(data.resultLoginID);
            } else if (loginFlg == 'L') {
                cfn_msg('ERROR', '계정이 잠겼습니다.\n관리자에게 문의하십시오.');
            } else if (loginFlg == 'N') {
                cfn_msg('ERROR', '최근 로그인 이후 30일이 지났습니다.\n관리자에게 문의하십시오.');
            } else if (loginFlg == 'O') {
                alert('비밀번호 변경 후 90일이 지났습니다.\n비밀번호 변경 페이지로 이동합니다.');
                fn_modifyUserInfo(data.resultLoginID);
            } else if (loginFlg == 'PT') {
                alert("정기결제 페이지로 넘어갑니다.")
                openPaymentAuthPop(data.resultLoginID);
            } else if (loginFlg == 'R') {
                alert("다시 로그인을 해주세요.")
            } else {
                //아이디,비번 쿠키저장
                saveid(frm);
                //언어 쿠키저장
                saveLanguage(frm);

                localStorage.clear();

                /* 그리드 정보 로컬스토리지에 담기  */
                var list = data.resultGridInfoAll;

                for (var i = 0; i < list.length; i++) {
                    var key = list[i].APPKEY + list[i].GRIDID;
                    localStorage.setItem(key, list[i].COLJSON);
                }

                location.href = '/comm/main.do';
            }
        });
    }

    function setCookie(name, value, expires) {
        document.cookie = name + "=" + escape(value) + "; path=/; expires=" + expires.toGMTString();
    }

    function getCookie(Name) {
        var search = Name + "=";
        if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
            offset = document.cookie.indexOf(search);
            if (offset != -1) { // 쿠키가 존재하면
                offset += search.length;
                // set index of beginning of value
                end = document.cookie.indexOf(";", offset);
                // 쿠키 값의 마지막 위치 인덱스 번호 설정
                if (end == -1)
                    end = document.cookie.length;
                return unescape(document.cookie.substring(offset, end));
            }
        }

        return "";
    }

    // 아이디 쿠기 저장
    function saveid(form) {
        var expdate = new Date();
        // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
        if (form.checkIdPw.checked) {
            expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
        } else {
            expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
        }
        setCookie("saveid", form.USERCD.value, expdate);
        setCookie("savepw", form.PASSWD.value, expdate);
    }

    // 쿠키에 저장된 아이디 가져오기
    function getid(form) {
        form.USERCD.value = getCookie("saveid");
        form.PASSWD.value = getCookie("savepw");

        form.checkIdPw.checked = (form.USERCD.value != "");
    }

    // 언어 쿠키 저장
    function saveLanguage(form) {
        var expdate = new Date();
        // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일

        var lang = 'kr';
        if (cfn_isEmpty($('#Language').val()) === false) {
            lang = $('#Language').val();
        }

        setCookie('Language', lang, expdate);
    }

    // 쿠키에 저장된 언어 가져오기
    function getLanguage(form) {
        if (getCookie("Language") == 'null') {
            $("#Language").val("kr");
        } else {
            $("#Language").val(getCookie("Language"));
        }
    }

    //90일 비밀번호 변경  
    function fn_modifyUserInfo(id) {
        pfn_popupOpen({
            url : '/sys/popup/popPwChange/view.do',
            params : {
                'USERCD' : id
            },
            returnFn : function(data, type) {
                if (type == 'OK') {
                    cfn_msg('INFO', '정상적으로 처리되었습니다.');
                    document.loginForm.PASSWD.value = '';
                }
            }
        });
    }

    //90일 비밀번호 변경  
    function openPaymentAuthPop(id) {
        pfn_popupOpen({
            url : "/sys/passBook/view.do",
            pid : "passBookPop",
            params : {
                'USERCD' : id
            },
            returnFn : function(data, type) {
                if (type == 'OK') {
                    location.href = '/comm/main.do';
                }
            }
        });
    }
</script>
</html>
