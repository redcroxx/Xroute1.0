package xrt.sys.popup;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
/**
 * 사용자 프린터설정 변경 팝업
 */
@Controller
@RequestMapping(value = "/sys/popup/popPrint")
public class PopPrintController {

	@Resource private PopPrintBiz biz;

	//팝업 호출
	@RequestMapping(value = "/view.do")
	public String view() throws Exception {
		return "sys/popup/PopPrint";
	}

	//검색
	@RequestMapping(value = "/search.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData search(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.getSearch(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

	//프린터 정보 처리
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData, HttpServletRequest request) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.setSave(paramData);

		/*if("U".equals(resultData.get("IDU"))){
			if((Integer) resultData.get("SCNT") > 0) {
				LDataMap param = reqData.getParamDataMap("paramData");

				PrintVO printVO = loginBiz.getPrint(param);

				// 성공시에만 세션정보 저장
				if (printVO != null) {
					// 로그인정보를 세션에 저장
					HttpSession session = request.getSession();

					session.setAttribute("printVO", printVO);
				}
			}
		}*/

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
}