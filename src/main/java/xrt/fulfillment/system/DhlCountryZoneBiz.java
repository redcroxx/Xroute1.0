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
public class DhlCountryZoneBiz extends DefaultBiz{
    
    Logger logger = LoggerFactory.getLogger(DhlCountryZoneBiz.class);

    public LRespData getSearch(CommonSearchVo reqData) throws Exception{
        LRespData resData = new LRespData();
        String sCountryCode = reqData.getsZone().toUpperCase();
        reqData.setsZone(sCountryCode);
        List<DhlCountryZoneVO> dhlCountryZoneList = dao.selectList("DhlCountryZoneMapper.getSearch", reqData);
        resData.put("resultList", dhlCountryZoneList);
        return resData;
    }

    public LRespData setSave(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 등록 전 기존의 목록은 삭제.
        dao.delete("DhlCountryZoneMapper.deleteCountryZone", dataList);
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            DhlCountryZoneVO dhlCountryZoneVO = new DhlCountryZoneVO();
            dhlCountryZoneVO.setCompcd(LoginInfo.getCompcd());
            dhlCountryZoneVO.setCountryName(dataList.get(i).getString("COUNTRY_NAME"));
            dhlCountryZoneVO.setCountryCode(dataList.get(i).getString("COUNTRY_CODE"));
            dhlCountryZoneVO.setZone(dataList.get(i).getString("ZONE"));
            dhlCountryZoneVO.setAddusercd(LoginInfo.getUsercd());
            dhlCountryZoneVO.setUpdusercd(LoginInfo.getUsercd());
            dhlCountryZoneVO.setTerminalcd(ClientInfo.getClntIP());
            dao.insert("DhlCountryZoneMapper.insertCountryZone", dhlCountryZoneVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LRespData updateZone(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            DhlCountryZoneVO dhlCountryZoneVO = new DhlCountryZoneVO();
            dhlCountryZoneVO.setDhlCountryZoneSeq(dataList.get(i).getString("dhlCountryZoneSeq"));
            dhlCountryZoneVO.setCountryName(dataList.get(i).getString("countryName"));
            dhlCountryZoneVO.setCountryCode(dataList.get(i).getString("countryCode"));
            dhlCountryZoneVO.setZone(dataList.get(i).getString("zone"));
            dhlCountryZoneVO.setUpdusercd(LoginInfo.getUsercd());
            dhlCountryZoneVO.setTerminalcd(ClientInfo.getClntIP());
            dao.update("DhlCountryZoneMapper.updateCountryZone", dhlCountryZoneVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LDataMap setDelete(LDataMap paramData) throws Exception {
        dao.delete("DhlCountryZoneMapper.deleteCountryInfo", paramData);
        return paramData;
    }
}
