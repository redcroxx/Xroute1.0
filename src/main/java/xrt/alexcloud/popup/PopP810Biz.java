package xrt.alexcloud.popup;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 품목재고팝업 - 다중  Biz
 */
@Service
public class PopP810Biz extends DefaultBiz {
	//검색
	public List<LDataMap> search(LDataMap param) throws Exception {
		return dao.select("PopP810Mapper.search", param);
	}

	//코드 유효성 검사
	public List<LDataMap> getCheck(LDataMap param) throws Exception {
		return dao.select("PopP810Mapper.getCheck", param);
	}
}