package xrt.fulfillment.order.modify;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.order.shippinglist.ShippingListVO;
import xrt.lingoframework.support.service.DefaultBiz;

@Service
public class OrderModifyBiz extends DefaultBiz {

	List<ShippingListVO> getSearch(CommonSearchVo paramVo) throws Exception {
		return  dao.selectList("OrderModifyMapper.getSearch", paramVo);
	}
}