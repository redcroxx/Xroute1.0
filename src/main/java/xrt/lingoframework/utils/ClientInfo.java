package xrt.lingoframework.utils;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class ClientInfo {
	/**
	 * 클라이언트(Client)의 IP주소를 조회하는 기능
	 * @param HttpServletRequest request Request객체
	 * @return String clientIp IP주소
	 * @exception Exception
	*/
	public static String getClntIP() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String clientIp = request.getHeader("WL-Proxy-Client-IP");
		if (clientIp == null || clientIp.length() == 0) {
			request.getHeader("Proxy-Client-IP");
		}
		if (clientIp == null || clientIp.length() == 0) {
			request.getHeader("X-Forwarded-For");
		}
		if (clientIp == null || clientIp.length() == 0) {
			clientIp = request.getRemoteAddr();
		}
		
		return clientIp;
	}
	/**
	 * 클라이언트(Client)의 로컬 IP주소를 조회하는 기능
	 * @param HttpServletRequest request Request객체
	 * @return String clientIp IP주소
	 * @exception Exception
	*/
	public static String getClntLocalIP() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String clientIp = request.getLocalAddr();
		return clientIp;
	}
	
	/**
	 * 클라이언트(Client)의 OS 정보를 조회하는 기능
	 * @param HttpServletRequest request Request객체
	 * @return String osInfo OS 정보
	 * @exception Exception
	*/
	public static String getClntOsInfo() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String userAgent = request.getHeader("user-agent").toUpperCase();
		
		String osInfo = "";
		if (userAgent.indexOf("WINDOWS NT 6.1") > -1) {
			osInfo = "Windows 7";
		}
		else if (userAgent.indexOf("WINDOWS NT 6.2") > -1) {
			osInfo = "Windows 8";
		}
		else if (userAgent.indexOf("WINDOWS NT 6.3") > -1) {
			osInfo = "Windows 8.1";
		}
		else if (userAgent.indexOf("WINDOWS NT 10.0") > -1) {
			osInfo = "Windows 10";
		}
		else if (userAgent.indexOf("WINDOWS NT 6.0") > -1) {
			osInfo = "Windows Vista";
		}
		else if (userAgent.indexOf("WINDOWS NT 5.1") > -1) {
			osInfo = "Windows XP";
		}
		else if (userAgent.indexOf("WINDOWS NT 5.0") > -1) {
			osInfo = "Windows 2000";
		}
		else if (userAgent.indexOf("WINDOWS NT 4.0") > -1) {
			osInfo = "Windows NT";
		}
		else if (userAgent.indexOf("WINDOWS 98") > -1) {
			osInfo = "Windows 98";
		}
		else if (userAgent.indexOf("WINDOWS 95") > -1) {
			osInfo = "Windows 95";
		}
		//window 외
		else if (userAgent.indexOf("IPHONE") > -1) {
			osInfo = "iPhone";
		}
		else if (userAgent.indexOf("IPAD") > -1) {
			osInfo = "iPad";
		}
		else if (userAgent.indexOf("ANDROID") > -1) {
			osInfo = "Android";
		}
		else if (userAgent.indexOf("MAC") > -1) {
			osInfo = "Mac";
		}
		else if (userAgent.indexOf("LINUX") > -1) {
			osInfo = "Linux";
		}
		else {
			osInfo = "OtherOS";
		}
		
		return osInfo;
	}
	
	/**
	 * 클라이언트(Client)의 웹브라우저 종류를 조회하는 기능
	 * @param HttpServletRequest request Request객체
	 * @return String webKind 웹브라우저 종류
	 * @exception Exception
	*/
	public static String getClntWebKind() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String userAgent = request.getHeader("user-agent").toUpperCase();
		
		// 웹브라우저 종류 조회
		String webKind = "";
		if (userAgent.indexOf("RV:11.0") != -1) {
			webKind = "Internet Explorer 11";
		} else if (userAgent.indexOf("MSIE") != -1) {
			if (userAgent.indexOf("OPERA") != -1) {
				webKind = "Opera";
			}
		} else if (userAgent.indexOf("MSIE 8") != -1) {
			webKind = "Internet Explorer 8";
		} else if (userAgent.indexOf("MSIE 9") != -1) {
			webKind = "Internet Explorer 9";
		} else if (userAgent.indexOf("MSIE 10") != -1) {
			webKind = "Internet Explorer 10";
		} else if (userAgent.indexOf("MOBILE") != -1) {
			webKind = "Mobile Web";
		} else if (userAgent.indexOf("SAFARI") != -1) {
			if (userAgent.indexOf("CHROME") != -1) {
				webKind = "Google Chrome";
			} else {
				webKind = "Safari";
			}
		} else if (userAgent.indexOf("FIREFOX") != -1) {
			webKind = "Firefox";
		} else if (userAgent.indexOf("THUNDERBIRD") != -1) {
			webKind = "Thunderbird";
		} else {
			webKind = "Other Web Browser";
		}
		
		return webKind;
	}
}
