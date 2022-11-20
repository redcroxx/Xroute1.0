<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="xrt.alexcloud.common.CommonConst"%>
<!-- 
	화면코드 : P000022
	화면명 : 주문서양식설정
-->
<c:import url="/comm/contentTop.do" />
<!-- 검색조건 영역 시작 -->
<div id="ct_sech_wrap">
    <form id="frmSearch" action="#" onsubmit="return false">
        <input type="hidden" id="S_COMPCD" class="cmc_code" />
        <ul class="sech_ul">
            <li class="sech_li required">
                <div>셀러</div>
                <div>
                    <input type="text" id="S_ORGCD" class="cmc_code required" />
                    <input type="text" id="S_ORGNM" class="cmc_value" />
                    <button type="button" class="cmc_cdsearch"></button>
                </div>
            </li>
            <li class="sech_li required">
                <div>양식명</div>
                <div>
                    <select id="S_SITE_CD" name="S_SITE_CD" class="cmc_combo"></select>
                    <!-- 	<input type="text" id="S_SITE_CD" class="cmc_code required" /> -->
                </div>
            </li>
        </ul>
    </form>
</div>
<!-- 검색조건 영역 끝 -->
<!-- 그리드 시작 -->
<div class="ct_left_wrap fix" style="width: 800px">
    <div style="height: 30%">
        <form id="frmDetail" action="#" onsubmit="return false">
            <table class="tblForm" style="min-width: 0px">
                <caption>기본정보</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                    <col />
                </colgroup>
                <tr>
                    <th class="required">주문서양식명</th>
                    <td>
                        <input type="text" id="SITE_NM" name="SITE_NM" class="cmc_txt required" maxlength="50" />
                        <input type="hidden" id="SITE_CD" name="SITE_NM" class="cmc_txt" maxlength="50" />
                    </td>
                    <th class="required">주문서약식명</th>
                    <td>
                        <input type="text" id="SITE_NM_SHORT" name="SITE_NM_SHORT" class="cmc_txt required" maxlength="3" />
                    </td>
                </tr>
                <tr>
                    <th class="required">송장자체출력</th>
                    <td>
                        <input type="radio" id="DELI_INVC_DIRECT_YN" name="DELI_INVC_DIRECT_YN" class="cmc_radio" value="Y" checked="checked" style="width: 13px" />
                        <label for="DELI_INVC_DIRECT_YN1">사용함</label>
                        <input type="radio" id="DELI_INVC_DIRECT_YN" name="DELI_INVC_DIRECT_YN" class="cmc_radio" value="N" checked="checked" style="width: 13px" />
                        <label for="DELI_INVC_DIRECT_YN2">사용하지않음</label>
                    </td>
                    <th class="required">활성화여부</th>
                    <td>
                        <input type="radio" id="ACTIVE_YN" name="ACTIVE_YN" class="cmc_radio" value="Y" checked="checked" style="width: 13px" />
                        <label for="ACTIVE_YN1">사용함</label>
                        <input type="radio" id="ACTIVE_YN" name="ACTIVE_YN" class="cmc_radio" value="N" checked="checked" style="width: 13px" />
                        <label for="ACTIVE_YN2">사용하지않음</label>
                    </td>
                </tr>
                <%-- <tr>
					<th class="required">합포장기준열</th>
					<td colspan="3">	
						<select id="PACK_1" name="PACK_1" class="cmc_combo" style="width:70px;">
							<option value="">선택</option>
							<c:forEach var="i" items="${codeLFCBOEXCELCOL}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>
						&nbsp;&nbsp;
						<select id="PACK_2" name="PACK_2" class="cmc_combo" style="width:70px;">
							<option value="">선택</option>
							<c:forEach var="i" items="${codeLFCBOEXCELCOL}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>
					</td>
				</tr> --%>
            </table>
            <table class="tblForm" style="min-width: 0px">
                <caption>발송정보</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                    <col />
                </colgroup>
                <tr>
                    <th class="required">발송코드(SUB)</th>
                    <td>
                        <input type="text" id="DELI_SUB_CODE" name="DELI_SUB_CODE" class="cmc_txt required num" maxlength="10" />
                    </td>
                    <th class="required">발송지명</th>
                    <td>
                        <input type="text" id="DELI_SND_NM" name="DELI_SND_NM" class="cmc_txt required" maxlength="30" />
                    </td>
                </tr>
                <tr>
                    <th class="required">발송지전화</th>
                    <td>
                        <input type="text" id="DELI_SND_TEL" name="DELI_SND_TEL" class="cmc_txt required" maxlength="30" />
                    </td>
                    <th class="required">발송지우편번호</th>
                    <td>
                        <input type="text" id="DELI_SND_ZIPCODE" name="DELI_SND_ZIPCODE" class="cmc_post required num" maxlength="10" />
                        <button type="button" class="cmc_cdsearch"></button>
                    </td>
                </tr>
                <tr>
                    <th class="required">발송지주소</th>
                    <td colspan="3">
                        <input type="text" id="DELI_SND_ADDR" name="DELI_SND_ADDR" class="cmc_address required" style="width: 600px;" maxlength="300" />
                    </td>
                </tr>
            </table>
            <%-- <table class="tblForm" style="min-width:0px">
				<caption>문자 병합</caption>
				<colgroup>
					<col width="20%" />
					<col width="80%" />
			        <col />
			    </colgroup>
				<tr>
					<th>병합1</th>
					<td>
						<input type="text" id="TGT_COL1" name="TGT_COL1" class="cmc_txt num" style="width:50px;" maxlength="30"/> 열 = 
						<input type="text" id="SRC_COLS11" name="TGT_COL11" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
						<input type="text" id="SEPS11" name="SEPS11" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 
						<input type="text" id="SRC_COLS12" name="SRC_COLS12" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
						<input type="text" id="SEPS12" name="SEPS12" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 	
						<input type="text" id="SRC_COLS13" name="SRC_COLS13" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열
					</td> 					
				</tr>                                                                          
				<tr>
					<th>병합2</th>
					<td>                                                                       
						<input type="text" id="TGT_COL2" name="TGT_COL2 num" class="cmc_txt" style="width:50px;" maxlength="30"/> 열 =                                            
						<input type="text" id="SRC_COLS21" name="TGT_COL21" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
						<input type="text" id="SEPS21" name="SEPS21" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 
						<input type="text" id="SRC_COLS22" name="SRC_COLS22" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
						<input type="text" id="SEPS22" name="SEPS22" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 	
						<input type="text" id="SRC_COLS23" name="SRC_COLS23" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 					
					</td>                                                                        
				</tr>                                                                            
				<tr>
					<th>병합3</th>                                            
					<td >                                                                         
						<input type="text" id="TGT_COL3" name="TGT_COL3" class="cmc_txt num" style="width:50px;" maxlength="30"/> 열 =
						<input type="text" id="SRC_COLS31" name="TGT_COL31" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
						<input type="text" id="SEPS31" name="SEPS31" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 
						<input type="text" id="SRC_COLS32" name="SRC_COLS32" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
						<input type="text" id="SEPS32" name="SEPS32" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 	
						<input type="text" id="SRC_COLS33" name="SRC_COLS33" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 				
					</td>
				</tr>
			</table> --%>
        </form>
    </div>
    <div style="height: 35%">
        <div class="grid_top_wrap">
            <div class="grid_top_left">
                문자 치환
                <span>(총 0건)</span>
            </div>
            <div class="grid_top_right">
                <input type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid1RowAdd()" />
                <input type="button" id="btn_rowDel" class="cmb_minus" onclick="fn_grid1RowDel()" />
            </div>
        </div>
        <div id="grid1"></div>
    </div>
    <div style="height: calc(35% - 10px); margin-top: 10px">
        <div class="grid_top_wrap">
            <div class="grid_top_left">
                문자 병합
                <span>(총 0건)</span>
            </div>
            <div class="grid_top_right">
                <input type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid2RowAdd()" />
                <input type="button" id="btn_rowDel" class="cmb_minus" onclick="fn_grid2RowDel()" />
            </div>
        </div>
        <div id="grid2"></div>
    </div>
