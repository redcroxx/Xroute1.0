package xrt.alexcloud.p800.p800100;

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
 * 재고조회
 */
@Controller
@RequestMapping(value = "/alexcloud/p800/p800100")
public class P800100Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P800100Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codeLOCGROUP = commonBiz.getCommonCode("LOCGROUP");
		List<CodeVO> codeUNITTYPE = commonBiz.getCommonCode("UNITTYPE");
		List<CodeVO> codeWHINVTYPE = commonBiz.getCommonCode("WHINVTYPE");
		String SELLER_ADMIN = CommonConst.SELLER_ADMIN;

		model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);
		model.addAttribute("codeLOCGROUP", codeLOCGROUP);
		model.addAttribute("codeWHINVTYPE", codeWHINVTYPE);

		model.addAttribute("gCodeLOCGROUP", Util.getCommonCodeGrid(codeLOCGROUP));
		model.addAttribute("gCodeUNITTYPE", Util.getCommonCodeGrid(codeUNITTYPE));

		return "alexcloud/p800/p800100/P800100";
	}

	//검색
	@RequestMapping(value = "/getSearch1.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch1(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch1(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	
	//검색
	@RequestMapping(value = "/getSearch2.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch2(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch2(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	
	//검색
	@RequestMapping(value = "/getSearch3.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch3(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch3(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
}
