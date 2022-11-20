package xrt.lingoframework.utils;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;

import xrt.lingoframework.common.vo.LoginVO;

public class LReqData extends HashMap<String, Object> implements Serializable {

private static final long serialVersionUID = 1L;

	public LReqData() {
	}

	public String getSID() {
		return (String) super.get("sid");
	}

	/**
	 * 문자열 형태의 파라미터 받기
	 * @param key : 파라미터 키값
	 */
	public String getParamDataVal(String key) {
		String str = null;

		if (super.get(key) != null) {
			str = (String) super.get(key);
		}

		return str;
	}

	/**
	 * Map 형태의 파라미터 받기
	 * @param key : 파라미터 키값
	 */
	@SuppressWarnings("unchecked")
	public LDataMap getParamDataMap(String key) {
		LDataMap ldMap = null;

		if (super.get(key) != null) {
			ldMap = new LDataMap((HashMap<String, Object>) super.get(key));

			if (LoginInfo.get() != null) {
				LoginVO loginVO = LoginInfo.get();
				ldMap.put("LOGIN_USERCD", loginVO.getUsercd());
				ldMap.put("LOGIN_NAME", loginVO.getName());
				ldMap.put("LOGIN_COMPCD", loginVO.getCompcd());
				ldMap.put("LOGIN_ORGCD", loginVO.getOrgcd());
				ldMap.put("LOGIN_CUSTCD", loginVO.getCustcd());
				ldMap.put("LOGIN_DEPTCD", loginVO.getDeptcd());
				ldMap.put("LOGIN_WHCD", loginVO.getWhcd());
				ldMap.put("LOGIN_PAYMENT_TPYE", loginVO.getPaymentType());
				ldMap.put("LOGIN_IP", ClientInfo.getClntIP());
			}

			if (super.get("ROWS_PER_PAGE") != null) {
				ldMap.put("ROWS_PER_PAGE", super.get("ROWS_PER_PAGE"));
			}
			if (super.get("CURRENT_PAGE") != null) {
				ldMap.put("CURRENT_PAGE", super.get("CURRENT_PAGE"));
			}
		}

		return ldMap;
	}

	/**
	 * List 형태의 파라미터 받기
	 * @param key : 파라미터 키값
	 */
	@SuppressWarnings("unchecked")
	public List<LDataMap> getParamDataList(String key) {
		LDataList ldList = null;

		if (super.get(key) != null) {
			ldList = new LDataList((List<LDataMap>) super.get(key));
		}

		return ldList;
	}
}