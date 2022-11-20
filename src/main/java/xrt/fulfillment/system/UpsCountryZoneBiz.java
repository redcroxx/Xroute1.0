package xrt.fulfillment.system;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class UpsCountryZoneBiz extends DefaultBiz{
    
    Logger logger = LoggerFactory.getLogger(UpsCountryZoneBiz.class);

    public LRespData getSearch(CommonSearchVo reqData) throws Exception{
        LRespData resData = new LRespData();
        String sCountryCode = reqData.getsZone().toUpperCase();
        reqData.setsZone(sCountryCode);
        List<UpsCountryZoneVO> upsCountryZoneList = dao.selectList("UpsCountryZoneMapper.getSearch", reqData);
        resData.put("resultList", upsCountryZoneList);
        return resData;
    }

    public LRespData setSave(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 등록 전 기존의 목록은 삭제.
        dao.delete("UpsCountryZoneMapper.deleteCountryZone", dataList);
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            UpsCountryZoneVO upsCountryZoneVO = new UpsCountryZoneVO();
            upsCountryZoneVO.setCountryName(dataList.get(i).getString("COUNTRY_NAME"));
            upsCountryZoneVO.setCountryCode(dataList.get(i).getString("COUNTRY_CODE"));
            upsCountryZoneVO.setZone(dataList.get(i).getString("ZONE"));
            upsCountryZoneVO.setEss(dataList.get(i).getString("ESS").replace(",",""));
            upsCountryZoneVO.setAddusercd(LoginInfo.getUsercd());
            upsCountryZoneVO.setUpdusercd(LoginInfo.getUsercd());
            upsCountryZoneVO.setTerminalcd(ClientInfo.getClntIP());
            dao.insert("UpsCountryZoneMapper.insertCountryZone", upsCountryZoneVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LRespData updateZone(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            UpsCountryZoneVO upsCountryZoneVO = new UpsCountryZoneVO();
            upsCountryZoneVO.setUpsCountryZoneSeq(dataList.get(i).getString("upsCountryZoneSeq"));
            upsCountryZoneVO.setCountryName(dataList.get(i).getString("countryName"));
            upsCountryZoneVO.setCountryCode(dataList.get(i).getString("countryCode"));
            upsCountryZoneVO.setZone(dataList.get(i).getString("zone"));
            upsCountryZoneVO.setEss(dataList.get(i).getString("ess"));
            upsCountryZoneVO.setUpdusercd(LoginInfo.getUsercd());
            upsCountryZoneVO.setTerminalcd(ClientInfo.getClntIP());
            dao.update("UpsCountryZoneMapper.updateCountryZone", upsCountryZoneVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LDataMap setDelete(LDataMap paramData) throws Exception {
        dao.delete("UpsCountryZoneMapper.deleteCountryInfo", paramData);
        return paramData;
    }
}
