package xrt.fulfillment.order.orderAmazon;

import java.util.List;
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

import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

/**
 * 아마존 오더 엑셀 업로드 팝업
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/order/OrderAmazon")
public class OrderAmazonController {

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private OrderAmazonBiz orderAmazonBiz;

	Logger logger = LoggerFactory.getLogger(OrderAmazonController.class);

	/**
	 * 팝업 호출 시 사용
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {

		String XROUTE_ADMIN = CommonConst.XROUTE_ADMIN;
		String CENTER_ADMIN = CommonConst.CENTER_ADMIN;
		String SELLER_ADMIN = CommonConst.SELLER_ADMIN;

		// 권한
		model.addAttribute("XROUTE_ADMIN", XROUTE_ADMIN);
		model.addAttribute("CENTER_ADMIN", CENTER_ADMIN);
		model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);


		return "fulfillment/order/orderAmazon/OrderAmazon";
	}

	/**
	 * 양식명 select box
	 * @param reqData
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSiteCd.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSiteCd(@RequestBody LReqData reqData) throws Exception {
		logger.debug("[getSiteCd] reqData : "+ reqData.toString());

		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> resultList = orderAmazonBiz.getSiteCd(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}

	/**
	 * 공통 파라메터 및 아마존 주문 목록 검증 및 xroute Torder, TorderDtl 데이터 변환 후 저장
	 * @param reqData
	 * @return JSON
	 * @throws Exception
	 */
	@RequestMapping(value = "/upload.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData upload(@RequestBody LReqData reqData) throws Exception {
		logger.debug("[upload] reqData : "+ reqData.toString());

		LDataMap paramMap = reqData.getParamDataMap("paramData");
		List<LDataMap> dataList = reqData.getParamDataList("paramList");

		logger.debug("1. param 검증");
		LDataMap validMap = orderAmazonBiz.valid(paramMap, dataList);
		String code = validMap.getString("code");
		if (!code.equals("200")) {
			throw new LingoException("아마존 오더 파일 업로드시 \n 오류가 발생 하였습니다.");
		}
		Map<String, Object> commMap = (Map<String, Object>) validMap.get("commMap");
		List<OrderAmazonVo> orderList = (List<OrderAmazonVo>) validMap.get("orderList");
		logger.debug("2. 아마존 주문 정보 저장");
		orderAmazonBiz.amazonOrderInsert(orderList);
		logger.debug("3. 중복 아마존 주문 정보 조회");

		logger.debug("4. Xroute Torder, TorderDtl 설정");
		LDataMap procgMap= orderAmazonBiz.processing(commMap, orderList);

		LRespData respData = new LRespData();
		respData.put("CODE", procgMap.getString("CODE"));
		respData.put("MESSAGE", procgMap.getString("MESSAGE"));
		return respData;
	}
}
