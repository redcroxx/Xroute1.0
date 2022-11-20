package xrt.fulfillment.bol;

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
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

/**
 * MBL Biz
 * 
 * @since 2020-12-24
 * @author wnkim
 *
 */
@Service
public class MasterBLBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(MasterBLBiz.class);
    
    @Value("#{config['c.debugtype']}")
    private String debugtype;

    /**
     * MASTER_BL 테이블 조회
     * 
     * @param paramVO
     * @return
     * @throws Exception
     */
    public LRespData getSearch(CommonSearchVo paramVO) throws Exception {
        LRespData resData = new LRespData();
        List<MasterBLVO> masterBLVOs = dao.selectList("masterBlMapper.getSearch", paramVO);
        resData.put("resultList", masterBLVOs);

        return resData;
    }

    /**
     * MBL 상태 완료로 변경
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    public LRespData setComplete(LReqData paramMap) throws Exception {
        List<LDataMap> completaList = paramMap.getParamDataList("dataList");

        for (int i = 0; i < completaList.size(); i++) {
            String masterBlNo = completaList.get(i).getString("masterBlNo");
            boolean bCloseYn = this.checkCloseYN(masterBlNo);
            if (bCloseYn) {
                throw new LingoException("완료된 MBL 입니다.");
            }

            MasterBLVO masterBlVO = new MasterBLVO();
            masterBlVO.setMasterBlNo(masterBlNo);
            masterBlVO.setCloseYn("Y");
            masterBlVO.setUpdusercd(LoginInfo.getUsercd());
            dao.update("masterBlMapper.updateMasterBL", masterBlVO);
        }

        LRespData resData = new LRespData();
        return resData;
    }

    /**
     * HBL 목록 조회
     * 
     * @return
     * @throws Exception
     */
    public LRespData getPopSearch(LDataMap paramMap) throws Exception {
        List<MasterBLVO> houseBLVOs = dao.selectList("masterBlMapper.getHouseBLList", paramMap);
        LRespData resData = new LRespData();
        resData.put("resultList", houseBLVOs);
        return resData;
    }

    /**
     * MBL 정보 조회
     * 
     * @return
     * @throws Exception
     */
    public LRespData getMasterBl(LDataMap paramMap) throws Exception {
        List<MasterBLVO> masterBLVOs = dao.selectList("masterBlMapper.getMasterBL", paramMap);
        LRespData resData = new LRespData();
        resData.put("resultData", masterBLVOs);
        return resData;
    }

    /**
     * HBL에서 MassterBlNo 제거
     * 
     * @return
     * @throws Exception
     */
    public LRespData deleteHouseBl(LReqData dataMap) throws Exception {
        String masterBlNo = dataMap.getParamDataVal("masterBlNo");
        List<LDataMap> houseBlNos = dataMap.getParamDataList("dataList");

        boolean bCloseYn = this.checkCloseYN(masterBlNo);
        if (bCloseYn) {
            throw new LingoException("완료된 MBL 입니다.");
        }

        for (int i = 0; i < houseBlNos.size(); i++) {
            HouseBLVO houseBLVO = new HouseBLVO();
            houseBLVO.setUpdusercd(LoginInfo.getUsercd());
            houseBLVO.setHouseBlNo(houseBlNos.get(i).getString("houseBlNo"));

            dao.update("masterBlMapper.updateHouseBL", houseBLVO);
            
            LDataMap tOrderMap = new LDataMap();
            tOrderMap.put("statusCd", CommonConst.ORD_STATUS_CD_SHIP_HOLD);
            tOrderMap.put("statusNm", CommonConst.ORD_STATUS_NM_SHIP_HOLD);
            tOrderMap.put("statusEnNm", CommonConst.ORD_STATUS_EN_NM_SHIP_HOLD);
            tOrderMap.put("houseBlNo", houseBlNos.get(i).getString("houseBlNo"));
            tOrderMap.put("usercd", LoginInfo.getUsercd());
            tOrderMap.put("terminalcd", ClientInfo.getClntIP());

            dao.update("masterBlMapper.updateTOrderHBL", tOrderMap);
            dao.insert("masterBlMapper.insertTrackingHistoryHBL", tOrderMap);
        }

        LRespData resData = new LRespData();
        return resData;
    }

    /**
     * MBL 수정 및 상태변경
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    public LRespData setPopSave(LDataMap paramMap) throws Exception {
        String orgcd = CommonConst.ATOMY_DEV_ORGCD;

        if (debugtype.equals("REAL")) {
            orgcd = CommonConst.ATOMY_REAL_ORGCD;
        }
        
        String masterBlNo = paramMap.getString("masterBlNo");
        String type = paramMap.getString("type");
        boolean bCloseYn = this.checkCloseYN(masterBlNo);
        if (bCloseYn) {
            throw new LingoException("완료된 MBL 입니다.");
        }

        MasterBLVO masterBlVO = new MasterBLVO();

        masterBlVO.setMasterBlNo(masterBlNo);
        masterBlVO.setUpdusercd(LoginInfo.getUsercd());
        if (type.equals("data")) {
            masterBlVO.setAirwayBill(paramMap.getString("airwayBill"));
            masterBlVO.setEtd(paramMap.getString("etd"));
            masterBlVO.setEtdComp(paramMap.getString("etdComp"));
            masterBlVO.setEta(paramMap.getString("eta"));
            masterBlVO.setEtaComp(paramMap.getString("etaComp"));
        } else if (type.equals("etdComp")) {
            masterBlVO.setEtdComp(paramMap.getString("etdComp"));
            masterBlVO.setEta(paramMap.getString("eta"));

            LDataMap insertMap = new LDataMap();
            insertMap.put("orgCd", orgcd);
            insertMap.put("statusCd", CommonConst.ORD_STATUS_CD_ETD_COMP);
            insertMap.put("statusNm", CommonConst.ORD_STATUS_NM_ETD_COMP);
            insertMap.put("statusEnNm", CommonConst.ORD_STATUS_EN_NM_ETD_COMP);
            insertMap.put("masterBlNo", masterBlNo);
            insertMap.put("usercd", LoginInfo.getUsercd());
            insertMap.put("terminalcd", ClientInfo.getClntIP());

            dao.insert("masterBlMapper.insertTrackingHistory", insertMap);
            dao.update("masterBlMapper.updateTOrder", insertMap);
            
            LDataMap checkMap = new LDataMap();
            checkMap.put("orgCd", orgcd);
            checkMap.put("masterBlNo", masterBlVO.getMasterBlNo());
            
            // 기존 선적완료 API 전송 시점.
            /*List<LDataMap> bodyList = dao.select("AtomyOApiOrderListMapper.getEtdCompList", checkMap);
           
            if (bodyList.size() != 0) {
                // 비행기에 선적 완료 후 선적 완료 신호 API 호출.
                this.setShipmentComp(bodyList);
            }*/
        } else if (type.equals("etaComp")) {
            masterBlVO.setEtaComp(paramMap.getString("etaComp"));
            masterBlVO.setCloseYn("Y");

            LDataMap insertMap = new LDataMap();
            insertMap.put("statusCd", CommonConst.ORD_STATUS_CD_ETA_COMP);
            insertMap.put("statusNm", CommonConst.ORD_STATUS_NM_ETA_COMP);
            insertMap.put("statusEnNm", CommonConst.ORD_STATUS_EN_NM_ETA_COMP);
            insertMap.put("masterBlNo", masterBlNo);
            insertMap.put("usercd", LoginInfo.getUsercd());
            insertMap.put("terminalcd", ClientInfo.getClntIP());

            dao.insert("masterBlMapper.insertTrackingHistory", insertMap);
            dao.update("masterBlMapper.updateTOrder", insertMap);
        } else {
            throw new LingoException("지정되지 않는 구분입니다.");
        }

        dao.update("masterBlMapper.updateMasterBL", masterBlVO);

        LRespData resData = new LRespData();
        return resData;
    }

    /**
     * MBL 생성
     * 
     * @param dataMap
     * @return
     * @throws Exception
     */
    public LRespData setCreatePopSave(LReqData dataMap) throws Exception {
        
        String orgcd = CommonConst.ATOMY_DEV_ORGCD;

        if (debugtype.equals("REAL")) {
            orgcd = CommonConst.ATOMY_REAL_ORGCD;
        }
        
        String masterBlNo = dataMap.getParamDataVal("masterBlNo");
        String etd = dataMap.getParamDataVal("etd");
        String eta = dataMap.getParamDataVal("eta");
        String remark = dataMap.getParamDataVal("remark");
        String closeYn = dataMap.getParamDataVal("closeYn");
        List<LDataMap> houseBlNos = dataMap.getParamDataList("dataList");

        boolean bCloseYn = this.checkCloseYN(masterBlNo);
        if (bCloseYn) {
            throw new LingoException("완료된 MBL 입니다.");
        }

        MasterBLVO masterBlVO = new MasterBLVO();
        masterBlVO.setMasterBlNo(masterBlNo);
        masterBlVO.setCompcd(LoginInfo.getCompcd());
        masterBlVO.setEta(eta);
        masterBlVO.setEtd(etd);
        masterBlVO.setCloseYn(closeYn.toUpperCase().trim());
        masterBlVO.setRemark(remark);
        masterBlVO.setAddusercd(LoginInfo.getUsercd());
        masterBlVO.setUpdusercd(LoginInfo.getUsercd());
        masterBlVO.setTerminalcd(ClientInfo.getClntIP());

        logger.debug("masterBlVO : " + masterBlVO.toString());
        int isCreated = (Integer) dao.selectOne("masterBlMapper.getNoCount", masterBlVO);
        if (isCreated == 0) {
            dao.insert("masterBlMapper.insertMasterBL", masterBlVO);
        } else if (isCreated == 1) {
            dao.update("masterBlMapper.updateMasterBL", masterBlVO);
        } else {
            throw new LingoException("masterBlNo에서 문제가 발생 하였습니다.");
        }

        for (int i = 0; i < houseBlNos.size(); i++) {
            HouseBLVO houseBlVO = new HouseBLVO();
            houseBlVO.setHouseBlNo(houseBlNos.get(i).getString("houseBlNo"));
            houseBlVO.setMasterBlNo(masterBlNo);
            houseBlVO.setUpdusercd(LoginInfo.getUsercd());

            dao.update("masterBlMapper.updateHouseBL", houseBlVO);
        }
        
        LDataMap tOrderMap = new LDataMap();
        tOrderMap.put("statusCd", CommonConst.ORD_STATUS_CD_ETD);
        tOrderMap.put("statusNm", CommonConst.ORD_STATUS_NM_ETD);
        tOrderMap.put("statusEnNm", CommonConst.ORD_STATUS_EN_NM_ETD);
        tOrderMap.put("masterBlNo", masterBlNo);
        tOrderMap.put("usercd", LoginInfo.getUsercd());
        tOrderMap.put("terminalcd", ClientInfo.getClntIP());

        dao.update("masterBlMapper.updateTOrder", tOrderMap);
        dao.insert("masterBlMapper.insertTrackingHistory", tOrderMap);
        
          // 선적완료 API 전송 시점을 인천공항출발 예정일때로 변경. 20210702 김광희 부장 요청.
        /*
        LDataMap checkMap = new LDataMap();
        checkMap.put("orgCd", orgcd);
        checkMap.put("masterBlNo", masterBlVO.getMasterBlNo());
        
        List<LDataMap> bodyList = dao.select("AtomyOApiOrderListMapper.getEtdCompList", checkMap);
       
        if (bodyList.size() != 0) {
            // 비행기에 선적 완료 후 선적 완료 신호 API 호출.
            this.setShipmentComp(bodyList);
        }
        */
        
        // TORDER 조회 후 E_NATION 정보를 가져와서 저장해야한다.
        LRespData resData = new LRespData();
        return resData;
    }

    /**
     * 상태 체크 true : 완료, false : 진행 중
     * 
     * @param masterBlNo
     * @return
     * @throws Exception
     */
    public boolean checkCloseYN(String masterBlNo) throws Exception {
        boolean bRet = false;

        if (masterBlNo == null || "".equals(masterBlNo)) {
            throw new LingoException("MBL 번호가 없습니다.");
        }

        LDataMap checkMap = new LDataMap();
        checkMap.put("masterBlNo", masterBlNo);
        checkMap.put("compcd", LoginInfo.getCompcd());
        Object vo = dao.selectOne("masterBlMapper.getMasterBL", checkMap);
        MasterBLVO masterBlVO = (MasterBLVO) vo;

        if (masterBlVO == null) {
            return bRet;
        } else {
            logger.debug("MasterBLVO : " + masterBlVO.toString());
            if ("Y".equals(masterBlVO.getCloseYn().trim().toUpperCase())) {
                bRet = true;
            }

            return bRet;
        }
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
    
    // 선적완료 신호 API.
    public LDataMap setShipmentComp(List<LDataMap> bodyList) throws Exception{
        StringBuffer sb = new StringBuffer();
        sb.append("[");
        for (int i = 0; i < bodyList.size(); i++) {
            sb.append("{");
            sb.append("\"SaleNum\": \"" + bodyList.get(i).getString("ordNo") + "\",");
            sb.append("\"Seq\": \"" + bodyList.get(i).getString("ordSeq") + "\",");
            sb.append("\"DeliDate\": \"" + bodyList.get(i).getString("deliDate") + "\"");
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
   
        LDataMap retMap = new LDataMap();
        retMap.put("code", status);
        retMap.put("message", message);
        return retMap;
    }
}