package xrt.fulfillment.tracking;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.interfaces.vo.TOrderVo;
import xrt.lingoframework.support.service.DefaultBiz;

@Service
public class TrackingListBiz extends DefaultBiz {

	List<TOrderVo> getSearch(CommonSearchVo paramVo) throws Exception {
		return  dao.selectList("TrackingListMapper.getSearch", paramVo);
	}

}
