package xrt.alexcloud.p000.p000011;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class P000011Biz extends DefaultBiz {

	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000011Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P000011Mapper.getDetailList", param);
	}
	//저장
	public LDataMap setSave(List<LDataMap> paramList) throws Exception {

		for(int i = 0; i<paramList.size(); i++) {
			LDataMap detailData = new LDataMap(paramList.get(i));

			detailData.put("LOGIN_USERCD", LoginInfo.getUsercd());
			detailData.put("LOGIN_IP", ClientInfo.getClntIP());
			detailData.put("CUSTCD","*");

			dao.select("P000011Mapper.updatePrice", detailData);
			if(!"1".equals(detailData.getString("MSGID"))){
				throw new LingoException(detailData.getString("MSG"));
			}
		}

		LDataMap resultData = new LDataMap(paramList.get(0));
		return resultData;
	}
}