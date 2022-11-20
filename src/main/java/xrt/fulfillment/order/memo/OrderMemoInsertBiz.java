package xrt.fulfillment.order.memo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;

@Service
public class OrderMemoInsertBiz extends DefaultBiz {
	
	Logger logger = LoggerFactory.getLogger(OrderMemoInsertBiz.class);

	public void insertMemo(OrderMemoMasterVo memoMasterVo) throws Exception{
		dao.insert("OrderMemoMapper.insertMemo", memoMasterVo);
	}

	public void updateMemo(OrderMemoMasterVo memoMasterVo) throws Exception{
		dao.update("OrderMemoMapper.updateMemo", memoMasterVo);
	}

	public void deleteMemo(OrderMemoMasterVo orderMemoMasterVo) throws Exception{
		dao.delete("OrderMemoMapper.deleteMemo", orderMemoMasterVo);
	}
}
