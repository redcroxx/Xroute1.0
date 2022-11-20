package xrt.lingoframework.utils;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.exceptions.LingoException;

public class Util {
	public static final String C_HISTORY_WI = "WI";
	public static final String C_HISTORY_ADJ = "ADJ";
	public static final String C_HISTORY_WO = "WO";
	public static final String C_HISTORY_SWO = "SWO";
	public static final String C_HISTORY_SET = "SET";

	public static final String C_HISTORY_ASSY = "ASSY";
//	public static final String C_HISTORY_WOALLOC = "WA";

	/**
	 * 그리드용 공통코드로 변환
	 * @param codeList
	 * @return
	 */
	public static String getCommonCodeGrid(List<CodeVO> codeList) {
		String resultValue = "";
		for (int i=0; i<codeList.size(); i++) {
			if (i == 0) {
				resultValue += codeList.get(i).getCode() + ":" + codeList.get(i).getValue();
			} else {
				resultValue += ";" + codeList.get(i).getCode() + ":" + codeList.get(i).getValue();
			}
		}

		return resultValue;
	}

	/**
	 * 그리드용 공통코드로 변환(선택 추가)
	 * @param codeList
	 * @return
	 */
	public static String getCommonCodeGridAll(List<CodeVO> codeList) {
		String resultValue = ":---선택---;";
		for (int i=0; i<codeList.size(); i++) {
			if (i == 0) {
				resultValue += codeList.get(i).getCode() + ":" + codeList.get(i).getValue();
			} else {
				resultValue += ";" + codeList.get(i).getCode() + ":" + codeList.get(i).getValue();
			}
		}

		return resultValue;
	}

	/**
	 * 그리드용 공통코드로 변환
	 * @param codeList
	 * @return
	 */
	public static String getCommonCodeGridLData(List<LDataMap> codeList) {
		String resultValue = "";
		for (int i=0; i<codeList.size(); i++) {
			if (i == 0) {
				resultValue += codeList.get(i).getString("CODE") + ":" + codeList.get(i).getString("VALUE");
			} else {
				resultValue += ";" + codeList.get(i).getString("CODE") + ":" + codeList.get(i).getString("VALUE");
			}
		}

		return resultValue;
	}

	/**
	 * 날짜시간 포맷 변환
	 * @param {Date} date
	 * @param {String} pattern : 포맷
 	 */
	public static String getDateFormat(Date date, String pattern) {
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		return format.format(date);
	}

	/**
	 * 현재 날짜시간 포맷 변환
	 * @param {String} pattern : 포맷
 	 */
	public static String getTodayFormat(String pattern) {
		Date today = new Date();
		return getDateFormat(today, pattern);
	}

	/**
	 * 변수가 null이거나 빈값 여부
	 * @param {Object} obj : 검사할 값
	 */
	public static boolean isEmpty(Object obj) {
		boolean flag = false;

		if (obj == null || obj.toString().trim().length() < 1)
			flag = true;

		return flag;
	}

	/**
	 * null 또는 빈값일 경우 빈값으로 변환
	 * @param obj 빈값 검사대상 값
	 */
	public static String ifEmpty(Object obj) {
		String result = "";

		if (!isEmpty(obj))
			result = obj.toString().trim();

		return result;
	}

	/**
	 * null 또는 빈값일 경우 기본값으로 변환
	 * @param obj 빈값 검사대상 값
	 * @param defaultVal 변환 값
	 */
	public static String ifEmpty(Object obj, String defaultVal) {
		String result = defaultVal;

		if (!isEmpty(obj))
			result = obj.toString().trim();

		return result;
	}

	/**
	 * null 또는 빈값일 경우 기본값으로 변환
	 * @param obj 빈값 검사대상 값
	 * @param defaultVal 변환 값
	 */
	public static Object ifEmpty(Object obj, Object defaultVal) {
		Object result = defaultVal;

		if (!isEmpty(obj))
			result = obj.toString().trim();

		return result;
	}

	/**
	 * 변수가 null이면 빈값, 아니면 Object -> String 변환
	 * @param {Object} obj : 검사할 값
	 * @return {String} 빈값 또는 obj
	 */
	public static String NVL(Object obj) {
		if (null == obj)
			return Constants.EMPTY_STRING;
		return obj.toString();
	}

	/**
	 * 변수가 null이면 파라미터값, 아니면 Object -> String 변환
	 * @param {Object} obj : 검사할 값
	 * @param {String} defaultValue : 변환 기본값
	 * @return {String} obj 또는 defaultValue
	 */
	public static String NVL(Object obj, String defaultValue) {
		if (null == obj)
			return defaultValue;
		return obj.toString();
	}

