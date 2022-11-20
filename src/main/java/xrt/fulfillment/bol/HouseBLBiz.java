package xrt.fulfillment.bol;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.order.shippinglist.ShippingListVO;
import xrt.fulfillment.tracking.TrackingHistorytVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

/**
 * HBL Biz
 * 
 * @since 2020-12-17
 * @author wnkim
 *
 */
@Service
public class HouseBLBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(HouseBLBiz.class);

    /**
     * HOUSE_BL 테이블 조회
     * 
     * @param paramVO
     * @return
     * @throws Exception
     */
    public LRespData getSearch(CommonSearchVo paramVO) throws Exception {
        LRespData resData = new LRespData();
        List<ShippingListVO> torderList = dao.selectList("houseBlMapper.getSearch", paramVO);
        resData.put("resultList", torderList);

        return resData;
    }

    public LRespData setComplete(LReqData paramMap) throws Exception {
        List<LDataMap> completaList = paramMap.getParamDataList("dataList");

        for (int i = 0; i < completaList.size(); i++) {

            String houseBlNo = completaList.get(i).getString("houseBlNo");

            boolean bCloseYn = this.checkCloseYN(houseBlNo);
            if (bCloseYn) {
                throw new LingoException("완료된 HBL 입니다.");
            }

            HouseBLVO houseBLVO = new HouseBLVO();
            houseBLVO.setHouseBlNo(houseBlNo);
            houseBLVO.setCloseYn("Y");
            houseBLVO.setUpdusercd(LoginInfo.getUsercd());
            dao.update("houseBlMapper.updateHouseBL", houseBLVO);
        }

        LRespData resData = new LRespData();
        return resData;
    }

    /**
     * SBL 목록 조회
     * 
     * @return
     * @throws Exception
     */
    public LRespData getPopSearch(LDataMap paramMap) throws Exception {
        List<ShipmentBLVO> shipmentBLVOs = dao.selectList("houseBlMapper.getShipmentBLList", paramMap);
        LRespData resData = new LRespData();
        resData.put("resultList", shipmentBLVOs);
        return resData;
    }

    /**
     * HBL 정보 조회
     * 
     * @return
     * @throws Exception
     */
    public LRespData getHouseBL(LDataMap paramMap) throws Exception {
        List<HouseBLVO> houseBLVOs = dao.selectList("houseBlMapper.getHouseBL", paramMap);
        LRespData resData = new LRespData();
        resData.put("resultData", houseBLVOs);
        return resData;
    }

    /**
     * SBL에서 HouseBlNo 제거
     * 
     * @return
     * @throws Exception
     */
    public LRespData deleteShipmentBL(LReqData dataMap) throws Exception {
        String houseBlNo = dataMap.getParamDataVal("houseBlNo");
        List<LDataMap> shipmentBlNos = dataMap.getParamDataList("dataList");

        boolean bCloseYn = this.checkCloseYN(houseBlNo);
        if (bCloseYn) {
            throw new LingoException("완료된 HBL 입니다.");
        }

        for (int i = 0; i < shipmentBlNos.size(); i++) {
            ShipmentBLVO shipmentBLVO = new ShipmentBLVO();
            shipmentBLVO.setUpdusercd(LoginInfo.getUsercd());
            shipmentBLVO.setShipmentBlNo(shipmentBlNos.get(i).getString("shipmentBlNo"));

            dao.update("houseBlMapper.updateShipmentBL", shipmentBLVO);
        }
        
        List<LDataMap> xrtInvcSnos = dao.selectList("houseBlMapper.getTorder", shipmentBlNos);
        
        for (int i = 0; i < xrtInvcSnos.size(); i++) {
            LDataMap updateMap = new LDataMap();
            updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_WAREHOUSE);
            updateMap.put("shipmentBlNo", xrtInvcSnos.get(i).getString("shipmentBlNo"));
            updateMap.put("usercd", LoginInfo.getUsercd());
            updateMap.put("xrtInvcSno", xrtInvcSnos.get(i).getString("xrtInvcSno"));

            dao.update("shipmentWaitMapper.updateTOrder", updateMap);

            TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
            trackingHistorytVO.setXrtInvcSno(xrtInvcSnos.get(i).getString("xrtInvcSno"));
            trackingHistorytVO.seteNation(xrtInvcSnos.get(i).getString("eNation").toUpperCase());
            trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_WAREHOUSE);
            trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_WAREHOUSE);
            trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_WAREHOUSE);
            trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
            trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
            trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());
            
            dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
        }

        LRespData resData = new LRespData();
        return resData;
    }

    /**
     * HBL 수정 및 상태변경
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    public LRespData setPopSave(LDataMap paramMap) throws Exception {
        String type = paramMap.getString("type");
        boolean bCloseYn = this.checkCloseYN(paramMap.getString("houseBlNo"));
        if ("data".equals(type) || "".equals(type) && "".equals(paramMap.getString("closeYn"))) {
            if (bCloseYn) {
                throw new LingoException("완료된 HBL입니다.");
            }
        }

        HouseBLVO houseBLVO = new HouseBLVO();
        houseBLVO.setHouseBlNo(paramMap.getString("houseBlNo"));
        houseBLVO.setRemark(paramMap.getString("remark"));
        houseBLVO.setCloseYn(paramMap.getString("closeYn"));
        houseBLVO.setUpdusercd(LoginInfo.getUsercd());

        dao.update("houseBlMapper.updateHouseBL", houseBLVO);

        LRespData resData = new LRespData();
        return resData;
    }

    /**
     * 하우스 B/L 생성
     * 
     * @param dataMap
     * @return
     * @throws Exception
     */
    public LRespData setCreatePopSave(LReqData dataMap) throws Exception {
        List<LDataMap> shipmentBlNos = dataMap.getParamDataList("dataList");
        String remark = dataMap.getParamDataVal("remark");
        String closeYn = dataMap.getParamDataVal("closeYn");
        String houseBlNo = dataMap.getParamDataVal("houseBlNo");
        String customsClearance = dataMap.getParamDataVal("customsClearance");

        boolean bCloseYn = this.checkCloseYN(houseBlNo);
        if (bCloseYn) {
            throw new LingoException("완료된 HBL입니다.");
        }

        LDataMap retMap = new LDataMap();
        retMap.put("dataList", dataMap.getParamDataList("dataList"));

        Date date = new Date();
        SimpleDateFormat today = new SimpleDateFormat("yyyyMMdd");
        HouseBLVO houseBLVO = new HouseBLVO();
        houseBLVO.setDate(today.format(date));
        houseBLVO.setHouseBlNo(houseBlNo);
        houseBLVO.setCompcd(LoginInfo.getCompcd());
        houseBLVO.setCloseYn(closeYn.toUpperCase().trim());
        houseBLVO.setCustomsClearance(customsClearance);
        houseBLVO.setRemark(remark);
        houseBLVO.setAddusercd(LoginInfo.getUsercd());
        houseBLVO.setUpdusercd(LoginInfo.getUsercd());
        houseBLVO.setTerminalcd(ClientInfo.getClntIP());

        logger.debug("HouseBLVO : " + houseBLVO.toString());
        int isCreated = (Integer) dao.selectOne("houseBlMapper.getNoCount", houseBLVO);
        if (isCreated == 0) {
            String scacCode = (String) dao.selectOne("houseBlMapper.getCreateNo", houseBLVO);
            houseBLVO.setScacCode(scacCode);
            dao.insert("houseBlMapper.insertHouseBL", houseBLVO);
        } else if (isCreated == 1) {
            dao.update("houseBlMapper.updateHouseBL", houseBLVO);
        } else {
            throw new LingoException("HoseBlNo에서 문제가 발생 하였습니다.");
        }

        for (int i = 0; i < shipmentBlNos.size(); i++) {
            ShipmentBLVO shipmentBLVO = new ShipmentBLVO();
            shipmentBLVO.setShipmentBlNo(shipmentBlNos.get(i).getString("shipmentBlNo"));
            shipmentBLVO.setHouseBlNo(houseBlNo);
            shipmentBLVO.setUpdusercd(LoginInfo.getUsercd());
            dao.update("houseBlMapper.updateShipmentBL", shipmentBLVO);
        }
        
        List<LDataMap> xrtInvcSnos = dao.selectList("houseBlMapper.getTorder", retMap);
        
        for (int i = 0; i < xrtInvcSnos.size(); i++) {
            LDataMap updateMap = new LDataMap();
            updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_SHIP_HOLD);
            updateMap.put("shipmentBlNo", xrtInvcSnos.get(i).getString("shipmentBlNo"));
            updateMap.put("usercd", LoginInfo.getUsercd());
            updateMap.put("xrtInvcSno", xrtInvcSnos.get(i).getString("xrtInvcSno"));

            dao.update("shipmentWaitMapper.updateTOrder", updateMap);

            TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
            trackingHistorytVO.setXrtInvcSno(xrtInvcSnos.get(i).getString("xrtInvcSno"));
            trackingHistorytVO.seteNation(xrtInvcSnos.get(i).getString("eNation").toUpperCase());
            trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_SHIP_HOLD);
            trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_SHIP_HOLD);
            trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_SHIP_HOLD);
            trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
            trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
            trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());
            
            dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
        }
        
        LRespData resData = new LRespData();
        return resData;
    }

    /**
     * House B/L상태 체크 true : 완료, false : 진행 중
     * 
     * @param houseBlNo
     * @return
     * @throws Exception
     */
    public boolean checkCloseYN(String houseBlNo) throws Exception {
        boolean bRet = false;

        if (houseBlNo == null || "".equals(houseBlNo)) {
            throw new LingoException("HBL 번호가 없습니다.");
        }

        LDataMap checkMap = new LDataMap();
        checkMap.put("houseBlNo", houseBlNo);
        checkMap.put("compcd", LoginInfo.getCompcd());
        Object vo = dao.selectOne("houseBlMapper.getHouseBL", checkMap);
        HouseBLVO houseBLVO = (HouseBLVO) vo;

        if (houseBLVO == null) {
            return bRet;
        } else {
            logger.debug("MasterBLVO : " + houseBLVO.toString());
            if ("Y".equals(houseBLVO.getCloseYn().trim().toUpperCase())) {
                bRet = true;
            }

            return bRet;
        }
    }
}