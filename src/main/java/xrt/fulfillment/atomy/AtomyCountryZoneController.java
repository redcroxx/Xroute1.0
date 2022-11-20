package xrt.fulfillment.atomy;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/atomy/countryZone")
public class AtomyCountryZoneController {
    
    
    Logger logger = LoggerFactory.getLogger(AtomyCountryZoneController.class);
    
    private AtomyCountryZoneBiz atomyCountryZoneBiz;
    
    @Autowired
    public AtomyCountryZoneController(AtomyCountryZoneBiz atomyZoneBiz) {
        this.atomyCountryZoneBiz = atomyZoneBiz;
    }
    
    @RequestMapping(value = "/view.do")
    public String view()throws Exception{
        return "fulfillment/atomy/AtomyCountryZoneList";
    }
    
    @RequestMapping(value = "/pop/view.do")
    public String popView()throws Exception{
        return "fulfillment/atomy/AtomyCountryZonePop";
    }
    
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getSearch(@RequestBody CommonSearchVo reqData) throws Exception {
        LRespData resData = atomyCountryZoneBiz.getSearch(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
        LRespData resData = atomyCountryZoneBiz.setSave(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/updateZone.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData updateZone(@RequestBody LReqData reqData) throws Exception{
        LRespData resData = atomyCountryZoneBiz.updateZone(reqData);
        return resData;
    }
}
