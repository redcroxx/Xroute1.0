package xrt.alexcloud.popup;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 부서코드 팝업 Biz
 */
@Service
public class PopP016Biz extends DefaultBiz {
	//트리 검색
	public List<LDataMap> getSearchTree(LDataMap param) throws Exception {
		return dao.select("PopP016Mapper.getSearchTree", param);
	}

	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("PopP016Mapper.getSearch", param);
	}

	//코드 유효성 검사
	public List<LDataMap> getCheck(LDataMap param) throws Exception {
		return dao.select("PopP016Mapper.getCheck", param);
	}
}