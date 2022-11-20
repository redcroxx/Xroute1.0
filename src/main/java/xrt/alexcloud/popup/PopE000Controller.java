package xrt.alexcloud.popup;
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
 * 공통 업로드 팝업
 */
@Controller
@RequestMapping(value = "/alexcloud/popup/popE000")
public class PopE000Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private PopE000Biz biz;

	//팝업 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		return "alexcloud/popup/PopE000";
	}
	
	// 그리드 초기화 정보 가져오기
	@RequestMapping(value = "/init.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData init(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getInit(paramData);
		LDataMap mstData = biz.getMstData(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);
		respData.put("mstData", mstData);

		return respData;
	}
	
	// 데이터 저장 및 유효성 체크
	@RequestMapping(value = "/setCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setCheck(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> paramList = reqData.getParamDataList("paramList");
		
		List<LDataMap> resultList = biz.setCheck(paramData, paramList);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	
	// 데이터 저장 및 유효성 체크
	@RequestMapping(value = "/upload.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData upload(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		
		biz.setUpload(paramData);

		LRespData respData = new LRespData();
		return respData;
	}
}
