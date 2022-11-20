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
@RequestMapping(value = "/fulfillment/system/dhlRate")
public class DhlRateController {
    
    Logger logger = LoggerFactory.getLogger(DhlRateController.class);
    
    private DhlRateBiz dhlRateBiz;
    
    @Autowired
    public DhlRateController(DhlRateBiz dhlRateBiz) {
        this.dhlRateBiz = dhlRateBiz;
    }
    
    @RequestMapping(value = "/view.do")
    public String view()throws Exception{
        return "fulfillment/system/dhlRateList";
    }
    
    @RequestMapping(value = "/pop/view.do")
    public String popView() throws Exception {
        return "fulfillment/system/dhlRatePop";
    }
    
    @ResponseBody
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
        LRespData resData = dhlRateBiz.getSearch(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
        LRespData resData = dhlRateBiz.setSave(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/updateDhlRate.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData updateDhlRate(@RequestBody LReqData reqData) throws Exception{
        LRespData resData = dhlRateBiz.updateDhlRate(reqData);
        return resData;
    }
}
