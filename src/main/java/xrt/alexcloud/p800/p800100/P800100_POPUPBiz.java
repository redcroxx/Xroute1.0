package xrt.alexcloud.p800.p800100;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;


/**
 * 재고이력 조회 팝업
 */
@Service
public class P800100_POPUPBiz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P800100POPUPMapper.getSearch", param);
	}
}
