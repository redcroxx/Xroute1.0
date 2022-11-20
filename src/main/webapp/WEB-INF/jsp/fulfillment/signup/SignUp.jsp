<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<title>XROUTE</title>
</head>
<body>
    <div class="container">
        <div class="col-md-10 order-md-1">
            <h2>회원정보 등록</h2>
            <form class="form-horizontal" action="post" onsubmit="return false">
                <div style="width: 90%; margin-bottom: 5px;">
                    <label for="userId" class="control-label">
                        아이디
                        <span class="label label-danger">필수</span>
                    </label>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="input-group">
                            <input type="text" class="form-control" id="userId" placeholder="아이디를 입력하세요.">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" type="button" onclick="fn_idCheck()">중복확인</button>
                            </span>
                        </div>
                    </div>
                    <div>
                        <span id="msg"></span>
                    </div>
                </div>
                <br />
                
                <div class="row">
                    <div class="col-md-5 mb-5">
                        <label for="companyKr">
                            회사명(한글)
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="text" class="form-control" id="company" onkeyup="strLengthCheck(this,20)" placeholder="회사명을 입력하세요.">
                    </div>
                    <div class="col-md-5 mb-5">
                        <label for="companyEn">
                            회사명(영문)
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="text" class="form-control" id="companyEn" onkeyup="strLengthCheck(this,20)" oninput="onlyEnglish(this)" placeholder="회사명을 영문으로 입력하세요.">
                    </div>
                </div>
                <br />
                
                <div class="row">
                    <div class="col-md-5 mb-5">
                        <label for="ceo">
                            대표자 이름
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="text" class="form-control" id="ceo" onkeyup="strLengthCheck(this,20)" placeholder="대표자 이름을 입력하세요.">
                    </div>
                    <div class="col-md-5 mb-5">
                        <label for="ceoEng">
                            대표자 영문 이름
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="text" class="form-control" id="ceoEng" onkeyup="strLengthCheck(this,50)" oninput="onlyEnglish(this)" placeholder="대표자 영문 이름을 입력하세요.">
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-5 mb-5">
                        <label for="bizNo">
                            사업자 번호
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="text" class="form-control" id="bizNo" onkeyup="strLengthCheck(this,12)" placeholder="사업자 번호를 입력하세요.">
                    </div>
                    <div class="col-md-5 mb-5">
                        <label for="fileNm">
                            사업자등록증 사본
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="file" id="fileNm" onchange="fn_fileChange(this)">
                        파일 용량 :
                        <span id="fileSize">0</span>
                        KB
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-5 mb-5">
                        <label for="name">
                            담당자 이름
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="text" class="form-control" id="name" onkeyup="strLengthCheck(this,20)" placeholder="담당자 이름을 입력하세요.">
                    </div>
                    <div class="col-md-5 mb-5">
                        <label for="eMail">
                            대표 이메일
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="text" class="form-control" id="eMail" placeholder="대표 이메일을 입력하세요.">
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-5 mb-5">
                        <label for="postCode">
                            우편번호
                            <span class="label label-danger">필수</span>
                        </label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="postCode" readonly="readonly">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" type="button" onclick="fn_addressSearch()">검색</button>
                            </span>
                        </div>
                    </div>
                    <div class="col-md-5 mb-5">
                        <label for="address">
                            주소
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="text" class="form-control" id="address" readonly="readonly" placeholder="우편번호를 선택하세요.">
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-5 mb-5">
                        <label for="addressDtl">
                            상세 주소
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="text" class="form-control" id="addressDtl" onkeyup="strLengthCheck(this,100)" placeholder="상세주소를 입력하세요.">
                    </div>
                    <div class="col-md-5 mb-5">
                        <label for="addressEng">
                            영문 주소
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="text" class="form-control" id="addressEng" onkeyup="strLengthCheck(this,200)" placeholder="영문 주소를 입력하세요.">
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="tel1">
                            전화번호1
                            <span class="label label-danger">필수</span>
                        </label>
                        <input type="text" class="form-control" id="tel1" onkeyup="strLengthCheck(this,4); removeChar(event);" onkeydown="return onlyNumber(event)" placeholder="지역번호를 입력하세요.">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="tel2">&nbsp;</label>
                        <input type="text" class="form-control" id="tel2" onkeyup="strLengthCheck(this,4); removeChar(event);" onkeydown="return onlyNumber(event)" placeholder="전화번호 앞자리를 입력하세요.">
                    </div>
                    <div class="col-md-4 mb-4">
                        <label for="tel3">&nbsp;</label>
                        <input type="text" class="form-control" id="tel3" onkeyup="strLengthCheck(this,4); removeChar(event);" onkeydown="return onlyNumber(event)" placeholder="전화번호 뒷자리를 입력하세요.">
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="phoneNo1">전화번호2 </label>
                        <input type="text" class="form-control" id="phoneNo1" onkeyup="strLengthCheck(this,4); removeChar(event);" onkeydown="return onlyNumber(event)" placeholder="지역번호를 입력하세요.">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="phoneNo2">&nbsp;</label>
                        <input type="text" class="form-control" id="phoneNo2" onkeyup="strLengthCheck(this,4); removeChar(event);" onkeydown="return onlyNumber(event)" placeholder="전화번호 앞자리를 입력하세요.">
                    </div>
                    <div class="col-md-4 mb-4">
                        <label for="phoneNo3">&nbsp;</label>
                        <input type="text" class="form-control" id="phoneNo3" onkeyup="strLengthCheck(this,4); removeChar(event);" onkeydown="return onlyNumber(event)" placeholder="전화번호 뒷자리를 입력하세요.">
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-5 mb-5">
                        <label for="webAddress">홈페이지</label>
                        <input type="text" class="form-control" id="webAddress" onkeyup="strLengthCheck(this,200)" placeholder="홈페이지를 입력하세요.">
                    </div>
                    <div class="col-md-5 mb-5">
                        <label for="nation">국가</label>
                        <input type="text" class="form-control" id="nation" onkeyup="strLengthCheck(this,50)" placeholder="국가를 입력하세요.">
                    </div>
                </div>
                <br />
                <div style="text-align: right; margin-bottom: 5px;">
                    <input type="checkbox" id="agreement">
                    <label for="agreement" style="margin-right: 55px;">이용약관</label>
                    <button type="button" class="btn btn-default" onclick="agreementPopup();">이용약관 팝업</button>
                </div>
                <div style="text-align: right; margin-bottom: 5px;">
                    <input type="checkbox" id="privacyPolicy">
                    <label for="privacyPolicy">개인정보동의</label>
                    <button type="button" class="btn btn-default" onclick="privacyPolicyPopup();">개인정보동의 팝업</button>
                </div>
                <div align="center">
                    <button type="button" class="btn btn-default" onclick="fn_main();">메인화면</button>
                    <button type="button" class="btn btn-danger" onclick="fn_reset();">초기화</button>
                    <button type="button" class="btn btn-success" onclick="fn_save();">회원가입 요청</button>
                </div>
            </form>
        </div>
    </div>
