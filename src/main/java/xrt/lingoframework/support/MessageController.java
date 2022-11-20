package xrt.lingoframework.support;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.support.service.MessageSource;
import xrt.lingoframework.utils.CookieUtils;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
public class MessageController {

	@Resource(name = "support_I18nService")
	private MessageSource messageSource;

	/**
	 * 메시지 가져오기
	 */
	@RequestMapping(value = "/alex/getMsg.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getMsg(@RequestBody LReqData reqData, HttpServletRequest request) throws Exception {

		LoginVO lvo = (LoginVO)request.getSession().getAttribute("loginVO");
		String msgcode = reqData.getParamDataVal("code");
		String args = reqData.getParamDataVal("args");
		String language = CookieUtils.getCookie("Language");
		String companycd = CookieUtils.getCookie("COMPANYCD");

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("COMPANYCD", companycd);
		param.put("LOCALE", language);
		param.put("CODE", msgcode);

		String msg = messageSource.getMessage(param);

		if (args != null) {
			String[] argss = args.split(",");
			for (int i=0; i<argss.length; i++) {
				msg = msg.replaceAll("\\{"+i+"\\}", argss[i].trim());
			}
		}

		LRespData respData = new LRespData();
		respData.put("msg", msg);

		return respData;
	}
}
