package xrt.alexcloud.popup;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 로케이션 재고 팝업 Biz
 */
@Service
public class PopP00501Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		List<LDataMap> resultList = new ArrayList<LDataMap>();
		if("STD".equals(param.getString("S_WHTYPE"))){
			resultList = dao.select("PopP00501Mapper.getSearch", param);
		} else {
			resultList = dao.select("PopP00501Mapper.getSearch2", param);
		}
		return resultList;
	}
	
	//코드 유효성 검사
	public List<LDataMap> getCheck(LDataMap param) throws Exception {
		List<LDataMap> resultList = new ArrayList<LDataMap>();
		if("STD".equals(param.getString("S_WHTYPE"))){
			resultList = dao.select("PopP00501Mapper.getCheck", param);
		} else {
			resultList = dao.select("PopP00501Mapper.getCheck2", param);
		}
		return resultList;
	}
}