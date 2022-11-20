package xrt.fulfillment.atomy;

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
public class AtomyCountryZoneBiz extends DefaultBiz {
    
    Logger logger = LoggerFactory.getLogger(AtomyCountryZoneBiz.class);

    public LRespData getSearch(CommonSearchVo reqData) throws Exception{
        LRespData resData = new LRespData();
        List<AtomyCountryZoneVO> atomyZoneList = dao.selectList("AtomyZoneMapper.getSearch", reqData);
        resData.put("resultList", atomyZoneList);
        return resData;
    }

    public LRespData setSave(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 등록 전 기존의 목록은 삭제.
        dao.delete("AtomyZoneMapper.deleteZone", dataList);
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            AtomyCountryZoneVO atomyCountryZoneVO = new AtomyCountryZoneVO();
            atomyCountryZoneVO.setCompcd(LoginInfo.getCompcd());
            atomyCountryZoneVO.setCountryName(dataList.get(i).getString("COUNTRY_NAME"));
            atomyCountryZoneVO.setCountryCode(dataList.get(i).getString("COUNTRY_CODE"));
            atomyCountryZoneVO.setLocalShipper(dataList.get(i).getString("LOCAL_SHIPPER"));
            atomyCountryZoneVO.setAddusercd(LoginInfo.getUsercd());
            atomyCountryZoneVO.setUpdusercd(LoginInfo.getUsercd());
            atomyCountryZoneVO.setTerminalcd(ClientInfo.getClntIP());
            dao.insert("AtomyZoneMapper.insertZone", atomyCountryZoneVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LRespData updateZone(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            AtomyCountryZoneVO atomyCountryZoneVO = new AtomyCountryZoneVO();
            atomyCountryZoneVO.setAtomyCountryZoneSeq(dataList.get(i).getString("atomyCountryZoneSeq"));
            atomyCountryZoneVO.setCountryName(dataList.get(i).getString("countryName"));
            atomyCountryZoneVO.setCountryCode(dataList.get(i).getString("countryCode"));
            atomyCountryZoneVO.setLocalShipper(dataList.get(i).getString("localShipper"));
            atomyCountryZoneVO.setUpdusercd(LoginInfo.getUsercd());
            atomyCountryZoneVO.setTerminalcd(ClientInfo.getClntIP());
            dao.update("AtomyZoneMapper.updateZone", atomyCountryZoneVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }
}
