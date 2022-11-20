package xrt.alexcloud.c000.c000021;

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
 * 품목 관리
 */
@Controller
@RequestMapping(value = "/alexcloud/c000/c000002")
public class C000021Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private C000021Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> CODE_CPLAIN = commonBiz.getCommonCodeOnlyName("CPLAIN"); //구분

		model.addAttribute("CODE_CPLAIN", CODE_CPLAIN);
		model.addAttribute("GCODE_CPLAIN", Util.getCommonCodeGrid(CODE_CPLAIN));

		String GCODE_ITEMTYPE = commonBiz.getCommonCodeOnlyNameGrid("ITEMTYPE"); //품목유형
		String GCODE_SETYN = commonBiz.getCommonCodeOnlyNameGrid("YN"); //세트여부
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE"); //관리단위

		model.addAttribute("GCODE_ITEMTYPE", GCODE_ITEMTYPE);
		model.addAttribute("GCODE_SETYN", GCODE_SETYN);
		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));

		return "alexcloud/c000/c000002/C000002";
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

	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> paramList = reqData.getParamDataList("paramList");

		LDataMap resultData = biz.setSave(paramList);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

	//삭제 (사용/미사용)
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
