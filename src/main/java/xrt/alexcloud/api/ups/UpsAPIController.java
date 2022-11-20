package xrt.alexcloud.api.ups;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/api/ups")
public class UpsAPIController {

    Logger logger = LoggerFactory.getLogger(UpsAPIController.class);

    private UpsAPIBiz upsAPIBiz;

    @Autowired
    public UpsAPIController(UpsAPIBiz upsAPIBiz) {
        super();
        this.upsAPIBiz = upsAPIBiz;
    }

    @ResponseBody
    @RequestMapping(value = "/av.do", method = RequestMethod.POST)
    public LRespData setAddressValidation(@RequestBody LDataMap paramMap) throws Exception {
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        LRespData resData = upsAPIBiz.setAddressValidation(paramMap);
        return resData;
    }
    
    @ResponseBody
    @RequestMapping(value = "/shipments.do", method = RequestMethod.POST)
    public LRespData setShipments(@RequestBody LDataMap paramMap) throws Exception {
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        LRespData resData = upsAPIBiz.setShipments(paramMap);
        return resData;
    }
    
    @ResponseBody
    @RequestMapping(value = "/voidShipment.do", method = RequestMethod.POST)
    public LRespData setVoidShipment(@RequestBody LDataMap paramMap) throws Exception {
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        LRespData resData = upsAPIBiz.setShipments(paramMap);
        return resData;
    }
    
    @ResponseBody
    @RequestMapping(value = "/getTrack.do", method = RequestMethod.POST)
    public LRespData getTrack(@RequestBody LDataMap paramMap) throws Exception {
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        LRespData resData = upsAPIBiz.getTrack(paramMap);
        return resData;
    }
}
