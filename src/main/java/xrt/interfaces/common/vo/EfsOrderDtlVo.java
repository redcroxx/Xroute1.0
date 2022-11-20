package xrt.interfaces.common.vo;

import java.io.Serializable;

public class EfsOrderDtlVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String orderlistKey; // 주문 번호
    private String dtlOrdNo; // 판매자주문번호
    private String dtlMallNm; // 판매 쇼핑몰명
    private String dtlCartNo; // 장바구니 번호
    private String goodsCd; // 상품코드
    private String goodsNm; // 상품명
    private String goodsOption; // 상품옵션 (영문)
    private String goodsOptionKor; // 상품옵션 (한글)
    private String goodsCnt; // 상품수량
    private String paymentPrice; // 결제금액
    private String dtlRecvCurrency; // 상품통화코드

    public String getDtlOrdNo() {
        return dtlOrdNo;
    }

    public void setDtlOrdNo(String dtlOrdNo) {
        this.dtlOrdNo = dtlOrdNo;
    }

    public String getDtlMallNm() {
        return dtlMallNm;
    }

    public void setDtlMallNm(String dtlMallNm) {
        this.dtlMallNm = dtlMallNm;
    }

    public String getGoodsCd() {
        return goodsCd;
    }

    public void setGoodsCd(String goodsCd) {
        this.goodsCd = goodsCd;
    }

    public String getGoodsNm() {
        return goodsNm;
    }

    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    public String getGoodsOption() {
        return goodsOption;
    }

    public void setGoodsOption(String goodsOption) {
        this.goodsOption = goodsOption;
    }

    public String getGoodsOptionKor() {
        return goodsOptionKor;
    }

    public void setGoodsOptionKor(String goodsOptionKor) {
        this.goodsOptionKor = goodsOptionKor;
    }

    public String getGoodsCnt() {
        return goodsCnt;
    }

    public void setGoodsCnt(String goodsCnt) {
        this.goodsCnt = goodsCnt;
    }

    public String getPaymentPrice() {
        return paymentPrice;
    }

    public void setPaymentPrice(String paymentPrice) {
        this.paymentPrice = paymentPrice;
    }

    public String getDtlRecvCurrency() {
        return dtlRecvCurrency;
    }

    public void setDtlRecvCurrency(String dtlRecvCurrency) {
        this.dtlRecvCurrency = dtlRecvCurrency;
    }

    public String getOrderlistKey() {
        return orderlistKey;
    }

    public void setOrderlistKey(String orderlistKey) {
        this.orderlistKey = orderlistKey;
    }

    public String getDtlCartNo() {
        return dtlCartNo;
    }

    public void setDtlCartNo(String dtlCartNo) {
        this.dtlCartNo = dtlCartNo;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\torderlistKey: ");
        builder.append(orderlistKey);
        builder.append("\n\tdtlOrdNo: ");
        builder.append(dtlOrdNo);
        builder.append("\n\tdtlMallNm: ");
        builder.append(dtlMallNm);
        builder.append("\n\tdtlCartNo: ");
        builder.append(dtlCartNo);
        builder.append("\n\tgoodsCd: ");
        builder.append(goodsCd);
        builder.append("\n\tgoodsNm: ");
        builder.append(goodsNm);
        builder.append("\n\tgoodsOption: ");
        builder.append(goodsOption);
        builder.append("\n\tgoodsOptionKor: ");
        builder.append(goodsOptionKor);
        builder.append("\n\tgoodsCnt: ");
        builder.append(goodsCnt);
        builder.append("\n\tpaymentPrice: ");
        builder.append(paymentPrice);
        builder.append("\n\tdtlRecvCurrency: ");
        builder.append(dtlRecvCurrency);
        builder.append("\n}");
        return builder.toString();
    }

}
