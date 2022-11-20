package xrt.fulfillment.system;

import java.text.DecimalFormat;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class UpsRateBiz extends DefaultBiz{
    
    Logger logger = LoggerFactory.getLogger(UpsRateBiz.class);

    public LRespData getSearch(LReqData reqData) throws Exception {
        LRespData resData = new LRespData();
        UpsRateVO upsRateVO = new UpsRateVO();
        List<UpsRateVO> upsRateList = dao.selectList("UpsRateMapper.getSearch", upsRateVO);
        for (int i = 0; i < upsRateList.size(); i++) {
            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            int zone1 = Integer.parseInt(upsRateList.get(i).getZone1());
            int zone2 = Integer.parseInt(upsRateList.get(i).getZone2());
            int zone3 = Integer.parseInt(upsRateList.get(i).getZone3());
            int zone4 = Integer.parseInt(upsRateList.get(i).getZone4());
            int zone5 = Integer.parseInt(upsRateList.get(i).getZone5());
            int zone6 = Integer.parseInt(upsRateList.get(i).getZone6());
            int zone7 = Integer.parseInt(upsRateList.get(i).getZone7());
            int zone8 = Integer.parseInt(upsRateList.get(i).getZone8());
            int zone9 = Integer.parseInt(upsRateList.get(i).getZone9());
            int zone10 = Integer.parseInt(upsRateList.get(i).getZone10());
            upsRateList.get(i).setZone1(decimalFormat.format(zone1).toString());
            upsRateList.get(i).setZone2(decimalFormat.format(zone2).toString());
            upsRateList.get(i).setZone3(decimalFormat.format(zone3).toString());
            upsRateList.get(i).setZone4(decimalFormat.format(zone4).toString());
            upsRateList.get(i).setZone5(decimalFormat.format(zone5).toString());
            upsRateList.get(i).setZone6(decimalFormat.format(zone6).toString());
            upsRateList.get(i).setZone7(decimalFormat.format(zone7).toString());
            upsRateList.get(i).setZone8(decimalFormat.format(zone8).toString());
            upsRateList.get(i).setZone9(decimalFormat.format(zone9).toString());
            upsRateList.get(i).setZone10(decimalFormat.format(zone10).toString());
        }
        resData.put("resultList", upsRateList);
        return resData;
    }

    public LRespData setSave(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 등록 전 기존의 요율표 목록은 삭제.
        dao.delete("UpsRateMapper.deleteUpsRate", dataList);
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            UpsRateVO upsRateVO = new UpsRateVO();
            upsRateVO.setKg(dataList.get(i).getString("KG"));
            upsRateVO.setZone1(dataList.get(i).getString("ZONE1").replace(",",""));
            upsRateVO.setZone2(dataList.get(i).getString("ZONE2").replace(",",""));
            upsRateVO.setZone3(dataList.get(i).getString("ZONE3").replace(",",""));
            upsRateVO.setZone4(dataList.get(i).getString("ZONE4").replace(",",""));
            upsRateVO.setZone5(dataList.get(i).getString("ZONE5").replace(",",""));
            upsRateVO.setZone6(dataList.get(i).getString("ZONE6").replace(",",""));
            upsRateVO.setZone7(dataList.get(i).getString("ZONE7").replace(",",""));
            upsRateVO.setZone8(dataList.get(i).getString("ZONE8").replace(",",""));
            upsRateVO.setZone9(dataList.get(i).getString("ZONE9").replace(",",""));
            upsRateVO.setZone10(dataList.get(i).getString("ZONE10").replace(",",""));
            upsRateVO.setAddusercd(LoginInfo.getUsercd());
            upsRateVO.setUpdusercd(LoginInfo.getUsercd());
            upsRateVO.setTerminalcd(ClientInfo.getClntIP());
            dao.insert("UpsRateMapper.insertUpsRate", upsRateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LRespData updateUpsRate(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.

        // 데이터 검증
        for (int i = 0; i < dataList.size(); i++) {
            UpsRateVO upsRateVO = new UpsRateVO();
            upsRateVO.setKg(dataList.get(i).getString("kg"));
            upsRateVO.setZone1(dataList.get(i).getString("zone1").replace(",",""));
            upsRateVO.setZone2(dataList.get(i).getString("zone2").replace(",",""));
            upsRateVO.setZone3(dataList.get(i).getString("zone3").replace(",",""));
            upsRateVO.setZone4(dataList.get(i).getString("zone4").replace(",",""));
            upsRateVO.setZone5(dataList.get(i).getString("zone5").replace(",",""));
            upsRateVO.setZone6(dataList.get(i).getString("zone6").replace(",",""));
            upsRateVO.setZone7(dataList.get(i).getString("zone7").replace(",",""));
            upsRateVO.setZone8(dataList.get(i).getString("zone8").replace(",",""));
            upsRateVO.setZone9(dataList.get(i).getString("zone9").replace(",",""));
            upsRateVO.setZone10(dataList.get(i).getString("zone10").replace(",",""));
            upsRateVO.setUpdusercd(LoginInfo.getUsercd());
            upsRateVO.setTerminalcd(ClientInfo.getClntIP());
            dao.update("UpsRateMapper.updateUpsRate", upsRateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }
}
