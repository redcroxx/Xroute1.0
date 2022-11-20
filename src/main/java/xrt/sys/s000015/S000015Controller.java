package xrt.sys.s000015;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
/**
 * 공지사항
 */
@Controller
@RequestMapping(value = "/sys/s000015")
public class S000015Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private S000015Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		
		model.addAttribute("CODE_NTTYPE", commonBiz.getCommonCodeOnlyName("NTTYPE"));
		model.addAttribute("CODE_ISUSING", commonBiz.getCommonCodeOnlyName("ISUSING"));
		model.addAttribute("CODE_NTTARGET", commonBiz.getCommonCodeOnlyName("NTTARGET"));
		model.addAttribute("CODE_YN", commonBiz.getCommonCodeOnlyName("YN"));
		
		model.addAttribute("gCODE_NTTYPE", commonBiz.getCommonCodeOnlyNameGrid("NTTYPE"));
		model.addAttribute("gCODE_ISUSING", commonBiz.getCommonCodeOnlyNameGrid("ISUSING"));
		model.addAttribute("gCODE_NTTARGET", commonBiz.getCommonCodeOnlyNameGrid("NTTARGET"));
		model.addAttribute("gCODE_YN", commonBiz.getCommonCodeOnlyNameGrid("YN"));
		
		return "sys/s000015/S000015";
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);
		respData.put("resultData", paramData);

		return respData;
	}
	
	//조회수 증가
	@RequestMapping(value = "/setHits.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.setHits(paramData);

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
}