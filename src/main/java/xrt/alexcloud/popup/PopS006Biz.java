package xrt.alexcloud.popup;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 사용자코드 팝업 Biz
 */
@Service
public class PopS006Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("PopS006Mapper.getSearch", param);
	}

}