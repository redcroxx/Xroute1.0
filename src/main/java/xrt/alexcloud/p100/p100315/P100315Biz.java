package xrt.alexcloud.p100.p100315;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class P100315Biz extends DefaultBiz {
	
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100315Mapper.getSearch", param);
	}
	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100315Mapper.getDetailList", param);
	}
}
