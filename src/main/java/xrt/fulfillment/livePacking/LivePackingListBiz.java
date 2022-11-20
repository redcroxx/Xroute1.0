package xrt.fulfillment.livePacking;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.sys.popup.LivePackingVo;

@Service
public class LivePackingListBiz extends DefaultBiz {

	Logger logger = LoggerFactory.getLogger(LivePackingListBiz.class);

	List<LivePackingVo> getSearch(CommonSearchVo paramVo) throws Exception {
		return  dao.selectList("LivePackingListMapper.getSearch", paramVo);
	}
}