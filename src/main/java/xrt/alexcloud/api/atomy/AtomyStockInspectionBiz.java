package xrt.alexcloud.api.atomy;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import xrt.alexcloud.common.CommonConst;
import xrt.fulfillment.tracking.TrackingHistorytVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class AtomyStockInspectionBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(AtomyStockInspectionBiz.class);

    // TOrder 데이터 조회
    public LDataMap getSearch(LDataMap paramMap) throws Exception {
        LDataMap retMap = (LDataMap) dao.selectOne("atomyStockInspectionMapper.getSearch", paramMap);
        return retMap;
    }

    // TOrderDTL 상품 조회
    public List<LDataMap> getOrderDtl(LDataMap paramData) throws Exception {
        return dao.select("atomyStockInspectionMapper.getOrderDtl", paramData);
    }

    // 검수내역 조회
    public LRespData getInspectionList(LDataMap paramMap) throws Exception {
        LRespData respData = new LRespData();
        respData.put("xrtInvcSno", paramMap.getString("xrtInvcSno"));
        respData.put("ciplXrtInvcSno", paramMap.getString("ciplXrtInvcSno"));
        respData.put("resultList", dao.select("atomyStockInspectionMapper.getInspectionList", paramMap));
        return respData;
    }

    // 검수 완료.
    public void setInspection(LDataMap paramMap) throws Exception {
        if (paramMap == null) {
            throw new LingoException("엑스루트 송장번호가 없습니다.");
        }

        paramMap.put("usercd", LoginInfo.getUsercd());
        paramMap.put("loginIp", ClientInfo.getClntIP());
        paramMap.put("statusCd", CommonConst.ORD_STATUS_CD_INSPECTION_COMP); // 검수완료.

        // 상태 변경.
        dao.update("atomyStockInspectionMapper.updateTorder", paramMap);
        dao.insert("atomyStockInspectionMapper.insertInspectionHistory", paramMap);

        TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
        trackingHistorytVO.setXrtInvcSno(paramMap.getString("xrtInvcSno"));
        trackingHistorytVO.seteNation(paramMap.getString("eNation").toUpperCase().trim());
        trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
        trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
        trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());
        trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_INSPECTION_COMP);
        trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_INSPECTION_COMP);
        trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_INSPECTION_COMP);
        dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
    }

    // 검수 취소
    public void setCancel(LDataMap paramMap) throws Exception {

        if (paramMap == null) {
            throw new LingoException("엑스루트 송장번호가 없습니다.");
        }
        
        LDataMap boxMap = (LDataMap) dao.selectOne("atomyStockInspectionMapper.getBoxData", paramMap);
        
        paramMap.put("wgt", boxMap.getString("weight"));
        paramMap.put("boxWidth", boxMap.getString("width"));
        paramMap.put("boxLength", boxMap.getString("length"));
        paramMap.put("boxHeight", boxMap.getString("height"));
        paramMap.put("statusCd", CommonConst.ORD_STATUS_CD_INSPECTION_CANCEL); // 검수취소
        dao.update("atomyStockInspectionMapper.updateTorder", paramMap);
        
        paramMap.put("usercd", LoginInfo.getUsercd());
        paramMap.put("loginIp", ClientInfo.getClntIP());
        paramMap.put("statusCd", CommonConst.ORD_STATUS_CD_INSPECTION_CANCEL);
        dao.insert("atomyStockInspectionMapper.insertInspectionHistory", paramMap);

        TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
        trackingHistorytVO.setXrtInvcSno(paramMap.getString("xrtInvcSno"));
        trackingHistorytVO.seteNation(paramMap.getString("eNation").toUpperCase().trim());
        trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
        trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
        trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());
        trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_INSPECTION_CANCEL);
        trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_INSPECTION_CANCEL);
        trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_INSPECTION_CANCEL);
        dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
    }

    public LDataMap checkXrtInvcSno(LDataMap paramMap) throws Exception{
        LDataMap resMap = new LDataMap();
        
        String xrtInvcSno = paramMap.getString("xrtInvcSno").toUpperCase();
        String ciplXrtInvcSno = paramMap.getString("ciplXrtInvcSno").toUpperCase();
        
        LDataMap retMap = (LDataMap) dao.selectOne("atomyStockInspectionMapper.getSearch", paramMap);
        
        if (xrtInvcSno.equals(ciplXrtInvcSno)) {
            resMap.put("result", "true");
        }else {
            resMap.put("result", "false");
        }
        
        resMap.put("statusCd", retMap.getString("statusCd"));
        return resMap;
    }
}
