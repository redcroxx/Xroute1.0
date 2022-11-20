package xrt.lingoframework.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * Comment : 쿠키관련 Util 클래스
 * 
 * @date : 2015. 2. 4. 오전 9:36:58
 * @author : Prio
 */
public class CookieUtils {
	/**
	 * 쿠키에 저장된 값 가져오기
	 * @param code (쿠키 코드)
	 * @return value (쿠키 값)
	 */
	public static String getCookie(String code) {
		String value = "";
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();

		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(code)) {
					value = cookie.getValue();
			    }
			}
		}
		
		if (code.equals("Language") && Util.isEmpty(value)) {
			value = "kr";
		}
		
		return value;
	}
	
	/**
	 * 쿠키에 저장된 언어코드의 공통코드 맵형태 리턴
	 * @param commCodekey (공통코드 키)
	 * @return map
	 */
	public static LDataMap getLangCodeMap(String commCodekey) {
		String langcd = "kr";
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("Language")) {
					langcd = cookie.getValue();
			    }
			}
		}
		
		LDataMap map = new LDataMap();
		map.put("key", commCodekey);
		map.put("langcd", langcd);
		
		return map;
	}

	/**
	 * 쿠키에 저장된 언어코드의 공통코드 맵형태 리턴
	 * @param  code (공통코드 키)
	 * @return map
	 */
	public static LDataMap getLangCodeMap(String code, String sname1, String sname2, String sname3, String sname4, String sname5) {
		String langcd = "kr";

		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();

		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("Language")) {
					langcd = cookie.getValue();
				}
			}
		}

		LDataMap map = new LDataMap();
		map.put("key", code);
		map.put("langcd", langcd);
		map.put("S_SNAME1", sname1);
		map.put("S_SNAME2", sname2);
		map.put("S_SNAME3", sname3);
		map.put("S_SNAME4", sname4);
		map.put("S_SNAME5", sname5);


		return map;
	}
}
