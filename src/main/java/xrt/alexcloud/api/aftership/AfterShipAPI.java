package xrt.alexcloud.api.aftership;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import xrt.alexcloud.api.aftership.vo.AfterShipTrackingVo;
import xrt.lingoframework.utils.LDataMap;

@Component
public class AfterShipAPI {

    Logger logger = LoggerFactory.getLogger(AfterShipAPI.class);

    @Value("#{config['c.afterShipURL']}")
    private String afterShipURL;

    @Value("#{config['c.afterShipApiKey']}")
    private String afterShipApiKey;

    /**
     * AfterShip API 헤더생성
     * 
     * @param queryString
     * @param httpMethod
     * @return
     * @throws Exception
     */
    public HttpURLConnection createHeader(String queryString, String httpMethod) throws Exception {

        
        String httpURL = afterShipURL + queryString;

        // 1. AfterShip API를 통신하기전에 httpURLConnection 을 생성
        HttpURLConnection retURL = (HttpURLConnection) new URL(httpURL).openConnection();
        retURL.setRequestMethod(httpMethod);
        retURL.setRequestProperty("aftership-api-key", afterShipApiKey);
        retURL.setRequestProperty("Content-Type", "application/json");
        retURL.setDoOutput(true);

        return retURL;
    }

    /**
     * AfterShip API Body 설정 및 AfterShip Server에 전송
     * 
     * @param conn
     * @return
     * @throws Exception
     */
    public JSONObject sendData(HttpURLConnection conn) throws Exception {

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
        JSONObject retJson = (JSONObject) object;

        logger.debug(" retJson 11 : " + retJson);

        return retJson;
    }

    /**
     * AfterShip API Body 설정 및 AfterShip Server에 전송
     * 
     * @param conn
     * @param sendData
     * @return
     * @throws Exception
     */
    public JSONObject sendData(HttpURLConnection conn, StringBuffer sendData) throws Exception {

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
            logger.debug("readLine : " + sb.toString());
        }

        bufferedReader.close();
        JSONParser jsonParser = new JSONParser();
        Object object = jsonParser.parse(sb.toString());
        JSONObject retJson = (JSONObject) object;

        return retJson;
    }

    public Map<String, Object> createTrackings(AfterShipTrackingVo trackingVo) throws Exception {

        Map<String, Object> retMap = new HashMap<>();

        try {
            // 1. aftership header 생성
            String queryString = "trackings";
            HttpURLConnection conn = this.createHeader(queryString, "POST");

            StringBuffer sb = new StringBuffer();
            sb.append("{");
            sb.append("\"tracking\": {");
            sb.append("\"slug\": \"" + trackingVo.getSlug() + "\",");
            sb.append("\"tracking_number\": \"" + trackingVo.getTrackingNumber() + "\",");
            sb.append("\"title\": \"" + trackingVo.getTitle() + "\",");
            sb.append("\"smses\": [");
            for (String email : trackingVo.getEmails()) {
                sb.append("\"" + email + "\"");
            }
            sb.append("],");
            sb.append("\"order_id\": \"" + trackingVo.getOrderId() + "\",");
            sb.append("\"order_id_path\": \"" + trackingVo.getOrderIdPath() + "\",");
            sb.append("\"custom_fields\": {");
            sb.append("\"product_name\": \"" + trackingVo.getCustomFields().get("productName") + "\",");
            sb.append("\"product_price\": \"" + trackingVo.getCustomFields().get("productPrice") + "\"");
            sb.append("},");
            sb.append("\"language\": \"" + trackingVo.getLanguage() + "\",");
            sb.append("\"order_promised_delivery_date\": \"" + trackingVo.getOrderPromisedDeliveryDate() + "\",");
            sb.append("\"delivery_type\": \"" + trackingVo.getDeliveryType() + "\",");
            sb.append("\"pickup_location\": \"" + trackingVo.getPickupLocation() + "\",");
            sb.append("\"pickup_note\": \"" + trackingVo.getPickupNote() + "\"");
            sb.append("}");
            sb.append("}");

            logger.debug("sb : " + sb.toString());

            JSONObject resJson = this.sendData(conn, sb);
            logger.debug("resJson : " + resJson);

            JSONParser jsonParser = new JSONParser();
            Object oMeta = jsonParser.parse(resJson.get("meta").toString());
            JSONObject jMeta = (JSONObject) oMeta;
            logger.debug("jResponse : " + jMeta.toString());
            Object oData = jsonParser.parse(resJson.get("data").toString());
            JSONObject jData = (JSONObject) oData;
            Object oTracking = jsonParser.parse(jData.get("tracking").toString());
            JSONObject jTracking = (JSONObject) oTracking;
            logger.debug("jTracking : " + jTracking.toString());

            retMap.put("code", "200");
            retMap.put("message", "정상적으로 처리되었습니다.");

        } catch (Exception e) {
            logger.debug("fillInStackTrace : " + e.fillInStackTrace());
            logger.debug("getMessage : " + e.getMessage());

            retMap.put("code", "500");
            retMap.put("message", e.getMessage());
        }

        return retMap;
    }

    public LDataMap getTrackings(String slug, String trackingNumber) throws Exception {

        LDataMap retMap = new LDataMap();
        String queryString = "trackings/" + slug + "/" + trackingNumber;
        HttpURLConnection conn = this.createHeader(queryString, "GET");
        JSONObject resJson = this.sendData(conn);

        retMap.put("data", resJson);
        return retMap;
    }

    public Map<String, Object> deleteTrackings(String slug, String trackingNumber) {

        Map<String, Object> retMap = new HashMap<>();

        try {
            String queryString = "trackings/" + slug + "/" + trackingNumber;
            HttpURLConnection conn = this.createHeader(queryString, "DELETE");

        } catch (Exception e) {

        }

        return retMap;
    }

}
