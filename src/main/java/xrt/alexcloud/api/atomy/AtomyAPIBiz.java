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
import xrt.fulfillment.atomy.AtomyProductVO;
import xrt.fulfillment.atomy.AtomyRateVO;
import xrt.fulfillment.interfaces.vo.TOrderDtlVo;
import xrt.fulfillment.interfaces.vo.TOrderVo;
import xrt.fulfillment.tracking.TrackingHistorytVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;;

@Service
public class AtomyAPIBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(AtomyAPIBiz.class);

    @Value("#{config['c.debugtype']}")
    private String debugtype;
    
    private UpsAPIBiz upsAPIBiz;
    
    @Autowired
    public AtomyAPIBiz(UpsAPIBiz upsAPIBiz) {
        this.upsAPIBiz = upsAPIBiz;
    }
    
    public LDataMap valid(AtomyAPIParamVO paramVO) throws Exception{
        
        // 파라메터 값 체크.
        if (paramVO.getCountry() == null || paramVO.getCountry().equals("")) {
            throw new LingoException("국가코드를 입력하세요.");
        }
        
        if (paramVO.getProducts() != null && paramVO.getProducts().size() != 0) {
            for (AtomyAPIParamVO product : paramVO.getProducts()) {
                if (product.getProductCode() == null || product.getProductCode().equals("")) {
                    throw new LingoException("상품코드를 입력하세요.");
                }
                if (product.getProductCount() == null || product.getProductCount().equals("")) {
                    throw new LingoException("상품수량을 입력하세요.");
                }
            }
        }else {
            if (paramVO.getProductCode() == null || paramVO.getProductCode().equals("")) {
                throw new LingoException("상품코드를 입력하세요.");
            }
            if (paramVO.getProductCount() == null || paramVO.getProductCount().equals("")) {
                throw new LingoException("상품수량을 입력하세요.");
            }
            
            AtomyAPIParamVO apiParamVO = new AtomyAPIParamVO();
            apiParamVO.setProductCode(paramVO.getProductCode());
            apiParamVO.setProductCount(paramVO.getProductCount());
            
            List<AtomyAPIParamVO> paramVOList = new ArrayList<AtomyAPIParamVO>();
            paramVOList.add(apiParamVO);
            paramVO.setProducts(paramVOList);
        }
        
        LDataMap resultMap = new LDataMap();
        resultMap.put("code", "1");
        resultMap.put("message", "success");
        resultMap.put("validVO", paramVO);
        return resultMap;
    }
    
    public LDataMap getRate(AtomyAPIParamVO paramVO) throws Exception {
        // 1. 제품 별 가로,세로,길이,무게,중량을 상품 구매 갯수에 대한 총 합계.
        AtomyProductVO atomyProductVO = (AtomyProductVO) dao.selectOne("atomyAPIMapper.getProduct", paramVO.getProducts());
        
        if (atomyProductVO == null) {
            throw new LingoException("존재하지 않는 상품코드입니다. 상품 코드를 다시 확인하세요.");
        }
        
        String sumLength = atomyProductVO.getLength(); // 총 세로.
        String sumWidth = atomyProductVO.getWidth(); // 총 가로.
        String sumHeight = atomyProductVO.getHeight(); // 총 높이.
        String sumKg = atomyProductVO.getKg(); // 총 무게.
        String sumCbm = atomyProductVO.getCbm(); // 총 체적.
        String sumVolumeWeight = atomyProductVO.getVolumeWeight(); // 총 부피 중량.

        // 2. 박스 1개의 가로, 세로, 높이, 실중량 및 부피 계산.
        Double sumKgF = Double.parseDouble(sumKg); // 총 실중량(무게).
        Double sumVolumeWeightF = Double.parseDouble(sumVolumeWeight); // 총 부피, 중량.

        // 3. 박스 정보 세팅.
        AtomyBoxSizeVO atomyBoxSizeVO = new AtomyBoxSizeVO(); // 박스 정보.
        atomyBoxSizeVO.setLength(sumLength); // 총 세로.
        atomyBoxSizeVO.setWidth(sumWidth); // 총 가로.
        atomyBoxSizeVO.setHeight(sumHeight); // 총 높이.
        atomyBoxSizeVO.setCbm(sumCbm); // 총 체적.
        if (sumKgF > sumVolumeWeightF) {
            atomyBoxSizeVO.setWeight(sumKg); // 실 중량이 부피 중량보다 클 경우 실중량으로 적용.
        } else {
            atomyBoxSizeVO.setWeight(sumVolumeWeight); // 실 중량보다 부피 중량이 클 경우 부피 중량으로 적용.
        }

        // 4. 애터미 박스 정보 가져오기.
        AtomyBoxSizeVO resultBoxSizeVO = (AtomyBoxSizeVO) dao.selectOne("atomyAPIMapper.getBoxInfo", atomyBoxSizeVO);

        if (resultBoxSizeVO == null) {
            LDataMap retMap = new LDataMap();
            retMap.put("code", "500");
            retMap.put("message", "최대 박스 크기를 초과하였습니다");
            return retMap;
        }else {
            AtomyAPIParamVO apiParamVO = new AtomyAPIParamVO();
            
            switch (paramVO.getCountry().toUpperCase()) {
                case "IT": // 이탈리아
                case "AU": // 호주
                case "HK": // 홍콩
                case "JP": // 일본
                case "MY": // 말레이시아
                case "MN": // 몽골
                case "NZ": // 뉴질랜드
                case "SG": // 싱가폴
                case "TW": // 대만
                case "US": // 미국
                case "CA": // 캐나다
                case "FR": // 프랑스
                case "DE": // 독일
                case "CH": // 스위스
                case "GB": // 영국
                case "KH": // 캄보디아
                case "TH": // 태국
                case "PH": // 필리핀
                case "ES": // 스페인
                case "PT": // 포르투갈
                case "RU": // 러시아
                    apiParamVO.setCountry(paramVO.getCountry().toUpperCase());

                    // 5. 국가코드로 ZONE 정보 가져오기.
                    AtomyCountryZoneVO atomyCountryZoneVO = (AtomyCountryZoneVO) dao.selectOne("AtomyOApiOrderListMapper.getCountry", apiParamVO);
                    String countryName = atomyCountryZoneVO.getCountryName().toUpperCase(); // 국가명.

                    AtomyRateVO atomyRateVO = new AtomyRateVO(); // 애터미 요율 정보 VO.
                    atomyRateVO.setKg(resultBoxSizeVO.getWeight()); // 최종 무게.
                    atomyRateVO.setCountryName(countryName);; // 국가명.

                    // 6. 국가명 정보로 배솧비 가져오기. 국가별/중량별 배송비 제공.
                    AtomyRateVO resultAtomyRate = (AtomyRateVO) dao.selectOne("AtomyOApiOrderListMapper.getRate", atomyRateVO);

                    // 7. 주문정보 API 호출값에 배송비 + 주문 상품 정보 + 박스 정보 호출.
                    LDataMap retMap = new LDataMap();
                    retMap.put("code", "1");
                    retMap.put("message", "success"); // 메시지 : 성공 (success), 실패(failed).
                    retMap.put("price", String.format("%,d", Integer.parseInt(resultAtomyRate.getPrice()))); // 배송비.
                    retMap.put("box", resultBoxSizeVO.getNo()); // 박스 크기.
                    return retMap;
                default:
                    LDataMap errMap = new LDataMap();
                    errMap.put("code", "500");
                    errMap.put("message", "애터미 역직구 배송 국가가 아닙니다.");
                    return errMap;
            }
        }
    }

    public HttpURLConnection setHttpHeader(String queryString, String httpMethod, String apiType) throws Exception {

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
    public JSONObject setHttpBody(HttpURLConnection conn, String apiType) {
        
        JSONObject retJson = new JSONObject();
        
        try {
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
            retJson = (JSONObject) object;

            logger.debug("[sendData] retJson : " + retJson);

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
    public JSONObject setHttpBody(HttpURLConnection conn, String apiType, StringBuffer reqSB) {

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

    // 1. 출하요청 개수 조회 (역직구 전용).
    public LDataMap getTotalcountDirect() throws Exception {

        LDataMap retMap = new LDataMap();

        Date dStartDate = new Date(); 
        Date dEndDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String startDate = dateFormat.format(dStartDate); 
        String endDate = dateFormat.format(dEndDate);

        String queryString = "/apiglobal/scm/kr/v1/request/totalcountDirect?EndDate=" + endDate + "&StartDate=" + startDate;
        String httpMethod = "GET";
        String apiType = "totalcountDirect";

        HttpURLConnection conn = this.setHttpHeader(queryString, httpMethod, apiType);
        JSONObject jsonObject = this.setHttpBody(conn, apiType);

        LDataMap resMap = new ObjectMapper().readValue(jsonObject.toJSONString(), LDataMap.class);
        logger.info("[1. getTotalcountDirect (신규출고목록 개수)]");
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
        dao.insert("atomyAPIMapper.insertApiHistory", retMap);

        return retMap;
    }

    // 2. 출하요청 목록 조회.
    public LDataMap getOrderList(String data) throws Exception {
        LDataMap returnMap = new LDataMap();
        LDataMap retMap = new LDataMap();

        Date todayDate = new Date();
        Date dStartDate = new Date(); 
        Date dEndDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String startDate = dateFormat.format(dStartDate); 
        String endDate = dateFormat.format(dEndDate);

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
                    
                    logger.info("[2. getOrderList (신규출고목록)]");
                    responseMap.entrySet().forEach(entry -> {
                        logger.info("" + entry.getKey() + " : " + entry.getValue());
                    });
                    logger.info("================================================");
                    // 애터미 주문 테이블에 주문 정보 저장.
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
        retMap.put("ErrMsg", "");
        retMap.put("todayDate", dateFormat.format(todayDate));

        dao.insert("atomyAPIMapper.insertApiHistory", retMap);
        
        // 주문 취소된 애터미 주문번호 확인.
        List<LDataMap> deleteOrderList = dao.selectList("AtomyOApiOrderListMapper.orderCancelList", retMap);
        
        for (int i = 0; i < deleteOrderList.size(); i++) {
            LDataMap deleteMap = deleteOrderList.get(i);
            dao.update("AtomyOApiOrderListMapper.updateOrderCancel", deleteMap);
        }

        List<LDataMap> atomyOrderList = dao.selectList("atomyAPIMapper.getAtomyOrderList", retMap);

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

        dao.insert("atomyAPIMapper.insertApiHistory", paramMap);
    }
    
    public LDataMap setAtomyOrder(LDataMap paramMap) throws Exception{
        
        List<LDataMap> successList = new ArrayList<>();

        String code = "";
        String message = "";
        int totalCount = 0;
        int dasNo = 1;
        int pickingPage = 0;
        
        Date today = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String todayDate = format.format(today);
        
        LDataMap param = new LDataMap();
        param.put("todayDate", todayDate);

        List<LDataMap> atomyGroupByOrderList = dao.select("atomyAPIMapper.getGroupByOrderList", param);
        if (atomyGroupByOrderList.size() == 0) {
            LDataMap retMap = new LDataMap();
            retMap.put("code", "500");
            retMap.put("message", "XROUTE에 저장할 데이터가 없습니다.");
            return retMap;
        }else {
            for (int i = 0; i < atomyGroupByOrderList.size(); i++) {
                LDataMap params = atomyGroupByOrderList.get(i);
                List<LDataMap> atomyOrderDtlList = dao.select("atomyAPIMapper.getAtomyOrderDtlList", params);
                LDataMap orderDtlMap = atomyOrderDtlList.get(0);
                int rowNum = params.getInt("rowNum");
                pickingPage =  (int) Math.ceil(rowNum / 10.0);
                logger.info("rowNum : " + rowNum + ", pickingPage : " + pickingPage);

                // 애터미 주문 정보(retMap.atomyOrderList)에서 국가코드, 상품코드, 상품수량으로 요율 가격 및 상품 사이즈, 박스 정보를 가져와 리스트에 세팅.
                LDataMap atomyBoxRateMap = getAtomyBoxRate(orderDtlMap);
                code = atomyBoxRateMap.getString("code");
                message = atomyBoxRateMap.getString("message");
                if (code.equals("200")) {
                    orderDtlMap.put("xrtShippingPrice", atomyBoxRateMap.getString("price"));
                    orderDtlMap.put("boxNo", atomyBoxRateMap.getString("box"));
                    orderDtlMap.put("boxInfo", (AtomyBoxSizeVO) atomyBoxRateMap.get("boxInfo"));
                    orderDtlMap.put("dasNo", dasNo + "");
                    orderDtlMap.put("pickingPage", String.valueOf(pickingPage));
                    setXrtOrder(orderDtlMap, atomyOrderDtlList);
                    successList.add(params);
                    
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
                retMap.put("message", totalCount + "건이 처리되었습니다.");
                return retMap;
            }else {
                LDataMap retMap = new LDataMap();
                retMap.put("code", code);
                retMap.put("message", message);
                return retMap;
            }
        }
    }
    
    // 박스 정보 및 배송비 정보.
    public LDataMap getAtomyBoxRate(LDataMap boxParam) throws Exception {
        AtomyBoxSizeVO atomyBoxSizeVO = new AtomyBoxSizeVO();
        atomyBoxSizeVO.setWidth(boxParam.getString("totalWidth"));
        atomyBoxSizeVO.setLength(boxParam.getString("totalLength"));
        atomyBoxSizeVO.setHeight(boxParam.getString("totalHeight"));

        if (boxParam.getFloat("totalKg") > boxParam.getFloat("totalVolumeWeight")) {
            atomyBoxSizeVO.setWeight(boxParam.getString("totalKg"));
        } else {
            atomyBoxSizeVO.setWeight(boxParam.getString("totalVolumeWeight"));
        }

        // 4. 애터미 박스 정보 가져오기.
        AtomyBoxSizeVO resultBoxSizeVO = (AtomyBoxSizeVO) dao.selectOne("atomyAPIMapper.getBoxInfo", atomyBoxSizeVO);

        if (resultBoxSizeVO == null) {
            LDataMap retMap = new LDataMap();
            retMap.put("code", "500");
            retMap.put("message", "최대 박스 크기를 초과하였습니다");
            return retMap;
        }else {
            AtomyAPIParamVO apiParamVO = new AtomyAPIParamVO();
            apiParamVO.setCountry(boxParam.getString("nationCode"));

            // 5. 국가코드로 ZONE 정보 가져오기.
            AtomyCountryZoneVO atomyZone = (AtomyCountryZoneVO) dao.selectOne("AtomyOApiOrderListMapper.getZone", apiParamVO);
            String zoneCode = atomyZone.getZone(); // ZONE CODE.

            AtomyRateVO atomyRateVO = new AtomyRateVO(); // 애터미 요율 정보 VO.
            atomyRateVO.setKg(resultBoxSizeVO.getWeight()); // 최종 무게.
            atomyRateVO.setZoneCode(zoneCode); // ZONE CODE.

            // 6. 국가코드, 존 정보로 배솧비 가져오기. 국가별/중량별 배송비 제공.
            AtomyRateVO resultAtomyRate = (AtomyRateVO) dao.selectOne("AtomyOApiOrderListMapper.getRate", atomyRateVO);

            // 7. 주문정보 API 호출값에 배송비 + 주문 상품 정보 + 박스 정보 호출.
            LDataMap retMap = new LDataMap();
            retMap.put("code", "200"); // 코드. 1이면 성공. 0이면 실패.
            retMap.put("message", "success"); // 메시지 : 성공 (success), 실패(failed).
            retMap.put("price", String.format("%,d", Integer.parseInt(resultAtomyRate.getPrice()))); // 배송비.
            retMap.put("box", resultBoxSizeVO.getNo()); // 박스 크기.
            retMap.put("boxInfo", resultBoxSizeVO); // 박스 정보.
            return retMap;
        }
    }

    // XROUTE 주문정보 세팅.
    public LDataMap setXrtOrder(LDataMap orderDtlMap, List<LDataMap> atomyOrderDtlList) throws Exception {
        String compcd = CommonConst.XROUTE_COMPCD;
        String orgcd = CommonConst.ATOMY_DEV_ORGCD;
        String whcd = CommonConst.ATOMY_DEV_WHCD;

        if (debugtype.equals("REAL")) {
            orgcd = CommonConst.ATOMY_REAL_ORGCD;
            whcd = CommonConst.ATOMY_REAL_WHCD;
        }

        Date today = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

        LDataMap commonMap = new LDataMap();
        commonMap.put("compcd", compcd);
        commonMap.put("orgcd", orgcd);
        commonMap.put("whcd", whcd);
        commonMap.put("fileYmd", dateFormat.format(today));

        // List<LDataMap> sellerList = dao.select("atomyAPIMapper.getSeller", commonMap); // 셀러 확인.
        int fileSeq = (Integer) dao.selectOne("atomyAPIMapper.getTorderFileSeq", commonMap) + 1;
        int relayCount = (Integer) dao.selectOne("atomyAPIMapper.getTorderRelaySeq", commonMap) + 1;
        int fileRelayCount = 1;

        // 길이 변환 : mm -> cm
        int cmWidth = Integer.parseInt(((AtomyBoxSizeVO) orderDtlMap.get("boxInfo")).getWidth()) / 10;
        int cmLength = Integer.parseInt(((AtomyBoxSizeVO) orderDtlMap.get("boxInfo")).getLength()) / 10;
        int cmHeight = Integer.parseInt(((AtomyBoxSizeVO) orderDtlMap.get("boxInfo")).getHeight()) / 10;
        
        Double dTotalKg = Double.parseDouble(orderDtlMap.getString("totalKg"));
        DecimalFormat decimalFormat = new DecimalFormat("#.##");
        String totalKg = decimalFormat.format(dTotalKg);
        
        String nationCode = orderDtlMap.getString("nationCode").toUpperCase();
     
        // 애터미 주문 목록 -> TORDER 주문 목록.
        TOrderVo tOrderVo = new TOrderVo();
        tOrderVo.setCompcd(compcd);
        tOrderVo.setOrgcd(orgcd);
        tOrderVo.setWhcd(whcd);
        tOrderVo.setUploadDate(dateFormat.format(today)); // TORDER UPDATE
        tOrderVo.setFileSeq(Integer.toString(fileSeq));
        tOrderVo.setFileNm(Integer.toString(fileSeq) + "차");
        tOrderVo.setFileNmReal("ATOMY Order Upload");
        tOrderVo.setPaymentType(CommonConst.PAYEMNT_TYPE_WARRANTY); // 4
        tOrderVo.setSiteCd("30112");
        tOrderVo.setStatusCd(CommonConst.ORD_STATUS_CD_ORDER_APPLY); // 10.
        tOrderVo.setStockType(CommonConst.STOCK_TYPE_CENTER); // 1.
        tOrderVo.setMallNm(CommonConst.ATOMY_USERCD); // ATOMY.
        tOrderVo.setLocalShipper(orderDtlMap.getString("localShipper"));
        tOrderVo.setShipMethodCd("DHL");
        tOrderVo.setOrdNo(orderDtlMap.getString("saleNum"));
        tOrderVo.setCartNo(orderDtlMap.getString("orderId"));
        tOrderVo.setOrdCnt(orderDtlMap.getString("ordCnt"));
        tOrderVo.setsNation("KR");
        tOrderVo.seteNation(orderDtlMap.getString("nationCode").toUpperCase());
        tOrderVo.setcWgtReal(totalKg); // 실제 상품의 무게.
        tOrderVo.setWgt(((AtomyBoxSizeVO) orderDtlMap.get("boxInfo")).getWeight()); // 박스
        tOrderVo.setBoxWidth(Integer.toString(cmWidth)); // 박스 가로.
        tOrderVo.setBoxLength(Integer.toString(cmLength)); // 박스 세로.
        tOrderVo.setBoxHeight(Integer.toString(cmHeight)); // 박스 높이.
        tOrderVo.setBoxVolume(((AtomyBoxSizeVO) orderDtlMap.get("boxInfo")).getCbm()); // 박스
        tOrderVo.setShipName(CommonConst.ATOMY_USERCD);
        tOrderVo.setShipTel("1544-8580"); // 애터미 고객센터.
        tOrderVo.setShipMobile("");
        tOrderVo.setShipAddr("충청남도 공주시 백제문화로 2148-21"); // 애터미 주소.
        tOrderVo.setShipPost("32543"); // 애터미 우편번호.
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
        tOrderVo.setTotPaymentPrice(orderDtlMap.getString("totalPrice"));
        tOrderVo.setXrtShippingPrice(orderDtlMap.getString("xrtShippingPrice").replace(",", ""));
        tOrderVo.setBoxNo(orderDtlMap.getString("boxNo"));
        tOrderVo.setDasNo(orderDtlMap.getString("dasNo"));
        tOrderVo.setPickingPage(orderDtlMap.getString("pickingPage"));
        tOrderVo.setPickingSeq(orderDtlMap.getString("dasNo"));
        tOrderVo.setClgoScanYn("N");

        // 1. TORDER 테이블에 애터미 주문 정보 저장.
        dao.insert("atomyAPIMapper.insertOrder", tOrderVo);
        logger.info("XROUTE-TORDER 주문정보 저장 완료");

        for (int i = 0; i < atomyOrderDtlList.size(); i++) {

            String materialCode = atomyOrderDtlList.get(i).getString("materialCode");
            String materialName = atomyOrderDtlList.get(i).getString("materialName");
            String saleQty = atomyOrderDtlList.get(i).getString("saleQty");

            TOrderDtlVo orderDtlVo = new TOrderDtlVo();
            orderDtlVo.setOrdCd(tOrderVo.getOrdCd());
            orderDtlVo.setOrdSeq(atomyOrderDtlList.get(i).getLong("seq"));
            orderDtlVo.setCompcd(compcd);
            orderDtlVo.setOrgcd(orgcd);
            orderDtlVo.setGoodsCd(materialCode);
            orderDtlVo.setGoodsNm(materialName);
            orderDtlVo.setGoodsOption("");
            orderDtlVo.setGoodsCnt(saleQty);
            orderDtlVo.setPaymentPrice(atomyOrderDtlList.get(i).getString("excAmt"));
            orderDtlVo.setAddusercd(CommonConst.ATOMY_USERCD);
            orderDtlVo.setUpdusercd(CommonConst.ATOMY_USERCD);
            orderDtlVo.setTerminalcd("127.0.0.1");
            orderDtlVo.setDelFlg("N");
            orderDtlVo.setOrdNo(orderDtlMap.getString("saleNum"));

            // 2. TORDERDTL 테이블에 애터미 주문 정보 저장.
            dao.insert("atomyAPIMapper.insertOrderDtl", orderDtlVo);
            logger.info("XROUTE-TORDERDTL 주문 정보 저장 완료");
        }

        TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
        trackingHistorytVO.setXrtInvcSno(tOrderVo.getXrtInvcSno());
        trackingHistorytVO.seteNation("KR");
        trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_ORDER_APPLY); // 10(주문등록)
        trackingHistorytVO.setStatusNm("용인센터배송접수");
        trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_ORDER_APPLY);
        trackingHistorytVO.setAddusercd(CommonConst.ATOMY_USERCD);
        trackingHistorytVO.setUpdusercd(CommonConst.ATOMY_USERCD);
        trackingHistorytVO.setTerminalcd("127.0.0.1");

        // 3. 트랙킹 히스토리에 애터미 주문 이력 저장.
        dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
        logger.info("TRACKING_HISTORY 테이블 저장 완료");

        relayCount++;
        fileRelayCount++;

        Thread.sleep(100);
        LDataMap retMap = new LDataMap();
        retMap.put("code", "1"); // 코드. 1이면 성공. 0이면 실패.
        retMap.put("message", "XROUTE 주문 정보 저장 완료하였습니다.");
        return retMap;
    }

 // 신규출고확인 상태변경 - Xroute 송장번호 추가.
    public LDataMap setAtomyStatusUpdate(CommonSearchVo paramVo) throws Exception {
        
        int result = 0;
        int count = 0;
        String errXrtInvcSno = "";
        
        String orgcd = CommonConst.ATOMY_DEV_ORGCD;

        if (debugtype.equals("REAL")) {
            orgcd = CommonConst.ATOMY_REAL_ORGCD;
        }
        
        Date todayDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String today = dateFormat.format(todayDate);
        LDataMap paramMap = new LDataMap();
        paramMap.put("todayDate", today);
        paramMap.put("orgCd", orgcd);

        List<LDataMap> bodyList = dao.select("AtomyOApiOrderListMapper.getAtomyStatusList", paramMap);
        
        if (bodyList.size() == 0) {
            LDataMap retMap = new LDataMap();
            retMap.put("code", "0"); // 코드. 1이면 성공. 0이면 실패.
            retMap.put("message", "주문정보가 존재하지 않습니다.");
            return retMap;
        }else {
            
            // 애터미 api 전송
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

            HttpURLConnection conn = this.setHttpHeader(queryString, httpMethod, apiType);
            JSONObject jsonObject = this.setHttpBody(conn, apiType, sb);

            LDataMap resMap = new ObjectMapper().readValue(jsonObject.toJSONString(), LDataMap.class);
            resMap.entrySet().forEach(entry -> {
                logger.info("" + entry.getKey() + " : " + entry.getValue());
            });
            
            // UPS shipment api 호출할 부분.
            List<LDataMap> orderY = dao.select("AtomyOApiOrderListMapper.getOrderY", paramMap);
            
            for (int i = 0; i < orderY.size(); i++) {
                
                try {
                    // ups api 쏘는구간
                    LRespData resData = upsAPIBiz.setShipments(orderY.get(i));  
                    // ups 리턴값
                    LDataMap packageResultsMap = (LDataMap) resData.get("packageResultsMap");

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
                    updateMap.put("xrtInvcSno", resData.get("xrtInvcSno"));
                    updateMap.put("invcSno1", invcSno1);
                    updateMap.put("graphicImage", blobGraphicImg);
                    updateMap.put("htmlImage", imgSrc);
                    result = dao.update("AtomyOApiOrderListMapper.torderUpsUpdate", updateMap);
                    logger.info("UPS 라벨 이미지 저장 완료.");
                    
                }catch (Exception e) {
                    // 쿼리
                    errXrtInvcSno = orderY.get(i).getString("xrtInvcSno");
                    LDataMap errMap = new LDataMap();
                    errMap.put("xrtInvcSno", errXrtInvcSno);
                    
                    dao.update("AtomyOApiOrderListMapper.upsError", errMap);
                    logger.info("에러 송장번호 등록");
                    count++;
                }
            }
            
            LDataMap retMap = new LDataMap();
            retMap.put("code", "1"); // 코드. 1이면 성공. 0이면 실패.
            retMap.put("message", "신규출고확인 상태변경 -> 총 " + Integer.toString(orderY.size()) + "건 중 성공 " + Integer.toString(orderY.size()- count) + ", 실패 " + count);
            return retMap;
        }
    }


    public LDataMap setShippingInvoiceUpdate() throws Exception {
        String orgcd = CommonConst.ATOMY_DEV_ORGCD;

        if (debugtype.equals("REAL")) {
            orgcd = CommonConst.ATOMY_REAL_ORGCD;
        }

        Date todayDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String today = dateFormat.format(todayDate);
        LDataMap paramMap = new LDataMap();
        paramMap.put("todayDate", today);
        paramMap.put("orgCd", orgcd);

        List<LDataMap> bodyList = dao.select("atomyAPIMapper.getAtomyOrderResult", paramMap);

        if (bodyList.size() == 0) {
            LDataMap retMap = new LDataMap();
            retMap.put("code", "0"); // 코드. 1이면 성공. 0이면 실패.
            retMap.put("message", "주문정보가 없습니다.");
            return retMap;
        }

        StringBuffer sb = new StringBuffer();
        sb.append("[");
        for (int i = 0; i < bodyList.size(); i++) {
            sb.append("{");
            sb.append("\"SaleNum\": \"" + bodyList.get(i).getString("ordNo") + "\",");
            sb.append("\"Seq\": \"" + bodyList.get(i).getString("ordSeq") + "\",");
            sb.append("\"InvoiceNo\": \"" + bodyList.get(i).getString("invcSno1") + "\",");
            sb.append("\"TagSms\": \"" + bodyList.get(i).getString("localShipper") + "\",");
            sb.append("\"EntryNum\": \"" + bodyList.get(i).getString("expNo") + "\"");
            if ((i + 1) == bodyList.size()) {
                sb.append("}");
            } else {
                sb.append("},");
            }
        }
        sb.append("]");

        String queryString = "/apiglobal/scm/kr/v1/status/invoiceDirect";
        String apiType = "invoiceDirect";
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
            for (int i = 0; i < bodyList.size(); i++) {
                LDataMap updParam = bodyList.get(i);
                dao.update("atomyAPIMapper.updateInvoiceYn", updParam);
                Thread.sleep(10);
            }
        }

        LDataMap retMap = new LDataMap();
        retMap.put("code", status); // 코드. 1이면 성공. 0이면 실패.
        retMap.put("message", message);
        return retMap;
    }
    
    // 주문취소가 가능한지 애터미에서 로지포커스 서버로 질의하는 기능 API.
    public LDataMap orderCancelValid(AtomyAPIParamVO paramVO) throws Exception{
        LDataMap resultMap = new LDataMap();
        
        // 파라메터 값 체크.
        if (paramVO.getSaleNum() == null || paramVO.getSaleNum().equals("")) {
            resultMap.put("code", "0");
            resultMap.put("message", "faild");
        }else {
            resultMap.put("code", "1");
            resultMap.put("message", "success");
            resultMap.put("validVO", paramVO);
        }
        return resultMap;
    }

    // 주문취소가 가능한지 애터미에서 로지포커스 서버로 질의하는 기능 API.
    public LDataMap orderCancelCheck(AtomyAPIParamVO paramVO) throws Exception {
        LDataMap retMap = new LDataMap();
        
        LDataMap resultMap = (LDataMap) dao.selectOne("atomyAPIMapper.orderCancelCheck", paramVO.getSaleNum());
        
        if (resultMap == null || resultMap.size() == 0) {
            retMap.put("shipments", "0");
        }else {
            if (resultMap.getString("shipments").equals("0")) {
                retMap.put("shipments", "0");
            }else {
                retMap.put("shipments", "1");
            }
        }
        return retMap;
    }
    
    // 주문번호가 입력되었는지, 그 주문번호가 실제 주문 번호인지 확인.
    public LDataMap saleNumValid(AtomyAPIParamVO paramVO) throws Exception{
        LDataMap resultMap = new LDataMap();
        
        // 파라메터 값 체크.
        if (paramVO.getSaleNum() == null || paramVO.getSaleNum().equals("") || paramVO.getShipmentRef() == null || paramVO.getShipmentRef().equals("")) {
            resultMap.put("code", "0");
            resultMap.put("message", "faild");
        }else {
            resultMap.put("code", "1");
            resultMap.put("message", "success");
            resultMap.put("validVO", paramVO);
        }
        
        return resultMap;
    }

    // [주문취소가 가능한 상태] (Shipment = 0) 에서 애터미 결제 프로세스 문제로 [주문취소 철회] 신호 받는 API.
    public LDataMap orderCancelInsert(AtomyAPIParamVO validVO) throws Exception{
        LDataMap retMap = new LDataMap();
        
        int result = dao.insert("atomyAPIMapper.orderCancelInsert", validVO);
        
        if (result > 0) {
            retMap.put("code", "200");
            retMap.put("message", "success");
        }else {
            retMap.put("code", "500");
            retMap.put("message", "fail");
        }
        
        return retMap;
    }
}
