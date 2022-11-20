package xrt.fulfillment.order.orderAmazon;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.CommonConst;
import xrt.fulfillment.interfaces.vo.TOrderDtlVo;
import xrt.fulfillment.interfaces.vo.TOrderVo;
import xrt.interfaces.qxpress.QxpressAPI;
import xrt.interfaces.qxpress.vo.QxpressVo;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

/**
 * 아마존 오더등록biz
 *
 * @author wn.kim
 *
 */
@Service
public class OrderAmazonBiz extends DefaultBiz {

    @Resource
    QxpressAPI qxpress;

    Logger logger = LoggerFactory.getLogger(OrderAmazonBiz.class);

    /**
     * 양식명 select box
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<LDataMap> getSiteCd(LDataMap param) throws Exception {
        return dao.select("OrderAmazonMapper.getSiteCd", param);
    }

    /**
     * 공통 파라메터 검증
     * 
     * @param paramMap
     * @param dataList
     * @return
     * @throws Exception
     */
    public LDataMap valid(LDataMap paramMap, List<LDataMap> dataList) throws Exception {
        logger.debug("[valid] paramMap : " + paramMap + ", dataList : " + dataList.toString());

        logger.debug("1. 공통파라메터 변수 지정");
        String compcd = paramMap.getString("amazonCompcd");
        String orgcd = paramMap.getString("amazonOrgcd");
        String orgnm = paramMap.getString("amazonOrgnm");
        String whcd = paramMap.getString("amazonWhcd");
        String shipMethod = paramMap.getString("shipMethod");
        String fileYmd = paramMap.getString("amazonFileYmd");
        String siteCd = paramMap.getString("amazonSiteCd");
        String userCd = paramMap.getString("LOGIN_USERCD");
        String loginIp = paramMap.getString("LOGIN_IP");
        String paymentType = paramMap.getString("LOGIN_PAYMENT_TPYE");

        logger.debug("2. 공통파라메터 null, 공백 검증");
        if (orgcd == null || "".equals(orgcd)) {
            throw new LingoException("셀러정보가 없습니다.");
        }
        if (whcd == null || "".equals(whcd)) {
            throw new LingoException("창고코드가 없습니다.");
        }
        if (shipMethod == null || "".equals(shipMethod)) {
            throw new LingoException("배송타입이 없습니다.");
        }
        if (fileYmd == null || "".equals(fileYmd)) {
            throw new LingoException("등록일자가 없습니다.");
        }
        if (userCd == null || "".equals(userCd)) {
            throw new LingoException("사용자 정보가 없습니다.");
        }

        logger.debug("3. 아마존 주문 목록 검증");
        logger.debug("dataList.size : " + dataList.size());
        List<String> usStateList = dao.selectList("OrderAmazonMapper.getUsStateList", paramMap);
        List<OrderAmazonVo> orderList = new ArrayList<OrderAmazonVo>();
        logger.debug("for start");
        int fileSeq = (Integer) dao.selectOne("OrderAmazonMapper.getTorderFileSeq", paramMap) + 1;
        for (int i = 0; i < dataList.size(); i++) {
            OrderAmazonVo orderAmazonVo = new OrderAmazonVo();
            String country;
            String state;

            if (dataList.get(i).getString("shipCountry").equals("")) {
                throw new LingoException("shipCountry가없습니다.");
            } else {
                country = dataList.get(i).getString("shipCountry").toUpperCase();
                orderAmazonVo.setShipCountry(country);
            }

            if (!country.equals("US") && !country.equals("JP")) {
                throw new LingoException("현재는 미국과 일본만 가능합니다.");
            }

            if (country.equals("US")) {
                if (dataList.get(i).getString("shipState").equals("")) {
                    throw new LingoException("shipState가없습니다.");
                } else {
                    state = dataList.get(i).getString("shipState").trim().toUpperCase();
                    if (usStateList.contains(state)) {
                        orderAmazonVo.setShipState(state);
                    } else {
                        throw new LingoException("등록되지 않은 주입니다.");
                    }
                }

                if (dataList.get(i).getString("shipCity").equals("")) {
                    throw new LingoException("shipCity가없습니다.");
                } else {
                    orderAmazonVo.setShipCity(dataList.get(i).getString("shipCity"));
                }
            } else {
                orderAmazonVo.setShipCity(dataList.get(i).getString("shipCity"));
            }

            if (dataList.get(i).getString("shipPostalCode").equals("")) {
                throw new LingoException("shipPostalCode가없습니다.");
            } else {
                orderAmazonVo.setShipPostalCode(dataList.get(i).getString("shipPostalCode"));
            }

            if (dataList.get(i).getString("itemPrice").equals("")) {
                throw new LingoException("itemPrice가없습니다.");
            } else {
                orderAmazonVo.setItemPrice(dataList.get(i).getString("itemPrice"));
            }

            if (dataList.get(i).getString("orderId").equals("")) {
                throw new LingoException("orderId가없습니다.");
            } else {
                orderAmazonVo.setOrderId(dataList.get(i).getString("orderId"));
            }

            if (dataList.get(i).getString("orderItemId").equals("")) {
                throw new LingoException("orderItemId가없습니다.");
            } else {
                orderAmazonVo.setOrderItemId(dataList.get(i).getString("orderItemId"));
            }

            if (dataList.get(i).getString("buyerPhoneNumber").equals("")) {
                throw new LingoException("buyerPhoneNumber가없습니다.");
            } else {
                orderAmazonVo.setBuyerPhoneNumber(dataList.get(i).getString("buyerPhoneNumber"));
            }

            if (dataList.get(i).getString("productName").equals("")) {
                throw new LingoException("productName가없습니다.");
            } else {
                orderAmazonVo.setProductName(dataList.get(i).getString("productName"));
            }

            if (dataList.get(i).getString("quantityPurchased").equals("")) {
                throw new LingoException("quantityPurchased가없습니다.");
            } else {
                orderAmazonVo.setQuantityPurchased(dataList.get(i).getString("quantityPurchased"));
            }

            if (dataList.get(i).getString("recipientName").equals("")) {
                throw new LingoException("recipientName가없습니다.");
            } else {
                orderAmazonVo.setRecipientName(dataList.get(i).getString("recipientName"));
            }

            if (dataList.get(i).getString("shipAddress1").equals("")) {
                throw new LingoException("shipAddress1가없습니다.");
            } else {
                orderAmazonVo.setShipAddress1(dataList.get(i).getString("shipAddress1"));
                orderAmazonVo.setShipAddress2(dataList.get(i).getString("shipAddress2"));
                orderAmazonVo.setShipAddress3(dataList.get(i).getString("shipAddress3"));
            }

            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            DateFormat yyyyMmdd = new SimpleDateFormat("yyyy-MM-dd");
            Date dPurchaseDate = new Date();
            Date dPaymentsDate = new Date();
            Date dReportingDate = new Date();
            Date dPromiseDate = new Date();
            String sPurchaseDate = dataList.get(i).getString("purchaseDate");
            String sPaymentsDate = dataList.get(i).getString("paymentsDate");
            String sReportingDate = dataList.get(i).getString("reportingDate");
            String sPromiseDate = dataList.get(i).getString("promiseDate");
            String purchaseDate = "";
            String paymentsDate = "";
            String reportingDate = "";
            String promiseDate = "";

            if (!sPurchaseDate.equals("")) {
                if (sPurchaseDate.length() < 19) {
                    dPurchaseDate = yyyyMmdd.parse(sPurchaseDate.substring(0, 10));
                } else {
                    dPurchaseDate = dateFormat.parse(sPurchaseDate);
                }

                purchaseDate = formatter.format(dPurchaseDate);
            }
            if (!sPaymentsDate.equals("")) {
                if (sPaymentsDate.length() < 19) {
                    dPaymentsDate = yyyyMmdd.parse(sPaymentsDate.substring(0, 10));
                } else {
                    dPaymentsDate = dateFormat.parse(sPaymentsDate);
                }
                
                paymentsDate = formatter.format(dPaymentsDate);
            }
            if (!sReportingDate.equals("")) {
                if (sReportingDate.length() < 19) {
                    dReportingDate = yyyyMmdd.parse(sReportingDate.substring(0, 10));
                } else {
                    dReportingDate = dateFormat.parse(sReportingDate);
                }
                
                reportingDate = formatter.format(dReportingDate);
            }
            if (!sPromiseDate.equals("")) {
                if (sPromiseDate.length() < 19) {
                    dPurchaseDate = yyyyMmdd.parse(sPromiseDate.substring(0, 10));
                } else {
                    dPromiseDate = dateFormat.parse(sPromiseDate);
                }
                
                promiseDate = formatter.format(dPromiseDate);
            }

            orderAmazonVo.setCompcd(compcd);
            orderAmazonVo.setOrgcd(orgcd);
            orderAmazonVo.setWhcd(whcd);
            orderAmazonVo.setFileYmd(fileYmd);
            orderAmazonVo.setFileSeq(fileSeq);
            orderAmazonVo.setPurchaseDate(purchaseDate);
            orderAmazonVo.setPaymentsDate(paymentsDate);
            orderAmazonVo.setReportingDate(reportingDate);
            orderAmazonVo.setPromiseDate(promiseDate);
            orderAmazonVo.setDaysPastPromise(dataList.get(i).getString("daysPastPromise"));
            orderAmazonVo.setBuyerEmail(dataList.get(i).getString("buyerEmail"));
            orderAmazonVo.setBuyerName(dataList.get(i).getString("buyerName"));
            orderAmazonVo.setSku(dataList.get(i).getString("sku"));
            orderAmazonVo.setQuantityShipped(dataList.get(i).getString("quantityShipped"));
            orderAmazonVo.setQuantityToShip(dataList.get(i).getString("quantityToShip"));
            orderAmazonVo.setShipServiceLevel(dataList.get(i).getString("shipServiceLevel"));
            orderAmazonVo.setAddusercd(userCd);
            orderAmazonVo.setUpdusercd(userCd);
            orderAmazonVo.setTerminalcd(loginIp);

            orderList.add(orderAmazonVo);
            Thread.sleep(100);
        }

        logger.debug("4. 공통 데이터 설정");
        Map<String, Object> commMap = new HashMap<>();
        commMap.put("compcd", compcd);
        commMap.put("orgcd", orgcd);
        commMap.put("orgnm", orgnm);
        commMap.put("whcd", whcd);
        commMap.put("shipMethod", shipMethod);
        commMap.put("fileYmd", fileYmd);
        commMap.put("siteCd", siteCd);
        commMap.put("paymentType", paymentType);
        commMap.put("userCd", userCd);
        commMap.put("loginIp", loginIp);

        logger.debug("5. 반환값 지정");
        LDataMap retMap = new LDataMap();
        retMap.put("commMap", commMap);
        retMap.put("orderList", orderList);
        retMap.put("code", "200");
        retMap.put("message", "성공하였습니다.");
        return retMap;
    }