	/**
	 *
	 */
	public static String lPad(String s, int length, String padstr) {
		while(s.length() < length) {
			s = padstr + s;
		}

		return s;
	}

	/**
	 * 정수인지 검사 Integer
	 * @param {Object} obj : 검사할 값
	 * @return {Boolean} 결과값 true: 정상, false: 오류
	 */
	public static boolean isInteger(Object obj) {
		try {
			Integer.parseInt(String.valueOf(obj).trim());
			return true;
		} catch(NumberFormatException e) {
			return false;
		}
	}

	/**
	 * 정수/소수 인지 검사 Double
	 * @param {Object} obj : 검사할 값
	 * @return {Boolean} 결과값 true: 정상, false: 오류
	 */
	public static boolean isDouble(Object obj) {
		try {
			Double.parseDouble(String.valueOf(obj).trim());
			return true;
		} catch(NumberFormatException e) {
			return false;
		}
	}

	/**
	 * 문자열 정수값의 앞자리 0 제거
	 * @param {Object} obj : 검사할 값
	 * @return {String} 앞자리 0 이 제거된 문자열정수
	 */
	public static String strInteger(Object obj) {
		try {
			int num = Integer.parseInt(String.valueOf(obj).trim());
			return String.valueOf(num);
		} catch(NumberFormatException e) {
			return String.valueOf(obj).trim();
		}
	}

	/**
	 * xml 파싱
	 * @param {String} url : 요청 url값
	 * @return {LDataMap} 파싱 return 값
	 */
	public static LDataMap parseXML(String strUrl) throws Exception{

		DocumentBuilderFactory factory = null;
		DocumentBuilder builder = null;
		Document doc = null;
		NodeList nList = null;

		LDataMap resultMap = new LDataMap();
		String rootTag = "";
		String resultFlag = "N";

		URL url = new URL(strUrl);
		BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
		StringBuffer sb = new StringBuffer();
		String tempStr = null;

		while(true) {
			tempStr = br.readLine();
			if(tempStr == null) break;
			sb.append(tempStr);
		}

		br.close();

		String strXml = sb.toString();

		factory = DocumentBuilderFactory.newInstance();
		builder = factory.newDocumentBuilder();
		InputStream is = new ByteArrayInputStream(strXml.getBytes("UTF-8"));
		doc = builder.parse(is);

		//최상위 태그 조회
		doc.getDocumentElement().normalize();
		rootTag = doc.getDocumentElement().getNodeName();

		//result 태그 list 생성
		if ("result".equals(rootTag)) { //정상 API RETURN 시(주소정제)
			nList = doc.getElementsByTagName("result");
		} else if("xsync".equals(rootTag)) { // 정상 API RETURN 시(택배접수, 택배접수 에러)
			nList = doc.getElementsByTagName("xsync");
		} else if("trace".equals(rootTag)) { // 정상 API RETURN 시(종추적 조회)
			nList = doc.getElementsByTagName("trace");
		} else if("error".equals(rootTag)){ // 에러
			nList = doc.getElementsByTagName("error");
		}

		if (nList != null) {
			for (int i=0; i<nList.getLength(); i++) {
				Node nd = nList.item(i);
				Element elmt = (Element) nd;

				//해당 태그의 하위 태그 value 조회
				if (nd.getNodeType() == Node.ELEMENT_NODE) {
					if ("result".equals(rootTag)) { // 주소정제 요청이 정상적으로 완료되었을 경우
						resultMap.put("arrCnpoNm", getTagValue("arrCnpoNm", elmt)); //도착집중국명
						resultMap.put("delivPoNm", getTagValue("delivPoNm", elmt)); //배달우체국명
						resultMap.put("delivAreaCd", getTagValue("delivAreaCd", elmt)); //집배코드

					} else if("xsync".equals(rootTag)) { //택배접수 요청이 정상적으로 완료 되었을 경우

						if(nd.getNodeType() == Node.ELEMENT_NODE) {	//하위 태그가 존재할 경우
							Node node = elmt.getFirstChild();
							String nodeName = node.getNodeName();

							if ("reqNo".equals(nodeName)) { // 하위 태그가 정상일 경우
								resultMap.put("reqNo", getTagValue("reqNo", elmt)); //우체국택배신청번호
								resultMap.put("resNo", getTagValue("resNo", elmt)); //예약번호
								resultMap.put("regiNo", getTagValue("regiNo", elmt)); //운송장번호
								resultMap.put("regiPoNm", getTagValue("regiPoNm", elmt)); //접수우체국
								resultMap.put("resDate", getTagValue("resDate", elmt)); //예약일시
								resultMap.put("price", getTagValue("price", elmt)); //예상접수요금
								resultMap.put("vTelNo", getTagValue("vTelNo", elmt)); //가상전화번호
								resultMap.put("arrCnpoNm", getTagValue("arrCnpoNm", elmt)); //도착집중국명
								resultMap.put("delivPoNm", getTagValue("delivPoNm", elmt)); //배달우체국명
								resultMap.put("delivAreaCd", getTagValue("delivAreaCd", elmt)); //배달구구분코드
							} else {
								resultFlag = "Y";
								resultMap.put("ERRORMSG",  "[" + getTagValue("error_code", elmt) + "] " + getTagValue("message", elmt));
							}
						}
					} else if ("trace".equals(rootTag)) { //배송추적이 정상적으로 완료 되었을 경우
						resultMap.put("TRACE_RCV_NM", getTagValue("signernm", elmt) + '-' + getTagValue("relationnm", elmt)); //수령인 + 관계

						//배송추적 제일 마지막 item 처리현황 확인
						NodeList itemList = doc.getElementsByTagName("item");
						Node itemNd = itemList.item(itemList.getLength() - 1);

						if (itemNd.getNodeType() == Node.ELEMENT_NODE) {
							Element itemElmt = (Element) itemNd;
							String strRcvNm = getTagValue("tracestatus", itemElmt);
							String strStatus = "";

							if ("집하완료".equals(strRcvNm) || "수거완료".equals(strRcvNm))
								strStatus = "00011"; //집하
							else if("발송".equals(strRcvNm))
								strStatus = "00012"; //발송
							else if("도착".equals(strRcvNm))
								strStatus = "00013"; //도착
							else if("배송준비".equals(strRcvNm) || "배달준비".equals(strRcvNm))
								strStatus = "00002"; //배송준비
							else if("배달완료".equals(strRcvNm))
								strStatus = "00003"; //배송완료

							resultMap.put("TRACE_CD", strStatus);
						}

					} else if("error".equals(rootTag)) { //에러일 경우
						resultFlag = "Y";
						resultMap.put("ERRORMSG",  "[" + getTagValue("error_code", elmt) + "] " + getTagValue("message", elmt));
					}
				}
			}
		}

		resultMap.put("resultFlag", resultFlag);
		return resultMap;
	}

