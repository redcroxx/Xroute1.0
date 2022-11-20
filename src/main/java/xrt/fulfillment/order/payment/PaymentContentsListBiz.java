package xrt.fulfillment.order.payment;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class PaymentContentsListBiz extends DefaultBiz {

    // 검색
    public List<LDataMap> getSearch(CommonSearchVo paramVO) throws Exception {
        return dao.selectList("paymentContentsListMapper.getSearch", paramVO);
    }
    // 검색
    public List<LDataMap > getPopSearch(CommonSearchVo paramVO) throws Exception {
        List<LDataMap > retMap = dao.selectList("paymentContentsListMapper.getPaymentDtl", paramVO);
        return retMap;
        
    }
}
