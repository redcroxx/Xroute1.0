package xrt.alexcloud.p100.p100320;

import java.util.List;

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
import xrt.lingoframework.utils.Util;
/**
 * 입고실적 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p100/p100320")
public class P100320Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P100320Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeWISTS = commonBiz.getCommonCode("WISTS");
		List<CodeVO> codeWITYPE = commonBiz.getCommonCode("WITYPE");
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE");
		List<CodeVO> codeWDTYPE = commonBiz.getCommonCode("WDTYPE");

		model.addAttribute("codeWISTS", codeWISTS);
		model.addAttribute("codeWITYPE", codeWITYPE);

		model.addAttribute("gCodeWDTYPE", Util.getCommonCodeGrid(codeWDTYPE));
		model.addAttribute("gCodeWISTS", Util.getCommonCodeGrid(codeWISTS));
		model.addAttribute("gCodeWITYPE", Util.getCommonCodeGrid(codeWITYPE));
		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));

		return "alexcloud/p100/p100320/P100320";
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

	//미입고 리스트 검색
	@RequestMapping(value = "/getTab2List.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getTab2List(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getTab2List(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}

	/**
	 * 입고실적 처리
	 */
	@RequestMapping(value = "/setInstruct.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setInstruct(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> paramDataList = reqData.getParamDataList("paramDataList");

		biz.setInstruct(paramData, paramDataList);

		LRespData respData = new LRespData();
		//respData.put("resultData", resultData);

		return respData;

	}

	/**
	 * 강제종료 처리
	 */
	@RequestMapping(value = "/setExecute.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setExecute(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		biz.setExecute(paramData);

		LRespData respData = new LRespData();
		//respData.put("resultData", resultData);

		return respData;

	}
}