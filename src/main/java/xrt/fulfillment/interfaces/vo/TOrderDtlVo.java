package xrt.fulfillment.interfaces.vo;

import java.io.Serializable;

public class TOrderDtlVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String ordCd;
    private Long ordSeq;
    private String compcd;
    private String orgcd;
    private String xrtInvcSno;
    private String goodsCd;
    private String goodsNm;
    private String goodsEnNm;
    private String goodsOption;
    private String goodsCnt;
    private String paymentPrice;
    private String paymentPriceUsd;
    private String excTagSum;
    private String excTotSum;
    private String saleTagSum;
    private String saleTotSum;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    private String delFlg;
    private String ordNo;
    
    public String getOrdCd() {
        return ordCd;
    }
    public void setOrdCd(String ordCd) {
        this.ordCd = ordCd;
    }
    public Long getOrdSeq() {
        return ordSeq;
    }
    public void setOrdSeq(Long ordSeq) {
        this.ordSeq = ordSeq;
    }
    public String getCompcd() {
        return compcd;
    }
    public void setCompcd(String compcd) {
        this.compcd = compcd;
    }
    public String getOrgcd() {
        return orgcd;
    }
    public void setOrgcd(String orgcd) {
        this.orgcd = orgcd;
    }
    public String getXrtInvcSno() {
        return xrtInvcSno;
    }
    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
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
    public String getGoodsEnNm() {
        return goodsEnNm;
    }
    public void setGoodsEnNm(String goodsEnNm) {
        this.goodsEnNm = goodsEnNm;
    }
    public String getGoodsOption() {
        return goodsOption;
    }
    public void setGoodsOption(String goodsOption) {
        this.goodsOption = goodsOption;
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
    public String getPaymentPriceUsd() {
        return paymentPriceUsd;
    }
    public void setPaymentPriceUsd(String paymentPriceUsd) {
        this.paymentPriceUsd = paymentPriceUsd;
    }
    public String getExcTagSum() {
        return excTagSum;
    }
    public void setExcTagSum(String excTagSum) {
        this.excTagSum = excTagSum;
    }
    public String getExcTotSum() {
        return excTotSum;
    }
    public void setExcTotSum(String excTotSum) {
        this.excTotSum = excTotSum;
    }
    public String getSaleTagSum() {
        return saleTagSum;
    }
    public void setSaleTagSum(String saleTagSum) {
        this.saleTagSum = saleTagSum;
    }
    public String getSaleTotSum() {
        return saleTotSum;
    }
    public void setSaleTotSum(String saleTotSum) {
        this.saleTotSum = saleTotSum;
    }
    public String getAddusercd() {
        return addusercd;
    }
    public void setAddusercd(String addusercd) {
        this.addusercd = addusercd;
    }
    public String getAdddatetime() {
        return adddatetime;
    }
    public void setAdddatetime(String adddatetime) {
        this.adddatetime = adddatetime;
    }
    public String getUpdusercd() {
        return updusercd;
    }
    public void setUpdusercd(String updusercd) {
        this.updusercd = updusercd;
    }
    public String getUpddatetime() {
        return upddatetime;
    }
    public void setUpddatetime(String upddatetime) {
        this.upddatetime = upddatetime;
    }
    public String getTerminalcd() {
        return terminalcd;
    }
    public void setTerminalcd(String terminalcd) {
        this.terminalcd = terminalcd;
    }
    public String getDelFlg() {
        return delFlg;
    }
    public void setDelFlg(String delFlg) {
        this.delFlg = delFlg;
    }
    public String getOrdNo() {
        return ordNo;
    }
    public void setOrdNo(String ordNo) {
        this.ordNo = ordNo;
    }
    
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("TOrderDtlVo {\n    ordCd : ");
        builder.append(ordCd);
        builder.append(",\n    ordSeq : ");
        builder.append(ordSeq);
        builder.append(",\n    compcd : ");
        builder.append(compcd);
        builder.append(",\n    orgcd : ");
        builder.append(orgcd);
        builder.append(",\n    xrtInvcSno : ");
        builder.append(xrtInvcSno);
        builder.append(",\n    goodsCd : ");
        builder.append(goodsCd);
        builder.append(",\n    goodsNm : ");
        builder.append(goodsNm);
        builder.append(",\n    goodsEnNm : ");
        builder.append(goodsEnNm);
        builder.append(",\n    goodsOption : ");
        builder.append(goodsOption);
        builder.append(",\n    goodsCnt : ");
        builder.append(goodsCnt);
        builder.append(",\n    paymentPrice : ");
        builder.append(paymentPrice);
        builder.append(",\n    paymentPriceUsd : ");
        builder.append(paymentPriceUsd);
        builder.append(",\n    excTagSum : ");
        builder.append(excTagSum);
        builder.append(",\n    excTotSum : ");
        builder.append(excTotSum);
        builder.append(",\n    saleTagSum : ");
        builder.append(saleTagSum);
        builder.append(",\n    saleTotSum : ");
        builder.append(saleTotSum);
        builder.append(",\n    addusercd : ");
        builder.append(addusercd);
        builder.append(",\n    adddatetime : ");
        builder.append(adddatetime);
        builder.append(",\n    updusercd : ");
        builder.append(updusercd);
        builder.append(",\n    upddatetime : ");
        builder.append(upddatetime);
        builder.append(",\n    terminalcd : ");
        builder.append(terminalcd);
        builder.append(",\n    delFlg : ");
        builder.append(delFlg);
        builder.append(",\n    ordNo : ");
        builder.append(ordNo);
        builder.append("\n}");
        return builder.toString();
    }
}
