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
public class DhlRateBiz extends DefaultBiz{
    
    Logger logger = LoggerFactory.getLogger(DhlRateBiz.class);

    public LRespData getSearch(LReqData reqData) throws Exception {
        LRespData resData = new LRespData();
        DhlRateVO dhlRateVO = new DhlRateVO();
        List<DhlRateVO> dhlRateList = dao.selectList("DhlRateMapper.getSearch", dhlRateVO);
        for (int i = 0; i < dhlRateList.size(); i++) {
            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            int zone1 = Integer.parseInt(dhlRateList.get(i).getZone1());
            int zone2 = Integer.parseInt(dhlRateList.get(i).getZone2());
            int zone3 = Integer.parseInt(dhlRateList.get(i).getZone3());
            int zone4 = Integer.parseInt(dhlRateList.get(i).getZone4());
            int zone5 = Integer.parseInt(dhlRateList.get(i).getZone5());
            int zone6 = Integer.parseInt(dhlRateList.get(i).getZone6());
            int zone7 = Integer.parseInt(dhlRateList.get(i).getZone7());
            int zone8 = Integer.parseInt(dhlRateList.get(i).getZone8());
            int zone41 = Integer.parseInt(dhlRateList.get(i).getZone41());
            dhlRateList.get(i).setZone1(decimalFormat.format(zone1).toString());
            dhlRateList.get(i).setZone2(decimalFormat.format(zone2).toString());
            dhlRateList.get(i).setZone3(decimalFormat.format(zone3).toString());
            dhlRateList.get(i).setZone4(decimalFormat.format(zone4).toString());
            dhlRateList.get(i).setZone5(decimalFormat.format(zone5).toString());
            dhlRateList.get(i).setZone6(decimalFormat.format(zone6).toString());
            dhlRateList.get(i).setZone7(decimalFormat.format(zone7).toString());
            dhlRateList.get(i).setZone8(decimalFormat.format(zone8).toString());
            dhlRateList.get(i).setZone41(decimalFormat.format(zone41).toString());
        }
        resData.put("resultList", dhlRateList);
        return resData;
    }

    public LRespData setSave(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 등록 전 기존의 요율표 목록은 삭제.
        dao.delete("DhlRateMapper.deleteDhlRate", dataList);
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            DhlRateVO dhlRateVO = new DhlRateVO();
            dhlRateVO.setKg(dataList.get(i).getString("KG"));
            dhlRateVO.setZone1(dataList.get(i).getString("ZONE1").replace(",",""));
            dhlRateVO.setZone2(dataList.get(i).getString("ZONE2").replace(",",""));
            dhlRateVO.setZone3(dataList.get(i).getString("ZONE3").replace(",",""));
            dhlRateVO.setZone4(dataList.get(i).getString("ZONE4").replace(",",""));
            dhlRateVO.setZone5(dataList.get(i).getString("ZONE5").replace(",",""));
            dhlRateVO.setZone6(dataList.get(i).getString("ZONE6").replace(",",""));
            dhlRateVO.setZone7(dataList.get(i).getString("ZONE7").replace(",",""));
            dhlRateVO.setZone8(dataList.get(i).getString("ZONE8").replace(",",""));
            dhlRateVO.setZone41(dataList.get(i).getString("ZONE41").replace(",",""));
            dhlRateVO.setAddusercd(LoginInfo.getUsercd());
            dhlRateVO.setUpdusercd(LoginInfo.getUsercd());
            dhlRateVO.setTerminalcd(ClientInfo.getClntIP());
            dao.insert("DhlRateMapper.insertDhlRate", dhlRateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LRespData updateDhlRate(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.

        // 데이터 검증
        for (int i = 0; i < dataList.size(); i++) {
            DhlRateVO dhlRateVO = new DhlRateVO();
            dhlRateVO.setKg(dataList.get(i).getString("kg"));
            dhlRateVO.setZone1(dataList.get(i).getString("zone1").replace(",",""));
            dhlRateVO.setZone2(dataList.get(i).getString("zone2").replace(",",""));
            dhlRateVO.setZone3(dataList.get(i).getString("zone3").replace(",",""));
            dhlRateVO.setZone4(dataList.get(i).getString("zone4").replace(",",""));
            dhlRateVO.setZone5(dataList.get(i).getString("zone5").replace(",",""));
            dhlRateVO.setZone6(dataList.get(i).getString("zone6").replace(",",""));
            dhlRateVO.setZone7(dataList.get(i).getString("zone7").replace(",",""));
            dhlRateVO.setZone8(dataList.get(i).getString("zone8").replace(",",""));
            dhlRateVO.setZone41(dataList.get(i).getString("zone41").replace(",",""));
            dhlRateVO.setUpdusercd(LoginInfo.getUsercd());
            dhlRateVO.setTerminalcd(ClientInfo.getClntIP());
            dao.update("DhlRateMapper.updateDhlRate", dhlRateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }
}
