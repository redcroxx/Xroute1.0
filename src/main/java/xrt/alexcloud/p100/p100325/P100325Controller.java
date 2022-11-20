package xrt.alexcloud.p100.p100325;

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
 * 입고지시/실적
 */
@Controller
@RequestMapping(value = "/alexcloud/p100/p100325")
public class P100325Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P100325Biz biz;
	
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
		
		return "alexcloud/p100/p100325/P100325";
	}

	//입고지시/실적처리 팝업 화면 호출
	@RequestMapping(value = "/popupView.do")
	public String popupView(ModelMap model) throws Exception {
		return "alexcloud/p100/p100325/P100325_popup";
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

	//입고로케이션 검색
	@RequestMapping(value = "/getWiLoccd.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getWiLoccd(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.getWiLoccd(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

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
	
	//실행(실적처리)
	@RequestMapping(value = "/setExecute.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setExecute(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> paramList = reqData.getParamDataList("paramList");
		List<LDataMap> paramList2 = reqData.getParamDataList("paramList2");

		LDataMap resultData = biz.setExecute(paramData, paramList, paramList2);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

}
