package xrt.fulfillment.order.orderlist;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class UpdateOrderDtlVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String compcd;
    private String orgcd;
    private String whcd;
    private String prevGoodsCd;
    private String prevGoodsNm;
    private String prevGoodsOption;
    private String ordCd;
    private String ordSeq;
    private String goodsCd;
    private String goodsNm;
    private String goodsOption;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;

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

    public String getWhcd() {
        return whcd;
    }

    public void setWhcd(String whcd) {
        this.whcd = whcd;
    }

    public String getPrevGoodsCd() {
        return prevGoodsCd;
    }

    public void setPrevGoodsCd(String prevGoodsCd) {
        this.prevGoodsCd = prevGoodsCd;
    }

    public String getPrevGoodsNm() {
        return prevGoodsNm;
    }

    public void setPrevGoodsNm(String prevGoodsNm) {
        this.prevGoodsNm = prevGoodsNm;
    }

    public String getPrevGoodsOption() {
        return prevGoodsOption;
    }

    public void setPrevGoodsOption(String prevGoodsOption) {
        this.prevGoodsOption = prevGoodsOption;
    }

    public String getOrdCd() {
        return ordCd;
    }

    public void setOrdCd(String ordCd) {
        this.ordCd = ordCd;
    }

    public String getOrdSeq() {
        return ordSeq;
    }

    public void setOrdSeq(String ordSeq) {
        this.ordSeq = ordSeq;
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

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tcompcd: ");
        builder.append(compcd);
        builder.append("\n\torgcd: ");
        builder.append(orgcd);
        builder.append("\n\twhcd: ");
        builder.append(whcd);
        builder.append("\n\tprevGoodsCd: ");
        builder.append(prevGoodsCd);
        builder.append("\n\tprevGoodsNm: ");
        builder.append(prevGoodsNm);
        builder.append("\n\tprevGoodsOption: ");
        builder.append(prevGoodsOption);
        builder.append("\n\tordCd: ");
        builder.append(ordCd);
        builder.append("\n\tordSeq: ");
        builder.append(ordSeq);
        builder.append("\n\tgoodsCd: ");
        builder.append(goodsCd);
        builder.append("\n\tgoodsNm: ");
        builder.append(goodsNm);
        builder.append("\n\tgoodsOption: ");
        builder.append(goodsOption);
        builder.append("\n\taddusercd: ");
        builder.append(addusercd);
        builder.append("\n\tadddatetime: ");
        builder.append(adddatetime);
        builder.append("\n\tupdusercd: ");
        builder.append(updusercd);
        builder.append("\n\tupddatetime: ");
        builder.append(upddatetime);
        builder.append("\n\tterminalcd: ");
        builder.append(terminalcd);
        builder.append("\n}");
        return builder.toString();
    }
}
