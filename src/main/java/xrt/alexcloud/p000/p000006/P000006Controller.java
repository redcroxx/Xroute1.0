package xrt.alexcloud.p000.p000006;

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
 * 품목 관리
 */
@Controller
@RequestMapping(value = "/alexcloud/p000/p000006")
public class P000006Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P000006Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> CODE_ISUSING = commonBiz.getCommonCodeOnlyName("ISUSING"); //사용여부
		String GCODE_ITEMTYPE = commonBiz.getCommonCodeOnlyNameGrid("ITEMTYPE"); //품목유형
		List<CodeVO> CODE_YN = commonBiz.getCommonCodeOnlyName("YN"); //세트여부, 시리얼관리여부 
		List<CodeVO> CODE_YNNUMBER = commonBiz.getCommonCodeOnlyName("YNNUMBER"); //개별품목여부		 
		List<CodeVO> CODE_STKTMP = commonBiz.getCommonCodeOnlyName("STKTMP"); //보관온도 
		String GCODE_PROD_TYPE_CD = commonBiz.getCommonCodeOnlyNameGrid("PROD_TYPE_CD"); //품목구분(대입/복합/단품)
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE"); //관리단위
		String GCODE_SUPUNIT = commonBiz.getCommonCodeOnlyNameGrid("SUPUNIT"); //보충단위
		
		String CENTER_ADMIN = CommonConst.CENTER_ADMIN;
		String CENTER_USER = CommonConst.CENTER_USER;
		String SELLER_ADMIN = CommonConst.SELLER_ADMIN;
	
		model.addAttribute("CENTER_ADMIN", CENTER_ADMIN);
		model.addAttribute("CENTER_USER", CENTER_USER);
		model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);
		
		model.addAttribute("CODE_ISUSING", CODE_ISUSING);
		model.addAttribute("GCODE_ISUSING", Util.getCommonCodeGrid(CODE_ISUSING));
		model.addAttribute("GCODE_ITEMTYPE", GCODE_ITEMTYPE);
		model.addAttribute("CODE_YN", CODE_YN);
		model.addAttribute("GCODE_YN", Util.getCommonCodeGrid(CODE_YN));
		model.addAttribute("CODE_YNNUMBER", CODE_YNNUMBER);
		model.addAttribute("GCODE_YNNUMBER", Util.getCommonCodeGrid(CODE_YNNUMBER));
		model.addAttribute("CODE_STKTMP", CODE_STKTMP);
		model.addAttribute("GCODE_STKTMP", Util.getCommonCodeGrid(CODE_STKTMP));
		model.addAttribute("GCODE_PROD_TYPE_CD", GCODE_PROD_TYPE_CD);
		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));
		model.addAttribute("GCODE_SUPUNIT", GCODE_SUPUNIT);

		return "alexcloud/p000/p000006/P000006";
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
	
	//품목바코드 검색
	@RequestMapping(value = "/getSearchDtl.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearchDtl(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultBarcodeList = biz.getSearchBarcode(paramData);
		List<LDataMap> resultCItemList = biz.getSearchCItem(paramData);

		LRespData respData = new LRespData();
		respData.put("resultBarcodeList", resultBarcodeList);
		respData.put("resultCItemList", resultCItemList);

		return respData;
	}

	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> paramList = reqData.getParamDataList("paramList");
		List<LDataMap> barList = reqData.getParamDataList("barList");
		List<LDataMap> cItemList = reqData.getParamDataList("cItemList");

		LDataMap resultData = biz.setSave(paramList, barList, cItemList);

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
