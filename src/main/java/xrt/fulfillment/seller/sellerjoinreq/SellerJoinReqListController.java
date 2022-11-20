package xrt.fulfillment.seller.sellerjoinreq;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/sellerjoin/sellerJoinReqList")
public class SellerJoinReqListController {

	@Resource private CommonBiz commonBiz;
	@Resource private SellerJoinReqListBiz biz;


	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {

		String GCODE_COUNTRYCD = commonBiz.getCommonCodeGrid("COUNTRYCD"); //국가
		String GCODE_YN = commonBiz.getCommonCodeGrid("YN"); //

		Map<String, Object> constMap = new HashMap<String, Object>();
		constMap.put("CENTER_ADMIN", CommonConst.CENTER_ADMIN);
		constMap.put("CENTER_SUPER", CommonConst.CENTER_SUPER_USER);
		constMap.put("CENTER_USER", CommonConst.CENTER_USER);
		constMap.put("SELLER_ADMIN", CommonConst.SELLER_ADMIN);
		constMap.put("SELLER_SUPER", CommonConst.SELLER_SUPER_USER);
		constMap.put("SELLER_USER", CommonConst.SELLER_USER);
		constMap.put("XROUTE_ADMIN", CommonConst.XROUTE_ADMIN);

		//권한
		model.addAttribute("constMap", constMap);
		model.addAttribute("GCODE_COUNTRYCD", GCODE_COUNTRYCD);
		model.addAttribute("GCODE_YN", GCODE_YN);

		return "fulfillment/seller/sellerjoin/SellerJoinReqList";
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> resultList = biz.getSearch(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}

	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> paramList = reqData.getParamDataList("mGridList");

		LDataMap resultData = biz.setSave(paramList);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

	//승인
	@RequestMapping(value = "/setApproval.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setApproval(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
//		List<LDataMap> paramList = reqData.getParamDataList("mGridList");

		//승인FLG : 승인완료
		paramData.put("APPROVAL_FLG", CommonConst.APPROVAL_FLG_COMP);
		//사용여부 : 사용
		paramData.put("ISUSING", "Y");
		paramData.put("MEM_USERCD", paramData.get("USERCD"));
		paramData.put("email", paramData.get("EMAIL"));
		LDataMap resultData = biz.setApproval(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

}