	/**
	 * xml 파싱
	 * @param {String} url : 요청 url값
	 * @return {LDataMap} 파싱 return 값
	 */
	public static LDataMap parseXML2(String strUrl) throws Exception{

		DocumentBuilderFactory factory = null;
		DocumentBuilder builder = null;
		Document doc = null;
		NodeList nList = null;

		LDataMap resultMap = new LDataMap();
		String rootTag = "";
		String errorMsg = null;

		URL url = new URL(strUrl);
		BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
		StringBuffer sb = new StringBuffer();
		String tempStr = null;

		while(true) {
			tempStr = br.readLine();
			if(tempStr == null) break;
			sb.append(tempStr);
		}

		br.close();

		String strXml = sb.toString();

		factory = DocumentBuilderFactory.newInstance();
		builder = factory.newDocumentBuilder();
		InputStream is = new ByteArrayInputStream(strXml.getBytes("UTF-8"));
		doc = builder.parse(is);

		//최상위 태그 조회
		doc.getDocumentElement().normalize();
		rootTag = doc.getDocumentElement().getNodeName();

		// result 태그 list 생성
		if ("result".equals(rootTag)) { //정상 API RETURN 시(주소정제)
			nList = doc.getElementsByTagName("result");
		} else if("xsync".equals(rootTag)) { // 정상 API RETURN 시(택배접수, 택배접수 에러)
			nList = doc.getElementsByTagName("xsync");
		} else if("trace".equals(rootTag)) { // 정상 API RETURN 시(종추적 조회)
			nList = doc.getElementsByTagName("trace");
		} else if("error".equals(rootTag)){ // 에러
			nList = doc.getElementsByTagName("error");
		}

		if (nList != null) {
			for (int i=0; i<nList.getLength(); i++) {
				Node nd = nList.item(i);
				Element elmt = (Element) nd;

				// 해당 태그의 하위 태그 value 조회
				if (nd.getNodeType() == Node.ELEMENT_NODE) {
					if("result".equals(rootTag)) { // 주소정제 요청이 정상적으로 완료되었을 경우
						resultMap.put("arrCnpoNm", getTagValue("arrCnpoNm", elmt)); //도착집중국명
						resultMap.put("delivPoNm", getTagValue("delivPoNm", elmt)); //배달우체국명
						resultMap.put("delivAreaCd", getTagValue("delivAreaCd", elmt)); //집배코드

					} else if("xsync".equals(rootTag)) { //택배접수 요청이 정상적으로 완료 되었을 경우

						if (nd.getNodeType() == Node.ELEMENT_NODE) {	//하위 태그가 존재할 경우
							Node node = elmt.getFirstChild();
							String nodeName = node.getNodeName();

							if ("reqNo".equals(nodeName)){ // 하위 태그가 정상일 경우
								resultMap.put("reqNo", getTagValue("reqNo", elmt)); //우체국택배신청번호
								resultMap.put("resNo", getTagValue("resNo", elmt)); //예약번호
								resultMap.put("regiNo", getTagValue("regiNo", elmt)); //운송장번호
								resultMap.put("regiPoNm", getTagValue("regiPoNm", elmt)); //접수우체국
								resultMap.put("resDate", getTagValue("resDate", elmt)); //예약일시
								resultMap.put("price", getTagValue("price", elmt)); //예상접수요금
								resultMap.put("vTelNo", getTagValue("vTelNo", elmt)); //가상전화번호
								resultMap.put("arrCnpoNm", getTagValue("arrCnpoNm", elmt)); //도착집중국명
								resultMap.put("delivPoNm", getTagValue("delivPoNm", elmt)); //배달우체국명
								resultMap.put("delivAreaCd", getTagValue("delivAreaCd", elmt)); //배달구구분코드
							} else {
								errorMsg = getTagValue("error_code", elmt) + getTagValue("message", elmt);
								throw new LingoException(errorMsg);
							}
						}
					} else if("trace".equals(rootTag)) { //배송추적이 정상적으로 완료 되었을 경우
						resultMap.put("TRACE_RCV_NM", getTagValue("signernm", elmt) + '-' + getTagValue("relationnm", elmt)); //수령인 + 관계

						// 배송추적 제일 마지막 item 처리현황 확인
						NodeList itemList = doc.getElementsByTagName("item");

						Node itemNd = itemList.item(itemList.getLength() - 1);

						if (itemNd.getNodeType() == Node.ELEMENT_NODE) {
							Element itemElmt = (Element) itemNd;
							String strRcvNm = getTagValue("tracestatus", itemElmt);
							String strStatus = "";

							if ("집하완료".equals(strRcvNm) || "수거완료".equals(strRcvNm))
								strStatus = "00011"; //집하
							else if("발송".equals(strRcvNm))
								strStatus = "00012"; //발송
							else if("도착".equals(strRcvNm))
								strStatus = "00013"; //도착
							else if("배송준비".equals(strRcvNm) || "배달준비".equals(strRcvNm))
								strStatus = "00002"; //배송준비
							else if("배달완료".equals(strRcvNm))
								strStatus = "00003"; //배송완료

							resultMap.put("TRACE_CD", strStatus);
							//resultMap.put("TRACE_RCV_NM", strRcvNm);
						}
					} else if("error".equals(rootTag)) { //에러일 경우
						errorMsg = getTagValue("error_code", elmt) + getTagValue("message", elmt);
						throw new LingoException(errorMsg);
					}
				}
			}
		}

		return resultMap;
	}

