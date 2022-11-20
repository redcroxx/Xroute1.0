package xrt.alexcloud.p900.p900520;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

/**
 * 입출고이력조회 - 마스터 디테일 그리드 2개 패턴 Biz
 */
@Service
public class P900520Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P900520Mapper.getSearch", param);
	}

}
