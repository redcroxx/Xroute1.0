package xrt.fulfillment.order.payment;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/sys/passBook")
public class PassBookController {

    Logger logger = LoggerFactory.getLogger(PassBookController.class);

    private PassBookBiz passBookBiz;

    @Autowired
    public PassBookController(PassBookBiz passBookBiz) {
        super();
        this.passBookBiz = passBookBiz;
    }

    @Value("#{config['c.debugtype']}")
    private String debugtype;

    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {

        String url = "https://tbezauth.settlebank.co.kr/js/SettlePay.js";
        if (debugtype.equals("REAL")) {
            url = "https://ezauth.settlebank.co.kr/js/SettlePay.js";
        }

        model.addAttribute("PASS_BOOK_URL", url);
        return "fulfillment/order/payment/PassBookPop";
    }

    @RequestMapping(value = "/auth.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setPassBookAuth(@RequestBody LDataMap paramMap) throws Exception {

        logger.info("paramMap {");
        paramMap.entrySet().forEach(entry -> {
            logger.info("    " + entry.getKey() + " : " + entry.getValue());
        });
        logger.info("}");

        LRespData retMap = passBookBiz.setPassBookAuth(paramMap);
        return retMap;
    }

    @RequestMapping(value = "/callBack.do", method = RequestMethod.POST, consumes = { MediaType.APPLICATION_FORM_URLENCODED_VALUE })
    public ModelAndView getPassBookCallBack(@RequestParam Map<String, Object> reqMap) throws Exception {
        logger.info("reqMap {");
        reqMap.entrySet().forEach(entry -> {
            logger.info("    " + entry.getKey() + " : " + entry.getValue());
        });
        logger.info("}");

        LDataMap paramMap = new LDataMap();
        paramMap.put("resultCd", reqMap.get("resultCd"));
        paramMap.put("errCd", reqMap.get("errCd"));
        paramMap.put("ordNo", reqMap.get("ordNo"));
        paramMap.put("authNo", reqMap.get("authNo"));
        paramMap.put("regularpayKey", reqMap.get("regularpayKey"));

        LDataMap dataMap = passBookBiz.getCallBack(paramMap);

        ModelAndView mav = new ModelAndView();
        mav.addObject("resultCd", dataMap.getString("resultCd"));
        mav.addObject("errCd", dataMap.getString("errCd"));
        mav.addObject("ordNo", dataMap.getString("ordNo"));
        mav.addObject("authNo", dataMap.getString("authNo"));
        mav.setViewName("fulfillment/order/payment/PassBookCallBackPop");
        return mav;

    }

    @RequestMapping(value = "/payApprov.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setPayApprov(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("paramMap {");
        paramMap.entrySet().forEach(entry -> {
            logger.info("    " + entry.getKey() + " : " + entry.getValue());
        });
        logger.info("}");

        LRespData retMap = passBookBiz.setPayApprov(paramMap);
        return retMap;
    }

    @RequestMapping(value = "/regularPayment.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setRegularPayment(@RequestBody LDataMap paramMap) throws LingoException {
        logger.info("paramMap {");
        paramMap.entrySet().forEach(entry -> {
            logger.info("    " + entry.getKey() + " : " + entry.getValue());
        });
        logger.info("}");

        LDataMap validMap = passBookBiz.checkedRegularPayment(paramMap);
        if (validMap.getString("code").equals("1")) {
            LRespData dataMap = passBookBiz.setRegularPayment(paramMap);
            LRespData retMap = passBookBiz.setReturnRegular(dataMap);
            return retMap;
        } else {
            LRespData retMap = new LRespData();
            retMap.put("CODE", validMap.getString("code"));
            retMap.put("MESSAGE", validMap.getString("message"));
            return retMap;
        }
    }

    @RequestMapping(value = "/payCancel.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setPayCancel(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("paramMap {");
        paramMap.entrySet().forEach(entry -> {
            logger.info("    " + entry.getKey() + " : " + entry.getValue());
        });
        logger.info("}");

        LRespData retMap = passBookBiz.setPayCancel(paramMap);
        return retMap;
    }

    @RequestMapping(value = "/regularCancel.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setRegularCancel(@RequestBody LReqData paramMap) throws Exception {
        logger.info("paramMap {");
        paramMap.entrySet().forEach(entry -> {
            logger.info("    " + entry.getKey() + " : " + entry.getValue());
        });
        logger.info("}");

        LRespData retMap = passBookBiz.setRegularCancel(paramMap);
        return retMap;
    }

}
