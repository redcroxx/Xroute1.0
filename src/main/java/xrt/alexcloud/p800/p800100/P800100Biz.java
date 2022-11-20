package xrt.alexcloud.p800.p800100;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;


/**
 * 재고조회
 */
@Service
public class P800100Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch1(LDataMap param) throws Exception {
		return dao.select("P800100Mapper.getSearch1", param);
	}
	//검색
	public List<LDataMap> getSearch2(LDataMap param) throws Exception {
		return dao.select("P800100Mapper.getSearch2", param);
	}
	//검색
	public List<LDataMap> getSearch3(LDataMap param) throws Exception {
		return dao.select("P800100Mapper.getSearch3", param);
	}
}
