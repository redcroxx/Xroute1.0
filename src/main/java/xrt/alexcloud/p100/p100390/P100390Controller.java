package xrt.alexcloud.p100.p100390;

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
 * 입고적치실적 - RealGrid 마스터 디테일 그리드 2개 패턴 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p100/p100390")
public class P100390Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P100390Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeIMSTS = commonBiz.getCommonCode("IMSTS");
		List<CodeVO> codeIMDSTS = commonBiz.getCommonCode("IMDSTS");

		model.addAttribute("codeIMSTS", codeIMSTS);

		model.addAttribute("gCodeIMSTS", Util.getCommonCodeGrid(codeIMSTS));
		model.addAttribute("gCodeIMDSTS", Util.getCommonCodeGrid(codeIMDSTS));
		
		return "alexcloud/p100/p100390/P100390";
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

	//확정
	@RequestMapping(value = "/setExecute.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setExecute(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> paramList = reqData.getParamDataList("paramList");

		LDataMap resultData = biz.setExecute(paramList);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
	
	//확정(분할실적)
	@RequestMapping(value = "/setExecuteDiv.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setExecuteDiv(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("mGridList");
		List<LDataMap> paramList = reqData.getParamDataList("dGridList");

		LDataMap resultData = biz.setExecuteDiv(paramData, paramList);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

	//취소
	@RequestMapping(value = "/setDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setDelete(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> paramList = reqData.getParamDataList("paramList");

		LDataMap resultData = biz.setDelete(paramList);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
	
}
