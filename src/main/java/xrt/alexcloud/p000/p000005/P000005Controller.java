package xrt.alexcloud.p000.p000005;

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
 * 로케이션 관리
 */
@Controller
@RequestMapping(value = "/alexcloud/p000/p000005")
public class P000005Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P000005Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> CODE_ISUSING = commonBiz.getCommonCode("ISUSING"); //사용여부
		List<CodeVO> CODE_LOCTYPE = commonBiz.getCommonCode("LOCTYPE"); //로케이션타입
		List<CodeVO> CODE_LOCGROUP = commonBiz.getCommonCode("LOCGROUP"); //로케이션 유형(그룹)
		List<CodeVO> CODE_NOTALLOCFLG = commonBiz.getCommonCode("NOTALLOCFLG"); //할당금지여부
		String GCODE_WHTYPE = commonBiz.getCommonCodeGrid("WHTYPE"); //창고유형
		String GCODE_LOCGROUP = commonBiz.getCommonCodeGrid("LOCGROUP"); //로케이션타입
		String GCODE_SLOTTYPE = commonBiz.getCommonCodeGrid("SLOTTYPE"); //입고유형
		String GCODE_PICKTYPE = commonBiz.getCommonCodeGrid("PICKTYPE"); //피킹유형
		String GCODE_ALLOCATETYPE = commonBiz.getCommonCodeGrid("ALLOCATETYPE"); //할당유형
		String GCODE_YN = commonBiz.getCommonCodeGrid("YN"); //Y,N
		String CENTER_ADMIN = CommonConst.CENTER_ADMIN;
		String CENTER_SUPER = CommonConst.CENTER_SUPER_USER;
		String CENTER_USER = CommonConst.CENTER_USER;
		String SELLER_ADMIN = CommonConst.SELLER_ADMIN;

		model.addAttribute("CENTER_ADMIN", CENTER_ADMIN);
		model.addAttribute("CENTER_SUPER", CENTER_SUPER);
		model.addAttribute("CENTER_USER", CENTER_USER);
		model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);
		
		model.addAttribute("CODE_ISUSING", CODE_ISUSING);
		model.addAttribute("CODE_LOCTYPE", CODE_LOCTYPE);
		model.addAttribute("CODE_LOCGROUP", CODE_LOCGROUP);
		model.addAttribute("CODE_NOTALLOCFLG", CODE_NOTALLOCFLG);
		model.addAttribute("GCODE_NOTALLOCFLG", Util.getCommonCodeGrid(CODE_NOTALLOCFLG));
		model.addAttribute("GCODE_ISUSING", Util.getCommonCodeGrid(CODE_ISUSING));
		model.addAttribute("GCODE_LOCTYPE", Util.getCommonCodeGrid(CODE_LOCTYPE));
		model.addAttribute("GCODE_WHTYPE", GCODE_WHTYPE);
		model.addAttribute("GCODE_LOCGROUP", GCODE_LOCGROUP);
		model.addAttribute("GCODE_SLOTTYPE", GCODE_SLOTTYPE);
		model.addAttribute("GCODE_PICKTYPE", GCODE_PICKTYPE);
		model.addAttribute("GCODE_ALLOCATETYPE", GCODE_ALLOCATETYPE);
		model.addAttribute("GCODE_YN", GCODE_YN);

		return "alexcloud/p000/p000005/P000005";
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

	//디테일 검색
	@RequestMapping(value = "/getDetailList.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getDetailList(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		paramData.put("COMPCD", reqData.getParamDataVal("COMPCD"));
		paramData.put("WHCD", reqData.getParamDataVal("WHCD"));
		
		List<LDataMap> resultList = biz.getDetailList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);
		//respData.put("resultData", paramData);

		return respData;
	}

	//존행열단 검색
	@RequestMapping(value = "/getLocZoneInfo.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getLocZoneInfo(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		paramData.put("CODEKEY", "LOCGROUP");
		List<LDataMap> resultZoneList = biz.getCodeList(paramData);
		paramData.put("CODEKEY", "LOCLINE");
		List<LDataMap> resultLineList = biz.getCodeList(paramData);
		paramData.put("CODEKEY", "LOCRANGE");
		List<LDataMap> resultRangeList = biz.getCodeList(paramData);
		paramData.put("CODEKEY", "LOCSTEP");
		List<LDataMap> resultStepList = biz.getCodeList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultZoneList", resultZoneList);
		respData.put("resultLineList", resultLineList);
		respData.put("resultRangeList", resultRangeList);
		respData.put("resultStepList", resultStepList);

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

	//로케이션 일괄 생성
	@RequestMapping(value = "/setLocCreate.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setLocCreate(@RequestBody LReqData reqData) throws Exception {
		LDataMap mData = reqData.getParamDataMap("mData");
		LDataMap zoneData = reqData.getParamDataMap("zoneData");
		List<LDataMap> lineList = reqData.getParamDataList("lineList");
		List<LDataMap> rangeList = reqData.getParamDataList("rangeList");
		List<LDataMap> stepList = reqData.getParamDataList("stepList");

		LDataMap resultData = biz.setLocCreate(mData, zoneData, lineList, rangeList, stepList);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

	//라벨 팝업 호출
	@RequestMapping(value = "/viewPopup.do")
	public String viewPopup(ModelMap model) throws Exception {
		return "alexcloud/p000/p000005/P000005_popup";
	}
}
