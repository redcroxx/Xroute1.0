package xrt.fulfillment.order.efs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/order/efs")
public class EfsController {
    
    Logger logger = LoggerFactory.getLogger(EfsController.class);
    
    private CommonBiz commonBiz;
    private EfsBiz efsBiz;

    @Autowired
    public EfsController(CommonBiz commonBiz, EfsBiz qxpressBiz) {
        super();
        this.commonBiz = commonBiz;
        this.efsBiz = qxpressBiz;
    }

    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {
        List<CodeVO> periodType = commonBiz.getCommonCode("PERIOD");
        List<CodeVO> countrylist = commonBiz.getCommonCode("COUNTRYLIST");
        List<CodeVO> shippingkeyword = commonBiz.getCommonCode("SHIPPINGKEYWORD");
        List<CodeVO> paymentType = commonBiz.getCommonCode("PAYMENTTYPE");

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
        model.addAttribute("countrylist", countrylist);
        model.addAttribute("shippingkeyword", shippingkeyword);
        model.addAttribute("paymentType", paymentType);

        return "fulfillment/order/efs/efs";
    }

    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        logger.debug("CommonSearchVo : " + paramVO.toString());
        List<EfsVO> qxpressList = efsBiz.getSearch(paramVO);
        LRespData retMap = new LRespData();
        retMap.put("resultList", qxpressList);
        return retMap;
    }
}
