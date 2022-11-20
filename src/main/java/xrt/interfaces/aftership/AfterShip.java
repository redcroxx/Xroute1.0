package xrt.interfaces.aftership;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import xrt.interfaces.aftership.vo.AfterShipVo;

@Service
public class AfterShip {

	Logger logger = LoggerFactory.getLogger(AfterShip.class);

	private static final String AFTER_SHIP_API_URL = "https://api.aftership.com/v4/";
	private static final String AFTER_SHIP_API = "65e5d333-c4fc-4bd7-b3d0-835796773e50";

	/**
	 * AfterShip API 헤더생성
	 * @param queryString
	 * @param httpMethod
	 * @return
	 * @throws Exception
	 */
	public HttpURLConnection createHeader(String queryString, String httpMethod) throws Exception  {

		String httpURL = AFTER_SHIP_API_URL + queryString;

		// 1. AfterShip API를 통신하기전에 httpURLConnection 을 생성
		HttpURLConnection retURL = (HttpURLConnection) new URL(httpURL).openConnection();
		retURL.setRequestMethod(httpMethod);
		retURL.setRequestProperty("aftership-api-key", AFTER_SHIP_API);
		retURL.setRequestProperty("Content-Type", "application/json");
		retURL.setDoOutput(true);

		return retURL;
	}

	/**
	 * AfterShip API Body 설정 및 AfterShip Server에 전송
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public JSONObject sendData(HttpURLConnection conn) throws Exception  {

		conn.connect();

		// 1. 응답 받은 데이터 저장
		StringBuilder sb = new StringBuilder();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		String readLine;
		while ((readLine = bufferedReader.readLine()) != null) {
			sb.append(readLine).append("\n");
		}

		bufferedReader.close();
		JSONParser jsonParser = new JSONParser();
		Object object = jsonParser.parse(sb.toString());
		JSONObject  retJson = (JSONObject) object;
		return retJson;
	}

	/**
	 * AfterShip API Body 설정 및 AfterShip Server에 전송
	 * @param conn
	 * @param sendData
	 * @return
	 * @throws Exception
	 */
	public JSONObject sendData(HttpURLConnection conn, StringBuffer sendData) throws Exception  {

		logger.debug(" sendData Start ==> ");

		conn.connect();
		// 1. 데이터 발송
		OutputStreamWriter outputStreamWriter = new OutputStreamWriter(conn.getOutputStream());
		outputStreamWriter.write(sendData.toString());
		outputStreamWriter.flush();
		// 2. 응답 받은 데이터 저장
		StringBuilder sb = new StringBuilder();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		String readLine;
		while ((readLine = bufferedReader.readLine()) != null) {
			sb.append(readLine).append("\n");
			logger.debug("readLine : "+ sb.toString());
		}

		bufferedReader.close();
		JSONParser jsonParser = new JSONParser();
		Object object = jsonParser.parse(sb.toString());
		JSONObject  retJson = (JSONObject) object;
		return retJson;
	}

