package xrt.fulfillment.tracking;

import java.io.Serializable;

public class TrackingHistorytVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String trackingSeq;
	private String xrtInvcSno;
	private String eNation;
	private String statusCd;
	private String statusNm;
	private String statusEnNm;
	private String addusercd;
	private String adddatetime;
	private String updusercd;
	private String upddatetime;
	private String terminalcd;
	
    public String getTrackingSeq() {
        return trackingSeq;
    }
    public void setTrackingSeq(String trackingSeq) {
        this.trackingSeq = trackingSeq;
    }
    public String getXrtInvcSno() {
        return xrtInvcSno;
    }
    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }
    public String geteNation() {
        return eNation;
    }
    public void seteNation(String eNation) {
        this.eNation = eNation;
    }
    public String getStatusCd() {
        return statusCd;
    }
    public void setStatusCd(String statusCd) {
        this.statusCd = statusCd;
    }
    public String getStatusNm() {
        return statusNm;
    }
    public void setStatusNm(String statusNm) {
        this.statusNm = statusNm;
    }
    public String getStatusEnNm() {
        return statusEnNm;
    }
    public void setStatusEnNm(String statusEnNm) {
        this.statusEnNm = statusEnNm;
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
        builder.append("TrackingHistoryVO {\n    trackingSeq : ");
        builder.append(trackingSeq);
        builder.append(",\n    xrtInvcSno : ");
        builder.append(xrtInvcSno);
        builder.append(",\n    eNation : ");
        builder.append(eNation);
        builder.append(",\n    statusCd : ");
        builder.append(statusCd);
        builder.append(",\n    statusEnNm : ");
        builder.append(statusEnNm);
        builder.append(",\n    statusNm : ");
        builder.append(statusNm);
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
        builder.append("\n}");
        return builder.toString();
    }
}
