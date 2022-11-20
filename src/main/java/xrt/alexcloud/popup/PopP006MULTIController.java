package xrt.alexcloud.popup;
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
 * 품목코드 팝업
 */
@Controller
@RequestMapping(value = "/alexcloud/popup/popP006MULTI")
public class PopP006MULTIController {

	@Resource private CommonBiz commonBiz;
	@Resource private PopP006MULTIBiz biz;

	//팝업 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {

		List<CodeVO> codeISUSING = commonBiz.getCommonCode("ISUSING");
		List<CodeVO> codeLOT4 = commonBiz.getCommonCode("LOT4");
		List<CodeVO> codeLOT5 = commonBiz.getCommonCode("LOT5");

		model.addAttribute("gCodeLOT4", Util.getCommonCodeGridAll(codeLOT4));
		model.addAttribute("gCodeLOT5", Util.getCommonCodeGridAll(codeLOT5));

		model.addAttribute("codeISUSING", codeISUSING);
		model.addAttribute("gCodeISUSING", Util.getCommonCodeGrid(codeISUSING));

		return "alexcloud/popup/PopP006MULTI";
	}

	//검색
	@RequestMapping(value = "/search.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData search(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}

	//코드 유효성 검사
	@RequestMapping(value = "/check.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData check(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getCheck(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
}