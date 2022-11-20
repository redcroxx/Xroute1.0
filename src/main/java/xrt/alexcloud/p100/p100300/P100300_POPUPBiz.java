package xrt.alexcloud.p100.p100300;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 입고등록 - 발주 적용 팝업 Biz
 */
@Service
public class P100300_POPUPBiz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100300POPUPMapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100300POPUPMapper.getDetailList", param);
	}

	//품목별 리스트 가져오기
	public List<LDataMap> getDetailList2(LDataMap param) throws Exception {
		return dao.select("P100300POPUPMapper.getDetailList2", param);
	}
}
