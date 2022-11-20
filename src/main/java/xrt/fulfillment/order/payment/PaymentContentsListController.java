package xrt.fulfillment.order.payment;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Controller
@RequestMapping(value = "/fulfillment/order/payment/paymentContentsList")
public class PaymentContentsListController {

    Logger logger = LoggerFactory.getLogger(PaymentContentsListController.class);

    private CommonBiz commonBiz;
    private PaymentContentsListBiz paymentContentsListBiz;

    @Autowired
    public PaymentContentsListController(CommonBiz commonBiz, PaymentContentsListBiz paymentContentsListBiz) {
        super();
        this.commonBiz = commonBiz;
        this.paymentContentsListBiz = paymentContentsListBiz;
    }

    // 화면호출
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {

        List<CodeVO> pstatusCd = commonBiz.getCommonCode("PAYMENT_STATUSCD");
        List<CodeVO> periodType = commonBiz.getCommonCode("ORDERPAYMENT_PERIOD");
        List<CodeVO> ordpaykeyword = commonBiz.getCommonCode("ORDPAY_KEYWORD");

        model.addAttribute("pstatusCd", pstatusCd);
        model.addAttribute("periodType", periodType);
        model.addAttribute("ordpaykeyword", ordpaykeyword);

        return "fulfillment/order/payment/PaymentContentsList";
    }

    // 검색
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        logger.debug("CommonSearchVo : " + paramVO.toString());

        paramVO.setsCompCd(LoginInfo.getCompcd());
        paramVO.setsOrgCd(LoginInfo.getOrgcd());

        List<LDataMap> paymentList = paymentContentsListBiz.getSearch(paramVO);
        LRespData retMap = new LRespData();
        retMap.put("resultList", paymentList);

        return retMap;
    }

    // 화면호출
    @RequestMapping(value = "/pop/view.do")
    public String popView(ModelMap model) throws Exception {
        return "fulfillment/order/payment/PaymentContentsPop";
    }

    // 검색
    @RequestMapping(value = "/pop/getSearch.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getPopSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        logger.debug("CommonSearchVo : " + paramVO.toString());

        paramVO.setsCompCd(LoginInfo.getCompcd());
        paramVO.setsOrgCd(LoginInfo.getOrgcd());

        List<LDataMap> paymentDtlList = paymentContentsListBiz.getPopSearch(paramVO);
        LRespData retMap = new LRespData();
        retMap.put("resultList", paymentDtlList);

        return retMap;
    }

}
