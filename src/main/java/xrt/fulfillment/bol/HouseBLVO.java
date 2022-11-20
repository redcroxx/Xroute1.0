package xrt.fulfillment.bol;

import java.io.Serializable;

/**
 * HBL VO
 * @since 2020-12-15
 * @author wnkim
 *
 */
public class HouseBLVO implements Serializable {

    private static final long serialVersionUID = 1L;
    
    private String houseBlSeq;
    private String compcd;
    private String scacCode;
    private String customsClearance;
    private String customsClearanceNm;
    private String houseBlNo;
    private String masterBlNo;
    private String closeYn;
    private String closeYnNm;
    private String remark;
    private String date;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    
    public String getHouseBlSeq() {
        return houseBlSeq;
    }
    public void setHouseBlSeq(String houseBlSeq) {
        this.houseBlSeq = houseBlSeq;
    }
    public String getCompcd() {
        return compcd;
    }
    public void setCompcd(String compcd) {
        this.compcd = compcd;
    }
    public String getScacCode() {
        return scacCode;
    }
    public void setScacCode(String scacCode) {
        this.scacCode = scacCode;
    }
    public String getCustomsClearance() {
        return customsClearance;
    }
    public void setCustomsClearance(String customsClearance) {
        this.customsClearance = customsClearance;
    }
    public String getCustomsClearanceNm() {
        return customsClearanceNm;
    }
    public void setCustomsClearanceNm(String customsClearanceNm) {
        this.customsClearanceNm = customsClearanceNm;
    }
    public String getHouseBlNo() {
        return houseBlNo;
    }
    public void setHouseBlNo(String houseBlNo) {
        this.houseBlNo = houseBlNo;
    }
    public String getMasterBlNo() {
        return masterBlNo;
    }
    public void setMasterBlNo(String masterBlNo) {
        this.masterBlNo = masterBlNo;
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
        builder.append("HouseBLVO [houseBlSeq=");
        builder.append(houseBlSeq);
        builder.append(" , \\n compcd=");
        builder.append(compcd);
        builder.append(" , \\n scacCode=");
        builder.append(scacCode);
        builder.append(" , \\n customsClearance=");
        builder.append(customsClearance);
        builder.append(" , \\n customsClearanceNm=");
        builder.append(customsClearanceNm);
        builder.append(" , \\n houseBlNo=");
        builder.append(houseBlNo);
        builder.append(" , \\n masterBlNo=");
        builder.append(masterBlNo);
        builder.append(" , \\n closeYn=");
        builder.append(closeYn);
        builder.append(" , \\n closeYnNm=");
        builder.append(closeYnNm);
        builder.append(" , \\n remark=");
        builder.append(remark);
        builder.append(" , \\n date=");
        builder.append(date);
        builder.append(" , \\n addusercd=");
        builder.append(addusercd);
        builder.append(" , \\n adddatetime=");
        builder.append(adddatetime);
        builder.append(" , \\n updusercd=");
        builder.append(updusercd);
        builder.append(" , \\n upddatetime=");
        builder.append(upddatetime);
        builder.append(" , \\n terminalcd=");
        builder.append(terminalcd);
        builder.append("]");
        return builder.toString();
    }

}
