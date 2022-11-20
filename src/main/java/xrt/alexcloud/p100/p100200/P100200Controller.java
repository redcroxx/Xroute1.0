package xrt.alexcloud.p100.p100200;

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
 * 입고 인터페이스 매핑 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p100/p100200")
public class P100200Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P100200Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeATOMY_INTERFACE = commonBiz.getCommonCode("ATOMY_INTERFACE");
		List<CodeVO> codeIFYN = commonBiz.getCommonCode("IFYN");

		model.addAttribute("gCodeIFYN", Util.getCommonCodeGrid(codeIFYN));
		model.addAttribute("gCodeATOMY_INTERFACE", Util.getCommonCodeGrid(codeATOMY_INTERFACE));

		return "alexcloud/p100/p100200/P100200";
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
	
	//실행(실적전송)
	@RequestMapping(value = "/setExecute.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setExecute(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> paramList = reqData.getParamDataList("paramList");

		LDataMap resultData = biz.setExecute(paramList);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
}
