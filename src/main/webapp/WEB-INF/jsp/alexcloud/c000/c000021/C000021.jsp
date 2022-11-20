<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : C000002
	화면명    : 반품 관리
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
        </ul>
        <ul class="sech_ul">
            <li class="sech_li">
                <div>상태</div>
                <div>
                    <select id="S_ISUSING" class="cmc_combo">
                        <option value="">--전체--</option>
                        <c:forEach var="i" items="${CODE_ISUSING}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </li>
            <li class="sech_li_2">
                <div>접수기준일</div>
                <div>
                    <select id="S_ISUSING" class="cmc_combo">
                        <option value="">--전체--</option>
                        <c:forEach var="i" items="${CODE_ISUSING}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                    <input type="text" id="rcv_FROM" class="cmc_date periods" />
                    ~
                    <input type="text" id="rcv_TO" class="cmc_date periode" />
                </div>
            </li>
            <!--  			<li class="sech_li">
					<input type="text" id="rcv_FROM" class="cmc_date periods" /> ~
					<input type="text" id="rcv_TO" class="cmc_date periode" />
			</li>
-->
        </ul>
        <div id="sech_extbtn" class="down"></div>
        <div id="sech_extline"></div>
        <div id="sech_extwrap">
            <!-- 회사별 반품관리 조회조건 -->
            <!-- 숨긴 조회조건 -->
            <c:import url="/comm/compItemSearch.do" />
            <ul class="sech_ul">
                <li class="sech_li">
                    <div>반품송장번호</div>
                    <div>
                        <input type="text" id="invc_sno" class="cmc_txt" readonly="readonly" />
                    </div>
                </li>
                <li class="sech_li">
                    <div>보낸사람</div>
                    <div>
                        <input type="text" id="rcv_nm" class="cmc_txt" readonly="readonly" />
                    </div>
                </li>
                <li class="sech_li">
                    <div>원주문ID</div>
                    <div>
                        <input type="text" id="user_id" class="cmc_txt" readonly="readonly" />
                    </div>
                </li>
            </ul>
        </div>
    </form>
</div>
<!-- 검색조건 영역 끝 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
            품목
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right">
            <input type="button" id="btn_ipgoResnd" class="cmb_normal" value="반품 입고" onclick="pfn_upload('P000006');" />
            <input type="button" id="btn_mapping" class="cmb_normal" value="반품 매핑" onclick="pfn_upload('P000006');" />
            <input type="button" id="btn_upload" class="cmb_normal" value="업로드" onclick="pfn_upload('P000006');" />
            <!-- <button type="button" id="btn_grid1Add" class="cmb_plus" onclick="fn_grid1AddRow()"></button>
				 <button type="button" id="btn_grid1Del" class="cmb_minus" onclick="fn_grid1DelRow()"></button> -->
        </div>
    </div>
    <div id="grid1"></div>
