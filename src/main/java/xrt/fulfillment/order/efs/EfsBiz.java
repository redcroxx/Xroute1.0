package xrt.fulfillment.order.efs;

import java.util.List;
import org.springframework.stereotype.Service;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.support.service.DefaultBiz;

@Service
public class EfsBiz extends DefaultBiz{

	public List<EfsVO> getSearch(CommonSearchVo paramVo) throws Exception{
	    List<EfsVO> resultList = dao.selectList("EfsMapper.getSearch", paramVo);
		return resultList;
	}
}
