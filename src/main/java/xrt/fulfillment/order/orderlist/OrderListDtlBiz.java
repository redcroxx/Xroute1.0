package xrt.fulfillment.order.orderlist;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class OrderListDtlBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(OrderListDtlBiz.class);

    public List<LDataMap> getStatusCd(CommonSearchVo paramVO) throws Exception {
        return dao.select("OrderListDtlMapper.getStatusCd", paramVO);
    }

    public List<LDataMap> getOrderDtl(CommonSearchVo paramVO) throws Exception {
        return dao.select("OrderListDtlMapper.getOrderDtl", paramVO);
    }

    public List<LDataMap> getOrderItems(CommonSearchVo paramVO) throws Exception {
        return dao.select("OrderListDtlMapper.getOrderItems", paramVO);
    }

    public LDataMap process(UpdateOrderVo paramVO) throws Exception {

        LDataMap retMap = this.valid(paramVO);

        if (!retMap.getString("CODE").equals("1")) {
            return retMap;
        }

        logger.debug("retMap : " + retMap.toString());
        if (((UpdateOrderVo) retMap.get("map")).getXrtInvcSno() != null) {

            String paymentType = ((UpdateOrderVo) retMap.get("map")).getPaymentType();
            String mallNm = ((UpdateOrderVo) retMap.get("map")).getMallNm();
            String shipMethodCd = ((UpdateOrderVo) retMap.get("map")).getShipMethodCd();
            String shipName = ((UpdateOrderVo) retMap.get("map")).getShipName();
            String shipTel = ((UpdateOrderVo) retMap.get("map")).getShipTel();
            String recvName = ((UpdateOrderVo) retMap.get("map")).getRecvName();
            String recvTel = ((UpdateOrderVo) retMap.get("map")).getRecvTel();
            String recvCity = ((UpdateOrderVo) retMap.get("map")).getRecvCity();
            String recvState = ((UpdateOrderVo) retMap.get("map")).getRecvState() == null ? null : ((UpdateOrderVo) retMap.get("map")).getRecvState().trim();
            String recvPost = ((UpdateOrderVo) retMap.get("map")).getRecvPost() == null ? null : ((UpdateOrderVo) retMap.get("map")).getRecvPost().trim();
            String recvAddr1 = ((UpdateOrderVo) retMap.get("map")).getRecvAddr1();
            String recvAddr2 = ((UpdateOrderVo) retMap.get("map")).getRecvAddr2();
            String xrtInvcSno = ((UpdateOrderVo) retMap.get("map")).getXrtInvcSno();
            String totPaymentPrice = ((UpdateOrderVo) retMap.get("map")).getTotPaymentPrice();
            String purchaseUrl = ((UpdateOrderVo) retMap.get("map")).getPurchaseUrl();
            String statusCd = ((UpdateOrderVo) retMap.get("map")).getStatusCd();

            LDataMap orderMap = new LDataMap();
            orderMap.put("paymentType", paymentType);
            orderMap.put("mallNm", mallNm);
            orderMap.put("shipMethodCd", shipMethodCd);
            orderMap.put("shipName", shipName);
            orderMap.put("shipTel", shipTel);
            orderMap.put("recvName", recvName);
            orderMap.put("recvTel", recvTel);
            orderMap.put("recvCity", recvCity);
            orderMap.put("recvState", recvState);
            orderMap.put("recvPost", recvPost);
            orderMap.put("recvAddr1", recvAddr1);
            orderMap.put("recvAddr2", recvAddr2);
            orderMap.put("xrtInvcSno", xrtInvcSno);
            orderMap.put("totPaymentPrice", totPaymentPrice);
            orderMap.put("purchaseUrl", purchaseUrl);
            orderMap.put("statusCd", statusCd);
            orderMap.put("usercd", paramVO.getUpdusercd());
            dao.update("OrderListDtlMapper.updateTorder", orderMap);
        }

        List<UpdateOrderDtlVo> orderList = (List<UpdateOrderDtlVo>) retMap.get("list");

        for (UpdateOrderDtlVo orderDtlVo : orderList) {

            if (orderDtlVo.getOrdCd() != null) {
                LDataMap itemMap = new LDataMap();
                itemMap.put("goodsCd", orderDtlVo.getGoodsCd());
                itemMap.put("goodsNm", orderDtlVo.getGoodsNm());
                itemMap.put("goodsOption", orderDtlVo.getGoodsOption());
                itemMap.put("ordCd", orderDtlVo.getOrdCd());
                itemMap.put("ordSeq", orderDtlVo.getOrdSeq());
                itemMap.put("usercd", paramVO.getUpdusercd());

                dao.update("OrderListDtlMapper.updateTorderDtl", itemMap);
            }
        }

        return retMap;
    }

    public LDataMap valid(UpdateOrderVo paramVo) throws Exception {
        logger.debug("[valid] : " + paramVo.toString());
        // Pattern pattern = Pattern.compile("[!@#$%^&*(),.?\":{}|<>]");
        UpdateOrderVo orderVo = new UpdateOrderVo();
        
        orderVo.setXrtInvcSno(paramVo.getXrtInvcSno());
        
        if (!paramVo.getPrevPaymentType().equals(paramVo.getPaymentType())) {
            orderVo.setPaymentType(paramVo.getPaymentType());
        }
        
        if (!paramVo.getPrevMallNm().equals(paramVo.getMallNm())) {
            orderVo.setMallNm(paramVo.getMallNm());
        }
        
        if (!paramVo.getPrevShipMethodCd().equals(paramVo.getShipMethodCd())) {
            orderVo.setShipMethodCd(paramVo.getShipMethodCd());
        }
        
        if (!paramVo.getPrevShipName().equals(paramVo.getShipName())) {
            orderVo.setShipName(paramVo.getShipName());
        }
        
        if (!paramVo.getPrevShipTel().equals(paramVo.getShipTel())) {
            orderVo.setShipTel(paramVo.getShipTel());
        }
        
        if (!paramVo.getPrevRecvName().equals(paramVo.getRecvName())) {
            orderVo.setRecvName(paramVo.getRecvName());
        }
        
        if (!paramVo.getPrevRecvTel().equals(paramVo.getRecvTel())) {
            orderVo.setRecvTel(paramVo.getRecvTel());
        }
        
        if (!paramVo.getPrevRecvCity().equals(paramVo.getRecvCity())) {
            orderVo.setRecvCity(paramVo.getRecvCity());
        }

        if (!paramVo.getPrevRecvState().equals(paramVo.getRecvState().trim())) {
            orderVo.setRecvState(paramVo.getRecvState().trim());
        }

        if (!paramVo.getPrevRecvPost().equals(paramVo.getRecvPost())) {
            orderVo.setRecvPost(paramVo.getRecvPost());
        }

        if (!paramVo.getPrevRecvAddr1().equals(paramVo.getRecvAddr1())) {
            orderVo.setRecvAddr1(paramVo.getRecvAddr1());
        }

        if (!paramVo.getPrevRecvAddr2().equals(paramVo.getRecvAddr2())) {
            orderVo.setRecvAddr2(paramVo.getRecvAddr2());
        }

        if (!paramVo.getPrevStatusCd().equals(paramVo.getStatusCd())) {
            orderVo.setStatusCd(paramVo.getStatusCd());
        }
        
        if (!paramVo.getPrevTotPaymentPrice().equals(paramVo.getTotPaymentPrice())) {
            orderVo.setTotPaymentPrice(paramVo.getTotPaymentPrice());
        }
        
        if (!paramVo.getPrevPurchaseUrl().equals(paramVo.getPurchaseUrl())) {
            orderVo.setPurchaseUrl(paramVo.getPurchaseUrl());
        }

        List<UpdateOrderDtlVo> itemList = new ArrayList<UpdateOrderDtlVo>();
        for (UpdateOrderDtlVo orderDtlVo : paramVo.getItems()) {
            UpdateOrderDtlVo dtlVo = new UpdateOrderDtlVo();
            /*
             * if (pattern.matcher(orderDtlVo.getGoodsNm()).find()) { throw new
             * LingoException("특수문자가 포함되어 있습니다."); }
             */

            if (!orderDtlVo.getPrevGoodsNm().equals(orderDtlVo.getGoodsNm())) {
                dtlVo.setGoodsNm(orderDtlVo.getGoodsNm());
                dtlVo.setOrdSeq(orderDtlVo.getOrdSeq());
                dtlVo.setOrdCd(orderDtlVo.getOrdCd());
            }

            if (!orderDtlVo.getPrevGoodsCd().equals(orderDtlVo.getGoodsCd())) {
                dtlVo.setGoodsCd(orderDtlVo.getGoodsCd());
                dtlVo.setOrdSeq(orderDtlVo.getOrdSeq());
                dtlVo.setOrdCd(orderDtlVo.getOrdCd());
            }

            if (!orderDtlVo.getPrevGoodsOption().equals(orderDtlVo.getGoodsOption())) {
                dtlVo.setGoodsOption(orderDtlVo.getGoodsOption());
                dtlVo.setOrdSeq(orderDtlVo.getOrdSeq());
                dtlVo.setOrdCd(orderDtlVo.getOrdCd());
            }

            itemList.add(dtlVo);
        }

        LDataMap lDataMap = new LDataMap();
        lDataMap.put("CODE", "1");
        lDataMap.put("map", orderVo);
        lDataMap.put("list", itemList);

        return lDataMap;
    }
}