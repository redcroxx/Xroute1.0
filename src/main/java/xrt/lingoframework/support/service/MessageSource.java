package xrt.lingoframework.support.service; 

import java.util.Map;

/**
 * Comment : 
 * <pre>
 * alexw.support.service 
 *    |_ MessageSource.java
 * 
 * </pre>
 * @date : 2015. 1. 16. 오후 12:40:13
 * @version : 
 * @author : Prio-001
 */
public interface MessageSource {
	public String getMessage(Map<String, Object> param);
}
