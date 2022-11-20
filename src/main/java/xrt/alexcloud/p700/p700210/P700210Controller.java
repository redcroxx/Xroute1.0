package xrt.alexcloud.p700.p700210;

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
 * 로케이션이동확정 - RealGrid 마스터 디테일 그리드 2개 패턴 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p700/p700210")
public class P700210Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P700210Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeIMSTS = commonBiz.getCommonCode("IMSTS");
		List<CodeVO> codeLOCGROUP = commonBiz.getCommonCode("LOCGROUP");
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE");
		
		model.addAttribute("codeIMSTS", codeIMSTS);
		model.addAttribute("codeLOCGROUP", codeLOCGROUP);

		model.addAttribute("gCodeIMSTS", Util.getCommonCodeGrid(codeIMSTS));
		model.addAttribute("gCodeLOCGROUP", Util.getCommonCodeGrid(codeLOCGROUP));
		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));
		
		return "alexcloud/p700/p700210/P700210";
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
		LDataMap paramData = reqData.getParamDataMap("mGridData");
		List<LDataMap> paramListData = reqData.getParamDataList("dGridData");

		LDataMap resultData = biz.setSave(paramData, paramListData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

	//확정
	@RequestMapping(value = "/setExecute.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setExecute(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> paramMList = reqData.getParamDataList("mGridList");
		List<LDataMap> paramDList = reqData.getParamDataList("dGridList");

		LDataMap resultData = biz.setExecute(paramMList, paramDList);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
}
