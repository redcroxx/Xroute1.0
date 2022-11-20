package xrt.alexcloud.p100.p100382;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 발주대비입고현황 Biz
 */
@Service
public class P100382Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100382Mapper.getSearch", param);

	}
}
