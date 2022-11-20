package xrt.fulfillment.signup;

import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.Constants;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.Util;

@Service
public class SignUpBiz extends DefaultBiz {

	Logger logger = LoggerFactory.getLogger(SignUpBiz.class);

	// 아이디 체크
	public LDataMap idCheck(LDataMap paramData) throws Exception {
		LDataMap map = new LDataMap(paramData);
		LDataMap check = (LDataMap) dao.selectOne("SignUpMapper.getIdCheck", map);
		String msg = "";
		String flag = "";

		if (check != null && !Util.isEmpty(check.get("USERCD"))) {
			msg = "<p id='openMsg' style='margin-top:5px;color:red;'>해당 아이디는 이미 사용중 입니다.</p>";
			flag = "N";
		} else if (Pattern.matches("(^[a-zA-Z0-9_]{4,20}$)", map.getString("id")) != true) {
			msg = "<p id='openMsg' style='margin-top:5px;'>아이디는 4~20자의 영문자, 숫자, 특수기호(_)만 사용 가능합니다.</p>";
			flag = "N";
		} else {
			msg = "<p id='openMsg' style='margin-top:5px;color:blue;'>사용할 수 있는 아이디 입니다.</p>";
			flag = "Y";
		}
		map.put("msg", msg);
		map.put("flag", flag);
		return map;
	}

	// 가입신청
	public LDataMap setSave(LDataMap paramList) throws Exception {
		int scnt = 0;
		String msg = "error";
		paramList.put("ENCKEY", Constants.ENCRYPTION_PW_KEY);
		scnt = 1 + dao.insert("SignUpMapper.insertSeller", paramList);
		logger.debug("scnt:"+scnt);

		if (scnt == 2) {
			scnt = 2 + dao.insert("SignUpMapper.insertUser", paramList);
			logger.debug("scnt:"+scnt);
			if (scnt == 3) {
				scnt = 3 + dao.insert("SignUpMapper.insertPrint", paramList);
				logger.debug("scnt:"+scnt);
				if (scnt == 4) {
					scnt = 4 + dao.insert("SignUpMapper.insertClient", paramList);
					logger.debug("scnt:"+scnt);
				} else {
					logger.debug("scnt:"+scnt);
					scnt = 0;
				}
			} else {
				logger.debug("scnt:"+scnt);
				scnt = 0;
			}
		} else {
			logger.debug("scnt:"+scnt);
			scnt = 0;
		}
		LDataMap param = new LDataMap(paramList);
		if (scnt == 5) {
			param.put("flag", scnt);
		} else if(scnt == 0){
			param.put("flag", msg);
		}
		return param;
	}
}
