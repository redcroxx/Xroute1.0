package xrt.interfaces.qxpress;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import xrt.interfaces.qxpress.vo.QxpressVo;

@Service
public class QxpressAPI {

	Logger logger = LoggerFactory.getLogger(QxpressAPI.class);

	@Value("#{config['c.qxpressURL']}")
	private String qxpressURL;

	@Value("#{config['c.qxpressCustNo']}")
	private String qxpressCustNo;

	@Value("#{config['c.qxpressSmartApiURL']}")
	private String qxpressSmartApiURL;

	@Value("#{config['c.qxpressSmartShipID']}")
	private String qxpressSmartShipID;

	@Value("#{config['c.qxpressSmartShipApiKey']}")
	private String qxpressSmartShipApiKey;

	private HttpURLConnection createHeader(String queryString) throws Exception  {
		logger.debug("[createHeader] queryString : "+ queryString);

		String httpURL = qxpressSmartApiURL + queryString;

		// 1. AfterShip API를 통신하기전에 httpURLConnection 을 생성
		HttpURLConnection retURL = (HttpURLConnection) new URL(httpURL).openConnection();
		retURL.setRequestMethod("GET");
		retURL.setDoOutput(true);
		return retURL;
	}

	/**
	 *
	 */
	private HttpURLConnection createHeader(String queryString, String httpMethod) throws Exception  {
		logger.debug("[createHeader] queryString : "+ queryString +", httpMethod : "+ httpMethod);

		String httpURL = qxpressURL + queryString;

		// 1. AfterShip API를 통신하기전에 httpURLConnection 을 생성
		HttpURLConnection retURL = (HttpURLConnection) new URL(httpURL).openConnection();
		retURL.setRequestMethod(httpMethod);
		retURL.setRequestProperty("Content-Type", "application/json;charset=utf-8");
		retURL.setDoOutput(true);

		return retURL;
	}

	private HttpURLConnection createHeader(String queryString, String httpMethod, String partnerKey) throws Exception  {
		logger.debug("[createHeader] queryString : "+ queryString +", httpMethod : "+ httpMethod +", partnerKey : "+ partnerKey);

		String httpURL = qxpressURL + queryString.replaceAll(" ", "");

		// 1. AfterShip API를 통신하기전에 httpURLConnection 을 생성
		HttpURLConnection retURL = (HttpURLConnection) new URL(httpURL).openConnection();
		retURL.setRequestMethod(httpMethod);
		retURL.setRequestProperty("Content-Type", "application/json;charset=utf-8");
		retURL.setRequestProperty("Authorization", "Bearer "+ partnerKey);
		retURL.setDoOutput(true);
		return retURL;
	}

	/**
	 *
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	private JSONObject sendData(HttpURLConnection conn) throws Exception  {
		logger.debug("[sendData] conn : "+ conn);

		conn.connect();

		// 1. 응답 받은 데이터 저장
		StringBuilder sb = new StringBuilder();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));

		String readLine;
		while ((readLine = bufferedReader.readLine()) != null) {
			sb.append(readLine).append("\n");
		}

		bufferedReader.close();
		JSONParser jsonParser = new JSONParser();
		Object object = jsonParser.parse(sb.toString());
		JSONObject  retJson = (JSONObject) object;

		logger.debug("[sendData] retJson : "+ retJson);

		return retJson;
	}

	/**
	 * @param conn
	 * @param sendData
	 * @return
	 * @throws Exception
	 */
	private JSONObject sendData(HttpURLConnection conn, StringBuffer sendData) {
		logger.debug("[sendData] conn : "+ conn +", sendData : "+ sendData);

		try {
			logger.debug("01. getShippingInfo API 요청");
			conn.connect();

			String encodeSendData = new String(sendData.toString().getBytes("8859_1"), StandardCharsets.UTF_8);
			// URLEncoder.encode(sendData.toString(), "UTF-8");

			// 1. 데이터 발송
			OutputStreamWriter outputStreamWriter = new OutputStreamWriter(conn.getOutputStream(), StandardCharsets.UTF_8);
			outputStreamWriter.write(encodeSendData);
			outputStreamWriter.flush();

			// 2. 응답 받은 데이터 저장
			StringBuilder sb = new StringBuilder();
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));

