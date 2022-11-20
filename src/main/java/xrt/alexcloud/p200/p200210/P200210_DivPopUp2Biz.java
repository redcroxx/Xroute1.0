package xrt.alexcloud.p200.p200210;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

/**
 * 주문등록 - 주문 적용 팝업 Biz
 */
@Service
public class P200210_DivPopUp2Biz extends DefaultBiz {
	// 검색
	public List<LDataMap> getSearch2(LDataMap param) throws Exception {
		return dao.select("P200210PopUpMapper.getSearchDivPopUp2", param);
	}
}
