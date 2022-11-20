package xrt.alexcloud.p100.p100330;

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
 * 입고적치지시 
 */
@Controller
@RequestMapping(value = "/alexcloud/p100/p100330")
public class P100330Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P100330Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE");
		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));

		return "alexcloud/p100/p100330/P100330";
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

	/**
	 * 입고적치 지시
	 */
	@RequestMapping(value = "/setMoveLoc.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setMoveLoc(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> paramDataList = reqData.getParamDataList("paramDataList");

		biz.setMoveLoc(paramData, paramDataList);

		LRespData respData = new LRespData();
		return respData;

	}
}