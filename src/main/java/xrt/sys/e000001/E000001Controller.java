package xrt.sys.e000001;

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

@Controller
@RequestMapping(value = "/sys/e000001")
public class E000001Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private E000001Biz biz;
	
	//화면호출
	@RequestMapping(value="/view.do")
	public String view(ModelMap model) throws Exception {
		
		List<CodeVO> CHECKTYPE = commonBiz.getCommonCode("CHECKTYPE");
		model.addAttribute("GCODE_CHECKTYPE", Util.getCommonCodeGridAll(CHECKTYPE));
		String GCODE_YN = commonBiz.getCommonCodeGrid("YN"); //Y,N
		model.addAttribute("GCODE_YN", GCODE_YN);
		
		return "sys/e000001/E000001";
	}
	//등록정보 검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> resultList = biz.getSearch(paramData);
		
		LRespData respData = new LRespData();
		respData.put("resultList",resultList);
		return respData;
	}
	//상세정보 검색
	@RequestMapping(value = "/getDetailSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getDetailList(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> resultList = biz.getDetailSearch(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap mGridData = reqData.getParamDataMap("mGridData");
		List<LDataMap> dGridDataList = reqData.getParamDataList("dGridDataList");
		LDataMap resultData = biz.setSave(mGridData,dGridDataList);
		
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		
		return respData;
		
	}
}