</div>
<!-- 그리드 끝 -->
<!-- 그리드 시작 -->
<div class="ct_right_wrap">
    <div class="grid_top_wrap">
        <div class="grid_top_left">주문 접수 양식</div>
        <div class="grid_top_right">
            <button type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid3RowAdd()"></button>
            <button type="button" id="btn_rowDel" class="cmb_minus" onclick="fn_grid3RowDel()"></button>
        </div>
    </div>
    <div id="grid3"></div>
</div>
<!-- 그리드 끝 -->
<%-- <!-- 입력폼 시작 -->
<div class="ct_top_wrap">
	<form id="frmDetail" action="#" onsubmit="return false">
		<div class="ct_top_wrap" style="height:30%;">
			<table class="tblForm">
				<caption>기본정보</caption>
				<colgroup>
					<col width="140px" />
					<col width="245px" />
					<col width="140px" />
					<col width="245px" />
					<col width="140px" />
			        <col />
			    </colgroup>
				<tr>
					<th class="required">주문서양식명</th>
					<td>				
						<input type="text" id="SITE_NM" name="SITE_NM" class="cmc_txt required" maxlength="50"/>
						<input type="hidden" id="SITE_CD" name="SITE_NM" class="cmc_txt" maxlength="50"/>
					</td>
					<th class="required">주문서약식명</th>
					<td >				
						<input type="text" id="SITE_NM_SHORT" name="SITE_NM_SHORT" class="cmc_txt required" maxlength="3"/>	(송장에 출력 될 약식명 : 3자이내)
					</td>
				</tr>
				<tr>
					<th class="required">송장자체출력</th>
					<td>
						<input type="radio" id="DELI_INVC_DIRECT_YN" name="DELI_INVC_DIRECT_YN" class="cmc_radio" value="Y" checked="checked" style="width:13px" />
						<label for="DELI_INVC_DIRECT_YN1">사용함</label>
						<input type="radio" id="DELI_INVC_DIRECT_YN" name="DELI_INVC_DIRECT_YN" class="cmc_radio" value="N" checked="checked" style="width:13px" />
						<label for="DELI_INVC_DIRECT_YN2">사용하지않음</label>
					</td>
					<th class="required">활성화여부</th>
					<td >
						<input type="radio" id="ACTIVE_YN" name="ACTIVE_YN" class="cmc_radio" value="Y" checked="checked" style="width:13px" />
						<label for="ACTIVE_YN1">사용함</label>
						<input type="radio" id="ACTIVE_YN" name="ACTIVE_YN" class="cmc_radio" value="N" checked="checked" style="width:13px" />
						<label for="ACTIVE_YN2">사용하지않음</label>
					</td>
				</tr>	
				<tr>
					<th class="required">합포장기준열</th>
					<td >	
						<select id="PACK_1" name="PACK_1" class="cmc_combo" style="width:70px;">
							<option value="">선택</option>
							<c:forEach var="i" items="${codeLFCBOEXCELCOL}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>
						&nbsp;&nbsp;
						<select id="PACK_2" name="PACK_2" class="cmc_combo" style="width:70px;">
							<option value="">선택</option>
							<c:forEach var="i" items="${codeLFCBOEXCELCOL}">
								<option value="${i.code}">${i.value}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</table>	
			
			<table class="tblForm">
				<caption>발송정보</caption>
				<colgroup>
					<col width="140px" />
					<col width="245px" />
					<col width="140px" />
					<col width="245px" />
					<col width="140px" />
			        <col />
			    </colgroup>
				<tr>
					<th class="required">발송코드(SUB)</th>
					<td><input type="text" id="DELI_SUB_CODE" name="DELI_SUB_CODE" class="cmc_txt required num" maxlength="10" /></td>
					<th class="required">발송지명</th>
					<td><input type="text" id="DELI_SND_NM" name="DELI_SND_NM" class="cmc_txt required" maxlength="30" /></td>
					<th class="required">발송지전화</th>
					<td><input type="text" id="DELI_SND_TEL" name="DELI_SND_TEL" class="cmc_txt required" maxlength="30" /></td>
				</tr>
				<tr>
					<th class="required">발송지우편번호</th>
					<td>
						<input type="text" id="DELI_SND_ZIPCODE" name="DELI_SND_ZIPCODE" class="cmc_post required num" maxlength="10"/>
						<button type="button" class="cmc_cdsearch"></button>
					</td>
					<th class="required">발송지주소</th>
					<td >
						<input type="text" id="DELI_SND_ADDR" name="DELI_SND_ADDR" class="cmc_address required" style="width:400px;" maxlength="300"/>			
					</td>
				</tr>
			</table>
		</div>
			
		<div class="ct_mid_wrap" style="height:20%">
			<div style="width:calc(50% - 10px);height:100%; float: left;">
				<div class="grid_top_wrap">
					<div class="grid_top_left">셀 병합하기 : 파일을 불러올 때 여러 개의 셀을 병합하여 하나의 셀로 불러옵니다.</div>
					<div class="grid_top_right"></div>
				</div>
				<div>
					<table class="tblForm" id="src_table" style="width:50%; min-width:650px;">
						<colgroup>
							<col width="140px" />
							<col width="650px" />
					        <col />
					    </colgroup>
						<tr>
							<th>병합1</th>
							<td>
								<input type="text" id="TGT_COL1" name="TGT_COL1" class="cmc_txt num" style="width:50px;" maxlength="30"/> 열 = 
								<input type="text" id="SRC_COLS11" name="TGT_COL11" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
								<input type="text" id="SEPS11" name="SEPS11" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 
								<input type="text" id="SRC_COLS12" name="SRC_COLS12" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
								<input type="text" id="SEPS12" name="SEPS12" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 	
								<input type="text" id="SRC_COLS13" name="SRC_COLS13" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열
							</td> 					
						</tr>                                                                          
						<tr>
							<th>병합2</th>
							<td>                                                                       
								<input type="text" id="TGT_COL2" name="TGT_COL2 num" class="cmc_txt" style="width:50px;" maxlength="30"/> 열 =                                            
								<input type="text" id="SRC_COLS21" name="TGT_COL21" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
								<input type="text" id="SEPS21" name="SEPS21" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 
								<input type="text" id="SRC_COLS22" name="SRC_COLS22" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
								<input type="text" id="SEPS22" name="SEPS22" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 	
								<input type="text" id="SRC_COLS23" name="SRC_COLS23" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 					
							</td>                                                                        
						</tr>                                                                            
						<tr>
							<th>병합3</th>                                            
							<td >                                                                         
								<input type="text" id="TGT_COL3" name="TGT_COL3" class="cmc_txt num" style="width:50px;" maxlength="30"/> 열 =
								<input type="text" id="SRC_COLS31" name="TGT_COL31" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
								<input type="text" id="SEPS31" name="SEPS31" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 
								<input type="text" id="SRC_COLS32" name="SRC_COLS32" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 + 
								<input type="text" id="SEPS32" name="SEPS32" class="cmc_txt" style="width:50px;" maxlength="1"/> 구분자 + 	
								<input type="text" id="SRC_COLS33" name="SRC_COLS33" class="cmc_txt num" style="width:50px;" maxlength="5"/> 열 				
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div style="width:calc(50% - 10px);height:100%; float: left;">
				<div class="grid_top_wrap">
					<div class="grid_top_left">문자 치환하기 : 셀 내의 특정문자 열을 바꾼다.(예: 무료 ⇒ 선불, 상품선택 ⇒ "" )<span>(총 0건)</span></div>
					<div class="grid_top_right">
						<input type="button" id="btn_rowAdd" class="cmb_plus" onclick="fn_grid1RowAdd()" />  
						<input type="button" id="btn_rowDel" class="cmb_minus" onclick="fn_grid1RowDel()" /> 
					</div>
				</div>
				<div id="grid1"></div>
			</div>
		</div>
		
		<!-- 그리드 시작 -->
		<div class="ct_bot_wrap" style="height:calc(50% - 20px);">
			<div style="height:calc(30%);">
				<div class="grid_top_wrap" >
					<div class="grid_top_left" >주문서 양식 설정</div>
					<div class="grid_top_right">
					</div>
				</div>
	 			<div id="grid2" style="height:75px;"></div> 
			</div>
			<div style="height:calc(30%);">
				<div class="grid_top_wrap" >
					<div class="grid_top_left" >주문서 양식 헤더</div>
					<div class="grid_top_right">
					</div>
				</div>
	 			<div id="grid3" style="height:75px;"></div> 
			</div>
		</div>
	</form>
