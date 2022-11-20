package xrt.interfaces.shopee;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Hex;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class Shopee {

	Logger logger = LoggerFactory.getLogger(Shopee.class);

	private static final String HMAC_SHA256_ALGORITHM = "HmacSHA256";
	private static final String CHAR_SET = "UTF-8";

	private static String TEST_API_URL = "https://partner.uat.shopeemobile.com/api/v1/";
	private static String REAL_API_URL = "https://partner.shopeemobile.com/api/v1/";

	public static String encode(String key, String data) throws Exception {
		Mac sha256_HMAC = Mac.getInstance(HMAC_SHA256_ALGORITHM);
		SecretKeySpec secret_key = new SecretKeySpec(key.getBytes(CHAR_SET), HMAC_SHA256_ALGORITHM);
		sha256_HMAC.init(secret_key);

		return Hex.encodeHexString(sha256_HMAC.doFinal(data.getBytes(CHAR_SET)));
	}

	/**
	 * Shopee API 헤더생성
	 *
	 * @param queryString
	 * @param authKey
	 * @param httpMethod
	 * @return HttpURLConnection
	 * @throws Exception
	 */
	public HttpURLConnection createHeader(String queryString, String authKey, String httpMethod) throws Exception {

		String httpURL = REAL_API_URL + queryString;

		// 1. AfterShip API를 통신하기전에 httpURLConnection 을 생성
		HttpURLConnection retURL = (HttpURLConnection) new URL(httpURL).openConnection();
		retURL.setRequestMethod(httpMethod);
		retURL.setRequestProperty("Content-Type", "application/json");
		retURL.setRequestProperty("Authorization", authKey);
		retURL.setDoOutput(true);

		return retURL;
	}

	/**
	 * Shopee API Body 설정 및  Server에 전송
	 *
	 * @param conn
	 * @param sendData
	 * @return JSONObject
	 * @throws Exception
	 */
	public JSONObject sendData(HttpURLConnection conn, String sendData) throws Exception {

		conn.connect();

		// 1. 데이터 발송
		OutputStreamWriter outputStreamWriter = new OutputStreamWriter(conn.getOutputStream());
		outputStreamWriter.write(sendData);
		outputStreamWriter.flush();
		// 2. 응답 받은 데이터 저장
		StringBuilder sb = new StringBuilder();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));

		String readLine;
		while ((readLine = bufferedReader.readLine()) != null) {
			sb.append(readLine).append("\n");
			logger.debug("sendData : " + sb.toString());
		}

		bufferedReader.close();
		JSONParser jsonParser = new JSONParser();
		Object object = jsonParser.parse(sb.toString());
		JSONObject retJson = (JSONObject) object;
		return retJson;
	}

	public Map<String, Object> getOrdersList(Map<String, Object> paramMap) {
		logger.debug("paramMap : "+ paramMap.toString());

		JSONArray totalList = new JSONArray();
		String shopId = (String) paramMap.get("shopId");
		String partnerId = (String) paramMap.get("partnerId");
		String partnerKey = (String) paramMap.get("partnerKey");
		String startDate = paramMap.get("toDate") + " 00:00:00";
		String endDate = paramMap.get("fromDate") + " 23:59:59";
		String queryString = "orders/basics";
		int count = Integer.parseInt(paramMap.get("count").toString());
		int forCount = count/100;

		try {

			long startTimestamp = 0;
			long endTimestamp = 0;
			int paginationEntriesPerPage = 100;

			for (int i=0; i<forCount; i++) {

				int paginationOffset = (i == 0 ? 1:i*100+1);

				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				startTimestamp = transFormat.parse(startDate).getTime() / 1000;
				endTimestamp = transFormat.parse(endDate).getTime() / 1000;
				Date currentDate = new Date();
				long cunrrentTimestamp = currentDate.getTime() / 1000;

				String jsonData = "{\"create_time_from\":" + startTimestamp + ",\"create_time_to\":" + endTimestamp + ",\"pagination_entries_per_page\":"
						+ paginationEntriesPerPage + ",\"pagination_offset\":" + paginationOffset + ",\"partner_id\":" + partnerId + ",\"shopid\":"
						+ shopId + ",\"timestamp\":" + cunrrentTimestamp + "}";
				String baseString = REAL_API_URL + queryString + "|" + jsonData;

				String authKey = encode(partnerKey, baseString);

				HttpURLConnection conn = this.createHeader(queryString, authKey, "POST");
				JSONObject resJson = this.sendData(conn, jsonData);

				if (resJson.toString().indexOf("error") > 0) {
					Map<String, Object> retMap = new HashMap<>();
					logger.info("error msg : "+ resJson.get("msg").toString());
					Object msg = resJson.get("error").toString();
					retMap.put("code", "501");
					retMap.put("message", msg);
					retMap.put("data", "");
					return retMap;
				}

				JSONParser jsonParser = new JSONParser();
				Object oOrders = jsonParser.parse(resJson.get("orders").toString());
				JSONArray jOrders = (JSONArray) oOrders;
				logger.debug("jOrders : "+ jOrders);
				totalList.addAll(jOrders);
			}

			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "200");
			retMap.put("message", "정상적으로 처리되었습니다.");
			retMap.put("data", totalList);
			return retMap;
		} catch (Exception e) {
			logger.error("e : "+ e.fillInStackTrace());
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "500");
			retMap.put("message", e.getMessage());
			retMap.put("data", "");
			return retMap;
		}
	}

	public Map<String, Object> getOrderDetails(Map<String, Object> paramMap) {

		List<Map<String, Object>> orderList = (List<Map<String, Object>>) paramMap.get("data");
		String shopId = (String) paramMap.get("shopId");
		String partnerId = (String) paramMap.get("partnerId");
		String partnerKey = (String) paramMap.get("partnerKey");
		String queryString = "orders/detail";

		Date currentDate = new Date();
		long cunrrentTimestamp = currentDate.getTime() / 1000;

		try {
			String ordersnList;

			JSONArray jOrderList = new JSONArray();
			JSONArray jErrorList = new JSONArray();
			for (Map<String, Object> ordersn : orderList) {
				ordersnList = ordersn.get("ordersn").toString();

				String jsonData = "{\"ordersn_list\":[\""+ ordersnList  +"\"],\"partner_id\":"+ partnerId +",\"shopid\":" + shopId + ",\"timestamp\":"+ cunrrentTimestamp +"}";
				String baseString = REAL_API_URL + queryString + "|" + jsonData;

				String authKey = encode(partnerKey, baseString);

				HttpURLConnection conn = this.createHeader(queryString, authKey, "POST");
				JSONObject resJson = this.sendData(conn, jsonData);

				JSONParser jsonParser = new JSONParser();
				Object oErrors = jsonParser.parse(resJson.get("errors").toString());
				JSONArray jErrors = (JSONArray) oErrors;
				Object oOrders = jsonParser.parse(resJson.get("orders").toString());
				JSONArray jOrders = (JSONArray) oOrders;
				jOrderList.addAll(jOrders);
				jErrorList.addAll(jErrors);
			}

			Map<String, Object> dataMap = new HashMap<>();
			dataMap.put("errors", jErrorList);
			dataMap.put("orders", jOrderList);

			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "200");
			retMap.put("message", "정상적으로 처리되었습니다.");
			retMap.put("data", dataMap);
			return retMap;
		} catch (Exception e) {
			logger.error("error : "+ e.fillInStackTrace());
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "500");
			retMap.put("message", e.getMessage());
			retMap.put("data", "");
			return retMap;
		}
	}

	public static void main(String[] args) {

	}
}
