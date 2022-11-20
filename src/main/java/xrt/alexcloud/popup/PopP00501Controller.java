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
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.Util;
/**
 * 로케이션 재고 팝업
 */
@Controller
@RequestMapping(value = "/alexcloud/popup/popP00501")
public class PopP00501Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private PopP00501Biz biz;

	//팝업 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> CODE_ISUSING = commonBiz.getCommonCode("ISUSING"); //사용여부
		List<CodeVO> CODE_LOCTYPE = commonBiz.getCommonCode("LOCTYPE"); //로케이션타입
		List<CodeVO> CODE_NOTALLOCFLG = commonBiz.getCommonCode("NOTALLOCFLG"); //할당금지여부
		String GCODE_LOCGROUP = commonBiz.getCommonCodeGrid("LOCGROUP"); //로케이션타입
		String GCODE_SLOTTYPE = commonBiz.getCommonCodeGrid("SLOTTYPE"); //입고유형
		String GCODE_PICKTYPE = commonBiz.getCommonCodeGrid("PICKTYPE"); //피킹유형
		String GCODE_ALLOCATETYPE = commonBiz.getCommonCodeGrid("ALLOCATETYPE"); //할당유형
		String GCODE_YN = commonBiz.getCommonCodeGrid("YN"); //Y,N
		
		model.addAttribute("CODE_ISUSING", CODE_ISUSING);
		model.addAttribute("CODE_LOCTYPE", CODE_LOCTYPE);
		model.addAttribute("CODE_NOTALLOCFLG", CODE_NOTALLOCFLG);
		model.addAttribute("GCODE_NOTALLOCFLG", Util.getCommonCodeGrid(CODE_NOTALLOCFLG));
		model.addAttribute("GCODE_ISUSING", Util.getCommonCodeGrid(CODE_ISUSING));
		model.addAttribute("GCODE_LOCTYPE", Util.getCommonCodeGrid(CODE_LOCTYPE));
		model.addAttribute("GCODE_LOCGROUP", GCODE_LOCGROUP);
		model.addAttribute("GCODE_SLOTTYPE", GCODE_SLOTTYPE);
		model.addAttribute("GCODE_PICKTYPE", GCODE_PICKTYPE);
		model.addAttribute("GCODE_ALLOCATETYPE", GCODE_ALLOCATETYPE);
		model.addAttribute("GCODE_YN", GCODE_YN);

		List<CodeVO> codeLOT4 = commonBiz.getCommonCode("LOT4");
		List<CodeVO> codeLOT5 = commonBiz.getCommonCode("LOT5");
		model.addAttribute("gCodeLOT4", Util.getCommonCodeGridAll(codeLOT4));
		model.addAttribute("gCodeLOT5", Util.getCommonCodeGridAll(codeLOT5));


		return "alexcloud/popup/PopP00501";
	}
	
	//검색
	@RequestMapping(value = "/search.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData search(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	
	//코드 유효성 검사
	@RequestMapping(value = "/check.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData check(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getCheck(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
}