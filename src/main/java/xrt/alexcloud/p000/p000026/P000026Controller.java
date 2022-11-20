package xrt.alexcloud.p000.p000026;

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
 * 복합품목관리
 */
@Controller
@RequestMapping(value = "/alexcloud/p000/p000026")
public class P000026Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P000026Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> CODE_YN = commonBiz.getCommonCode("YNNUMBER"); //사용여부
		
		model.addAttribute("CODE_YN", CODE_YN);
		model.addAttribute("GCODE_YN", Util.getCommonCodeGrid(CODE_YN));
		
		return "alexcloud/p000/p000026/P000026";
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch(paramData);
		List<LDataMap> resultExcelList = biz.getExcelSearch(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);
		respData.put("resultData", paramData);
		respData.put("resultExcelList", resultExcelList);

		return respData;
	}
	
	//디테일리스트 검색
	@RequestMapping(value = "/getDetailList.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getDetailList(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getDetailList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	
	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("mGridData");
		List<LDataMap> paramListData = reqData.getParamDataList("dGridData");

		LDataMap resultData = biz.setSave(paramData, paramListData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

	//삭제 (사용/미사용)
	@RequestMapping(value = "/setDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setDelete(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		biz.setDelete(paramData);
		
		LRespData respData = new LRespData();
		
		return respData;
	}
}
