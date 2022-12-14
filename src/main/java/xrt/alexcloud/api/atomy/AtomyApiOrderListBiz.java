package xrt.alexcloud.api.atomy;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
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
public class AtomyApiOrderListBiz extends DefaultBiz{
    
    private final static Logger logger = LoggerFactory.getLogger(AtomyApiOrderListBiz.class);
    
    private UpsAPIBiz upsAPIBiz;
    
    @Autowired
    public AtomyApiOrderListBiz(UpsAPIBiz upsAPIBiz) {
        this.upsAPIBiz = upsAPIBiz;
    }

    @Value("#{config['c.debugtype']}")
    private String debugtype;
    
    public List<LDataMap> getSearch(CommonSearchVo paramVo) throws Exception{
        return dao.selectList("AtomyOApiOrderListMapper.getSearch", paramVo);
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
        logger.info("atomy api url : " + url + queryString);
        retUrl.setRequestMethod(httpMethod);
        retUrl.setRequestProperty("Content-Type", "application/json;charset=utf-8");
        retUrl.setRequestProperty("Accept", "application/json;charset=utf-8");
        retUrl.setRequestProperty("Atomy-Api-Token", apiToken);
        retUrl.setRequestProperty("Atomy-User-Token", apiUserToken);
        retUrl.setDoOutput(true);
        return retUrl;
    }

