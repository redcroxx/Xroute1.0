package xrt.fulfillment.order.ups;

import java.util.List;
import org.springframework.stereotype.Service;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.support.service.DefaultBiz;

@Service
public class UpsBiz extends DefaultBiz{

	public List<UpsVO> getSearch(CommonSearchVo paramVo) throws Exception{
	    List<UpsVO> resultList = dao.selectList("UpsMapper.getSearch", paramVo);
		return resultList;
	}

    public List<UpsGoodsVO> goodsSearch(CommonSearchVo paramVO) throws Exception{
        List<UpsGoodsVO> resultList = dao.selectList("UpsMapper.goodsSearch", paramVO);
        return resultList;
    }
}
