package xrt.fulfillment.order.parcelproof;

import java.util.HashMap;
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
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

/**
 * 해외 소포 수령증 Controller
 */
@Controller
@RequestMapping(value = "/fulfillment/order/parcelProof")
public class ParcelProofController {

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private ParcelProofBiz biz;

	Logger logger = LoggerFactory.getLogger(ParcelProofController.class);

	// 화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		// 공통코드 년도
		List<CodeVO> year = commonBiz.getCommonCode("YEAR");
		// 공통코드 분기
		List<CodeVO> quarter = commonBiz.getCommonCode("QUARTER");
		// 권한
		Map<String, Object> constMap = new HashMap<String, Object>();
		constMap.put("SELLER_ADMIN", CommonConst.SELLER_ADMIN);
		model.addAttribute("quarter", quarter);
		model.addAttribute("year", year);
		model.addAttribute("constMap", constMap);

		return "fulfillment/order/parcelproof/ParcelProof";
	}

	// 데이터 여부 확인
	@RequestMapping(value = "/getPrint.do", method = RequestMethod.POST)
	public @ResponseBody LRespData getPrint(@RequestBody LDataMap reqData) throws Exception {
		LDataMap searching = biz.getPrint(reqData);
		LRespData retMap = new LRespData();
		retMap.put("flagValue", searching);
		return retMap;
	}

}