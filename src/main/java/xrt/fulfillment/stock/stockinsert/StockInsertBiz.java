package xrt.fulfillment.stock.stockinsert;

import java.math.BigDecimal;
import java.math.MathContext;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import xrt.alexcloud.api.aftership.AfterShipAPI;
import xrt.alexcloud.api.aftership.vo.AfterShipTrackingVo;
import xrt.alexcloud.api.shippo.ShippoAPI;
import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.utils.SendMail;
import xrt.fulfillment.order.payment.PassBookBiz;
import xrt.fulfillment.order.payment.PassBookMasterVO;
import xrt.fulfillment.system.WeightCalculationBiz;
import xrt.fulfillment.tracking.TrackingHistorytVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.sys.promotionCode.PromotionCodeVO;

@Service
public class StockInsertBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(StockInsertBiz.class);

    private SendMail sendMail;
    private PassBookBiz passBookBiz;
    private AfterShipAPI afterShipAPI;
    private WeightCalculationBiz weightCalculationBiz;

    @Autowired
    public StockInsertBiz(SendMail sendMail, PassBookBiz passBookBiz, AfterShipAPI afterShipAPI, WeightCalculationBiz weightCalculationBiz) {
        super();
        this.sendMail = sendMail;
        this.passBookBiz = passBookBiz;
        this.afterShipAPI = afterShipAPI;
        this.weightCalculationBiz = weightCalculationBiz;
    }

    @Value("#{config['c.debugtype']}")
    private String debugtype;
    @Value("#{config['c.devShippoWestApiyKey']}")
    private String devShippoWestApiyKey;
    @Value("#{config['c.devShippoEastApiKey']}")
    private String devShippoEastApiKey;
    @Value("#{config['c.realShippoWestApiyKey']}")
    private String realShippoWestApiyKey;
    @Value("#{config['c.realShippoEastApiKey']}")
    private String realShippoEastApiKey;

    // 검색
    public LDataMap getSearch(LDataMap param) throws Exception {
        LDataMap resultData = (LDataMap) dao.selectOne("stockInsertMapper.getSearch", param);
        return resultData;
    }

    // 검색
    public List<LDataMap> getOrderDtl(LDataMap param) throws Exception {
        return dao.select("stockInsertMapper.getOrderDtl", param);
    }

    // 입고 리스트
    public List<LDataMap> getWarehousing(LDataMap param) throws Exception {
        return dao.select("stockInsertMapper.getWarehousing", param);
    }

    // 무게값 취득
    public List<LDataMap> getWgtSearch(LDataMap param) throws Exception {
        return dao.select("stockInsertMapper.getWgtSearch", param);
    }

    // 무게값 취득
    public void updWgt(LDataMap param) throws Exception {
        dao.update("stockInsertMapper.updWgt", param);
    }

    // 라벨 출력
    public LDataMap getPrint(LDataMap paramMap) throws Exception {
        LDataMap orderMap = (LDataMap) dao.selectOne("stockInsertMapper.getPrint", paramMap);
        String eNation = orderMap.getString("E_NATION").toUpperCase();
        String shipMethodCd = orderMap.getString("SHIP_METHOD_CD").toUpperCase();
        // 미국(PREMIUM) 외 해외 송장 출력 불가능
        if (!eNation.equals("US")) {
            throw new LingoException("US인 경우만 출력이 가능합니다.");
        }

        if (!shipMethodCd.equals(CommonConst.SHIP_METHOD_PREMIUM)) {
            throw new LingoException("배송 구분이 'PREMIUM'인것만 출력이 가능합니다.");
        }

        if (orderMap.getString("WGT") == "") {
            throw new LingoException("무게값이 없습니다.");
        }

        dao.update("stockInsertMapper.setPrintCnt", paramMap);
        paramMap.put("EVENT_CD", CommonConst.EVENT_STOCK_INVC_PRINT);
        dao.insert("stockInsertMapper.insertStockHis", paramMap);

        return orderMap;
    }

    // Shippo Create Shipment
    public LDataMap getShipmentData(LDataMap paramMap) throws Exception {

        LDataMap orderMap = (LDataMap) dao.selectOne("stockInsertMapper.getShipmentData", paramMap);

        String eNation = orderMap.getString("eNation").toUpperCase();
        String shipMethodCd = orderMap.getString("shipMethodCd").toUpperCase();
        String sWgt = paramMap.getString("wgt");

        if (!eNation.equals("US")) {
            logger.debug(" eNation : " + eNation);
            LDataMap retMap = new LDataMap();
            retMap.put("code", "201");
            retMap.put("message", "USA아님.");
            return retMap;
        }
        // EMS, K-PACKET, DHL, NORMAL의 경우는 쉬포송장출력을 하지 않는다.
        if (!shipMethodCd.equals(CommonConst.SHIP_METHOD_PREMIUM)) {
            LDataMap retMap = new LDataMap();
            retMap.put("code", "201");
            retMap.put("message", "배송타입이 PREMIUM이 아님.");
            return retMap;
        }

        orderMap.put("width", "10");
        orderMap.put("length", "10");
        orderMap.put("height", "10");
        orderMap.put("wgt", sWgt);

        LDataMap retMap = createShipmentData(orderMap);
        return retMap;
    }

    // 저장
    public LDataMap setSave(LDataMap paramMap) throws Exception {

        if (paramMap == null) {
            throw new LingoException("변경된 항목이 없습니다.");
        }

        paramMap.put("LOGIN_USERCD", LoginInfo.getUsercd());
        paramMap.put("LOGIN_IP", ClientInfo.getClntIP());

        // 결제방식, 결제유무에 따른 STATUS_CD 저장 20200210최일규
        String statusCd = "";
        String pStatusCd = paramMap.getString("STATUS_CD");
        String paymentType = paramMap.getString("PAYMENT_TYPE");
        switch (paymentType) {
            case CommonConst.PAYEMNT_TYPE_MONTH:
            case CommonConst.PAYEMNT_TYPE_WARRANTY:
                statusCd = CommonConst.ORD_STATUS_CD_STOCK_COMP; // 입고 완료.
                break;
            case CommonConst.PAYEMNT_TYPE_PERCASE:
                if (CommonConst.ORD_STATUS_CD_PAYMENT_COMP.equals(pStatusCd)) { // 입금완료.
                    statusCd = CommonConst.ORD_STATUS_CD_STOCK_COMP; // 입고 완료.
                } else {
                    statusCd = CommonConst.ORD_STATUS_CD_CENTER_ARRIVE; // 입금대기
                }
                break;
            case CommonConst.PAYEMNT_TYPE_REGULAR:
                if (CommonConst.ORD_STATUS_CD_ORDER_APPLY.equals(pStatusCd)) { // 입금완료.
                    statusCd = CommonConst.ORD_STATUS_CD_CENTER_ARRIVE; // 입고완료.
                } else {
                    statusCd = CommonConst.ORD_STATUS_CD_STOCK_COMP; // 입금대기
                }
                break;
            default:
                throw new LingoException("지정된 결제구분이 아닙니다.");
        }

        paramMap.put("STATUS_CD", statusCd);

        if (paramMap.getString("BOX_WIDTH").equals("")) {
            // throw new LingoException("가로값이 없습니다.");
            paramMap.put("BOX_WIDTH", "1");
        }
        if (paramMap.getString("BOX_LENGTH").equals("")) {
            // throw new LingoException("세로값이 없습니다.");
            paramMap.put("BOX_LENGTH", "1");
        }
        if (paramMap.getString("BOX_HEIGHT").equals("")) {
            // throw new LingoException("높이값이 없습니다.");
            paramMap.put("BOX_HEIGHT", "1");
        }

        BigDecimal box_width = new BigDecimal(paramMap.getString("BOX_WIDTH"));
        BigDecimal box_length = new BigDecimal(paramMap.getString("BOX_LENGTH"));
        BigDecimal box_heigth = new BigDecimal(paramMap.getString("BOX_HEIGHT"));
        BigDecimal box_volume = new BigDecimal(0);
        BigDecimal xrtWgt = new BigDecimal(paramMap.getString("WGT"));
        BigDecimal primeumNumber = new BigDecimal(CommonConst.BOX_VOLUME_PRIMEUM_NUMBER);
        BigDecimal expressNumber = new BigDecimal(CommonConst.BOX_VOLUME_EXPRESS_NUMBER);
        BigDecimal upsNumber = new BigDecimal(CommonConst.BOX_VOLUME_UPS_NUMBER);

        String shipMetondCd = paramMap.getString("SHIP_METHOD_CD").toUpperCase();
        if (shipMetondCd.equals(CommonConst.SHIP_METHOD_PREMIUM)) {
            // 볼륨중량 = (가로 x 세로 x 높이)/6000
            box_volume = (box_width.multiply(box_length).multiply(box_heigth)).divide(primeumNumber, MathContext.DECIMAL32);
        } else if (shipMetondCd.equals(CommonConst.SHIP_METHOD_DHL)) {
            // 볼륨중량 = (가로 x 세로 x 높이)/5000
            box_volume = (box_width.multiply(box_length).multiply(box_heigth)).divide(expressNumber, MathContext.DECIMAL32);
        } else if (shipMetondCd.equals(CommonConst.SHIP_METHOD_UPS)) {
            // 볼륨중량 = (가로 x 세로 x 높이)/5000
            box_volume = (box_width.multiply(box_length).multiply(box_heigth)).divide(upsNumber, MathContext.DECIMAL32);
        }

        paramMap.put("BOX_VOLUME", String.format("%.2f", box_volume.doubleValue()));
        // 1) 가격비교
        // 볼륨중량과 무게중량을 비교해서 볼륨중량이 더 크면 볼륨중량을 사용.
        // compareTo :::: -1은 작다, 0은 같다,1은 크다
        if (box_volume.compareTo(xrtWgt) == 1) {
            xrtWgt = box_volume;
        }

        // 배송사별 무게제한 체크
        double dWgt = xrtWgt.doubleValue();
        if (dWgt > Integer.parseInt(CommonConst.LIMIT_WGT)) {
            throw new LingoException("배송가능 무게 30Kg 초과했습니다.");
        }

        // 2) 가격취득 및 저장
        paramMap.put("XRT_WGT", xrtWgt.toString());

        LDataMap wgtParamMap = new LDataMap();
        wgtParamMap.put("width", paramMap.getString("BOX_WIDTH"));
        wgtParamMap.put("length", paramMap.getString("BOX_LENGTH"));
        wgtParamMap.put("height", paramMap.getString("BOX_HEIGHT"));
        wgtParamMap.put("wgt", paramMap.getString("WGT"));
        wgtParamMap.put("shippingType", shipMetondCd);
        if (shipMetondCd.equals(CommonConst.SHIP_METHOD_DHL)) {
            wgtParamMap.put("dhlCountry", paramMap.getString("E_NATION").toUpperCase());
        } else if (shipMetondCd.equals(CommonConst.SHIP_METHOD_UPS)) {
            wgtParamMap.put("upsCountry", paramMap.getString("E_NATION").toUpperCase());
        } else {
            wgtParamMap.put("premiumCountry", paramMap.getString("E_NATION").toUpperCase());
        }

        LDataMap wgtMap = weightCalculationBiz.getWeightCalculation(wgtParamMap);
        String xrtShippingPrice = wgtMap.getString("resultPrice");
        String xrtPrice = "";

        // 프로모션 코드적용
        String promotionCode = dao.selectStrOne("stockInsertMapper.getPromotionCode", paramMap);
        if (promotionCode.equals("")) {
            xrtPrice = xrtShippingPrice.replaceAll(",", "");
        } else {
            SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyyMMdd");
            Date date = new Date();
            String toDay = yyyyMMdd.format(date);

            LDataMap promotionParam = new LDataMap();
            promotionParam.put("toDay", toDay);
            promotionParam.put("promotionCode", promotionCode);

            PromotionCodeVO promotionCodeVO = (PromotionCodeVO) dao.selectOne("stockInsertMapper.getDiscount", promotionParam);
            if (promotionCodeVO != null) {
                double discount = 0;
                if (shipMetondCd.equals(CommonConst.SHIP_METHOD_DHL)) {
                    discount = Integer.parseInt(promotionCodeVO.getDhl()) / 100.0;
                    logger.info("getDhl: " + promotionCodeVO.getDhl());
                } else {
                    discount = Integer.parseInt(promotionCodeVO.getPremium()) / 100.0;
                    logger.info("getPremium : " + promotionCodeVO.getPremium());
                }

                logger.info("discount : " + discount);
                int oriPrice = Integer.parseInt(xrtShippingPrice.replaceAll(",", ""));
                int discountPrice = (int) (oriPrice * discount);
                int calcPrice = oriPrice - discountPrice;
                xrtPrice = Integer.toString(calcPrice);

                logger.info("discount : " + discount);
                logger.info("oriPrice : " + oriPrice);
                logger.info("discountPrice : " + discountPrice);
                logger.info("calcPrice : " + calcPrice);
                logger.info("xrtPrice : " + xrtPrice);
            } else {
                xrtPrice = xrtShippingPrice.replaceAll(",", "");
            }
        }

        // 3) 무게, 부피저장
        paramMap.put("XRT_SHIPPING_PRICE", xrtPrice);
        int scnt = dao.update("stockInsertMapper.updateTorderMst", paramMap);

        // TSOTCK_HISTORY INSERT
        if (scnt > 0) {
            if (CommonConst.ORD_STATUS_CD_CENTER_ARRIVE.equals(statusCd)) {
                paramMap.put("EVENT_CD", CommonConst.EVENT_PAYMENT_SAVE);
            } else {
                paramMap.put("EVENT_CD", CommonConst.EVENT_STOCK_SAVE);
            }
            // XRT_SHIPPING_PRICE, INVC_SNO1 취득
            LDataMap reSelect = (LDataMap) dao.selectOne("stockInsertMapper.getAmount", paramMap);
            paramMap.put("XRT_SHIPPING_PRICE", reSelect.get("XRT_SHIPPING_PRICE"));
            paramMap.put("API_INVC_SNO", reSelect.get("INVC_SNO1"));
            dao.insert("stockInsertMapper.insertStockHis", paramMap);

            TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
            trackingHistorytVO.setXrtInvcSno(paramMap.getString("XRT_INVC_NO"));
            trackingHistorytVO.seteNation(paramMap.getString("E_NATION").toUpperCase());
            trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
            trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
            trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());

            if (CommonConst.ORD_STATUS_CD_CENTER_ARRIVE.equals(statusCd)) { // 입금대기상태이면.
                if (paymentType.equals(CommonConst.PAYEMNT_TYPE_PERCASE)) { // 결제타입이건당결제이면,
                    LDataMap emailParam = (LDataMap) dao.selectOne("stockInsertMapper.getEmailData", paramMap);
                    emailParam.put("xrtShippingPrice", xrtShippingPrice + "원");
                    sendMail.sendPaymentWating(emailParam);
                }
                trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_CENTER_ARRIVE); // 입금대기.
                trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_CENTER_ARRIVE); // 입금대기.
                trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_CENTER_ARRIVE); // 입금대기.
            } else { // 입고 완료 상태
                trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_STOCK_COMP); // 입고완료.
                trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_STOCK_COMP); // 입고완료.
                trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_STOCK_COMP); // 입고완료.
            }
            dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO); // 트랙킹저장(입금대기상태).
        }

        LDataMap retParam = new LDataMap();
        retParam.put("SCNT", scnt);
        return retParam;
    }

    // 입고완료
    public LDataMap setPmSave(LDataMap paramMap) throws Exception {

        if (paramMap == null) {
            throw new LingoException("변경된 항목이 없습니다.");
        }

        paramMap.put("LOGIN_USERCD", LoginInfo.getUsercd());
        paramMap.put("LOGIN_IP", ClientInfo.getClntIP());
        paramMap.put("STATUS_CD", CommonConst.ORD_STATUS_CD_STOCK_COMP);

        // torder update
        int scnt = dao.update("stockInsertMapper.updateTorderMst", paramMap);
        if (scnt > 0) {
            LDataMap reSelect = (LDataMap) dao.selectOne("stockInsertMapper.getAmount", paramMap);
            paramMap.put("API_INVC_SNO", reSelect.get("INVC_SNO1"));
            paramMap.put("EVENT_CD", CommonConst.EVENT_STOCK_SAVE);
            dao.insert("stockInsertMapper.insertStockHis", paramMap);

            TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
            trackingHistorytVO.setXrtInvcSno(paramMap.getString("XRT_INVC_NO"));
            trackingHistorytVO.seteNation(paramMap.getString("E_NATION").toUpperCase());
            trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
            trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
            trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());
            trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_STOCK_COMP); // 입고완료.
            trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_STOCK_COMP); // 입고완료.
            trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_STOCK_COMP); // 입고완료.
            dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO); // 트랙킹저장(입금대기상태).
        }

        LDataMap retParam = new LDataMap();
        retParam.put("SCNT", scnt);
        return retParam;
    }

    // 입고취소
    public LDataMap setCancel(LDataMap paramMap) throws Exception {

        if (paramMap == null) {
            throw new LingoException("변경된 항목이 없습니다.");
        }

        List<LDataMap> shippoList = dao.selectList("stockInsertMapper.getShippoInfo", paramMap);

        String shippoId = "";
        String amount = "";
        String apiInvcSno = "";
        String shipMethodCd = "";
        String statusCd = "";
        String tmpEnation = "";
        String tmpShipMethodCd = "";
        String delInvcSnoYn = "N";

        // 입고상태에서만 해당 로직 적용 20200213 최일규
        for (LDataMap orderMap : shippoList) {
            statusCd = orderMap.getString("statusCd");
            tmpEnation = orderMap.getString("eNation").toUpperCase();
            tmpShipMethodCd = orderMap.getString("shipMethodCd").toUpperCase();
            if (statusCd.equals("30") && tmpShipMethodCd.equals("PREMIUM")) {

                if (!tmpEnation.toUpperCase().equals("US")) {
                    break;
                }

                switch (tmpShipMethodCd) {
                    case CommonConst.SHIP_METHOD_PREMIUM:
                        delInvcSnoYn = "Y";
                        break;
                    case CommonConst.SHIP_METHOD_DHL:
                        break;
                    case CommonConst.SHIP_METHOD_UPS:
                        break;
                    default:
                        break;
                }

                BigDecimal bAmount = (BigDecimal) (orderMap.get("amount") == null ? BigDecimal.ZERO : orderMap.get("amount"));
                shippoId = orderMap.getString("shippoId");
                amount = bAmount.toPlainString();
                apiInvcSno = orderMap.getString("invcSno1");
            }
        }
        // 배송국가
        paramMap.put("delInvcSnoYn", delInvcSnoYn);
        // 환불정보 취득
        LDataMap refundMap = (LDataMap) dao.selectOne("stockInsertMapper.getRefundInfo", paramMap);
        refundMap.put("LOGIN_USERCD", LoginInfo.getUsercd());
        refundMap.put("LOGIN_IP", ClientInfo.getClntIP());

        paramMap.put("STATUS_CD", CommonConst.ORD_STATUS_CD_ORDER_APPLY);
        int scnt = dao.update("stockInsertMapper.updateTorderMstStockCancle", paramMap);
        // TSOTCK_HISTORY INSERT
        if (scnt > 0) {
            paramMap.put("API_INVC_SNO", apiInvcSno);
            paramMap.put("ETC1", shippoId);
            paramMap.put("ETC2", amount);
            paramMap.put("EVENT_CD", CommonConst.EVENT_STOCK_CANCEL);
            paramMap.put("STATUS_CD", CommonConst.ORD_STATUS_CD_STOCK_CANCEL);
            // history insert
            dao.insert("stockInsertMapper.insertStockHis", paramMap);

            TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
            trackingHistorytVO.setXrtInvcSno(refundMap.getString("XRT_INVC_SNO"));
            trackingHistorytVO.seteNation(refundMap.getString("E_NATION").toUpperCase());
            trackingHistorytVO.setAddusercd(LoginInfo.getUsercd());
            trackingHistorytVO.setUpdusercd(LoginInfo.getUsercd());
            trackingHistorytVO.setTerminalcd(ClientInfo.getClntIP());
            trackingHistorytVO.setStatusCd(CommonConst.ORD_STATUS_CD_STOCK_CANCEL); // 입고취소.
            trackingHistorytVO.setStatusNm(CommonConst.ORD_STATUS_NM_STOCK_CANCEL); // 입고취소.
            trackingHistorytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_STOCK_CANCEL); // 입고취소.
            dao.insert("trackingHistoryMapper.insertTrackingHistory", trackingHistorytVO); // 트랙킹저장(입금대기상태).

            // refund_master insert - 건별 결제만 insert
            if (CommonConst.PAYEMNT_TYPE_PERCASE.equals(refundMap.getString("PAYMENT_TYPE"))) {
                dao.insert("stockInsertMapper.insertRefundMaster", refundMap);
            } else if (CommonConst.PAYEMNT_TYPE_REGULAR.equals(refundMap.getString("PAYMENT_TYPE"))) {
                LDataMap passBookMap = new LDataMap();
                passBookMap.put("xrtInvcSno", refundMap.getString("XRT_INVC_SNO"));
                passBookMap.put("productNm", "물품배송비");
                passBookMap.put("cancelYn", "Y");
                PassBookMasterVO passBookMasterVO = (PassBookMasterVO) dao.selectOne("passBookMapper.getPassBookMaster", passBookMap);

                if (passBookMasterVO != null) {
                    passBookMap.put("ordNo", passBookMasterVO.getOrdNo());
                    passBookMap.put("clientIp", ClientInfo.getClntIP());
                    passBookMap.put("usercd", LoginInfo.getUsercd());

                    passBookMap.put("cancelPrice", refundMap.getString("XRT_SHIPPING_PRICE"));
                    passBookBiz.setPayCancel(passBookMap);
                }

            }
            // payment_master delete
            dao.delete("stockInsertMapper.deletePaymentMst", paramMap);
        }

        for (LDataMap orderMap : shippoList) {

            if (!tmpEnation.toUpperCase().equals("US")) {
                break;
            }

            switch (tmpShipMethodCd) {
                case CommonConst.SHIP_METHOD_PREMIUM:
                    delInvcSnoYn = "Y";
                    break;
                case CommonConst.SHIP_METHOD_DHL:
                    break;
                default:
                    break;
            }

            List<String> westStates = getWestStates();
            List<String> eastStates = getEastStates();
            double wgt = Double.parseDouble(orderMap.getString("wgt"));
            String upddatetime = orderMap.getString("upddatetime");
            String state = "";
            shippoId = orderMap.getString("shippoId");
            apiInvcSno = orderMap.getString("invcSno1");
            shipMethodCd = orderMap.getString("shipMethodCd").toUpperCase();
            int getDate = Integer.parseInt(upddatetime.trim());

            if (orderMap.getString("eNation").equals("US") && shipMethodCd.equals("PREMIUM") && !shippoId.equals("")) {
                BigDecimal bAmount = (BigDecimal) orderMap.get("amount");
                amount = bAmount.toPlainString();
                String recvState = orderMap.getString("recvState").toUpperCase();
                String apiKey = "";
                if (eastStates.contains(recvState)) {
                    state = "east";
                }

                if (westStates.contains(recvState)) {
                    state = "west";
                }

                if ("east".equals(state)) {
                    logger.debug("debugtype.equals(\"DEV\") : " + debugtype.equals("DEV"));
                    if (debugtype.equals("DEV")) {
                        apiKey = devShippoEastApiKey;
                    } else {
                        apiKey = realShippoEastApiKey;
                    }

                } else {
                    logger.debug("debugtype.equals(\"DEV\") : " + debugtype.equals("DEV"));
                    if (debugtype.equals("DEV")) {
                        apiKey = devShippoWestApiyKey;
                    } else {
                        apiKey = realShippoWestApiyKey;
                    }
                }

                /**
                 * 나중에 해당 부분 원복해야함
                 */
                if (wgt <= 0.3685 && getDate >= 20200402) {
                    if (debugtype.equals("DEV")) {
                        apiKey = devShippoWestApiyKey;
                    } else {
                        apiKey = realShippoWestApiyKey;
                    }
                }

                if (getDate > 20201220) {
                    if (debugtype.equals("DEV")) {
                        apiKey = devShippoWestApiyKey;
                    } else {
                        apiKey = realShippoWestApiyKey;
                    }
                }

                logger.debug("ShippoAPI Start");
                String transaction = orderMap.getString("shippoId");
                ShippoAPI shippoAPI = new ShippoAPI();
                shippoAPI.refund(apiKey, transaction);
            }
        }

        LDataMap retParam = new LDataMap();
        retParam.put("SCNT", scnt);
        return retParam;
    }

    // 취소
    public LDataMap setPmCancel(LDataMap paramMap) throws Exception {

        if (paramMap == null) {
            throw new LingoException("변경된 항목이 없습니다.");
        }

        // api송장번호 취득
        LDataMap reSelect = (LDataMap) dao.selectOne("stockInsertMapper.getAmount", paramMap);
        String invcSno = reSelect.getString("INVC_SNO1");
        String amount = "";
        paramMap.put("invcSno1", invcSno);

        // 환불정보 취득
        LDataMap refundMap = (LDataMap) dao.selectOne("stockInsertMapper.getRefundInfo", paramMap);
        refundMap.put("LOGIN_USERCD", LoginInfo.getUsercd());
        refundMap.put("LOGIN_IP", ClientInfo.getClntIP());

        paramMap.put("STATUS_CD", CommonConst.ORD_STATUS_CD_ORDER_APPLY);
        int scnt = dao.update("stockInsertMapper.updateTorderMstStockCancle", paramMap);

        // TSOTCK_HISTORY INSERT
        if (scnt > 0) {
            paramMap.put("API_INVC_SNO", invcSno);
            paramMap.put("ETC2", amount);
            paramMap.put("EVENT_CD", CommonConst.EVENT_PAYMENT_CANCEL);
            paramMap.put("STATUS_CD", CommonConst.ORD_STATUS_CD_DEPOSIT_CANCEL);

            // history insert
            dao.insert("stockInsertMapper.insertStockHis", paramMap);
            // refund_master insert - 입고상태가 입금완료(21)인 경우만 insert
            if (refundMap.getString("STATUS_CD").equals(CommonConst.ORD_STATUS_CD_PAYMENT_COMP)) {
                dao.insert("stockInsertMapper.insertRefundMaster", refundMap);
            }
            dao.delete("stockInsertMapper.deletePaymentMst", paramMap);
        }

        LDataMap retParam = new LDataMap();
        retParam.put("SCNT", scnt);
        return retParam;
    }

    public LDataMap createShipmentData(LDataMap paramMap) throws Exception {

        List<String> westStates = getWestStates();
        List<String> eastStates = getEastStates();
        String recvState = paramMap.getString("recvState").toUpperCase().trim();
        String state = "";
        String sWgt = paramMap.getString("wgt");

        if (recvState.equals("")) {
            throw new LingoException("주 정보가 없습니다.");
        }
        if (eastStates.contains(recvState)) {
            state = "east";
        }
        if (westStates.contains(recvState)) {
            state = "west";
        }
        Map<String, Object> fromAddressMap = new HashMap<String, Object>();
        fromAddressMap.put("name", "logifocus");
        fromAddressMap.put("company", "logifocus");
        fromAddressMap.put("country", "US");

        /**
         * 2020-12-21 wn.kim 수정 김포센터에서 최호성 대리가 요청 다 웨스트로 실행
         */
        // if ("east".equals(state)) {
        //
        // logger.debug("debugtype.equals(\"DEV\") : " +
        // debugtype.equals("DEV"));
        // logger.debug("dWgt > 0.3685 :" + (dWgt > 0.3685));
        // logger.debug("dWgt <= 0.3685 :" + (dWgt <= 0.3685));
        // if (dWgt <= 0.3685) {
        // if (debugtype.equals("DEV")) {
        // apiKey = devShippoWestApiyKey;
        // } else {
        // apiKey = realShippoWestApiyKey;
        // }
        //
        // fromAddressMap.put("street1", "361 E Jefferson Blvd");
        // fromAddressMap.put("city", "Los Angeles");
        // fromAddressMap.put("state", "CA");
        // fromAddressMap.put("zip", "90011");
        // fromAddressMap.put("phone", "+1 323-235-5000");
        // fromAddressMap.put("email", "jay.chang@logifocus.co.kr");
        // } else {
        // if (debugtype.equals("DEV")) {
        // apiKey = devShippoEastApiKey;
        // } else {
        // apiKey = realShippoEastApiKey;
        // }
        // fromAddressMap.put("street1", "207 REDNECK AVENUE");
        // fromAddressMap.put("city", "LITTLE FERRY");
        // fromAddressMap.put("state", "NJ");
        // fromAddressMap.put("zip", "07643");
        // fromAddressMap.put("phone", "+1 201-440-2972");
        // fromAddressMap.put("email", "sjlee@logifocus.co.kr");
        //
        // massUnit = "lb";
        // Double lbWgt = dWgt / 0.45359237;
        // parcelWgt = String.format("%.4f", lbWgt);
        // }
        //
        // } else {
        //
        // logger.debug("debugtype.equals(\"DEV\") : " +
        // debugtype.equals("DEV"));
        // if (debugtype.equals("DEV")) {
        // apiKey = devShippoWestApiyKey;
        // } else {
        // apiKey = realShippoWestApiyKey;
        // }
        //
        // fromAddressMap.put("street1", "361 E Jefferson Blvd");
        // fromAddressMap.put("city", "Los Angeles");
        // fromAddressMap.put("state", "CA");
        // fromAddressMap.put("zip", "90011");
        // fromAddressMap.put("phone", "+1 323-235-5000");
        // fromAddressMap.put("email", "jay.chang@logifocus.co.kr");
        // }

        // debugtype.equals("DEV"));
        String apiKey = "";
        if (debugtype.equals("DEV")) {
            apiKey = devShippoWestApiyKey;
        } else {
            apiKey = realShippoWestApiyKey;
        }

        // 배대지 주소 변경

        /*
         * fromAddressMap.put("street1", "361 E Jefferson Blvd");
         * fromAddressMap.put("city", "Los Angeles");
         * fromAddressMap.put("state", "CA"); fromAddressMap.put("zip",
         * "90011"); fromAddressMap.put("phone", "+1 323-235-5000");
         * fromAddressMap.put("email", "kh.kim@logifocus.co.kr");
         */

        fromAddressMap.put("street1", "4422 E. Airport Dr. Unit C");
        fromAddressMap.put("city", "Ontario");
        fromAddressMap.put("state", "CA");
        fromAddressMap.put("zip", "91761");
        fromAddressMap.put("phone", "+1 909-552-6091");
        fromAddressMap.put("email", "kh.kim@logifocus.co.kr");

        Map<String, Object> toAddressMap = new HashMap<String, Object>();
        toAddressMap.put("name", paramMap.getString("recvName"));
        toAddressMap.put("company", "");
        toAddressMap.put("street1", paramMap.getString("recvAddr1"));
        toAddressMap.put("city", paramMap.getString("recvCity"));
        toAddressMap.put("state", recvState);
        toAddressMap.put("zip", paramMap.getString("recvPost"));
        toAddressMap.put("country", "US");
        toAddressMap.put("email", "");
        toAddressMap.put("phone", paramMap.getString("recvTel"));

        List<Map<String, Object>> parcels = new ArrayList<>();
        Map<String, Object> parcel = new HashMap<>();
        parcel.put("length", paramMap.getString("length"));
        parcel.put("width", paramMap.getString("width"));
        parcel.put("height", paramMap.getString("height"));
        parcel.put("distance_unit", "cm");
        parcel.put("weight", sWgt);
        parcel.put("mass_unit", "kg");
        parcels.add(parcel);

        logger.debug("ShippoAPI Start");
        ShippoAPI shippoAPI = new ShippoAPI();
        LDataMap retMap = shippoAPI.shipment(apiKey, toAddressMap, fromAddressMap, parcels);
        return retMap;
    }

    /**
     * AfterShip Tracking API
     *
     * @return
     * @throws Exception
     */
    public Map<String, Object> addAfterShipTrackings(LDataMap paramMap) throws Exception {

        Map<String, Object> retMap = new HashMap<>();
        List<LDataMap> orders = dao.selectList("AfterShipMapper.getOrderData", paramMap);

        for (int i = 0; i < orders.size(); i++) {
            AfterShipTrackingVo trackingVo = new AfterShipTrackingVo();
            trackingVo.setSlug("usps");
            trackingVo.setTrackingNumber(paramMap.getString("trackingNumber"));
            trackingVo.setTitle("");

            List<String> emails = new ArrayList<>();
            emails.add("xroute@logifocus.co.kr");
            trackingVo.setEmails(emails);
            trackingVo.setOrderId(orders.get(i).getString("ordNo"));
            trackingVo.setOrderIdPath("");
            Map<String, Object> customFileds = new HashMap<>();
            customFileds.put("productName", orders.get(i).getString("goodsNm"));
            customFileds.put("productPrice", orders.get(i).getString("price"));

            trackingVo.setCustomFields(customFileds);
            trackingVo.setLanguage("en");
            trackingVo.setOrderPromisedDeliveryDate("");
            trackingVo.setDeliveryType("pickup_at_courier");
            trackingVo.setPickupLocation(orders.get(i).getString("eNation").toUpperCase());
            trackingVo.setPickupNote("");

            retMap = afterShipAPI.createTrackings(trackingVo);
        }

        return retMap;
    }

    List<String> getWestStates() {

        List<String> retList = new ArrayList<>();
        retList.add("WA");
        retList.add("OR");
        retList.add("CA");
        retList.add("NV");
        retList.add("ID");
        retList.add("MT");
        retList.add("WY");
        retList.add("UT");
        retList.add("AZ");
        retList.add("CO");
        retList.add("NM");
        retList.add("ND");
        retList.add("SD");
        retList.add("NE");
        retList.add("KS");
        retList.add("OK");
        retList.add("TX");
        retList.add("AK");
        retList.add("HI");

        return retList;
    }

    List<String> getEastStates() {

        List<String> retList = new ArrayList<>();
        retList.add("ME");
        retList.add("NH");
        retList.add("VT");
        retList.add("MA");
        retList.add("RI");
        retList.add("CT");
        retList.add("NJ");
        retList.add("DE");
        retList.add("MD");
        retList.add("NY");
        retList.add("PA");
        retList.add("DC");
        retList.add("VA");
        retList.add("WV");
        retList.add("OH");
        retList.add("MI");
        retList.add("IN");
        retList.add("WI");
        retList.add("MN");
        retList.add("IA");
        retList.add("MO");
        retList.add("AR");
        retList.add("LA");
        retList.add("MS");
        retList.add("TN");
        retList.add("IL");
        retList.add("KY");
        retList.add("AL");
        retList.add("GA");
        retList.add("FL");
        retList.add("SC");
        retList.add("NC");
        retList.add("DC");

        return retList;
    }

    public LDataMap setPaymentMst(LDataMap paramMap) throws Exception {
        paramMap.put("LOGIN_USERCD", LoginInfo.getUsercd());
        paramMap.put("LOGIN_IP", ClientInfo.getClntIP());
        int scnt = dao.insert("stockInsertMapper.insertPaymentMst", paramMap);
        LDataMap retParam = new LDataMap();
        if (scnt == 1) {
            retParam.put("SCNT", scnt);
        } else {
            throw new LingoException("처리과정에 문제가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
        }
        return retParam;
    }
}
