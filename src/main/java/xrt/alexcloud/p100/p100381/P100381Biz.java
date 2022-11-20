package xrt.alexcloud.p100.p100381;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 입고 인터페이스 현황 Biz
 */
@Service
public class P100381Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		List<LDataMap> resultList = new ArrayList<LDataMap>();

		/*if ("1".equals(param.getString("TABIDX"))) {
			resultList = dao.select("P100381Mapper.getSearch", param);
		} else if ("2".equals(param.getString("TABIDX"))) {
			resultList =  dao.select("P100381Mapper.getSearch2", param);
		}*/
		
		resultList = dao.select("P100381Mapper.getSearch", param);

		return resultList;
	}
}
