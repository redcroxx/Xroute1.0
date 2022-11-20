package xrt.alexcloud.p100.p100301;

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
 * 입고등록2 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p100/p100301")
public class P100301Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P100301Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String viewDetail(ModelMap model) throws Exception {
		List<CodeVO> codeWISTS = commonBiz.getCommonCode("WISTS");
		List<CodeVO> codeWITYPE = commonBiz.getCommonCode("WITYPE");
		List<CodeVO> codeVATFLG = commonBiz.getCommonCode("VATFLG");
		List<CodeVO> codeDOCSTS = commonBiz.getCommonCode("DOCSTS");

		model.addAttribute("codeWISTS", codeWISTS);
		model.addAttribute("codeWITYPE", codeWITYPE);
		model.addAttribute("codeVATFLG", codeVATFLG);
		model.addAttribute("codeDOCSTS", codeDOCSTS);

		model.addAttribute("gCodeWISTS", Util.getCommonCodeGrid(codeWISTS));
		model.addAttribute("gCodeWITYPE", Util.getCommonCodeGrid(codeWITYPE));
		model.addAttribute("gCodeVATFLG", Util.getCommonCodeGrid(codeVATFLG));
		model.addAttribute("gCodeDOCSTS", Util.getCommonCodeGrid(codeDOCSTS));
		
		//
		List<CodeVO> codeLOT4 = commonBiz.getCommonCode("LOT4");
		List<CodeVO> codeLOT5 = commonBiz.getCommonCode("LOT5");

		model.addAttribute("gCodeLOT4", Util.getCommonCodeGridAll(codeLOT4));
		model.addAttribute("gCodeLOT5", Util.getCommonCodeGridAll(codeLOT5));

		List<CodeVO> codeFUSER01 = commonBiz.getCommonCode("FUSER01");
		List<CodeVO> codeFUSER02 = commonBiz.getCommonCode("FUSER02");
		List<CodeVO> codeFUSER03 = commonBiz.getCommonCode("FUSER03");
		List<CodeVO> codeFUSER04 = commonBiz.getCommonCode("FUSER04");
		List<CodeVO> codeFUSER05 = commonBiz.getCommonCode("FUSER05");

		model.addAttribute("gCodeFUSER01", Util.getCommonCodeGrid(codeFUSER01));
		model.addAttribute("gCodeFUSER02", Util.getCommonCodeGrid(codeFUSER02));
		model.addAttribute("gCodeFUSER03", Util.getCommonCodeGrid(codeFUSER03));
		model.addAttribute("gCodeFUSER04", Util.getCommonCodeGrid(codeFUSER04));
		model.addAttribute("gCodeFUSER05", Util.getCommonCodeGrid(codeFUSER05));
		
		return "alexcloud/p100/p100301/P100301";
	}

	//상세 검색
	@RequestMapping(value = "/getDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getDetail(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		
		LDataMap resultData = biz.getDetail(paramData);
		List<LDataMap> resultList = biz.getDetailList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		respData.put("resultList", resultList);

		return respData;
	}
	
	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> paramList = reqData.getParamDataList("paramList");

		LDataMap resultData = biz.setSave(paramData, paramList);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

	//삭제
	@RequestMapping(value = "/setDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setDelete(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.setDelete(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
	
	//출력
	@RequestMapping(value = "/getPrint.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getPrint(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.getPrint(paramData);
		
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
}
