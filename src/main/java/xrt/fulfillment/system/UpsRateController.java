package xrt.fulfillment.system;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/system/upsRate")
public class UpsRateController {
    
    Logger logger = LoggerFactory.getLogger(UpsRateController.class);
    
    private UpsRateBiz upsRateBiz;
    
    @Autowired
    public UpsRateController(UpsRateBiz upsRateBiz) {
        this.upsRateBiz = upsRateBiz;
    }
    
    @RequestMapping(value = "/view.do")
    public String view()throws Exception{
        return "fulfillment/system/upsRateList";
    }
    
    @RequestMapping(value = "/pop/view.do")
    public String popView() throws Exception {
        return "fulfillment/system/upsRatePop";
    }
    
    @ResponseBody
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
        LRespData resData = upsRateBiz.getSearch(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
        LRespData resData = upsRateBiz.setSave(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/updateUpsRate.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData updateUpsRate(@RequestBody LReqData reqData) throws Exception{
        LRespData resData = upsRateBiz.updateUpsRate(reqData);
        return resData;
    }
}
