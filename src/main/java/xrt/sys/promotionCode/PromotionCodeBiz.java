
package xrt.sys.promotionCode;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class PromotionCodeBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(PromotionCodeBiz.class);

    public LRespData getSearch(LDataMap paramMap) throws Exception {
        List<PromotionCodeVO> dataList = dao.selectList("promotionCodeMapper.getSearch", paramMap);
        LRespData resMap = new LRespData();
        resMap.put("resultList", dataList);
        return resMap;
    }
    
    public PromotionCodeVO popUpdateView(LDataMap paramMap) throws Exception {
        PromotionCodeVO promotionCodeVO = (PromotionCodeVO) dao.selectOne("promotionCodeMapper.getPromotionCodeData", paramMap);
        
        return promotionCodeVO;
    }
    
    public LRespData setSave(PromotionCodeVO paramVO) throws Exception {
        
        if (paramVO.getPromotionCode().equals("")) {
            throw new LingoException("프로모션 코드를 입력하세요");
        }
        
        String pattern1 = "^[a-zA-Z0-9 ]+$";
        logger.info("" + paramVO.getPromotionCode().matches(pattern1));
        if (!paramVO.getPromotionCode().matches(pattern1)) {
            throw new LingoException("프로모션 코드는 영문 및 숫자만 입력가능 합니다.");
        }
        
        paramVO.setAddusercd(LoginInfo.getUsercd());
        paramVO.setUpdusercd(LoginInfo.getUsercd());
        paramVO.setTerminalcd(ClientInfo.getClntIP());
        
        dao.insert("promotionCodeMapper.insertPromotionCode", paramVO);
        
        LRespData retMap = new LRespData();
        return retMap;
    }

    public LRespData setUpdate(PromotionCodeVO paramVO) throws Exception {

        paramVO.setAddusercd(LoginInfo.getUsercd());
        paramVO.setUpdusercd(LoginInfo.getUsercd());
        paramVO.setTerminalcd(ClientInfo.getClntIP());

        dao.insert("promotionCodeMapper.updatePromotionCode", paramVO);

        LRespData retMap = new LRespData();
        return retMap;
    }

    public LRespData deletePromotionCode(List<LDataMap> paramList) throws Exception {
        
        for (int i=0; i<paramList.size(); i++) {
            dao.delete("promotionCodeMapper.deletePromotionCode", paramList.get(i));
        }
        
        LRespData retMap = new LRespData();
        return retMap;
    }

    public LRespData setPromotionCode(LDataMap paramMap) throws Exception {

        if (paramMap.getString("promotionCode").equals("")) {
            throw new LingoException("프로모션 코드를 입력하세요");
        }
        
        String pattern1 = "^[a-zA-Z0-9 ]+$";
        logger.info("" + paramMap.getString("promotionCode").matches(pattern1));
        if (!paramMap.getString("promotionCode").matches(pattern1)) {
            throw new LingoException("프로모션 코드는 영문 및 숫자만 입력가능 합니다.");
        }

        SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyyMMdd");
        Date date = new Date();
        String toDay = yyyyMMdd.format(date);

        paramMap.put("toDay", toDay);
        paramMap.put("usercd", LoginInfo.getUsercd());
        String prevPromotionCode = dao.selectStrOne("promotionCodeMapper.checkPromotionCode", paramMap);
        
        if (paramMap.getString("promotionCode").equals(prevPromotionCode)) {
            throw new LingoException("중복 코드를 입력 할 수 없습니다.");
        }
        
        PromotionCodeVO promotionCodeVO = (PromotionCodeVO) dao.selectOne("promotionCodeMapper.getPromotionCode", paramMap);

        if (promotionCodeVO == null) {
            throw new LingoException("올바르지 않은 프로모션 코드입니다. 프로모션 코드를 확인해주세요.");
        }

        if (promotionCodeVO.getCodeCount().equals("N")) {
            throw new LingoException("사용이 만료된 프로모션 코드입니다.");
        }

        promotionCodeVO.setCodeCount("Y");
        promotionCodeVO.setUpdusercd("SYSTEM");

        dao.update("promotionCodeMapper.updatePromotionCode", promotionCodeVO);
        dao.update("promotionCodeMapper.updateP002", paramMap);
        
        String message = "프로모션 코드가 정상적으로 등록되었습니다.\n";
        message += "프리미엄 할인율 : " +promotionCodeVO.getPremium() + "% \n";
        message += "익스프레스 할인율 : " +promotionCodeVO.getDhl() + "% \n";
        message += "프로모션 적용기간 : " +promotionCodeVO.getDiscountPeriod();

        LRespData retMap = new LRespData();
        retMap.put("MESSAGE", message);
        return retMap;
    }

}
