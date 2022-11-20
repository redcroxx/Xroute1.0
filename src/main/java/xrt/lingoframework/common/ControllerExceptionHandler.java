package xrt.lingoframework.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.Util;

@ControllerAdvice
public class ControllerExceptionHandler {

    private Logger log = LoggerFactory.getLogger("lingo");
    
    private final String ERR00001 = "ERR-10000";
    private final String SQL00001 = "SQL-10000";

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public LRespData handleException(Exception ex) {
        String errCode = ERR00001;
        String errMsg = ex.getMessage();

        if (ex.getClass() == LingoException.class) {
            errCode = ((LingoException) ex).getErrCode();
            errMsg = ((LingoException) ex).getErrMsg();
        } else if (errMsg.indexOf("jdbc.SQLServerException", 0) >= 0) {
            errCode = SQL00001;
            errMsg = ex.getCause().getMessage();
        } else if (!Util.isEmpty(errMsg)) {
            int oraIdx = errMsg.indexOf("ORA-");

            if (oraIdx >= 0) {
                if (errMsg.indexOf(":", oraIdx) >= 0)
                    errCode = errMsg.substring(oraIdx, errMsg.indexOf(":", oraIdx));
                if (errMsg.indexOf("\n", errMsg.indexOf(":", oraIdx)) >= 0)
                    errMsg = errMsg.substring(errMsg.indexOf(":", oraIdx) + 1, errMsg.indexOf("\n", errMsg.indexOf(":", oraIdx)));
            }

            if ("ORA-00001".equals(errCode)) {
                errMsg = "중복되는 키값이 존재합니다.";
            }
        }

        log.error(ex.toString());
        LRespData respData = new LRespData();
        respData.put("CODE", errCode);
        respData.put("MESSAGE", errMsg);
        return respData;
    }
}
