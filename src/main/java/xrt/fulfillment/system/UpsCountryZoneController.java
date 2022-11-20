package xrt.fulfillment.system;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/system/upsCountryZone")
public class UpsCountryZoneController {
    
    Logger logger = LoggerFactory.getLogger(UpsCountryZoneController.class);
    
    private UpsCountryZoneBiz upsCountryZoneBiz;
    
    @Autowired
    public UpsCountryZoneController(UpsCountryZoneBiz upsCountryZoneBiz) {
        this.upsCountryZoneBiz = upsCountryZoneBiz;
    }
    
    @RequestMapping(value = "/view.do")
    public String view() throws Exception{
        return "fulfillment/system/upsCountryZoneList";
    }
    
    @RequestMapping(value = "/popView.do")
    public String popView() throws Exception{
        return "fulfillment/system/upsCountryZonePop";
    }
    
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getSearch(@RequestBody CommonSearchVo reqData) throws Exception {
        LRespData resData = upsCountryZoneBiz.getSearch(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
        LRespData resData = upsCountryZoneBiz.setSave(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/updateCountryZone.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData updateZone(@RequestBody LReqData reqData) throws Exception{
        LRespData resData = upsCountryZoneBiz.updateZone(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/setDelete.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setDelete(@RequestBody LReqData reqData) throws Exception{
        LDataMap paramData = reqData.getParamDataMap("paramData");
        LDataMap resultData = upsCountryZoneBiz.setDelete(paramData);
        LRespData respData = new LRespData();
        respData.put("resultData", resultData);
        return respData;
    }
}
