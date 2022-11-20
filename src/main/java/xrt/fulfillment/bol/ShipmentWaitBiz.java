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
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

/**
 * 선적 대기 Biz
 * 
 * @since 2020-12-15
 * @author wnkim
 *
 */
@Service
public class ShipmentWaitBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(ShipmentWaitBiz.class);
    
    /**
     * 최초 화면 진입
     * @return
     * @throws Exception
     */
    public LDataMap view() throws Exception {
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("STATUS", "Y");
        List<CodeVO> countrylist = dao.selectList("UpsCountryZoneMapper.getUpsCountryName", param);
        
        LDataMap param2 = new LDataMap();
        param2.put("COMPCD", LoginInfo.getCompcd());
        param2.put("CODEKEY", "DELIVERY_TYPE");
        param2.put("STATUS", "Y");
        List<CodeVO> serviceType = dao.selectList("CodeCacheMapper.getCommonCode", param2);
        
        LDataMap retMap = new LDataMap();
        retMap.put("countrylist", countrylist);
        retMap.put("serviceType", serviceType);
        return retMap;
    }
    
    /**
     * TOrder 테이블 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public LRespData getSearch(CommonSearchVo paramVO) throws Exception {
        LRespData resData = new LRespData();
        List<ShippingListVO> tOrderList = dao.selectList("shipmentWaitMapper.getSearch", paramVO);
        resData.put("resultList", tOrderList);
        return resData;
    }
    
    /**
     * TOrder / SBLNO, HBLNO, MBLNO 조회 테이블 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public LRespData getOrderSearch(CommonSearchVo paramVO) throws Exception {
        LRespData resData = new LRespData();
        List<ShippingListVO> tOrderList = dao.selectList("shipmentWaitMapper.getOrderSearch", paramVO);
        resData.put("resultList", tOrderList);
        return resData;
    }
    
    /**
     * 최초 화면 진입
     * @return
     * @throws Exception
     */
    public LDataMap popView() throws Exception {
        
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("STATUS", "Y");
        List<CodeVO> countrylist = dao.selectList("DhlCountryZoneMapper.getDhlCountryCode", param);
        
        LDataMap retMap = new LDataMap();
        retMap.put("countrylist", countrylist);
        return retMap;
    }
    
    
    /**
     * 선적 등록
     * @param dataMap
     * @return
     * @throws Exception
     */
    public LRespData setPopSave(LReqData dataMap) throws Exception {
        String customsClearance = dataMap.getParamDataVal("customsClearance");
        String country = dataMap.getParamDataVal("country");
        String closeYn = dataMap.getParamDataVal("closeYn");
        String remark = dataMap.getParamDataVal("remark");
        List<LDataMap> xrtInvcSnos = dataMap.getParamDataList("dataList");
        
        SimpleDateFormat today = new SimpleDateFormat("yyyyMMdd"); 
        Date date = new Date();
        
        ShipmentBLVO shipmentBLVO = new ShipmentBLVO();
        shipmentBLVO.setDate(today.format(date));
        shipmentBLVO.setCompcd(LoginInfo.getCompcd());
        shipmentBLVO.setCustomsClearance(customsClearance);
        shipmentBLVO.setCountry(country);
        shipmentBLVO.setCloseYn(closeYn);
        shipmentBLVO.setRemark(remark);
        shipmentBLVO.setAddusercd(LoginInfo.getUsercd());
        shipmentBLVO.setUpdusercd(LoginInfo.getUsercd());
        shipmentBLVO.setTerminalcd(ClientInfo.getClntIP());

        String shipmentBlNo = "";
        int isCreated = (Integer) dao.selectOne("shipmentWaitMapper.getNoCount", shipmentBLVO);
        if (isCreated == 0) {
            shipmentBlNo = (String) dao.selectOne("shipmentWaitMapper.getCreateNo", shipmentBLVO);
        } else if (isCreated == 1) {
            shipmentBlNo = (String) dao.selectOne("shipmentWaitMapper.getShipmentBLNo", shipmentBLVO);
        } else {
            throw new LingoException("ShipmentBlNo에서 문제가 발생 하였습니다.");
        }

        shipmentBLVO.setShipmentBlNo(shipmentBlNo);
        if (isCreated == 0) {
            dao.insert("shipmentWaitMapper.insertShipmentBL", shipmentBLVO);
        } else {
            dao.update("shipmentWaitMapper.updateShipmentBL", shipmentBLVO);
        }
        
        logger.debug("shipmentBLVO : " + shipmentBLVO.toString());
        for (int i = 0; i < xrtInvcSnos.size(); i++) {
            LDataMap updateMap = new LDataMap();
            updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_WAREHOUSE);
            updateMap.put("shipmentBlNo", shipmentBlNo);
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
}