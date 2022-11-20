package xrt.alexcloud.p100.p100351;

import java.util.List;
import xrt.lingoframework.utils.Util;

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
/**
 * 입고실적수량변경 - RealGrid 마스터 디테일 그리드 2개 패턴 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p100/p100351")
public class P100351Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P100351Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeWISTS = commonBiz.getCommonCode("WISTS");
		List<CodeVO> codeWITYPE = commonBiz.getCommonCode("WITYPE");
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE");

		model.addAttribute("codeWISTS", codeWISTS);
		model.addAttribute("codeWITYPE", codeWITYPE);

		model.addAttribute("gCodeWISTS", Util.getCommonCodeGrid(codeWISTS));
		model.addAttribute("gCodeWITYPE", Util.getCommonCodeGrid(codeWITYPE));
		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));

		return "alexcloud/p100/p100351/P100351";
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

	//디테일 리스트 검색
	@RequestMapping(value = "/getDetailList.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getDetailList(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getDetailList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}

	//실행
	@RequestMapping(value = "/setExecute.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setExecute(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> paramDataList = reqData.getParamDataList("paramDataList");

		LDataMap resultData = biz.setExecute(paramDataList);
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
}
