<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/comm/contentTop.do" />
<!-- 검색 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <ul class="sech_ul">
            <li class="sech_li">
                <div>기간</div>
                <div>
                    <input type="text" id="DATE_TO" class="cmc_date periods" readonly="readonly" />
                    ~
                    <input type="text" id="DATE_FROM" class="cmc_date periode" readonly="readonly" />
                </div>
            </li>
            <li class="sech_li">
                <div>국가</div>
                <div>
                    <select id="nation" onchange="changeSelect()">
                        <c:forEach var="i" items="${country}">
                            <option value="${i.code}">${i.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </li>
        </ul>
        <ul class="sech_ul">
            <li id="stateSelect" class="sech_li">
                <div>주(STATE)</div>
                <div>
                    <select id="usState" class="cmc_combo">
                        <option value="US_STATE_EAST">동부</option>
                        <option value="US_STATE_WEST">서부</option>
                    </select>
                </div>
            </li>
        </ul>
        <br>
        <ul style="padding-left: 10px;">
            <li>
                <div>
                    <P>
                        <font color="#FF000">※ 기준정보 > 셀러에서 대표자 영문이름과 영문주소를 입력하지않으면 대표자이름과 주소가 표시되지 않습니다.</font>
                    </P>
                </div>
            </li>
        </ul>
    </form>
</div>
<!-- 검색 끝 -->
<!-- 그리드 시작 -->
<div class="ct_top_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">
            마스터정보 리스트
            <span>(총 0건)</span>
        </div>
        <div class="grid_top_right"></div>
    </div>
    <div id="grid1"></div>
</div>
<!-- 그리드 끝 -->
<script type="text/javascript">
    //초기 로드
    $(function() {
        initLayout();
        //그리드 초기화
        grid1_Load();
        // 날짜셋팅
        $('#DATE_TO').val(cfn_getDateFormat(new Date, 'yyyy-MM-dd'));
        $('#DATE_FROM').val(cfn_getDateFormat(new Date, 'yyyy-MM-dd'));
        $("#nation").val("US");
    });

    function grid1_Load() {
        var gid = 'grid1';
        var columns = [
                {
                    name : 'XRT_INVC_SNO',
                    header : {
                        text : 'Tracking no'
                    },
                    width : 150,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'XRT_INVC_SNO',
                    header : {
                        text : 'Shipping no'
                    },
                    width : 150,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'ORD_CNT',
                    header : {
                        text : 'Qty'
                    },
                    width : 50,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'INVC_SNO',
                    header : {
                        text : 'Tracking No'
                    },
                    width : 150,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'WGT',
                    header : {
                        text : 'Weight(Kg)'
                    },
                    width : 80,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'GOODS',
                    header : {
                        text : 'Contents'
                    },
                    width : 250,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'SELLER_CEO',
                    header : {
                        text : 'Seller.CEO'
                    },
                    width : 100,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'SELLER_NAME',
                    header : {
                        text : 'Seller.Name'
                    },
                    width : 100,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'SELLER_ADDR',
                    header : {
                        text : 'Seller.Address'
                    },
                    width : 300,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'SELLER_TEL',
                    header : {
                        text : 'Seller.Tel'
                    },
                    width : 130,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'RECV_NAME',
                    header : {
                        text : 'Recipient.Name'
                    },
                    width : 130,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'RECV_ADDR1',
                    header : {
                        text : 'Recipient.Address'
                    },
                    width : 300,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'RECV_ADDR2',
                    header : {
                        text : 'Address Detail'
                    },
                    width : 200,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'RECV_CITY',
                    header : {
                        text : 'Recipient City'
                    },
                    width : 190,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'RECV_STATE',
                    header : {
                        text : 'STATE'
                    },
                    width : 80,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'RECV_TEL',
                    header : {
                        text : 'Recipient.Tel'
                    },
                    width : 150,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'RECV_POST',
                    header : {
                        text : 'ZIP CODE'
                    },
                    width : 120,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }, {
                    name : 'ZONE',
                    header : {
                        text : 'Zone'
                    },
                    width : 120,
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true
                }
        ];

        //그리드 생성 (realgrid 써서)
        $('#' + gid).gfn_createGrid(columns, {
            footerflg : false,
            cmenuGroupflg : false,
            cmenuColChangeflg : false,
            cmenuColSaveflg : false,
            cmenuColInitflg : false,
            cmenuExcelflg : false,
            cmenuCsvflg : false
        });

        //그리드설정 및 이벤트처리
        $('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            var options = gridView.getDisplayOptions();

            options.columnResizable = !options.columnResizable;
            //gridView.setDisplayOptions(options);

            //열고정 설정
            gridView.setFixedOptions({
                colCount : 2,
                resizable : true,
                colBarWidth : 1
            });
            gridView.setContextMenu([
                {
                    label : "Excel Export"
                }
            ]);
            gridView.onContextMenuItemClicked = function(grid, label, index) {
                fn_excel_export();
            };
        });
    }

    //요청한 데이터 처리 callback
    function gfn_callback(sid, data) {
        //검색
        if (sid == 'sid_getSearch') {
            $('#grid1').gfn_setDataList(data.resultList);
            $('#grid1').gfn_focusPK();
        }
    }

    //공통버튼 - 검색 클릭
    function cfn_retrieve() {
        $('#grid1').gridView().cancel();
        param = cfn_getFormData('frmSearch');

        var sid = 'sid_getSearch';
        var url = '/fulfillment/settlement/masterReport/getSearch.do';
        var sendData = {
            'paramData' : param
        };

        gfn_sendData(sid, url, sendData, true);
    }

    function changeSelect() {
        if ($('#nation').val() != 'US') {
            $('#stateSelect').hide();
            $('#usState').val('');
        }

        if ($('#nation').val() == 'US') {
            $('#stateSelect').show();
            $('#usState').val('US_STATE_EAST');
        }
    }

    //excel파일 다운로드
    function fn_excel_export() {

        var $g = 'grid1';

        RealGridJS.exportGrid({
            type : 'excel',
            target : 'local',
            fileName : 'MasterReport' + '.xlsx',
            showProgress : 'Y',
            documentTitle : { //제목
                message : "MANIFEST",
                visible : true,
                styles : {
                    fontSize : 40,
                    fontBold : true,
                    textAlignment : "center",
                    lineAlignment : "center",
                    background : "#FFFFFF"
                },
                spaceTop : 1,
                spaceBottom : 0,
                height : 60
            },
            applyDynamicStyles : true,
            progressMessage : '엑셀 Export중입니다.',
            header : 'default',
            footer : 'default',
            compatibility : '2010',
            lookupDisplay : true,
            exportGrids : [
                {
                    grid : $('#' + $g).gridView(),
                    sheetName : "MANIFEST"
                }
            ],
            done : function() {
            }
        });
    }
</script>
<c:import url="/comm/contentBottom.do" />