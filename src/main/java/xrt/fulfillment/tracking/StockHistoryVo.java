package xrt.fulfillment.tracking;

import java.io.Serializable;

public class StockHistoryVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String idx;
    private String ordCd;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    private String invcSno;
    private String eventCd;
    private String statusCd;
    private String apiInvcSno;
    private String etc1;
    private String etc2;
    private String nation;
    private String localShipper;
    private String slug1;
    private String slug2;
    private String tag;
    private String tagKr;
    private String invcSno2;
    private String invcSno3;
    private String checkPointDate;
    private String rowStatusCd;

    public String getIdx() {
        return idx;
    }

    public void setIdx(String idx) {
        this.idx = idx;
    }

    public String getOrdCd() {
        return ordCd;
    }

    public void setOrdCd(String ordCd) {
        this.ordCd = ordCd;
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

    public String getInvcSno() {
        return invcSno;
    }

    public void setInvcSno(String invcSno) {
        this.invcSno = invcSno;
    }

    public String getEventCd() {
        return eventCd;
    }

    public void setEventCd(String eventCd) {
        this.eventCd = eventCd;
    }

    public String getStatusCd() {
        return statusCd;
    }

    public void setStatusCd(String statusCd) {
        this.statusCd = statusCd;
    }

    public String getApiInvcSno() {
        return apiInvcSno;
    }

    public void setApiInvcSno(String apiInvcSno) {
        this.apiInvcSno = apiInvcSno;
    }

    public String getEtc1() {
        return etc1;
    }

    public void setEtc1(String etc1) {
        this.etc1 = etc1;
    }

    public String getEtc2() {
        return etc2;
    }

    public void setEtc2(String etc2) {
        this.etc2 = etc2;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getLocalShipper() {
        return localShipper;
    }

    public void setLocalShipper(String localShipper) {
        this.localShipper = localShipper;
    }

    public String getSlug1() {
        return slug1;
    }

    public void setSlug1(String slug1) {
        this.slug1 = slug1;
    }

    public String getSlug2() {
        return slug2;
    }

    public void setSlug2(String slug2) {
        this.slug2 = slug2;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getTagKr() {
        return tagKr;
    }

    public void setTagKr(String tagKr) {
        this.tagKr = tagKr;
    }

    public String getInvcSno2() {
        return invcSno2;
    }

    public void setInvcSno2(String invcSno2) {
        this.invcSno2 = invcSno2;
    }

    public String getInvcSno3() {
        return invcSno3;
    }

    public void setInvcSno3(String invcSno3) {
        this.invcSno3 = invcSno3;
    }

    public String getCheckPointDate() {
        return checkPointDate;
    }

    public void setCheckPointDate(String checkPointDate) {
        this.checkPointDate = checkPointDate;
    }

    public String getRowStatusCd() {
        return rowStatusCd;
    }

    public void setRowStatusCd(String rowStatusCd) {
        this.rowStatusCd = rowStatusCd;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tidx: ");
        builder.append(idx);
        builder.append("\n\tordCd: ");
        builder.append(ordCd);
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
        builder.append("\n\tinvcSno: ");
        builder.append(invcSno);
        builder.append("\n\teventCd: ");
        builder.append(eventCd);
        builder.append("\n\tstatusCd: ");
        builder.append(statusCd);
        builder.append("\n\tapiInvcSno: ");
        builder.append(apiInvcSno);
        builder.append("\n\tetc1: ");
        builder.append(etc1);
        builder.append("\n\tetc2: ");
        builder.append(etc2);
        builder.append("\n\tnation: ");
        builder.append(nation);
        builder.append("\n\tlocalShipper: ");
        builder.append(localShipper);
        builder.append("\n\tslug1: ");
        builder.append(slug1);
        builder.append("\n\tslug2: ");
        builder.append(slug2);
        builder.append("\n\ttag: ");
        builder.append(tag);
        builder.append("\n\ttagKr: ");
        builder.append(tagKr);
        builder.append("\n\tinvcSno2: ");
        builder.append(invcSno2);
        builder.append("\n\tinvcSno3: ");
        builder.append(invcSno3);
        builder.append("\n\tcheckPointDate: ");
        builder.append(checkPointDate);
        builder.append("\n\trowStatusCd: ");
        builder.append(rowStatusCd);
        builder.append("\n}");
        return builder.toString();
    }
}
