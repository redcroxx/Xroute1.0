package xrt.alexcloud.api.ups;

import java.net.HttpURLConnection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import com.fasterxml.jackson.databind.ObjectMapper;
import xrt.alexcloud.common.utils.HttpConnectionUtils;
import xrt.fulfillment.order.shippinglist.ShippingListVO;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

@Component
public class UpsAPIBiz extends CommonBiz {

    Logger logger = LoggerFactory.getLogger(UpsAPIBiz.class);

    private HttpConnectionUtils httpConnectionUtils;

    @Autowired
    public UpsAPIBiz(HttpConnectionUtils httpConnectionUtils) {
        super();
        this.httpConnectionUtils = httpConnectionUtils;
    }

    @Value("#{config['c.debugtype']}")
    private String debugtype;

    @Value("#{config['c.upsDevUrl']}")
    private String upsDevUrl;

    @Value("#{config['c.upsRealUrl']}")
    private String upsRealUrl;

    @Value("#{config['c.upsUserName']}")
    private String upsUserName;

    @Value("#{config['c.upsPassword']}")
    private String upsPassword;

    @Value("#{config['c.upsAccessKey']}")
    private String upsAccessKey;

    @Value("#{config['c.upsShipperNumber']}")
    private String upsShipperNumber;

    @SuppressWarnings("unchecked")
    public LRespData setAddressValidation(LDataMap paramMap) throws Exception {

        String url = "";

        if (debugtype.equals("DEV")) {
            url = upsDevUrl + "rest/AV";
        } else {
            url = upsRealUrl + "rest/AV";
        }

        HttpURLConnection httpConn = httpConnectionUtils.setHeader(url, "POST");

        StringBuffer sb = new StringBuffer();
        sb.append("{ ");
        sb.append("\"AccessRequest\": {");
        sb.append("\"AccessLicenseNumber\": \"" + upsAccessKey + "\",");
        sb.append("\"UserId\": \"" + upsUserName + "\",");
        sb.append("\"Password\": \"" + upsPassword + "\"");
        sb.append("},");
        sb.append("\"AddressValidationRequest\":");
        sb.append("{\"Request\": {");
        sb.append("\"TransactionReference\": {");
        sb.append("\"CustomerContext\": \"\"");
        sb.append("},");
        sb.append("\"RequestAction\": \"AV\"");
        sb.append("},");
        sb.append("\"Address\": {");
        sb.append("\"City\": \"" + paramMap.getString("recvCity") + "\",");
        sb.append("\"StateProvinceCode\": \"" + paramMap.getString("recvState") + "\",");
        sb.append("\"PostalCode\": \"" + paramMap.getString("recvPost") + "\"");
        sb.append("}");
        sb.append("}");
        sb.append("}");

        JSONObject bodyJson = httpConnectionUtils.getErrorResponse(httpConn, sb);
        LDataMap avMap = new ObjectMapper().readValue(bodyJson.toJSONString(), LDataMap.class);
        avMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        Map<String, Object> responseMap = (Map<String, Object>) avMap.get("AddressValidationResponse");
        responseMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        Map<String, Object> retMap = (Map<String, Object>) responseMap.get("Response");
        retMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        LRespData resData = new LRespData();

        if (!retMap.get("ResponseStatusCode").equals("1")) {
            resData.put("CODE", retMap.get("ResponseStatusCode"));
            resData.put("MESSAGE", retMap.get("ResponseStatusDescription"));
        }

        return resData;
    }

