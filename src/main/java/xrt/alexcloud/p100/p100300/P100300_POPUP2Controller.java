package xrt.alexcloud.p100.p100300;

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
 * 입고등록 - 애터미 입고 팝업 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p100/p100300_popup2")
public class P100300_POPUP2Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P100300_POPUP2Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeATOMY_INTERFACE = commonBiz.getCommonCode("ATOMY_INTERFACE");
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE");

		model.addAttribute("gCodeATOMY_INTERFACE", Util.getCommonCodeGrid(codeATOMY_INTERFACE));
		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));

		return "alexcloud/p100/p100300/P100300_popup2";
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

}
