<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : PopS100
	화면명    : 팝업 - 전자결재 요청 팝업
-->
<div id="PopS100" class="pop_wrap">
	<!-- 검색조건영역 시작 -->
	<div id="ct_sech_wrap">
		<form id="frm_PopS100" action="#" onsubmit="return false">
			<input type="hidden" id="MENUID" name="MENUID" class="cmc_txt"/>
			<input type="hidden" id="ORGCD" name="ORGCD" class="cmc_txt"/>
			<input type="hidden" id="COMPCD" name="COMPCD" class="cmc_txt"/>
			<input type="hidden" id="REFNO1" name="REFNO1" class="cmc_txt" />
			<input type="hidden" id="REFNO2" name="REFNO2" class="cmc_txt" />
			<input type="hidden" id="DOCHTML" name="DOCHTML" class="cmc_txt" />
			<ul class="sech_ul">
			  	<li class="sech_li">
			  		<div style="width:50px">제목</div>
			  		<div style="width:500px;">
						<input type="text" id="DOCTITLE" name="DOCTITLE" class="cmc_txt required" style="width:500px;"/>
					</div>
				</li>
				<li class="cls"></li>
				<li class="sech_li">
			  		<div style="width:50px">비고</div>
			  		<div style="width:500px;">
						<input type="text" id="REQRMK" name="REQRMK" class="cmc_txt" style="width:500px;" />
					</div>
				</li>
			</ul>
		</form>
	</div>
	<!-- 검색조건영역 끝 -->
	
	<div class="ct_top_wrap">
		<div class="grid_top_wrap">
			<div class="grid_top_left">결재선 지정<span>(총 0건)</span></div>
			<div class="grid_top_right">
				<input type="button" id="btn_add" class="cmb_plus" onclick="pfn_btn_add()"/>
				<input type="button" id="btn_del" class="cmb_minus" onclick="pfn_btn_del()" />
				<input type="button" id="btn_up" class="cmb_normal" value="위로" onclick="pfn_btn_up();"/>
				<input type="button" id="btn_down" class="cmb_normal" value="아래로" onclick="pfn_btn_down();"/>
			</div>
		</div>
		<div id="grid_PopS100"></div>
	</div>
</div>
			
