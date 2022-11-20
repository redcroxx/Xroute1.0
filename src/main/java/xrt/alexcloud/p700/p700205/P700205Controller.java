package xrt.alexcloud.p700.p700205;

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
 * 이동지시서 발행
 */
@Controller
@RequestMapping(value = "/alexcloud/p700/p700205")
public class P700205Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P700205Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeIMSTS = commonBiz.getCommonCode("IMSTS");
		List<CodeVO> codeMVTYPE = commonBiz.getCommonCode("MVTYPE");
		List<CodeVO> codeLOCGROUP = commonBiz.getCommonCode("LOCGROUP");
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE");

		model.addAttribute("codeIMSTS", codeIMSTS);
		model.addAttribute("codeMVTYPE", codeMVTYPE);
		model.addAttribute("codeLOCGROUP", codeLOCGROUP);

		model.addAttribute("gCodeIMSTS", Util.getCommonCodeGrid(codeIMSTS));
		model.addAttribute("gCodeMVTYPE", Util.getCommonCodeGrid(codeMVTYPE));
		model.addAttribute("gCodeLOCGROUP", Util.getCommonCodeGrid(codeLOCGROUP));
		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));

		return "alexcloud/p700/p700205/P700205";
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

	//로케이션이동지시서 팝업 화면 호출
	@RequestMapping(value = "/popReportView.do")
	public String popReportView(ModelMap model) throws Exception {

		return "alexcloud/p700/p700205/P700205_reportPop";
	}


}