</body>
<script type="text/javascript">
    // 아이디 체크 유무
    var idCheckFlg = "N";
    // 아이디 상태
    var idState = "error";
    // 필수값 체크
    var emptyCheck = false;

    // 파일 변경사항 반영
    function fn_fileChange(file) {

        // 파일사이즈 초기화
        var fileSize = fileSize = file.files[0].size;
        var rouundFileSize = Math.round(fileSize / 1000);
        $("#fileSize").text(rouundFileSize)

        var sizeCheck = rouundFileSize / 1000;
        var fileCheck = file.files;

        // 확장자 체크
        if (!/\.(gif|jpg|jpeg|png|pdf)$/i.test(fileCheck[0].name)) {
            alert("gif, jpg, jpeg, png, pdf 파일만 업로드 가능 합니다.");
            $("#fileNm").val("");
            $("#fileNm").replaceWith($("#fileNm").clone(true));

            // 파일 용량 제한 
        } else if (sizeCheck > 20) {
            alert("파일 용량은 20MB를 넘을 수 없습니다.\n\n현재 용량 : " + rouundFileSize + "KB");
            $("#fileNm").val("");
            $("#fileNm").replaceWith($("#fileNm").clone(true));
            fileSize = 0;
            $("#fileSize").text(rouundFileSize)
        } else {
            $("#fileSize").text(rouundFileSize)
        }
    }

    // 데이터 체크
    function dataCheck(value) {

        // 아이디 입력 확인
        if (value === "id") {
            if ($("#userId").val() === "") {
                alert("아이디를 입력하세요");
                $("#userId").focus();
                return false;
            }
        }

        if (value === "empty") {
            var emailVal = $("#eMail").val();
            var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            var pattern1 = /^[a-zA-Z0-9 ]+$/;
            var ceoEng = $("#ceoEng").val();
            var pattern2 = /^[a-zA-Z0-9 ~!@#$%^&*()_+-=`]+$/;
            var addressEng = $("#addressEng").val();
            // 중복확인 버튼 클릭 유무
            if (idCheckFlg === "N") {
                alert("아이디 입력후 중복확인을 하시기 바랍니다.");
                $("#userId").focus();
                return false;

                // 아이디 빈값 체크
                if ($("#userId").val() === "") {
                    alert("아이디를 입력하세요");
                    $("#userId").focus();
                    return false;
                }
                // 아이디 상태값 확인
            } else if (idState === "error") {
                alert("아이디를 확인 하시기 바랍니다.");
                $("#userId").focus();
                return false;
            }
            if ($("#company").val() == null || $("#company").val() == "") {
                alert("회사명을 입력해주세요.");
                $("#company").focus();
                return false;
            }
            if ($("#companyEn").val() == null || $("#companyEn").val() == "") {
                alert("회사명을 입력해주세요.");
                $("#companyEn").focus();
                return false;
            }
            if ($("#ceo").val() == null || $("#ceo").val() == "") {
                alert("대표자 이름을 입력해주세요.");
                $("#ceo").focus();
                return false;
            }
            if ($("#ceoEng").val() == null || $("#ceoEng").val() == "") {
                alert("대표자 영문 이름을 입력해주세요.");
                $("#ceoEng").focus();
                return false;
            } else if (!pattern1.test(ceoEng)) {
                alert("대표자 영문 이름은 영문으로 입력하여야 합니다.");
                $("#ceoEng").focus();
                return false;
            }
            if ($("#bizNo").val() == null || $("#bizNo").val() == "") {
                alert("사업자 등록번호를 입력해주세요.");
                $("#bizNo").focus();
                return false;
            }
            if ($("#fileNm").val() == null || $("#fileNm").val() == "") {
                alert("사업자등록증을 첨부해주세요.");
                return false;
            }
            if ($("#name").val() == null || $("#name").val() == "") {
                alert("담당자 이름을 입력해주세요.");
                $("#name").focus();
                return false;
            }
            if ($("#eMail").val() == null || $("#eMail").val() == "") {
                alert("이메일을 입력해주세요.");
                $("#eMail").focus();
                return false;
            } else if (emailVal.match(regExp) == null) {
                alert("이메일 형식이 올바르지 않습니다.");
                $("#eMail").focus();
                return false;
            }
            if ($("#postCode").val() == null || $("#postCode").val() == "") {
                alert("우편번호 검색버튼을 눌러 주소를 입력해 주세요.");
                $("#postCode").focus();
                return false;
            }
            if ($("#addressDtl").val() == null || $("#addressDtl").val() == "") {
                alert("상세 주소는 필수 입력값 입니다.");
                $("#addressDtl").focus();
                return false;
            }
            if ($("#addressEng").val() == null || $("#addressEng").val() == "") {
                alert("영문 주소를 입력해주세요.");
                $("#addressEng").focus();
                return false;
            } else if (!pattern2.test(addressEng)) {
                alert("영문 주소는 영문으로 입력하여야 합니다.");
                return false;
            }
            if ($("#tel1").val() == null || $("#tel1").val() == "") {
                alert("전화번호를 입력해주세요.");
                $("#tel1").focus();
                return false;
            }
            if ($("#tel2").val() == null || $("#tel2").val() == "") {
                alert("전화번호를 입력해주세요.");
                $("#tel2").focus();
                return false;
            }
            if ($("#tel3").val() == null || $("#tel3").val() == "") {
                alert("전화번호를 입력해주세요.");
                $("#tel3").focus();
                return false;
            }
            if ($("#agreement").is(":checked") == false) {
                alert("이용약관 동의를 체크해주세요.");
                $("#agreement").focus();
                return false;
            }
            if ($("#privacyPolicy").is(":checked") == false) {
                alert("개인정보취급 동의를 체크해주세요.");
                $("#privacyPolicy").focus();
                return false;
            }
            return true
        }
    }

    // 아이디 중복 체크
    function fn_idCheck() {
        idCheckFlg = "Y";
        if (dataCheck("id") == false) {
            return;
        }
        var jsonObj = {};
        jsonObj.id = $('#userId').val();

        $.ajax({
            url : "/signup/IdCheck.do",
            contentType : "application/json",
            method : "POST",
            dataType : "json",
            data : JSON.stringify(jsonObj),
            success : function(result) {
                document.getElementById("msg").innerHTML = result.resultData.msg;
                if (result.resultData.flag == "Y") {
                    $("#userId").attr("readonly", true);// 아이디 체크 후 수정금지
                    idState = "success";
                } else if (result.resultData.flag == "N") {
                    idState = "error";
                }
            },
            error : function(result) {
                console.log("error result  : ", result);
            }
        });
    }

    //우편번호 검색
    function fn_addressSearch() {
        new daum.Postcode({
            oncomplete : function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ""; // 주소 변수
                var extraAddr = ""; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === "R") { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === "R") {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== "" && data.apartment === "Y") {
                        extraAddr += (extraAddr !== "" ? ", " + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== "") {
                        extraAddr = " (" + extraAddr + ")";
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // 도로명 타입일때 주소와 참고항목을 함께 넣는다.
                    $("#address").val(addr + "" + extraAddr);
                    ;
                } else {
                    // 도로명 타입이 아니면 주소만 넣는다.
                    $("#address").val(addr);
                }
                // 우편번호를 해당 필드에 넣는다.
                $("#postCode").val(data.zonecode);
                // 영문 주소 자동선택
                $("#addressEng").val(data.addressEnglish);
                // 커서를 상세주소 필드로 이동한다.
                $("#addressDtl").focus();
            }
        }).open();
    }

    // 글자 수 자르기
    function strLengthCheck(obj, maxlength) {
        var str = obj.value; // 이벤트가 일어난 컨트롤의 value 값    
        var str_length = str.length; // 전체길이      

        // 변수초기화    
        var max_length = maxlength; // 제한할 글자수 크기    
        var i = 0; // for문에 사용    
        var ko_byte = 0; // 한글일경우는 2 그밗에는 1을 더함    
        var li_len = 0; // substring하기 위해서 사용     
        var one_char = ""; // 한글자씩 검사한다     
        var str2 = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다.

        for (i = 0; i < str_length; i++) {
            // 한글자추출
            one_char = str.charAt(i);
            ko_byte++;
        }
        // 전체 크기가 max_length를 넘지않으면 입력 
        if (ko_byte <= max_length) {
            li_len = i + 1;
        }
        // 전체길이를 초과하면 자른다
        if (ko_byte > max_length) {
            str2 = str.substr(0, max_length);
            obj.value = str2;
        }

        obj.focus();
    }

    // 숫자만 입력
    function onlyNumber(event) {
        event = event || window.event;
        var keyID = (event.which) ? event.which : event.keyCode;
        if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9)
            return;
        else
            return false;
    }

    // 숫자가 아니면 자르기
    function removeChar(event) {
        event = event || window.event;
        var keyID = (event.which) ? event.which : event.keyCode;
        if (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
            return;
        else
            event.target.value = event.target.value.replace(/[^0-9]/g, "");
    }
    
    // 회사명(영문) 영어만 입력하기.
    function onlyEnglish(e) {
        e.value = e.value.replace(/[^A-Za-z]/ig, "");
    }

    // 초기화 버튼 클릭시 생성한 <p>삭제
    function fn_reset() {
        $("#openMsg").remove();
        $("#fileSize").text("0");
        // 초기화 후 수정 가능
        $("#userId").attr("readonly", false);
        // 아이디 체크 유무
        var idCheckFlg = "N";
        // 아이디 상태
        var idState = "error";
        // 필수값 체크
        var emptyCheck = false;
        $("input[type='text']").val("");
    }

    // 가입 신청
    function fn_save() {

        if (confirm("해당 정보로 가입 신청을 하시겠습니까?") == false) {
            return;
        }

        //필수값 체크
        if (dataCheck("empty") == true) {
            var objList = {
                "userId" : $("#userId").val(),
                "company" : $("#company").val(),
                "companyEn" : $("#companyEn").val(),
                "ceo" : $("#ceo").val(),
                "ceoEng" : $("#ceoEng").val(),
                "bizNo" : $("#bizNo").val(),
                "eMail" : $("#eMail").val(),
                "name" : $("#name").val(),
                "tel1" : $("#tel1").val(),
                "tel2" : $("#tel2").val(),
                "tel3" : $("#tel3").val(),
                "phone1" : $("#phoneNo1").val(),
                "phone2" : $("#phoneNo2").val(),
                "phone3" : $("#phoneNo3").val(),
                "postCode" : $("#postCode").val(),
                "address" : $("#address").val(),
                "addressEng" : $("#addressEng").val(),
                "addressDtl" : $("#addressDtl").val(),
                "webAddress" : $("#webAddress").val(),
                "nation" : $("#nation").val(),
            };

            // 파일 업로드
            var fileData = new FormData();
            $("#fileNm").each(function(i, tag) {
                fileData.append("fileObj", $(tag)[0].files[0]);
            });

            $.ajax({
                url : "/signup/setFile.do",
                data : fileData,
                processData : false,
                contentType : false,
                type : "POST",
                success : function(data) {
                    // 가입신청
                    // 서버에 저장된 파일의 realFileName 배열에 추가
                    objList.realFileName = data.resultAttachFile.ORIGINFILENM0;
                    objList.fileNm = data.resultAttachFile.FILENM0;
                    var jsonObj = {
                        "objList" : objList
                    };
                    $.ajax({
                        url : "/signup/setSave.do",
                        contentType : "application/json",
                        method : "POST",
                        dataType : "json",
                        data : JSON.stringify(jsonObj),
                        success : function(result) {
                            if (result.resultData.flag == "error") {
                                alert("처리에 실패 하였습니다. 다시 확인 해주시기 바랍니다.")
                            } else if (result.resultData.flag == 5) {
                                location.href = "/signup/SignUpSave.do";
                            }
                        },
                        error : function(result) {
                            console.log("error result  : ", result);
                        }
                    });
                }
            });
        }
    }

    // 개인정보 취급방침 윈도우 팝업.
    function privacyPolicyPopup() {
        var width = "1000";
        var height = "690";
        var left = (window.screen.width / 2) - (width / 2);
        var top = (window.screen.height / 2) - (height / 2);
        var url = "/comm/privacyPolicy.do";
        var option = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top + ", resizable=no, scrollbars=no, menubar=no, location=no, status=no";
        var openWin = window.open(url, "개인정보취급방침", option);
    }

    // 이용약관 윈도우 팝업.
    function agreementPopup() {
        var width = "1000";
        var height = "690";
        var left = (window.screen.width / 2) - (width / 2);
        var top = (window.screen.height / 2) - (height / 2);
        var url = "/comm/agreement.do";
        var option = "width=" + width + ", height=" + height + ", left=" + left + ", top=" + top + ", resizable=no, scrollbars=no, menubar=no, location=no, status=no";
        var openWin = window.open(url, "이용약관", option);
    }

    // 메인화면 이동.
    function fn_main() {
        window.history.back();
    }
</script>
</html>