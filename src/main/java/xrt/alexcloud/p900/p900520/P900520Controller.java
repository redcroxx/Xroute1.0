package xrt.alexcloud.p900.p900520;

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
 * 로케이션 사용현황 - 마스터 디테일 그리드 2개 패턴 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p900/p900520")
public class P900520Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P900520Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeLOCGROUP = commonBiz.getCommonCode("LOCGROUP");
		List<CodeVO> codeLOCTYPE = commonBiz.getCommonCode("LOCTYPE");

		model.addAttribute("codeLOCGROUP", codeLOCGROUP);
		model.addAttribute("codeLOCTYPE", codeLOCTYPE);
		model.addAttribute("gCodeLOCGROUP", Util.getCommonCodeGrid(codeLOCGROUP));
		model.addAttribute("gCodeLOCTYPE", Util.getCommonCodeGrid(codeLOCTYPE));

		return "alexcloud/p900/p900520/P900520";
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
	
	//출력 팝업
	/*@RequestMapping(value = "/popReportView.do")
	public String popupView(ModelMap model) throws Exception {
		return "alexcloud/p900/p900520/p900520_reportPop";
	}*/
}
