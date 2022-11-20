package xrt.alexcloud.c000.c000001;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.Util;
/**
 * 품목분류 관리
 */
@Controller
@RequestMapping(value = "/alexcloud/c000/c000001")
public class C000001Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private C000001Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		/*
		List<CodeVO> codeOtherStatus = commonBiz.getCommonCode("codeOtherStatus"); 
		List<CodeVO> codeOtherType = commonBiz.getCommonCode("codeOtherType");
		List<CodeVO> codeOtherHan = commonBiz.getCommonCode("codeOtherHan");

		model.addAttribute("codeOtherStatus", codeOtherStatus);
		model.addAttribute("codeOtherType", codeOtherType);
		model.addAttribute("codeOtherHan", codeOtherHan);		
		*/
		
		
		List<CodeVO> cplainType = commonBiz.getCommonCode("CPLAIN_TYPE"); //민원구분
		List<CodeVO> cplainStatus = commonBiz.getCommonCode("CPLAIN_STATUS"); //민원구분
		
		model.addAttribute("cplainType", cplainType);
		model.addAttribute("gcplainType", cplainType);
		model.addAttribute("cplainStatus", cplainStatus);
		model.addAttribute("gcplainStatus", cplainStatus);
		model.addAttribute("GCPLAIN_STATUS", Util.getCommonCodeGrid(cplainStatus));
		model.addAttribute("GCPLAIN_GB", Util.getCommonCodeGrid(cplainType));
		
		
		return "alexcloud/c000/c000001/C000001";
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
	
	//상세 검색
	@RequestMapping(value = "/getDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getDetail(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getDetail(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

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

	//정보 수정
	@RequestMapping(value = "/setUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setUpdate(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultList = biz.setUpdate(paramData);
		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	//메모 수정
	@RequestMapping(value = "/setMemoUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setMemoUpdate(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultList = biz.setMemoUpdate(paramData);
		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	//메모 수정
	@RequestMapping(value = "/setMemoNew.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setMemoNew(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultList = biz.setMemoNew(paramData);
		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
}
