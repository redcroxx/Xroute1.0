package xrt.fulfillment.payment;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.order.payment.PassBookBiz;
import xrt.fulfillment.order.payment.PassBookMasterVO;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class PassBookListBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(PassBookListBiz.class);

    private PassBookBiz passBookBiz;

    @Autowired
    public PassBookListBiz(PassBookBiz passBookBiz) {
        super();
        this.passBookBiz = passBookBiz;
    }

    public LDataMap view() throws Exception {

        LDataMap paramMap = new LDataMap();
        paramMap.put("COMPCD", LoginInfo.getCompcd());
        paramMap.put("CODEKEY", "PAYMENT_PERIOD");
        paramMap.put("STATUS", "Y");
        LDataMap paramMap1 = new LDataMap();
        paramMap1.put("COMPCD", LoginInfo.getCompcd());
        paramMap1.put("CODEKEY", "COUNTRYLIST");
        paramMap1.put("STATUS", "Y");
        LDataMap paramMap2 = new LDataMap();
        paramMap2.put("COMPCD", LoginInfo.getCompcd());
        paramMap2.put("CODEKEY", "PAYMENT_KEYWORD_TYPE");
        paramMap2.put("STATUS", "Y");

        List<CodeVO> periodType = dao.selectList("CodeCacheMapper.getCommonCode", paramMap);
        List<CodeVO> countrylist = dao.selectList("CodeCacheMapper.getCommonCode", paramMap1);
        List<CodeVO> paymentKeyword = dao.selectList("CodeCacheMapper.getCommonCode", paramMap2);

        LDataMap constMap = new LDataMap();
        constMap.put("XROUTE_CD", CommonConst.XROUTE_COMPCD);
        constMap.put("XROUTE_ADMIN", CommonConst.XROUTE_ADMIN);
        constMap.put("CENTER_ADMIN", CommonConst.CENTER_ADMIN);
        constMap.put("CENTER_SUPER", CommonConst.CENTER_SUPER_USER);
        constMap.put("CENTER_USER", CommonConst.CENTER_USER);
        constMap.put("SELLER_ADMIN", CommonConst.SELLER_ADMIN);
        constMap.put("SELLER_SUPER", CommonConst.SELLER_SUPER_USER);
        constMap.put("SELLER_USER", CommonConst.SELLER_USER);

        LDataMap retMap = new LDataMap();
        retMap.put("constMap", constMap);
        retMap.put("periodType", periodType);
        retMap.put("countrylist", countrylist);
        retMap.put("paymentKeyword", paymentKeyword);

        return retMap;
    }

    public LRespData getSearch(CommonSearchVo paramVO) throws Exception {

        List<PassBookMasterVO> passBookMasterList = dao.selectList("passBookListMapper.getSearch", paramVO);

        LRespData retMap = new LRespData();
        retMap.put("resultList", passBookMasterList);

        return retMap;
    }

    public LRespData getRegularSearch(LDataMap paramMap) throws Exception {

        List<PassBookMasterVO> passBookMasterList = dao.selectList("passBookListMapper.getRegularSearch", paramMap);

        LRespData retMap = new LRespData();
        retMap.put("resultList", passBookMasterList);

        return retMap;
    }

    public LRespData setCancel(List<LDataMap> dataList) throws Exception {

        int userGroup = Integer.parseInt(LoginInfo.getUsergroup());
        int centerAdmin = Integer.parseInt(CommonConst.CENTER_ADMIN);

        if (userGroup < centerAdmin) {
            throw new LingoException("결제취소 권한이 없습니다.");
        }

        for (int i = 0; i < dataList.size(); i++) {
            LDataMap dataMap = dataList.get(i);
            dataMap.put("type", "etc");
            passBookBiz.setPayCancel(dataMap);
        }

        LRespData retMap = new LRespData();
        return retMap;
    }

    /**
     * 데이터 검증
     * 
     * @param paramMap
     * @param dataList
     * @return
     * @throws Exception
     */
    public LDataMap valid(List<LDataMap> dataList) throws LingoException {
        logger.debug("[valid] dataList : " + dataList.size());
        
        List<LDataMap> retList = new ArrayList<LDataMap>();

        for (int i = 0; i < dataList.size(); i++) {
            LDataMap dataMap = dataList.get(i);
            int price = dataMap.getInt("price");

            if (dataMap.getString("xrtInvcSno").equals("")) {
                throw new LingoException("xrtInvcSno가 없습니다.");
            }

            if (dataMap.getString("productNm").equals("")) {
                throw new LingoException("productNm이 없습니다.");
            }

            if (price == 0) {
                throw new LingoException("price가 없습니다.");
            }
            
            dataMap.put("orgcd", (String) dao.selectOneLE("passBookListMapper.getOrgcd", dataMap));
            
            retList.add(dataMap);
        }

        logger.debug("2. 반환값 지정");
        LDataMap retMap = new LDataMap();
        retMap.put("code", "200");
        retMap.put("message", "성공하였습니다.");
        retMap.put("data", retList);
        return retMap;
    }

    public LRespData setUpload(List<LDataMap> dataList, String type) throws LingoException {
        
        String errors = "";

        for (int i = 0; i < dataList.size(); i++) {
            LDataMap dataMap = dataList.get(i);
            dataMap.put("type", type);
            LDataMap checkMap = passBookBiz.checkedRegularPayment(dataMap);
            if (!checkMap.getString("code").equals("1")) {
                errors += checkMap.getString("message") + "\n";
            } else {
                LRespData paymentMap = passBookBiz.setRegularPayment(dataMap);
                passBookBiz.setReturnRegular(paymentMap);
                try {
                    Thread.sleep(100);
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    throw new LingoException(e.getMessage());
                }
            }
        }

        LRespData retMap = new LRespData();
        if (!errors.equals("")) {
            retMap.put("CODE", "500");
            retMap.put("MESSAGE", errors);
        }
        return retMap;
    }

}