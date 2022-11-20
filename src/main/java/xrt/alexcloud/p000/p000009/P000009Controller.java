package xrt.alexcloud.p000.p000009;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.Util;
/**
 * 품목별로케이션 관리
 */
@Controller
@RequestMapping(value = "/alexcloud/p000/p000009")
public class P000009Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P000009Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> CODE_P009TYPE = commonBiz.getCommonCodeOnlyName("P009TYPE"); //미/등록내역
		List<CodeVO> CODE_P009LOCTYPE = commonBiz.getCommonCodeOnlyName("P009LOCTYPE"); //보관피킹로케이션
		String GCODE_ITEMTYPE = commonBiz.getCommonCodeGrid("ITEMTYPE"); //품목유형
		String GCODE_SETYN = commonBiz.getCommonCodeGrid("YN"); //세트여부
		String CENTER_ADMIN = CommonConst.CENTER_ADMIN;
		String CENTER_SUPER = CommonConst.CENTER_SUPER_USER;
		String SELLER_ADMIN = CommonConst.SELLER_ADMIN;


		//권한
		model.addAttribute("CENTER_ADMIN", CENTER_ADMIN);
		model.addAttribute("CENTER_SUPER", CENTER_SUPER);
		model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);

		model.addAttribute("CODE_P009TYPE", CODE_P009TYPE);
		model.addAttribute("CODE_P009LOCTYPE", CODE_P009LOCTYPE);
		model.addAttribute("GCODE_P009TYPE", Util.getCommonCodeGrid(CODE_P009TYPE));
		model.addAttribute("GCODE_ITEMTYPE", GCODE_ITEMTYPE);
		model.addAttribute("GCODE_SETYN", GCODE_SETYN);
		
		return "alexcloud/p000/p000009/P000009";
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

	//삭제
	@RequestMapping(value = "/setDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setDelete(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> paramList = reqData.getParamDataList("paramList");
		
		LDataMap resultData = biz.setDelete(paramList);
		
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		
		return respData;
	}
}
