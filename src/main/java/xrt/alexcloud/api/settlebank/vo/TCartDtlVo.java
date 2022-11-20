package xrt.alexcloud.api.settlebank.vo;

import java.io.Serializable;

public class TCartDtlVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String poid; // 결제주문번호
    private String pseq; // SEQ
    private String compcd; // 회사코드
    private String orgcd; // 셀러코드
    private String ordCd; // torder주문번호
    private String xrtInvcSno; // XROUTE송장번호
    private String xrtShippingPrice; // XRT 판매가 (KRW)
    private String addusercd; // 등록 사용자 ID
    private String adddatetime; // 등록 일시
    private String updusercd; // 수정 사용자 ID
    private String upddatetime; // 수정 일시
    private String terminalcd;

    public String getPoid() {
        return poid;
    }

    public void setPoid(String poid) {
        this.poid = poid;
    }

    public String getPseq() {
        return pseq;
    }

    public void setPseq(String pseq) {
        this.pseq = pseq;
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

    public String getOrdCd() {
        return ordCd;
    }

    public void setOrdCd(String ordCd) {
        this.ordCd = ordCd;
    }

    public String getXrtInvcSno() {
        return xrtInvcSno;
    }

    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }

    public String getXrtShippingPrice() {
        return xrtShippingPrice;
    }

    public void setXrtShippingPrice(String xrtShippingPrice) {
        this.xrtShippingPrice = xrtShippingPrice;
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
        builder.append(" {\n\tpoid: ");
        builder.append(poid);
        builder.append("\n\tpseq: ");
        builder.append(pseq);
        builder.append("\n\tcompcd: ");
        builder.append(compcd);
        builder.append("\n\torgcd: ");
        builder.append(orgcd);
        builder.append("\n\tordCd: ");
        builder.append(ordCd);
        builder.append("\n\txrtInvcSno: ");
        builder.append(xrtInvcSno);
        builder.append("\n\txrtShippingPrice: ");
        builder.append(xrtShippingPrice);
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
