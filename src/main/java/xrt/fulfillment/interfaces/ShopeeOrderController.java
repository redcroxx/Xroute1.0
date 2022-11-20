package xrt.fulfillment.interfaces;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import xrt.fulfillment.order.orderinsert.ShippingDataVo;
import xrt.interfaces.shopee.vo.ShopeeOrderVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.Util;

@Controller
@RequestMapping(value = "/interfaceShopee")
public class ShopeeOrderController {

	Logger logger = LoggerFactory.getLogger(ShopeeOrderController.class);

	@Resource
	private ShopeeOrderBiz shopeeOrderBiz;
	@Resource
	private CommonBiz commonBiz;

	// 페이지 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		logger.debug("[view] Start");

		List<CodeVO> shopeeCountry = commonBiz.getCommonCode("SHOPEE_COUNTRY");

		model.addAttribute("shopeeCountry", shopeeCountry);

		return "fulfillment/interfaces/ShopeeOrderList";
	}

	@ResponseBody
	@RequestMapping(value = "/getShopeeOrderList.do", method = RequestMethod.POST)
	public Map getShopeeOrderList(HttpServletRequest request, @RequestBody CommonSearchVo paramVo) throws Exception {
		logger.debug("[getShopeeOrderList] CommonSearchVo : "+ paramVo.toString());

		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
		String clientIp = request.getHeader("X-FORWARDED-FOR");
		if ( clientIp == null ) {
			clientIp = request.getRemoteAddr();
		}

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("count", paramVo.getsCount());
		paramMap.put("country", paramVo.getsCountry());
		paramMap.put("toDate", paramVo.getsToDate());
		paramMap.put("fromDate", paramVo.getsFromDate());
		paramMap.put("userCd", loginVo.getUsercd());
		paramMap.put("whCd", loginVo.getWhcd());
		paramMap.put("compCd", loginVo.getCompcd());
		paramMap.put("orgCd", loginVo.getOrgcd());
		paramMap.put("clientIp", clientIp);

		Map<String, Object> shopeeOrderMap = shopeeOrderBiz.getShopeeOrderList(paramMap);

		return shopeeOrderMap;
	}


	@ResponseBody
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	public LRespData getSearch(HttpServletRequest request, @RequestBody CommonSearchVo paramVo) throws Exception {
		logger.debug("[getSearch] CommonSearchVo : "+ paramVo.toString());

		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");

		paramVo.setsUserCd(loginVo.getUsercd());
		paramVo.setsWhcd(loginVo.getWhcd());
		paramVo.setsOrgCd(loginVo.getOrgcd());
		paramVo.setsCompCd(loginVo.getCompcd());

		List<ShopeeOrderVo> shopeeOrderList = shopeeOrderBiz.getSearch(paramVo);

		LRespData retMap = new LRespData();
		retMap.put("resultList", shopeeOrderList);

		return retMap;
	}

	@ResponseBody
	@RequestMapping(value= "/save.do")
	public Map<String, Object> shopeeOrderListToXrouteTorder(HttpServletRequest request, @RequestBody CommonSearchVo paramVo) throws Exception {
		logger.debug("[shopeeOrderListToXrouteTorder] CommonSearchVo : "+ paramVo.toString());

		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");

		String clientIp = request.getHeader("X-FORWARDED-FOR");
		if ( clientIp == null ) {
			clientIp = request.getRemoteAddr();
		}

		paramVo.setsUserCd(loginVo.getUsercd());
		paramVo.setsWhcd(loginVo.getWhcd());
		paramVo.setsOrgCd(loginVo.getOrgcd());
		paramVo.setsCompCd(loginVo.getCompcd());
		paramVo.setsOrgNm(loginVo.getOrgnm());

		Map<String, Object> retMap = shopeeOrderBiz.shopeeOrderListToXrouteTorder(paramVo, clientIp);
		return retMap;
	}

	@ResponseBody
	@RequestMapping(value= "/getInvoicNumber.do")
	public Map<String, Object> getAgencyInvoicNumber(HttpServletRequest request, @RequestBody CommonSearchVo paramVo) throws Exception {
		logger.debug("[getAgencyInvoicNumber] CommonSearchVo : "+ paramVo.toString());

		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");

		String clientIp = request.getHeader("X-FORWARDED-FOR");
		if ( clientIp == null ) {
			clientIp = request.getRemoteAddr();
		}

		paramVo.setsUserCd(loginVo.getUsercd());
		paramVo.setsWhcd(loginVo.getWhcd());
		paramVo.setsOrgCd(loginVo.getOrgcd());
		paramVo.setsCompCd(loginVo.getCompcd());
		paramVo.setsOrgNm(loginVo.getOrgnm());

		Map<String, Object> ainMap = shopeeOrderBiz.getAgencyInvoicNumber(paramVo, clientIp);
		Map<String, Object> retMap = new HashMap<>();
		ShippingDataVo shippingDataVo = (ShippingDataVo) ainMap.get("data");

		// EFS
		if (!Util.isEmpty(shippingDataVo.getEfsShipmentVos()) && shippingDataVo.getEfsShipmentVos().size() > 0) {
			//EFS API 연동
			retMap = shopeeOrderBiz.efsCreateShipment(shippingDataVo);
			if (!retMap.get("code").equals("200")) {
				String message = retMap.get("message").toString();
				throw new LingoException(message);
			}
		} else {
			retMap.put("code", "404");
			retMap.put("message", "지정되지 않은 배송방식이 있습니다.");
		}
		if (!Util.isEmpty(shippingDataVo.getEtomarsShipmentVos()) && shippingDataVo.getEtomarsShipmentVos().size() > 0) {
			//ETOMARS API 연동
			retMap = shopeeOrderBiz.etomarsRegData(shippingDataVo);
			if (!retMap.get("code").equals("200")) {
				String message = retMap.get("message").toString();
				throw new LingoException(message);
			}
		} else {
			retMap.put("code", "404");
			retMap.put("message", "지정되지 않은 배송방식이 있습니다.");
		}

		if (!Util.isEmpty(shippingDataVo.getQxpressVos()) && shippingDataVo.getQxpressVos().size() > 0) {
			//QXPRESS API 연동
			retMap = shopeeOrderBiz.qxpressRegData(shippingDataVo);
			if (!retMap.get("code").equals("200")) {
				String message = retMap.get("message").toString();
				throw new LingoException(message);
			}
		} else {
			retMap.put("code", "404");
			retMap.put("message", "지정되지 않은 배송방식이 있습니다.");
		}

		return retMap;
	}
}
