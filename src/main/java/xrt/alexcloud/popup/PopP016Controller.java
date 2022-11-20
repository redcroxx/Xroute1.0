package xrt.alexcloud.popup;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
/**
 * 부서코드 팝업
 */
@Controller
@RequestMapping(value = "/alexcloud/popup/popP016")
public class PopP016Controller {
	
	@Resource private PopP016Biz biz;

	//팝업 호출
	@RequestMapping(value = "/view.do")
	public String view() throws Exception {
		return "alexcloud/popup/PopP016";
	}
	
	//트리 검색
	@RequestMapping(value = "/searchTree.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData searchTree(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearchTree(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);
		respData.put("resultData", paramData);

		return respData;
	}
	
	//검색
	@RequestMapping(value = "/search.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData search(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}

	//코드 유효성 검사
	@RequestMapping(value = "/check.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData check(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getCheck(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
}