    public LRespData setShipments(LDataMap paramMap) throws Exception {

        LRespData resData = new LRespData();
        List<Map<String, Object>> params = new ArrayList<Map<String, Object>>();
        Date toDay = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat documentDateFormat = new SimpleDateFormat("yyyy-MM-dd-HH.mm.ss.SSS");
        String sToDay = dateFormat.format(toDay);

        ShippingListVO orderVo = (ShippingListVO) dao.selectOne("upsAPIMapper.getTOrder", paramMap);
        
        LDataMap orderMap = new LDataMap();
        orderMap.put("ordCd", orderVo.getOrdCd());
        List<ShippingListVO> orderDtlVo = dao.selectList("upsAPIMapper.getTOrderDtl", orderMap);

        String url = "";
        Map<String, Object> licensMap = new HashMap<String, Object>();
        licensMap.put("key", "AccessLicenseNumber");
        licensMap.put("value", upsAccessKey);
        Map<String, Object> userMap = new HashMap<String, Object>();
        userMap.put("key", "Username");
        userMap.put("value", upsUserName);
        Map<String, Object> passMap = new HashMap<String, Object>();
        passMap.put("key", "Password");
        passMap.put("value", upsPassword);
        Map<String, Object> transMap = new HashMap<String, Object>();
        transMap.put("key", "transId");
        transMap.put("value", sToDay + orderVo.getXrtInvcSno());
        Map<String, Object> transSrcMap = new HashMap<String, Object>();
        transSrcMap.put("key", "transactionSrc");
        transSrcMap.put("value", "tx.logifocus.co.kr");
        params.add(licensMap);
        params.add(userMap);
        params.add(passMap);
        params.add(transMap);
        params.add(transSrcMap);

        if (debugtype.equals("DEV")) {
            url = upsDevUrl + "ship/v1/shipments";
        } else {
            url = upsRealUrl + "ship/v1/shipments";
        }

        HttpURLConnection httpConn = httpConnectionUtils.setHeader(url, "POST", params);

        StringBuffer sb = new StringBuffer();
        sb.append("{");
        sb.append("\"ShipmentRequest\":{");
        sb.append("\"Shipment\":{");
        sb.append("\"Description\":\"To Logifocus From UPS\",");
        sb.append("\"Shipper\":{");
        sb.append("\"Name\":\"Logifocus\",");
        sb.append("\"AttentionName\":\"Logifocus\",");
        sb.append("\"CompanyDisplayableName\":\"Logifocus\",");
        sb.append("\"Phone\":{");
        sb.append("\"Number\":\"+82-2-6956-6603\"");
        sb.append("},");
        sb.append("\"ShipperNumber\":\"" + upsShipperNumber + "\",");
        sb.append("\"EMailAddress\":\"kh.kim@logifocus.co.kr\",");
        sb.append("\"Address\":{");
        sb.append("\"AddressLine\":\"Haneul-gil, Gangseo-gu\",");
        sb.append("\"AddressLine1\":\"#105 8-1A warehouse, 210\",");
        sb.append("\"City\":\"Seoul\",");
        sb.append("\"StateProvinceCode\":\"\",");
        sb.append("\"PostalCode\":\"07505\",");
        sb.append("\"CountryCode\":\"KR\"");
        sb.append("}");
        sb.append("},");
        sb.append("\"ShipTo\":{");
        sb.append("\"Name\":\"" + orderVo.getRecvName() + "\",");
        sb.append("\"AttentionName\":\"" + orderVo.getRecvName() + "\",");
        sb.append("\"Phone\":{");
        sb.append("\"Number\":\"" + orderVo.getRecvTel() + "\"");
        sb.append("},");
        sb.append("\"EMailAddress\":\"\",");
        sb.append("\"Address\":{");
        sb.append("\"AddressLine\":\"" + orderVo.getRecvAddr1() + "\",");
        sb.append("\"AddressLine1\":\"" + orderVo.getRecvAddr2() + "\",");
        sb.append("\"City\":\"" + orderVo.getRecvCity() + "\",");
        sb.append("\"StateProvinceCode\":\"" + orderVo.getRecvState() + "\",");
        sb.append("\"PostalCode\":\"" + orderVo.getRecvPost() + "\",");
        sb.append("\"CountryCode\":\"" + orderVo.geteNation() + "\"");
        sb.append("}");
        sb.append("},");
        sb.append("\"ShipFrom\":{");
        sb.append("\"Name\":\"Atomy\",");
        sb.append("\"CompanyDisplayableName\":\"Atomy\",");
        sb.append("\"Phone\":{");
        sb.append("\"Number\":\"+82-1544-8580\"");
        sb.append("},");
        sb.append("\"Address\":{");
        sb.append("\"AddressLine\":\"2148-21, Baekjemunhwa-ro\",");
        sb.append("\"City\":\"Gongju-si\",");
        sb.append("\"StateProvinceCode\":\"\",");
        sb.append("\"PostalCode\":\"32543\",");
        sb.append("\"CountryCode\":\"KR\"");
        sb.append("}");
        sb.append("},");
        sb.append("\"PaymentInformation\":{");
        sb.append("\"ShipmentCharge\":{");
        sb.append("\"Type\":\"01\",");
        sb.append("\"BillShipper\":{");
        sb.append("\"AccountNumber\":\"" + upsShipperNumber + "\"");
        sb.append("}");
        sb.append("}");
        sb.append("},");
        sb.append("\"Service\":{");
        sb.append("\"Code\":\"65\",");
        sb.append("\"Description\":\"Expedited\"");
        sb.append("},");
        sb.append("\"Package\":[");
        sb.append("{");
        sb.append("\"Description\":\"" + orderVo.getMallNm() + "\",");
        sb.append("\"Packaging\":{");
        sb.append("\"Code\":\"02\"");
        sb.append("},");
        sb.append("\"Dimensions\":{");
        sb.append("\"UnitOfMeasurement\":{");
        sb.append("\"Code\":\"CM\"");
        sb.append("},");
        sb.append("\"Length\":\"" + orderVo.getxBoxLength() + "\",");
        sb.append("\"Width\":\"" + orderVo.getxBoxWidth() + "\",");
        sb.append("\"Height\":\"" + orderVo.getxBoxHeight() + "\"");
        sb.append("},");
        sb.append("\"PackageWeight\":{");
        sb.append("\"UnitOfMeasurement\":{");
        sb.append("\"Code\":\"KGS\"");
        sb.append("},");
        sb.append("\"Weight\":\"" + orderVo.getxWgt() + "\"");
        sb.append("},");
        sb.append("\"ReferenceNumber\":{");
        sb.append("\"Value\":\"1\"");
        sb.append("}");
        sb.append("}");
        sb.append("],");
        sb.append("\"ShipmentServiceOptions\":{");
        sb.append("\"InternationalForms\":{");
        sb.append("\"FormType\":[");
        sb.append("\"01\",");
        sb.append("\"06\"");
        sb.append("],");
        sb.append("\"UserCreatedForm\":{");
        sb.append("\"DocumentID\":\"" + documentDateFormat.format(toDay).toString() +"\"");
        sb.append("},");
        sb.append("\"InvoiceDate\":\"" + dateFormat.format(toDay).toString() + "\",");
        sb.append("\"TermsOfShipment\":\"DDP\",");
        sb.append("\"ReasonForExport\":\"SALE\",");
        sb.append("\"Contacts\":{");
        sb.append("\"SoldTo\":{");
        sb.append("\"Name\":\"" + orderVo.getRecvName() + "\",");
        sb.append("\"AttentionName\":\"" + orderVo.getRecvName() + "\",");
        sb.append("\"Phone\":{");
        sb.append("\"Number\":\"" + orderVo.getRecvTel() + "\"");
        sb.append("},");
        sb.append("\"Address\":{");
        sb.append("\"AddressLine\":\"" + orderVo.getRecvAddr1() + "\",");
        sb.append("\"AddressLine1\":\"" + orderVo.getRecvAddr2() + "\",");
        sb.append("\"City\":\"" + orderVo.getRecvCity() + "\",");
        sb.append("\"StateProvinceCode\":\"" + orderVo.getRecvState() + "\",");
        sb.append("\"PostalCode\":\"" + orderVo.getRecvPost() + "\",");
        sb.append("\"CountryCode\":\"" + orderVo.geteNation() + "\"");
        sb.append("},");
        sb.append("\"EMailAddress\":\"\"");
        sb.append("}");
        sb.append("},");
        sb.append("\"Product\":[");
        for (int i = 0; i < orderDtlVo.size(); i++) {
            sb.append("{");
            sb.append("\"Description\":\"" + orderDtlVo.get(i).getGoodsNm() + "\",");
            sb.append("\"Unit\":{");
            sb.append("\"Number\":\"" + orderDtlVo.get(i).getGoodsCnt() + "\",");
            sb.append("\"UnitOfMeasurement\":{");
            sb.append("\"Code\":\"EA\"");
            sb.append("},");
            sb.append("\"Value\":\"" + orderDtlVo.get(i).getPaymentPrice() + "\"");
            sb.append("},");
            sb.append("\"CommodityCode\":\"" + orderDtlVo.get(i).getGoodsCd() + "\",");
            sb.append("\"OriginCountryCode\":\"KR\",");
            sb.append("\"PackingListInfo\":{");
            sb.append("\"PackageAssociated\":{");
            sb.append("\"PackageNumber\":\"" + orderVo.getPickingPage() + "\",");
            sb.append("\"ProductAmount\":\"" + orderDtlVo.get(i).getGoodsCnt() + "\"");
            sb.append("}");
            sb.append("}");
            if (i == orderDtlVo.size()-1) { // sb.append(sb.substring(0, sb.length() -1));
                sb.append("}");
            }else {
                sb.append("},");
            }
        }
        sb.append("],");
        sb.append("\"CurrencyCode\":\"" + orderVo.getRecvCurrency() + "\"");
        sb.append("}");
        sb.append("}");
        sb.append("},");
        sb.append("\"LabelSpecification\":{");
        sb.append("\"LabelImageFormat\":{");
        sb.append("\"Code\":\"GIF\"");
        sb.append("}");
        sb.append("}");
        sb.append("}");
        sb.append("}");
        
        JSONObject bodyJson = httpConnectionUtils.getErrorResponse(httpConn, sb);

        if (bodyJson.get("ShipmentResponse") != null) {
            
            JSONObject shipmentResponse = (JSONObject) bodyJson.get("ShipmentResponse");
            
            JSONObject shipmentResults = (JSONObject) shipmentResponse.get("ShipmentResults");
            
            JSONObject packageResults = (JSONObject) shipmentResults.get("PackageResults");
            
            LDataMap upsResMap = new ObjectMapper().readValue(packageResults.toJSONString(), LDataMap.class);
            
            upsResMap.entrySet().forEach(entry -> {
                logger.info("" + entry.getKey() + " : " + entry.getValue());
            });
            
            resData.put("packageResultsMap", upsResMap);
            resData.put("xrtInvcSno", orderVo.getXrtInvcSno());
            logger.info("orderVo.getXrtInvcSno : " + orderVo.getXrtInvcSno());
        } else {
            JSONObject retMap = (JSONObject) bodyJson.get("response");
            JSONArray errors = (JSONArray) retMap.get("errors");
            resData.put("CODE", "500");
            resData.put("MESSAGE", "총 " + errors.size() + "건의 오류가 발생하였습니다.");
        }
        return resData;
    }

