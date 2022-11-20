package xrt.fulfillment.atomy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.utils.LDataMap;

@Controller
@RequestMapping(value = "/fulfillment/atomy/test/")
public class AtomyDeliveredTestController {
    
    private AtomyDeliveredTestBiz atomyDeliveredTestBiz;
    
    @Autowired
    public AtomyDeliveredTestController(AtomyDeliveredTestBiz atomyDeliveredTestBiz) {
        this.atomyDeliveredTestBiz = atomyDeliveredTestBiz;
    }
   
    @RequestMapping(value = "setDeliveredUpdate.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap setDeliveredUpdate(@RequestBody CommonSearchVo paramVo) throws Exception {
        String xrtInvcSno = paramVo.getsXrtInvcSno();
        LDataMap order = new LDataMap();
        order.put("xrtInvcSno", xrtInvcSno);
        LDataMap retMap = atomyDeliveredTestBiz.setDeliveredUpdate(order);
        return retMap;
    }
}