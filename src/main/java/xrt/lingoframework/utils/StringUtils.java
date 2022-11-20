package xrt.lingoframework.utils;

/**
 * Comment : 문자열 Util 클래스
 *
 * <pre>
 * alexw.utils
 *    |_ StringUtils.java
 *
 * </pre>
 *
 * @date : 2014. 12. 30. 오전 10:43:14
 * @version :
 * @author : Prio-001
 */
public class StringUtils {
	/**
	 * <pre>
	 * 1. 개요 : 문자열 대하여 String 값 반환. Null일 경우 defaultValue 반환
	 * 2. 처리내용 :
	 *     1. Null 여부 판단.
	 *        2-1. Null일 경우 defaultValue 반환
	 *        2-2. Null이 아닐경우 source 반환
	 * </pre>
	 *
	 * @Method Name : NVL
	 * @date : 2014. 12. 30.
	 * @author : Prio-001
	 * @history :
	 *----------------------------------------------------------------
	 *------- 변경일 작성자 변경내용 ----------- -------------------
	 *--------------------------------------- 2014. 12. 30. Prio-001
	 *최초 작성
	 *------------------------------------------------------------
	 *-----------
	 *
	 * @param source
	 * @param defaultValue
	 * @return String
	 */
	public static String NVL(String source, String defaultValue) {
		if ("null".equals(source))
			return defaultValue;
		return source;
	}

	/**
	 * <pre>
	 * 1. 개요 : 문자열 대하여 String 값 반환. Null일 경우 defaultValue 반환
	 * 2. 처리내용 :
	 *     1. Null 여부 판단.
	 *        2-1. Null일 경우 defaultValue 반환
	 *        2-2. Null이 아닐경우 source 반환
	 * </pre>
	 *
	 * @Method Name : NVL
	 * @date : 2014. 12. 30.
	 * @author : Prio-001
	 * @history :
	 *          ----------------------------------------------------------------
	 *          ------- 변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2014. 12. 30. Prio-001
	 *          최초 작성
	 *          ------------------------------------------------------------
	 *          -----------
	 *
	 * @param source
	 * @param defaultValue
	 * @return String
	 */
	public static Object NVL(Object source, String defaultValue) {
		if (source == null)
			return defaultValue;
		return source;
	}

	/**
	 * <pre>
	 * 1. 개요 : 문자열 대하여 String 값 반환. Null일 경우 Constants.EMPTY_STRING 반환
	 * 2. 처리내용 :
	 *     1. Null 여부 판단.
	 *        2-1. Null일 경우 Constants.EMPTY_STRING 반환
	 *        2-2. Null이 아닐경우 source 반환
	 * </pre>
	 *
	 * @Method Name : NVL
	 * @date : 2014. 12. 30.
	 * @author : Prio-001
	 * @history :
	 *          ----------------------------------------------------------------
	 *          ------- 변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2014. 12. 30. Prio-001
	 *          최초 작성
	 *          ------------------------------------------------------------
	 *          -----------
	 *
	 * @param source
	 * @return
	 */
	public static String NVL(Object source) {
		if (null == source)
			return Constants.EMPTY_STRING;
		return source.toString();
	}


	public static String NVL_REPLACE(Object source,String returnValue) {
		if (null == source || source.equals("") || source.equals("NULL"))
			return returnValue;
		return source.toString();
	}


	/**
	 * <pre>
	 * 1. 개요 :
	 * 2. 처리내용 :
	 * </pre>
	 *
	 * @Method Name : isNotEmpty
	 * @date : 2015. 1. 13.
	 * @author : Prio-001
	 * @history :
	 *          ----------------------------------------------------------------
	 *          ------- 변경일 작성자 변경내용 ----------- -------------------
	 *          --------------------------------------- 2015. 1. 13. Prio-001 최초
	 *          작성
	 *          --------------------------------------------------------------
	 *          ---------
	 *
	 * @param string
	 * @return
	 */
	public static boolean isNotEmpty(String source) {
		return (NVL(source) == "" ? false : true);
	}
}
