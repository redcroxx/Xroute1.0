package xrt.interfaces.tolos;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Component;

import xrt.interfaces.tolos.vo.TolosOrderVo;
import xrt.interfaces.tolos.vo.TolosShipmentVo;

@Component
public class Tolos {

	// 개발서버, 운영서버에 따라 사용한다.
	private static final String DEV_URL = "http://dev-api.tolosdelivery.asia/?p_cd=";
	private static final String DEV_ID = "logifocus";
	private static final String DEV_PW = "a11111";

	private static final String REAL_URL = "http://api.tolosdelivery.asia/?p_cd=";
	private static final String REAL_ID = "";
	private static final String REAL_PW = "";

	/**
	 * Tolos API Header
	 * @param pCd
	 * @return
	 * @throws Exception
	 */
	public HttpURLConnection createHeader(String pCd, String devType) throws Exception  {

		String httpURL = (devType == "dev"? DEV_URL + pCd : REAL_URL + pCd);

		// 1. tolos API를 통신하기전에 httpURLConnection 을 생성
		HttpURLConnection retURL = (HttpURLConnection) new URL(httpURL).openConnection();
		retURL.setRequestMethod("POST");
		retURL.setRequestProperty("Content-Type", "application/json");
		retURL.setDoOutput(true);

		return retURL;
	}

	/**
	 * Tolos API Body 설정 및 Tolos Server에 전송
	 * @param conn
	 * @param sendData
	 * @return
	 * @throws Exception
	 */
	public JSONObject sendData(HttpURLConnection conn, StringBuffer sendData) throws Exception  {

		// 1. 데이터 발송
		OutputStreamWriter outputStreamWriter = new OutputStreamWriter(conn.getOutputStream(), "utf-8");
		outputStreamWriter.write(sendData.toString());
		outputStreamWriter.flush();
		// 2. 응답 받은 데이터 저장
		StringBuilder sb = new StringBuilder();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		String readLine;
		while ((readLine = bufferedReader.readLine()) != null) {
			sb.append(readLine).append("\n");
		}

		bufferedReader.close();
		outputStreamWriter.close();
		JSONParser jsonParser = new JSONParser();
		Object object = jsonParser.parse(sb.toString());
		JSONObject  retJson = (JSONObject) object;
		return retJson;
	}

