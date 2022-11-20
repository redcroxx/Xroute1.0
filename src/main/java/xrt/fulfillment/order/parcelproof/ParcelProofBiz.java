package xrt.fulfillment.order.parcelproof;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

/**
 * 해외 소포 수령증 Biz
 */

@Service
public class ParcelProofBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(ParcelProofBiz.class);

    // 검색
    public LDataMap getPrint(LDataMap reqData) throws Exception {
        LDataMap count = (LDataMap) dao.selectOne("ParcelProofMapper.getOrderData", reqData);

        logger.debug("count : " + count.getInt("COUNT"));
        ;
        int value = count.getInt("COUNT");
        if (value == 0) {
            throw new LingoException("해당 분기에 출력할 데이터가 존재하지 않습니다.");
        }
        return count;
    }

}