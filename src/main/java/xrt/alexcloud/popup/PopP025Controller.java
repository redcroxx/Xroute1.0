package xrt.alexcloud.popup;
import java.util.ArrayList;
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
 * 품목(복합,단품)코드 팝업
 */
@Controller
@RequestMapping(value = "/alexcloud/popup/popP025")
public class PopP025Controller {
	
	@Resource private CommonBiz commonBiz;
	@Resource private PopP025Biz biz;

	//팝업 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> codePROD_TYPE_CD = new ArrayList<CodeVO>();
		
		CodeVO cv = new CodeVO();
		cv.setCodekey("PROD_TYPE_CD");
		cv.setCode("00001");
		cv.setValue("단품");
		codePROD_TYPE_CD.add(0, cv);

		
		CodeVO cv2 = new CodeVO();
		cv2.setCode("00002");
		cv2.setValue("복합");
		codePROD_TYPE_CD.add(1, cv2);

		model.addAttribute("codePROD_TYPE_CD", codePROD_TYPE_CD);
		model.addAttribute("gCodePROD_TYPE_CD", Util.getCommonCodeGrid(codePROD_TYPE_CD)); 
		return "alexcloud/popup/PopP025";
	}
	
	//검색
	@RequestMapping(value = "/search.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData search1(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch1(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}

	//상세검색
	@RequestMapping(value = "/search2.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData search2(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch2(paramData);

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