	/**
	 * 태그 value 가져오기
	 * @param {String} tag : 검사할 값
	 * @param {Element} element : 검사할 값
	 * @return {String} value
	 */
	public static String getTagValue(String tag, Element element) throws Exception{
		NodeList nodeList = null;
		Node value = null;

		String nodeValue = "";

		nodeList = element.getElementsByTagName(tag).item(0).getChildNodes();
		value = nodeList.item(0);

		if(value == null) {
			nodeValue = "";
		}else {
			nodeValue = value.getNodeValue();
		}

		//nodeValue = (value.getNodeValue().equals(null) || value.getNodeValue().equals("")) ? "" : value.getNodeValue();

		return nodeValue;

	}

	/**
`	 * 날짜시간비교
`	 * @param oldDate
`	 * @return
`	 */
	public static long getDiffTime(Date oldDate) {

		long startTime=oldDate.getTime();

		// 현재의 시간 설정
		Calendar cal=Calendar.getInstance();
		Date endDate=cal.getTime();
		long endTime=endDate.getTime();
		long mills=endTime-startTime;

		// 분으로 변환
		long min=mills/60000;

		return min;
	}

	/**
	 * 공백문자제거
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public static String getStrTrim(String str) throws Exception {
		String returnStr = "";
		if (!Util.isEmpty(str)) {
			str = str.trim();
			returnStr = str.replaceAll("\\s+","").replaceAll("(^\\p{Z}+|\\p{Z}+$)", "");
		} else {
			returnStr = str;
		}

		return returnStr;
	}
}