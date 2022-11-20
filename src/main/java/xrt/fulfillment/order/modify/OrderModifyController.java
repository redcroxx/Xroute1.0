package xrt.fulfillment.order.modify;

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
import xrt.fulfillment.order.shippinglist.ShippingListVO;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

/**
 * 쉬핑리스트 Controller
 */
@Controller
@RequestMapping(value = "/orderModify")
public class OrderModifyController {

    Logger logger = LoggerFactory.getLogger(OrderModifyController.class);

    private CommonBiz commonBiz;
    private OrderModifyBiz orderModifyBiz;
    
    @Autowired
    public OrderModifyController(CommonBiz commonBiz, OrderModifyBiz orderModifyBiz) {
        super();
        this.commonBiz = commonBiz;
        this.orderModifyBiz = orderModifyBiz;
    }

    // 화면 호출
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {

        List<CodeVO> periodType = commonBiz.getCommonCode("PERIOD");
        List<CodeVO> countrylist = commonBiz.getCommonCode("COUNTRYLIST");
        List<CodeVO> shippingkeyword = commonBiz.getCommonCode("SHIPPINGKEYWORD");

        Map<String, Object> constMap = new HashMap<String, Object>();
        constMap.put("XROUTE_CD", CommonConst.XROUTE_COMPCD);
        constMap.put("XROUTE_ADMIN", CommonConst.XROUTE_ADMIN);
        constMap.put("CENTER_ADMIN", CommonConst.CENTER_ADMIN);
        constMap.put("CENTER_SUPER", CommonConst.CENTER_SUPER_USER);
        constMap.put("CENTER_USER", CommonConst.CENTER_USER);
        constMap.put("SELLER_ADMIN", CommonConst.SELLER_ADMIN);
        constMap.put("SELLER_SUPER", CommonConst.SELLER_SUPER_USER);
        constMap.put("SELLER_USER", CommonConst.SELLER_USER);

        LDataMap map = commonBiz.view();
        model.addAllAttributes(map);
        model.addAttribute("constMap", constMap);
        model.addAttribute("periodType", periodType);
        model.addAttribute("countrylist", countrylist);
        model.addAttribute("shippingkeyword", shippingkeyword);

        return "fulfillment/order/orderModify/orderModify";
    }

    // 검색
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVo) throws Exception {

        List<ShippingListVO> shippingList = orderModifyBiz.getSearch(paramVo);

        LRespData retMap = new LRespData();
        retMap.put("resultList", shippingList);

        return retMap;
    }
}