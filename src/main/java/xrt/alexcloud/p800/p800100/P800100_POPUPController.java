package xrt.alexcloud.p800.p800100;

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
 * 입고등록 - 발주 적용 팝업 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p800/p800100_popup")
public class P800100_POPUPController {

	@Resource private CommonBiz commonBiz;
	@Resource private P800100_POPUPBiz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeIOFLG = commonBiz.getCommonCode("IOFLG");
		List<CodeVO> codeIOTYPE = commonBiz.getCommonCode("IOTYPE");
		model.addAttribute("gCodeIOFLG", Util.getCommonCodeGrid(codeIOFLG));
		model.addAttribute("gCodeIOTYPE", Util.getCommonCodeGrid(codeIOTYPE));
		
		return "alexcloud/p800/p800100/P800100_popup";
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
