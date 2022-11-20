package xrt.fulfillment.order.shippinglist;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
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
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

/**
 * 쉬핑리스트 Controller
 */
@Controller
@RequestMapping(value = "/fulfillment/order/shippingList")
public class ShippingListController {

    Logger logger = LoggerFactory.getLogger(ShippingListController.class);

    private CommonBiz commonBiz;
    private ShippingListBiz shippingListBiz;
    
    @Autowired
    public ShippingListController(CommonBiz commonBiz, ShippingListBiz shippingListBiz) {
        super();
        this.commonBiz = commonBiz;
        this.shippingListBiz = shippingListBiz;
    }

    // 화면 호출
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model, HttpServletRequest request) throws Exception {

        String sToDate = request.getParameter("sToDate");
        String sFromDate = request.getParameter("sFromDate");
        String sStatusCd = request.getParameter("sStatusCd");

        if (sToDate == null || sFromDate == null) {
            sToDate = "";
            sFromDate = "";
        }
        if (sStatusCd == null || sStatusCd.equals("All")) {
            sStatusCd = "";
        }

        List<CodeVO> periodType = commonBiz.getCommonCode("PERIOD");
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
        
        LDataMap map = commonBiz.view();
        model.addAllAttributes(map);
        model.addAttribute("constMap", constMap);
        model.addAttribute("periodType", periodType);
        model.addAttribute("shippingkeyword", shippingkeyword);
        model.addAttribute("paymentType", paymentType);
        model.addAttribute("sToDate", sToDate);
        model.addAttribute("sFromDate", sFromDate);
        model.addAttribute("sStatusCd", sStatusCd);

        return "fulfillment/order/shippinglist/ShippingList";
    }

    // 검색
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVo) throws Exception {
        
        if (Integer.parseInt(LoginInfo.getUsergroup()) <= Integer.parseInt(CommonConst.SELLER_ADMIN)) {
            paramVo.setsEtcCd1(CommonConst.SELLER_USER);
        }else {
            paramVo.setsEtcCd1("");
        }
        
        List<ShippingListVO> shippingList = shippingListBiz.getSearch(paramVo);
        LRespData retMap = new LRespData();
        retMap.put("resultList", shippingList);

        return retMap;
    }
    
    /**
     * 최초 팝업 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/view.do")
    public String popView(ModelMap model) throws Exception {
        return "fulfillment/order/shippinglist/ShippingPop";
    }

    @RequestMapping(value = "/pop/getSearch.do")
    @ResponseBody
    public LRespData getPopSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        logger.debug("CommonSearchVo : " + paramVO.toString());
        LDataMap orderMap = shippingListBiz.getPopSearch(paramVO);
        LRespData resData = shippingListBiz.setTrackingHistory(orderMap);
        return resData;
    }
    
    @RequestMapping(value = "/statusRefresh.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData shippingStatusRefresh() throws Exception {
        logger.debug("shippingStatusRefresh");
        List<LDataMap> orders = shippingListBiz.shippingGetOrders();
        LRespData resData = shippingListBiz.setAtomyHistoryRefresh(orders);        
        return resData;
    }
}