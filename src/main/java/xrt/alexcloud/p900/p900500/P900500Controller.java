package xrt.alexcloud.p900.p900500;

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
 * 로케이션별재고현황 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p900/p900500")
public class P900500Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P900500Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE");
		List<CodeVO> codeLOCTYPE = commonBiz.getCommonCode("LOCTYPE");
		List<CodeVO> codeLOCGROUP = commonBiz.getCommonCode("LOCGROUP");

		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));
		model.addAttribute("gCodeLOCTYPE", Util.getCommonCodeGrid(codeLOCTYPE));
		model.addAttribute("gCodeLOCGROUP", Util.getCommonCodeGrid(codeLOCGROUP));

		return "alexcloud/p900/p900500/P900500";
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
		LDataMap paramSearch = reqData.getParamDataMap("paramSearch");

		paramData.put("S_LOTKEY", paramSearch.getString("S_LOTKEY"));
		paramData.put("S_ITEM", paramSearch.getString("S_ITEM"));
		paramData.put("S_GUBUN", paramSearch.getString("S_GUBUN"));
		paramData.put("S_F_USER01", paramSearch.getString("S_F_USER01"));
		paramData.put("S_F_USER02", paramSearch.getString("S_F_USER02"));
		paramData.put("S_F_USER03", paramSearch.getString("S_F_USER03"));
		paramData.put("S_F_USER04", paramSearch.getString("S_F_USER04"));
		paramData.put("S_F_USER05", paramSearch.getString("S_F_USER05"));
		paramData.put("S_F_USER11", paramSearch.getString("S_F_USER11"));
		paramData.put("S_F_USER12", paramSearch.getString("S_F_USER12"));
		paramData.put("S_F_USER13", paramSearch.getString("S_F_USER13"));
		paramData.put("S_F_USER14", paramSearch.getString("S_F_USER14"));
		paramData.put("S_F_USER15", paramSearch.getString("S_F_USER15"));

		List<LDataMap> resultList = biz.getDetailList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
}
