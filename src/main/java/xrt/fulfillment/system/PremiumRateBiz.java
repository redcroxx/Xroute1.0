package xrt.fulfillment.system;

import java.text.DecimalFormat;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

/**
 * RateBiz
 * 
 * @since 2020-12-24
 * @author ljh
 *
 */
@Service
public class PremiumRateBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(PremiumRateBiz.class);

    public LDataMap view() throws Exception {
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("CODEKEY", "USE_COUNTRY");
        param.put("STATUS", "Y");
        List<CodeVO> countrylist = dao.selectList("CodeCacheMapper.getCommonCode", param);

        LDataMap retMap = new LDataMap();
        retMap.put("countrylist", countrylist);
        return retMap;
    }

    /**
     * 국가별 rate 테이블 조회
     * 
     * @param reqData
     * @return
     * @throws Exception
     */
    public LRespData getSearch(LReqData reqData) throws Exception {
        LRespData resData = new LRespData();
        PremiumRateVO rateVO = new PremiumRateVO();
        rateVO.setCountry(reqData.getParamDataVal("country").toUpperCase());
        List<PremiumRateVO> rateList = dao.selectList("PremiumRateMapper.getSearch", rateVO);
        for (int i = 0; i < rateList.size(); i++) {
            String premium1s = rateList.get(i).getPremium1();
            String premium2s = rateList.get(i).getPremium2();
            String premium3s = rateList.get(i).getPremium3();
            String premium4s = rateList.get(i).getPremium4();
            String premium5s = rateList.get(i).getPremium5();
            
            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            if (premium1s.equals("") || premium1s == null) {
                rateList.get(i).setPremium1("");
            }else {
                int premium1 = Integer.parseInt(rateList.get(i).getPremium1());
                rateList.get(i).setPremium1(decimalFormat.format(premium1).toString());
            }
            
            if (premium2s.equals("") || premium2s == null) {
                rateList.get(i).setPremium2("");
            }else {
                int premium2 = Integer.parseInt(rateList.get(i).getPremium2());
                rateList.get(i).setPremium2(decimalFormat.format(premium2).toString());
            }
            
            if (premium3s.equals("") || premium3s == null) {
                rateList.get(i).setPremium3("");
            }else {
                int premium3 = Integer.parseInt(rateList.get(i).getPremium3());
                rateList.get(i).setPremium3(decimalFormat.format(premium3).toString());
            }
            
            if (premium4s.equals("") || premium4s == null) {
                rateList.get(i).setPremium4("");
            }else {
                int premium4 = Integer.parseInt(rateList.get(i).getPremium4());
                rateList.get(i).setPremium4(decimalFormat.format(premium4).toString());
            }
            
            if (premium5s.equals("") || premium5s == null) {
                rateList.get(i).setPremium5("");
            }else {
                int premium5 = Integer.parseInt(rateList.get(i).getPremium5());
                rateList.get(i).setPremium5(decimalFormat.format(premium5).toString());
            }
        }
        resData.put("resultList", rateList);
        return resData;
    }

    public LRespData setSave(LReqData reqData) throws Exception {
        logger.info("[RateBiz] reqData : " + reqData.toString());
        LDataMap paramData = reqData.getParamDataMap("paramData"); // 국가
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터

        // 국가 코드 적용.
        String country = paramData.getString("popCountry").toUpperCase(); // 선택 국가, 코드 가져오기
        switch (country) {

            case "JP":
                break;
            case "US":
                break;
            case "SG":
                break;
            case "HK":
                break;
            case "MY":
                break;
            case "TW":
                break;
            default:
                throw new LingoException("지정된 국가가 아닙니다.");
        }
        paramData.put("country", country);
        dao.delete("PremiumRateMapper.deleteRate", paramData);
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            PremiumRateVO rateVO = new PremiumRateVO();
            rateVO.setWgt(dataList.get(i).getString("WGT"));
            rateVO.setPremium1(dataList.get(i).getString("PREMIUM1").replaceAll(",", ""));
            rateVO.setPremium2(dataList.get(i).getString("PREMIUM2").replaceAll(",", ""));
            rateVO.setPremium3(dataList.get(i).getString("PREMIUM3").replaceAll(",", ""));
            rateVO.setPremium4(dataList.get(i).getString("PREMIUM4").replaceAll(",", ""));
            rateVO.setPremium5(dataList.get(i).getString("PREMIUM5").replaceAll(",", ""));
            rateVO.setAddusercd(LoginInfo.getUsercd());
            rateVO.setUpdusercd(LoginInfo.getUsercd());
            rateVO.setTerminalcd(ClientInfo.getClntIP());
            rateVO.setCountry(country);
            switch (country) {
                case "JP":
                    break;
                case "US":
                    break;
                case "SG":
                    break;
                case "HK":
                    break;
                case "MY":
                    break;
                case "TW":
                    break;
                default:
                    throw new LingoException("지정된 국가가 아닙니다.");
            }
            dao.insert("PremiumRateMapper.insertRate", rateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LRespData updateRateList(LReqData reqData) throws Exception {
        logger.info("[RateBiz] reqData : " + reqData.toString());
        LDataMap paramData = reqData.getParamDataMap("paramData"); // 국가.
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터ㅏ
        logger.info("country : " + paramData.getString("country"));
        logger.info("dataList : " + dataList.toString());

        String country = paramData.getString("country").toUpperCase(); // 선택 국가,코드 가져오기

        switch (country) {
            case "JP":
                break;
            case "US":
                break;
            case "SG":
                break;
            case "HK":
                break;
            case "MY":
                break;
            case "TW":
                break;
            default:
                throw new LingoException("지정된 국가가 아닙니다.");
        }

        for (int i = 0; i < dataList.size(); i++) {
            PremiumRateVO rateVO = new PremiumRateVO();
            rateVO.setWgt(dataList.get(i).getString("wgt"));
            rateVO.setPremium1(dataList.get(i).getString("premium1").replaceAll(",", ""));
            rateVO.setPremium2(dataList.get(i).getString("premium2").replaceAll(",", ""));
            rateVO.setPremium3(dataList.get(i).getString("premium3").replaceAll(",", ""));
            rateVO.setPremium4(dataList.get(i).getString("premium4").replaceAll(",", ""));
            rateVO.setPremium5(dataList.get(i).getString("premium5").replaceAll(",", ""));
            rateVO.setUpdusercd(LoginInfo.getUsercd());
            rateVO.setTerminalcd(ClientInfo.getClntIP());
            rateVO.setCountry(country);
            dao.update("PremiumRateMapper.updateRate", rateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }
}