package xrt.alexcloud.p100.p100310;

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
 * 입고지시
 */
@Controller
@RequestMapping(value = "/alexcloud/p100/p100310")
public class P100310Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P100310Biz biz;
	
	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		
		List<CodeVO> codeWISTS = commonBiz.getCommonCode("WISTS"); //입고상태
		List<CodeVO> codeWITYPE = commonBiz.getCommonCode("WITYPE"); //입고유형
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE");
		
		model.addAttribute("codeWISTS", codeWISTS);
		model.addAttribute("gCodeWISTS", Util.getCommonCodeGrid(codeWISTS));
		model.addAttribute("codeWITYPE", codeWITYPE);
		model.addAttribute("gCodeWITYPE", Util.getCommonCodeGrid(codeWITYPE));
		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));
		
		return "alexcloud/p100/p100310/P100310";
	}

	//입고지시처리 팝업 화면 호출
	@RequestMapping(value = "/popupView.do")
	public String popupView(ModelMap model) throws Exception {
		
		List<CodeVO> codeWDTYPE = commonBiz.getCommonCode("WDTYPE"); //입고지시유형
		model.addAttribute("codeWDTYPE", codeWDTYPE);
		
		return "alexcloud/p100/p100310/P100310_popup";
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
	
	//실행(입고지시)
	@RequestMapping(value = "/setExecute.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setExecute(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		LDataMap paramData2 = reqData.getParamDataMap("paramData2");
		List<LDataMap> paramList = reqData.getParamDataList("paramList");

		LDataMap resultData = biz.setExecute(paramData,paramData2, paramList);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

}
