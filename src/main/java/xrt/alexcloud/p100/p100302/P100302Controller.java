package xrt.alexcloud.p100.p100302;

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
 * 입고등록 - 그리드+입력폼 패턴 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p100/p100302")
public class P100302Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P100302Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
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

		return "alexcloud/p100/p100302/P100302";
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

	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("formData");
		List<LDataMap> paramListData = reqData.getParamDataList("dGridData");

		// 저장
		LDataMap resultData = biz.setSave(paramData, paramListData);

		// 저장이후 검색 처리
		LDataMap searchData = reqData.getParamDataMap("searchData");
		List<LDataMap> resultList = biz.getSearch(searchData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);
		respData.put("resultData", resultData);
		respData.put("wikey", paramData.get("WIKEY"));

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
}
