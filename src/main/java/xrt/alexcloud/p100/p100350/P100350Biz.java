package xrt.alexcloud.p100.p100350;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
/**
 * 입고실적수량변경 - RealGrid 마스터 디테일 그리드 2개 패턴 Biz
 */
@Service
public class P100350Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100350Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100350Mapper.getDetailList", param);
	}


	//실행
	public LDataMap setExecute(List<LDataMap> paramList) throws Exception {
		LDataMap param = new LDataMap(paramList.get(0));

		for (int i = 0; i < paramList.size(); i++) {
			LDataMap executeData = new LDataMap(paramList.get(i));
			if(executeData.get("AFTERQTY") == null) {
				executeData.put("AFTERQTY", 0);
			}
			executeData.put("MSGID", "");
			executeData.put("MSG", "");

			executeData.put("LOGIN_USERCD", LoginInfo.getUsercd());
			executeData.put("LOGIN_IP", ClientInfo.getClntIP());

			dao.update("P100350Mapper.setExecute", executeData);

			if(!"1".equals(executeData.getString("MSGID"))){
				throw new LingoException(executeData.getString("MSG"));
			}
		}

		return param;
	}
}
