package xrt.alexcloud.p000.p000016;

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
 * 부서 관리
 */
@Controller
@RequestMapping(value = "/alexcloud/p000/p000016")
public class P000016Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P000016Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		return "alexcloud/p000/p000016/P000016";
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

	//상세 검색
	@RequestMapping(value = "/getDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getDetail(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.getDetail(paramData);
		List<LDataMap> resultList = biz.getDetailList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		respData.put("resultList", resultList);

		return respData;
	}

	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.setSave(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

	//삭제
	@RequestMapping(value = "/setDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setDelete(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> paramList = reqData.getParamDataList("paramList");

		biz.setDelete(paramList);

		LRespData respData = new LRespData();

		return respData;
	}
}
