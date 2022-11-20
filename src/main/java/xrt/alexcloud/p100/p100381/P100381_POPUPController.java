package xrt.alexcloud.p100.p100381;

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
 * 발주대비입고현황 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p100/p100381_popup")
public class P100381_POPUPController {

	@Resource private CommonBiz commonBiz;
	@Resource private P100381_POPUPBiz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeIFSTS = commonBiz.getCommonCode("IFSTATUS");
		List<CodeVO> codeATOMY_INTERFACE = commonBiz.getCommonCode("ATOMY_INTERFACE");

		model.addAttribute("codeIFSTS", codeIFSTS);
		model.addAttribute("gCodeIFSTS", Util.getCommonCodeGrid(codeIFSTS));
		model.addAttribute("gCodeATOMY_INTERFACE", Util.getCommonCodeGrid(codeATOMY_INTERFACE));

		return "alexcloud/p100/p100381/P100381_popup";
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