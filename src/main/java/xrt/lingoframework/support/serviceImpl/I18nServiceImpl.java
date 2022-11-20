package xrt.lingoframework.support.serviceImpl; 

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.lingoframework.support.dao.I18nMapper;
import xrt.lingoframework.support.service.MessageSource;

/**
 * Comment : 
 * <pre>
 * alexw.support.serviceImpl 
 *    |_ I18nServiceImpl.java
 * 
 * </pre>
 * @date : 2015. 1. 16. 오후 1:26:51
 * @version : 
 * @author : Prio-001
 */
@Service("support_I18nService")
public class I18nServiceImpl implements MessageSource {

	@Resource(name="support_I18nMapper")
	I18nMapper mapper;
	
	/**
	 * <pre>
	 * 1. 개요 : 
	 * 2. 처리내용 : 
	 * </pre>
	 * @Method Name : getMessage
	 * @date : 2015. 1. 16.
	 * @author : Prio-001
	 * @history : 
	 *	-----------------------------------------------------------------------
	 *	변경일				작성자						변경내용  
	 *	----------- ------------------- ---------------------------------------
	 *	2015. 1. 16.		Prio-001				최초 작성 
	 *	-----------------------------------------------------------------------
	 * 
	 * @see alexw.support.service.MessageSource#getMessage(java.lang.String, java.lang.String)
	 * @param code
	 * @param locale
	 * @return
	 */ 	
	@Override
	public String getMessage(Map<String, Object> param) {
		Object msg = mapper.getMessage(param);
		
		if(msg == null) {
			msg = "";
			return msg.toString();
		}
		return ((Map<String,Object>)msg).get("MSG").toString();
	}
}
