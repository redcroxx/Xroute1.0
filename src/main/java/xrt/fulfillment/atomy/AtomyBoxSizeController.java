package xrt.fulfillment.atomy;

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
@RequestMapping(value = "/fulfillment/atomy/boxSize")
public class AtomyBoxSizeController {

    Logger logger = LoggerFactory.getLogger(AtomyBoxSizeController.class);
    
    private AtomyBoxSizeBiz atomyBoxSizeBiz;
    
    @Autowired
    public AtomyBoxSizeController(AtomyBoxSizeBiz atomyBoxSizeBiz) {
        this.atomyBoxSizeBiz = atomyBoxSizeBiz;
    }
    
    @RequestMapping(value = "/view.do")
    public String view() throws Exception {
        return "fulfillment/atomy/AtomyBoxSizeList";
    }
    
    @RequestMapping(value = "/pop/view.do")
    public String popView()throws Exception{
        return "fulfillment/atomy/AtomyBoxSizePop";
    }
    
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
        logger.debug("[AtomyBozSizeController] reqData : " + reqData.toString());
        LRespData resData = atomyBoxSizeBiz.getSearch(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
        logger.debug("[AtomyBoxSizeController] reqData : " +  reqData.toString());
        LRespData resData = atomyBoxSizeBiz.setSave(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/updateBoxSize.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData updateBoxSize(@RequestBody LReqData reqData) throws Exception{
        logger.debug("[AtomyBoxSizeController] reqData : " + reqData.toString());
        LRespData resData = atomyBoxSizeBiz.updateBoxSize(reqData);
        return resData;
    }
}
