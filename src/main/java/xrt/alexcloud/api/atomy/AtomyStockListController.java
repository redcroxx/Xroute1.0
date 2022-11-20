package xrt.alexcloud.api.atomy;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.alexcloud.common.CommonConst;
import xrt.fulfillment.stock.stocklist.StockListVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.Util;

@Controller
@RequestMapping(value = "/fulfillment/atomy/stockList")
public class AtomyStockListController {
    
    private static Logger logger = LoggerFactory.getLogger(AtomyStockListController.class);
    
    @Value("#{config['c.debugtype']}")
    private String debugtype;

    private CommonBiz commonBiz;
    private AtomyStockListBiz atomyStockListBiz;
    
    @Autowired
    public AtomyStockListController(CommonBiz commonBiz, AtomyStockListBiz atomyStockListBiz) {
        this.commonBiz = commonBiz;
        this.atomyStockListBiz = atomyStockListBiz;
    }
    
    // 화면호출.
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {
        List<CodeVO> CODE_STOCK_YN = commonBiz.getCommonCode("STOCK_YN"); //입고 YN
        
        String atomyOrgcd = CommonConst.ATOMY_DEV_ORGCD;
        
        if (debugtype.equals("REAL")) {
            atomyOrgcd = CommonConst.ATOMY_REAL_ORGCD;
        }
        model.addAttribute("atomyOrgcd", atomyOrgcd);
        model.addAttribute("CODE_STOCK_YN", CODE_STOCK_YN);
        model.addAttribute("GCODE_STOCK_YN", Util.getCommonCodeGrid(CODE_STOCK_YN));
        return "fulfillment/atomy/AtomyStockList";
    }

    // 검색.
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
        LDataMap paramData = reqData.getParamDataMap("paramData");
        
        logger.info("atomyOrgcd : " + paramData.getString("atomyOrgcd"));
        List<StockListVo> stockList = atomyStockListBiz.getSearch(paramData);
        LRespData retMap = new LRespData();
        retMap.put("resultList", stockList);
        return retMap;
    }
}
