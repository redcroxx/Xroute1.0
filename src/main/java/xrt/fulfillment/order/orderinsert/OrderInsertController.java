package xrt.fulfillment.order.orderinsert;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.Util;

/**
 * 오더등록 팝업(엑셀업로드)
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/order/OrderInsert")
public class OrderInsertController {

    Logger logger = LoggerFactory.getLogger(OrderInsertController.class);

    @Resource
    private CommonBiz commonBiz;
    @Resource
    private OrderInsertBiz orderinsertBiz;

    // 팝업 호출
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {

        List<CodeVO> codeRELEASE_LINE = commonBiz.getCommonCode("RELEASE_LINE");
        List<CodeVO> codeYNVAL = commonBiz.getCommonCode("YNVALUE"); // YN(감사카드,수첩)
        List<CodeVO> codeSEQTP = commonBiz.getCommonCode("ORDFILESEQTP");// 구분
        List<CodeVO> codeCOUNTRYLIST = commonBiz.getCommonCode("COUNTRYLIST");// 국가리스트

        // 20191217추가
        List<CodeVO> efsApiCountryList = commonBiz.getCommonCode("EFS_API_COUNTRY");

        String XROUTE_ADMIN = CommonConst.XROUTE_ADMIN;
        String CENTER_ADMIN = CommonConst.CENTER_ADMIN;
        String SELLER_ADMIN = CommonConst.SELLER_ADMIN;

        // 권한
        model.addAttribute("XROUTE_ADMIN", XROUTE_ADMIN);
        model.addAttribute("CENTER_ADMIN", CENTER_ADMIN);
        model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);

        model.addAttribute("codeYNVAL", codeYNVAL);
        model.addAttribute("codeSEQTP", codeSEQTP);
        model.addAttribute("codeRELEASE_LINE", codeRELEASE_LINE);
        model.addAttribute("codeCOUNTRYLIST", codeCOUNTRYLIST);
        model.addAttribute("codeEfsApiCountryList", efsApiCountryList);

        return "fulfillment/order/orderinsert/OrderInsert";
    }

    /**
     * 그리드 초기화 정보 가져오기
     *
     * @param reqData
     * @return JSON
     * @throws Exception
     */
    @RequestMapping(value = "/init.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData init(@RequestBody LReqData reqData) throws Exception {
        LDataMap paramData = reqData.getParamDataMap("paramData");

        List<LDataMap> siteHeaderList = orderinsertBiz.getSiteHeader(paramData);
        List<LDataMap> countryList = orderinsertBiz.getCountryList(paramData); // 국가코드리스트
        List<LDataMap> currencyList = orderinsertBiz.getCurrencyList(paramData); // 통화코드리스트
        List<LDataMap> usstateList = orderinsertBiz.getUSStateList(paramData); // 주(State)리스트

        LRespData respData = new LRespData();
        respData.put("paramList", siteHeaderList);
        respData.put("countryList", countryList);
        respData.put("currencyList", currencyList);
        respData.put("usstateList", usstateList);

        return respData;
    }

    /**
     * @methodname 데이터 저장 및 유효성 체크
     *
     * @param reqData
     * @return JSON
     * @throws Exception
     */
    @RequestMapping(value = "/setCheck.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setCheck(@RequestBody LReqData reqData) throws Exception {

        LDataMap paramData = reqData.getParamDataMap("paramData");
        logger.info("paramData => ");
        paramData.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        List<LDataMap> paramList = reqData.getParamDataList("paramList");

        List<CodeVO> countryCdList = commonBiz.getCommonCode("COUNTRY_CD_LIST"); // 국가별코드
        List<CodeVO> mainCountryCdList = commonBiz.getCommonCode("MAIN_COUNTRYLIST"); // 주요국가코드
        List<CodeVO> currencyCodeList = commonBiz.getCommonCode("CURRENCY_CODE"); // 통화코드
        List<CodeVO> eastStateList = commonBiz.getCommonCode("US_STATE_EAST"); // 미국동부주(State)
        List<CodeVO> westStateList = commonBiz.getCommonCode("US_STATE_WEST"); // 미국서부주(State)
        List<CodeVO> deliveryType = commonBiz.getCommonCode("DELIVERY_TYPE"); // 배송타입
        List<CodeVO> apiTargetCountry = commonBiz.getCommonCode("API_TARGET_COUNTRY"); // API국가리스트
        List<CodeVO> kpacketNation = commonBiz.getCommonCode("K-PACKET_NATION"); // K-Packet국가리스트
        List<CodeVO> emsNation = commonBiz.getCommonCode("EMS_NATION"); // EMS국가리스트
        List<CodeVO> premiumNation = commonBiz.getCommonCode("USE_COUNTRY"); // 프리미엄국가리스트
        List<CodeVO> dhlNation = commonBiz.getCommonCode("DHL_COUNTRY_CD_LIST"); // DHL국가리스트
        List<CodeVO> upsNation = commonBiz.getCommonCode("UPS_COUNTRY_CD_LIST"); // UPS국가리스트

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("kpacketNation", kpacketNation);
        paramMap.put("emsNation", emsNation);
        paramData.put("premiumNation", premiumNation);
        paramMap.put("dhlNation", dhlNation);
        paramMap.put("upsNation", upsNation);

        List<CodeVO> newStateList = new ArrayList<CodeVO>();
        newStateList.addAll(eastStateList);
        newStateList.addAll(westStateList);

        List<LDataMap> resultList = orderinsertBiz.setCheck(paramData, paramList, countryCdList, currencyCodeList, mainCountryCdList, newStateList, deliveryType, apiTargetCountry, paramMap);

        LRespData respData = new LRespData();
        respData.put("resultList", resultList);

        return respData;
    }

    /**
     * @methodname 주문서 저장
     *
     * @param reqData
     * @return JSON
     * @throws Exception
     */
    @RequestMapping(value = "/upload.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData upload(HttpServletRequest request, @RequestBody LReqData reqData) throws Exception {

        HttpSession session = request.getSession();
        LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
        String clientIp = request.getHeader("X-FORWARDED-FOR");
        if (clientIp == null) {
            clientIp = request.getRemoteAddr();
        }

        LDataMap paramData = reqData.getParamDataMap("paramData");

        // 1. XROUTE송장발번통신
        // 2. torder, torderdtl에 데이터 생성
        paramData.put("STATUS_CD", CommonConst.ORD_STATUS_CD_ORDER_APPLY);
        paramData.put("STOCK_TYPE", CommonConst.STOCK_TYPE_SELLER);
        // 결제타입구분설정

        if (loginVo.getUsergroup().equals(CommonConst.SELLER_SUPER_USER) || loginVo.getUsergroup().equals(CommonConst.SELLER_USER) || loginVo.getUsergroup().equals(CommonConst.SELLER_ADMIN)) {
            paramData.put("PAYMENT_TYPE", loginVo.getPaymentType());
        } else {
            Map<String, Object> tmpMap = new HashMap<>();
            tmpMap.put("ORGCD", paramData.get("ORGCD"));
            String paymentType = orderinsertBiz.getPayment(tmpMap);
            if (!Util.isEmpty(paymentType)) {
                // 셀러의 paymentType을 가져와서 로그인 paymentType로 변경함
                loginVo.setPaymentType(paymentType);
            } else {
                throw new LingoException("유저 정보가 없습니다.");
            }
        }

        LDataMap reaultData = orderinsertBiz.setUpload(paramData);
        if (reaultData == null) {
            throw new LingoException("리턴 값이 없습니다.");
        }

        logger.debug("reaultData : " + reaultData.toString());
        int regSeq = (int) reaultData.get("REG_SEQ");

        // 결제타입구분 update
        orderinsertBiz.updTorderPaymentType(loginVo, regSeq);

        // 3. TSTOCK_HISTORY UPDATE
        orderinsertBiz.insertTstockHistory(loginVo, clientIp, regSeq);

        // API 연동
        Map<String, Object> resMap = new HashMap<>();
        // 해당 도착국가, 배송타입 취득해서 API업체 연동 배정
        ShippingDataVo resShippingData = orderinsertBiz.convShippingData(regSeq);

        // EFS
        if (!Util.isEmpty(resShippingData.getEfsShipmentVos()) && resShippingData.getEfsShipmentVos().size() > 0) {
            // EFS API 연동
            resMap = orderinsertBiz.efsCreateShipment(resShippingData);
            if (!resMap.get("code").equals("200")) {
                String message = resMap.get("message").toString();
                throw new LingoException(message);
            }
        }
        
        // ETOMARS
        if (!Util.isEmpty(resShippingData.getEtomarsShipmentVos()) && resShippingData.getEtomarsShipmentVos().size() > 0) {
            // ETOMARS API 연동
            resMap = orderinsertBiz.etomarsRegData(resShippingData);
            if (!resMap.get("code").equals("200")) {
                String message = resMap.get("message").toString();
                throw new LingoException(message);
            }
        }

        // QXPRESS 미진행
        if (!Util.isEmpty(resShippingData.getQxpressVos()) && resShippingData.getQxpressVos().size() > 0) {
            // QXPRESS API 연동
            resMap = orderinsertBiz.qxpressRegData(resShippingData);
            if (!resMap.get("code").equals("200")) {
                String message = resMap.get("message").toString();
                throw new LingoException(message);
            }
        }

        LRespData respData = new LRespData();
        respData.put("resultData", reaultData);
        return respData;
    }

    /**
     * @methodname 병합/치환
     *
     * @param reqData
     * @return JSON
     * @throws Exception
     */
    @RequestMapping(value = "/getSiteColEdit.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getSiteColEdit(@RequestBody LReqData reqData) throws Exception {
        LDataMap paramData = reqData.getParamDataMap("paramData");

        List<LDataMap> resultList1 = orderinsertBiz.getSiteColEdit1(paramData);
        List<LDataMap> resultList2 = orderinsertBiz.getSiteColEdit2(paramData);

        LRespData respData = new LRespData();
        respData.put("resultList1", resultList1);
        respData.put("resultList2", resultList2);

        return respData;
    }

    // 양식명 SEELCTBOX
    @RequestMapping(value = "/getSiteCd.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getSiteCd(@RequestBody LReqData reqData) throws Exception {
        LDataMap paramData = reqData.getParamDataMap("paramData");
        List<LDataMap> resultList = orderinsertBiz.getSiteCd(paramData);

        LRespData respData = new LRespData();
        respData.put("resultList", resultList);

        return respData;
    }
}
