package xrt.sys.s000012;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 마이메뉴 Biz
 */
@Service
public class S000012Biz extends DefaultBiz {
	//마이메뉴 전체 검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("S000012Mapper.getSearch", param);
	}

	//마이메뉴 검색
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("S000012Mapper.getDetailList", param);
	}

	//마이메뉴 저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap detailData = new LDataMap(paramList.get(i));

			detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			detailData.put("LOGIN_IP", param.get("LOGIN_IP"));

			if ("D".equals(detailData.getString("IDU"))) {
				dao.delete("S000012Mapper.deleteDtl", detailData);
			} else if ("I".equals(detailData.getString("IDU"))) {
				dao.insert("S000012Mapper.insertDtl", detailData);
			} else if ("U".equals(detailData.getString("IDU"))) {
				dao.update("S000012Mapper.updateDtl", detailData);
			}
		}

		return param;
	}
}