package xrt.fulfillment.order.orderlist;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

/**
 * 배송조회상세팝업
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/order/orderListDtl")
public class OrderListDtlController {

	Logger logger = LoggerFactory.getLogger(OrderListDtlController.class);

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private OrderListDtlBiz biz;

	// 팝업 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		return "fulfillment/order/orderlist/OrderListDtl";
	}

	@RequestMapping(value = "/getStatusCd.do", method = RequestMethod.POST)
	public @ResponseBody LRespData getStatusCd(@RequestBody CommonSearchVo paramVo) throws Exception {
		LRespData respData = new LRespData();
		respData.put("resultList", biz.getStatusCd(paramVo));
		return respData;
	}

	@RequestMapping(value = "/getOrderDtl.do", method = RequestMethod.POST)
	public @ResponseBody LRespData getOrderDtl(@RequestBody CommonSearchVo paramVo) throws Exception {
		LRespData respData = new LRespData();
		respData.put("resultList", biz.getOrderDtl(paramVo));
		return respData;
	}

	@RequestMapping(value = "/getOrderItems.do", method = RequestMethod.POST)
	public @ResponseBody LRespData getOrderItems(@RequestBody CommonSearchVo paramVo) throws Exception {
		LRespData respData = new LRespData();
		respData.put("resultList", biz.getOrderItems(paramVo));
		return respData;
	}

	@RequestMapping(value = "/update.do", method = RequestMethod.POST)
	public @ResponseBody LRespData OrderUpdate(HttpServletRequest request, @RequestBody UpdateOrderVo paramVo) throws Exception {
		logger.debug("paramVo : "+ paramVo.toString());

		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
		String clientIp = request.getHeader("X-FORWARDED-FOR");
		if ( clientIp == null ) {
			clientIp = request.getRemoteAddr();
		}

		paramVo.setCompcd(loginVo.getCompcd());
		paramVo.setOrgcd(loginVo.getOrgcd());
		paramVo.setWhcd(loginVo.getWhcd());
		paramVo.setAddusercd(loginVo.getUsercd());
		paramVo.setUpdusercd(loginVo.getUsercd());
		paramVo.setTerminalcd(clientIp);

		LDataMap retMap = biz.process(paramVo);
		LRespData respData = new LRespData();
		respData.put("resultList", "");
		return respData;
	}
}
