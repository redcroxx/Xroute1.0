package xrt.fulfillment.stock.stocklist;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class StockListBiz extends DefaultBiz{
	
	List<StockListVo> getSearch(LDataMap paramData) throws Exception {
		return dao.selectList("StockListMapper.getSearch", paramData);
	}

}
