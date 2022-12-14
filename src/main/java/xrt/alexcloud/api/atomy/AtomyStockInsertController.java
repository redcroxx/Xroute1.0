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
@RequestMapping(value = "/fulfillment/atomy/stockInsert")
public class AtomyStockInsertController {

    Logger logger = LoggerFactory.getLogger(StockInsertController.class);

    private AtomyStockInsertBiz atomyStockInsertBiz;

    @Autowired
    public AtomyStockInsertController(AtomyStockInsertBiz atomyStockInsertBiz) {
        super();
        this.atomyStockInsertBiz = atomyStockInsertBiz;
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

        return "fulfillment/atomy/AtomyStockInsert";
    }

    // ??????.
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("paramMap => ");
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        // ??????????????? ??????
        LDataMap orderMap = atomyStockInsertBiz.getSearch(paramMap);
        // DEL_YN = 'N'?????????, ????????????
        if (Util.isEmpty(orderMap)) {
            throw new LingoException("???????????? ????????? ????????? ???????????? ?????????.");
        }

        List<LDataMap> goodsList = atomyStockInsertBiz.getOrderDtl(orderMap);

        LRespData respData = new LRespData();
        respData.put("resultData", orderMap);
        respData.put("resultList", goodsList);
        return respData;
    }

    // ?????? ??????.
    @RequestMapping(value = "/getStockList.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getStockList(@RequestBody LDataMap paramMap) throws Exception {
        LRespData respData = atomyStockInsertBiz.getStockList(paramMap);
        return respData;
    }
    
    // ???????????? ???????????? ??? ?????????????????? ??????.
    @RequestMapping(value = "/checkInspection.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData checkInspection(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("xrtInvcSno : " + paramMap.getString("xrtInvcSno"));

        if (paramMap.getString("xrtInvcSno").equals("")) {
            throw new LingoException("??????????????? ????????? ???????????? ???????????????.");
        }

        LDataMap resultMap = atomyStockInsertBiz.checkInspection(paramMap);

        LRespData respData = new LRespData();
        respData.put("code", resultMap.getString("clgoScanYn"));
        return respData;
    }

    // ???????????? ????????????.
    @RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setSave(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("paramMap => ");
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        if (paramMap.getString("xrtInvcSno").equals("")) {
            throw new LingoException("??????????????? ????????? ???????????? ???????????????.");
        }

        atomyStockInsertBiz.setSave(paramMap);

        LRespData respData = new LRespData();
        return respData;
    }
    
    // ???????????? ?????? ??????.
    @RequestMapping(value = "/checkSendingComp.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData checkSendingComp(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("xrtInvcSno : " + paramMap.getString("xrtInvcSno"));
       
        LDataMap resultMap = atomyStockInsertBiz.checkSendingComp(paramMap);
        
        LRespData respData = new LRespData();
        respData.put("code", resultMap.getString("code"));
        respData.put("message", resultMap.getString("message"));
        respData.put("statusCd", resultMap.getString("statusCd"));
        return respData;
    }
    
    // ?????? ??????.
    @RequestMapping(value = "/setStockComp.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData setStockComp(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("paramMap => ");
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        
        if (paramMap.getString("xrtInvcSno").equals("")) {
            throw new LingoException("??????????????? ????????? ???????????? ???????????????.");
        }
        
        atomyStockInsertBiz.setStockComp(paramMap);
        
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

        atomyStockInsertBiz.setCancel(paramMap);

        LRespData respData = new LRespData();
        return respData;
    }
}
