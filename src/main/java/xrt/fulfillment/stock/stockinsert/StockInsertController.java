package xrt.fulfillment.stock.stockinsert;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;

/**
 * 입고스캔
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/stock/stockInsert")
public class StockInsertController {

    Logger logger = LoggerFactory.getLogger(StockInsertController.class);

    private CommonBiz commonBiz;
    private StockInsertBiz stockInsertBiz;

    @Autowired
    public StockInsertController(CommonBiz commonBiz, StockInsertBiz stockInsertBiz) {
        super();
        this.commonBiz = commonBiz;
        this.stockInsertBiz = stockInsertBiz;
    }

    // 화면 호출
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {

        Map<String, Object> userGroupMap = new HashMap<String, Object>();
        userGroupMap.put("xrouteAdmin", CommonConst.XROUTE_ADMIN);
        userGroupMap.put("centerAdmin", CommonConst.CENTER_ADMIN);
        userGroupMap.put("centerSuper", CommonConst.CENTER_SUPER_USER);
        userGroupMap.put("centerUser", CommonConst.CENTER_USER);
        userGroupMap.put("sellerAdmin", CommonConst.SELLER_ADMIN);
        userGroupMap.put("sellerSuper", CommonConst.SELLER_SUPER_USER);
        userGroupMap.put("sellerUser", CommonConst.SELLER_USER);

        Map<String, Object> statusMap = new HashMap<String, Object>();
        statusMap.put("orderApply", CommonConst.ORD_STATUS_CD_ORDER_APPLY);

        model.addAttribute("userGroupMap", userGroupMap);
        model.addAttribute("statusMap", statusMap);

        return "fulfillment/stock/stockinsert/StockInsert";
    }

    // 송장에 들어갈 데이터 불러오기
    @RequestMapping(value = "/print.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getPrint(@RequestBody LReqData reqData) throws Exception {

        LDataMap paramData = reqData.getParamDataMap("paramData");
        if (paramData.getString("INVC_SNO").equals("")) {
            throw new LingoException("송장정보를 제대로 읽어오지 못했습니다.");
        }

        logger.info("paramData => ");
        paramData.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        LDataMap resultData = stockInsertBiz.getPrint(paramData);
        LRespData respData = new LRespData();
        respData.put("resultData", resultData);
        return respData;
    }

    // 검색
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(HttpServletRequest request, @RequestBody LReqData reqData) throws Exception {

        HttpSession session = request.getSession();
        LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
        LDataMap paramData = reqData.getParamDataMap("paramData");
        LDataMap whnmMap = commonBiz.getCodeSname("WHNM_INFO", CommonConst.XROUTE_GIMPO_WHCD);

        logger.info("paramData => ");
        paramData.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        // 주문마스터 검색
        LDataMap resultData = stockInsertBiz.getSearch(paramData);
        // DEL_YN = 'N'인경우, 검색가능
        if (Util.isEmpty(resultData)) {
            throw new LingoException("존재하지 않거나 삭제된 송장번호 입니다.");
        }

        paramData.put("ORD_CD", resultData.getString("ORD_CD"));
        List<LDataMap> resultList = stockInsertBiz.getOrderDtl(paramData);
        // 유저그룹이 center user 인경우, 실행 start
        if (CommonConst.CENTER_USER.equals(loginVo.getUsergroup())) {
            paramData.put("SCALE_CD", loginVo.getScale1());
            paramData.put("WHNM", whnmMap.getString("SNAME1"));
            paramData.put("INVC_SNO", "1");
            stockInsertBiz.updWgt(paramData);
        }

        LRespData respData = new LRespData();
        respData.put("resultList", resultList);
        respData.put("resultData", resultData);

        return respData;
    }

    // 저장
    @RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setSave(@RequestBody LReqData reqData) throws Exception {

        LDataMap paramData = reqData.getParamDataMap("paramData");

        logger.info("paramData => ");
        paramData.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        if (paramData.getString("INVC_SNO").equals("")) {
            throw new LingoException("송장정보를 제대로 읽어오지 못했습니다.");
        }

        String width = "1";
        String length = "1";
        String height = "1";
        if (!paramData.getString("BOX_WIDTH").equals("")) {
            width = paramData.getString("BOX_WIDTH");
        }

        if (!paramData.getString("BOX_LENGTH").equals("")) {
            length = paramData.getString("BOX_LENGTH");
        }

        if (!paramData.getString("BOX_HEIGHT").equals("")) {
            height = paramData.getString("BOX_HEIGHT");
        }

        paramData.put("XRT_INVC_NO", paramData.getString("INVC_SNO"));
        // get Shipment required data
        LDataMap paramMap = new LDataMap();
        paramMap.put("xrtInvcSno", paramData.getString("INVC_SNO"));
        paramMap.put("width", width);
        paramMap.put("length", length);
        paramMap.put("height", height);
        paramMap.put("wgt", paramData.getString("WGT"));

        // 결제 방식에 따른 update 대상 데이터와 api통신 20200210최일규
        String paymentType = paramData.getString("PAYMENT_TYPE");

        switch (paymentType) {
            case CommonConst.PAYEMNT_TYPE_MONTH:
            case CommonConst.PAYEMNT_TYPE_WARRANTY:
                LDataMap shipmentMap = stockInsertBiz.getShipmentData(paramMap);

                if (shipmentMap.getString("code").equals("500")) {
                    throw new LingoException(shipmentMap.getString("message") + "");
                } else if (shipmentMap.getString("code").equals("404")) {
                    throw new LingoException(shipmentMap.getString("message") + "");
                } else if (shipmentMap.getString("code").equals("201")) {
                } else if (shipmentMap.getString("code").equals("200")) {
                    String amount = shipmentMap.getString("amount");
                    String trackingNumber = shipmentMap.getString("trackingNumber");
                    String shippoId = shipmentMap.getString("shippoId");

                    paramData.put("AMOUNT", amount);
                    paramData.put("LOCAL_SHIPPER", "USPS");
                    paramData.put("INVC_SNO1", trackingNumber);
                    paramData.put("SHIPPO_ID", shippoId);
                    paramMap.put("trackingNumber", trackingNumber);

                    stockInsertBiz.addAfterShipTrackings(paramMap);
                }

            default:
                break;
        }

        LDataMap resultData = stockInsertBiz.setSave(paramData);
        LDataMap orderData = stockInsertBiz.getSearch(paramData);
        if ("1".equals(paramData.getString("PAYMENT_TYPE"))) {
            stockInsertBiz.setPaymentMst(orderData);
        }

        LRespData respData = new LRespData();
        respData.put("resultData", resultData);
        respData.put("orderData", orderData);

        return respData;
    }

    // 입고완료 추가개발 20200210최일규
    @RequestMapping(value = "/setCompletion.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setCompletion(@RequestBody LReqData reqData) throws Exception {

        LDataMap paramData = reqData.getParamDataMap("paramData");

        logger.info("paramData => ");
        paramData.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        if (paramData.getString("INVC_SNO").equals("")) {
            throw new LingoException("송장정보를 제대로 읽어오지 못했습니다.");
        }

        String width = "1";
        String length = "1";
        String height = "1";

        if (!paramData.getString("BOX_WIDTH").equals("")) {
            width = paramData.getString("BOX_WIDTH");
        }

        if (!paramData.getString("BOX_LENGTH").equals("")) {
            length = paramData.getString("BOX_LENGTH");
        }

        if (!paramData.getString("BOX_HEIGHT").equals("")) {
            height = paramData.getString("BOX_HEIGHT");
        }

        paramData.put("XRT_INVC_NO", paramData.getString("INVC_SNO"));
        // get Shipment required data
        LDataMap paramMap = new LDataMap();
        paramMap.put("xrtInvcSno", paramData.getString("INVC_SNO"));
        paramMap.put("width", width);
        paramMap.put("length", length);
        paramMap.put("height", height);
        paramMap.put("wgt", paramData.getString("WGT"));

        LDataMap shipmentMap = stockInsertBiz.getShipmentData(paramMap);

        if (shipmentMap.getString("code").equals("500")) {
            throw new LingoException(shipmentMap.getString("message") + "");
        } else if (shipmentMap.getString("code").equals("404")) {
            throw new LingoException(shipmentMap.getString("message") + "");
        } else if (shipmentMap.getString("code").equals("201")) {
        } else if (shipmentMap.getString("code").equals("200")) {
            String amount = shipmentMap.getString("amount");
            String trackingNumber = shipmentMap.getString("trackingNumber");
            String shippoId = shipmentMap.getString("shippoId");

            paramData.put("AMOUNT", amount);
            paramData.put("LOCAL_SHIPPER", "USPS");
            paramData.put("INVC_SNO1", trackingNumber);
            paramData.put("SHIPPO_ID", shippoId);
            paramMap.put("trackingNumber", trackingNumber);

            stockInsertBiz.addAfterShipTrackings(paramMap);
        }

        LDataMap resultData = stockInsertBiz.setPmSave(paramData);
        LDataMap orderData = stockInsertBiz.getSearch(paramData);

        LRespData respData = new LRespData();
        respData.put("resultData", resultData);
        respData.put("orderData", orderData);

        return respData;
    }

    // 입고취소
    @RequestMapping(value = "/setCancel.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setCancel(@RequestBody LReqData reqData) throws Exception {

        LDataMap paramData = reqData.getParamDataMap("paramData");

        logger.info("paramData => ");
        paramData.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        if (paramData.getString("INVC_SNO").equals("")) {
            throw new LingoException("송장정보를 제대로 읽어오지 못했습니다.");
        }

        paramData.put("XRT_INVC_NO", paramData.getString("INVC_SNO"));
        LDataMap rsData = stockInsertBiz.getSearch(paramData);
        // 저장후 30분이 지나면 취소할 수 없음
        if (rsData.getString("STOCK_DATE").equals("")) {
            throw new LingoException("이미 취소처리되었거나 입고상태가 아닙니다.");
        }

        LDataMap resultData = new LDataMap();
        String statusCd = rsData.getString("STATUS_CD");
        // 오더상태가 입고(30)이거나 입금대기(20), 입금완료(21)인 경우, 취소가 가능
        switch (statusCd) {
            case CommonConst.ORD_STATUS_CD_STOCK_COMP:
            case CommonConst.ORD_STATUS_CD_CENTER_ARRIVE:
            case CommonConst.ORD_STATUS_CD_PAYMENT_COMP:
                long min = Util.getDiffTime((Date) rsData.get("STOCK_DATE"));
                // 센터최고권한자 OR Xroute권한자는 30분이후에도 수정가능함.
                if (CommonConst.CENTER_ADMIN.equals(LoginInfo.getUsergroup()) || CommonConst.XROUTE_ADMIN.equals(LoginInfo.getUsergroup())) {
                    resultData = stockInsertBiz.setCancel(paramData);
                } else {
                    if (min <= Integer.parseInt(CommonConst.LABEL_CANCEL_MINUTE)) {
                        resultData = stockInsertBiz.setCancel(paramData);
                    } else {
                        throw new LingoException("수정가능한 시간이 이미 지났습니다.");
                    }
                }
                break;
            default:
                throw new LingoException("입고취소를 할 수 없습니다.");
        }

        LRespData respData = new LRespData();
        respData.put("resultData", resultData);
        return respData;
    }

    // 취소
    @RequestMapping(value = "/setPmCancel.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setPmCancel(@RequestBody LReqData reqData) throws Exception {

        LDataMap paramData = reqData.getParamDataMap("paramData");

        logger.info("paramData => ");
        paramData.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        if (Util.isEmpty(paramData.getString("INVC_SNO"))) {
            throw new LingoException("송장정보를 제대로 읽어오지 못했습니다.");
        }
        // 주문마스터 검색
        paramData.put("XRT_INVC_NO", paramData.getString("INVC_SNO"));
        LDataMap rsData = stockInsertBiz.getSearch(paramData);
        LDataMap resultData = new LDataMap();
        String statusCd = rsData.getString("STATUS_CD");
        // 입금대기(20), 입금완료(21)인 경우, 취소가 가능
        switch (statusCd) {
            case CommonConst.ORD_STATUS_CD_CENTER_ARRIVE:
                resultData = stockInsertBiz.setPmCancel(paramData);
                break;
            case CommonConst.ORD_STATUS_CD_PAYMENT_COMP:
                // 센터최고권한자 OR Xroute권한자는 30분이후에도 수정가능함.
                if (CommonConst.CENTER_ADMIN.equals(LoginInfo.getUsergroup()) || CommonConst.XROUTE_ADMIN.equals(LoginInfo.getUsergroup())) {
                    resultData = stockInsertBiz.setPmCancel(paramData);
                } else {
                    throw new LingoException("셀러는 취소 할 수 있습니다.");
                }
                break;
            default:
                throw new LingoException("입금대기 또는 입금완료 상태가 아닙니다.");
        }

        LRespData respData = new LRespData();
        respData.put("resultData", resultData);
        return respData;
    }

    // 무게측정값 취득
    @RequestMapping(value = "/getWgt.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getWgt(HttpServletRequest request, @RequestBody LReqData reqData) throws Exception {

        HttpSession session = request.getSession();
        LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
        LDataMap paramData = reqData.getParamDataMap("paramData");
        LDataMap whnmMap = commonBiz.getCodeSname("WHNM_INFO", CommonConst.XROUTE_GIMPO_WHCD); // 창고명취득

        logger.info("paramData => ");
        paramData.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        // 로그인 정보에서 저울코드값 취득
        paramData.put("SCALE_CD", loginVo.getScale1());
        paramData.put("WHNM", whnmMap.getString("SNAME1"));
        // 주문마스터 검색
        List<LDataMap> resultData = stockInsertBiz.getWgtSearch(paramData);
        LRespData respData = new LRespData();
        if (resultData == null || resultData.size() == 0) {
            LRespData respData2 = new LRespData();
            respData2.put("WGT", "");
            respData.put("resultData", respData2);
        } else {
            // 데이터 삭제 처리
            stockInsertBiz.updWgt(paramData);
            respData.put("resultData", resultData.get(0));
        }

        return respData;
    }

    // 입고 내역
    @RequestMapping(value = "/getWarehousing.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getWarehousing(@RequestBody LReqData reqData) throws Exception {
        List<LDataMap> resultList = stockInsertBiz.getWarehousing(null);
        LRespData respData = new LRespData();
        respData.put("resultList", resultList);
        return respData;
    }
}