	/**
	 * Tolos API Key 발급
	 * @param serverType
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> ts0001( String serverType ) {

		Map<String, Object> retMap = new HashMap<>();

		try {
			// 1. 해더생성
			HttpURLConnection conn = this.createHeader("TS_0001",  serverType);
			conn.connect();
			// 2. tolos 서버에 보낼 body 데이터 생성
			StringBuffer sb = new StringBuffer();
			sb.append("{");
				sb.append("\"request\": {");
					sb.append("\"id\": "+"\""+ (serverType == "dev" ? DEV_ID:REAL_ID) +"\", ");
					sb.append("\"pw\": "+"\""+ (serverType == "dev" ? DEV_PW:REAL_PW) +"\"");
				sb.append("}");
			sb.append("}");
			JSONObject resJson =  this.sendData(conn, sb);
			JSONParser jsonParser = new JSONParser();
			Object oResponse = jsonParser.parse(resJson.get("response").toString());
			JSONObject jResponse = (JSONObject) oResponse;
			if (jResponse.get("code").equals("S001") ) {
				retMap.put("apikey", jResponse.get("apikey"));
				retMap.put("code", "200");
				retMap.put("message", "success");
			} else {
				retMap.put("code", jResponse.get("code"));
				retMap.put("message", jResponse.get("message"));
			}

			return retMap;

		} catch ( Exception e ) {
			retMap.put("code", "500");
			retMap.put("message", e.fillInStackTrace());
			return retMap;
		}
	}

	/**
	 * Tolos 배송 상태 송수신(TS_0003), 삭제(TS_0007), 입고완료 정보 반환 (TS_0014)
	 * @param serverType dev, real
	 * @param shippingnos tolos 배송번호
	 * @return
	 */
	public Map<String, Object> commonTs( String pCd, String serverType, List<String> shippingnos ) {

		Map<String, Object> retMap = new HashMap<>();

		if ( shippingnos.size() == 0) {
			retMap.put("code", "404");
			retMap.put("message", "Tolos 배송번호가 없습니다.");
			return retMap;
		}

		try {
			// 1. 해더생성
			HttpURLConnection conn = this.createHeader(pCd,  serverType);
			conn.connect();
			// 2. API KEY 발급
			Map<String, Object> resMap = this.ts0001( serverType );
			if ( resMap == null || (resMap.get("code") == null) ) {
				retMap.put("code", "404");
				retMap.put("message", "데이터가 없습니다.");
				return retMap;
			} else if ( !resMap.get("code").equals("200") ) {
				retMap.put("code", resMap.get("code"));
				retMap.put("message", resMap.get("message"));
				return retMap;
			}
			// 3. tolos 서버에 보낼 body 데이터 생성
			String apiKey = (String) resMap.get("apikey");
			StringBuffer sb = new StringBuffer();
			sb.append("{");
				sb.append("\"request\": {");
					sb.append("\"info\": {");
						sb.append("\"apikey\": "+"\""+ apiKey +"\"");
					sb.append("},");
					sb.append("\"list\": [");
					for (int i=0; i<shippingnos.size(); i++ ) {
						String returnBrace = returnBrace( i, shippingnos.size(), "}" );
						sb.append("{\"shippingno\": "+"\""+ shippingnos.get(i) +"\""+ returnBrace);
					}
					sb.append("]");
				sb.append("}");
			sb.append("}");

			JSONObject resJson =  this.sendData(conn, sb);
			JSONParser jsonParser = new JSONParser();
			Object oResponse = jsonParser.parse(resJson.get("response").toString());
			JSONObject jResponse = (JSONObject) oResponse;
			Object oInfo = jsonParser.parse(jResponse.get("info").toString());
			JSONObject jInfo = (JSONObject) oInfo;
			Object oList = jsonParser.parse(jResponse.get("list").toString());
			JSONArray jList = (JSONArray) oList;

			if (pCd == "TS_0014") {
				if (!jInfo.get("code").equals("E101") ) {
					retMap.put("code", "200");
					retMap.put("message", "success");
					retMap.put("list", jList);
				} else {
					retMap.put("code", jInfo.get("code"));
					retMap.put("message", jInfo.get("message"));
				}
			} else {
				if (jResponse.get("code") == null ) {
					retMap.put("code", "200");
					retMap.put("message", "success");
					retMap.put("list", jList);
				} else {
					retMap.put("code", jResponse.get("code"));
					retMap.put("message", jResponse.get("message"));
				}
			}

			return retMap;
		} catch ( Exception e ) {
			retMap.put("code", "500");
			retMap.put("message", e.fillInStackTrace());
			return retMap;
		}
	}