	public Map<String, Object> createTrackings( AfterShipVo afterShipVo ) {

		Map<String, Object> retMap = new HashMap<>();

		try {
			// 1. aftership header 생성
			String queryString = "trackings";
			HttpURLConnection conn = this.createHeader(queryString, "POST");

			logger.debug("afterShipVo : "+ afterShipVo.toString());

			StringBuffer sb = new StringBuffer();
			sb.append("{");
				sb.append("\"tracking\": {");
					sb.append("\"slug\": \""+ afterShipVo.getSlug() +"\",");
					sb.append("\"tracking_number\": \""+ afterShipVo.getTrackingNumber() +"\",");
					sb.append("\"title\": \""+ afterShipVo.getTitle() +"\",");
					sb.append("\"smses\": [");
					for ( String email : afterShipVo.getEmails() ) {
						sb.append("\"" + email  + "\"");
					}
					sb.append("],");
					sb.append("\"order_id\": \""+ afterShipVo.getOrderId() +"\",");
					sb.append("\"order_id_path\": \""+ afterShipVo.getOrderIdPath() +"\",");
					sb.append("\"custom_fields\": {");
						sb.append("\"product_name\": \""+ afterShipVo.getCustomFields().get("productName") +"\",");
						sb.append("\"product_price\": \""+ afterShipVo.getCustomFields().get("productPrice") +"\"");
					sb.append("},");
					sb.append("\"language\": \""+ afterShipVo.getLanguage() +"\",");
					sb.append("\"order_promised_delivery_date\": \""+ afterShipVo.getOrderPromisedDeliveryDate() +"\",");
					sb.append("\"delivery_type\": \""+ afterShipVo.getDeliveryType() +"\",");
					sb.append("\"pickup_location\": \""+ afterShipVo.getPickupLocation() +"\",");
					sb.append("\"pickup_note\": \""+ afterShipVo.getPickupNote() +"\"");
				sb.append("}");
			sb.append("}");
			logger.debug("sb : "+ sb.toString());

			JSONObject resJson =  this.sendData(conn, sb);
			logger.debug("resJson : "+ resJson);

			JSONParser jsonParser = new JSONParser();
			Object oMeta = jsonParser.parse(resJson.get("meta").toString());
			JSONObject jMeta = (JSONObject) oMeta;
			logger.debug("jResponse : "+ jMeta.toString());
			Object oData = jsonParser.parse(resJson.get("data").toString());
			JSONObject jData = (JSONObject) oData;
			Object oTracking = jsonParser.parse(jData.get("tracking").toString());
			JSONObject jTracking = (JSONObject) oTracking;

			retMap.put("code", "200");
			retMap.put("message", "정성적으로 처리되었습니다.");
			retMap.put("tracking", jTracking);
			return retMap;
		} catch ( Exception e ) {
			logger.debug("fillInStackTrace : "+ e.fillInStackTrace());
			logger.debug("getMessage : "+ e.getMessage());
			retMap.put("code", "500");
			retMap.put("message", e.getMessage());
			retMap.put("tracking", "");
			return retMap;
		}


	}

	public Map<String, Object> getTrackings(String slug, String trackingNumber) {

		Map<String, Object> retMap = new HashMap<>();

		try {
			String queryString = "trackings/"+ slug +"/"+ trackingNumber;
			HttpURLConnection conn = this.createHeader(queryString, "GET");
			JSONObject resJson =  this.sendData(conn);

			JSONParser jsonParser = new JSONParser();
			Object oMeta = jsonParser.parse(resJson.get("meta").toString());
			JSONObject jMeta = (JSONObject) oMeta;
			Object oData = jsonParser.parse(resJson.get("data").toString());
			JSONObject jData = (JSONObject) oData;
			Object oTracking = jsonParser.parse(jData.get("tracking").toString());
			JSONObject jTracking = (JSONObject) oTracking;
			Object oCheckpoints = jsonParser.parse(jTracking.get("checkpoints").toString());
			JSONArray jCheckpoints = (JSONArray) oCheckpoints;

			List<Map<String, Object>> resList = new ArrayList<>();
			for ( int i=0; i<jCheckpoints.size(); i++ ) {
				JSONObject checkpoint = (JSONObject) jCheckpoints.get(i);
				Map<String, Object> map = new ObjectMapper().readValue(checkpoint.toJSONString(), Map.class) ;
				resList.add(map);
			}

			String code = jMeta.get("code").toString();
			if (!code.equals("200")) {
				retMap.put("code", jMeta.get("code"));
				retMap.put("message", jMeta.get("message"));
				retMap.put("data", new ArrayList());
			} else {
				retMap.put("code", jMeta.get("code"));
				retMap.put("message", "정상적으로 처리하였습니다.");
				retMap.put("data", resList);
			}
		} catch ( Exception e ) {
			retMap.put("code", "500");
			retMap.put("message", "알 수 없는 오류가 발생하였습니다.");
			retMap.put("data", new ArrayList());
		}

		return retMap;
	}

	public Map<String, Object> deleteTrackings(String slug, String trackingNumber) {

		Map<String, Object> retMap = new HashMap<>();

		try {
			String queryString = "trackings/"+ slug +"/"+ trackingNumber;
			HttpURLConnection conn = this.createHeader(queryString, "DELETE");


		} catch ( Exception e ) {

		}

		return retMap;
	}

}
