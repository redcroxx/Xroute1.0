package xrt.fulfillment.settlement.masterreport;

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

@Controller
@RequestMapping(value = "/fulfillment/settlement/masterReport")
public class MasterReportController {

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private MasterReportBiz biz;

	// 화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		// 공통코드 국가코드
		List<CodeVO> country = commonBiz.getCommonCode("COUNTRY_CD_LIST");
		model.addAttribute("country", country);
		return "fulfillment/settlement/masterreport/MasterReport";
	}
	
	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	public 	@ResponseBody LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
	    LDataMap paramData = reqData.getParamDataMap("paramData");
	    List<LDataMap> masterList = biz.getSearch(paramData);
	    LRespData retMap = new LRespData();
	    retMap.put("resultList", masterList);
	
	    return retMap;
	}
}
