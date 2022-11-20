package xrt.alexcloud.p100.p100380;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 발주대비입고현황 팝업 Biz
 */
@Service
public class P100380_POPUPBiz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100380Mapper.getSearch", param);
	}
}
