package xrt.fulfillment.atomy;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/atomy/rateList")
public class AtomyRateController {
    
    Logger logger = LoggerFactory.getLogger(AtomyRateController.class);
    
    private AtomyRateBiz atomyRateBiz;
    
    @Autowired
    public AtomyRateController(AtomyRateBiz atomyRateBiz) {
        this.atomyRateBiz = atomyRateBiz;
    }
    
    /**
     * 최초 화면 반환
     * 
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/view.do")
    public String view(Model model) throws Exception {
        LDataMap map = atomyRateBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/atomy/AtomyRateList";
    }
    
    @RequestMapping(value = "/total/view.do")
    public String totalView(Model model) throws Exception {
        LDataMap map = atomyRateBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/atomy/AtomyRateTotalList";
    }
    
    /**
     * AtomyRateList 애터미 요율표 목록 조회.
     * 
     * @param model
     * @return
     * @throws Exception
     */
    
    @ResponseBody
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
        LRespData resData = atomyRateBiz.getSearch(reqData);
        return resData;
    }
    
    @ResponseBody
    @RequestMapping(value = "/total/getSearch.do", method = RequestMethod.POST)
    public LRespData getTotalSearch(@RequestBody LReqData reqData) throws Exception {
        LRespData resData = atomyRateBiz.getTotalSearch(reqData);
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
        LDataMap map = atomyRateBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/atomy/AtomyRatePop";
    }
    
    @RequestMapping(value = "/total/pop/view.do")
    public String popTotalView(ModelMap model) throws Exception {
        LDataMap map = atomyRateBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/atomy/AtomyRateTotalPop";
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
        LRespData resData = atomyRateBiz.setSave(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/total/pop/setSave.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setTotalSave(@RequestBody LReqData reqData) throws Exception {
        LRespData resData = atomyRateBiz.setTotalSave(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/updateAtomyRate.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData updateAtomyRate(@RequestBody LReqData reqData) throws Exception{
        LRespData resData = atomyRateBiz.updateAtomyRate(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/total/updateAtomyRate.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData updateAtomyTotalRate(@RequestBody LReqData reqData) throws Exception{
        LRespData resData = atomyRateBiz.updateAtomyTotalRate(reqData);
        return resData;
    }
}
