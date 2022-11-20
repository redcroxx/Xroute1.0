package xrt.fulfillment.bol;

import java.io.Serializable;

/**
 * MBL VO
 * @since 2020-12-23
 * @author wnkim
 *
 */
public class MasterBLVO implements Serializable {

    private static final long serialVersionUID = 1L;
    
    private String masterBlSeq;
    private String compcd;
    private String masterBlNo;
    private String airwayBill;
    private String closeYn;
    private String closeYnNm;
    private String etd;
    private String etdComp;
    private String eta;
    private String etaComp;
    private String remark;
    private String date;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    
    public String getMasterBlSeq() {
        return masterBlSeq;
    }
    public void setMasterBlSeq(String masterBlSeq) {
        this.masterBlSeq = masterBlSeq;
    }
    public String getCompcd() {
        return compcd;
    }
    public void setCompcd(String compcd) {
        this.compcd = compcd;
    }
    public String getMasterBlNo() {
        return masterBlNo;
    }
    public void setMasterBlNo(String masterBlNo) {
        this.masterBlNo = masterBlNo;
    }
    public String getAirwayBill() {
        return airwayBill;
    }
    public void setAirwayBill(String airwayBill) {
        this.airwayBill = airwayBill;
    }
    public String getCloseYn() {
        return closeYn;
    }
    public void setCloseYn(String closeYn) {
        this.closeYn = closeYn;
    }
    public String getCloseYnNm() {
        return closeYnNm;
    }
    public void setCloseYnNm(String closeYnNm) {
        this.closeYnNm = closeYnNm;
    }
    public String getEtd() {
        return etd;
    }
    public void setEtd(String etd) {
        this.etd = etd;
    }
    public String getEtdComp() {
        return etdComp;
    }
    public void setEtdComp(String etdComp) {
        this.etdComp = etdComp;
    }
    public String getEta() {
        return eta;
    }
    public void setEta(String eta) {
        this.eta = eta;
    }
    public String getEtaComp() {
        return etaComp;
    }
    public void setEtaComp(String etaComp) {
        this.etaComp = etaComp;
    }
    public String getRemark() {
        return remark;
    }
    public void setRemark(String remark) {
        this.remark = remark;
    }
    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
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
        builder.append("MasterBLVO {\n\tmasterBlSeq : ");
        builder.append(masterBlSeq);
        builder.append(",\n\tcompcd : ");
        builder.append(compcd);
        builder.append(",\n\tmasterBlNo : ");
        builder.append(masterBlNo);
        builder.append(",\n\tairwayBill : ");
        builder.append(airwayBill);
        builder.append(",\n\tcloseYn : ");
        builder.append(closeYn);
        builder.append(",\n\tcloseYnNm : ");
        builder.append(closeYnNm);
        builder.append(",\n\tetd : ");
        builder.append(etd);
        builder.append(",\n\tetdComp : ");
        builder.append(etdComp);
        builder.append(",\n\teta : ");
        builder.append(eta);
        builder.append(",\n\tetaComp : ");
        builder.append(etaComp);
        builder.append(",\n\tremark : ");
        builder.append(remark);
        builder.append(",\n\tdate : ");
        builder.append(date);
        builder.append(",\n\taddusercd : ");
        builder.append(addusercd);
        builder.append(",\n\tadddatetime : ");
        builder.append(adddatetime);
        builder.append(",\n\tupdusercd : ");
        builder.append(updusercd);
        builder.append(",\n\tupddatetime : ");
        builder.append(upddatetime);
        builder.append(",\n\tterminalcd : ");
        builder.append(terminalcd);
        builder.append("\n}");
        return builder.toString();
    }
}
