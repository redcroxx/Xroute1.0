package xrt.lingoframework.support.service; 

import java.util.List;
import java.util.Map;

/**
 * Comment : 
 * <pre>
 * alexw.support.service 
 *    |_ I18nService.java
 * 
 * </pre>
 * @date : 2015. 1. 16. 오후 12:40:48
 * @version : 
 * @author : Prio-001
 */
public interface I18nService {
	public List<?> findCode(Map<String, Object> param) throws Exception;
}
