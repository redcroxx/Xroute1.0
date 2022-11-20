package xrt.alexcloud.api.atomy;

import java.util.List;
import org.springframework.stereotype.Service;
import xrt.fulfillment.stock.stocklist.StockListVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class AtomyStockListBiz extends DefaultBiz{

    public List<StockListVo> getSearch(LDataMap paramData) throws Exception {
        return dao.selectList("AtomyStockListMapper.getSearch", paramData);
    }
}
