package xrt.fulfillment.settlement.masterreport;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/settlement/packingDetails")
public class PackingDetailsController {

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private PackingDetailsBiz packingDetailsBiz;

	// 화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		// 공통코드 국가코드
	    // List<CodeVO> country = commonBiz.getCommonCode("COUNTRY_CD_LIST");
	    // model.addAttribute("country", country);
	    LDataMap map = packingDetailsBiz.view();
        model.addAllAttributes(map);
		return "fulfillment/settlement/masterreport/PackingDetails";
	}
	
	// 검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	public 	@ResponseBody LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
	    LDataMap paramData = reqData.getParamDataMap("paramData");
	    List<LDataMap> packingDetailsList = packingDetailsBiz.getSearch(paramData);
	    LRespData retMap = new LRespData();
	    retMap.put("resultList", packingDetailsList);
	    return retMap;
	}
	
	// 팝업 호출
    @RequestMapping(value = "/pop/view.do")
    public String view(Model model) throws Exception {
        LDataMap map = packingDetailsBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/settlement/masterreport/ShipmentBlNoPop";
    }
    
    // SBL 검색
    @RequestMapping(value = "/pop/search.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData search(@RequestBody LReqData reqData) throws Exception {
        LDataMap paramData = reqData.getParamDataMap("paramData");
        List<LDataMap> resultList = packingDetailsBiz.getSblNoSearch(paramData);

        LRespData respData = new LRespData();
        respData.put("resultList", resultList);

        return respData;
    }
}
