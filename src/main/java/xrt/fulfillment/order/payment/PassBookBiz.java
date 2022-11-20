package xrt.fulfillment.order.payment;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.utils.ChiperUtil;
import xrt.fulfillment.order.shippinglist.ShippingListVO;
import xrt.fulfillment.tracking.TrackingHistorytVO;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class PassBookBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(PassBookBiz.class);

    @Value("#{config['c.debugtype']}")
    private String debugtype;

    public LRespData setPassBookAuth(LDataMap paramMap) throws Exception {

        LoginVO loginVO = (LoginVO) dao.selectOne("passBookMapper.getUser", paramMap);

        paramMap.put("compcd", loginVO.getCompcd());
        paramMap.put("orgcd", loginVO.getOrgcd());

        PassBookAuthVO passBookAuthVO = (PassBookAuthVO) dao.selectOne("passBookMapper.getPassBookAuth", paramMap);

        if (passBookAuthVO != null && passBookAuthVO.getCompleteYn().equals("Y")) {
            throw new LingoException("인증된 회원 입니다.");
        }

        if (passBookAuthVO != null) {
            logger.debug("passBookAuthVO : " + passBookAuthVO.toString());
        }

        Date currentDate = new Date();
        SimpleDateFormat ymdFormat = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat hmsFormat = new SimpleDateFormat("HHmmss");
        String yyyyMMdd = ymdFormat.format(currentDate);
        String hhmmss = hmsFormat.format(currentDate);
        String oriTotPrice = "1";
        String ordNo = dao.selectStrOne("passBookMapper.getOrdNo", paramMap);
        String mercntId = CommonConst.PASS_BOOK_DEV_MERCNT_ID;
        String callBackUrl = CommonConst.PASS_BOOK_DEV_CALLBACK_URL;
        String encrytKey = CommonConst.PASS_BOOK_DEV_ENCRYPT_KEY;

        if (debugtype.equals("REAL")) {
            mercntId = CommonConst.PASS_BOOK_REAL_MERCNT_ID;
            callBackUrl = CommonConst.PASS_BOOK_REAL_CALLBACK_URL;
            encrytKey = CommonConst.PASS_BOOK_REAL_ENCRYPT_KEY;
        }

        String trPrice = ChiperUtil.aesEncryptEcb(encrytKey, oriTotPrice);
        String signature = ChiperUtil.sha256(mercntId + ordNo + yyyyMMdd + hhmmss + oriTotPrice + encrytKey);

        if (passBookAuthVO == null) {
            passBookAuthVO = new PassBookAuthVO();
            passBookAuthVO.setCompcd(loginVO.getCompcd());
            passBookAuthVO.setOrgcd(loginVO.getOrgcd());
            passBookAuthVO.setUsercd(loginVO.getUsercd());
            passBookAuthVO.setCompleteYn("N");
            passBookAuthVO.setOrdNo(ordNo);
            passBookAuthVO.setAddusercd(paramMap.getString("usercd"));
            passBookAuthVO.setUpdusercd(paramMap.getString("usercd"));
            passBookAuthVO.setTerminalcd(ClientInfo.getClntIP());

            dao.insert("passBookMapper.insertPassBookAuth", passBookAuthVO);
        } else {
            passBookAuthVO.setOrdNo(ordNo);
            passBookAuthVO.setAddusercd(paramMap.getString("usercd"));
            passBookAuthVO.setUpdusercd(paramMap.getString("usercd"));
            passBookAuthVO.setTerminalcd(ClientInfo.getClntIP());
            dao.update("passBookMapper.updatePassBookAuth", passBookAuthVO);
        }

        PassBookMasterVO passBookMasterVO = new PassBookMasterVO();
        passBookMasterVO.setCompcd(loginVO.getCompcd());
        passBookMasterVO.setOrgcd(loginVO.getOrgcd());
        passBookMasterVO.setUsercd(paramMap.getString("usercd"));
        passBookMasterVO.setHdInfo(CommonConst.PASS_BOOK_HD_INFO);
        passBookMasterVO.setApiVer(CommonConst.PASS_BOOK_AP_VER);
        passBookMasterVO.setMercntId(mercntId);
        passBookMasterVO.setOrdNo(ordNo);
        passBookMasterVO.setTrDay(yyyyMMdd);
        passBookMasterVO.setTrTime(hhmmss);
        passBookMasterVO.setPrice(oriTotPrice);
        passBookMasterVO.setTrPrice(trPrice);
        passBookMasterVO.setDutyFreeYn("Y");
        passBookMasterVO.setProductNm("정기결제 인증비용");
        passBookMasterVO.setCallbackUrl(callBackUrl);
        passBookMasterVO.setAddusercd(paramMap.getString("usercd"));
        passBookMasterVO.setUpdusercd(paramMap.getString("usercd"));
        passBookMasterVO.setTerminalcd(ClientInfo.getClntIP());
        dao.insert("passBookMapper.insertPassBookMaster", passBookMasterVO);

        LRespData retMap = new LRespData();
        retMap.put("hdInfo", passBookMasterVO.getHdInfo());
        retMap.put("apiVer", passBookMasterVO.getApiVer());
        retMap.put("processType", CommonConst.PASS_BOOK_PROCESS_TYPE);
        retMap.put("mercntId", passBookMasterVO.getMercntId());
        retMap.put("ordNo", passBookMasterVO.getOrdNo());
        retMap.put("trDay", passBookMasterVO.getTrDay());
        retMap.put("trTime", passBookMasterVO.getTrTime());
        retMap.put("trPrice", passBookMasterVO.getTrPrice());
        retMap.put("signature", signature);
        retMap.put("dutyFreeYn", passBookMasterVO.getDutyFreeYn());
        retMap.put("regularpayYn", "Y");
        retMap.put("callbackUrl", passBookMasterVO.getCallbackUrl());
        retMap.put("productNm", passBookMasterVO.getProductNm());
        return retMap;
    }

    public LDataMap getCallBack(LDataMap paramMap) throws Exception {

        String resultCd = paramMap.getString("resultCd");
        String errCd = paramMap.getString("errCd");
        String ordNo = paramMap.getString("ordNo");
        String authNo = paramMap.getString("authNo");
        String completeYn = "Y";

        if (resultCd.equals("-1")) {
            completeYn = "E";
        } else {
            PassBookMasterVO passBookMasterVO = new PassBookMasterVO();
            passBookMasterVO.setOrdNo(ordNo);
            passBookMasterVO.setAuthNo(authNo);
            passBookMasterVO.setUpdusercd("SettleBank");

            dao.update("passBookMapper.updatePassBookMaster", passBookMasterVO);
        }

        PassBookMasterVO pbmVO = (PassBookMasterVO) dao.selectOne("passBookMapper.getPassBookMaster", paramMap);

        PassBookAuthVO passBookAuthVO = new PassBookAuthVO();
        passBookAuthVO.setCompcd(pbmVO.getCompcd());
        passBookAuthVO.setOrgcd(pbmVO.getOrgcd());
        passBookAuthVO.setOrdNo(ordNo);
        passBookAuthVO.setCompleteYn(completeYn);
        passBookAuthVO.setCancelYn("N");
        passBookAuthVO.setUpdusercd("SettleBank");

        dao.update("passBookMapper.updatePassBookAuth", passBookAuthVO);

        LDataMap retMap = new LDataMap();
        retMap.put("resultCd", resultCd);
        retMap.put("errCd", errCd);
        retMap.put("ordNo", ordNo);
        retMap.put("authNo", authNo);
        return retMap;
    }

    public LRespData setPayApprov(LDataMap paramMap) throws Exception {

        if (paramMap.getString("ordNo").equals("")) {
            throw new LingoException("주문번호가 없습니다.");
        }

        Date currentDate = new Date();
        SimpleDateFormat ymdFormat = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat hmsFormat = new SimpleDateFormat("HHmmss");
        String yyyyMMdd = ymdFormat.format(currentDate);
        String hhmmss = hmsFormat.format(currentDate);
        String mercntId = CommonConst.PASS_BOOK_DEV_MERCNT_ID;
        String encrytKey = CommonConst.PASS_BOOK_DEV_ENCRYPT_KEY;
        String httpURL = CommonConst.PASS_BOOK_DEV_APPROV_URL;

        if (debugtype.equals("REAL")) {
            mercntId = CommonConst.PASS_BOOK_REAL_MERCNT_ID;
            encrytKey = CommonConst.PASS_BOOK_REAL_ENCRYPT_KEY;
            httpURL = CommonConst.PASS_BOOK_REAL_APPROV_URL;
        }

        PassBookMasterVO passBookMasterVO = new PassBookMasterVO();
        passBookMasterVO.setHdInfo(CommonConst.PASS_BOOK_HD_INFO);
        passBookMasterVO.setApiVer(CommonConst.PASS_BOOK_AP_VER);
        passBookMasterVO.setMercntId(mercntId);
        passBookMasterVO.setReqDay(yyyyMMdd);
        passBookMasterVO.setReqTime(hhmmss);
        passBookMasterVO.setOrdNo(paramMap.getString("ordNo"));
        passBookMasterVO.setUpdusercd(LoginInfo.getUsercd());
        passBookMasterVO.setAuthNo(paramMap.getString("authNo"));
        passBookMasterVO.setUpdusercd("SettleBank");

        String signature = ChiperUtil.sha256(mercntId + paramMap.getString("authNo") + yyyyMMdd + hhmmss + encrytKey);
        passBookMasterVO.setSignature(signature);

        dao.update("passBookMapper.updatePassBookMaster", passBookMasterVO);

        StringBuffer sb = new StringBuffer();
        sb.append("{");
        sb.append("\"hdInfo\": \"" + passBookMasterVO.getHdInfo() + "\",");
        sb.append("\"apiVer\": \"" + passBookMasterVO.getApiVer() + "\",");
        sb.append("\"mercntId\": \"" + passBookMasterVO.getMercntId() + "\",");
        sb.append("\"authNo\": \"" + passBookMasterVO.getAuthNo() + "\",");
        sb.append("\"reqDay\": \"" + passBookMasterVO.getReqDay() + "\",");
        sb.append("\"reqTime\": \"" + passBookMasterVO.getReqTime() + "\",");
        sb.append("\"signature\": \"" + passBookMasterVO.getSignature() + "\"");
        sb.append("}");

        HttpURLConnection conn = this.setHttpHeader(httpURL);
        JSONObject resJson = this.setHttpBody(conn, sb);

        if (resJson.isEmpty()) {
            throw new LingoException("404 Not Found");
        }

        LDataMap resMap = new ObjectMapper().readValue(resJson.toJSONString(), LDataMap.class);
        resMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        if (resMap.getString("resultCd").equals("0")) {
            PassBookMasterVO resPassBookMasterVO = new PassBookMasterVO();
            resPassBookMasterVO.setOrdNo(resMap.getString("ordNo"));
            resPassBookMasterVO.setTrNo(resMap.getString("trNo"));
            resPassBookMasterVO.setUpdusercd("SettleBank");
            dao.update("passBookMapper.updatePassBookMaster", resPassBookMasterVO);

            PassBookMasterVO pbMasterVO = (PassBookMasterVO) dao.selectOne("passBookMapper.getPassBookMaster", paramMap);
            PassBookRegularVO passBookRegularVO = new PassBookRegularVO();
            passBookRegularVO.setCompcd(pbMasterVO.getCompcd());
            passBookRegularVO.setOrgcd(pbMasterVO.getOrgcd());
            passBookRegularVO.setOrdNo(resMap.getString("ordNo"));
            passBookRegularVO.setRegularpayKey(resMap.getString("regularpayKey"));
            passBookRegularVO.setBankAcctNo(resMap.getString("bankAcctNo"));
            passBookRegularVO.setAddusercd("SettleBank");
            passBookRegularVO.setUpdusercd("SettleBank");
            passBookRegularVO.setTerminalcd(ClientInfo.getClntIP());

            dao.update("passBookMapper.insertPassBookRegular", passBookRegularVO);

            LRespData retMap = new LRespData();
            return retMap;
        } else {
            throw new LingoException(resMap.getString("resultMsg"));
        }
    }

    public LDataMap checkedRegularPayment(LDataMap paramMap) throws LingoException {

        if (paramMap.getString("orgcd").equals("")) {
            throw new LingoException("셀러정보가 없습니다.");
        }

        if (paramMap.getString("xrtInvcSno").equals("")) {
            throw new LingoException("XRT송장번호가 없습니다.");
        }

        LDataMap retMap = new LDataMap();
        String productNm = "";
        if (paramMap.getString("type").equals("")) {
            productNm = "물품배송비";
            paramMap.put("productNm", productNm);
        } else {
            productNm = paramMap.getString("productNm");
        }

        String paymentYn = (String) dao.selectOneLE("passBookMapper.getPaymentCheck", paramMap);

        if (paymentYn.equals("Y")) {
            String message = "송장번호 " + paramMap.getString("xrtInvcSno") + "의 " + productNm + "은 이미 처리되었습니다.";
            retMap.put("code", "500");
            retMap.put("message", message);
        } else {
            retMap.put("code", "1");
        }

        return retMap;
    }

    public LRespData setRegularPayment(LDataMap paramMap) throws LingoException {

        PassBookRegularVO passBookRegularVO = (PassBookRegularVO) dao.selectOneLE("passBookMapper.getPassBookRegular", paramMap);
        ShippingListVO shippingListVO = (ShippingListVO) dao.selectOneLE("passBookMapper.getTOrder", paramMap);

        Date currentDate = new Date();
        SimpleDateFormat ymdFormat = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat hmsFormat = new SimpleDateFormat("HHmmss");
        String yyyyMMdd = ymdFormat.format(currentDate);
        String hhmmss = hmsFormat.format(currentDate);
        String ordNo = (String) dao.selectOneLE("passBookMapper.getOrdNo", paramMap);
        String xrtShippingPrice = "";
        String productNm = "";
        String xrtInvcSno = paramMap.getString("xrtInvcSno");

        String mercntId = CommonConst.PASS_BOOK_DEV_MERCNT_ID;
        String encrytKey = CommonConst.PASS_BOOK_DEV_ENCRYPT_KEY;
        String httpURL = CommonConst.PASS_BOOK_DEV_REGULAR_URL;

        if (debugtype.equals("REAL")) {
            mercntId = CommonConst.PASS_BOOK_REAL_MERCNT_ID;
            encrytKey = CommonConst.PASS_BOOK_REAL_ENCRYPT_KEY;
            httpURL = CommonConst.PASS_BOOK_REAL_REGULAR_URL;
        }

        if (paramMap.getString("type").equals("")) {
            xrtShippingPrice = shippingListVO.getXrtShippingPrice();
            productNm = "물품배송비";
            paramMap.put("productNm", productNm);
        } else {
            xrtShippingPrice = paramMap.getString("price");
            productNm = paramMap.getString("productNm");
        }

        String trPrice = ChiperUtil.aesEncryptEcb(encrytKey, xrtShippingPrice);
        String signature = ChiperUtil.sha256(mercntId + ordNo + yyyyMMdd + yyyyMMdd + hhmmss + xrtShippingPrice + passBookRegularVO.getRegularpayKey() + encrytKey);

        PassBookMasterVO passBookMasterVO = new PassBookMasterVO();
        passBookMasterVO.setCompcd(LoginInfo.getCompcd());
        passBookMasterVO.setOrgcd(shippingListVO.getOrgcd());
        passBookMasterVO.setHdInfo(CommonConst.PASS_BOOK_HD_INFO);
        passBookMasterVO.setApiVer(CommonConst.PASS_BOOK_AP_VER);
        passBookMasterVO.setUsercd(LoginInfo.getUsercd());
        passBookMasterVO.setMercntId(mercntId);
        passBookMasterVO.setTrDay(yyyyMMdd);
        passBookMasterVO.setTrTime(hhmmss);
        passBookMasterVO.setOrdNo(ordNo);
        passBookMasterVO.setReqDay(yyyyMMdd);
        passBookMasterVO.setReqTime(hhmmss);
        passBookMasterVO.setPrice(xrtShippingPrice);
        passBookMasterVO.setTrPrice(trPrice);
        passBookMasterVO.setProductNm(productNm);
        passBookMasterVO.setDutyFreeYn("Y");
        passBookMasterVO.setSignature(signature);
        passBookMasterVO.setCustParam1(xrtInvcSno);
        passBookMasterVO.setAddusercd(LoginInfo.getUsercd());
        passBookMasterVO.setUpdusercd(LoginInfo.getUsercd());
        passBookMasterVO.setTerminalcd(ClientInfo.getClntIP());

        try {
            dao.insert("passBookMapper.insertPassBookMaster", passBookMasterVO);
        } catch (Exception e) {
            throw new LingoException(e.getMessage());
        }

        StringBuffer sb = new StringBuffer();
        sb.append("{");
        sb.append("\"hdInfo\": \"" + passBookMasterVO.getHdInfo() + "\",");
        sb.append("\"apiVer\": \"" + passBookMasterVO.getApiVer() + "\",");
        sb.append("\"mercntId\": \"" + passBookMasterVO.getMercntId() + "\",");
        sb.append("\"trDay\": \"" + passBookMasterVO.getTrDay() + "\",");
        sb.append("\"trTime\": \"" + passBookMasterVO.getTrTime() + "\",");
        sb.append("\"ordNo\": \"" + passBookMasterVO.getOrdNo() + "\",");
        sb.append("\"reqDay\": \"" + passBookMasterVO.getReqDay() + "\",");
        sb.append("\"reqTime\": \"" + passBookMasterVO.getReqTime() + "\",");
        sb.append("\"trPrice\": \"" + passBookMasterVO.getTrPrice() + "\",");
        sb.append("\"productNm\": \"" + passBookMasterVO.getProductNm() + "\",");
        sb.append("\"dutyFreeYn\": \"" + passBookMasterVO.getDutyFreeYn() + "\",");
        sb.append("\"regularpayKey\": \"" + passBookRegularVO.getRegularpayKey() + "\",");
        sb.append("\"signature\": \"" + passBookMasterVO.getSignature() + "\"");
        sb.append("}");

        LRespData retMap = new LRespData();
        retMap.put("httpURL", httpURL);
        retMap.put("shippingListVO", shippingListVO);
        retMap.put("bodyString", sb);
        retMap.put("type", paramMap.getString("type"));
        retMap.put("ordNo", passBookMasterVO.getOrdNo());
        return retMap;

    }

    public LRespData setReturnRegular(LRespData paramMap) throws LingoException {

        String httpURL = (String) paramMap.get("httpURL");
        String type = (String) paramMap.get("type");
        StringBuffer sb = (StringBuffer) paramMap.get("bodyString");
        ShippingListVO shippingListVO = (ShippingListVO) paramMap.get("shippingListVO");

        try {
            HttpURLConnection conn = this.setHttpHeader(httpURL);
            JSONObject resJson = this.setHttpBody(conn, sb);

            if (resJson.isEmpty()) {
                throw new LingoException("404 Not Found");
            }

            LDataMap resMap = new ObjectMapper().readValue(resJson.toJSONString(), LDataMap.class);
            resMap.entrySet().forEach(entry -> {
                logger.info("" + entry.getKey() + " : " + entry.getValue());
            });

            if (resMap.getString("resultCd").equals("0")) {
                PassBookMasterVO resPassBookMasterVO = new PassBookMasterVO();
                resPassBookMasterVO.setOrdNo(resMap.getString("ordNo"));
                resPassBookMasterVO.setTrNo(resMap.getString("trNo"));
                resPassBookMasterVO.setUpdusercd("SettleBank");
                dao.update("passBookMapper.updatePassBookMaster", resPassBookMasterVO);

                if (type.equals("")) {
                    LDataMap updateMap = new LDataMap();
                    updateMap.put("xrtInvcSno", shippingListVO.getXrtInvcSno());
                    updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_PAYMENT_COMP);
                    updateMap.put("usercd", LoginInfo.getUsercd());

                    dao.update("passBookMapper.updateTOrder", updateMap);

                    TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
                    trackingHistorytVO.setXrtInvcSno(shippingListVO.getXrtInvcSno());
                    trackingHistorytVO.seteNation(shippingListVO.geteNation());
                    trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_PAYMENT_COMP);
                    trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_PAYMENT_COMP);
                    trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_PAYMENT_COMP);
                    trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
                    trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
                    trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());

                    dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
                }

                LRespData retMap = new LRespData();
                return retMap;
            } else {
                dao.update("passBookMapper.deletePassBookMaster", paramMap);
                LRespData retMap = new LRespData();
                retMap.put("CODE", "500");
                retMap.put("MESSAGE", resMap.getString("resultMsg"));
                return retMap;
            }
        } catch (Exception e) {
            // TODO: handle exception
            throw new LingoException(e.getMessage());
        }
    }

    public LRespData setPayCancel(LDataMap paramMap) throws Exception {

        if (paramMap.getString("ordNo").equals("")) {
            throw new LingoException("주문번호가 없습니다.");
        }

        PassBookMasterVO passBookMasterVO = (PassBookMasterVO) dao.selectOne("passBookMapper.getPassBookMaster", paramMap);

        Date currentDate = new Date();
        SimpleDateFormat ymdFormat = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat hmsFormat = new SimpleDateFormat("HHmmss");
        String yyyyMMdd = ymdFormat.format(currentDate);
        String hhmmss = hmsFormat.format(currentDate);
        String price = paramMap.getString("cancelPrice");
        String ordNo = dao.selectStrOne("passBookMapper.getCancelOrdNo", paramMap);
        String mercntId = CommonConst.PASS_BOOK_DEV_MERCNT_ID;
        String encrytKey = CommonConst.PASS_BOOK_DEV_ENCRYPT_KEY;
        String httpURL = CommonConst.PASS_BOOK_DEV_CANCEL_URL;

        if (debugtype.equals("REAL")) {
            mercntId = CommonConst.PASS_BOOK_REAL_MERCNT_ID;
            encrytKey = CommonConst.PASS_BOOK_REAL_ENCRYPT_KEY;
            httpURL = CommonConst.PASS_BOOK_REAL_CANCEL_URL;
        }

        String cancelPrice = ChiperUtil.aesEncryptEcb(encrytKey, price);
        String signature = ChiperUtil.sha256(mercntId + passBookMasterVO.getTrNo() + ordNo + price + yyyyMMdd + hhmmss + encrytKey);

        passBookMasterVO.setHdInfo(CommonConst.PASS_BOOK_HD_INFO);
        passBookMasterVO.setApiVer(CommonConst.PASS_BOOK_AP_VER);
        passBookMasterVO.setMercntId(mercntId);
        passBookMasterVO.setCancelReqDay(yyyyMMdd);
        passBookMasterVO.setCancelReqTime(hhmmss);
        passBookMasterVO.setCancelPrice(cancelPrice);
        passBookMasterVO.setSignature(signature);
        passBookMasterVO.setUpdusercd(paramMap.getString("usercd"));
        passBookMasterVO.setTerminalcd(paramMap.getString("clientIp"));

        StringBuffer sb = new StringBuffer();
        sb.append("{");
        sb.append("\"hdInfo\": \"" + passBookMasterVO.getHdInfo() + "\",");
        sb.append("\"apiVer\": \"" + passBookMasterVO.getApiVer() + "\",");
        sb.append("\"mercntId\": \"" + passBookMasterVO.getMercntId() + "\",");
        sb.append("\"oldTrNo\": \"" + passBookMasterVO.getTrNo() + "\",");
        sb.append("\"ordNo\": \"" + ordNo + "\",");
        sb.append("\"cancelPrice\": \"" + passBookMasterVO.getCancelPrice() + "\",");
        sb.append("\"reqDay\": \"" + passBookMasterVO.getCancelReqDay() + "\",");
        sb.append("\"reqTime\": \"" + passBookMasterVO.getCancelReqTime() + "\",");
        sb.append("\"signature\": \"" + passBookMasterVO.getSignature() + "\"");
        sb.append("}");

        HttpURLConnection conn = this.setHttpHeader(httpURL);
        JSONObject resJson = this.setHttpBody(conn, sb);

        if (resJson.isEmpty()) {
            throw new LingoException("404 Not Found");
        }

        LDataMap resMap = new ObjectMapper().readValue(resJson.toJSONString(), LDataMap.class);
        resMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        if (resMap.getString("resultCd").equals("0")) {
            PassBookMasterVO resPassBookMasterVO = new PassBookMasterVO();
            resPassBookMasterVO.setTrNo(resMap.getString("oldTrNo"));
            resPassBookMasterVO.setCancelTrNo(resMap.getString("trNo"));
            resPassBookMasterVO.setCancelReqDay(resMap.getString("cancelDay"));
            resPassBookMasterVO.setCancelPrice(resMap.getString("cancelPrice"));
            resPassBookMasterVO.setUpdusercd("SettleBank");
            dao.update("passBookMapper.updatePassBookMaster", resPassBookMasterVO);

            if (!paramMap.getString("usercd").equals("")) {
                LDataMap updateMap = new LDataMap();
                updateMap.put("usercd", paramMap.getString("usercd"));

                dao.update("passBookMapper.updateP002", updateMap);
            }

            LRespData retMap = new LRespData();
            return retMap;
        } else {
            throw new LingoException(resMap.getString("resultMsg"));
        }
    }

    public LRespData setRegularCancel(LReqData paramMap) throws Exception {

        List<LDataMap> dataList = paramMap.getParamDataList("dataList");
        List<LDataMap> deleteList = new ArrayList<LDataMap>();

        for (int i = 0; i < dataList.size(); i++) {
            LDataMap dataMap = dataList.get(i);
            if (dataMap.getString("orgcd").equals("")) {
                throw new LingoException("셀러코드가 없습니다.");
            }

            LDataMap reqularMap = (LDataMap) dao.selectOne("passBookMapper.getRegular", dataMap);

            Date currentDate = new Date();
            SimpleDateFormat ymdFormat = new SimpleDateFormat("yyyyMMdd");
            SimpleDateFormat hmsFormat = new SimpleDateFormat("HHmmss");
            String yyyyMMdd = ymdFormat.format(currentDate);
            String hhmmss = hmsFormat.format(currentDate);
            String mercntId = CommonConst.PASS_BOOK_DEV_MERCNT_ID;
            String encrytKey = CommonConst.PASS_BOOK_DEV_ENCRYPT_KEY;
            String httpURL = CommonConst.PASS_BOOK_DEV_REGULAR_CANCEL_URL;
            String regularpayKey = reqularMap.getString("regularpayKey");

            if (debugtype.equals("REAL")) {
                mercntId = CommonConst.PASS_BOOK_REAL_MERCNT_ID;
                encrytKey = CommonConst.PASS_BOOK_REAL_ENCRYPT_KEY;
                httpURL = CommonConst.PASS_BOOK_REAL_REGULAR_CANCEL_URL;
            }

            String signature = ChiperUtil.sha256(mercntId + yyyyMMdd + hhmmss + regularpayKey + encrytKey);

            StringBuffer sb = new StringBuffer();
            sb.append("{");
            sb.append("\"hdInfo\": \"" + CommonConst.PASS_BOOK_HD_INFO + "\",");
            sb.append("\"apiVer\": \"" + CommonConst.PASS_BOOK_AP_VER + "\",");
            sb.append("\"mercntId\": \"" + mercntId + "\",");
            sb.append("\"reqDay\": \"" + yyyyMMdd + "\",");
            sb.append("\"reqTime\": \"" + hhmmss + "\",");
            sb.append("\"regularpayKey\": \"" + regularpayKey + "\",");
            sb.append("\"signature\": \"" + signature + "\"");
            sb.append("}");

            HttpURLConnection conn = this.setHttpHeader(httpURL);
            JSONObject resJson = this.setHttpBody(conn, sb);

            if (resJson.isEmpty()) {
                throw new LingoException("404 Not Found");
            }

            LDataMap resMap = new ObjectMapper().readValue(resJson.toJSONString(), LDataMap.class);
            resMap.entrySet().forEach(entry -> {
                logger.info("" + entry.getKey() + " : " + entry.getValue());
            });

            if (resMap.getString("resultCd").equals("0")) {
                PassBookAuthVO passBookAuthVO = new PassBookAuthVO();
                passBookAuthVO.setCompcd(dataMap.getString("compcd"));
                passBookAuthVO.setOrgcd(dataMap.getString("orgcd"));
                passBookAuthVO.setCompleteYn("N");
                passBookAuthVO.setCancelYn("Y");
                passBookAuthVO.setUpdusercd(LoginInfo.getUsercd());

                dao.update("passBookMapper.updatePassBookAuth", passBookAuthVO);

                deleteList.add(reqularMap);
            } else {
                throw new LingoException(resMap.getString("resultMsg"));
            }
        }

        for (int i = 0; i < deleteList.size(); i++) {
            LDataMap dataMap = deleteList.get(i);
            dao.delete("passBookMapper.deletePassBookRegular", dataMap);
        }

        LRespData retMap = new LRespData();
        return retMap;
    }

    public HttpURLConnection setHttpHeader(String httpURL) throws Exception {

        HttpURLConnection retURL = (HttpURLConnection) new URL(httpURL).openConnection();
        retURL.setRequestMethod("POST");
        retURL.setRequestProperty("Content-Type", "application/json;charset=utf-8");
        retURL.setRequestProperty("Accept", "application/json;charset=utf-8");
        retURL.setDoOutput(true);

        return retURL;
    }

    private JSONObject setHttpBody(HttpURLConnection conn, StringBuffer sendData) throws Exception {
        conn.connect();

        String encodeSendData = new String(sendData.toString().getBytes("8859_1"), StandardCharsets.UTF_8);
        // URLEncoder.encode(sendData.toString(), "UTF-8");

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
            // logger.debug("[sendData] readLine : " + sb.toString());
        }

        bufferedReader.close();
        JSONParser jsonParser = new JSONParser();
        Object object = jsonParser.parse(sb.toString());
        JSONObject retJson = (JSONObject) object;
        return retJson;
    }
}