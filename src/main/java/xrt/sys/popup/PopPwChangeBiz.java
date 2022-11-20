package xrt.sys.popup;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.Constants;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;
/**
 * 사용자 비밀번호 변경 팝업 Biz
 */
@Service
public class PopPwChangeBiz extends DefaultBiz {
	//검색
	public LDataMap getSearch(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("PopPwChangeMapper.getSearch", param);
	}

	//비밀번호 변경 처리
	public LDataMap setSave(LDataMap param) throws Exception {
		int scnt = 0;

		//필수 값 유효성 검사
		if (Util.isEmpty(param.get("COMPCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드가 없습니다.");
		} else if (Util.isEmpty(param.get("USERCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n사용자코드가 없습니다.");
		} else if (Util.isEmpty(param.get("OLDPASS"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n이전비밀번호는 필수 입력값 입니다.");
		} else if (Util.isEmpty(param.get("NEWPASS"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n신규비밀번호는 필수 입력값 입니다.");
		} else if (Util.isEmpty(param.get("NEWREPASS"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n신규비밀번호확인은 필수 입력값 입니다.");
		} else if (Util.ifEmpty(param.get("NEWPASS"), "").length() < 6 || Util.ifEmpty(param.get("NEWPASS"), "").length() > 20) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n비밀번호는 6~20자 이내로 입력하여 주시기 바랍니다.");
		} else if (!Util.ifEmpty(param.get("NEWPASS"), "NEWPASS").equals(Util.ifEmpty(param.get("NEWREPASS"), "NEWREPASS"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n신규비밀번호와 비밀번호확인이 일치하지 않습니다.");
		}

		//암호화 인증키
		param.put("ENCKEY", Constants.ENCRYPTION_PW_KEY);
		param.put("LOGIN_USERCD", param.get("USERCD"));
		param.put("LOGIN_IP", ClientInfo.getClntIP());

		LDataMap map = (LDataMap) dao.selectOne("PopPwChangeMapper.getPwChangeInfo", param);

		if (map == null || Util.isEmpty(map.get("USERCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n이전 비밀번호가 일치하지 않습니다.");
		}

		//비밀번호 변경 처리
		scnt = dao.update("PopPwChangeMapper.updatePwChange", param);

		param.put("SCNT", scnt);

		return param;
	}
}