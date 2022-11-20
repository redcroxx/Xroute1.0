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
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/atomy/orderProduct")
public class AtomyOrderProductInfoController {
    
    Logger logger  = LoggerFactory.getLogger(AtomyOrderProductInfoController.class);
    
    private AtomyOrderProductInfoBiz atomyOrderProductInfoBiz;
    
    @Autowired
    public AtomyOrderProductInfoController(AtomyOrderProductInfoBiz atomyOrderProductInfoBiz) {
        this.atomyOrderProductInfoBiz = atomyOrderProductInfoBiz;
    }
    
    @RequestMapping(value = "/view.do")
    public String view() throws Exception {
        return "fulfillment/atomy/AtomyOrderProductInfo";
    }
    
    @ResponseBody
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public LRespData getSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        LRespData resData = atomyOrderProductInfoBiz.getSearch(paramVO);
        return resData;
    }
}