<script type="text/javascript">
var pData;
$(function() {
	$('#PopS100').lingoPopup({
		title: '전자결재',
		buttons: {
			'결재요청': {
				text: '결재요청',
				click: function() {
					var rowDatas = $('#grid_PopS100').gfn_getDataList();
					
					var formData = cfn_getFormData('frm_PopS100');
					
					//폼 필수입력 체크
					if(!cfn_isFormRequireData('frm_PopS100')) return false;
					
					if(rowDatas.length < 2) {
						cfn_msg('WARNING','결재선을 하나 이상 지정하세요.');
						return;
					}
					//그리드 필수입력 체크
					if ($('#grid_PopS100').gfn_checkValidateCells()) return false;
					
					//값이 없으면 html에 그대로 undefined로 들어감... ''로만들어줌..
					for(i=0; i<rowDatas.length; i++) {
						if(cfn_isEmpty(rowDatas[i].APVRMK)) {
							rowDatas[i].APVRMK = '';
						}
						
						if(cfn_isEmpty(rowDatas[i].POSITION)) {
							rowDatas[i].POSITION = '';
						}
					}
					
					var dochtml = 
 ' <table class="__se_tbl" border="1" cellpadding="0" cellspacing="1" _se2_tbl_template="1" style="background-color: rgb(199, 199, 199); border-collapse:collapse"><tbody>'																																																																																																						
+' <tr><td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 200px; height: 35px; background-color: rgb(255, 255, 255);" class="" colspan="1" rowspan="2"><p style="text-align: center;">'
+' <span style="font-size: 24pt;">' + pData.DOCNAME + '</span></p></td>'																								        
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 85px; height: 20px;"><p>&nbsp;문서번호</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 175px; height: 20px;">'
+' <p>DOCNO</p></td>' //디비에서 REPLACE
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 85px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1"><p>&nbsp;기안일자</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 175px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1" rowspan="1">'
+' <p>' + pData.DOCDT + '</p></td></tr><tr>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 85px; height: 20px;"><p>&nbsp;기안자</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 175px; height: 20px;">'
+' <p>' + cfn_loginInfo().USERNM + '</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 85px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1"><p>&nbsp;부서</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 175px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1" rowspan="1">'
+ '<p>' + cfn_loginInfo().DEPTNM + '</p></td></tr></tbody>'
+' </table><p></p><table class="__se_tbl" border="1" cellpadding="0" cellspacing="1" _se2_tbl_template="1" style="background-color: rgb(199, 199, 199); border-collapse:collapse"><tbody>'
+' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;제목</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 389px; height: 20px;">'
+' <p>' + $('#DOCTITLE').val() + '</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 85px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1"><p>&nbsp;전결자</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 175px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1" rowspan="1">'
+' <p id="DRTUSERNM"></p></td></tr>'
+' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;결재비고</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 660px; height: 20px;" colspan="3">'
+' <p>' + $('#REQRMK').val() + '</p></td></tr></tbody></table>'
+' <br><p style="color: rgb(102, 102, 102); font-size:medium">전표 정보</p><table class="__se_tbl" border="1" cellpadding="0" cellspacing="1" _se2_tbl_template="1" style="background-color: rgb(199, 199, 199); border-collapse:collapse"><tbody>'
/* +' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;거래처</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 110px; height: 20px;">'
+' <p>' + pData.CUSTNM + '</p></td>' */
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;총금액</p></td>                                                                                                                                                                                                    '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 87px; height: 20px;">'
+' <p>' + pData.TOTSUPPLYAMT + '</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;품목수</p></td>                                                                                                                                                                                                    '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 85px; height: 20px;">'
+' <p>' + pData.ITEMCNT + '</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;총수량</p></td>                                                                                                                                                                                                    '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 90px; height: 20px;">'
+' <p>' + pData.TOTQTY + '</p></td></tr>'
+' <tr><td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 80px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1" rowspan="1"><p>&nbsp;전표비고</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 642px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="7" rowspan="1">'
+' <p>' + pData.REMARK + '</p></td></tr></tbody></table>'
+' <br><p style="color: rgb(102, 102, 102); font-size:medium">결재선</p><table class="__se_tbl" border="1" cellpadding="0" cellspacing="1" _se2_tbl_template="1" style="background-color: rgb(199, 199, 199); border-collapse:collapse"><tbody>                                                                                                                                                                                             '
+' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 20px; height: 20px;"><p style="margin-left: 20px;"><br></p></td>                                                                                                                                                                             '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 65px; height: 20px;"><p>&nbsp;담당자</p></td>                                                                                                                                                                                                    '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 65px; height: 20px;"><p>&nbsp;부서</p></td>                                                                                                                                                                                                      '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 65px; height: 20px;"><p>&nbsp;직책</p></td>                                                                                                                                                                                                      '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 65px; height: 20px;"><p>&nbsp;결재유형</p></td>                                                                                                                                                                                                  '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 65px; height: 20px;"><p>&nbsp;결재상태</p></td>                                                                                                                                                                                                  '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 305px; height: 20px;"><p>&nbsp;비고</p></td></tr>'
+' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 20px; height: 20px;"><p>1</p></td>                                                                                                                                                                                                      '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 70px; height: 20px;"><p>'+ rowDatas[0].APVUSERNM +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 70px; height: 20px;"><p>'+ rowDatas[0].APVDEPTNM +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 70px; height: 20px;"><p>'+ rowDatas[0].POSITION +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 70px; height: 20px;"><p>기안</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 70px; height: 20px;"><p>승인</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 305px; height: 20px;"><p>'+ rowDatas[0].APVRMK +'</p></td></tr>';

for(i=1; i<rowDatas.length - 1; i++) {
dochtml = dochtml + 
' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 20px; height: 20px;"><p>'+ (parseInt(i) + parseInt(1)) +'</p></td>                                                                                                                                                                                                      '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[i].APVUSERNM +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[i].APVDEPTNM +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[i].POSITION +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>합의</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p id="DOCSTS' + i + '"></p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 305px; height: 20px;"><p id="APVRMK' + i + '">'+ rowDatas[i].APVRMK +'</p></td></tr>'		
;}

if(rowDatas.length > 1) {
	dochtml = dochtml + 
	' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 20px; height: 20px;"><p>'+ (parseInt(rowDatas.length - 1) + parseInt(1)) +'</p></td>                                                                                                                                                                                                      '
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[rowDatas.length - 1].APVUSERNM +'</p></td>                                                                                                                                                                                                          '
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[rowDatas.length - 1].APVDEPTNM +'</p></td>                                                                                                                                                                                                          '
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[rowDatas.length - 1].POSITION +'</p></td>'
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>승인</p></td>'
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p id="DOCSTS' + (rowDatas.length - 1) + '"></p></td>'
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 305px; height: 20px;"><p id="APVRMK' + (rowDatas.length - 1) + '">'+ rowDatas[rowDatas.length - 1].APVRMK +'</p></td></tr>'		
	;	
}

dochtml = dochtml + 
' </tbody>                                                                                                                                                                                                                                                                                                                                                  '
+' </table>';

$('#DOCHTML').val(dochtml);
				
					var formData = cfn_getFormData('frm_PopS100');

					if(confirm("결재요청 하시겠습니까?")) {
						var url = '/alexcloud/popup/PopS100/setSave.do';
						
						formData.ALLAPPROV = false;
						
						var sendData = {'paramData':formData, 'paramList':rowDatas};
						
						gfn_ajax(url, true, sendData, function(data, xhr) {
							var resultData = data.resultData;

							if(resultData['SCNT'] > 1) {
								cfn_msg('INFO','정상적으로 결재요청되었습니다.');
								resultData.DOCSTS = '기안';
								$('#PopS100').lingoPopup('setData', resultData);
								$('#PopS100').lingoPopup('close', 'OK');
							} else {
								cfn_msg('WARNING','결재요청 실패');
							}
						});	
					}
				}
			},
			'전결': {
				text: '전결',
				click: function() {
					//전결 권한이 있는지 체크
					if('${ISDRT}' != 'Y') {
						cfn_msg('WARNING','전결권한이 없습니다.');
						return;
					}
					
					var formData = cfn_getFormData('frm_PopS100');
						
					//폼 필수입력 체크
					if(!cfn_isFormRequireData('frm_PopS100')) return false;
					
					var rowDatas = $('#grid_PopS100').gfn_getDataList();
					
					//그리드 필수입력 체크
					if ($('#grid_PopS100').gfn_checkValidateCells()) return false;
					
					//값이 없으면 html에 그대로 undefined로 들어감... ''로만들어줌..
					for(i=0; i<rowDatas.length; i++) {
						if(cfn_isEmpty(rowDatas[i].APVRMK)) {
							rowDatas[i].APVRMK = '';
						}
						
						if(cfn_isEmpty(rowDatas[i].POSITION)) {
							rowDatas[i].POSITION = '';
						}
					}
					
					if(confirm("전결 하시겠습니까?")) {
						
	var dochtml = 
 ' <table class="__se_tbl" border="1" cellpadding="0" cellspacing="1" _se2_tbl_template="1" style="background-color: rgb(199, 199, 199); border-collapse:collapse"><tbody>'																																																																																																						
+' <tr><td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 200px; height: 35px; background-color: rgb(255, 255, 255);" class="" colspan="1" rowspan="2"><p style="text-align: center;">'
+' <span style="font-size: 24pt;">' + pData.DOCNAME + '</span></p></td>'																								        
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 85px; height: 20px;"><p>&nbsp;문서번호</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 175px; height: 20px;">'
+' <p>DOCNO</p></td>' //디비에서 REPLACE
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 85px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1"><p>&nbsp;기안일자</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 175px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1" rowspan="1">'
+' <p>' + pData.DOCDT + '</p></td></tr><tr>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 85px; height: 20px;"><p>&nbsp;기안자</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 175px; height: 20px;">'
+' <p>' + cfn_loginInfo().USERNM + '</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 85px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1"><p>&nbsp;부서</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 175px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1" rowspan="1">'
+ '<p>' + cfn_loginInfo().DEPTNM + '</p></td></tr></tbody>'
+' </table><p></p><table class="__se_tbl" border="1" cellpadding="0" cellspacing="1" _se2_tbl_template="1" style="background-color: rgb(199, 199, 199); border-collapse:collapse"><tbody>'
+' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;제목</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 384px; height: 20px;">'
+' <p>' + $('#DOCTITLE').val() + '</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 83px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1"><p>&nbsp;전결자</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 175px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1" rowspan="1">'
+' <p>' + cfn_loginInfo().USERNM + '</p></td></tr>'
+' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;결재비고</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 668px; height: 20px;" colspan="3">'
+' <p>' + $('#REQRMK').val() + '</p></td></tr></tbody></table>'
+' <br><p style="color: rgb(102, 102, 102); font-size:medium">전표 정보</p><table class="__se_tbl" border="1" cellpadding="0" cellspacing="1" _se2_tbl_template="1" style="background-color: rgb(199, 199, 199); border-collapse:collapse"><tbody>'
/* +' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;거래처</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 110px; height: 20px;">'
+' <p>' + pData.CUSTNM + '</p></td>' */
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;총금액</p></td>                                                                                                                                                                                                    '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 87px; height: 20px;">'
+' <p>' + pData.TOTSUPPLYAMT + '</p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;품목수</p></td>                                                                                                                                                                                                    '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 85px; height: 20px;">'
+' <p>' + pData.ITEMCNT + '</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 80px; height: 20px;"><p>&nbsp;총수량</p></td>                                                                                                                                                                                                    '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 90px; height: 20px;">'
+' <p>' + pData.TOTQTY + '</p></td></tr>'
+' <tr><td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 80px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="1" rowspan="1"><p>&nbsp;전표비고</p></td>'
+' <td style="padding: 3px 4px 2px; color: rgb(102, 102, 102); width: 642px; height: 20px; background-color: rgb(255, 255, 255);" class="" colspan="7" rowspan="1">'
+' <p>' + pData.REMARK + '</p></td></tr></tbody></table>'
+' <br><p style="color: rgb(102, 102, 102); font-size:medium">결재선</p><table class="__se_tbl" border="1" cellpadding="0" cellspacing="1" _se2_tbl_template="1" style="background-color: rgb(199, 199, 199); border-collapse:collapse"><tbody>                                                                                                                                                                                             '
+' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 20px; height: 20px;"><p style="margin-left: 20px;"><br></p></td>                                                                                                                                                                             '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 65px; height: 20px;"><p>&nbsp;담당자</p></td>                                                                                                                                                                                                    '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 65px; height: 20px;"><p>&nbsp;부서</p></td>                                                                                                                                                                                                      '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 65px; height: 20px;"><p>&nbsp;직책</p></td>                                                                                                                                                                                                      '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 65px; height: 20px;"><p>&nbsp;결재유형</p></td>                                                                                                                                                                                                  '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 65px; height: 20px;"><p>&nbsp;결재상태</p></td>                                                                                                                                                                                                  '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 305px; height: 20px;"><p>&nbsp;비고</p></td></tr>'
+' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 20px; height: 20px;"><p>1</p></td>                                                                                                                                                                                                      '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 70px; height: 20px;"><p>'+ rowDatas[0].APVUSERNM +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 70px; height: 20px;"><p>'+ rowDatas[0].APVDEPTNM +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 70px; height: 20px;"><p>'+ rowDatas[0].POSITION +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 70px; height: 20px;"><p>기안</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 70px; height: 20px;"><p>승인</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 305px; height: 20px;"><p>'+ rowDatas[0].APVRMK +'</p></td></tr>';

for(i=1; i<rowDatas.length - 1; i++) {
dochtml = dochtml + 
' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 20px; height: 20px;"><p>'+ (parseInt(i) + parseInt(1)) +'</p></td>                                                                                                                                                                                                      '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[i].APVUSERNM +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[i].APVDEPTNM +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[i].POSITION +'</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>합의</p></td>                                                                                                                                                                                                          '
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p id="DOCSTS' + i + '"></p></td>'
+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 305px; height: 20px;"><p id="APVRMK' + i + '">'+ rowDatas[i].APVRMK +'</p></td></tr>'		
;}

if(rowDatas.length > 1) {
	dochtml = dochtml + 
	' <tr><td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 20px; height: 20px;"><p>'+ (parseInt(rowDatas.length) + parseInt(1)) +'</p></td>                                                                                                                                                                                                      '
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[rowDatas.length - 1].APVUSERNM +'</p></td>                                                                                                                                                                                                          '
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[rowDatas.length - 1].APVDEPTNM +'</p></td>                                                                                                                                                                                                          '
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>'+ rowDatas[rowDatas.length - 1].POSITION +'</p></td>                                                                                                                                                                                                          '
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p>승인</p></td>                                                                                                                                                                                                          '
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 75px; height: 20px;"><p id="DOCSTS' + (rowDatas.length - 1) + '"></p></td>'
	+' <td style="padding: 3px 4px 2px; background-color: rgb(255, 255, 255); color: rgb(102, 102, 102); width: 305px; height: 20px;"><p id="APVRMK' + (rowDatas.length - 1) + '">'+ rowDatas[rowDatas.length - 1].APVRMK +'</p></td></tr>';	
}

dochtml = dochtml + 
' </tbody>                                                                                                                                                                                                                                                                                                                                                  '
+' </table>';

						$('#DOCHTML').val(dochtml);
						
						var formData = cfn_getFormData('frm_PopS100');

						var url = '/alexcloud/popup/PopS100/setSave.do';
						
						formData.ALLAPPROV = true;
						
						var sendData = {'paramData':formData, 'paramList':rowDatas};
						
						gfn_ajax(url, true, sendData, function(data, xhr) {
							var resultData = data.resultData;

							if(resultData['SCNT'] > 1) {
								cfn_msg('INFO','정상적으로 전결되었습니다.');
								resultData.DOCSTS = '승인';
								$('#PopS100').lingoPopup('setData', resultData);
								$('#PopS100').lingoPopup('close', 'OK');
							} else {
								cfn_msg('WARNING','전결 실패');
							}
						});	
					}
				}
			},
			'취소': {
				text: '취소',
				click: function() {
					$(this).lingoPopup('setData', '');
					$(this).lingoPopup('close', 'CANCEL');
				}
			}
		},
		open: function(data) {
			cfn_bindFormData('frm_PopS100', data);
			
			pData = data;
			
			grid_PopS100_Load();
			
			$('#grid_PopS100').gfn_addRow({'APVUSERCD':cfn_loginInfo().USERCD,
										 'APVUSERNM':cfn_loginInfo().USERNM,
										 'APVDEPTCD':cfn_loginInfo().DEPTCD,
										 'APVDEPTNM':cfn_loginInfo().DEPTNM,
										 'DOCTYPE':'REQ', //기안
									     'DOCSTS':'900', //승인
									     'APVRMK':'기안자',
									     'EMAIL':'${EMAIL}', //로그인 사용자의 이메일
									     'POSITION':'${POSITION}' //로그인 정보로 가져오거나, 사용자가 설정, 시스템이 설정
										 });
		}
	});
});

