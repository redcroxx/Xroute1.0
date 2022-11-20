package xrt.fulfillment.order.efs;

import java.io.Serializable;

public class EfsVO implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String customerId;
    private String customerShoppingMall;
    private String orderNo;
    private String cartNo;
    private String serviceType;
    private String goodsName;
    private String goodsCnt;
    private String shipName;
    private String recvName;
    private String recvTel;
    private String recvMobile;
    private String recvAddr1;
    private String recvAddr2;
    private String recvPost;
    private String eNation;
    private String currency;
    private String totPaymentPrice;
    private String cityState;
    
    public String getCustomerId() {
        return customerId;
    }
    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }
    public String getCustomerShoppingMall() {
        return customerShoppingMall;
    }
    public void setCustomerShoppingMall(String customerShoppingMall) {
        this.customerShoppingMall = customerShoppingMall;
    }
    public String getOrderNo() {
        return orderNo;
    }
    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }
    public String getCartNo() {
        return cartNo;
    }
    public void setCartNo(String cartNo) {
        this.cartNo = cartNo;
    }
    public String getServiceType() {
        return serviceType;
    }
    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }
    public String getGoodsName() {
        return goodsName;
    }
    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }
    public String getGoodsCnt() {
        return goodsCnt;
    }
    public void setGoodsCnt(String goodsCnt) {
        this.goodsCnt = goodsCnt;
    }
    public String getShipName() {
        return shipName;
    }
    public void setShipName(String shipName) {
        this.shipName = shipName;
    }
    public String getRecvName() {
        return recvName;
    }
    public void setRecvName(String recvName) {
        this.recvName = recvName;
    }
    public String getRecvTel() {
        return recvTel;
    }
    public void setRecvTel(String recvTel) {
        this.recvTel = recvTel;
    }
    public String getRecvMobile() {
        return recvMobile;
    }
    public void setRecvMobile(String recvMobile) {
        this.recvMobile = recvMobile;
    }
    public String getRecvAddr1() {
        return recvAddr1;
    }
    public void setRecvAddr1(String recvAddr1) {
        this.recvAddr1 = recvAddr1;
    }
    public String getRecvAddr2() {
        return recvAddr2;
    }
    public void setRecvAddr2(String recvAddr2) {
        this.recvAddr2 = recvAddr2;
    }
    public String getRecvPost() {
        return recvPost;
    }
    public void setRecvPost(String recvPost) {
        this.recvPost = recvPost;
    }
    public String geteNation() {
        return eNation;
    }
    public void seteNation(String eNation) {
        this.eNation = eNation;
    }
    public String getCurrency() {
        return currency;
    }
    public void setCurrency(String currency) {
        this.currency = currency;
    }
    public String getTotPaymentPrice() {
        return totPaymentPrice;
    }
    public void setTotPaymentPrice(String totPaymentPrice) {
        this.totPaymentPrice = totPaymentPrice;
    }
    public String getCityState() {
        return cityState;
    }
    public void setCityState(String cityState) {
        this.cityState = cityState;
    }
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("EfsVO {\n    customerId : ");
        builder.append(customerId);
        builder.append(",\n    customerShoppingMall : ");
        builder.append(customerShoppingMall);
        builder.append(",\n    orderNo : ");
        builder.append(orderNo);
        builder.append(",\n    cartNo : ");
        builder.append(cartNo);
        builder.append(",\n    serviceType : ");
        builder.append(serviceType);
        builder.append(",\n    goodsName : ");
        builder.append(goodsName);
        builder.append(",\n    goodsCnt : ");
        builder.append(goodsCnt);
        builder.append(",\n    shipName : ");
        builder.append(shipName);
        builder.append(",\n    recvName : ");
        builder.append(recvName);
        builder.append(",\n    recvTel : ");
        builder.append(recvTel);
        builder.append(",\n    recvMobile : ");
        builder.append(recvMobile);
        builder.append(",\n    recvAddr1 : ");
        builder.append(recvAddr1);
        builder.append(",\n    recvAddr2 : ");
        builder.append(recvAddr2);
        builder.append(",\n    recvPost : ");
        builder.append(recvPost);
        builder.append(",\n    eNation : ");
        builder.append(eNation);
        builder.append(",\n    currency : ");
        builder.append(currency);
        builder.append(",\n    totPaymentPrice : ");
        builder.append(totPaymentPrice);
        builder.append(",\n    cityState : ");
        builder.append(cityState);
        builder.append("\n}");
        return builder.toString();
    }
}
