<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000002
	화면명   : 셀러(셀러)
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <ul class="sech_ul">
            <li class="sech_li">
                <div>회사</div>
                <div>
                    <input type="text" id="S_COMPCD" class="cmc_code" readonly="readonly" disabled />
                    <input type="text" id="S_COMPNM" class="cmc_value" readonly="readonly" disabled />
                    <button type="button" class="cmc_cdsearch disabled" disabled></button>
                </div>
            </li>
            <li class="sech_li">
                <div>셀러코드/명</div>
                <div>
                    <input type="text" id="S_ITEM" class="cmc_txt" />
                </div>
            </li>
            <li class="sech_li">
                <div>사용여부</div>
                <div>
                    <select id="S_ISUSING" class="cmc_combo">
                        <option value="">전체</option>
                        <c:forEach var="i" items="${codeISUSING}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </li>
        </ul>
    </form>
</div>
<!-- 검색조건 영역 끝 -->
<!-- 그리드 시작 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
            셀러
            <span>(총 0건)</span>
        </div>
        <c:if
            test="${sessionScope.loginVO.usergroup == constMap.CENTER_ADMIN || sessionScope.loginVO.usergroup == constMap.CENTER_SUPER || sessionScope.loginVO.usergroup == constMap.CENTER_USER || sessionScope.loginVO.usergroup == constMap.XROUTE_ADMIN}"
        >
            <div class="grid_top_right">
                <button type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid1RowAdd()"></button>
                <button type="button" id="btn_rowDel" class="cmb_minus" onclick="fn_grid1RowDel()"></button>
            </div>
        </c:if>
    </div>
    <div id="grid1"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    
<%--
  * ========= 공통버튼 클릭함수 =========
  * 검색 : cfn_retrieve()
  * 목록 : cfn_list()
  * 신규 : cfn_new()
  * 삭제 : cfn_del()
  * 저장 : cfn_save()
  * 복사 : cfn_copy()
  * 초기화 : cfn_init()
  * 실행 : cfn_execute()
  * 취소 : cfn_cancel()
  * 엑셀업로드 : cfn_excelup()
  * 엑셀다운 : cfn_exceldown()
  * 출력 : cfn_print()
  * 사용자버튼 : cfn_userbtn1() ~ cfn_userbtn5()
  * -------------------------------
  * 버튼 순서 : setCommBtnSeq(['ret','list']) : ret,list,new,del,save,copy,init,execute,cancel,print,excelup,exceldown,user1,2,3,4,5
  * 버튼 표시/숨김 : setCommBtn('ret', true) : ret,list,new,del,save,copy,init,execute,cancel,print,excelup,exceldown,user1,2,3,4,5
  * ===============================
