package xrt.fulfillment.order.modify;

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
@RequestMapping(value = "/orderModifyDtl")
public class OrderModifyDtlController {

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private OrderModifyDtlBiz biz;

	Logger logger = LoggerFactory.getLogger(OrderModifyDtlController.class);

	/**
	 * 팝업 호출 시 사용
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {

		return "fulfillment/order/orderModify/orderModifyDtl";
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

		List<LDataMap> dataList = reqData.getParamDataList("dataList");

		logger.debug("1. param 검증");
		LDataMap validMap = biz.valid(dataList);
		String code = validMap.getString("code");
		if (!code.equals("200")) {
			throw new LingoException("오더 수정 파일 업로드시 \n 오류가 발생 하였습니다.");
		}

		logger.debug("2. TORDER 업데이트");
		LDataMap procgMap = biz.setTorder(dataList);

		LRespData respData = new LRespData();
		respData.put("CODE", procgMap.getString("CODE"));
		respData.put("MESSAGE", procgMap.getString("MESSAGE"));
		return respData;
	}
}
