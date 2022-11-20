<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var gCodeLOT4 = '${gCodeLOT4}';
var gCodeLOT5 = '${gCodeLOT5}';
var gCodeFUSER01 = '${gCodeFUSER01}';
var gCodeFUSER02 = '${gCodeFUSER02}';
var gCodeFUSER03 = '${gCodeFUSER03}';
var gCodeFUSER04 = '${gCodeFUSER04}';
var gCodeFUSER05 = '${gCodeFUSER05}';
</script>
		<ul class="sech_ul">
			<li class="sech_li" id="F_USER01_YN" >
				<div style="width:100px" id="F_USER01_LABEL">지정속성1</div>
				<div style="width:250px">	
					<select id="S_F_USER01" name="S_F_USER01" class="cmc_combo">
						<option value=""><c:out value="전체" /></option>
						<c:forEach var="i" items="${codeFUSER01}">
							<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li" id="F_USER02_YN">
				<div style="width:100px" id="F_USER02_LABEL">지정속성2</div>
				<div style="width:250px">		
					<select id="S_F_USER02" name="S_F_USER02" class="cmc_combo">
						<option value=""><c:out value="전체" /></option>
						<c:forEach var="i" items="${codeFUSER02}">
							<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li" id="F_USER03_YN">
				<div style="width:100px" id="F_USER03_LABEL">지정속성3</div>
				<div style="width:250px">		
					<select id="S_F_USER03" name="S_F_USER03" class="cmc_combo">
						<option value=""><c:out value="전체" /></option>
						<c:forEach var="i" items="${codeFUSER03}">
							<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li" id="F_USER04_YN">
				<div style="width:100px" id="F_USER04_LABEL">지정속성4</div>
				<div style="width:250px">		
					<select id="S_F_USER04" name="S_F_USER04" class="cmc_combo">
						<option value=""><c:out value="전체" /></option>
						<c:forEach var="i" items="${codeFUSER04}">
							<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li" id="F_USER05_YN">
				<div style="width:100px" id="F_USER05_LABEL">지정속성5</div>
				<div style="width:250px">		
					<select id="S_F_USER05" name="S_F_USER05" class="cmc_combo">
						<option value=""><c:out value="전체" /></option>
						<c:forEach var="i" items="${codeFUSER05}">
							<option value="<c:out value='${i.code}' />"><c:out value="${i.value}" /></option>
						</c:forEach>
					</select>
				</div>
			</li>
			<li class="sech_li" id="F_USER11_YN" >
				<div style="width:100px" id="F_USER11_LABEL">지정속성11</div>
				<div style="width:250px">		
					<input type="text" id="S_F_USER11" name="S_F_USER11" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li" id="F_USER12_YN">
				<div style="width:100px" id="F_USER12_LABEL">지정속성12</div>
				<div style="width:250px">		
					<input type="text" id="S_F_USER12" name="S_F_USER12" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li" id="F_USER13_YN">
				<div style="width:100px" id="F_USER13_LABEL">지정속성13</div>
				<div style="width:250px">		
					<input type="text" id="S_F_USER13" name="S_F_USER13" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li" id="F_USER14_YN">
				<div style="width:100px" id="F_USER14_LABEL">지정속성14</div>
				<div style="width:250px">		
					<input type="text" id="S_F_USER14" name="S_F_USER14" class="cmc_txt" />
				</div>
			</li>
			<li class="sech_li" id="F_USER15_YN">
				<div style="width:100px" id="F_USER15_LABEL">지정속성5</div>
				<div style="width:250px">		
					<input type="text" id="S_F_USER15" name="S_F_USER15" class="cmc_txt" />
				</div>
			</li>
		</ul>