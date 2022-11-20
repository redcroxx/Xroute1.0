package xrt.lingoframework.aops;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.utils.Constants;
import xrt.lingoframework.utils.StringUtils;

public class ServiceIntercept extends HandlerInterceptorAdapter {

    Logger logger = LoggerFactory.getLogger(ServiceIntercept.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        LoginVO userInfo = (LoginVO) request.getSession().getAttribute("loginVO");
        String requestURI = request.getRequestURI(); // 요청 URI

        if (requestURI.indexOf("/comm/login.do") < 0 && requestURI.indexOf("/comm/login1.do") < 0 && requestURI.indexOf("/comm/getLogin.do") < 0 && requestURI.indexOf("/comm/privacyPolicy.do") < 0
                && requestURI.indexOf("/comm/agreement.do") < 0 && requestURI.indexOf("/comm/contJsCsImpt.do") < 0 && requestURI.indexOf("/popup/popPwChange") < 0
                && requestURI.indexOf("/error/error.do") < 0 && requestURI.indexOf("/signup/") < 0 && requestURI.indexOf("/api/") < 0 && requestURI.indexOf("/getSettleBank.do") < 0
                && requestURI.indexOf("/open/getRateInfo.do") < 0 && requestURI.indexOf("/atomy/") < 0 && requestURI.indexOf("/sys/passBook") < 0 && requestURI.indexOf("/sys/tracking/pop") < 0 && requestURI.indexOf("/schedule/") < 0) {
            // 정상적인 세션정보가 없으면 로그인페이지로 이동
            if (userInfo == null) {
                if (request.getHeader(Constants.METHOD_ID) != null) {
                    // Ajax일 경우
                    response.sendError(991);
                    response.sendRedirect("/comm/login.do");
                }

                // ModelMap map = new ModelMap("sessionOut", "1");
                // ModelAndView modelAndView = new
                // ModelAndView("forward:/comm/sessionout.do", map);
                ModelAndView modelAndView = new ModelAndView("forward:/comm/login.do");
                throw new ModelAndViewDefiningException(modelAndView);
            }
        }

        response.addHeader("METHOD_ID", StringUtils.NVL(request.getHeader(Constants.METHOD_ID)));
        return super.preHandle(request, response, handler);
    }
}
