package xrt.alexcloud.p000.p000002;

import java.util.List;

import javax.annotation.Resource;

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
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.Util;

@Controller
@RequestMapping(value = "/alexcloud/p000/p000002")
public class P000002Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P000002Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {

		List<CodeVO> codeISUSING = commonBiz.getCommonCode("ISUSING");
		String GCODE_COUNTRYCD = commonBiz.getCommonCodeGrid("COUNTRYCD"); //국가
		String GCODE_YN = commonBiz.getCommonCodeGrid("YN"); //
		String SELLER_ADMIN = CommonConst.SELLER_ADMIN;
		List<CodeVO> codePAYMENTTYPE = commonBiz.getCommonCode("PAYMENTTYPE"); //결제타입구분

		//권한
		model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);
		model.addAttribute("codeISUSING", codeISUSING);
		model.addAttribute("gCodeISUSING", Util.getCommonCodeGrid(codeISUSING));
		model.addAttribute("GCODE_COUNTRYCD", GCODE_COUNTRYCD);
		model.addAttribute("GCODE_YN", GCODE_YN);
		model.addAttribute("gCodePAYMENTTYPE", Util.getCommonCodeGrid(codePAYMENTTYPE));

		return "alexcloud/p000/p000002/P000002";
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

	//미사용
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
