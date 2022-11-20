package xrt.fulfillment.atomy;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;
import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class AtomyDeliveredTestBiz extends DefaultBiz{
    
    private final static Logger logger = LoggerFactory.getLogger(AtomyDeliveredTestBiz.class);
    
    @Value("#{config['c.debugtype']}")
    private String debugtype;

    public LDataMap setDeliveredUpdate(LDataMap order) throws Exception {
        LDataMap dataMap = new LDataMap();
        List<LDataMap> bodyList = dao.select("shippingListMapper.getDeliveredData", order);
        if (bodyList.size() != 0) {
           dataMap = this.setDelivered(bodyList); // 애터미 배송완료 신호 API 호출.
        }
        return dataMap;
    }
    
    // 애터미 배송완료 API.
    public LDataMap setDelivered(List<LDataMap> bodyList) throws Exception{
        StringBuffer sb = new StringBuffer();
        sb.append("[");
        for (int i = 0; i < bodyList.size(); i++) {
            sb.append("{");
            sb.append("\"SaleNum\": \"" + bodyList.get(i).getString("ordNo") + "\",");
            sb.append("\"Seq\": \"" + bodyList.get(i).getString("ordSeq") + "\"");
            if ((i + 1) == bodyList.size()) {
                sb.append("}");
            } else {
                sb.append("},");
            }
        }
        sb.append("]");
        
        String queryString = "/apiglobal/scm/kr/v1/status/finished";
        String apiType = "delivered";
        String httpMethod = "PUT";

        HttpURLConnection conn = this.setHttpHeader(queryString, httpMethod, apiType);
        JSONObject jsonObject = this.setHttpBody(conn, apiType, sb);

        LDataMap resMap = new ObjectMapper().readValue(jsonObject.toJSONString(), LDataMap.class);
        resMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        
        String status = resMap.getString("Status");
        String message = resMap.getString("Message");
   
        LDataMap retMap = new LDataMap();
        retMap.put("code", status);
        retMap.put("message", message);
        return retMap;
    }
    
    public HttpURLConnection setHttpHeader(String queryString, String httpMethod, String apiType) throws Exception{

        String apiToken = CommonConst.ATOMY_DEV_API_TOKEN;
        String apiUserToken = CommonConst.ATOMY_DEV_API_USER_TOKEN;
        String url = CommonConst.ATOMY_DEV_URL;
        
        if (debugtype.equals("REAL")) {
            url = CommonConst.ATOMY_REAL_URL;
            apiToken = CommonConst.ATOMY_DEV_API_TOKEN;
            apiUserToken = CommonConst.ATOMY_DEV_API_USER_TOKEN;
        }
        
        HttpURLConnection retUrl = (HttpURLConnection) new URL(url + queryString).openConnection();
        retUrl.setRequestMethod(httpMethod);
        retUrl.setRequestProperty("Content-Type", "application/json;charset=utf-8");
        retUrl.setRequestProperty("Accept", "application/json;charset=utf-8");
        retUrl.setRequestProperty("Atomy-Api-Token", apiToken);
        retUrl.setRequestProperty("Atomy-User-Token", apiUserToken);
        retUrl.setDoOutput(true);
        return retUrl;
    }
    
    @SuppressWarnings({ "unchecked", "finally" })
    public JSONObject setHttpBody(HttpURLConnection conn, String apiType, StringBuffer reqSB) throws Exception {
        
        logger.info("reqSB : " + reqSB.toString());
        
        JSONObject retJson = new JSONObject();
        
        try {
            conn.connect();

            String encodeSendData = new String(reqSB.toString().getBytes("8859_1"), StandardCharsets.UTF_8);

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
            }

            bufferedReader.close();
            JSONParser jsonParser = new JSONParser();
            Object object = jsonParser.parse(sb.toString());
            retJson = (JSONObject) object;

        } catch (Exception e) {
            retJson.put("Status", "0");
            retJson.put("StatusDetailCode", "");
            retJson.put("data", "");
            retJson.put("apiType", apiType);
            retJson.put("errMsg", e.getMessage());
        } finally {
            return retJson;
        }
    }
}
