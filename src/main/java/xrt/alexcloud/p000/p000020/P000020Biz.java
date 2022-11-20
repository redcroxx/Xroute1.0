package xrt.alexcloud.p000.p000020;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 회사별 품목속성
 */
@Service
public class P000020Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000020Mapper.getSearch", param);
	}

	//저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {

		//디테일 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap detailData = new LDataMap(paramList.get(i));
			detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			detailData.put("LOGIN_IP", param.get("LOGIN_IP"));

			if ("U".equals(detailData.getString("IDU"))) {
				dao.update("P000020Mapper.updateMst", detailData);
				param.put("COMPCD", detailData.getString("COMPCD"));
			}
		}

		return param;
	}
}
