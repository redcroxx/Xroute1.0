package xrt.lingoframework.support.dao; 

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * Comment : 
 * <pre>
 * alexw.support.dao 
 *    |_ I18nMapper.java
 * 
 * </pre>
 * @date : 2015. 1. 16. 오후 1:28:41
 * @version : 
 * @author : Prio-001
 */
@Repository("support_I18nMapper")
public class I18nMapper  extends EgovAbstractMapper {

	public Object getMessage(Map<?,?> param) {
		return selectByPk("support.findNameByPk", param);
	}
}
