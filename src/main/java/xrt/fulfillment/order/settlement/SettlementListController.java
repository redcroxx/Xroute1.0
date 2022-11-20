package xrt.fulfillment.order.settlement;

import java.util.ArrayList;
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
import xrt.alexcloud.common.vo.ShipPriceSearchVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.LRespData;

/**
 * 정산조회 Controller
 */
@Controller
@RequestMapping(value = "/fulfillment/settlement/settlementList")
public class SettlementListController {
    
    Logger logger = LoggerFactory.getLogger(SettlementListController.class);

    private CommonBiz commonBiz;
    private SettlementListBiz settlementListBiz;

    @Autowired
    public SettlementListController(CommonBiz commonBiz, SettlementListBiz settlementListBiz) {
        super();
        this.commonBiz = commonBiz;
        this.settlementListBiz = settlementListBiz;
    }

    // 화면 호출
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {

        List<CodeVO> periodType = commonBiz.getCommonCode("PERIOD");
        List<CodeVO> countrylist = commonBiz.getCommonCode("COUNTRYLIST");
        List<CodeVO> shippingkeyword = commonBiz.getCommonCode("SHIPPINGKEYWORD");
        List<CodeVO> shipcompanylist = commonBiz.getCommonCode("SHIP_COMPANY_LIST");

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
        model.addAttribute("shipcompanylist", shipcompanylist);

        return "fulfillment/settlement/settlementlist/SettlementList";
    }

    // 검색
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVo) throws Exception {

        List<SettlementListVo> shippingList = settlementListBiz.getSearch(paramVo);

        LRespData retMap = new LRespData();
        retMap.put("resultList", shippingList);

        return retMap;
    }

    // 업체 판매가 검색
    @RequestMapping(value = "/getPriceSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getPriceSearch(@RequestBody ShipPriceSearchVo paramVo) throws Exception {

        // 배송업체를 보고 API를 취득
        // 배송업체가 EFS인 경우
        String shipCompany = paramVo.getShipCompany();

        List<Map<String, Object>> resList = new ArrayList<>();
        List<SettlementListVo> shippingList = new ArrayList<>();
        // Map<String, Object> resMap = new HashMap<>();
        if ("EFS".equals(shipCompany)) {
            // API연동
            // DB업데이트 (판매가, 무게 업데이트)
            resList = settlementListBiz.getEfsTrackStatus(paramVo);
        } else if ("ETOMARS".equals(shipCompany)) {
            // API연동
            // DB업데이트
            resList = settlementListBiz.estShippingFee(paramVo);
        } else if ("QXPRESS".equals(shipCompany)) {
            // API연동
            // DB업데이트
            resList = settlementListBiz.getQxpressTrackingData(paramVo);
        }
        for (Map<String, Object> resMap : resList) {
            String error = resMap.get("error").toString();
            if ("Y".equals(error)) {

                String message = resMap.get("message").toString();
                if (resMap.get("message").equals("")) {
                    message = "배송데이터를 취득중 에러가 발생했습니다.";
                }
                throw new LingoException(message);
            }
        }

        shippingList = settlementListBiz.getPriceSearchData(paramVo);

        // API연동결과
        LRespData retMap = new LRespData();
        retMap.put("resList", resList);
        retMap.put("resultList", shippingList);
        return retMap;
    }
}