			String readLine;
			while ((readLine = bufferedReader.readLine()) != null) {
				sb.append(readLine).append("\n");
				logger.debug("[sendData] readLine : "+ sb.toString());
			}

			bufferedReader.close();
			JSONParser jsonParser = new JSONParser();
			Object object = jsonParser.parse(sb.toString());
			JSONObject  retJson = (JSONObject) object;

			return retJson;
		} catch (Exception e) {
			logger.error("[sendData] Exception : "+ e.fillInStackTrace());
			JSONObject  retJson = new JSONObject();;
			return retJson;
		}
	}

	private Map<String, Object> RequestAccessToken() {

		Map<String, Object> retMap = new HashMap<>();

		String queryString = "NonQ10Order/RequestAccessToken?CustNo="+ qxpressCustNo;
		String httpMethond = "GET";

		try {
			HttpURLConnection conn = this.createHeader(queryString, httpMethond);
			JSONObject resJson = this.sendData(conn);

			logger.debug("[RequestAccessToken] resJson : "+ resJson);

			JSONParser jsonParser = new JSONParser();
			Object oBody = jsonParser.parse(resJson.get("body").toString());
			logger.debug("[RequestAccessToken] oBody : "+ oBody.toString());
			Map<String, Object> bodyMap = new ObjectMapper().readValue(resJson.get("body").toString(), Map.class);
			logger.debug("[RequestAccessToken] bodyMap : "+ bodyMap.toString());

			retMap.put("partnerKey", bodyMap.get("partnerKey"));
			retMap.put("code", "200");
			retMap.put("message", "정상적으로 성공하였습니다.");
			return retMap;
		} catch (Exception e) {
			logger.error("[RequestAccessToken] Exception : "+ e.fillInStackTrace());
			retMap.put("partnerKey", "");
			retMap.put("code", "500");
			retMap.put("message", e.getMessage());
			return retMap;
		}
	}

	public Map<String, Object> createOrder(List<QxpressVo> qxpressVos) {
		logger.debug("[createOrder] qxpressVos.size : "+ qxpressVos.size());

		try {
			logger.debug(" 01. RequestAccessToken 호출");
			Map<String, Object> tokenMap = this.RequestAccessToken();

			String partnerKey = (String) tokenMap.get("partnerKey");
			logger.debug(" 02. CreateOrder 데이터 생성");
			StringBuffer sb = new StringBuffer();
			sb.append("[");
			int count = 1;
			for (QxpressVo qxpressVo : qxpressVos) {
				sb.append("{");
				sb.append("\"RCVNM\": \""+ qxpressVo.getRcvnm() +"\",");
				sb.append("\"HP_NO\": \""+ qxpressVo.getHpNo() +"\",");
				sb.append("\"DEL_FRONTADDRESS\": \""+ qxpressVo.getDelFrontaddress() +"\",");
				sb.append("\"DEL_BACKADDRESS\": \""+ qxpressVo.getDelBackaddress() +"\",");
				sb.append("\"DPC3REFNO1\": \""+ qxpressVo.getDpc3refno1() +"\",");
				sb.append("\"RCVNM_HURI\": \"\",");
				sb.append("\"TEL_NO\": \""+ qxpressVo.getTelNo() +"\",");
				sb.append("\"ZIP_CODE\": \""+ qxpressVo.getZipCode() +"\",");
				sb.append("\"BUY_CUSTEMAIL\": \""+ qxpressVo.getBuyCustemail() +"\",");
				sb.append("\"DELIVERY_NATIONCD\": \""+ qxpressVo.getDeliveryNationcd() +"\",");
				sb.append("\"DELIVERY_OPTION_CODE\": \"\",");
				sb.append("\"SELL_CUSTNM\": \""+ qxpressVo.getSellCustnm() +"\",");
				sb.append("\"START_NATIONCD\": \""+ qxpressVo.getStartNationcd() +"\",");
				sb.append("\"REMARK\": \""+ qxpressVo.getRemark() +"\",");
				sb.append("\"ITEM_NM\": \""+ qxpressVo.getItemNm() +"\",");
				sb.append("\"QTY\": \""+ qxpressVo.getQty() +"\",");
				sb.append("\"PURCHAS_AMT\": \""+ qxpressVo.getPurchasAmt() +"\",");
				sb.append("\"CURRENCY\": \""+ qxpressVo.getCurrency() +"\"");
				if (qxpressVos.size() == count) {
					sb.append("}");
				} else {
					sb.append("},");
				}
				count++;
			}
			sb.append("]");

			String queryString = "NonQ10Order/CreateOrder?order="+ sb;
			String httpMethond = "POST";
			logger.debug(" 03. CreateOrder 호출");
			HttpURLConnection conn = this.createHeader(queryString, httpMethond, partnerKey);
			JSONObject resJson = this.sendData(conn, sb);

			logger.debug(" resJson : "+ resJson);
			if (!resJson.isEmpty()) {
				JSONParser jsonParser = new JSONParser();
				// Map<String, Object> Data = new ObjectMapper().readValue(resJson.get("Data").toString(), Map.class);
				Object oData = jsonParser.parse(resJson.get("Data").toString());
				logger.debug(" oData : "+ oData.toString());
				JSONObject jData = (JSONObject) oData;
				Object oList = jsonParser.parse(jData.get("bundleList").toString());
				logger.debug(" oList : "+ oList.toString());
				JSONArray jList = (JSONArray) oList;

				Map<String, Object> retMap = new HashMap<>();
				retMap.put("data", jList);
				retMap.put("code", "200");
				retMap.put("message", "정상적으로 성공하였습니다.");
				return retMap;
			} else {
				Map<String, Object> retMap = new HashMap<>();
				retMap.put("data", new JSONArray());
				retMap.put("code", "404");
				retMap.put("message", "응답 데이터 없습니다.");
				return retMap;
			}

		} catch (Exception e) {
			logger.error("[createOrder] Exception : "+ e.fillInStackTrace());
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "500");
			retMap.put("message", e.getMessage());
			return retMap;
		}
	}

	public Map<String, Object> createOrder(QxpressVo qxpressVo) {
		logger.debug("[createOrder] qxpressVo : "+ qxpressVo.toString());

		logger.debug(" 01. RequestAccessToken 호출");
		Map<String, Object> tokenMap = this.RequestAccessToken();

		String partnerKey = (String) tokenMap.get("partnerKey");

		try {
			logger.debug(" 02. CreateOrder 데이터 생성");
			StringBuffer sb = new StringBuffer();
			sb.append("[{");
			sb.append("\"RCVNM\": \""+ qxpressVo.getRcvnm() +"\",");
			sb.append("\"HP_NO\": \""+ qxpressVo.getHpNo() +"\",");
			sb.append("\"DEL_FRONTADDRESS\": \""+ qxpressVo.getDelFrontaddress() +"\",");
			sb.append("\"DEL_BACKADDRESS\": \""+ qxpressVo.getDelBackaddress() +"\",");
			sb.append("\"DPC3REFNO1\": \""+ qxpressVo.getDpc3refno1() +"\",");
			sb.append("\"RCVNM_HURI\": \"\",");
			sb.append("\"TEL_NO\": \""+ qxpressVo.getTelNo() +"\",");
			sb.append("\"ZIP_CODE\": \""+ qxpressVo.getZipCode() +"\",");
			sb.append("\"BUY_CUSTEMAIL\": \""+ qxpressVo.getBuyCustemail() +"\",");
			sb.append("\"DELIVERY_NATIONCD\": \""+ qxpressVo.getDeliveryNationcd() +"\",");
			sb.append("\"DELIVERY_OPTION_CODE\": \"\",");
			sb.append("\"SELL_CUSTNM\": \""+ qxpressVo.getSellCustnm() +"\",");
			sb.append("\"START_NATIONCD\": \""+ qxpressVo.getStartNationcd() +"\",");
			sb.append("\"REMARK\": \""+ qxpressVo.getRemark() +"\",");
			sb.append("\"ITEM_NM\": \""+ qxpressVo.getItemNm() +"\",");
			sb.append("\"QTY\": \""+ qxpressVo.getQty() +"\",");
			sb.append("\"PURCHAS_AMT\": \""+ qxpressVo.getPurchasAmt() +"\",");
			sb.append("\"CURRENCY\": \""+ qxpressVo.getCurrency() +"\"");
			sb.append("}]");

			String queryString = "NonQ10Order/CreateOrder?order="+ sb;
			String httpMethond = "POST";
			logger.debug(" 03. CreateOrder 호출");
			HttpURLConnection conn = this.createHeader(queryString, httpMethond, partnerKey);
			JSONObject resJson = this.sendData(conn, sb);

			logger.debug(" resJson : "+ resJson);
			JSONParser jsonParser = new JSONParser();
			// Map<String, Object> Data = new ObjectMapper().readValue(resJson.get("Data").toString(), Map.class);
			Object oData = jsonParser.parse(resJson.get("Data").toString());
			logger.debug(" oData : "+ oData.toString());
			JSONObject jData = (JSONObject) oData;
			Object oList = jsonParser.parse(jData.get("bundleList").toString());
			logger.debug(" oList : "+ oList.toString());
			JSONArray jList = (JSONArray) oList;

			Map<String, Object> retMap = new HashMap<>();
			retMap.put("data", jList);
			retMap.put("code", "200");
			retMap.put("message", "정상적으로 성공하였습니다.");
			return retMap;
		} catch (Exception e) {
			logger.error("[createOrder] Exception : "+ e.fillInStackTrace());
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "500");
			retMap.put("message", e.getMessage());
			return retMap;
		}
	}

	public Map<String, Object> multiOrderCreate(QxpressVo qxpressVo) {
		logger.debug("[MultiOrderCreate] qxpressVo : "+ qxpressVo.toString());


		logger.debug(" 01. RequestAccessToken 호출");
		Map<String, Object> tokenMap = this.RequestAccessToken();

		String partnerKey = (String) tokenMap.get("partnerKey");

		try {
			logger.debug(" 02. MultiOrderCreate 데이터 생성");
			StringBuffer sb = new StringBuffer();
			sb.append("[{");
			//
			sb.append("\"RCVNM\": \""+ qxpressVo.getRcvnm() +"\",");
			sb.append("\"RCVNM_HURI\": \""+ qxpressVo.getRcvnmHuri() +"\",");
			sb.append("\"HP_NO\": \""+ qxpressVo.getHpNo() +"\",");
			sb.append("\"TEL_NO\": \""+ qxpressVo.getTelNo() +"\",");
			sb.append("\"ZIP_CODE\": \""+ qxpressVo.getZipCode() +"\",");
			sb.append("\"DEL_FRONTADDRESS\": \""+ qxpressVo.getDelFrontaddress() +"\",");
			sb.append("\"DEL_BACKADDRESS\": \""+ qxpressVo.getDelBackaddress() +"\",");
			sb.append("\"BUY_CUSTEMAIL\": \""+ qxpressVo.getBuyCustemail() +"\",");
			sb.append("\"DELIVERY_NATIONCD\": \""+ qxpressVo.getDeliveryNationcd() +"\",");
			sb.append("\"DELIVERY_OPTION_CODE\": \""+ qxpressVo.getDeliveryOptionCode() +"\",");
			sb.append("\"SELL_CUSTNM\": \""+ qxpressVo.getSellCustnm() +"\",");
			sb.append("\"REMARK\": \""+ qxpressVo.getRemark() +"\",");
			sb.append("\"RCVID\": \""+ qxpressVo.getRcvid() +"\",");
			sb.append("\"RCVID_PATH\": \""+ qxpressVo.getRcvidPath() +"\",");
			sb.append("\"DPC3REFNO1\": \""+ qxpressVo.getDpc3refno1() +"\",");
			// 발송지 정보
			sb.append("\"START_NATIONCD\": \""+ qxpressVo.getStartNationcd() +"\",");
			sb.append("\"OG_SELNM\": \""+ qxpressVo.getOgSellnm() +"\",");
			sb.append("\"OG_HP_NO\": \""+ qxpressVo.getOgHpNo() +"\",");
			sb.append("\"OG_TEL_NO\": \""+ qxpressVo.getOgTelNo() +"\",");
			sb.append("\"OG_ZIP_CODE\": \""+ qxpressVo.getOgZipCode() +"\",");
			sb.append("\"OG_DEP_FRONTADDRESS\": \""+ qxpressVo.getOgDepFrontaddress() +"\",");
			sb.append("\"OG_DEP_BACKADDRESS\": \""+ qxpressVo.getOgDepBackaddress() +"\",");
			sb.append("\"OG_DEP_SELMAIL\": \""+ qxpressVo.getOgDepSelMail() +"\",");
			// 정식 수출신고 신청 정보
			sb.append("\"EXP_NM_KR\": \""+ qxpressVo.getExpNmKr() +"\",");
			sb.append("\"EXP_NM_EN\": \""+ qxpressVo.getExpNmEn() +"\",");
			sb.append("\"EXP_NM_BIZ\": \""+ qxpressVo.getExpNmBiz() +"\",");
			sb.append("\"EXP_NO_BIZ\": \""+ qxpressVo.getExpNoBiz() +"\",");
			sb.append("\"EXP_CL\": \""+ qxpressVo.getExpCl() +"\",");
			sb.append("\"EXP_BIZ_POST\": \""+ qxpressVo.getExpBizPost() +"\",");
			sb.append("\"EXP_BIZ_ADD1\": \""+ qxpressVo.getExpBizAdd1() +"\",");
			sb.append("\"EXP_BIZ_ADD1_EN\": \""+ qxpressVo.getExpBizAdd1En() +"\",");
			sb.append("\"EXP_BIZ_ADD2\": \""+ qxpressVo.getExpBizAdd2() +"\",");
			sb.append("\"EXP_BIZ_ADD2_EN\": \""+ qxpressVo.getExpBizAdd2En() +"\",");
			// 상품정보
			sb.append("\"ITEM_NM\": \""+ qxpressVo.getItemNm() +"\",");
			sb.append("\"QTY\": \""+ qxpressVo.getQty() +"\",");
			sb.append("\"HSCD\": \""+ qxpressVo.getHscd() +"\",");
			sb.append("\"BD\": \""+ qxpressVo.getBd() +"\",");
			sb.append("\"MF\": \""+ qxpressVo.getMf() +"\",");
			sb.append("\"ME\": \""+ qxpressVo.getMe() +"\",");
			sb.append("\"MD\": \""+ qxpressVo.getMd() +"\",");
			sb.append("\"PG\": \""+ qxpressVo.getPg() +"\",");
			//
			sb.append("\"PURCHAS_AMT\": \""+ qxpressVo.getPurchasAmt() +"\",");
			sb.append("\"CURRENCY\": \""+ qxpressVo.getCurrency() +"\",");
			sb.append("\"URL_E\": \""+ qxpressVo.getUrlE() +"\",");
			sb.append("\"URL_P\": \""+ qxpressVo.getUrlP() +"\",");
			sb.append("\"TAX_CG\": \""+ qxpressVo.getTaxCg() +"\",");
			sb.append("\"INS\": \""+ qxpressVo.getIns() +"\",");
			sb.append("\"DPA\": \""+ qxpressVo.getDpa()+"\"");
			sb.append("}]");

			String queryString = "NonQ10Order/CreateMultiOrder?order="+ sb;
			String httpMethond = "POST";
			logger.debug(" 03. MultiOrderCreate 호출");
			HttpURLConnection conn = this.createHeader(queryString, httpMethond, partnerKey);
			JSONObject resJson = this.sendData(conn, sb);

			logger.debug(" resJson : "+ resJson);
			JSONParser jsonParser = new JSONParser();
			// Map<String, Object> Data = new ObjectMapper().readValue(resJson.get("Data").toString(), Map.class);
			Object oData = jsonParser.parse(resJson.get("Data").toString());
			logger.debug(" oData : "+ oData.toString());
			JSONObject jData = (JSONObject) oData;
			Object oList = jsonParser.parse(jData.get("bundleList").toString());
			logger.debug(" oList : "+ oList.toString());
			JSONArray jList = (JSONArray) oList;

			Map<String, Object> retMap = new HashMap<>();
			retMap.put("data", jList);
			retMap.put("code", "200");
			retMap.put("message", "정상적으로 성공하였습니다.");
			return retMap;
		} catch (Exception e) {
			logger.error("[MultiOrderCreate] Exception : "+ e.fillInStackTrace());
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "500");
			retMap.put("message", e.getMessage());
			return retMap;
		}

	}

	public Map<String, Object> getShippingInfo(QxpressVo qxpressVo) {
		logger.debug("[getShippingInfo] qxpressVo : "+ qxpressVo.toString());

		try {
			logger.debug("01. getShippingInfo API 요청");

			String queryString = "GMKT.INC.GLPS.OpenApiService/Giosis.qapi?key=&v=1.0&returnType=json&method=ShipmentOuterService.GetShippingInfo&apiKey="+ qxpressSmartShipApiKey +"&accountId="+ qxpressSmartShipID +"&tracking_no="+ qxpressVo.getDpc3refno1();
			HttpURLConnection conn = this.createHeader(queryString);
			JSONObject resJson = this.sendData(conn);

			logger.debug("resJson : "+ resJson);
			JSONParser jsonParser = new JSONParser();
			// Map<String, Object> Data = new ObjectMapper().readValue(resJson.get("Data").toString(), Map.class);

			Object oResultCode = jsonParser.parse(resJson.get("ResultCode").toString());
			logger.debug("oResultCode : "+ oResultCode.toString());
			Long resultCode = (Long) oResultCode;

			logger.debug("resultCode : "+ resultCode);

			Object oResultObject = jsonParser.parse(resJson.get("ResultObject").toString());
			logger.debug("oResultObject : "+ oResultObject.toString());
			JSONObject jResultObject = (JSONObject) oResultObject;

			Map<String, Object> retMap = new HashMap<>();
			retMap.put("data", jResultObject);
			retMap.put("code", "200");
			retMap.put("message", "정상적으로 성공하였습니다.");
			return retMap;
		} catch (Exception e) {
			logger.error("[getShippingInfo] Exception : "+ e.fillInStackTrace());
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "500");
			retMap.put("message", e.getMessage());
			return retMap;
		}
	}

	public Map<String, Object> getTracking(QxpressVo qxpressVo) {
		logger.debug("[getTracking] qxpressVo : "+ qxpressVo.toString());

		try {
			logger.debug("01. getTracking API 요청");

			String queryString = "GMKT.INC.GLPS.OpenApiService/DeliveryService.qapi/Tracking?returnType=json&tracking_no="+ qxpressVo.getDpc3refno1();
			HttpURLConnection conn = this.createHeader(queryString);
			JSONObject resJson = this.sendData(conn);

			logger.debug("resJson : "+ resJson);
			JSONParser jsonParser = new JSONParser();
			// Map<String, Object> Data = new ObjectMapper().readValue(resJson.get("Data").toString(), Map.class);
			Object oData = jsonParser.parse(resJson.get("ResultObject").toString());
			logger.debug("oData : "+ oData.toString());
			JSONObject jData = (JSONObject) oData;

			if (jData.get("Tracking_History") == null) {

				Map<String, Object> retMap = new HashMap<>();
				retMap.put("data", "");
				retMap.put("code", "404");
				retMap.put("message", "Tracking_History 정보가 없습니다.");
				return retMap;
			} else {
				Object oHistory = jsonParser.parse(jData.get("Tracking_History").toString());
				JSONArray jHsitory =(JSONArray) oHistory;
				logger.debug("jHsitory : "+ jHsitory.toString());

				Map<String, Object> retMap = new HashMap<>();
				retMap.put("data", jHsitory);
				retMap.put("code", "200");
				retMap.put("message", "정상적으로 성공하였습니다.");
				return retMap;
			}
		} catch (Exception e) {
			logger.error("[getTracking] Exception : "+ e.fillInStackTrace());
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "500");
			retMap.put("message", e.getMessage());
			return retMap;
		}
	}
}
