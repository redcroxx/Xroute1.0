package xrt.fulfillment.order.memo;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class OrderMemoListDtlBiz extends DefaultBiz {

	Logger logger = LoggerFactory.getLogger(OrderMemoListDtlBiz.class);

	public List<OrderMemoMasterVo> getSearch(LDataMap param) throws Exception {
		return dao.selectList("OrderMemoMapper.getSearch", param);
	}
	
	public List<OrderMemoMasterVo> getSearchShippingMemo(CommonSearchVo param) throws Exception {
		return dao.selectList("OrderMemoMapper.getSearchShippingMemo", param);
	}
	
	public List<OrderMemoMasterVo> getSearchMainMemo(CommonSearchVo param) throws Exception {
        return dao.selectList("OrderMemoMapper.getSearchMainMemo", param);
    }
	
	public List<OrderMemoMasterVo> getMemoList(CommonSearchVo param) throws Exception {
        return dao.selectList("OrderMemoMapper.getMemoList", param);
    }
}