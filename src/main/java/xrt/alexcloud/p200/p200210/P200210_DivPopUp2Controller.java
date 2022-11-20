package xrt.alexcloud.p200.p200210;

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
 * 주문등록 - 주문 적용 팝업 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p200/p200210_Divpopup2")
public class P200210_DivPopUp2Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P200210_DivPopUp2Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		return "alexcloud/p200/p200210/P200210_Divpopup2";
	}

	//검색
	@RequestMapping(value = "/getSearchDivpopup2.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch2(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap paramData = reqData.getParamDataMap("paramData");
		
		List<LDataMap> resultList = biz.getSearch2(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}



}
