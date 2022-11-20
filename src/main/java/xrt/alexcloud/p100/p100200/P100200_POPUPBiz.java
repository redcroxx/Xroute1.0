package xrt.alexcloud.p100.p100200;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 입고등록 - 미입고 애터미 발주내역 팝업 Biz
 */
@Service
public class P100200_POPUPBiz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100200POPUPMapper.getSearch", param);
	}
}
