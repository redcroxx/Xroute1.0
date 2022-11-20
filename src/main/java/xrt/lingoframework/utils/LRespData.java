package xrt.lingoframework.utils;

import java.io.Serializable;
import java.util.HashMap;

public class LRespData extends HashMap<String, Object> implements Serializable {

	private static final long serialVersionUID = 1L;

	public LRespData() {
		this.put("CODE", "1");
		this.put("MESSAGE", "Success");
	}
	
	public void setURL(String url) {
		this.put("URL", url);
	}
}