    public LRespData setVoidShipment(LDataMap paramMap) throws Exception {

        LRespData resData = new LRespData();
        List<Map<String, Object>> params = new ArrayList<Map<String, Object>>();
        Date toDay = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String sToDay = dateFormat.format(toDay);
        String xrtInvcSno = paramMap.getString("xrtInvcSno");

        ShippingListVO orderVo = (ShippingListVO) dao.selectOne("upsAPIMapper.getTOrder", paramMap);

        String url = "";
        Map<String, Object> licensMap = new HashMap<String, Object>();
        licensMap.put("key", "AccessLicenseNumber");
        licensMap.put("value", upsAccessKey);
        Map<String, Object> userMap = new HashMap<String, Object>();
        userMap.put("key", "Username");
        userMap.put("value", upsUserName);
        Map<String, Object> passMap = new HashMap<String, Object>();
        passMap.put("key", "Password");
        passMap.put("value", upsPassword);
        Map<String, Object> transMap = new HashMap<String, Object>();
        transMap.put("key", "transId");
        transMap.put("value", sToDay + xrtInvcSno);
        Map<String, Object> transSrcMap = new HashMap<String, Object>();
        transSrcMap.put("key", "transactionSrc");
        transSrcMap.put("value", "tx.logifocus.co.kr");
        params.add(licensMap);
        params.add(userMap);
        params.add(passMap);
        params.add(transMap);
        params.add(transSrcMap);

        if (debugtype.equals("DEV")) {
            url = upsDevUrl + "ship/v1/shipments/cancel/";
        } else {
            url = upsRealUrl + "ship/v1/shipments/cancel/";
        }

        HttpURLConnection httpConn = httpConnectionUtils.setHeader(url + orderVo.getShippoId(), "DELETE", params);

        JSONObject bodyJson = httpConnectionUtils.getErrorResponse(httpConn);
        LDataMap resMap = new ObjectMapper().readValue(bodyJson.toJSONString(), LDataMap.class);
        resMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        return resData;
    }

