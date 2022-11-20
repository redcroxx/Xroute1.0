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
public class AtomyStockInsertBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(AtomyStockInsertBiz.class);

    // TOrder 데이터 조회
    public LDataMap getSearch(LDataMap paramMap) throws Exception {
        LDataMap retMap = (LDataMap) dao.selectOne("atomyStockInsertMapper.getSearch", paramMap);
        return retMap;
    }

    // TOrderDTL 상품 조회
    public List<LDataMap> getOrderDtl(LDataMap paramData) throws Exception {
        return dao.select("atomyStockInsertMapper.getOrderDtl", paramData);
    }

    // STOCK_HISTORY 조회
    public LRespData getStockList(LDataMap paramMap) throws Exception {
        LRespData respData = new LRespData();
        respData.put("resultList", dao.select("atomyStockInsertMapper.getStockList", paramMap));
        return respData;
    }

    // 저장.
    public void setSave(LDataMap paramMap) throws Exception {
        if (paramMap == null) {
            throw new LingoException("엑스루트 송장번호가 없습니다.");
        }

        paramMap.put("usercd", LoginInfo.getUsercd());
        paramMap.put("loginIp", ClientInfo.getClntIP());
        paramMap.put("statusCd", CommonConst.ORD_STATUS_CD_SENDING_COMP); // 발송완료.
        paramMap.put("confirmYn", "Y");

        // 상태 변경.
        dao.update("atomyStockInsertMapper.updateTorder", paramMap);

        TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
        trackingHistorytVO.setXrtInvcSno(paramMap.getString("xrtInvcSno"));
        trackingHistorytVO.seteNation("KR");
        trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
        trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
        trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());
        trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_SENDING_COMP); // 발송완료.
        trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_SENDING_COMP); // 발송완료.
        trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_SENDING_COMP); // 발송완료.
        dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
    }

    // 입고 완료.
    public void setStockComp(LDataMap paramMap) throws Exception {
        if (paramMap == null) {
            throw new LingoException("엑스루트 송장번호가 없습니다.");
        }

        paramMap.put("usercd", LoginInfo.getUsercd());
        paramMap.put("loginIp", ClientInfo.getClntIP());
        paramMap.put("statusCd", CommonConst.ORD_STATUS_CD_STOCK_COMP);
        paramMap.put("eventCd", CommonConst.EVENT_STOCK_SAVE);

        // 상태 변경.
        dao.update("atomyStockInsertMapper.updateTorder", paramMap);
        dao.insert("atomyStockInsertMapper.insertStockHistory", paramMap);

        TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
        trackingHistorytVO.setXrtInvcSno(paramMap.getString("xrtInvcSno"));
        trackingHistorytVO.seteNation("KR");
        trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
        trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
        trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());
        trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_STOCK_COMP);
        trackingHistorytVO.setStatusNm("김포센터입고완료");
        trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_STOCK_COMP);
        dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
    }
    

    // 취소
    public void setCancel(LDataMap paramMap) throws Exception {

        if (paramMap == null) {
            throw new LingoException("엑스루트 송장번호가 없습니다.");
        }
        
        LDataMap boxMap = (LDataMap) dao.selectOne("atomyStockInsertMapper.getBoxData", paramMap);
        
        paramMap.put("wgt", boxMap.getString("weight"));
        paramMap.put("boxWidth", boxMap.getString("width"));
        paramMap.put("boxLength", boxMap.getString("length"));
        paramMap.put("boxHeight", boxMap.getString("height"));
        paramMap.put("statusCd", CommonConst.ORD_STATUS_CD_SENDING_COMP); // 발송완료 상태.
        dao.update("atomyStockInsertMapper.updateTorder", paramMap);
        
        paramMap.put("usercd", LoginInfo.getUsercd());
        paramMap.put("loginIp", ClientInfo.getClntIP());
        paramMap.put("statusCd", CommonConst.ORD_STATUS_CD_STOCK_CANCEL);
        paramMap.put("eventCd", CommonConst.EVENT_STOCK_CANCEL);
        dao.insert("atomyStockInsertMapper.insertStockHistory", paramMap);

        TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
        trackingHistorytVO.setXrtInvcSno(paramMap.getString("xrtInvcSno"));
        trackingHistorytVO.seteNation("KR");
        trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
        trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
        trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());
        trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_STOCK_CANCEL);
        trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_STOCK_CANCEL);
        trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_STOCK_CANCEL);
        dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
    }

    // 발송완료 상태 확인.
    public LDataMap checkSendingComp(LDataMap paramMap) throws Exception{
        LDataMap retMap = (LDataMap) dao.selectOne("atomyStockInsertMapper.checkSendingComp", paramMap);
        return retMap;
    }

    // 용인센터 검수되었는지 체크.
    public LDataMap checkInspection(LDataMap paramMap) throws Exception{
        LDataMap retMap = (LDataMap) dao.selectOne("atomyStockInsertMapper.checkInspection", paramMap);
        return retMap;
    }
}
