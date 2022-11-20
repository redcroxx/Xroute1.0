package xrt.fulfillment.system;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

/**
 * RateController
 * 
 * @since 2020-12-23
 * @author ljh
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/system/premiumRate")
public class PremiumRateController {

    Logger logger = LoggerFactory.getLogger(PremiumRateController.class);

    private PremiumRateBiz rateBiz;

    @Autowired
    public PremiumRateController(PremiumRateBiz rateBiz) {
        super();
        this.rateBiz = rateBiz;
    }
    
    /**
     * 최초 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {
        LDataMap map = rateBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/system/premiumRateList";
    }

    /**
     * RateList 요율표 목록 조회.
     * 
     * @param model
     * @return
     * @throws Exception
     */
    
    @ResponseBody
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
        logger.debug("reqData : " + reqData.toString());
        LRespData resData = rateBiz.getSearch(reqData);
        return resData;
    }
    
    /**
     * RatePop 요율표 등록 팝업 호출.
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/view.do")
    public String popView(ModelMap model) throws Exception {
        LDataMap map = rateBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/system/premiumRatePop";
    }
    
    /**
     * 
     * @param reqData
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
        logger.debug("[RateController] reqData : " +  reqData.toString());
        LRespData resData = rateBiz.setSave(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/updateRateList.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData updateRateList(@RequestBody LReqData reqData) throws Exception{
        logger.debug("[RateController] reqData : " + reqData.toString());
        LRespData resData = rateBiz.updateRateList(reqData);
        return resData;
    }
}