function grid_PopS100_Load() {
	var gid = 'grid_PopS100';
	var columns = [
		{name:'APVUSERCD',header:{text:'담당자'},width:100,formatter:'popup',editable:true,required:true,
			popupOption:{url:'/alexcloud/popup/popS010/view.do',
						inparam:{S_USERCD:'APVUSERCD'},
						outparam:{USERCD:'APVUSERCD',NAME:'APVUSERNM',DEPTCD:'APVDEPTCD',DEPTNM:'APVDEPTNM',EMAIL:'EMAIL',POSITION:'POSITION'},
						returnFn: function(data) {
							if(data.length > 0) {
								var rowDatas = $('#grid_PopS100').gfn_getDataList();
								var rowidx = $('#grid_PopS100').gfn_getCurRowIdx();
								
								for(var i=0; i<rowDatas.length -1; i++) {
									if(rowDatas[i].APVUSERCD == data[0].USERCD && i != rowidx) {
										cfn_msg('WARN', '중복된 결재자가 있습니다.');
										
										$('#grid_PopS100').gfn_setValue(rowidx,'APVUSERCD', null);
										$('#grid_PopS100').gfn_setValue(rowidx,'APVUSERNM', null);
										$('#grid_PopS100').gfn_setValue(rowidx,'APVDEPTCD', null);
										$('#grid_PopS100').gfn_setValue(rowidx,'APVDEPTNM', null);
										$('#grid_PopS100').gfn_setValue(rowidx,'EMAIL', null);
										$('#grid_PopS100').gfn_setValue(rowidx,'POSITION', null);
										
										return false;
									}
								}
							}
						}
			}		
},
		{name:'APVUSERNM',header:{text:'담당자명'},width:120},
		{name:'APVDEPTCD',header:{text:'부서코드'},width:80},
		{name:'APVDEPTNM',header:{text:'부서명'},width:120,required:true},
		{name:'DOCTYPE',header:{text:'결재유형'},width:80,formatter:'combo',comboValue:'${gCodeDOCTYPE}',styles:{textAlignment:'center'}},
		{name:'DOCSTS',header:{text:'결재상태'},width:80,formatter:'combo',comboValue:'${gCodeDOCSTS}',styles:{textAlignment:'center'}},
		{name:'APVRMK',header:{text:'승인비고'},width:100},
		{name:'EMAIL',header:{text:'이메일'},width:150},
		{name:'POSITION',header:{text:'직책'},width:100}
	];
	
	//그리드 생성
	$('#' + gid).gfn_createGrid(columns, {sortable: false, footerflg:false});
	
	//그리드설정 및 이벤트처리
	$('#' + gid).gfn_setGridEvent(function(gridView, dataProvider) {
		//셀 로우 변경 이벤트
		gridView.onCurrentRowChanged = function(grid, oldRowIdx, newRowIdx) {
			if (newRowIdx > -1) {
				//기안자 수정불가
				var editable = grid.getValue(newRowIdx, 'DOCTYPE') != 'REQ'
				$('#' + gid).gfn_setColDisabled(['APVUSERCD'], editable);
			}
		};
	});
}


