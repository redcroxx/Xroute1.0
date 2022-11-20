package xrt.lingoframework.support;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.AbstractMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import xrt.lingoframework.support.service.MessageSource;

/**
 * Comment :
 * 
 * <pre>
 * alexw.utils 
 *    |_ DatabaseMessageResource.java
 * 
 * </pre>
 * 
 * @date : 2015. 1. 16. 오전 11:54:49
 * @version :
 * @author : Prio-001
 */
@Controller
public class DatabaseMessageResourceController extends AbstractMessageSource {

	@Resource(name = "support_I18nService")
	MessageSource messageSource;

	private Logger log = LoggerFactory.getLogger("alex");

	/**
	 * <pre>
	 * 1. 개요 : 
	 * 2. 처리내용 :
	 * </pre>
	 * 
	 * @Method Name : resolveCode
	 * @date : 2015. 1. 16.
	 * @author : Prio-001
	 * @history :
	 *          ----------------------------------------------------------------
	 *          ------- 변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2015. 1. 16. Prio-001 최초
	 *          작성
	 *          --------------------------------------------------------------
	 *          ---------
	 * 
	 * @see org.springframework.context.support.AbstractMessageSource#resolveCode(java.lang.String,
	 *      java.util.Locale)
	 * @param arg0
	 * @param arg1
	 * @return
	 */
	@Override
	protected MessageFormat resolveCode(String code, Locale locale) {
		MessageFormat mf = null;
		Map<String, Object> param = new HashMap<String, Object>();

		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		Cookie[] cookies = attr.getRequest().getCookies();
		
		String message = null;
		String companycd = "";
		String lang = locale.getLanguage();
		
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("COMPANYCD")) {
					companycd = cookie.getValue();
				}
			}
		}
		
		param.put("CODE", code); 
		param.put("LOCALE", lang);
		param.put("COMPANYCD", companycd);

		try {
			message = messageSource.getMessage(param);
		} catch (Exception e) {
			e.printStackTrace();
			log.debug("Exception {} ", e.getMessage());
		}

		if (message == null) {
			mf = new MessageFormat(code + "." + lang);
		} else {
			mf = new MessageFormat(message, locale);
		}
		return mf;
	}
}
