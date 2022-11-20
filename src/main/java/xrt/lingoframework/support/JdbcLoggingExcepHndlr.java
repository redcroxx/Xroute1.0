package xrt.lingoframework.support;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.exception.handler.ExceptionHandler;

/**
 * <pre>
 * alex.egovframework.common
 *    |_ JdbcLoggingExcepHndlr.java
 *
 * </pre>
 * @date : 2014. 12. 12. 오후 3:50:53
 * @version :
 * @author : Prio-001
 */
public class JdbcLoggingExcepHndlr implements ExceptionHandler {

	Logger logger = LoggerFactory.getLogger(JdbcLoggingExcepHndlr.class.getName());

	@Override
	public void occur(Exception ex, String packageName) {
		logger.error(ex.getMessage());
	}
}
