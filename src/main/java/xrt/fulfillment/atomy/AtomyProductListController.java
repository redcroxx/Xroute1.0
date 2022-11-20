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
@RequestMapping(value = "/fulfillment/atomy/productList")
public class AtomyProductListController {
    
    Logger logger = LoggerFactory.getLogger(AtomyProductListController.class);
    
    private AtomyProductListBiz atomyProductListBiz;
    
    @Autowired
    public AtomyProductListController(AtomyProductListBiz atomyProductListBiz) {
        this.atomyProductListBiz = atomyProductListBiz;
    }
    
    @RequestMapping(value = "/view.do")
    public String view() throws Exception {
        return "fulfillment/atomy/AtomyProductList";
    }
    
    @RequestMapping(value = "/pop/view.do")
    public String popView() throws Exception{
        return "fulfillment/atomy/AtomyProductPop";
    }
    
    @ResponseBody
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public LRespData getSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        LRespData resData = atomyProductListBiz.getSearch(paramVO);
        return resData;
    }
    
    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
        LRespData resData = atomyProductListBiz.setSave(reqData);
        return resData;
    }
    
    @RequestMapping(value = "/updateAtomyProduct.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData updateAtomyProduct(@RequestBody LReqData reqData) throws Exception{
        LRespData resData = atomyProductListBiz.updateAtomyProduct(reqData);
        return resData;
    }
}
