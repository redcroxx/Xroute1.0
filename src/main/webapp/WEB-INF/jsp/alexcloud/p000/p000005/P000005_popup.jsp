<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
	화면코드 : P000005_popup
	화면명    : 로케이션 라벨 출력
-->
<div id="P000005_popup" class="pop_wrap">
	<div id="ct_sech_wrap">
		<form id="frmDetail_P000005_popup" action="#" onsubmit="return false">
			<input type="hidden" id="COMPCD" />
			<input type="hidden" id="WHCD" />
			<ul class="sech_ul">
				<li class="sech_li">	
					<div>
						<input type="radio" id="PAGETYPE1" name="PAGETYPE" class="cmc_radio" value="1" checked="checked" style="width:13px" />
						<label for="PAGETYPE1">라벨</label>
						<input type="radio" id="PAGETYPE2" name="PAGETYPE" class="cmc_radio" value="2" checked="checked" style="width:13px" />
						<label for="PAGETYPE2">A4</label>
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">	
					<div>
						<input type="radio" id="RPTTYPE1" name="RPTTYPE" class="cmc_radio" value="1" checked="checked" style="width:13px" />
						<label for="RPTTYPE1">전체출력</label>
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">	
					<div>
						<input type="radio" id="RPTTYPE2" name="RPTTYPE" class="cmc_radio" value="2" style="width:13px" />
						<label for="RPTTYPE2">범위출력</label>
					</div>
					<div>
						<input type="text" id="LOCCDFR" class="cmc_txt" style="width:100px" /> ~ 
						<input type="text" id="LOCCDTO" class="cmc_txt" style="width:100px" />
					</div>
				</li>
			</ul>
			<ul class="sech_ul">
				<li class="sech_li">	
					<div>
						<input type="radio" id="RPTTYPE3" name="RPTTYPE" class="cmc_radio" value="3" style="width:13px" />
						<label for="RPTTYPE3">단위출력</label>
					</div>
					<div>
						<input type="text" id="LOCCD" class="cmc_txt" style="width:100px" />
					</div>
				</li>
			</ul>
		</form>
	</div>
</div>

<script type="text/javascript">
$(function() {
	$('#P000005_popup').lingoPopup({
		title: '로케이션 라벨 출력',
		width: 450,
		height: 220,
		buttons: {
			'확인': {
				text: '확인',
				click: function() {
					var formData = cfn_getFormData('frmDetail_P000005_popup');
					
					if (formData.RPTTYPE === '2') {
						if (cfn_isEmpty(formData.LOCCDFR) || cfn_isEmpty(formData.LOCCDTO)) {
							cfn_msg('WARNING', '로케이션코드 범위를 입력해야 합니다.');
							return false;
						}
					} else if (formData.RPTTYPE === '3') {
						if (cfn_isEmpty(formData.LOCCD)) {
							cfn_msg('WARNING', '로케이션코드를 입력해야 합니다.');
							return false;
						}
					}
					
					if(formData.PAGETYPE === '1'){
						rfn_reportLabel({
							jrfName: 'P000005_R01',
							args: formData
						});
					} else {
						rfn_reportLabel({
							jrfName: 'P000005_R02',
							args: formData
						});
					}
					
					$(this).lingoPopup('setData', formData);
					$(this).lingoPopup('close', 'OK');
				}
			},
			'취소': {
				text: '취소',
				click: function() {
					$(this).lingoPopup('setData', '');
					$(this).lingoPopup('close');
				}
			}
		},
		open: function(data) {
			cfn_bindFormData('frmDetail_P000005_popup', data);
		}
	});
});
</script>