package xrt.alexcloud.p000.p000004;

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
 * 창고 관리
 */
@Controller
@RequestMapping(value = "/alexcloud/p000/p000004")
public class P000004Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P000004Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> CODE_ISUSING = commonBiz.getCommonCode("ISUSING"); //사용여부
		String GCODE_WHTYPE = commonBiz.getCommonCodeGrid("WHTYPE"); //창고유형
		String GCODE_WHINVTYPE = commonBiz.getCommonCodeGrid("WHINVTYPE"); //창고재고유형
		String XROUTE_ADMIN = CommonConst.XROUTE_ADMIN;
		String CENTER_ADMIN = CommonConst.CENTER_ADMIN;
		String SELLER_ADMIN = CommonConst.SELLER_ADMIN;
		
		//권한
		model.addAttribute("XROUTE_ADMIN", XROUTE_ADMIN);
		model.addAttribute("CENTER_ADMIN", CENTER_ADMIN);
		model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);
		
		model.addAttribute("CODE_ISUSING", CODE_ISUSING);
		model.addAttribute("GCODE_ISUSING", Util.getCommonCodeGrid(CODE_ISUSING));
		model.addAttribute("GCODE_WHTYPE", GCODE_WHTYPE);
		model.addAttribute("GCODE_WHINVTYPE", GCODE_WHINVTYPE);
		
		return "alexcloud/p000/p000004/P000004";
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
}
