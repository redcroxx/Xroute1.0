package xrt.lingoframework.exceptions;

public class LingoException extends Exception {

	private static final long serialVersionUID = 1L;
	private String errCode;
	private String errMsg;
	private String errType;

	public LingoException(String errMsg) {
		super(errMsg);
		this.errCode = "ERR-10000";
		this.errMsg = errMsg;
	}

	public LingoException(String errCode, String errMsg) {
		super(errMsg);
		this.errCode = "ERR-" + errCode;
		this.errMsg = errMsg;
	}
	
	public LingoException(String errCode, String errMsg, String errType) {
	    super(errMsg);
	    this.errCode = errCode;
	    this.errMsg = errMsg;
	    this.errType = errType;
	}

	public String getErrCode() {
		return errCode;
	}

	public void setErrCode(String errcode) {
		this.errCode = errcode;
	}

	public String getErrMsg() {
		return errMsg;
	}

	public void setErrMsg(String errmsg) {
		this.errMsg = errmsg;
	}

    public String getErrType() {
        return errType;
    }

    public void setErrType(String errType) {
        this.errType = errType;
    }
}