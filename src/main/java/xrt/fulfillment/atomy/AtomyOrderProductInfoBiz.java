package xrt.fulfillment.atomy;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.interfaces.vo.TOrderDtlVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LRespData;

@Service
public class AtomyOrderProductInfoBiz extends DefaultBiz {
    
    Logger logger = LoggerFactory.getLogger(AtomyOrderProductInfoBiz.class);
    
    @Value("#{config['c.debugtype']}")
    private String debugtype;

    public LRespData getSearch(CommonSearchVo paramVO) throws Exception {
        
        String atomyOrgcd = CommonConst.ATOMY_DEV_ORGCD;
        if (debugtype.equals("REAL")) {
            atomyOrgcd = CommonConst.ATOMY_REAL_ORGCD;
        }
        
        paramVO.setsOrgCd(atomyOrgcd);
        
        LRespData resData = new LRespData();
        List<TOrderDtlVo> atomyOrderProductList = dao.selectList("AtomyOrderProductMapper.getSearch", paramVO);
        resData.put("resultList", atomyOrderProductList);
        return resData;
    }
}
