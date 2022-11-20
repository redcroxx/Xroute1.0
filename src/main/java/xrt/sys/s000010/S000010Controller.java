package xrt.sys.s000010;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
 * 사용자 관리
 */
@Controller
@RequestMapping(value = "/sys/s000010")
public class S000010Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private S000010Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		List<CodeVO> CODE_ISUSING = commonBiz.getCommonCode("ISUSING"); //사용여부
		List<CodeVO> CODE_DEPTCD = commonBiz.getCommonCode("DEPTCD"); //사용여부
		List<CodeVO> CODE_USERGROUP = commonBiz.getCommonCode("USERGROUP"); //사용자그룹
		String GCODE_SEX = commonBiz.getCommonCodeGrid("SEX"); //성별
		
		model.addAttribute("CODE_ISUSING", CODE_ISUSING);
		model.addAttribute("CODE_DEPTCD", CODE_DEPTCD);
		model.addAttribute("CODE_USERGROUP", CODE_USERGROUP);
		
		model.addAttribute("GCODE_ISUSING", Util.getCommonCodeGrid(CODE_ISUSING));
		model.addAttribute("GCODE_DEPTCD", Util.getCommonCodeGrid(CODE_DEPTCD));
		model.addAttribute("GCODE_USERGROUP", Util.getCommonCodeGrid(CODE_USERGROUP));
		model.addAttribute("GCODE_SEX", GCODE_SEX);
		
		return "sys/s000010/S000010";
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData, HttpServletRequest request) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		// 190903 cmju 권한에 따라 해당 셀러 목록만 보이도록 수정
//		LoginVO userInfo = (LoginVO) request.getSession().getAttribute("loginVO");
//		
//		if(!CommonConst.XROUTE_ADMIN.equals(userInfo.getUsergroup())) {
//			if(CommonConst.CENTER_ADMIN.equals(userInfo.getUsergroup())) {
//				paramData.put("WHCD", userInfo.getWhcd());
//			} else if(CommonConst.CENTER_SUPER.equals(userInfo.getUsergroup())
//						|| CommonConst.CENTER_USER.equals(userInfo.getUsergroup())
//						|| CommonConst.SELLER_SUPER.equals(userInfo.getUsergroup())
//						|| CommonConst.SELLER_USER.equals(userInfo.getUsergroup())) {
//				paramData.put("USERCD", userInfo.getUsercd());
//			} else if(CommonConst.SELLER_ADMIN.equals(userInfo.getUsergroup())) {
//				paramData.put("ORGCD", userInfo.getOrgcd());
//			} else {
//				paramData.put("USERCD", userInfo.getUsercd());
//			}
//			paramData.put("USERGROUP_CD", userInfo.getUsergroup());
//		}
		
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
	
	//비밀번호 초기화
	@RequestMapping(value = "/setPwInit.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setPwInit(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		
		LDataMap resultData = biz.setPwInit(paramData);
		
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		
		return respData;
	}
}
