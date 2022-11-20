package xrt.sys.popup;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 공통코드 팝업 Biz
 */
@Service
public class PopS00101001Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("PopS00101001CacheMapper.getSearch", param);
	}
}