--%>
    //초기 로드
    $(function() {
        //화면레이아웃 지정 
        initLayout();

        //화면 공통버튼 설정
        setCommBtn('del', null, '미사용');

        //로그인정보로 초기화
        $('#S_COMPCD').val(cfn_loginInfo().COMPCD);
        $('#S_COMPNM').val(cfn_loginInfo().COMPNM);

        //초기화
        $('#S_ISUSING').val('Y');

        //그리드 초기화
        grid1_Load();

        //권한별 표시
        authority_Load();
    });

    function authority_Load() {
        if (cfn_loginInfo().USERGROUP == '${SELLER_ADMIN}') {
            $('#S_ITEM').val(cfn_loginInfo().ORGCD);
            $('#S_ITEM').prop("disabled", true);
        }
    }

    function grid1_Load() {
        var gid = 'grid1';
        var vEditable = false;

        if ("<c:out value='${sessionScope.loginVO.usergroup}' />" > "40") {
            vEditable = true;
        }

        var columns = [
                {
                    name : 'ISUSING',
                    header : {
                        text : '사용여부'
                    },
                    width : 100,
                    formatter : 'combo',
                    comboValue : '${gCodeISUSING}',
                    renderer : {
                        type : 'shape'
                    },
                    styles : {
                        textAlignment : 'center',
                        figureName : 'ellipse',
                        iconLocation : 'left'
                    },
                    dynamicStyles : [
                            {
                                criteria : 'value = "Y"',
                                styles : {
                                    figureBackground : cfn_getStsColor(3)
                                }
                            }, {
                                criteria : 'value = "N"',
                                styles : {
                                    figureBackground : cfn_getStsColor(0)
                                }
                            }
                    ]
                }, {
                    name : 'ORGCD',
                    header : {
                        text : '셀러코드'
                    },
                    width : 80,
                    editable : true,
                    required : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'NAME',
                    header : {
                        text : '셀러명'
                    },
                    width : 120,
                    editable : true,
                    required : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'SNAME',
                    header : {
                        text : '셀러명(약칭)'
                    },
                    width : 120,
                    editable : true,
                    editor : {
                        maxLength : 100
                    }
                }, {
                    name : 'COMPANY_EN',
                    header : {
                        text : '셀러명(영문)'
                    },
                    width : 120,
                    editable : true,
                    editor : {
                        maxLength : 100
                    }
                }, {
                    name : 'MEM_USERCD',
                    header : {
                        text : '멤버아이디'
                    },
                    width : 200,
                    editable : false
                }, {
                    name : 'PAYMENT_TYPE',
                    header : {
                        text : '결제타입구분'
                    },
                    width : 100,
                    formatter : 'combo',
                    comboValue : '${gCodePAYMENTTYPE}',
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : vEditable
                }, {
                    name : 'PROMOTION_CODE',
                    header : {
                        text : '프로모션 코드'
                    },
                    width : 110,
                    editable : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'PROMOTION_PRERIOD',
                    header : {
                        text : '프로모션 유효 기간'
                    },
                    width : 110,
                    editable : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'PREMIUM',
                    header : {
                        text : '프리미엄 할인율'
                    },
                    width : 110,
                    editable : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'DHL',
                    header : {
                        text : '익스프레스 할인율'
                    },
                    width : 110,
                    editable : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'TEL1',
                    header : {
                        text : '전화번호1'
                    },
                    width : 110,
                    editable : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'TEL2',
                    header : {
                        text : '전화번호2'
                    },
                    width : 110,
                    editable : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'FAX1',
                    header : {
                        text : '팩스번호1'
                    },
                    width : 100,
                    editable : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'FAX2',
                    header : {
                        text : '팩스번호2'
                    },
                    width : 100,
                    editable : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'POST',
                    header : {
                        text : '우편번호'
                    },
                    width : 80,
                    editable : true,
                    editor : {
                        maxLength : 15
                    },
                    formatter : 'popup',
                    popupOption : {
                        url : '/sys/popup/popPost/view.do',
                        outparam : {
                            POST : 'POST',
                            ADDR : 'ADDR'
                        }
                    }
                }, {
                    name : 'ADDR',
                    header : {
                        text : '주소'
                    },
                    width : 800,
                    editable : true,
                    editor : {
                        maxLength : 200
                    }
                }, {
                    name : 'ADDR2',
                    header : {
                        text : '주소상세'
                    },
                    width : 200,
                    editable : true,
                    editor : {
                        maxLength : 200
                    }
                }, {
                    name : 'CEO',
                    header : {
                        text : '대표자'
                    },
                    width : 80,
                    editable : true,
                    editor : {
                        maxLength : 50
                    },
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'ENG_ADDR',
                    header : {
                        text : '영문 주소'
                    },
                    width : 360,
                    editable : true,
                    editor : {
                        maxLength : 350
                    }
                }, {
                    name : 'ENG_CEO',
                    header : {
                        text : '영문 대표자명'
                    },
                    width : 150,
                    editable : true,
                    editor : {
                        maxLength : 50
                    },
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'BIZDATE',
                    header : {
                        text : '창립일'
                    },
                    width : 130,
                    editable : true,
                    formatter : 'date',
                    styles : {
                        textAlignment : 'center'
                    },
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'BIZNO1',
                    header : {
                        text : '사업자번호1'
                    },
                    width : 110,
                    editable : true,
                    editor : {
                        maxLength : 50
                    }
                }, {
                    name : 'BIZNO2',
                    header : {
                        text : '사업자번호2'
                    },
                    width : 110,
                    editable : true,
                    editor : {
                        maxLength : 50
                    }
                }, {
                    name : 'BIZUP',
                    header : {
                        text : '사업자등록증 수정'
                    },
                    width : 100,
                    buttonVisibility : 'always',
                    renderer : {
                        type : 'imageButtons',
                        editable : false,
                        images : [
                            {
                                name : 'upload',
                                up : '/images/btn_upload.png',
                                hover : '/images/btn_upload.png',
                                down : '/images/btn_upload.png'
                            }
                        ],
                        alignment : 'center'
                    },
                    cursor : 'pointer'
                }, {
                    name : 'BIZDOWN',
                    header : {
                        text : '사업자등록증 다운'
                    },
                    width : 100,
                    buttonVisibility : 'always',
                    renderer : {
                        type : 'imageButtons',
                        editable : false,
                        images : [
                            {
                                name : 'download',
                                up : '/images/btn_download.png',
                                hover : '/images/btn_download.png',
                                down : '/images/btn_download.png'
                            }
                        ],
                        alignment : 'center'
                    },
                    cursor : 'pointer'
                }, {
                    name : 'BIZKIND',
                    header : {
                        text : '업태'
                    },
                    width : 80,
                    editable : true,
                    editor : {
                        maxLength : 50
                    }
                }, {
                    name : 'BIZTYPE',
                    header : {
                        text : '업종'
                    },
                    width : 80,
                    editable : true,
                    editor : {
                        maxLength : 50
                    }
                }, {
                    name : 'EMAIL',
                    header : {
                        text : '대표이메일'
                    },
                    width : 180,
                    editable : true,
                    editor : {
                        maxLength : 50
                    }
                }, {
                    name : 'WEBADDR',
                    header : {
                        text : '홈페이지'
                    },
                    width : 180,
                    editable : true,
                    editor : {
                        maxLength : 50
                    }
                }, {
                    name : 'NATION',
                    header : {
                        text : '국가'
                    },
                    width : 120,
                    formatter : 'combo',
                    comboValue : '${GCODE_COUNTRYCD}',
                    editable : true,
                    styles : {
                        textAlignment : 'center'
                    },
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'REMARKS',
                    header : {
                        text : '비고'
                    },
                    width : 200,
                    editable : true,
                    editor : {
                        maxLength : 255
                    }
                }, {
                    name : 'COMPCD',
                    header : {
                        text : '회사코드'
                    },
                    width : 80,
                    styles : {
                        textAlignment : 'center'
                    },
                    visible : false,
                    show : false
                }, {
                    name : 'COMPNM',
                    header : {
                        text : '회사명'
                    },
                    width : 120,
                    styles : {
                        textAlignment : 'center'
                    },
                    visible : false,
                    show : false
                }, {
                    name : 'ADDUSERCD',
                    header : {
                        text : '등록자'
                    },
                    width : 100,
                    styles : {
                        textAlignment : 'center'
                    },
                    visible : false,
                    show : false
                }, {
                    name : 'ADDDATETIME',
                    header : {
                        text : '등록일시'
                    },
                    width : 150,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'UPDUSERCD',
                    header : {
                        text : '수정자'
                    },
                    width : 100,
                    styles : {
                        textAlignment : 'center'
                    },
                    visible : false,
                    show : false
                }, {
                    name : 'UPDDATETIME',
                    header : {
                        text : '수정일시'
                    },
                    width : 150,
                    styles : {
                        textAlignment : 'center'
                    },
                    visible : false,
                    show : false
                }, {
                    name : 'TERMINALCD',
                    header : {
                        text : 'IP'
                    },
                    width : 100,
                    styles : {
                        textAlignment : 'center'
                    },
                    visible : false,
                    show : false
                }, {
                    name : 'FILENAME',
                    header : {
                        text : '업로드파일명'
                    },
                    styles : {
                        textAlignment : 'center'
                    },
                    visible : false,
                    show : false
                }, {
                    name : 'ORIGINFILENM',
                    header : {
                        text : '실제저장파일명'
                    },
                    styles : {
                        textAlignment : 'center'
                    },
                    visible : false,
                    show : false
                }
        ];

        //그리드 생성
        $('#' + gid).gfn_createGrid(columns, {
            footerflg : false
        });

        //disable할꺼
        $('#' + gid).gfn_setGridEvent(
                function(gridView, dataProvider) {
                    //열고정 설정
                    gridView.setFixedOptions({
                        colCount : 2,
                        resizabld : true,
                        colBarWidth : 1
                    });
                    //셀 로우 변경 이벤트
                    gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
                        if (newRowIdx > -1) {
                            var editable = grid.getValue(newRowIdx, 'ISUSING') === 'Y';
                            $('#' + gid).gfn_setColDisabled(
                                    [
                                            'NAME', 'SNAME', 'COMPANY_EN','TEL1', 'TEL2', 'FAX1', 'FAX2', 'POST', 'ADDR', 'ADDR2', 'CEO', 'BIZDATE', 'BIZNO1', 'BIZNO2', 'BIZKIND', 'BIZTYPE', 'EMAIL', 'WEBADDR',
                                            'NATION', 'REMARKS'
                                    ], editable);
                            if (editable) {
                                setCommBtn('del', null, '미사용', {
                                    'iconname' : 'btn_del.png'
                                });
                            } else {
                                setCommBtn('del', null, '사용', {
                                    'iconname' : 'btn_on.png'
                                });
                            }

                            var state = $('#' + gid).dataProvider().getRowState(newRowIdx) === 'created';
                            $('#' + gid).gfn_setColDisabled([
                                'ORGCD'
                            ], state);
                        }
                    };

                    //셀 클릭 이벤트
                    gridView.onDataCellClicked = function(gridView, column) {

                        var rowidx = $('#' + gid).gfn_getCurRowIdx();
                        //사업자등록증다운 버튼 클릭
                        if (column.column == 'BIZDOWN') {
                            var compcd = $('#' + gid).gfn_getValue(rowidx, 'COMPCD');
                            var orgcd = $('#' + gid).gfn_getValue(rowidx, 'ORGCD');
                            var filename = $('#' + gid).gfn_getValue(rowidx, 'FILENAME');
                            var originfilenm = $('#' + gid).gfn_getValue(rowidx, 'ORIGINFILENM');
                            window.open(encodeURI('/alexcloud/popup/popS014/noticeDownloadFile.do?realFilename=' + originfilenm + '&filename=' + filename))
                        }

                        //사업자등록증 수정 버튼 클릭
                        if (column.column == 'BIZUP') {
                            var compcd = $('#' + gid).gfn_getValue(rowidx, 'COMPCD');
                            var orgcd = $('#' + gid).gfn_getValue(rowidx, 'ORGCD');
                            var filename = $('#' + gid).gfn_getValue(rowidx, 'FILENAME');
                            var originfilenm = $('#' + gid).gfn_getValue(rowidx, 'ORIGINFILENM');

                            // 정보 변경 팝업 오픈
                            pfn_popupOpen({
                                url : '/alexcloud/popup/popP000002/view.do',
                                pid : 'popP000002',
                                params : {
                                    'COMPCD' : compcd,
                                    'ORGCD' : orgcd,
                                    'FILENAME' : filename,
                                    'ORIGINFILENM' : originfilenm
                                },
                                returnFn : function(data, type) {
                                    if (type === 'OK') {
                                        cfn_msg('INFO', '정상적으로 저장되었습니다.');
                                        cfn_retrieve();
                                    }
                                }
                            });
                        }
                    }
                });
    }

    /* 요청한 데이터 처리 callback */
    function gfn_callback(sid, data) {
        //검색
        if (sid == 'sid_getSearch') {
            $('#grid1').gfn_setDataList(data.resultList);
            $('#grid1').gfn_focusPK();
        }

        //저장
        if (sid == 'sid_setSave') {
            $('#grid1').gfn_setFocusPK(data.resultData, [
                    'COMPCD', 'ORGCD'
            ]);
            cfn_msg('INFO', '정상적으로 저장되었습니다.');
            cfn_retrieve();
        }

        //미사용/사용
        if (sid == 'sid_setDelete') {
            $('#grid1').gfn_setFocusPK(data.resultData, [
                    'COMPCD', 'ORGCD'
            ]);
            cfn_msg('INFO', '정상적으로 처리되었습니다.');
            cfn_retrieve();
        }
    }

    /* 공통버튼 - 검색 클릭 */
    function cfn_retrieve() {
        $('#grid1').gridView().cancel();

        gv_searchData = cfn_getFormData('frmSearch');

        //서버 호출
        var sid = 'sid_getSearch';
        var url = '/alexcloud/p000/p000002/getSearch.do';
        var sendData = {
            'paramData' : gv_searchData
        };

        gfn_sendData(sid, url, sendData);
    }

    /* 공통버튼 - 저장 클릭 */
    function cfn_save(directmsg) {
        $('#grid1').gridView().commit(true);

        var $grid1 = $('#grid1');
        var masterList = $grid1.gfn_getDataList(false);

        if (masterList.length < 1) {
            cfn_msg('WARNING', '변경된 항목이 없습니다.');
            return false;
        }

        //변경RowIndex 추출
        var states = $grid1.dataProvider().getAllStateRows();
        var stateRowidxs = states.updated;
        stateRowidxs = stateRowidxs.concat(states.created);

        //필수입력 체크
        if ($grid1.gfn_checkValidateCells(stateRowidxs))
            return false;

        if (confirm('저장하시겠습니까?')) {
            var sid = 'sid_setSave';
            var url = '/alexcloud/p000/p000002/setSave.do';
            var sendData = {
                'mGridList' : masterList
            };

            gfn_sendData(sid, url, sendData);
        }

    }

    /* 공통버튼 - 미사용 클릭 */
    function cfn_del() {
        $('#grid1').gridView().commit(true);

        var rowidx = $('#grid1').gfn_getCurRowIdx();

        if (rowidx < 0) {
            cfn_msg('WARNING', '선택된 셀러가 없습니다.');
            return false;
        }

        var state = $('#grid1').dataProvider().getRowState(rowidx);

        if (state === 'created') {
            $('#grid1').gfn_delRow(rowidx);
            return;
        }

        var masterData = $('#grid1').gfn_getDataRow(rowidx);
        var msgtxt;

        if (masterData.ISUSING == 'N') {
            msgtxt = '사용';
        } else {
            msgtxt = '미사용';
        }

        if (confirm('셀러코드[' + masterData.ORGCD + '] 항목을 ' + msgtxt + '처리 하시겠습니까?')) {
            var sid = 'sid_setDelete';
            var url = '/alexcloud/p000/p000002/setDelete.do';
            var sendData = {
                'paramData' : masterData
            };

            gfn_sendData(sid, url, sendData);
        }
    }
    //신규 행추가 ICON 버튼 클릭
    function fn_grid1RowAdd() {
        $('#grid1').gfn_addRow({
            'COMPCD' : cfn_loginInfo().COMPCD,
            'COMPNM' : cfn_loginInfo().COMPNM,
            'ISUSING' : 'Y',
            'PROD_MAP_YN' : 'Y'
        });
    }

    //신규 행삭제 ICON 버튼 클릭
    function fn_grid1RowDel() {
        var rowidx = $('#grid1').gfn_getCurRowIdx();

        if (rowidx < 0) {
            cfn_msg('WARNING', '선택된 행이 없습니다.');
            return false;
        }
        var state = $('#grid1').dataProvider().getRowState(rowidx);

        if (state !== 'created') {
            cfn_msg('WARNING', '기등록 데이터는 삭제할 수 없습니다.');
            return false;
        }

        $('#grid1').gfn_delRow(rowidx);

    }
</script>
<c:import url="/comm/contentBottom.do" />