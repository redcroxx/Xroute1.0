package xrt.alexcloud.p700.p700300;

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
 * 로케이션변경 - 로케이션변경 - 마스터,디테일  RealGrid -> 총 2개 (장바구니 형태) Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p700/p700300")
public class P700300Controller {
	
	@Resource private CommonBiz commonBiz;
	@Resource private P700300Biz biz;
	
	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeLOCGROUP = commonBiz.getCommonCode("LOCGROUP");
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE");
		
		model.addAttribute("codeLOCGROUP", codeLOCGROUP);
		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));
		
		return "/alexcloud/p700/p700300/P700300";
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
	//실행 (로케이션 변경)
	@RequestMapping(value = "/setExecute.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setExecute(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> paramDataList = reqData.getParamDataList("paramDataList");
		
		LDataMap resultData = biz.setExecute(paramDataList);
		
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		
		return respData;
		
	}
}