    @SuppressWarnings({ "finally", "unchecked" })
    public JSONObject setHttpBody(HttpURLConnection conn, String apiType) throws Exception {
        
        JSONObject retJson = new JSONObject();
        
        try {
            conn.connect();

            // 1. ?????? ?????? ????????? ??????
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
    
    @SuppressWarnings({ "unchecked", "finally" })
    public JSONObject setHttpBody(HttpURLConnection conn, String apiType, StringBuffer reqSB) throws Exception {
        
        logger.info("reqSB : " + reqSB.toString());
        
        JSONObject retJson = new JSONObject();
        
        try {
            conn.connect();

            String encodeSendData = new String(reqSB.toString().getBytes("8859_1"), StandardCharsets.UTF_8);

            // 1. ????????? ??????
            OutputStreamWriter outputStreamWriter = new OutputStreamWriter(conn.getOutputStream(), StandardCharsets.UTF_8);
            outputStreamWriter.write(encodeSendData);
            outputStreamWriter.flush();
            
            // 2. ?????? ?????? ????????? ??????
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

    // 1. ???????????? ?????? ?????? (????????? ??????).
    public LDataMap getTotalcountDirect(CommonSearchVo paramVo) throws Exception {

        LDataMap retMap = new LDataMap();

        logger.info("paramVo.date>>"+paramVo.getsToDate());
        SimpleDateFormat beforeDateFormat = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat afterDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        

        Date dStartDate = beforeDateFormat.parse(paramVo.getsToDate());
        Date dEndDate =  beforeDateFormat.parse(paramVo.getsFromDate());
        
        
        logger.info("?????? : "+dStartDate);
        logger.info("?????? : "+dEndDate);
        
        /*
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        cal.add(cal.DATE, -1); // ????????? ?????? ???.
        String yesterdayDate = dateFormat.format(cal.getTime());
        String startDate = yesterdayDate;
        String endDate = yesterdayDate;
        */
        
        String startDate = afterDateFormat.format(dStartDate);
        String endDate =  afterDateFormat.format(dEndDate);
        
        String queryString = "/apiglobal/scm/kr/v1/request/totalcountDirect?EndDate=" + endDate + "&StartDate=" + startDate;
        
        logger.info("???????????????: "+queryString);
        String httpMethod = "GET";
        String apiType = "totalcountDirect";

        HttpURLConnection conn = this.setHttpHeader(queryString, httpMethod, apiType);
        JSONObject jsonObject = this.setHttpBody(conn, apiType);

        LDataMap resMap = new ObjectMapper().readValue(jsonObject.toJSONString(), LDataMap.class);
        logger.info("[1. getTotalcountDirect (?????????????????? ??????)]");
        resMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        String status = resMap.getString("Status");
        String statusDetailCode = resMap.getString("StatusDetailCode");
        String data = resMap.getString("Data");

        retMap.put("apiType", apiType);
        retMap.put("Status", status.toString());
        retMap.put("StatusDetailCode", statusDetailCode.toString());
        retMap.put("Data", data);
        
        // dao.insert("atomyAPIMapper.insertApiHistory", retMap);

        return retMap;
    }

    // 2. ???????????? ?????? ??????.
    public LDataMap getOrderList(String data, CommonSearchVo paramVo) throws Exception {
        LDataMap returnMap = new LDataMap();
        LDataMap retMap = new LDataMap();

        SimpleDateFormat beforeDateFormat = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat afterDateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Date dStartDate = beforeDateFormat.parse(paramVo.getsToDate());
        Date dEndDate =  beforeDateFormat.parse(paramVo.getsFromDate());

        String startDate = afterDateFormat.format(dStartDate);
        String endDate =  afterDateFormat.format(dEndDate);
        
        /*
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        cal.add(cal.DATE, -1); // ????????? ?????? ???.
        String yesterdayDate = dateFormat.format(cal.getTime());
        String startDate = yesterdayDate;
        String endDate = yesterdayDate;
        */

        String atomyOrgcd = CommonConst.ATOMY_DEV_ORGCD;
        String queryString = "";
        String httpMethod = "GET";
        String apiType = "requestDirect";
        String status = "";
        String statusDetailCode = "";

        int insertCount = 0;
        int totalCount = Integer.parseInt(data);
        int pageSize = 200;
        int pageNo = (totalCount / pageSize) + 1;
        
        if (debugtype.equals("REAL")) {
            atomyOrgcd = CommonConst.ATOMY_REAL_ORGCD;
        }

        for (int i = 1; i <= pageNo; i++) {
            queryString = "/apiglobal/scm/kr/v1/requestDirect?StartDate=" + startDate + "&EndDate=" + endDate + "&PageSize=" + pageSize + "&PageNo=" + i;

            HttpURLConnection conn = this.setHttpHeader(queryString, httpMethod, apiType);
            JSONObject jsonObject = this.setHttpBody(conn, apiType);

            JSONParser jsonParser = new JSONParser();
            status = jsonObject.get("Status").toString();
            if (status.equals("1")) {
                JSONArray jData = (JSONArray) jsonParser.parse(jsonObject.get("Data").toString());
                insertCount += jData.size();
                for (int j = 0; j < jData.size(); j++) {
                    JSONObject jObject = (JSONObject) jData.get(j);
                    LDataMap responseMap = new ObjectMapper().readValue(jObject.toJSONString(), LDataMap.class);
                    
                    if (responseMap.getString("NationCode").equals("UK")) {
                        responseMap.put("NationCode", "GB");
                    }
                    
                    responseMap.put("compcd", CommonConst.XROUTE_COMPCD);
                    responseMap.put("orgcd", atomyOrgcd);
                    responseMap.put("addusercd", "SYSTEM");
                    responseMap.put("updusercd", "SYSTEM");
                    responseMap.put("terminalCd", "127.0.0.1");
                    responseMap.put("shipments", "1");
                    
                    logger.info("[2. getOrderList (??????????????????)]");
                    responseMap.entrySet().forEach(entry -> {
                        logger.info("" + entry.getKey() + " : " + entry.getValue());
                    });
                    logger.info("================================================");
                    // ????????? ?????? ???????????? ?????? ?????? ??????.
                    dao.update("AtomyOApiOrderListMapper.setOrderList", responseMap);
                }
            }

            LDataMap resMap = new ObjectMapper().readValue(jsonObject.toJSONString(), LDataMap.class);
            logger.info("[2. jsonObject]");
            resMap.entrySet().forEach(entry -> {
                logger.info("" + entry.getKey() + " : " + entry.getValue());
            });
            logger.info("================================================");
        }

        retMap.put("apiType", apiType);
        retMap.put("Status", status.toString());
        retMap.put("StatusDetailCode", statusDetailCode.toString());
        retMap.put("Data", insertCount);
        retMap.put("startDate", startDate);
        retMap.put("endDate", endDate);

        dao.insert("AtomyOApiOrderListMapper.insertApiHistory", retMap);
        
        // ?????? ????????? ????????? ???????????? ??????.
        List<LDataMap> deleteOrderList = dao.selectList("AtomyOApiOrderListMapper.orderCancelList", retMap);
        
        for (int i = 0; i < deleteOrderList.size(); i++) {
            LDataMap deleteMap = deleteOrderList.get(i);
            dao.update("AtomyOApiOrderListMapper.updateOrderCancel", deleteMap);
        }
        
        List<LDataMap> atomyOrderList = dao.selectList("AtomyOApiOrderListMapper.getAtomyOrderList", retMap);

        returnMap.put("Status", status.toString());
        returnMap.put("StatusDetailCode", statusDetailCode.toString());
        returnMap.put("Data", atomyOrderList);
        return returnMap;
    }
    
    public LDataMap getLastOrderList(String data, CommonSearchVo paramVo) throws Exception {
        LDataMap returnMap = new LDataMap();
        LDataMap retMap = new LDataMap();

        SimpleDateFormat beforeDateFormat = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat afterDateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Date dStartDate = beforeDateFormat.parse(paramVo.getsToDate());
        Date dEndDate =  beforeDateFormat.parse(paramVo.getsFromDate());

        String startDate = afterDateFormat.format(dStartDate);
        String endDate =  afterDateFormat.format(dEndDate);

        String atomyOrgcd = CommonConst.ATOMY_DEV_ORGCD;
        String queryString = "";
        String httpMethod = "GET";
        String apiType = "requestDirect";
        String status = "";
        String statusDetailCode = "";

        int insertCount = 0;
        int totalCount = Integer.parseInt(data);
        int pageSize = 200;
        int pageNo = (totalCount / pageSize) + 1;
        
        if (debugtype.equals("REAL")) {
            atomyOrgcd = CommonConst.ATOMY_REAL_ORGCD;
        }

        for (int i = 1; i <= pageNo; i++) {
            queryString = "/apiglobal/scm/kr/v1/requestDirect?StartDate=" + startDate + "&EndDate=" + endDate + "&PageSize=" + pageSize + "&PageNo=" + i;

            HttpURLConnection conn = this.setHttpHeader(queryString, httpMethod, apiType);
            JSONObject jsonObject = this.setHttpBody(conn, apiType);

            JSONParser jsonParser = new JSONParser();
            status = jsonObject.get("Status").toString();
            if (status.equals("1")) {
                JSONArray jData = (JSONArray) jsonParser.parse(jsonObject.get("Data").toString());
                insertCount += jData.size();
                for (int j = 0; j < jData.size(); j++) {
                    JSONObject jObject = (JSONObject) jData.get(j);
                    LDataMap responseMap = new ObjectMapper().readValue(jObject.toJSONString(), LDataMap.class);
                    
                    if (responseMap.getString("NationCode").equals("UK")) {
                        responseMap.put("NationCode", "GB");
                    }
                    
                    responseMap.put("compcd", CommonConst.XROUTE_COMPCD);
                    responseMap.put("orgcd", atomyOrgcd);
                    responseMap.put("addusercd", "SYSTEM");
                    responseMap.put("updusercd", "SYSTEM");
                    responseMap.put("terminalCd", "127.0.0.1");
                    responseMap.put("shipments", "1");
                    
                    logger.info("[2. getOrderList (??????????????????)]");
                    responseMap.entrySet().forEach(entry -> {
                        logger.info("" + entry.getKey() + " : " + entry.getValue());
                    });
                    logger.info("================================================");
                    // ????????? ?????? ???????????? ?????? ?????? ??????.
                    dao.update("AtomyOApiOrderListMapper.setLastOrderList", responseMap);
                }
            }

            LDataMap resMap = new ObjectMapper().readValue(jsonObject.toJSONString(), LDataMap.class);
            logger.info("[2. jsonObject]");
            resMap.entrySet().forEach(entry -> {
                logger.info("" + entry.getKey() + " : " + entry.getValue());
            });
            logger.info("================================================");
        }

        retMap.put("apiType", apiType);
        retMap.put("Status", status.toString());
        retMap.put("StatusDetailCode", statusDetailCode.toString());
        retMap.put("Data", insertCount);
        retMap.put("startDate", startDate);
        retMap.put("endDate", endDate);

        dao.insert("AtomyOApiOrderListMapper.insertApiHistory", retMap);
        
        // ?????? ????????? ????????? ???????????? ??????.
        List<LDataMap> deleteOrderList = dao.selectList("AtomyOApiOrderListMapper.orderCancelList", retMap);
        
        for (int i = 0; i < deleteOrderList.size(); i++) {
            LDataMap deleteMap = deleteOrderList.get(i);
            dao.update("AtomyOApiOrderListMapper.updateOrderCancel", deleteMap); // ????????? ???????????? ????????????.
        }
        
        // ???????????? ?????? ?????? ????????? ???????????? ?????????.
        List<LDataMap> atomyOrderList = dao.selectList("AtomyOApiOrderListMapper.getAtomyOrderList", retMap);
        
        returnMap.put("Status", status.toString());
        returnMap.put("StatusDetailCode", statusDetailCode.toString());
        returnMap.put("Data", atomyOrderList);
        return returnMap;
    }

    public void insertApiHistory(LDataMap paramMap) throws Exception {
        logger.info("[insertApiHistory]");
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        logger.info("================================================");
        dao.insert("AtomyOApiOrderListMapper.insertApiHistory", paramMap);
    }

    public List<LDataMap> getGroupByOrderList(CommonSearchVo paramVo) throws Exception {
        
        /*SimpleDateFormat beforeDateFormat = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat afterDateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Date dStartDate = beforeDateFormat.parse(paramVo.getsToDate());
        Date dEndDate =  beforeDateFormat.parse(paramVo.getsFromDate());

        String startDate = afterDateFormat.format(dStartDate);
        String endDate =  afterDateFormat.format(dEndDate);*/

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        cal.add(cal.DATE, -1); // ????????? ?????? ???.
        String yesterdayDate = dateFormat.format(cal.getTime());
        String startDate = yesterdayDate;
        String endDate = yesterdayDate;
        
        LDataMap param = new LDataMap();
        param.put("sToDate", startDate);
        param.put("sFromDate", endDate);
        return dao.select("AtomyOApiOrderListMapper.getGroupByOrderList", param);
    }

    public LDataMap preTorderData(List<LDataMap> atomyGroupByOrderList) throws Exception {
        
        List<LDataMap> successList = new ArrayList<>();
        
        String code = "";
        String message = "";
        int totalCount = 0;
        int dasNo = 1;
        int pickingPage = 0;

        for (int i = 0; i < atomyGroupByOrderList.size(); i++) {
            LDataMap param = atomyGroupByOrderList.get(i);
            List<LDataMap> atomyOrderDtlList = dao.select("AtomyOApiOrderListMapper.getAtomyOrderDtlList", param);
            LDataMap orderDtlMap = atomyOrderDtlList.get(0);
            int rowNum = param.getInt("rowNum");
            pickingPage =  (int) Math.ceil(rowNum / 10.0);
            logger.info("rowNum : " + rowNum + ", pickingPage : " + pickingPage);

            // ????????? ?????? ??????(retMap.atomyOrderList)?????? ????????????, ????????????, ?????????????????? ?????? ?????? ??? ?????? ?????????, ?????? ????????? ????????? ???????????? ??????.
            LDataMap atomyBoxRateMap = getAtomyBoxRate(orderDtlMap);
            code = atomyBoxRateMap.getString("code");
            message = atomyBoxRateMap.getString("message");
            if (code.equals("200")) {
                orderDtlMap.put("xrtShippingPrice", atomyBoxRateMap.getString("price"));
                orderDtlMap.put("boxNo", atomyBoxRateMap.getString("box"));
                orderDtlMap.put("boxInfo", (AtomyBoxSizeVO) atomyBoxRateMap.get("boxInfo"));
                orderDtlMap.put("dasNo", dasNo + "");
                orderDtlMap.put("pickingPage", String.valueOf(pickingPage));
                orderDtlMap.put("localShipper", atomyBoxRateMap.getString("localShipper"));
                setXrtOrder(orderDtlMap, atomyOrderDtlList);
                successList.add(param);
                
                if (dasNo == 10) {
                    dasNo = 1;
                } else {
                    dasNo++;
                }
            }
        }

        if (code.equals("200")) {
            for (int i = 0; i < successList.size(); i++) {
                LDataMap updParam = successList.get(i);
                totalCount += dao.update("AtomyOApiOrderListMapper.updateAtomyOrder", updParam);
            }
            
            LDataMap retMap = new LDataMap();
            retMap.put("code", "200");
            retMap.put("message", totalCount + "?????? ?????????????????????.");
            return retMap;
        }else {
            LDataMap retMap = new LDataMap();
            retMap.put("code", code);
            retMap.put("message", message);
            return retMap;
        }
    }
    
    // ?????? ?????? ??? ????????? ??????.
    public LDataMap getAtomyBoxRate(LDataMap boxParam) throws Exception {
        AtomyBoxSizeVO atomyBoxSizeVO = new AtomyBoxSizeVO();
        atomyBoxSizeVO.setWidth(boxParam.getString("totalWidth"));
        atomyBoxSizeVO.setLength(boxParam.getString("totalLength"));
        atomyBoxSizeVO.setHeight(boxParam.getString("totalHeight"));
        atomyBoxSizeVO.setCbm(boxParam.getString("totalCbm"));

        if (boxParam.getFloat("totalKg") > boxParam.getFloat("totalVolumeWeight")) {
            atomyBoxSizeVO.setWeight(boxParam.getString("totalKg"));
        } else {
            atomyBoxSizeVO.setWeight(boxParam.getString("totalVolumeWeight"));
        }

        // 4. ????????? ?????? ?????? ????????????.
        AtomyBoxSizeVO resultBoxSizeVO = (AtomyBoxSizeVO) dao.selectOne("AtomyOApiOrderListMapper.getBoxInfo", atomyBoxSizeVO);
        
        if (resultBoxSizeVO == null) {
            LDataMap retMap = new LDataMap();
            retMap.put("code", "500");
            retMap.put("message", "?????? ?????? ????????? ?????????????????????");
            return retMap;
        }else {
            
            AtomyAPIParamVO apiParamVO = new AtomyAPIParamVO();
            
            switch (boxParam.getString("nationCode")) {
                case "IT": // ????????????
                case "AU": // ??????
                case "HK": // ??????
                case "JP": // ??????
                case "MY": // ???????????????
                case "MN": // ??????
                case "NZ": // ????????????
                case "SG": // ?????????
                case "TW": // ??????
                case "US": // ??????
                case "CA": // ?????????
                case "FR": // ?????????
                case "DE": // ??????
                case "CH": // ?????????
                case "GB": // ??????
                case "KH": // ????????????
                case "TH": // ??????
                case "PH": // ?????????
                case "ES": // ?????????
                case "PT": // ????????????
                case "RU": // ?????????
                    apiParamVO.setCountry(boxParam.getString("nationCode"));

                    // 5. ??????????????? ZONE ?????? ????????????.
                    AtomyCountryZoneVO atomyCountryZoneVO = (AtomyCountryZoneVO) dao.selectOne("AtomyOApiOrderListMapper.getCountry", apiParamVO);
                    String countryName = atomyCountryZoneVO.getCountryName().toUpperCase(); // ?????????.
                    String localShipper = atomyCountryZoneVO.getLocalShipper(); // ????????? ?????????.

                    AtomyRateVO atomyRateVO = new AtomyRateVO(); // ????????? ?????? ?????? VO.
                    atomyRateVO.setKg(resultBoxSizeVO.getWeight()); // ?????? ??????.
                    atomyRateVO.setCountryName(countryName);; // ?????????.

                    // 6. ????????? ????????? ????????? ????????????. ?????????/????????? ????????? ??????.
                    AtomyRateVO resultAtomyRate = (AtomyRateVO) dao.selectOne("AtomyOApiOrderListMapper.getRate", atomyRateVO);

                    // 7. ???????????? API ???????????? ????????? + ?????? ?????? ?????? + ?????? ?????? ??????.
                    LDataMap retMap = new LDataMap();
                    retMap.put("code", "200");
                    retMap.put("message", "success"); // ????????? : ?????? (success), ??????(failed).
                    retMap.put("price", String.format("%,d", Integer.parseInt(resultAtomyRate.getPrice()))); // ?????????.
                    retMap.put("box", resultBoxSizeVO.getNo()); // ?????? ??????.
                    retMap.put("boxInfo", resultBoxSizeVO); // ?????? ??????.
                    retMap.put("localShipper", localShipper); // ????????? ??????.
                    return retMap;
                default:
                    LDataMap errMap = new LDataMap();
                    errMap.put("code", "500");
                    errMap.put("message", "????????? ????????? ?????? ????????? ????????????.");
                    return errMap;
            }
        }
    }

    // XROUTE ???????????? ??????.
    public LDataMap setXrtOrder(LDataMap orderDtlMap, List<LDataMap> atomyOrderDtlList) throws Exception {
        String compcd = CommonConst.XROUTE_COMPCD;
        String orgcd = CommonConst.ATOMY_DEV_ORGCD;
        String whcd = CommonConst.ATOMY_DEV_WHCD;

        if (debugtype.equals("REAL")) {
            orgcd = CommonConst.ATOMY_REAL_ORGCD;
            whcd = CommonConst.ATOMY_REAL_WHCD;
        }

        // Date uploadDate = new Date();
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat uploadDateFormat = new SimpleDateFormat("yyyyMMdd");
        cal.add(cal.DATE, -1); // ????????? ?????? ???.
        String uploadDate = uploadDateFormat.format(cal.getTime());

        LDataMap commonMap = new LDataMap();
        commonMap.put("compcd", compcd);
        commonMap.put("orgcd", orgcd);
        commonMap.put("whcd", whcd);
        commonMap.put("fileYmd", uploadDate);

        // List<LDataMap> sellerList = dao.select("atomyAPIMapper.getSeller", commonMap); // ?????? ??????.
        int fileSeq = (Integer) dao.selectOne("atomyAPIMapper.getTorderFileSeq", commonMap) + 1;
        int relayCount = (Integer) dao.selectOne("atomyAPIMapper.getTorderRelaySeq", commonMap) + 1;
        int fileRelayCount = 1;

        // ?????? ?????? : mm -> cm
        int cmWidth = Integer.parseInt(((AtomyBoxSizeVO) orderDtlMap.get("boxInfo")).getWidth().trim()) / 10;
        int cmLength = Integer.parseInt(((AtomyBoxSizeVO) orderDtlMap.get("boxInfo")).getLength().trim()) / 10;
        int cmHeight = Integer.parseInt(((AtomyBoxSizeVO) orderDtlMap.get("boxInfo")).getHeight().trim()) / 10;
        
        Double dTotalKg = Double.parseDouble(orderDtlMap.getString("totalKg"));
        // Double dTotPaymentPrice = Double.parseDouble(orderDtlMap.getString("totalPrice"));
        DecimalFormat decimalFormat = new DecimalFormat("#.##");
        String totalKg = decimalFormat.format(dTotalKg);
        // String totPaymentPrice = decimalFormat.format(dTotPaymentPrice);
        
        String nationCode = orderDtlMap.getString("nationCode").toUpperCase();
        
        // ????????? ?????? ?????? -> TORDER ?????? ??????.
        TOrderVo tOrderVo = new TOrderVo();
        tOrderVo.setCompcd(compcd);
        tOrderVo.setOrgcd(orgcd);
        tOrderVo.setWhcd(whcd);
        tOrderVo.setUploadDate(uploadDate); // TORDER UPDATE.
        tOrderVo.setFileSeq(Integer.toString(fileSeq).trim());
        tOrderVo.setFileNm(Integer.toString(fileSeq).trim() + "???");
        tOrderVo.setFileNmReal("ATOMY Order Upload");
        tOrderVo.setPaymentType(CommonConst.PAYEMNT_TYPE_WARRANTY); // 4
        tOrderVo.setSiteCd("30112");
        tOrderVo.setStatusCd(CommonConst.ORD_STATUS_CD_ORDER_APPLY); // 10.
        tOrderVo.setStockType(CommonConst.STOCK_TYPE_CENTER); // 1.
        tOrderVo.setMallNm(CommonConst.ATOMY_USERCD); // ATOMY.
        tOrderVo.setLocalShipper(orderDtlMap.getString("localShipper")); // ?????????.
        tOrderVo.setShipMethodCd("DHL");
        tOrderVo.setOrdNo(orderDtlMap.getString("saleNum"));
        tOrderVo.setCartNo(orderDtlMap.getString("orderId"));
        tOrderVo.setOrdCnt(orderDtlMap.getString("ordCnt"));
        tOrderVo.setsNation("KR");
        tOrderVo.seteNation(orderDtlMap.getString("nationCode").toUpperCase());
        tOrderVo.setcWgtReal(totalKg); // ?????? ????????? ??????.
        tOrderVo.setWgt(((AtomyBoxSizeVO) orderDtlMap.get("boxInfo")).getWeight()); // ?????? ??????.
        tOrderVo.setBoxWidth(Integer.toString(cmWidth).trim()); // ?????? ??????.
        tOrderVo.setBoxLength(Integer.toString(cmLength).trim()); // ?????? ??????.
        tOrderVo.setBoxHeight(Integer.toString(cmHeight).trim()); // ?????? ??????.
        tOrderVo.setBoxVolume(((AtomyBoxSizeVO) orderDtlMap.get("boxInfo")).getCbm()); // ?????? ??????.
        tOrderVo.setShipName(CommonConst.ATOMY_USERCD);
        tOrderVo.setShipTel("1544-8580"); // ????????? ????????????.
        tOrderVo.setShipMobile("");
        tOrderVo.setShipAddr("???????????? ????????? ??????????????? 2148-21"); // ????????? ??????.
        tOrderVo.setShipPost("32543"); // ????????? ????????????.
        tOrderVo.setRecvName(orderDtlMap.getString("deliName"));
        tOrderVo.setRecvTel(orderDtlMap.getString("phoneNo"));
        tOrderVo.setRecvMobile(orderDtlMap.getString("handPhone"));
        tOrderVo.setRecvAddr1(orderDtlMap.getString("addr4"));
        tOrderVo.setRecvAddr2(orderDtlMap.getString("addr3").equals("") ? "." : orderDtlMap.getString("addr3"));
        tOrderVo.setRecvCity(orderDtlMap.getString("addr2"));
        tOrderVo.setRecvState(nationCode.equals("US") || nationCode.equals("CA") ? orderDtlMap.getString("addr1") : orderDtlMap.getString("nationCode").toUpperCase());
        tOrderVo.setRecvPost(orderDtlMap.getString("postNo"));
        tOrderVo.setRecvNation(orderDtlMap.getString("nationCode").toUpperCase());
        tOrderVo.setRecvCurrency(orderDtlMap.getString("excCur"));
        tOrderVo.setAddusercd(CommonConst.ATOMY_USERCD);
        tOrderVo.setUpdusercd(CommonConst.ATOMY_USERCD);
        tOrderVo.setTerminalcd("127.0.0.1");
        tOrderVo.setRelaySeq(relayCount);
        tOrderVo.setFileRelaySeq(fileRelayCount);
        tOrderVo.setTotPaymentPrice(orderDtlMap.getString("totalPrice")); // ?????? ??? ?????? ??????.
        tOrderVo.setXrtShippingPrice(orderDtlMap.getString("xrtShippingPrice").replace(",", "")); // ?????????.
        tOrderVo.setBoxNo(orderDtlMap.getString("boxNo")); // ?????? ??????.
        tOrderVo.setDasNo(orderDtlMap.getString("dasNo"));
        tOrderVo.setPickingPage(orderDtlMap.getString("pickingPage"));
        tOrderVo.setPickingSeq(orderDtlMap.getString("dasNo"));
        tOrderVo.setClgoScanYn("N");
        
        // 1. TORDER ???????????? ????????? ?????? ?????? ??????.
        dao.insert("AtomyOApiOrderListMapper.insertOrder", tOrderVo);
        logger.info("XROUTE-TORDER ?????? ?????? ?????? ??????");

        for (int i = 0; i < atomyOrderDtlList.size(); i++) {

            String materialCode = atomyOrderDtlList.get(i).getString("materialCode");
            String materialName = atomyOrderDtlList.get(i).getString("materialName");
            String enProductName = atomyOrderDtlList.get(i).getString("enProductName");
            String saleQty = atomyOrderDtlList.get(i).getString("saleQty");
            String salePrice = atomyOrderDtlList.get(i).getString("salePrice");

            TOrderDtlVo orderDtlVo = new TOrderDtlVo();
            orderDtlVo.setOrdCd(tOrderVo.getOrdCd());
            orderDtlVo.setOrdSeq(atomyOrderDtlList.get(i).getLong("seq"));
            orderDtlVo.setCompcd(compcd);
            orderDtlVo.setOrgcd(orgcd);
            orderDtlVo.setGoodsCd(materialCode);
            orderDtlVo.setGoodsNm(materialName);
            orderDtlVo.setGoodsEnNm(enProductName);
            orderDtlVo.setGoodsOption("");
            orderDtlVo.setGoodsCnt(saleQty);
            orderDtlVo.setPaymentPrice(salePrice); // ?????? ?????? ??????(??????).
            orderDtlVo.setPaymentPriceUsd(atomyOrderDtlList.get(i).getString("excAmt")); // ?????? ?????? ??????(??????).
            orderDtlVo.setAddusercd(CommonConst.ATOMY_USERCD);
            orderDtlVo.setUpdusercd(CommonConst.ATOMY_USERCD);
            orderDtlVo.setTerminalcd("127.0.0.1");
            orderDtlVo.setDelFlg("N");
            orderDtlVo.setOrdNo(orderDtlMap.getString("saleNum"));
            orderDtlVo.setExcTagSum(atomyOrderDtlList.get(i).getString("excTagSum")); // ?????? ?????????.
            orderDtlVo.setExcTotSum(atomyOrderDtlList.get(i).getString("excTotSum")); // ?????? ????????????. (????????? + ?????????).
            orderDtlVo.setSaleTagSum(atomyOrderDtlList.get(i).getString("saleTagSum")); // ?????? ?????????.
            orderDtlVo.setSaleTotSum(atomyOrderDtlList.get(i).getString("saleTotSum")); // ?????? ????????????. (????????? + ?????????).
            
            // 2. TORDERDTL ???????????? ????????? ?????? ?????? ??????.
            dao.insert("AtomyOApiOrderListMapper.insertOrderDtl", orderDtlVo);
            logger.info("XROUTE-TORDERDTL ?????? ?????? ?????? ??????");
        }

        TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
        trackingHistorytVO.setXrtInvcSno(tOrderVo.getXrtInvcSno());
        trackingHistorytVO.seteNation("KR");
        trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_ORDER_APPLY); // 10(????????????)
        trackingHistorytVO.setStatusNm("????????????????????????");
        trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_ORDER_APPLY);
        trackingHistorytVO.setAddusercd(CommonConst.ATOMY_USERCD);
        trackingHistorytVO.setUpdusercd(CommonConst.ATOMY_USERCD);
        trackingHistorytVO.setTerminalcd("127.0.0.1");

        // 3. ????????? ??????????????? ????????? ?????? ?????? ??????.
        dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
        logger.info("TRACKING_HISTORY ????????? ?????? ??????");

        relayCount++;
        fileRelayCount++;

        Thread.sleep(100);
        LDataMap retMap = new LDataMap();
        retMap.put("code", "200");
        retMap.put("message", "XROUTE ?????? ?????? ?????? ?????????????????????.");
        return retMap;
    }

    // ?????????????????? ???????????? API- Xroute ???????????? ??????.
    public LDataMap setAtomyStatusUpdate(CommonSearchVo paramVo) throws Exception {
        
        String orgcd = CommonConst.ATOMY_DEV_ORGCD;

        if (debugtype.equals("REAL")) {
            orgcd = CommonConst.ATOMY_REAL_ORGCD;
        }
        
        /*
        Date todayDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String today = dateFormat.format(todayDate);
        */
        
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        cal.add(cal.DATE, -1); // ????????? ?????? ???.
        String yesterdayDate = dateFormat.format(cal.getTime());

        LDataMap paramMap = new LDataMap();
        paramMap.put("todayDate", yesterdayDate);
        paramMap.put("orgCd", orgcd);

        List<LDataMap> bodyList = dao.select("AtomyOApiOrderListMapper.getAtomyStatusList", paramMap);
        
        if (bodyList.size() == 0) {
            LDataMap retMap = new LDataMap();
            retMap.put("code", "0"); // ??????. 1?????? ??????. 0?????? ??????.
            retMap.put("message", "??????????????? ???????????? ????????????.");
            return retMap;
        }else {
            
            // ????????? api ??????
            StringBuffer sb = new StringBuffer();
            sb.append("[");
            for (int i = 0; i < bodyList.size(); i++) {
                sb.append("{");
                sb.append("\"SaleNum\": \"" + bodyList.get(i).getString("ordNo") + "\",");
                sb.append("\"Seq\": \"" + bodyList.get(i).getString("ordSeq") + "\",");
                sb.append("\"XRoot\": \"" + bodyList.get(i).getString("xrtInvcSno") + "\"");
                if ((i + 1) == bodyList.size()) {
                    sb.append("}");
                } else {
                    sb.append("},");
                }
            }
            sb.append("]");
            
            String queryString = "/apiglobal/scm/kr/v1/status/requestconfirmDirect";
            String apiType = "requestconfirmDirect";
            String httpMethod = "PUT";

            // ????????? API??????
            HttpURLConnection conn = this.setHttpHeader(queryString, httpMethod, apiType);
            JSONObject jsonObject = this.setHttpBody(conn, apiType, sb);

            LDataMap resMap = new ObjectMapper().readValue(jsonObject.toJSONString(), LDataMap.class);
            resMap.entrySet().forEach(entry -> {
                logger.info("" + entry.getKey() + " : " + entry.getValue());
            });
            
            // ?????????????????? ???????????? API ?????? ????????? ???????????? ???????????? ????????? ????????????.
            List<LDataMap> sendingWaitList = dao.select("AtomyOApiOrderListMapper.getAtomySendingWaitList", paramMap);
            
            for (int i = 0; i < sendingWaitList.size(); i++) {
                LDataMap updMap = new LDataMap();
                updMap.put("xrtInvcSno", sendingWaitList.get(i).getString("xrtInvcSno"));
                updMap.put("statusCd", CommonConst.ORD_STATUS_CD_SENDING_WAIT); // ???????????? ??????.
                updMap.put("usercd", LoginInfo.getUsercd());
                dao.update("AtomyOApiOrderListMapper.updateTorder", updMap);
                Thread.sleep(100);
                
                TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
                trackingHistorytVO.setXrtInvcSno(sendingWaitList.get(i).getString("xrtInvcSno"));
                trackingHistorytVO.seteNation("KR");
                trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_SENDING_WAIT); // ???????????? ??????.
                trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_SENDING_WAIT); // ???????????? ??????.
                trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_SENDING_WAIT); // ???????????? ??????.
                trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
                trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
                trackingHistorytVO.setTerminalcd("127.0.0.1");
                dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
            }
            
            LDataMap retMap =  new LDataMap();
            retMap.put("code", "1");
            retMap.put("message", bodyList.size() + "??? ?????????????????? ???????????? API ??????");
            return retMap;
        }
    }

    public LDataMap setUpsShipments(List<LDataMap> dataList) throws Exception{
        
        int result = 0;
        int count = 0;
        String errXrtInvcSno = ""; // UPS ?????? ????????????.

        String orgcd = CommonConst.ATOMY_DEV_ORGCD;

        if (debugtype.equals("REAL")) {
            orgcd = CommonConst.ATOMY_REAL_ORGCD;
        }
        
        LDataMap paramMap = new LDataMap();
        paramMap.put("orgCd", orgcd);
        paramMap.put("dataList", dataList);

        // 210623 : ?????????API + UPS API??????
        // UPS Shipment API ????????? ??????.
        List<LDataMap> orderY = dao.select("AtomyOApiOrderListMapper.getOrderY", paramMap);

        for (int i = 0; i < orderY.size(); i++) {

            try {
                LRespData upsData = upsAPIBiz.setShipments(orderY.get(i));
                LDataMap packageResultsMap = (LDataMap) upsData.get("packageResultsMap");

                String invcSno1 = packageResultsMap.get("TrackingNumber").toString();

                Map<String, Object> shippingLabelMap = (Map<String, Object>) packageResultsMap.get("ShippingLabel");
                String graphicImage = shippingLabelMap.get("GraphicImage").toString();
                String htmlImage = shippingLabelMap.get("HTMLImage").toString();

                byte[] decodedByteG = Base64.getDecoder().decode(graphicImage);
                byte[] decodedByteH = Base64.getDecoder().decode(htmlImage);

                Blob blobGraphicImg = new SerialBlob(decodedByteG);
                String decodedString = new String(decodedByteH, StandardCharsets.UTF_8);

                String imgSrc = "";
                Document doc = Jsoup.parse(decodedString);
                Elements imgs = doc.getElementsByTag("img");
                if (imgs.size() > 0) {
                    imgSrc = imgs.get(0).attr("src");
                }

                LDataMap updateMap = new LDataMap();
                updateMap.put("xrtInvcSno", upsData.get("xrtInvcSno"));
                updateMap.put("invcSno1", invcSno1);
                updateMap.put("graphicImage", blobGraphicImg);
                updateMap.put("htmlImage", imgSrc);
                result = dao.update("AtomyOApiOrderListMapper.torderUpsUpdate", updateMap);
                logger.info("UPS ?????? ????????? ?????? ??????.");
            } catch (Exception e) {
                errXrtInvcSno = orderY.get(i).getString("xrtInvcSno");
                LDataMap errMap = new LDataMap();
                errMap.put("xrtInvcSno", errXrtInvcSno);

                dao.update("AtomyOApiOrderListMapper.upsError", errMap);
                logger.info("?????? ???????????? ??????");
                count++;
            }
        }

        LDataMap retMap = new LDataMap();
        retMap.put("code", "1"); // ??????. 1?????? ??????. 0?????? ??????.
        retMap.put("message", "UPS ?????? ??????  ??? " + Integer.toString(orderY.size()) + "??? ??? ?????? : " + Integer.toString(orderY.size() - count) + "???, ?????? : " + count + "???.");
        return retMap;
    }
}
