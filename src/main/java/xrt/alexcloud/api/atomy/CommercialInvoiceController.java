package xrt.alexcloud.api.atomy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/atomy/commercialInvoice")
public class CommercialInvoiceController {
    
    private CommonBiz commonBiz;
    private CommercialInvoiceBiz commercialInvoiceBiz;
    
    @Autowired
    public CommercialInvoiceController(CommonBiz commonBiz, CommercialInvoiceBiz commercialInvoiceBiz) {
        this.commonBiz = commonBiz;
        this.commercialInvoiceBiz = commercialInvoiceBiz;
    }
    
    @RequestMapping(value = "/view.do")
    public String view(Model model) throws Exception {
        List<CodeVO> periodType = commonBiz.getCommonCode("PERIOD");

        Map<String, Object> constMap = new HashMap<String, Object>();
        constMap.put("XROUTE_CD", CommonConst.XROUTE_COMPCD);
        constMap.put("XROUTE_ADMIN", CommonConst.XROUTE_ADMIN);
        constMap.put("CENTER_ADMIN", CommonConst.CENTER_ADMIN);
        constMap.put("CENTER_SUPER", CommonConst.CENTER_SUPER_USER);
        constMap.put("CENTER_USER", CommonConst.CENTER_USER);
        constMap.put("SELLER_ADMIN", CommonConst.SELLER_ADMIN);
        constMap.put("SELLER_SUPER", CommonConst.SELLER_SUPER_USER);
        constMap.put("SELLER_USER", CommonConst.SELLER_USER);

        model.addAttribute("constMap", constMap);
        model.addAttribute("periodType", periodType);
        return "fulfillment/atomy/CommercialInvoice";
    }
    
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        List<CommercialInvoiceVO> commercialInvoiceList = commercialInvoiceBiz.getSearch(paramVO);
        LRespData retMap = new LRespData();
        retMap.put("resultList", commercialInvoiceList);
        return retMap;
    }
    
    @RequestMapping(value = "/pop/view.do")
    public String popView(ModelMap model) throws Exception {
        LDataMap map = commercialInvoiceBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/atomy/CommercialInvoicePop";
    }
    
    @RequestMapping(value = "/pop/updateCommercialInvoice.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData updateCommercialInvoice(@RequestBody LReqData reqData) throws Exception{
        LRespData resData = commercialInvoiceBiz.updateCommercialInvoice(reqData);
        return resData;
    }
}