</div>
<!-- 입력폼 끝 --> --%>
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

        $('#S_COMPCD').val(cfn_loginInfo().COMPCD);

        /* 셀러 */
        pfn_codeval({
            url : '/alexcloud/popup/popP002/view.do',
            codeid : 'S_ORGCD',
            inparam : {
                S_COMPCD : 'S_COMPCD',
                S_ORGCD : 'S_ORGCD,S_ORGNM'
            },
            outparam : {
                ORGCD : 'S_ORGCD',
                NAME : 'S_ORGNM'
            },
            returnFn : function(data, type) {
                fn_sitecd();
            }
        });

        /* 셀러(입력폼) */
        pfn_codeval({
            url : '/alexcloud/popup/popP002/view.do',
            codeid : 'ORGCD',
            inparam : {
                S_COMPCD : 'S_COMPCD',
                S_ORGCD : 'ORGCD,ORGNM'
            },
            outparam : {
                ORGCD : 'ORGCD',
                NAME : 'ORGNM'
            }
        });

        /* 우편번호 코드/명 */
        pfn_postcodeval('DELI_SND_ZIPCODE', 'DELI_SND_ADDR');

        if (!cfn_isEmpty(cfn_loginInfo().ORGCD)) {
            //검색
            $('#S_ORGCD').attr('disabled', true).addClass('disabled').attr('readonly', 'readonly');
            $('#S_ORGNM').attr('disabled', true).addClass('disabled').attr('readonly', 'readonly');
            $('#btn_S_ORGCD').attr('disabled', 'disabled').addClass('disabled');

            //$('#S_ORGCD').val(cfn_loginInfo().ORGCD);
            //$('#S_ORGNM').val(cfn_loginInfo().ORGNM);

            $('#S_ORGCD').val("");
            $('#S_ORGNM').val("");
        }

        fn_sitecd();

        grid1_Load();
        grid2_Load();
        grid3_Load();

    });

    //컬럼ID 채번순서
    var colArr = [
            'C01', 'C02', 'C03', 'C04', 'C05', 'C06', 'C07', 'C08', 'C09', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18', 'C19', 'C20', 'C21', 'C22', 'C23', 'C24', 'C25', 'C26',
            'C27', 'C28', 'C29', 'C30', 'C31', 'C32', 'C33', 'C34', 'C35', 'C36', 'C37', 'C38', 'C39', 'C40', 'C41', 'C42', 'C43', 'C44', 'C45', 'C46', 'C47', 'C48', 'C49', 'C50', 'C51', 'C52',
            'C53', 'C54', 'C55', 'C56', 'C57', 'C58', 'C59', 'C60', 'C61', 'C62', 'C63', 'C64', 'C65', 'C66', 'C67', 'C68', 'C69', 'C70', 'C71', 'C72', 'C73', 'C74', 'C75', 'C76', 'C77', 'C78',
            'C79', 'C80', 'C81', 'C82', 'C83', 'C84', 'C85', 'C86', 'C87', 'C88', 'C89', 'C90', 'C91', 'C92', 'C93', 'C94', 'C95', 'C96', 'C97', 'C98', 'C99', 'C100'
    ];

    function grid1_Load() {
        var gid = 'grid1';
        var columns = [
                {
                    name : 'TGT_COL',
                    header : {
                        text : '대상열'
                    },
                    width : 70,
                    required : true,
                    formatter : 'combo',
                    comboValue : '${gCodeLFCBOEXCELCOL}',
                    editable : true,
                    styles : {
                        textAlignment : 'far'
                    }
                }, {
                    name : 'ETC1',
                    header : {
                        text : '='
                    },
                    width : 20,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'SRC_COLS1',
                    header : {
                        text : '1열'
                    },
                    width : 70,
                    required : true,
                    formatter : 'combo',
                    comboValue : '${gCodeLFCBOEXCELCOL}',
                    editable : true,
                    styles : {
                        textAlignment : 'far'
                    }
                }, {
                    name : 'ETC2',
                    header : {
                        text : '+'
                    },
                    width : 20,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'SEPS1',
                    header : {
                        text : '구분자1'
                    },
                    editable : true,
                    editor : {
                        maxLength : 100
                    },
                    width : 70,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'ETC3',
                    header : {
                        text : '+'
                    },
                    width : 20,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'SRC_COLS2',
                    header : {
                        text : '2열'
                    },
                    width : 70,
                    required : true,
                    formatter : 'combo',
                    comboValue : '${gCodeLFCBOEXCELCOL}',
                    editable : true,
                    styles : {
                        textAlignment : 'far'
                    }
                }, {
                    name : 'ETC4',
                    header : {
                        text : '+'
                    },
                    width : 20,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'SEPS2',
                    header : {
                        text : '구분자2'
                    },
                    editable : true,
                    editor : {
                        maxLength : 100
                    },
                    width : 70,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'ETC5',
                    header : {
                        text : '+'
                    },
                    width : 20,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'SRC_COLS3',
                    header : {
                        text : '3열'
                    },
                    width : 70,
                    formatter : 'combo',
                    comboValue : '${gCodeLFCBOEXCELCOL}',
                    editable : true,
                    styles : {
                        textAlignment : 'far'
                    }
                }, {
                    name : 'IDX',
                    header : {
                        text : 'IDX'
                    },
                    editor : {
                        maxLength : 100
                    },
                    width : 100,
                    visible : false,
                    show : false
                }
        ];

        //그리드 생성
        $('#' + gid).gfn_createGrid(columns, {
            editable : true,
            footerflg : false
        });

    }

    function grid2_Load() {
        var gid = 'grid2';
        var columns = [
                {
                    name : 'TGT_COL',
                    header : {
                        text : '대상열'
                    },
                    width : 70,
                    required : true,
                    formatter : 'combo',
                    comboValue : '${gCodeLFCBOEXCELCOL}',
                    editable : true,
                    styles : {
                        textAlignment : 'far'
                    }
                }, {
                    name : 'REPLACES1',
                    header : {
                        text : '치환대상문자열(~을)'
                    },
                    editable : true,
                    editor : {
                        maxLength : 100
                    },
                    width : 160
                }, {
                    name : 'REPLACES2',
                    header : {
                        text : '치환문자열(~으로)'
                    },
                    editable : true,
                    editor : {
                        maxLength : 100
                    },
                    width : 160
                }, {
                    name : 'IDX',
                    header : {
                        text : 'IDX'
                    },
                    editor : {
                        maxLength : 100
                    },
                    width : 100,
                    visible : false,
                    show : false
                }
        ];

        //그리드 생성
        $('#' + gid).gfn_createGrid(columns, {
            editable : true,
            footerflg : false
        });

    }

    function grid3_Load() {
        var gid = 'grid3';
        var columns = [
                {
                    name : 'SITE_NM',
                    header : {
                        text : '주문서양식'
                    },
                    width : 80,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'DB_COL_NM',
                    header : {
                        text : '순번'
                    },
                    width : 50,
                    required : true,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'DB_COL_NM_INVC',
                    header : {
                        text : '컬럼코드'
                    },
                    width : 150,
                    required : true,
                    formatter : 'combo',
                    comboValue : '${gCodeORDER_UPLOAD_CD}',
                    editable : true
                }, {
                    name : 'COL_NM',
                    header : {
                        text : '컬럼명'
                    },
                    width : 150,
                    required : true,
                    editable : true
                }, {
                    name : 'ISCHECK',
                    header : {
                        text : '필수여부'
                    },
                    width : 80,
                    required : true,
                    formatter : 'combo',
                    comboValue : '${GCODE_YN}',
                    styles : {
                        textAlignment : 'center'
                    },
                    editable : true,
                    editor : {
                        maxLength : 1
                    }
                }, {
                    name : 'CHECKTYPE',
                    header : {
                        text : '체크유형'
                    },
                    width : 100,
                    editable : true,
                    formatter : 'combo',
                    comboValue : '${GCODE_CHECKTYPE}',
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'CODEKEY',
                    header : {
                        text : '공통코드키'
                    },
                    width : 100,
                    editable : true
                }, {
                    name : 'MAXLEN',
                    header : {
                        text : '최대길이'
                    },
                    width : 80,
                    editable : true,
                    dataType : 'number',
                    styles : {
                        textAlignment : 'far'
                    }
                }, {
                    name : 'ADDUSERCD',
                    header : {
                        text : '등록자'
                    },
                    width : 100,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'ADDDATETIME',
                    header : {
                        text : '등록일시'
                    },
                    width : 140,
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
                    }
                }, {
                    name : 'UPDDATETIME',
                    header : {
                        text : '수정일시'
                    },
                    width : 140,
                    styles : {
                        textAlignment : 'center'
                    }
                }, {
                    name : 'TERMINALCD',
                    header : {
                        text : 'IP'
                    },
                    width : 100,
                    styles : {
                        textAlignment : 'center'
                    },
                    visible : false
                }, {
                    name : 'SITE_CD',
                    header : {
                        text : '택배사'
                    },
                    width : 80,
                    styles : {
                        textAlignment : 'center'
                    },
                    visible : false
                }, {
                    name : 'ORGCD',
                    header : {
                        text : '셀러코드'
                    },
                    width : 100,
                    show : false
                }, {
                    name : 'COMPCD',
                    header : {
                        text : '회사명'
                    },
                    width : 100,
                    show : false
                }, {
                    name : 'IDX',
                    header : {
                        text : 'IDX'
                    },
                    editor : {
                        maxLength : 100
                    },
                    width : 100,
                    visible : false,
                    show : false
                }
        ];
        //그리드 생성
        $('#' + gid).gfn_createGrid(columns, {
            editable : true,
            footerflg : false,
            sortable : false
        });

        //그리드설정 및 이벤트처리
        $('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
            //열고정 설정
            gridView.setFixedOptions({
                colCount : 3,
                resizable : true,
                colBarWidth : 1
            });

            //셀 수정 이벤트
            gridView.onEditChange = function(grid, column, value) {
                if (column.column === 'DB_COL_NM_INVC') {
                    $('#grid3').gridView().commit();
                    var rowDplVals = $('#grid3').gridView().getDisplayValues(column.itemIndex);
                    $('#grid3').gfn_setValue(column.itemIndex, "COL_NM", rowDplVals[column.column]);
                }
            };
            $('#' + gid).gridView().setColumnProperty(gridView.columnByField("DB_COL_NM"), "dynamicStyles", [
                {
                    criteria : [
                            "(values['DB_COL_NM'] <> '')",
                    ],
                    styles : [
                            "background=#ffff1a",
                    ]
                }
            ])
        });

    }

    /* 요청한 데이터 처리 callback */
    function gfn_callback(sid, data) {
        //검색(문자치환하기)
        if (sid == 'sid_getSearch') {
            var formData = data.resultData;//기본정보

            if (cfn_isEmpty(formData)) {
                cfn_msg('WARNING', '주문서 양식이 존재하지 않습니다.');
            } else {
                var gridData = data.resultList; //셀병합
                var gridData2 = data.resultList2;//문자치환	
                var gridData3 = data.resultList3;//주문접수양식

                cfn_bindFormData('frmDetail', formData);

                $('#grid1').gfn_setDataList(gridData);
                $('#grid2').gfn_setDataList(gridData2);
                $('#grid3').gfn_setDataList(gridData3);

                cfn_setIDUR('U');
            }
        }

        if (sid == 'sid_getSearch2') {
            var formData = data.resultData;//기본정보

            if (cfn_isEmpty(formData)) {
                cfn_msg('WARNING', '주문서 양식이 존재하지 않습니다.');
            } else {
                var gridData = data.resultList; //셀병합
                var gridData2 = data.resultList2;//문자치환	
                var gridData3 = data.resultList3;//주문접수양식

                cfn_bindFormData('frmDetail', formData);

                $('#grid1').gfn_setDataList(gridData);
                $('#grid2').gfn_setDataList(gridData2);
                $('#grid3').gfn_setDataList(gridData3);

                cfn_setIDUR('U');
                fn_sitecd();

                $('#S_SITE_CD').val(formData.S_SITE_CD);
            }
        }

        //저장
        if (sid == 'sid_setSave') {
            var formData = data.resultData;
            cfn_bindFormData('frmDetail', formData);
            cfn_msg('INFO', '정상적으로 저장되었습니다.');
            //location.href = '/alexcloud/p000/p000022/view.do';
            fn_retrieve(formData)
        }

        //삭제
        if (sid == 'sid_setDelete') {
            cfn_msg('INFO', '정상적으로 삭제되었습니다.');
            location.href = '/alexcloud/p000/p000022/view.do';
        }
    }

    /* 공통버튼 - 검색 클릭 */
    function cfn_retrieve() {
        $('#grid1').gridView().cancel();
        $('#grid2').gridView().cancel();
        $('#grid3').gridView().cancel();

        //검색조건 필수입력 체크
        if (cfn_isFormRequireData('frmSearch') == false)
            return;

        gv_searchData = cfn_getFormData('frmSearch');

        var sid = 'sid_getSearch';
        var url = '/alexcloud/p000/p000022/getSearch.do';
        var sendData = {
            'paramData' : gv_searchData
        };

        gfn_sendData(sid, url, sendData);
    }

    //저장 후 검색
    function fn_retrieve(formData) {
        formData.S_COMPCD = formData.LOGIN_COMPCD;
        formData.S_ORGCD = formData.S_ORGCD;
        formData.S_SITE_CD = formData.SITE_CD;

        var sid = 'sid_getSearch2';
        var url = '/alexcloud/p000/p000022/getSearch.do';
        var sendData = {
            'paramData' : formData
        };

        gfn_sendData(sid, url, sendData);
    }

    /* 공통버튼 - 신규 클릭 */
    function cfn_new() {
        gfn_pageMove('/alexcloud/p000/p000022/view.do');
    }

    /* 공통버튼 - 저장 클릭 */
    function cfn_save() {
        if (!cfn_isFormRequireData('frmDetail'))
            return false;

        if ($('#grid3').gfn_checkValidateCells()) {
            return false;
        }

        gv_DetailData = cfn_getFormData('frmDetail');
        gv_searchData = cfn_getFormData('frmSearch');

        gv_DetailData.S_COMPCD = gv_searchData.S_COMPCD;
        gv_DetailData.S_ORGCD = gv_searchData.S_ORGCD;

        var gridData1 = $('#grid1').gfn_getDataList();
        var gridData2 = $('#grid2').gfn_getDataList();
        var gridData3 = $('#grid3').gfn_getDataList();

        if (confirm('저장하시겠습니까?')) {
            var sid = 'sid_setSave';
            var url = '/alexcloud/p000/p000022/setSave.do';
            var sendData = {
                'paramData' : gv_DetailData,
                'paramList1' : gridData1,
                'paramList2' : gridData2,
                'paramList3' : gridData3
            };

            gfn_sendData(sid, url, sendData);
        }
    }

    //공통버튼 - 삭제 클릭
    function cfn_del() {

        gv_searchData = cfn_getFormData('frmSearch');

        if (cfn_getIDUR() === 'I' || $('#SITE_CD').val == '') {
            cfn_msg('WARNING', '신규등록 시 삭제 할 수 없습니다.');
            return false;
        }
        if (confirm('삭제하시겠습니까?')) {
            var sid = 'sid_setDelete';
            var url = '/alexcloud/p000/p000022/setDelete.do';
            var sendData = {
                'paramData' : gv_searchData
            };

            gfn_sendData(sid, url, sendData);
        }
    }

    /* 그리드 행추가 버튼 클릭(문자치환하기) */
    function fn_grid1RowAdd() {
        $('#grid1').gfn_addRow({
            'ETC1' : '=',
            'ETC2' : '+',
            'ETC3' : '+',
            'ETC4' : '+',
            'ETC5' : '+'
        });

    }

    /* 그리드 행삭제 버튼 클릭(문자치환하기) */
    function fn_grid1RowDel() {
        var rowidx = $('#grid1').gfn_getCurRowIdx();

        //검색 안하고 행 삭제 경우
        if (rowidx < 0) {
            cfn_msg('WARNING', '데이터가 없습니다.');
            return false;
        }

        var state = $('#grid1').dataProvider().getRowState(rowidx);

        //신규행 삭제 
        if (state === 'created') {
            $('#grid1').gfn_delRow(rowidx);
        } else {
            cfn_msg('WARNING', '기존에 등록된 내역은 삭제불가합니다.');
            return false;
        }

    }

    /* 그리드 행추가 버튼 클릭(문자병합) */
    function fn_grid2RowAdd() {
        $('#grid2').gfn_addRow(/* {'ORGCD':masterData.ORGCD} */);

    }

    /* 그리드 행삭제 버튼 클릭(문자병합) */
    function fn_grid2RowDel() {
        var rowidx = $('#grid2').gfn_getCurRowIdx();

        //검색 안하고 행 삭제 경우
        if (rowidx < 0) {
            cfn_msg('WARNING', '데이터가 없습니다.');
            return false;
        }

        var state = $('#grid2').dataProvider().getRowState(rowidx);

        //신규행 삭제 
        if (state === 'created') {
            $('#grid2').gfn_delRow(rowidx);
        } else {
            cfn_msg('WARNING', '기존에 등록된 내역은 삭제불가합니다.');
            return false;
        }

    }

    //양식명 가져오기(SELECTBOX)
    function fn_sitecd() {
        var orgcd = $('#S_ORGCD').val();
        var url = '/alexcloud/p000/p000022/getSiteCd.do';
        var sendData = {
            'paramData' : {
                'COMPCD' : cfn_loginInfo().COMPCD,
                'ORGCD' : orgcd
            }
        };

        gfn_ajax(url, false, sendData, function(data, xhr) {
            var list = data.resultList;
            var siteHtml = '';
            for (var i = 0; i < list.length; i++) {
                siteHtml += '<option value="'+list[i].CODE+'">' + list[i].VALUE + '</option>'
            }
            $('#S_SITE_CD').html(siteHtml);
        });

    }

    //행추가 ICON 버튼 클릭
    function fn_grid3RowAdd() {
        // 행추가시 배열보다 크지않도록 함
        var maxRowid = $('#grid3').dataProvider().getRowCount();

        if (colArr.length == maxRowid) {
            cfn_msg('INFO', '행추가를 더 이상 할 수 없습니다.');
            return false;
        }

        if (cfn_getIDUR() === 'I' || $('#SITE_CD').val == '') {
            $('#grid3').gfn_addRow({
                'SITE_NM' : $('#SITE_NM').val(),
                'ORGCD' : '',
                'COMPCD' : '',
                'SITE_CD' : ''
            });

        } else {
            $('#grid3').gfn_addRow({
                'SITE_NM' : $('#S_SITE_CD option:selected').text(),
                'ORGCD' : $('#S_ORGCD').val(),
                'COMPCD' : $('#S_COMPCD').val(),
                'SITE_CD' : $('#S_SITE_CD option:selected').val()
            });

        }

        //COL_ID 재정렬		
        fn_reSetGrid();

    }

    //행삭제 ICON 버튼 클릭
    function fn_grid3RowDel() {

        var rowidx = $('#grid3').gfn_getCurRowIdx();

        //검색 안하고 행 삭제 경우
        if (rowidx < 0) {
            cfn_msg('WARNING', '데이터가 없습니다.');
            return false;
        }

        var state = $('#grid3').dataProvider().getRowState(rowidx);

        //신규행 삭제 
        if (state === 'created') {
            $('#grid3').gfn_delRow(rowidx);
        } else {
            cfn_msg('WARNING', '기존에 등록된 내역은 삭제불가합니다.');
            return false;
        }
    }

    //COL_ID 재정렬 등록	
    function fn_reSetGrid() {
        var maxRowid = $('#grid3').dataProvider().getRowCount();

        if (maxRowid >= 0) {
            for (var i = 0; i < maxRowid; i++) {
                $('#grid3').gfn_setValue($('#grid3').gridView().getDataRow(i), 'DB_COL_NM', colArr[i]);
            }
        }
    }
</script>
<c:import url="/comm/contentBottom.do" />
