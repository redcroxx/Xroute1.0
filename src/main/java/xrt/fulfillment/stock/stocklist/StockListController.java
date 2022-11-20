package xrt.fulfillment.stock.stocklist;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.Util;

/**
 * 입고리스트
 */
@Controller
@RequestMapping(value = "/fulfillment/stock/stockList")
public class StockListController {

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private StockListBiz biz;

	// 화면호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		
		List<CodeVO> CODE_STOCK_YN = commonBiz.getCommonCode("STOCK_YN"); //입고 YN
		model.addAttribute("CODE_STOCK_YN", CODE_STOCK_YN);
		model.addAttribute("GCODE_STOCK_YN", Util.getCommonCodeGrid(CODE_STOCK_YN));
		
		return "fulfillment/stock/stocklist/StockList";
	}

	// 검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	public @ResponseBody LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<StockListVo> stockList = biz.getSearch(paramData);
		LRespData retMap = new LRespData();
		retMap.put("resultList", stockList);

		return retMap;
	}
}
