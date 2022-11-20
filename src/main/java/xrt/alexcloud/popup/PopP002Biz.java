package xrt.alexcloud.popup;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 셀러코드 팝업 Biz
 */
@Service
public class PopP002Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("PopP002Mapper.getSearch", param);
	}
	
	//코드 유효성 검사
	public List<LDataMap> getCheck(LDataMap param) throws Exception {
		return dao.select("PopP002Mapper.getCheck", param);
	}
}