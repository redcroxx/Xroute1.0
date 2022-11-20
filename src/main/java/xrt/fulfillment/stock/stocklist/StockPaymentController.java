package xrt.fulfillment.stock.stocklist;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

/**
 * 입고결제화면 팝업
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/stock/stockPayment")
public class StockPaymentController {

	Logger logger = LoggerFactory.getLogger(StockPaymentController.class);

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private StockPaymentBiz biz;

	// 팝업 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		return "fulfillment/stock/stocklist/StockPayment";
	}

	// 결제 금액
	@RequestMapping(value = "/getAmount.do")
	public @ResponseBody Map<String, Object> getAmount(@RequestBody StockListVo paramVo) throws Exception {
		Map<String, Object> retMap = biz.getAmount(paramVo);
		retMap.put("CODE", "1");

		return retMap;
	}
	
	@RequestMapping(value = "/setAmountUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setAmountUpdate(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		LDataMap updateData = new LDataMap();
		String amount = (String) paramData.get("pmAmount");
		paramData.put("pmAmount", amount.replaceAll(",", ""));
		updateData = biz.updateData(paramData);
		
		LRespData respData = new LRespData();
		respData.put("updateData", updateData);
		return respData;
	}

}
