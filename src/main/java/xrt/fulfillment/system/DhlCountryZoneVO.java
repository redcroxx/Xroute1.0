package xrt.fulfillment.system;

import java.io.Serializable;

public class DhlCountryZoneVO implements Serializable{

    private static final long serialVersionUID = 1L;
    
    private String dhlCountryZoneSeq;
    private String compcd;
    private String countryName;
    private String countryCode;
    private String zone;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    
    public String getDhlCountryZoneSeq() {
        return dhlCountryZoneSeq;
    }
    public void setDhlCountryZoneSeq(String dhlCountryZoneSeq) {
        this.dhlCountryZoneSeq = dhlCountryZoneSeq;
    }
    public String getCompcd() {
        return compcd;
    }
    public void setCompcd(String compcd) {
        this.compcd = compcd;
    }
    public String getCountryName() {
        return countryName;
    }
    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }
    public String getCountryCode() {
        return countryCode;
    }
    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }
    public String getZone() {
        return zone;
    }
    public void setZone(String zone) {
        this.zone = zone;
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
        builder.append("DhlCountryZoneVO {\n    dhlCountryZoneSeq : ");
        builder.append(dhlCountryZoneSeq);
        builder.append(",\n    compcd : ");
        builder.append(compcd);
        builder.append(",\n    countryName : ");
        builder.append(countryName);
        builder.append(",\n    countryCode : ");
        builder.append(countryCode);
        builder.append(",\n    zone : ");
        builder.append(zone);
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
