package xrt.fulfillment.order.qxpress;

import java.util.List;
import org.springframework.stereotype.Service;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.support.service.DefaultBiz;

@Service
public class QxpressBiz extends DefaultBiz{

	public List<QxpressVO> getSearch(CommonSearchVo paramVo) throws Exception{
	    List<QxpressVO> resultList = dao.selectList("QxpressMapper.getSearch", paramVo);
		return resultList;
	}
}
