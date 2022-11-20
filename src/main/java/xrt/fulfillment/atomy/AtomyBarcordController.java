package xrt.fulfillment.atomy;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/atomy/barcord")
public class AtomyBarcordController {

    Logger logger = LoggerFactory.getLogger(AtomyBarcordController.class);

    private AtomyBarcordBiz atomyBarcordBiz;

    @Autowired
    public AtomyBarcordController(AtomyBarcordBiz atomyBarcordBiz) {
        this.atomyBarcordBiz = atomyBarcordBiz;
    }

    @RequestMapping(value = "/view.do")
    public String view() throws Exception {
        return "fulfillment/atomy/AtomyBarcordList";
    }

    @RequestMapping(value = "/pop/view.do")
    public String popView() throws Exception {
        return "fulfillment/atomy/AtomyBarcordPop";
    }

    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getSearch(@RequestBody LDataMap paramMap) throws Exception {
        logger.debug(" paramMap : " + paramMap.toString());
        LRespData resData = atomyBarcordBiz.getSearch(paramMap);
        return resData;
    }

    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
        logger.debug(" reqData : " + reqData.toString());
        LRespData resData = atomyBarcordBiz.setSave(reqData);
        return resData;
    }

    @RequestMapping(value = "/setUpdate.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setUpdate(@RequestBody LReqData reqData) throws Exception {
        logger.debug("[AtomyBoxSizeController] reqData : " + reqData.toString());
        LRespData resData = atomyBarcordBiz.setUpdate(reqData);
        return resData;
    }

}
