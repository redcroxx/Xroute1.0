package xrt.alexcloud.p000.p000011;

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
@RequestMapping(value = "/alexcloud/p000/p000011")
public class P000011Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P000011Biz biz;

	//화면호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {

		List<CodeVO> CODE_ISUSING = commonBiz.getCommonCode("ISUSING");
		String GCODE_ITEMTYPE = commonBiz.getCommonCodeGrid("ITEMTYPE");
		String GCODE_UNITCD = commonBiz.getCommonCodeOnlyNameGrid("UNITCD");
		String GCODE_SETYN = commonBiz.getCommonCodeOnlyNameGrid("YN");

		model.addAttribute("CODE_ISUSING", CODE_ISUSING);
		model.addAttribute("GCODE_ISUSING", Util.getCommonCodeGrid(CODE_ISUSING));
		model.addAttribute("GCODE_ITEMTYPE", GCODE_ITEMTYPE);
		model.addAttribute("GCODE_UNITCD", GCODE_UNITCD);
		model.addAttribute("GCODE_SETYN", GCODE_SETYN);

		return "alexcloud/p000/p000011/P000011";
	}
	//검색
	@RequestMapping(value = "/getSearch.do",method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	//디테일 리스트 검색
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
		List<LDataMap> paramListData = reqData.getParamDataList("DetailData");

		LDataMap resultData = biz.setSave(paramListData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

}
