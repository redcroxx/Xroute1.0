package xrt.alexcloud.p100.p100300;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 입고등록 - 애터미 입고 팝업 Biz
 */
@Service
public class P100300_POPUP2Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100300POPUP2Mapper.getSearch", param);
	}
}
