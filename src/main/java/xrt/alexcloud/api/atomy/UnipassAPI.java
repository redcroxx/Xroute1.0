package xrt.alexcloud.api.atomy;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.Blob;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.sql.rowset.serial.SerialBlob;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.json.XML;
import org.json.simple.JSONArray;
import org.json.simple.JSONAware;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.fasterxml.jackson.databind.ObjectMapper;

import xrt.alexcloud.api.ups.UpsAPIBiz;
import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.atomy.AtomyBoxSizeVO;
import xrt.fulfillment.atomy.AtomyCountryZoneVO;
import xrt.fulfillment.atomy.AtomyRateVO;
import xrt.fulfillment.interfaces.vo.TOrderDtlVo;
import xrt.fulfillment.interfaces.vo.TOrderVo;
import xrt.fulfillment.tracking.TrackingHistorytVO;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class UnipassAPI extends DefaultBiz{
    
    private final static Logger logger = LoggerFactory.getLogger(UnipassAPI.class);
    
//    private UpsAPIBiz upsAPIBiz;
//    
//    @Autowired
//    public UnipassAPI(UpsAPIBiz upsAPIBiz) {
//        this.upsAPIBiz = upsAPIBiz;
//    }

    @Value("#{config['c.debugtype']}")
    private String debugtype;
    
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
            retJson.put("apiType", apiType);
            retJson.put("errMsg", e.getMessage());
        } finally {
            return retJson;
        }
    }
    
    
    @SuppressWarnings({ "finally", "unchecked" })
    public JSONObject xmlParser(String expDclrNo) throws Exception {
        JSONObject retJson = new JSONObject();
        try {            
            String apiKey = CommonConst.UNIPASS_CRKYCN;
            String url = CommonConst.UNIPASS_URL + "?crkyCn=" + apiKey + "&expDclrNo=" + expDclrNo;
            Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(url);            
            Transformer transformer = TransformerFactory.newInstance().newTransformer();
            StringWriter writer = new StringWriter();
            transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
            transformer.transform(new DOMSource(doc), new StreamResult(writer));
            org.json.JSONObject rtnJson = XML.toJSONObject(writer.getBuffer().toString());
            
            String shpmCmplYn = rtnJson.getJSONObject("expDclrNoPrExpFfmnBrkdQryRtnVo").getJSONObject("expDclrNoPrExpFfmnBrkdQryRsltVo").get("shpmCmplYn").toString();
            String tkofDt = rtnJson.getJSONObject("expDclrNoPrExpFfmnBrkdQryRtnVo").getJSONObject("expDclrNoPrExpFfmnBrkdDtlQryRsltVo").get("tkofDt").toString();

            logger.info("shpmCmplYn : "+shpmCmplYn + "   tkofDt :"+ tkofDt);
            
            retJson.put("shpmCmplYn", shpmCmplYn);
            retJson.put("tkofDt", tkofDt);            
            if (shpmCmplYn.equals("Y")) {
            	
            	LDataMap checkMap = new LDataMap();
            	checkMap.put("EXP_NO", expDclrNo);
            	List<LDataMap> bodyList = dao.select("AtomyOApiOrderListMapper.getAtomyShipmentCompList", checkMap);
            	retJson.put("bodylist", bodyList);
                if (bodyList.size() != 0) {
                    // ATOMY 선적완료 호출
                    this.setShipmentComp(bodyList, tkofDt);
                    // 호출하고 바꿔야함
                    retJson.put("updateResult",isShipping(expDclrNo, tkofDt));
                }
            }
            
        } catch (Exception e) {
            retJson.put("apiType", "unipassAPI");
            retJson.put("errMsg", e.getMessage());
        } finally {
        	retJson.put("expDclrNo", expDclrNo);
            return retJson;
        }
    }
    
    @SuppressWarnings({ "finally", "unchecked" })
    public JSONObject xmlParserNormalSeller(String expDclrNo) throws Exception {
        JSONObject retJson = new JSONObject();
        try {            
            String apiKey = CommonConst.UNIPASS_CRKYCN;
            String url = CommonConst.UNIPASS_URL + "?crkyCn=" + apiKey + "&expDclrNo=" + expDclrNo;
            Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(url);            
            Transformer transformer = TransformerFactory.newInstance().newTransformer();
            StringWriter writer = new StringWriter();
            transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
            transformer.transform(new DOMSource(doc), new StreamResult(writer));
            org.json.JSONObject rtnJson = XML.toJSONObject(writer.getBuffer().toString());
            
            String shpmCmplYn = rtnJson.getJSONObject("expDclrNoPrExpFfmnBrkdQryRtnVo").getJSONObject("expDclrNoPrExpFfmnBrkdQryRsltVo").get("shpmCmplYn").toString();
            String tkofDt = rtnJson.getJSONObject("expDclrNoPrExpFfmnBrkdQryRtnVo").getJSONObject("expDclrNoPrExpFfmnBrkdDtlQryRsltVo").get("tkofDt").toString();

            logger.info("shpmCmplYn : "+shpmCmplYn + "   tkofDt :"+ tkofDt);
            
            retJson.put("shpmCmplYn", shpmCmplYn);
            retJson.put("tkofDt", tkofDt);            
            if (shpmCmplYn.equals("Y")) {
            	
            	LDataMap checkMap = new LDataMap();
            	checkMap.put("EXP_NO", expDclrNo);
            	List<LDataMap> bodyList = dao.select("AtomyOApiOrderListMapper.getAtomyShipmentCompList", checkMap);
            	retJson.put("bodylist", bodyList);
            }
            
        } catch (Exception e) {
            retJson.put("apiType", "unipassAPI");
            retJson.put("errMsg", e.getMessage());
        } finally {
        	retJson.put("expDclrNo", expDclrNo);
            return retJson;
        }
    }
    
    // UNIPASS 선적완료여부값이 Y인 경우 - TORDER update
    public int isShipping(String expDclrNo, String tkofDt) throws Exception {
    	LDataMap lm = new LDataMap();
    	lm.put("EXP_NO", expDclrNo);
    	lm.put("UNIPASS_TKOFDT", tkofDt);
    	return dao.update("AtomyOApiOrderListMapper.unipassDoRefresh", lm);
    }
    
    // UNIPASS 조회
    @SuppressWarnings("unchecked")
	public LDataMap getUnipassTrackingStatus() throws Exception {
        LDataMap retMap = new LDataMap();
        logger.info("[1. UNIPASS API 데이터수집]");
        List<LDataMap> list = dao.select("AtomyOApiOrderListMapper.unipassRefreshList", null);
        JSONArray jarr = new JSONArray();
        for (int i=0; i<list.size(); i++) {
        	 jarr.add(this.xmlParser(list.get(i).getString("EXP_NO")));
        }
        retMap.put("resultLength", list.size());
        retMap.put("result", jarr);
        return retMap;
    }
    
    // UNIPASS 조회
    @SuppressWarnings("unchecked")
	public LDataMap getNormalSellerUnipassTrackingStatus() throws Exception {
        LDataMap retMap = new LDataMap();
        logger.info("[1. UNIPASS API 데이터수집]");
        List<LDataMap> list = dao.select("AtomyOApiOrderListMapper.unipassRefreshListNormalSeller", null);
        JSONArray jarr = new JSONArray();
        for (int i=0; i<list.size(); i++) {
        	 jarr.add(this.xmlParserNormalSeller(list.get(i).getString("EXP_NO")));
        }
        retMap.put("resultLength", list.size());
        retMap.put("result", jarr);
        return retMap;
    }
    
    public LDataMap setShipmentComp(List<LDataMap> bodyList, String deliDate) throws Exception{
        StringBuffer sb = new StringBuffer();
        sb.append("[");
        for (int i = 0; i < bodyList.size(); i++) {
            sb.append("{");
            sb.append("\"SaleNum\": \"" + bodyList.get(i).getString("ordNo") + "\",");
            sb.append("\"Seq\": \"" + bodyList.get(i).getString("ordSeq") + "\",");
            sb.append("\"DeliDate\": \"" + deliDate + "\"");
            if ((i + 1) == bodyList.size()) {
                sb.append("}");
            } else {
                sb.append("},");
            }
        }
        sb.append("]");
        
        String queryString = "/apiglobal/scm/kr/v1/status/shipDirect";
        String apiType = "etdComp";
        String httpMethod = "PUT";        

        HttpURLConnection conn = this.setHttpHeader(queryString, httpMethod, apiType);
        JSONObject jsonObject = this.setHttpBody(conn, apiType, sb);

        LDataMap resMap = new ObjectMapper().readValue(jsonObject.toJSONString(), LDataMap.class);
        resMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        
        String status = resMap.getString("Status");
        String message = resMap.getString("Message");
        
        if (status.equals("1")) {
        	
        }
   
        LDataMap retMap = new LDataMap();
        retMap.put("code", status);
        retMap.put("message", message);
        return retMap;
    }

 
}
