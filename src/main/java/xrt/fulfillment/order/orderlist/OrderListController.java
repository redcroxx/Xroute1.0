package xrt.fulfillment.order.orderlist;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.order.shippinglist.OrderVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

/**
 * 오더리스트 Controller
 */
@Controller
@RequestMapping(value = "/fulfillment/order/orderList")
public class OrderListController {

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private OrderListBiz biz;

	Logger logger = LoggerFactory.getLogger(OrderListController.class);

	// 화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {

		List<CodeVO> countrylist = commonBiz.getCommonCode("COUNTRYLIST");
		List<CodeVO> orderkeyword = commonBiz.getCommonCode("ORDERKEYWORD");
		List<CodeVO> shopeeCountry = commonBiz.getCommonCode("SHOPEE_COUNTRY");
		List<CodeVO> fileseqlist = commonBiz.getCommonCode("FILESEQLIST");

		String XROUTE_ADMIN = CommonConst.XROUTE_ADMIN;
		String CENTER_ADMIN = CommonConst.CENTER_ADMIN;
		String SELLER_ADMIN = CommonConst.SELLER_ADMIN;

		//권한
		model.addAttribute("XROUTE_ADMIN", XROUTE_ADMIN);
		model.addAttribute("CENTER_ADMIN", CENTER_ADMIN);
		model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);

		model.addAttribute("countrylist", countrylist);
		model.addAttribute("shopeeCountry", shopeeCountry);
		model.addAttribute("orderkeyword", orderkeyword);
		model.addAttribute("fileseqlist", fileseqlist);

		return "fulfillment/order/orderlist/OrderList";
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	public 	@ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVo) throws Exception {

		List<OrderVo> orderList = biz.getSearch(paramVo);

		LDataMap invcSeq = biz.invcSEQ(paramVo);

		LRespData retMap = new LRespData();
		retMap.put("resultList", orderList);
		retMap.put("invcSeq", invcSeq); //송장 SEQ

		return retMap;
	}

	// 품목리스트 갯수 low,max, 중간값
	@RequestMapping(value = "/getCnt.do", method = RequestMethod.POST)
	public 	@ResponseBody LRespData getCnt(@RequestBody CommonSearchVo paramVo) throws Exception {
		LDataMap orderCnt = biz.getListCnt(paramVo);

		LRespData retMap = new LRespData();
		retMap.put("orderCnt", orderCnt); // 리스트 갯수

		return retMap;
	}

	//삭제
	@RequestMapping(value = "/setDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setDelete(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.setDelete(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
}
