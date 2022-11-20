package xrt.fulfillment.settlement.masterreport;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class MasterReportBiz extends DefaultBiz {

	// 검색
	List<LDataMap> getSearch(LDataMap paramData) throws Exception {
		return dao.selectList("MasterReportMapper.getSearch", paramData);
	}
}
