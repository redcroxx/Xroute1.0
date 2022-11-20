package xrt.lingoframework.common;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.common.biz.LoginBiz;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.utils.Constants;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
public class LoginController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    private LoginBiz loginBiz;

    @Autowired
    public LoginController(LoginBiz loginBiz) {
        super();
        this.loginBiz = loginBiz;
    }

    // 로그인 화면
    @RequestMapping(value = "/comm/login.do")
    public String login(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("login") LoginVO loginVO) throws Exception {
        String httpUrl = request.getRequestURL().toString();
        if (httpUrl.contains("xroute.co.kr")) {
            response.sendRedirect("http://xroute.logifocus.co.kr");
        }

        return "common/login";
    }
    
    // 로그인 화면
    @RequestMapping(value = "/comm/login1.do")
    public String login1(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("login") LoginVO loginVO) throws Exception {
        String httpUrl = request.getRequestURL().toString();
        if (httpUrl.contains("xroute.co.kr")) {
            response.sendRedirect("http://xroute.logifocus.co.kr");
        }

        return "common/login";
    }

    // 로그인 처리
    @RequestMapping(value = "/comm/getLogin.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getLogin(@RequestBody LReqData reqData, HttpServletRequest request) throws Exception {
        logger.info("reqData {");
        reqData.entrySet().forEach(entry -> {
            logger.info("    " + entry.getKey() + " : " + entry.getValue());
        });
        logger.info("}");
        
        LDataMap param = reqData.getParamDataMap("paramData");
        param.put("ENCKEY", Constants.ENCRYPTION_PW_KEY);

        LoginVO loginVO = loginBiz.getLogin(param);
        LRespData respData = new LRespData();

        if (loginVO != null && loginVO.getUsercd() != null && !loginVO.getUsercd().equals("")) {
            // 사용자 그리드 정보 가져오기
            List<LDataMap> resultGridInfoAll = loginBiz.getGridColInfoAll(loginVO);
            // respData.put("resultLoginFlg", 1);
            respData.put("resultLoginID", loginVO.getUsercd());
            respData.put("resultLoginName", loginVO.getName());
            respData.put("resultLoginFlg", loginVO.getReturnCode());
            respData.put("resultFailCnt", loginVO.getFailCnt());
            respData.put("resultGridInfoAll", resultGridInfoAll);
        } else {
            respData.put("resultLoginFlg", 0);
        }

        // 성공시에만 세션정보 저장
        if (loginVO != null && ("S".equals(loginVO.getReturnCode()))) {
            HttpSession session = request.getSession();
            session.setAttribute("loginVO", loginVO);
        }

        return respData;
    }

    // 로그아웃 처리
    @RequestMapping(value = "/comm/logout.do")
    public String actionLogout(HttpServletRequest request) throws Exception {
        // 로그아웃 처리
        loginBiz.setLogout();
        request.getSession().invalidate();
        return "redirect:/comm/login.do";
    }

    // 세션아웃
    @RequestMapping(value = "/comm/sessionout.do")
    public String sessionOut(HttpServletRequest request) throws Exception {
        request.getSession().invalidate();
        return "redirect:/comm/login.do";
    }
}
