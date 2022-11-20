package xrt.fulfillment.order.qxpress;

import java.io.Serializable;

public class QxpressVO implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String orgcd; // 판매자 ID.
    private String sNation; // 출발 국가.
    private String eNation; // 도착 국가.
    private String xrtInvcSno; // 참조 주문번호(XROUTE 송장번호).
    private String goodsNm; // 상품명.
    private String goodsCnt; // 상품수.
    private String totPaymentPrice; // 상품가격 (총액).
    private String recvName; // 이름.
    private String recvPost; // 우편번호.
    private String recvAddr1; // 수취인주소1.
    private String recvAddr2; // 수취인주소2.
    private String recvTel; // 연락처(HP).
    private String recvMobile; // 연락처.
    private String recvCurrency; // 통화.
    private String shippingGrade; // 배송등급.
    private String recvNameFurigana; // 이름 후리가나.
    private String pcc; // 구매고객통관고유번호.
    private String purchaseUrl; // 상품 URL 정보.
    
    public String getOrgcd() {
        return orgcd;
    }
    public void setOrgcd(String orgcd) {
        this.orgcd = orgcd;
    }
    public String getsNation() {
        return sNation;
    }
    public void setsNation(String sNation) {
        this.sNation = sNation;
    }
    public String geteNation() {
        return eNation;
    }
    public void seteNation(String eNation) {
        this.eNation = eNation;
    }
    public String getXrtInvcSno() {
        return xrtInvcSno;
    }
    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }
    public String getGoodsNm() {
        return goodsNm;
    }
    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }
    public String getGoodsCnt() {
        return goodsCnt;
    }
    public void setGoodsCnt(String goodsCnt) {
        this.goodsCnt = goodsCnt;
    }
    public String getTotPaymentPrice() {
        return totPaymentPrice;
    }
    public void setTotPaymentPrice(String totPaymentPrice) {
        this.totPaymentPrice = totPaymentPrice;
    }
    public String getRecvName() {
        return recvName;
    }
    public void setRecvName(String recvName) {
        this.recvName = recvName;
    }
    public String getRecvPost() {
        return recvPost;
    }
    public void setRecvPost(String recvPost) {
        this.recvPost = recvPost;
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
    public String getRecvCurrency() {
        return recvCurrency;
    }
    public void setRecvCurrency(String recvCurrency) {
        this.recvCurrency = recvCurrency;
    }
    public String getShippingGrade() {
        return shippingGrade;
    }
    public void setShippingGrade(String shippingGrade) {
        this.shippingGrade = shippingGrade;
    }
    public String getRecvNameFurigana() {
        return recvNameFurigana;
    }
    public void setRecvNameFurigana(String recvNameFurigana) {
        this.recvNameFurigana = recvNameFurigana;
    }
    public String getPcc() {
        return pcc;
    }
    public void setPcc(String pcc) {
        this.pcc = pcc;
    }
    public String getPurchaseUrl() {
        return purchaseUrl;
    }
    public void setPurchaseUrl(String purchaseUrl) {
        this.purchaseUrl = purchaseUrl;
    }
    
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("QxpressVO {\n    orgcd : ");
        builder.append(orgcd);
        builder.append(",\n    sNation : ");
        builder.append(sNation);
        builder.append(",\n    eNation : ");
        builder.append(eNation);
        builder.append(",\n    xrtInvcSno : ");
        builder.append(xrtInvcSno);
        builder.append(",\n    goodsNm : ");
        builder.append(goodsNm);
        builder.append(",\n    goodsCnt : ");
        builder.append(goodsCnt);
        builder.append(",\n    totPaymentPrice : ");
        builder.append(totPaymentPrice);
        builder.append(",\n    recvName : ");
        builder.append(recvName);
        builder.append(",\n    recvPost : ");
        builder.append(recvPost);
        builder.append(",\n    recvAddr1 : ");
        builder.append(recvAddr1);
        builder.append(",\n    recvAddr2 : ");
        builder.append(recvAddr2);
        builder.append(",\n    recvTel : ");
        builder.append(recvTel);
        builder.append(",\n    recvMobile : ");
        builder.append(recvMobile);
        builder.append(",\n    recvCurrency : ");
        builder.append(recvCurrency);
        builder.append(",\n    shippingGrade : ");
        builder.append(shippingGrade);
        builder.append(",\n    recvNameFurigana : ");
        builder.append(recvNameFurigana);
        builder.append(",\n    pcc : ");
        builder.append(pcc);
        builder.append(",\n    purchaseUrl : ");
        builder.append(purchaseUrl);
        builder.append("\n}");
        return builder.toString();
    }
}
