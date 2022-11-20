package xrt.fulfillment.order.modify;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import xrt.alexcloud.api.aftership.AfterShipAPI;
import xrt.alexcloud.api.aftership.vo.AfterShipTrackingVo;
import xrt.alexcloud.common.CommonConst;
import xrt.fulfillment.tracking.TrackingHistorytVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

/**
 * 오더수정biz
 *
 * @author wn.kim
 *
 */
@Service
public class OrderModifyDtlBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(OrderModifyDtlBiz.class);
    
    private AfterShipAPI afterShipAPI;
    
    @Autowired
    public OrderModifyDtlBiz(AfterShipAPI afterShipAPI) {
        this.afterShipAPI = afterShipAPI;
    }

    /**
     *
     * @param param
     * @return
     * @throws Exception
     */
    public String checkXrtInvcSno(LDataMap param) throws Exception {
        return dao.selectStrOne("OrderModifyMapper.checkXrtInvcSno", param);
    }

    /**
     * 데이터 검증
     * @param paramMap
     * @param dataList
     * @return
     * @throws Exception
     */
    public LDataMap valid(List<LDataMap> dataList) throws Exception {
        logger.debug("[valid] dataList : "+ dataList.toString());
        logger.debug("1. 수정 데이터 목록 검증");
        logger.debug("dataList.size : "+ dataList.size());

        for (int i = 0; i < dataList.size(); i++) {
            String checkXrtInvcSno = this.checkXrtInvcSno(dataList.get(i));
            int statusCd = dataList.get(i).getString("statusCd") == "" ? 0 : Integer.parseInt(dataList.get(i).getString("statusCd"));
            logger.debug("statusCd : "+ statusCd);

            /*if (dataList.get(i).getString("xrtInvcSno").equals("")) {
                throw new LingoException("xrtInvcSno가없습니다.");
            }

            if (dataList.get(i).getString("invcSno1").equals("")) {
                throw new LingoException("invcSno1가없습니다.");
            }*/
            if (dataList.get(i).getString("statusCd") != "") {
                if (!(statusCd >= 10 && statusCd <= 30)) {
                    throw new LingoException("입고완료 상태까지 수정 가능합니다.");
                }
            }
            
            if (checkXrtInvcSno.equals("false")) {
                throw new LingoException("해당 송장번호가없습니다.");
            }
        }

        logger.debug("2. 반환값 지정");
        LDataMap retMap = new LDataMap();
        retMap.put("code", "200");
        retMap.put("message", "성공하였습니다.");
        return retMap;
    }

    /**
     * Order List를 Torder 수정 적용
     * @param orderList
     * @return
     * @throws Exception
     */
    public LDataMap setTorder(List<LDataMap> orderList) throws Exception {
        logger.debug("[setTorder] orderList : "+ orderList.toString());
        LDataMap retMap = new LDataMap();
        
        logger.debug("1. 오더 수정");
        
        for (int i = 0; i < orderList.size(); i++) {
            /*
             * 강제 오더 수정 시 입고일자가 없는 경우에만 오더수정탭에서 입고일자 입력. 그리고 입고일자가 있을 경우 변동이 안되고 기존 입고 일자 유지.
             */
            String xrtInvcSno = orderList.get(i).getString("xrtInvcSno");
            // 입고 날짜 확인.
            String checkStockDate = dao.selectStrOne("OrderModifyMapper.checkStockDate", xrtInvcSno);
            logger.info("checkStockDate : " + checkStockDate);
            
            LDataMap dataMap = new LDataMap();
            dataMap.put("xrtInvcSno", orderList.get(i).getString("xrtInvcSno"));
            dataMap.put("invcSno1", orderList.get(i).getString("invcSno1"));
            dataMap.put("statusCd", orderList.get(i).getString("statusCd"));
            dataMap.put("localShipper", orderList.get(i).getString("localShipper"));
            dataMap.put("xrtShippingPrice", orderList.get(i).getString("xrtShippingPrice"));
            dataMap.put("wgt", orderList.get(i).getString("wgt"));
            dataMap.put("usercd", LoginInfo.getUsercd());
            if (checkStockDate.equals("Y")) {
                dataMap.put("stockDate", orderList.get(i).getString("stockDate"));
            }

            dao.update("OrderModifyMapper.updateTorder", dataMap);
            
            AfterShipTrackingVo afterShipTrackingVo = new AfterShipTrackingVo();
            
            LDataMap orders = (LDataMap) dao.selectOne("AfterShipMapper.getOrderData", orderList.get(i));
            
            if (!orderList.get(i).getString("localShipper").equals("") && !orderList.get(i).getString("invcSno1").equals("")) {
                afterShipTrackingVo.setSlug(orderList.get(i).getString("localShipper").toLowerCase());
                afterShipTrackingVo.setTrackingNumber(orderList.get(i).getString("invcSno1"));
                afterShipTrackingVo.setTitle("");

                List<String> emails = new ArrayList<>();
                emails.add("xroute@logifocus.co.kr");
                afterShipTrackingVo.setEmails(emails);
                afterShipTrackingVo.setOrderId(orders.getString("ordNo"));
                afterShipTrackingVo.setOrderIdPath("");

                Map<String, Object> customFileds = new HashMap<>();
                customFileds.put("productName", orders.getString("goodsNm"));
                customFileds.put("productPrice", orders.getString("price"));

                afterShipTrackingVo.setCustomFields(customFileds);
                afterShipTrackingVo.setLanguage("en");
                afterShipTrackingVo.setOrderPromisedDeliveryDate("");
                afterShipTrackingVo.setDeliveryType("pickup_at_courier");
                afterShipTrackingVo.setPickupLocation(orders.getString("eNation").toUpperCase());
                afterShipTrackingVo.setPickupNote("");
                afterShipAPI.createTrackings(afterShipTrackingVo);
            }
            TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
            
            String statusCd = orderList.get(i).getString("statusCd");
            switch (statusCd) {
                case "10":
                    trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_ORDER_APPLY);
                    trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_ORDER_APPLY);
                    trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_ORDER_APPLY);
                    break;
                case "11":
                    trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_SENDING_WAIT);
                    trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_SENDING_WAIT);
                    trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_SENDING_WAIT);
                    break;
                case "12":
                    trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_SENDING_COMP);
                    trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_SENDING_COMP);
                    trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_SENDING_COMP);
                    break;
                case "20":
                    trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_CENTER_ARRIVE);
                    trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_CENTER_ARRIVE);
                    trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_CENTER_ARRIVE);
                    break;
                case "21":
                    trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_PAYMENT_COMP);
                    trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_PAYMENT_COMP);
                    trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_PAYMENT_COMP);
                    break;
                case "22":
                    trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_PAYMENT_WAIT);
                    trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_PAYMENT_WAIT);
                    trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_PAYMENT_WAIT);
                    break;
                case "23":
                    trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_PAYMENT_FAIL);
                    trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_PAYMENT_FAIL);
                    trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_PAYMENT_FAIL);
                    break;
                case "30":
                    trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_STOCK_COMP);
                    trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_STOCK_COMP);
                    trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_STOCK_COMP);
                    break;
                default:
                    break;
            }

            
            if (!statusCd.equals("")) {
                trackingHistorytVO.setXrtInvcSno(orderList.get(i).getString("xrtInvcSno"));
                trackingHistorytVO.seteNation(orders.getString("eNation"));
                trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
                trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
                trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());
                dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO);
            }
        }
        retMap.put("CODE", "1");
        retMap.put("MESSAGE", "성공하였습니다.");
        return retMap;
    }
}
