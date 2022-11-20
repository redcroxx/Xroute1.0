package xrt.alexcloud.common.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class HttpConnectionUtils {

    Logger logger = LoggerFactory.getLogger(HttpConnectionUtils.class);

    public HttpURLConnection setHeader(String url, String httpMethod) throws Exception {

        String httpURL = url;

        // 1. AfterShip API를 통신하기전에 httpURLConnection 을 생성
        HttpURLConnection retURL = (HttpURLConnection) new URL(httpURL).openConnection();
        retURL.setRequestMethod(httpMethod);
        retURL.setRequestProperty("Content-Type", "application/json;charset=utf-8");
        retURL.setRequestProperty("Accept", "application/json;charset=utf-8");
        retURL.setDoOutput(true);

        return retURL;
    }

    public HttpURLConnection setHeader(String url, String httpMethod, List<Map<String, Object>> params) throws Exception {

        String httpURL = url;

        // 1. AfterShip API를 통신하기전에 httpURLConnection 을 생성
        HttpURLConnection retURL = (HttpURLConnection) new URL(httpURL).openConnection();
        retURL.setRequestMethod(httpMethod);
        retURL.setRequestProperty("Content-Type", "application/json;charset=utf-8");
        retURL.setRequestProperty("Accept", "application/json;charset=utf-8");

        for (int i = 0; i < params.size(); i++) {
            retURL.setRequestProperty(params.get(i).get("key").toString(), params.get(i).get("value").toString());
        }

        retURL.getRequestProperties().entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        retURL.setDoOutput(true);

        return retURL;
    }

    public JSONObject getResponse(HttpURLConnection conn) throws Exception {

        conn.connect();

        // 1. 데이터 발송
        OutputStreamWriter outputStreamWriter = new OutputStreamWriter(conn.getOutputStream(), StandardCharsets.UTF_8);
        outputStreamWriter.flush();

        // 2. 응답 받은 데이터 저장
        StringBuilder sb = new StringBuilder();
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));

        String readLine;
        while ((readLine = bufferedReader.readLine()) != null) {
            sb.append(readLine).append("\n");
        }

        bufferedReader.close();
        conn.disconnect();
        JSONParser jsonParser = new JSONParser();
        Object object = jsonParser.parse(sb.toString());
        JSONObject retJson = (JSONObject) object;
        return retJson;
    }

    public JSONObject getResponse(HttpURLConnection conn, StringBuffer bodySB) throws Exception {

        logger.info("bodySB : " + bodySB.toString());

        conn.connect();

        String encodeSendData = new String(bodySB.toString().getBytes("8859_1"), StandardCharsets.UTF_8);

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
        conn.disconnect();
        JSONParser jsonParser = new JSONParser();
        Object object = jsonParser.parse(sb.toString());
        JSONObject retJson = (JSONObject) object;
        return retJson;
    }

    @SuppressWarnings({ "unchecked", "finally" })
    public JSONObject getErrorResponse(HttpURLConnection conn) {

        BufferedReader bufferedReader = null;
        JSONObject retJson = new JSONObject();
        String responseMessage = "";
        int responseCode = 0;

        try {

            conn.connect();

            // 1. 응답 받은 데이터 저장
            StringBuilder sb = new StringBuilder();

            // 2. 응답 받은 데이터 저장
            responseCode = conn.getResponseCode();
            responseMessage = conn.getResponseMessage();
            if (responseCode == 200) {
                bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            } else {
                bufferedReader = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
            }

            String readLine;
            while ((readLine = bufferedReader.readLine()) != null) {
                sb.append(readLine).append("\n");
                logger.debug("readLine : " + sb.toString());
            }

            bufferedReader.close();
            JSONParser jsonParser = new JSONParser();
            Object object = jsonParser.parse(sb.toString());
            retJson = (JSONObject) object;
        } catch (Exception e) {
            logger.error("Exception : " + e.fillInStackTrace());
            retJson.put("CODE", responseCode + "");
            retJson.put("MESSAGE", responseMessage);
            return retJson;
        } finally {

            try {
                bufferedReader.close();
                conn.disconnect();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            return retJson;
        }
    }

    @SuppressWarnings({ "unchecked", "finally" })
    public JSONObject getErrorResponse(HttpURLConnection conn, StringBuffer bodySB) {
        
        logger.info("bodySB : " + bodySB.toString());

        BufferedReader bufferedReader = null;
        JSONObject retJson = new JSONObject();
        String responseMessage = "";
        int responseCode = 0;

        try {
            conn.connect();

            String encodeSendData = new String(bodySB.toString().getBytes("8859_1"), StandardCharsets.UTF_8);

            // 1. 데이터 발송
            OutputStreamWriter outputStreamWriter = new OutputStreamWriter(conn.getOutputStream(), StandardCharsets.UTF_8);
            outputStreamWriter.write(encodeSendData);
            outputStreamWriter.flush();

            responseCode = conn.getResponseCode();
            responseMessage = conn.getResponseMessage();

            // 2. 응답 받은 데이터 저장
            StringBuilder sb = new StringBuilder();

            if (responseCode == 200) {
                bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            } else {
                bufferedReader = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
            }

            String readLine;
            while ((readLine = bufferedReader.readLine()) != null) {
                sb.append(readLine).append("\n");
            }

            JSONParser jsonParser = new JSONParser();
            Object object = jsonParser.parse(sb.toString());
            retJson = (JSONObject) object;
        } catch (Exception e) {
            logger.error("Exception : " + e.fillInStackTrace());
            retJson.put("CODE", responseCode + "");
            retJson.put("MESSAGE", responseMessage);
        } finally {

            try {
                bufferedReader.close();
                conn.disconnect();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            return retJson;
        }
    }

}
