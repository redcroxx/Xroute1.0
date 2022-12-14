package xrt.alexcloud.api.atomy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.CommonConst;
import xrt.fulfillment.stock.stockinsert.StockInsertController;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;

@Controller
@RequestMapping(value = "/fulfillment/atomy/stockInspection")
public class AtomyStockInspectionController {

    Logger logger = LoggerFactory.getLogger(StockInsertController.class);

    private AtomyStockInspectionBiz atomyStockInspectionBiz;

    @Autowired
    public AtomyStockInspectionController(AtomyStockInspectionBiz atomyStockInspectionBiz) {
        super();
        this.atomyStockInspectionBiz = atomyStockInspectionBiz;
    }

    @RequestMapping(value = "/view.do")
    public String view(Model model) throws Exception {
        Map<String, Object> userGroupMap = new HashMap<String, Object>();
        userGroupMap.put("xrouteAdmin", CommonConst.XROUTE_ADMIN);
        userGroupMap.put("centerAdmin", CommonConst.CENTER_ADMIN);
        userGroupMap.put("centerSuper", CommonConst.CENTER_SUPER_USER);
        userGroupMap.put("centerUser", CommonConst.CENTER_USER);
        userGroupMap.put("sellerAdmin", CommonConst.SELLER_ADMIN);
        userGroupMap.put("sellerSuper", CommonConst.SELLER_SUPER_USER);
        userGroupMap.put("sellerUser", CommonConst.SELLER_USER);

        Map<String, Object> statusMap = new HashMap<String, Object>();
        statusMap.put("orderApply", CommonConst.ORD_STATUS_CD_ORDER_APPLY);

        model.addAttribute("userGroupMap", userGroupMap);
        model.addAttribute("statusMap", statusMap);
        model.addAttribute("usercd", LoginInfo.getUsercd());

        return "fulfillment/atomy/AtomyStockInspection";
    }

    // ??????.
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("paramMap => ");
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        // ??????????????? ??????
        LDataMap orderMap = atomyStockInspectionBiz.getSearch(paramMap);
        // DEL_YN = 'N'?????????, ????????????
        if (Util.isEmpty(orderMap)) {
            throw new LingoException("???????????? ????????? ????????? ???????????? ?????????.");
        }

        List<LDataMap> goodsList = atomyStockInspectionBiz.getOrderDtl(orderMap);

        LRespData respData = new LRespData();
        respData.put("resultData", orderMap);
        respData.put("resultList", goodsList);
        return respData;
    }
    
    // ???????????? ??????.
    @RequestMapping(value = "/checkXrtInvcSno.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData checkXrtInvcSno(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("xrtInvcSno : " + paramMap.getString("xrtInvcSno"));
        logger.info("ciplXrtInvcSno : " + paramMap.getString("ciplXrtInvcSno"));
       
        LDataMap resultMap = atomyStockInspectionBiz.checkXrtInvcSno(paramMap);
        
        LRespData respData = new LRespData();
        respData.put("result", resultMap.getString("result"));
        respData.put("message", resultMap.getString("message"));
        respData.put("statusCd", resultMap.getString("statusCd"));
        return respData;
    }

    // ?????? ??????.
    @RequestMapping(value = "/getInspectionList.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getInspectionList(@RequestBody LDataMap paramMap) throws Exception {
        LRespData respData = atomyStockInspectionBiz.getInspectionList(paramMap);
        return respData;
    }
    
    // ?????? ??????.
    @RequestMapping(value = "/setInspection.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setInspection(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("paramMap => ");
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        
        if (paramMap.getString("xrtInvcSno").equals("")) {
            throw new LingoException("??????????????? ????????? ???????????? ???????????????.");
        }
        
        atomyStockInspectionBiz.setInspection(paramMap);
        
        LRespData respData = new LRespData();
        return respData;
    }

    // ?????? ??????.
    @RequestMapping(value = "/setCancel.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setCancel(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("paramMap => ");
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        if (paramMap.getString("xrtInvcSno").equals("")) {
            throw new LingoException("??????????????? ????????? ???????????? ???????????????.");
        }

        atomyStockInspectionBiz.setCancel(paramMap);

        LRespData respData = new LRespData();
        return respData;
    }
}