    /**
     * 아마존 오더 정보 저장
     * 
     * @param paramMap
     * @param orderList
     * @return
     * @throws Exception
     */
    public void amazonOrderInsert(List<OrderAmazonVo> orderList) throws Exception {
        logger.debug("[amazonOrderInsert] orderList : " + orderList.toString());

        for (OrderAmazonVo orderAmazonVo : orderList) {
            logger.debug("01. 등록되어 있는 주문정보 인지확인.");
            List<OrderAmazonVo> listCount = dao.selectList("OrderAmazonMapper.getInsertCheck", orderAmazonVo);

            if (listCount.size() > 0) {
                throw new LingoException("이미 등록되어 있는 정보입니다..");
            }

            dao.insert("OrderAmazonMapper.insertOrderAmazon", orderAmazonVo);
        }
    }

    /**
     * 공통 파라메터 및 아마존 Order List를 Torder, TorderDtl 맵핑함.
     * 
     * @param paramMap
     * @param orderList
     * @return
     * @throws Exception
     */
    public LDataMap processing(Map<String, Object> paramMap, List<OrderAmazonVo> orderList) throws Exception {
        logger.debug("[processing] paramMap : " + paramMap + ", orderList : " + orderList.toString());

        logger.debug("1. 셀러정보 조회");
        LDataMap sellerMap = (LDataMap) dao.selectOne("OrderAmazonMapper.getSeller", paramMap);
        int relayCount = ((Integer) dao.selectOne("OrderAmazonMapper.getTorderRelaySeq", paramMap)) + 1;
        int fileRelayCount = 1;

        logger.debug("2. 아마존 주문 정보 -> 엑스루트 정보 변환");
        List<TOrderVo> torderList = new ArrayList<>();
        for (OrderAmazonVo orderAmazonVo : orderList) {
            logger.debug("2-1. 주소2, 주소3 공백 확인");
            String addrDtl;
            if (orderAmazonVo.getShipAddress2().equals("")) {
                addrDtl = ". " + orderAmazonVo.getShipAddress3();
            } else {
                if (orderAmazonVo.getShipAddress3().trim().equals("")) {
                    addrDtl = orderAmazonVo.getShipAddress2();
                } else {
                    addrDtl = orderAmazonVo.getShipAddress2() + " " + orderAmazonVo.getShipAddress3();
                }
            }
            String buyerPhoneNumber = orderAmazonVo.getBuyerPhoneNumber();
            String[] recvTelA = buyerPhoneNumber.split(" ");
            String recvTel;
            String currency = orderAmazonVo.getShipCountry().equals("US") ? "USD" : "JPY";
            String paymentType = paramMap.get("paymentType") + "";

            if (recvTelA.length == 1) {
                recvTel = buyerPhoneNumber;
            } else {
                recvTel = recvTelA[0] + " " + recvTelA[1];
            }

            TOrderVo torderVo = new TOrderVo();
            torderVo.setCompcd(orderAmazonVo.getCompcd());
            torderVo.setOrgcd(orderAmazonVo.getOrgcd());
            torderVo.setWhcd(orderAmazonVo.getWhcd());
            torderVo.setUploadDate(orderAmazonVo.getFileYmd());
            torderVo.setFileSeq(orderAmazonVo.getFileSeq() + "");
            torderVo.setFileNm(orderAmazonVo.getFileSeq() + "차");
            torderVo.setFileNmReal("Amazon order upload");
            torderVo.setSiteCd("30112");
            torderVo.setStatusCd("10");
            torderVo.setStockType("1");
            torderVo.setMallNm(sellerMap.getString("NAME"));
            torderVo.setShipMethodCd(paramMap.get("shipMethod") + "");
            torderVo.setOrdNo(orderAmazonVo.getOrderId());
            torderVo.setCartNo(orderAmazonVo.getOrderId());
            torderVo.setOrdCnt("1");
            torderVo.setsNation("KR");
            torderVo.seteNation(orderAmazonVo.getShipCountry().trim());
            torderVo.setShipName(sellerMap.getString("COMPANY_EN"));
            torderVo.setShipTel(sellerMap.getString("TEL1"));
            torderVo.setShipMobile(sellerMap.getString("TEL2"));
            torderVo.setShipAddr(sellerMap.getString("ENG_ADDR"));
            torderVo.setShipPost(sellerMap.getString("POST"));
            torderVo.setRecvName(orderAmazonVo.getRecipientName());
            torderVo.setRecvTel(recvTel);
            torderVo.setRecvMobile(recvTel);
            torderVo.setRecvAddr1(orderAmazonVo.getShipAddress1());
            torderVo.setRecvAddr2(addrDtl);
            torderVo.setRecvCity(orderAmazonVo.getShipCity());
            torderVo.setRecvState(orderAmazonVo.getShipState());
            torderVo.setRecvPost(orderAmazonVo.getShipPostalCode());
            torderVo.setRecvNation(orderAmazonVo.getShipCountry());
            torderVo.setRecvCurrency(currency);
            torderVo.setTotPaymentPrice(orderAmazonVo.getItemPrice());
            torderVo.setAddusercd(orderAmazonVo.getAddusercd());
            torderVo.setUpdusercd(orderAmazonVo.getUpdusercd());
            torderVo.setTerminalcd(orderAmazonVo.getTerminalcd());
            torderVo.setRelaySeq(relayCount);
            torderVo.setFileRelaySeq(fileRelayCount);
            torderVo.setPaymentType(paymentType);
            logger.debug("OrderAmazonMapper.insertTorder");
            dao.insert("OrderAmazonMapper.insertTorder", torderVo);

            Long itemCount = 1L;
            TOrderDtlVo tOrderDtlVo = new TOrderDtlVo();
            tOrderDtlVo.setOrdCd(torderVo.getOrdCd());
            tOrderDtlVo.setOrdSeq(itemCount);
            tOrderDtlVo.setCompcd(orderAmazonVo.getCompcd());
            tOrderDtlVo.setOrgcd(orderAmazonVo.getOrgcd());
            tOrderDtlVo.setGoodsCd(orderAmazonVo.getOrderItemId());
            tOrderDtlVo.setGoodsNm(orderAmazonVo.getProductName());
            tOrderDtlVo.setGoodsOption("");
            tOrderDtlVo.setGoodsCnt(orderAmazonVo.getQuantityPurchased());
            tOrderDtlVo.setPaymentPrice(orderAmazonVo.getItemPrice());
            tOrderDtlVo.setAddusercd(orderAmazonVo.getAddusercd());
            tOrderDtlVo.setUpdusercd(orderAmazonVo.getUpdusercd());
            tOrderDtlVo.setOrdNo(orderAmazonVo.getOrderId());
            tOrderDtlVo.setTerminalcd(orderAmazonVo.getTerminalcd());
            logger.debug("OrderAmazonMapper.insertTOrderDtl");
            dao.insert("OrderAmazonMapper.insertTOrderDtl", tOrderDtlVo);
            relayCount++;
            fileRelayCount++;
            logger.debug("OrderAmazonMapper.updateOrderAmazon");
            dao.update("OrderAmazonMapper.updateOrderAmazon", orderAmazonVo);
            torderList.add(torderVo);
            Thread.sleep(100);
        }

        logger.debug("3. 국가 체크 후 기타 API 호출");
        for (TOrderVo tOrderVo : torderList) {
            String country = tOrderVo.geteNation().toUpperCase();
            String shipMethodCd = tOrderVo.getShipMethodCd().toUpperCase();

            switch (country) {
                case "JP":
                    if (shipMethodCd.equals("PREMIUM")) {
                        // qxpressProcessing(tOrderVo);
                    }
                    break;

                default:
                    break;
            }
        }

        LDataMap retMap = new LDataMap();
        retMap.put("CODE", "1");
        retMap.put("MESSAGE", "성공하였습니다.");
        return retMap;
    }