</div>
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
        initLayout();

        setCommBtn('del', null, '미사용');

        $('#S_COMPCD').val("<c:out value='${sessionScope.loginVO.compcd}' />");
        $('#S_COMPNM').val(cfn_loginInfo().COMPNM);
        $('#S_ORGCD').val(cfn_loginInfo().ORGCD);
        $('#S_ORGNM').val(cfn_loginInfo().ORGNM);
        $('#S_ISUSING').val('Y');

        grid1_Load();

        //셀러
        pfn_codeval({
            url : '/alexcloud/popup/popP002/view.do',
            codeid : 'S_ORGCD',
            inparam : {
                S_COMPCD : 'S_COMPCD',
                S_ORGCD : 'S_ORGCD'
            },
            outparam : {
                ORGCD : 'S_ORGCD',
                NAME : 'S_ORGNM'
            }
        });

        //품목분류
        pfn_codeval({
            url : '/alexcloud/popup/popP017/view.do',
            codeid : 'S_ITEMCATCD',
            inparam : {
                S_COMPCD : 'S_COMPCD',
                S_ITEMCAT : 'S_ITEMCATCD,S_ITEMCATNM'
            },
            outparam : {
                ITEMCATCD : 'S_ITEMCATCD',
                NAME : 'S_ITEMCATNM'
            }
        });

        if ($('#S_ORGCD').val().length > 0) {
            $('#S_ORGCD').attr('disabled', true).addClass('disabled').attr('readonly', 'readonly');
            $('#S_ORGNM').attr('disabled', true).addClass('disabled').attr('readonly', 'readonly');
            $('#btn_S_ORGCD').attr('disabled', 'disabled').addClass('disabled');
        }
    });

    function grid1_Load() {
        var gid = 'grid1', $grid = $('#' + gid);
        var columns = [
                {
                    name : 'RESENDNO',
                    header : {
                        text : '반품번호'
                    },
                    width : 100
                }, {
                    name : 'ORGNM',
                    header : {
                        text : '업체명'
                    },
                    width : 100
                }, {
                    name : 'ITEMCD',
                    header : {
                        text : '상태'
                    },
                    width : 100,
                    editable : true,
                    required : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'NAME',
                    header : {
                        text : '접수일'
                    },
                    width : 50,
                    editable : true,
                    required : true,
                    editor : {
                        maxLength : 20
                    }
                }, {
                    name : 'SNAME',
                    header : {
                        text : '완료일'
                    },
                    width : 50,
                    editable : true,
                    editor : {
                        maxLength : 100
                    }
                }, {
                    name : 'FNAME',
                    header : {
                        text : '취소일'
                    },
                    width : 50,
                    editable : true,
                    editor : {
                        maxLength : 100
                    }
                }, {
                    name : 'ITEMTYPE',
                    header : {
                        text : '원송장'
                    },
                    width : 100,
                    formatter : 'combo',
                    comboValue : '${GCODE_ITEMTYPE}',
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true,
                    editor : {
                        maxLength : 10
                    }
                }, {
                    name : 'UNITCD',
                    header : {
                        text : '반품송장'
                    },
                    width : 100,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true,
                    editor : {
                        maxLength : 10
                    }
                }, {
                    name : 'ITEMSIZE',
                    header : {
                        text : '교환송장'
                    },
                    width : 100,
                    editable : true,
                    editor : {
                        maxLength : 20
                    },
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'UNITCOST',
                    header : {
                        text : '택배사'
                    },
                    width : 100,
                    required : true,
                    dataType : 'number',
                    styles : {
                        textAlignment : 'far',
                        numberFormat : '#,##0'
                    },
                    editable : true,
                    editor : {
                        maxLength : 13,
                        type : 'number',
                        positiveOnly : true,
                        integerOnly : true,
                        editFormat : '#,##0'
                    }
                }, {
                    name : 'UNITPRICE',
                    header : {
                        text : '배송구분'
                    },
                    width : 100,
                    required : true,
                    dataType : 'number',
                    styles : {
                        textAlignment : 'far',
                        numberFormat : '#,##0'
                    },
                    editable : true,
                    editor : {
                        maxLength : 13,
                        type : 'number',
                        positiveOnly : true,
                        integerOnly : true,
                        editFormat : '#,##0'
                    }
                }, {
                    name : 'ITEMCAT1NM',
                    header : {
                        text : '배송비'
                    },
                    width : 50
                }, {
                    name : 'ITEMCAT2NM',
                    header : {
                        text : '반품비'
                    },
                    width : 50
                }, {
                    name : 'ITEMCAT3NM',
                    header : {
                        text : '보낸사람'
                    },
                    width : 100
                }, {
                    name : 'ITEMCAT4NM',
                    header : {
                        text : '전화1'
                    },
                    width : 100
                }, {
                    name : 'ITEMCAT5NM',
                    header : {
                        text : '전화2'
                    },
                    width : 100
                }, {
                    name : 'ITEMCAT6NM',
                    header : {
                        text : '우편번호'
                    },
                    width : 100
                }, {
                    name : 'ITEMCAT7NM',
                    header : {
                        text : '지정일'
                    },
                    width : 50
                }, {
                    name : 'ITEMCAT8NM',
                    header : {
                        text : '주소'
                    },
                    width : 150
                }, {
                    name : 'ITEMCAT9NM',
                    header : {
                        text : '고객반송베시지'
                    },
                    width : 150
                }, {
                    name : 'ITEMCAT10NM',
                    header : {
                        text : '회수시요구사항'
                    },
                    width : 150
                }, {
                    name : 'ITEMCAT11NM',
                    header : {
                        text : '담당자'
                    },
                    width : 50
                }, {
                    name : 'ITEMCAT12NM',
                    header : {
                        text : '처리구분'
                    },
                    width : 100
                }, {
                    name : 'ITEMCAT13NM',
                    header : {
                        text : '반송구분'
                    },
                    width : 100
                }, {
                    name : 'ITEMCAT14NM',
                    header : {
                        text : '반송품목'
                    },
                    width : 100
                }, {
                    name : 'ITEMCAT15NM',
                    header : {
                        text : '주문ID'
                    },
                    width : 100
                }, {
                    name : 'ITEMCAT16NM',
                    header : {
                        text : '수량'
                    },
                    width : 50
                }, {
                    name : 'ITEMCAT17NM',
                    header : {
                        text : '양품'
                    },
                    width : 100
                }, {
                    name : 'ITEMCAT18NM',
                    header : {
                        text : '불량'
                    },
                    width : 100
                }, {
                    name : 'ITEMCAT19NM',
                    header : {
                        text : '양품입고창고'
                    },
                    width : 100
                }, {
                    name : 'ITEMCAT20NM',
                    header : {
                        text : '불량입고창고'
                    },
                    width : 100
                }

        ];
        $grid.gfn_createGrid(columns, {
            editable : true,
            footerflg : false
        });

        //그리드설정 및 이벤트처리
        $grid.gfn_setGridEvent(function(gridView, dataProvider) {
            //열고정 설정
            gridView.setFixedOptions({
                colCount : 3,
                resizable : true,
                colBarWidth : 1
            });

            //셀 로우 변경 이벤트
            gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
                if (newRowIdx > -1) {
                    var state = dataProvider.getRowState(newRowIdx);
                    var rowData = $grid.gfn_getDataRow(newRowIdx);

                    if (rowData.ISUSING === 'N') {
                        setCommBtn('del', null, '사용', {
                            iconname : 'btn_on.png'
                        });
                    } else {
                        setCommBtn('del', null, '미사용', {
                            iconname : 'btn_del.png'
                        });
                    }

                    var editable = state === 'created';
                    $grid.gfn_setColDisabled([
                            'ORGCD', 'ITEMCD', 'UNITCOST', 'UNITPRICE', 'UNITCOST', 'UNITPRICE'
                    ], editable);

                    if (rowData.UNITTYPE === 'EA') {
                        $grid.gfn_setColDisabled([
                            'INBOXQTY'
                        ], false);
                    } else {
                        $grid.gfn_setColDisabled([
                            'INBOXQTY'
                        ], true);
                    }

                    if (!cfn_isEmpty(cfn_loginInfo().ORGCD)) {
                        $('#' + gid).gfn_setColDisabled([
                            'ORGCD'
                        ], false);
                    }
                }
            };

            //셀 수정 완료 이벤트
            gridView.onCellEdited = function(grid, itemIdx, dataRow, fieldIdx) {
                if (dataProvider.getFieldName(fieldIdx) === 'UNITTYPE') {
                    if ($('#' + gid).gfn_getValue(dataRow, 'UNITTYPE') == 'EA') {
                        $('#' + gid).gfn_setValue(dataRow, 'INBOXQTY', 1);
                        $grid.gfn_setColDisabled([
                            'INBOXQTY'
                        ], false);
                    } else {
                        $grid.gfn_setColDisabled([
                            'INBOXQTY'
                        ], true);
                    }
                }
            }
        });
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == 'sid_getSearch') {
            $('#grid1').gfn_setDataList(data.resultList);
            $('#grid1').gfn_focusPK();
        }
        //저장
        else if (sid === 'sid_setSave') {
            $('#grid1').gfn_setFocusPK(data.resultData, [
                    'COMPCD', 'ORGCD', 'ITEMCD'
            ]);
            cfn_msg('INFO', '정상적으로 저장되었습니다.');
            cfn_retrieve();
        }
        //삭제 (사용/미사용)
        else if (sid === 'sid_setDelete') {
            $('#grid1').gfn_setFocusPK(data.resultData, [
                    'COMPCD', 'ORGCD', 'ITEMCD'
            ]);
            cfn_msg('INFO', '정상적으로 처리되었습니다.');
            cfn_retrieve();
        }
    }

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        $('#grid1').gridView().cancel();

        gv_searchData = cfn_getFormData('frmSearch');

        var sid = 'sid_getSearch';
        var url = '/alexcloud/c000/c000002/getSearch.do';
        var sendData = {
            'paramData' : gv_searchData
        };

        gfn_sendData(sid, url, sendData);
    }

    //공통버튼 - 신규 클릭
    function cfn_new() {
        $('#grid1').gridView().commit(true);

        $('#grid1').gfn_addRow({
            COMPCD : "<c:out value='${sessionScope.loginVO.compcd}' />",
            ORGCD : cfn_loginInfo().ORGCD,
            ORGNM : cfn_loginInfo().ORGNM,
            ITEMTYPE : '10',
            UNITCD : 'EA',
            SETYN : 'N',
            UNITTYPE : 'EA',
            INBOXQTY : 1,
            INPLTQTY : 1,
            ISUSING : 'Y',
            UNITCOST : 0,
            UNITPRICE : 0
        });
    }

    //공통버튼 - 저장 클릭
    function cfn_save() {
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
            var url = '/alexcloud/c000/c000002/setSave.do';
            var sendData = {
                'paramList' : masterList
            };

            gfn_sendData(sid, url, sendData);
        }
    }

    //공통버튼 - 삭제 (사용/미사용) 클릭
    function cfn_del() {
        $('#grid1').gridView().commit(true);

        var $grid1 = $('#grid1');
        var rowidx = $grid1.gfn_getCurRowIdx();

        if (rowidx < 0) {
            cfn_msg('WARNING', '선택된 품목이 없습니다.');
            return false;
        }

        var state = $grid1.dataProvider().getRowState(rowidx);

        if (state === 'created') {
            $grid1.gfn_delRow(rowidx);
            return false;
        }

        var rowData = $grid1.gfn_getDataRow(rowidx);
        var delstr = rowData.ISUSING === 'N' ? '사용' : '미사용';

        if (confirm('품목코드 [' + rowData.ITEMCD + '] 항목을 ' + delstr + ' 처리하시겠습니까?')) {
            var sid = 'sid_setDelete';
            var url = '/alexcloud/c000/c000002/setDelete.do';
            var sendData = {
                'paramData' : rowData
            };

            gfn_sendData(sid, url, sendData);
        }
    }

    //그리드1 행추가 버튼 클릭
    function fn_grid1AddRow() {
        cfn_new();
    }

    //그리드1 행삭제 버튼 클릭
    function fn_grid1DelRow() {
        cfn_del();
    }
</script>
<c:import url="/comm/contentBottom.do" />