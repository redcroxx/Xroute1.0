package xrt.fulfillment.order.manual.ebay;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.fulfillment.interfaces.vo.TOrderDtlVo;
import xrt.fulfillment.interfaces.vo.TOrderVo;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class EbayUploadBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(EbayUploadBiz.class);

    /**
     * 양식명 select box
     * 
     * @param param
     * @return
     * @throws Exception
     */
    public List<LDataMap> getSiteCd(LDataMap param) throws Exception {
        return dao.select("EbayUploadMapper.getSiteCd", param);
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
        String compcd = paramMap.getString("compcd");
        String orgcd = paramMap.getString("orgcd");
        String orgnm = paramMap.getString("orgnm");
        String whcd = paramMap.getString("whcd");
        String shipMethod = paramMap.getString("shipMethod");
        String fileYmd = paramMap.getString("fileYmd");
        String siteCd = paramMap.getString("siteCd");
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

        logger.debug("3. 이베이 주문 목록 검증");
        logger.debug("dataList.size : " + dataList.size());
        List<String> usStateList = dao.selectList("EbayUploadMapper.getUsStateList", paramMap);
        List<EbayVo> orderList = new ArrayList<EbayVo>();
        logger.debug("for start");
        int fileSeq = (Integer) dao.selectOne("EbayUploadMapper.getTorderFileSeq", paramMap) + 1;
        for (int i = 0; i < dataList.size(); i++) {
            EbayVo ebayVo = new EbayVo();
            String country = dataList.get(i).getString("shipToCountry").toUpperCase().trim();
            String state = dataList.get(i).getString("shipToState").trim().toUpperCase();

            if (!country.equals("UNITED STATES") && !country.equals("US")) {
                throw new LingoException("현재는 미국만 가능합니다.");
            } else {
                ebayVo.setShipToCountry("US");
            }

            if (country.equals("UNITED STATES")) {
                if (state.equals("")) {
                    throw new LingoException("shipToState가없습니다.");
                } else {
                    if (usStateList.contains(state)) {
                        ebayVo.setShipToState(state);
                    } else {
                        throw new LingoException("등록되지 않은 주입니다.");
                    }
                }

                if (dataList.get(i).getString("shipToCity").equals("")) {
                    throw new LingoException("shipToCity가없습니다.");
                } else {
                    ebayVo.setShipToCity(dataList.get(i).getString("shipToCity"));
                }
            } else {
                ebayVo.setShipToCity(dataList.get(i).getString("shipToCity"));
            }

            if (dataList.get(i).getString("shipToZip").equals("")) {
                throw new LingoException("shipToZip가없습니다.");
            } else {
                ebayVo.setShipToZip(dataList.get(i).getString("shipToZip"));
            }

            if (dataList.get(i).getString("totalPrice").equals("")) {
                throw new LingoException("totalPrice가없습니다.");
            } else {
                ebayVo.setTotalPrice(dataList.get(i).getString("totalPrice"));
            }

            if (dataList.get(i).getString("orderNumber").equals("")) {
                throw new LingoException("orderNumber가없습니다.");
            } else {
                ebayVo.setOrderNumber(dataList.get(i).getString("orderNumber"));
            }

            if (dataList.get(i).getString("itemNumber").equals("")) {
                throw new LingoException("itemNumber가없습니다.");
            } else {
                ebayVo.setItemNumber(dataList.get(i).getString("itemNumber"));
            }

            if (dataList.get(i).getString("shipToPhone").equals("")) {
                throw new LingoException("shipToPhone가없습니다.");
            } else {
                ebayVo.setShipToPhone(dataList.get(i).getString("shipToPhone"));
            }

            if (dataList.get(i).getString("itemTitle").equals("")) {
                throw new LingoException("itemTitle가없습니다.");
            } else {
                ebayVo.setItemTitle(dataList.get(i).getString("itemTitle"));
            }

            if (dataList.get(i).getString("quantity").equals("")) {
                throw new LingoException("quantity가없습니다.");
            } else {
                ebayVo.setQuantity(dataList.get(i).getString("quantity"));
            }

            if (dataList.get(i).getString("shipToName").equals("")) {
                throw new LingoException("shipToName가없습니다.");
            } else {
                ebayVo.setShipToName(dataList.get(i).getString("shipToName"));
            }

            if (dataList.get(i).getString("shipToAddress1").equals("")) {
                throw new LingoException("shipAddress1가없습니다.");
            } else {
                ebayVo.setShipToAddress1(dataList.get(i).getString("shipToAddress1"));
                ebayVo.setShipToAddress2(dataList.get(i).getString("shipToAddress2"));
            }

            DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String saleDate = "";
            String paidOnDate = "";
            String shipByDate = "";
            String minimumEstimatedDeliveryDate = "";
            String maximumEstimatedDeliveryDate = "";
            String shippedOnDate = "";

            if (!dataList.get(i).getString("saleDate").equals("")) {
                Date dSaleDate = dateFormat.parse(dataList.get(i).getString("saleDate"));
                logger.debug("dSaleDate : " + dSaleDate);
                saleDate = formatter.format(dSaleDate);
            }
            if (!dataList.get(i).getString("paidOnDate").equals("")) {
                Date dPaidOnDate = dateFormat.parse(dataList.get(i).getString("paidOnDate"));
                logger.debug("dPaidOnDate : " + dPaidOnDate);
                paidOnDate = formatter.format(dPaidOnDate);
            }
            if (!dataList.get(i).getString("shipByDate").equals("")) {
                Date dShipByDate = dateFormat.parse(dataList.get(i).getString("shipByDate"));
                shipByDate = formatter.format(dShipByDate);
            }
            if (!dataList.get(i).getString("minimumEstimatedDeliveryDate").equals("")) {
                Date dMinimumEstimatedDeliveryDate = dateFormat.parse(dataList.get(i).getString("minimumEstimatedDeliveryDate"));
                minimumEstimatedDeliveryDate = formatter.format(dMinimumEstimatedDeliveryDate);
            }
            if (!dataList.get(i).getString("maximumEstimatedDeliveryDate").equals("")) {
                Date dMaximumEstimatedDeliveryDate = dateFormat.parse(dataList.get(i).getString("maximumEstimatedDeliveryDate"));
                maximumEstimatedDeliveryDate = formatter.format(dMaximumEstimatedDeliveryDate);
            }
            if (!dataList.get(i).getString("shippedOnDate").equals("")) {
                Date dShippedOnDate = dateFormat.parse(dataList.get(i).getString("shippedOnDate"));
                shippedOnDate = formatter.format(dShippedOnDate);
            }

            ebayVo.setCompcd(compcd);
            ebayVo.setOrgcd(orgcd);
            ebayVo.setWhcd(whcd);
            ebayVo.setFileYmd(fileYmd);
            ebayVo.setFileSeq(fileSeq);
            ebayVo.setSaleDate(saleDate);
            ebayVo.setPaidOnDate(paidOnDate);
            ebayVo.setShipByDate(shipByDate);
            ebayVo.setSalesRecordNumber(dataList.get(i).getString("salesRecordNumber"));
            ebayVo.setMinimumEstimatedDeliveryDate(minimumEstimatedDeliveryDate);
            ebayVo.setMaximumEstimatedDeliveryDate(maximumEstimatedDeliveryDate);
            ebayVo.setShippedOnDate(shippedOnDate);
            ebayVo.setBuyerEmail(dataList.get(i).getString("buyerEmail"));
            ebayVo.setBuyerName(dataList.get(i).getString("buyerName"));
            ebayVo.setBuyerUsername(dataList.get(i).getString("buyerUsername"));
            ebayVo.setBuyerNote(dataList.get(i).getString("buyerNote"));
            ebayVo.setBuyerAddress1(dataList.get(i).getString("buyerAddress1"));
            ebayVo.setBuyerAddress2(dataList.get(i).getString("buyerAddress1"));
            ebayVo.setBuyerCity(dataList.get(i).getString("buyerCity"));
            ebayVo.setBuyerState(dataList.get(i).getString("buyerState"));
            ebayVo.setBuyerZip(dataList.get(i).getString("buyerZip"));
            ebayVo.setBuyerCountry(dataList.get(i).getString("buyerCountry"));
            ebayVo.setCustomLabel(dataList.get(i).getString("customLabel"));
            ebayVo.setSoldViaPromotedListings(dataList.get(i).getString("soldViaPromotedListings"));
            ebayVo.setSoldFor(dataList.get(i).getString("soldFor"));
            ebayVo.setShippingAndHandling(dataList.get(i).getString("shippingAndHandling"));
            ebayVo.setSellerCollectedTax(dataList.get(i).getString("sellerCollectedTax"));
            ebayVo.seteBayCollectedTax(dataList.get(i).getString("eBayCollectedTax"));
            ebayVo.setElectronicWasteRecyclingFee(dataList.get(i).getString("electronicWasteRecyclingFee"));
            ebayVo.setMattressRecyclingFee(dataList.get(i).getString("mattressRecyclingFee"));
            ebayVo.setAdditionalFee(dataList.get(i).getString("additionalFee"));
            ebayVo.setTotalPrice(dataList.get(i).getString("totalPrice").replace("$", ""));
            ebayVo.seteBayCollectedTaxAndFeesIncludedInTotal(dataList.get(i).getString("eBayCollectedTaxAndFeesIncludedInTotal"));
            ebayVo.setPaymentMethod(dataList.get(i).getString("paymentMethod"));
            ebayVo.setFeedbackLeft(dataList.get(i).getString("feedbackLeft"));
            ebayVo.setFeedbackReceived(dataList.get(i).getString("feedbackReceived"));
            ebayVo.setMyItemNote(dataList.get(i).getString("myItemNote"));
            ebayVo.setPayPalTransactionId(dataList.get(i).getString("payPalTransactionId"));
            ebayVo.setShippingService(dataList.get(i).getString("shippingService"));
            ebayVo.setTrackingNumber(dataList.get(i).getString("trackingNumber"));
            ebayVo.setTransactionId(dataList.get(i).getString("transactionId"));
            ebayVo.setGlobalShippingProgram(dataList.get(i).getString("globalShippingProgram"));
            ebayVo.setGlobalShippingReferenceId(dataList.get(i).getString("globalShippingReferenceId"));
            ebayVo.setClickAndCollect(dataList.get(i).getString("clickAndCollect"));
            ebayVo.setClickAndCollectReferenceNumber(dataList.get(i).getString("clickAndCollectReferenceNumber"));
            ebayVo.seteBayPlus(dataList.get(i).getString("eBayPlus"));
            ebayVo.setAddusercd(userCd);
            ebayVo.setUpdusercd(userCd);
            ebayVo.setTerminalcd(loginIp);

            orderList.add(ebayVo);
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
    public void orderEbayInsert(List<EbayVo> orderList) throws Exception {
        logger.debug("[orderEbayInsert] orderList : " + orderList.toString());

        for (EbayVo ebayVo : orderList) {
            logger.debug("01. 등록되어 있는 주문정보 인지확인.");
            List<EbayVo> listCount = dao.selectList("EbayUploadMapper.getInsertCheck", ebayVo);

            if (listCount.size() > 0) {
                throw new LingoException("이미 등록되어 있는 정보입니다..");
            }

            dao.insert("EbayUploadMapper.insertOrderEbay", ebayVo);
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
    public LDataMap processing(Map<String, Object> paramMap, List<EbayVo> orderList) throws Exception {
        logger.debug("[processing] paramMap : " + paramMap + ", orderList : " + orderList.toString());

        LDataMap sellerMap = (LDataMap) dao.selectOne("EbayUploadMapper.getSeller", paramMap);

        int relayCount = ((Integer) dao.selectOne("EbayUploadMapper.getTorderRelaySeq", paramMap)) + 1;
        int fileRelayCount = 1;

        List<TOrderVo> torderList = new ArrayList<>();
        for (EbayVo ebayVo : orderList) {
            String addrDtl;
            if (ebayVo.getShipToAddress2().equals("")) {
                addrDtl = ".";
            } else {
                addrDtl = ebayVo.getShipToAddress2();
            }
            String recvTel = ebayVo.getShipToPhone();
            String currency = "USD";
            String paymenyType = paramMap.get("paymentType") + "";

            TOrderVo torderVo = new TOrderVo();
            torderVo.setCompcd(ebayVo.getCompcd());
            torderVo.setOrgcd(ebayVo.getOrgcd());
            torderVo.setWhcd(ebayVo.getWhcd());
            torderVo.setUploadDate(ebayVo.getFileYmd());
            torderVo.setFileSeq(ebayVo.getFileSeq() + "");
            torderVo.setFileNm(ebayVo.getFileSeq() + "차");
            torderVo.setFileNmReal("Ebay order upload");
            torderVo.setSiteCd("30112");
            torderVo.setStatusCd("10");
            torderVo.setStockType("1");
            torderVo.setMallNm(sellerMap.getString("NAME"));
            torderVo.setShipMethodCd(paramMap.get("shipMethod") + "");
            torderVo.setOrdNo(ebayVo.getOrderNumber());
            torderVo.setCartNo(ebayVo.getSalesRecordNumber());
            torderVo.setOrdCnt("1");
            torderVo.setsNation("KR");
            torderVo.seteNation(ebayVo.getShipToCountry());
            torderVo.setShipName(sellerMap.getString("COMPANY_EN"));
            torderVo.setShipTel(sellerMap.getString("TEL1"));
            torderVo.setShipMobile(sellerMap.getString("TEL2"));
            torderVo.setShipAddr(sellerMap.getString("ENG_ADDR"));
            torderVo.setShipPost(sellerMap.getString("POST"));
            torderVo.setRecvName(ebayVo.getShipToName());
            torderVo.setRecvTel(recvTel);
            torderVo.setRecvMobile(recvTel);
            torderVo.setRecvAddr1(ebayVo.getShipToAddress1());
            torderVo.setRecvAddr2(addrDtl);
            torderVo.setRecvCity(ebayVo.getShipToCity());
            torderVo.setRecvState(ebayVo.getShipToState());
            torderVo.setRecvPost(ebayVo.getShipToZip());
            torderVo.setRecvNation(ebayVo.getShipToCountry());
            torderVo.setRecvCurrency(currency);
            torderVo.setTotPaymentPrice(ebayVo.getTotalPrice());
            torderVo.setAddusercd(ebayVo.getAddusercd());
            torderVo.setUpdusercd(ebayVo.getUpdusercd());
            torderVo.setTerminalcd(ebayVo.getTerminalcd());
            torderVo.setRelaySeq(relayCount);
            torderVo.setFileRelaySeq(fileRelayCount);
            torderVo.setPaymentType(paymenyType);
            logger.debug("EbayUploadMapper.insertTorder");
            dao.insert("EbayUploadMapper.insertTorder", torderVo);

            Long itemCount = 1L;
            TOrderDtlVo tOrderDtlVo = new TOrderDtlVo();
            tOrderDtlVo.setOrdCd(torderVo.getOrdCd());
            tOrderDtlVo.setOrdSeq(itemCount);
            tOrderDtlVo.setCompcd(ebayVo.getCompcd());
            tOrderDtlVo.setOrgcd(ebayVo.getOrgcd());
            tOrderDtlVo.setGoodsCd(ebayVo.getItemNumber());
            tOrderDtlVo.setGoodsNm(ebayVo.getItemTitle());
            tOrderDtlVo.setGoodsOption(ebayVo.getVariationDetails());
            tOrderDtlVo.setGoodsCnt(ebayVo.getQuantity());
            tOrderDtlVo.setPaymentPrice(ebayVo.getTotalPrice());
            tOrderDtlVo.setAddusercd(ebayVo.getAddusercd());
            tOrderDtlVo.setUpdusercd(ebayVo.getUpdusercd());
            tOrderDtlVo.setOrdNo(ebayVo.getOrderNumber());
            tOrderDtlVo.setTerminalcd(ebayVo.getTerminalcd());
            logger.debug("EbayUploadMapper.insertTOrderDtl");
            dao.insert("EbayUploadMapper.insertTOrderDtl", tOrderDtlVo);
            relayCount++;
            fileRelayCount++;
            logger.debug("EbayUploadMapper.updateOrderEbay");
            dao.update("EbayUploadMapper.updateOrderEbay", ebayVo);
            torderList.add(torderVo);
            Thread.sleep(100);
        }

        LDataMap retMap = new LDataMap();
        retMap.put("CODE", "1");
        retMap.put("MESSAGE", "성공하였습니다.");
        return retMap;
    }
}