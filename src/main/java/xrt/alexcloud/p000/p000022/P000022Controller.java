package xrt.alexcloud.p000.p000022;

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
 * 주문서양식설정 Controller
 */
@Controller
@RequestMapping(value = "/alexcloud/p000/p000022")
public class P000022Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P000022Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeORDER_UPLOAD_CD = commonBiz.getCommonCode("ORDER_UPLOAD_CD"); //주문양식컬럼
		List<CodeVO> codeLFCBOEXCELCOL = commonBiz.getCommonCode("LF_CBOEXCELCOL"); //엑셀양식
		
		List<CodeVO> CHECKTYPE = commonBiz.getCommonCode("CHECKTYPE");
		String GCODE_YN = commonBiz.getCommonCodeGrid("YN"); //Y,N
		
		model.addAttribute("GCODE_CHECKTYPE", Util.getCommonCodeGridAll(CHECKTYPE));
		model.addAttribute("GCODE_YN", GCODE_YN);
		model.addAttribute("codeORDER_UPLOAD_CD", codeORDER_UPLOAD_CD);
		model.addAttribute("codeLFCBOEXCELCOL", codeLFCBOEXCELCOL);

		model.addAttribute("gCodeORDER_UPLOAD_CD", Util.getCommonCodeGrid(codeORDER_UPLOAD_CD));
		model.addAttribute("gCodeLFCBOEXCELCOL", Util.getCommonCodeGridAll(codeLFCBOEXCELCOL));

		return "alexcloud/p000/p000022/P000022";
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.getSearch1(paramData);
		List<LDataMap> resultList = biz.getSearch2(paramData);
		List<LDataMap> resultList2 = biz.getSearch3(paramData);
		List<LDataMap> resultList3 = biz.getSearch4(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		respData.put("resultList", resultList);
		respData.put("resultList2", resultList2);
		respData.put("resultList3", resultList3);
		
		return respData;
	}
	
	//양식명 SEELCTBOX
	@RequestMapping(value = "/getSiteCd.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSiteCd(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> resultList = biz.getSiteCd(paramData);
		
		LRespData respData = new LRespData();
		respData.put("resultList", resultList);
		
		return respData;
	}

	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> paramList1 = reqData.getParamDataList("paramList1");
		List<LDataMap> paramList2 = reqData.getParamDataList("paramList2");
		List<LDataMap> paramList3 = reqData.getParamDataList("paramList3");

		LDataMap resultData = biz.setSave(paramData, paramList1, paramList2, paramList3);

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