//그리드 로우 추가 버튼 이벤트
function pfn_btn_add() {
	$('#grid_PopS100').gfn_addRow({'DOCTYPE':'APV'});
	
	var itemidx = $('#grid_PopS100').gfn_getCurItemIdx();
	
	for(var i=1; i < itemidx; i++) {
		var rowid = $('#grid_PopS100').gridView().getDataRow(i);
		$('#grid_PopS100').gfn_setValue(rowid,'DOCTYPE', 'REF');
	}
}  

//그리드 로우 삭제 버튼 이벤트
function pfn_btn_del() {
	var itemidx = $('#grid_PopS100').gfn_getCurItemIdx();
	
	var rowidx = $('#grid_PopS100').gridView().getDataRow(itemidx);
	var doctype = $('#grid_PopS100').gfn_getValue(rowidx, 'DOCTYPE');
	
	if(cfn_isEmpty(rowidx)) {
		cfn_msg('WARNING','삭제할 담당자를 선택하세요.');
		return;
	}
	
	if(doctype == 'REQ') {
		cfn_msg('WARNING','기안자는 삭제할 수 없습니다.');
		return;
	} else {
		$('#grid_PopS100').gfn_delRow(rowidx);
		
		var endidx = $('#grid_PopS100').dataProvider().getRowCount();
		
		if(endidx > 1) {
			$('#grid_PopS100').gfn_setValue(endidx-1,'DOCTYPE', 'APV');
			
			for(var i=1; i < endidx - 1; i++) {
				var rowid = $('#grid_PopS100').gridView().getDataRow(i);
				$('#grid_PopS100').gfn_setValue(rowid,'DOCTYPE', 'REF');
			}
		}
	} 
}  