    /**
     * efs 배송데이터
     *
     * @param tOrder
     * @return
     * @throws Exception
     */
    public void qxpressProcessing(TOrderVo tOrderVo) throws Exception {
        logger.debug("[qxpressProcessing] TOrderVo : " + tOrderVo.toString());

        List<TOrderDtlVo> items = dao.selectList("OrderAmazonMapper.getOrderDtlList", tOrderVo);
        List<QxpressVo> qxpressList = new ArrayList<>();

        for (int i = 0; i < items.size(); i++) {

            String recvHpNo = tOrderVo.getRecvMobile();
            String recvTel = tOrderVo.getRecvTel();
            String zipcode = tOrderVo.getRecvPost();
            String countryCode = tOrderVo.geteNation().toUpperCase();

            // 홍콩일 경우 우편번호 999로 세팅. 최일규
            if (("HK".equals(countryCode) || "MA".equals(countryCode))) {
                zipcode = "";
            }

            QxpressVo qxpressVo = new QxpressVo();
            qxpressVo.setXrtInvcSno(tOrderVo.getXrtInvcSno());
            qxpressVo.setRcvnm(tOrderVo.getRecvName());
            qxpressVo.setHpNo((!recvHpNo.equals("") ? recvHpNo : recvTel));
            qxpressVo.setDelFrontaddress(tOrderVo.getRecvAddr1().replaceAll("#", "＃"));
            qxpressVo.setDelBackaddress(tOrderVo.getRecvAddr2().replaceAll("#", "＃"));

            logger.debug("getDelFrontaddress => " + qxpressVo.getDelFrontaddress());

            qxpressVo.setDpc3refno1(tOrderVo.getXrtInvcSno());
            qxpressVo.setTelNo(recvTel);
            qxpressVo.setZipCode(zipcode);
            qxpressVo.setBuyCustemail("");
            qxpressVo.setDeliveryNationcd(countryCode);
            qxpressVo.setDeliveryOptionCode("");
            qxpressVo.setSellCustnm(tOrderVo.getShipName());
            qxpressVo.setStartNationcd(tOrderVo.getsNation().toUpperCase());
            qxpressVo.setRemark("");
            qxpressVo.setItemNm(items.get(i).getGoodsNm());
            qxpressVo.setQty(items.get(i).getGoodsCnt());
            qxpressVo.setPurchasAmt(items.get(i).getPaymentPrice());
            qxpressVo.setCurrency(tOrderVo.getRecvCurrency());
            qxpressList.add(qxpressVo);
        }

        List<Map<String, Object>> errors = new ArrayList<>();
        List<Map<String, Object>> xrtInvcSnoList = new ArrayList();
        for (QxpressVo qxpressVo : qxpressList) {
            logger.debug("[qxpressRegData] qxpressVo : " + qxpressVo.toString());
            // TODO. 오류 처리 로직 추가해야함.
            Map<String, Object> retMap = qxpress.createOrder(qxpressVo);
            String code = (String) retMap.get("code");
            if (!code.equals("200")) {
                throw new LingoException(retMap.get("message").toString());
            }

            JSONArray resList = (JSONArray) retMap.get("data");

            for (int i = 0; i < resList.size(); i++) {
                Map<String, Object> updateMap = new HashMap<>();
                JSONObject jsonObject = (JSONObject) resList.get(i);
                logger.debug("[qxpressRegData] jsonObject : " + jsonObject.toString());
                JSONParser jsonParser = new JSONParser();
                Object oOrder = jsonParser.parse(jsonObject.get("Order").toString());
                JSONObject jOrder = (JSONObject) oOrder;

                // 성공한 경우
                logger.debug("[qxpressRegData] jOrder : " + jOrder.toString());
                if ("OK".equals(jOrder.get("RESULT__MSG").toString())) {
                    updateMap.put("xrtInvcSno", qxpressVo.getXrtInvcSno());
                    updateMap.put("invcSno2", jOrder.get("SHIPPING_NO").toString());
                    updateMap.put("localShipper", "");
                    updateMap.put("shippingCompany", "QXPRESS");

                    xrtInvcSnoList.add(updateMap);
                } else {
                    updateMap.put("xrtInvcSno", qxpressVo.getXrtInvcSno());
                    updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);
                }

                dao.update("OrderAmazonMapper.updateTorder", updateMap);
            }
        }
    }
}