    public LRespData getTrack(LDataMap paramMap) throws Exception {

        LRespData resData = new LRespData();
        List<Map<String, Object>> params = new ArrayList<Map<String, Object>>();
        Date toDay = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String sToDay = dateFormat.format(toDay);
        String xrtInvcSno = paramMap.getString("xrtInvcSno");

        ShippingListVO orderVo = (ShippingListVO) dao.selectOne("upsAPIMapper.getTOrder", paramMap);

        String url = "";
        Map<String, Object> licensMap = new HashMap<String, Object>();
        licensMap.put("key", "AccessLicenseNumber");
        licensMap.put("value", upsAccessKey);
        Map<String, Object> userMap = new HashMap<String, Object>();
        userMap.put("key", "Username");
        userMap.put("value", upsUserName);
        Map<String, Object> passMap = new HashMap<String, Object>();
        passMap.put("key", "Password");
        passMap.put("value", upsPassword);
        Map<String, Object> transMap = new HashMap<String, Object>();
        transMap.put("key", "transId");
        transMap.put("value", sToDay + xrtInvcSno);
        Map<String, Object> transSrcMap = new HashMap<String, Object>();
        transSrcMap.put("key", "transactionSrc");
        transSrcMap.put("value", "tx.logifocus.co.kr");
        params.add(licensMap);
        params.add(userMap);
        params.add(passMap);
        params.add(transMap);
        params.add(transSrcMap);

        if (debugtype.equals("DEV")) {
            url = upsDevUrl + "track/v1/details/";
        } else {
            url = upsRealUrl + "track/v1/details/";
        }

        HttpURLConnection httpConn = httpConnectionUtils.setHeader(url + orderVo.getInvcSno1(), "GET", params);

        JSONObject bodyJson = httpConnectionUtils.getErrorResponse(httpConn);
        LDataMap upsResMap = new ObjectMapper().readValue(bodyJson.toJSONString(), LDataMap.class);
        upsResMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        if (upsResMap.get("trackResponse") != null) {

            List<Map<String, Object>> shipments = (List<Map<String, Object>>) upsResMap.get("shipment");
            for (int i = 0; i<shipments.size(); i++) {
                Map<String, Object> shipmentMap = shipments.get(i);
                
                shipmentMap.entrySet().forEach(entry -> {
                    logger.info("" + entry.getKey() + " : " + entry.getValue());
                });
            }
            
            Map<String, Object> shipmentMap = shipments.get(0);

            Map<String, Object> packageMap = (Map<String, Object>) shipmentMap.get("package");
            packageMap.entrySet().forEach(entry -> {
                logger.info("" + entry.getKey() + " : " + entry.getValue());
            });

            List<Map<String, Object>> activitys = (List<Map<String, Object>>) packageMap.get("activity");
            for (int i = 0; i < activitys.size(); i++) {
                activitys.get(i).entrySet().forEach(entry -> {
                    logger.info("" + entry.getKey() + " : " + entry.getValue());
                });
            }
 
        } else {
            Map<String, Object> retMap = (Map<String, Object>) upsResMap.get("response");
            retMap.entrySet().forEach(entry -> {
                logger.info("" + entry.getKey() + " : " + entry.getValue());
            });

            List<Map<String, Object>> errors = (List<Map<String, Object>>) retMap.get("errors");
            for (int i = 0; i < errors.size(); i++) {
                errors.get(i).entrySet().forEach(entry -> {
                    logger.info("" + entry.getKey() + " : " + entry.getValue());
                });
            }

            resData.put("CODE", "500");
            resData.put("MESSAGE", "총 " + errors.size() + "건의 오류가 발생하였습니다.");

        }

        return resData;
    }
}
