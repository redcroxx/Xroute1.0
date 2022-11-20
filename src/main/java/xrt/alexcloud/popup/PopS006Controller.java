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
 * 사용자코드 팝업
 */
@Controller
@RequestMapping(value = "/alexcloud/popup/popS006")
public class PopS006Controller {

	@Resource private PopS006Biz biz;
	@Resource private CommonBiz commonBiz;

	//팝업 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> CODE_DEPTCD = commonBiz.getCommonCode("DEPTCD"); //소속
		List<CodeVO> CODE_USERGROUP = commonBiz.getCommonCode("USERGROUP"); //사용자그룹

		model.addAttribute("CODE_DEPTCD", CODE_DEPTCD);
		model.addAttribute("CODE_USERGROUP", CODE_USERGROUP);
		model.addAttribute("GCODE_DEPTCD", Util.getCommonCodeGrid(CODE_DEPTCD));
		model.addAttribute("GCODE_USERGROUP", Util.getCommonCodeGrid(CODE_USERGROUP));

		return "alexcloud/popup/PopS006";
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
}