//그리드 로우 위로 버튼 이벤트
function pfn_btn_up() {
	var rowidx = $('#grid_PopS100').gfn_getCurRowIdx();
	
	if(rowidx != 0 && rowidx != 1) {
		$('#grid_PopS100').dataProvider().moveRow(rowidx,rowidx-1); //2번을 1번으로 이동한다.
	
		var index = {dataRow:rowidx-1}; //1번에 포커스
		$('#grid_PopS100').gridView().setCurrent(index);
	}
	
	//전체 행의 개수를 알아내서, 마지막 행에는 승인, 사이에는 합의로 넣어준다.
	var endidx = $('#grid_PopS100').dataProvider().getRowCount();
	
	if(endidx > 1) {
		$('#grid_PopS100').gfn_setValue(endidx-1,'DOCTYPE', 'APV');
		
		for(var i=1; i < endidx - 1; i++) {
			var rowid = $('#grid_PopS100').gridView().getDataRow(i);
			$('#grid_PopS100').gfn_setValue(rowid,'DOCTYPE', 'REF');
		}
	}
} 


//그리드 로우 아래로 버튼 이벤트
function pfn_btn_down() {
	var rowidx = $('#grid_PopS100').gfn_getCurRowIdx();
	
	var endidx = $('#grid_PopS100').dataProvider().getRowCount();
	
	if(rowidx != 0 && rowidx != endidx - 1) {
		$('#grid_PopS100').dataProvider().moveRow(rowidx,rowidx+1); //2번을 3번으로 이동한다.
		
		var index = {dataRow:rowidx+1}; //1번에 포커스
		$('#grid_PopS100').gridView().setCurrent(index);
	}
	
	//전체 행의 개수를 알아내서, 마지막 행에는 승인, 사이에는 합의로 넣어준다.
	var endidx = $('#grid_PopS100').dataProvider().getRowCount();
	
	if(endidx > 1) {
		$('#grid_PopS100').gfn_setValue(endidx-1,'DOCTYPE', 'APV');
		
		for(var i=1; i < endidx - 1; i++) {
			var rowid = $('#grid_PopS100').gridView().getDataRow(i);
			$('#grid_PopS100').gfn_setValue(rowid,'DOCTYPE', 'REF');
		}
	}
}

</script>