	/**
	 * tolos 주문 정보 송수신
	 * @param serverType
	 * @param shipments
	 * @return
	 */
	public Map<String, Object> ts0009(String serverType, List<TolosShipmentVo> shipments ) {

		Map<String, Object> retMap = new HashMap<>();
		if ( shipments.size() == 0) {
			retMap.put("code", "404");
			retMap.put("message", "주문정보가 없습니다.");
			return retMap;
		}

		try {

			// 1. 해더생성
			HttpURLConnection conn = this.createHeader("TS_0009",  serverType);
			conn.connect();
			// 2. API KEY 발급
			Map<String, Object> resMap = this.ts0001( serverType );
			if ( resMap == null || (resMap.get("code") == null) ) {
				retMap.put("code", "404");
				retMap.put("message", "데이터가 없습니다.");
				return retMap;
			} else if ( !resMap.get("code").equals("200") ) {
				retMap.put("code", resMap.get("code"));
				retMap.put("message", resMap.get("message"));
				return retMap;
			}
			// 3. tolos 서버에 보낼 body 데이터 생성
			String apiKey = (String) resMap.get("apikey");
			StringBuffer sb = new StringBuffer();
			sb.append("{ ");
				sb.append("\"request\": { ");
					sb.append("\"info\": { ");
						sb.append("\"apikey\": "+"\""+ apiKey +"\"");
					sb.append(" }, ");
					sb.append("\"list\": [");

					for ( int i=0; i<shipments.size(); i++ ) {
						sb.append("{ ");
						sb.append("\"shprrefno\": "+"\""+ shipments.get(i).getShprrefno() +"\", ");
						sb.append("\"shipmethod\": "+"\""+ shipments.get(i).getShipmethod().toUpperCase() +"\", ");
						sb.append("\"shipname\": "+"\""+ shipments.get(i).getShipname() +"\", ");
						sb.append("\"shipaddr\": "+"\""+ shipments.get(i).getShipaddr() +"\", ");
						sb.append("\"shippostal\": "+"\""+ shipments.get(i).getShippostal() +"\", ");
						sb.append("\"shiptel\": "+"\""+ shipments.get(i).getShiptel() +"\", ");
						sb.append("\"shipmobile\": "+"\""+ shipments.get(i).getShipmobile() +"\", ");
						sb.append("\"snation\": "+"\""+ shipments.get(i).getSnation() +"\", ");
						sb.append("\"cneename\": "+"\""+ shipments.get(i).getCneename() +"\", ");
						sb.append("\"cneeaddr\": "+"\""+ shipments.get(i).getCneeaddr() +"\", ");
						sb.append("\"cneepostal\": "+"\""+ shipments.get(i).getCneepostal().replace("-", "")  +"\", ");
						sb.append("\"cneetel\": "+"\""+ shipments.get(i).getCneetel() +"\", ");
						sb.append("\"cneemobile\": "+"\""+ shipments.get(i).getCneemobile()  +"\", ");
						sb.append("\"enation\": "+"\""+ shipments.get(i).getEnation() +"\", ");
						sb.append("\"shopcode\": "+"\""+ shipments.get(i).getShopcode() +"\", ");
						sb.append("\"currency\": "+"\""+ shipments.get(i).getCurrency() +"\", ");
						sb.append("\"purchasecharge\": "+"\""+ shipments.get(i).getPurchasecharge()  +"\", ");
						sb.append("\"cartno\": "+"\""+ shipments.get(i).getCartno() +"\",");
							sb.append("\"orderlist\": { ");
							List<TolosOrderVo> orderList = shipments.get(i).getOrderList();
							for ( int j=0; j<orderList.size(); j++ ) {
								sb.append("\""+ orderList.get(j).getOrderlistKey() +"\": [ ");
								for ( int k=0; k<orderList.get(j).getItem().length; k++  ) {
									sb.append("{ ");
									sb.append("\"itemno\": "+"\""+ orderList.get(j).getItemno()[k] +"\",");
									sb.append("\"item\": "+"\""+ orderList.get(j).getItem()[k] +"\",");
									sb.append("\"itemoption\": "+"\""+ orderList.get(j).getItemoption()[k] +"\",");
									sb.append("\"itemoptionkr\": "+"\""+ orderList.get(j).getItemoptionkr()[k] +"\",");
									sb.append("\"itemcnt\": "+"\""+ orderList.get(j).getItemcnt()[k] +"\",");
									sb.append("\"itemprice\": "+"\""+ orderList.get(j).getItemprice()[k] +"\"");
									sb.append( this.returnBrace( k, orderList.get(j).getItem().length, " }"));
								}
								sb.append( this.returnBrace(j, orderList.size(), " ]") );
							}
							sb.append(" }");
						sb.append( this.returnBrace(i, shipments.size(), " }") );
					}
					sb.append(" ]");
				sb.append(" }");
			sb.append(" }");

			JSONObject resJson =  this.sendData(conn, sb);
			JSONParser jsonParser = new JSONParser();
			Object oResponse = jsonParser.parse(resJson.get("response").toString());
			JSONObject jResponse = (JSONObject) oResponse;
			Object oInfo = jsonParser.parse(jResponse.get("info").toString());
			JSONObject jInfo = (JSONObject) oInfo;
			Object oList = jsonParser.parse(jResponse.get("list").toString());
			JSONArray jList = (JSONArray) oList;
			if (jInfo.get("code").equals("S001")) {
				retMap.put("code", "200");
				retMap.put("message", "success");
				retMap.put("list", jList);
			} else {
				retMap.put("code", jInfo.get("code"));
				retMap.put("message", jInfo.get("message"));
				retMap.put("list", jList);
			}

			return retMap;
		} catch ( Exception e ) {
			retMap.put("code", "500");
			retMap.put("message", e.fillInStackTrace());
			return retMap;
		}
	}

	String returnBrace(int idnex, int listSize, String type) {
		if ((idnex + 1) == listSize) {
			return type;
		} else {
			return type +",";
		}
	}
}
