package xrt.sys.s000006;

import java.util.List;
import xrt.lingoframework.utils.Util;

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
/**
 * 권한 Controller
 */
@Controller
@RequestMapping(value = "/sys/s000006")
public class S000006Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private S000006Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		// 대메뉴
		List<LDataMap> codeMENUL1 = biz.getMenuL1("MENUL1");
		List<CodeVO> codeAUTHSEARCH = commonBiz.getCommonCode("AUTHSEARCH");
		List<CodeVO> CODE_DEPTCD = commonBiz.getCommonCode("DEPTCD"); //소속
		List<CodeVO> CODE_USERGROUP = commonBiz.getCommonCode("USERGROUP"); //사용자그룹
		
		model.addAttribute("CODE_DEPTCD", CODE_DEPTCD);
		model.addAttribute("CODE_USERGROUP", CODE_USERGROUP);
		model.addAttribute("GCODE_DEPTCD", Util.getCommonCodeGrid(CODE_DEPTCD));
		model.addAttribute("GCODE_USERGROUP", Util.getCommonCodeGrid(CODE_USERGROUP));
		model.addAttribute("codeMENUL1", codeMENUL1);
		model.addAttribute("codeAUTHSEARCH", codeAUTHSEARCH);
		
		model.addAttribute("gCodeAUTHSEARCH", Util.getCommonCodeGrid(codeAUTHSEARCH));
				
		return "sys/s000006/S000006";
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultUserList = biz.getSearch(paramData);
		
		LRespData respData = new LRespData();
		respData.put("resultUserList", resultUserList);
		
		return respData;
	}
	
	// 전체 메뉴 리스트 
	@RequestMapping(value = "/getAllMenu.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getAllMenu(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultMenuList = biz.getMenuList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultMenuList", resultMenuList);

		return respData;
	}
	
	// 사용자별 권한 검색
	@RequestMapping(value = "/getAuthList.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getAuthList(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultAuthList = biz.getAuthList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultAuthList", resultAuthList);

		return respData;
	}
		
	// 권한 추가
	@RequestMapping(value = "/setAuth.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setAuth(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap paramData = reqData.getParamDataMap("grid1Data");
		List<LDataMap> paramListData = reqData.getParamDataList("grid2Data");

		LDataMap resultData = biz.setAuth(paramData, paramListData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
		
	}
	
	// 권한 삭제
	@RequestMapping(value = "/delAuth.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData deleteAuth(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap paramData = reqData.getParamDataMap("grid1Data");
		List<LDataMap> paramListData = reqData.getParamDataList("grid3Data");

		LDataMap resultData = biz.deleteAuth(paramData, paramListData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
	
	// 검색 권한 update
	@RequestMapping(value = "/updateAuthSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData updateAuthSearch(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> resultAuthList = reqData.getParamDataList("paramDataList");

		biz.updateAuthSearch(resultAuthList);

		LRespData respData = new LRespData();
		
		return respData;
	}

	// 권한 체크 update
	@RequestMapping(value = "/updateUserXAuthDtAuth.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData updateUserXAuthDtAuth(@RequestBody LReqData reqData) throws Exception {
		List<LDataMap> resultAuthList = reqData.getParamDataList("paramDataList");

		biz.saveUserXAuthDtAuth(resultAuthList);

		LRespData respData = new LRespData();
		
		return respData;
	}
	
	// 권한 복사
	@RequestMapping(value = "/insertCopyAuth.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData insertCopyAuth(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> paramList = reqData.getParamDataList("paramList");
		biz.insertCopyAuth(paramData, paramList);

		LRespData respData = new LRespData();

		return respData;
	}
}
