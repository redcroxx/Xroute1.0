package xrt.fulfillment.tracking;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class TrackingDtlBiz extends DefaultBiz {

	Logger logger = LoggerFactory.getLogger(TrackingDtlBiz.class);

	List<StockHistoryVo> getSearch(CommonSearchVo paramVo) throws Exception {
		return  dao.selectList("TrackingDtlMapper.getSearch", paramVo);
	}

	public LDataMap process(List<StockHistoryVo> paramList) throws Exception {
		logger.debug("paramList : "+ paramList.toString());

		for (StockHistoryVo stockHistoryVo : paramList) {
			dao.insert("TrackingDtlMapper.insertTStockHistory", stockHistoryVo);
		}

		LDataMap lDataMap = new LDataMap();
		return lDataMap;
	}

	public LDataMap delete(StockHistoryVo paramVo) throws Exception {

		dao.delete("TrackingDtlMapper.deleteTStockHistory", paramVo);

		LDataMap lDataMap = new LDataMap();
		return lDataMap;
	}

}