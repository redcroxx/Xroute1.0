package xrt.fulfillment.order.payment;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import xrt.alexcloud.api.settlebank.vo.SettleBankResNotiVO;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.order.shippinglist.ShippingListVO;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

/**
 * 주문결제리스트 Controller
 */
@Controller
@RequestMapping(value = "/fulfillment/order/payment/paymentList")
public class PaymentListController {

    Logger logger = LoggerFactory.getLogger(PaymentListController.class);

    private CommonBiz commonBiz;
    private PaymentListBiz paymentListBiz;

    @Autowired
    public PaymentListController(CommonBiz commonBiz, PaymentListBiz paymentListBiz) {
        super();
        this.commonBiz = commonBiz;
        this.paymentListBiz = paymentListBiz;
    }

    // 화면 호출
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {
        List<CodeVO> periodType = commonBiz.getCommonCode("PAYMENT_PERIOD");
        List<CodeVO> paymentKeyword = commonBiz.getCommonCode("PAYMENT_KEYWORD_TYPE");
        
        LDataMap map = commonBiz.view();
        model.addAllAttributes(map);
        model.addAttribute("periodType", periodType);
        model.addAttribute("paymentKeyword", paymentKeyword);
        return "fulfillment/order/payment/PaymentList";
    }

    // 검색
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        logger.info("CommonSearchVo : " + paramVO.toString());
        List<ShippingListVO> paymentList = paymentListBiz.getSearch(paramVO);

        LRespData retMap = new LRespData();
        retMap.put("resultList", paymentList);

        return retMap;
    }

    @RequestMapping(value = "/pop/view.do")
    public String popView(ModelMap model) throws Exception {
        return "fulfillment/order/payment/PaymentPop";
    }

    @RequestMapping(value = "/pop/getSearch.do")
    @ResponseBody
    public LRespData getPopSearch(@RequestBody LReqData reqData) throws Exception {
        logger.debug("LReqData : " + reqData.toString());

        LDataMap paramData = reqData.getParamDataMap("paramData");

        if (paramData.size() == 0) {
            new LingoException("선택된 송장이 없습니다. 주문결제리스트에서 다시 선택해주세요");
        }

        LDataMap paramMap = new LDataMap();
        paramMap.put("xrtInvcSnos", paramData.get("data"));
        paramMap.put("compcd", paramData.getString("LOGIN_COMPCD"));
        paramMap.put("usercd", paramData.getString("LOGIN_USERCD"));
        paramMap.put("orgcd", paramData.getString("LOGIN_ORGCD"));
        paramMap.put("clientIp", paramData.getString("LOGIN_IP"));

        // 1. 조회
        logger.debug("1. Torder 조회");
        List<ShippingListVO> paymentList = paymentListBiz.getPopSearch(paramMap);
        if (paymentList.size() == 0) {
            new LingoException("선택된 송장이 없습니다. 주문결제리스트에서 다시 선택해주세요");
        }

        // 2. TCart 테이블 저장 처리
        logger.debug("2. cartProcess 실행");
        Map<String, Object> cartMap = paymentListBiz.cartProcess(paramMap);

        LRespData retMap = new LRespData();
        retMap.put("resultList", paymentList);
        retMap.put("pOid", cartMap.get("pOid"));
        retMap.put("pEmail", cartMap.get("pEmail"));
        retMap.put("pPhone", cartMap.get("pPhone"));
        retMap.put("pGoods", cartMap.get("pGoods"));
        retMap.put("pMid", cartMap.get("pMid"));
        retMap.put("pAmt", cartMap.get("PAmt"));
        retMap.put("pMname", cartMap.get("pMname"));
        retMap.put("pUname", cartMap.get("pUname"));
        retMap.put("pBname", cartMap.get("pBname"));
        retMap.put("pUserid", cartMap.get("pUserid"));

        return retMap;
    }

    @RequestMapping(value = "/pop/getSettleBank.do", method = RequestMethod.POST)
    public ModelAndView getSettleBank(SettleBankResNotiVO paramVO) throws Exception {

        ModelAndView mav = new ModelAndView();

        Map<String, Object> retMap = paymentListBiz.resSettleBankData(paramVO);

        mav.addObject("rsultData", retMap.get("rsultData"));
        mav.setViewName("fulfillment/order/payment/PopResult");

        return mav;
    }
}
