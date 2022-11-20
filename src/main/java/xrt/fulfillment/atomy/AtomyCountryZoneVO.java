package xrt.fulfillment.atomy;

import java.io.Serializable;

public class AtomyCountryZoneVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String atomyCountryZoneSeq;
    private String compcd;
    private String countryName;
    private String countryCode;
    private String localShipper;
    private String zone;
    private String bound;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    
    public String getAtomyCountryZoneSeq() {
        return atomyCountryZoneSeq;
    }
    public void setAtomyCountryZoneSeq(String atomyCountryZoneSeq) {
        this.atomyCountryZoneSeq = atomyCountryZoneSeq;
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
    public String getLocalShipper() {
        return localShipper;
    }
    public void setLocalShipper(String localShipper) {
        this.localShipper = localShipper;
    }
    public String getZone() {
        return zone;
    }
    public void setZone(String zone) {
        this.zone = zone;
    }
    public String getBound() {
        return bound;
    }
    public void setBound(String bound) {
        this.bound = bound;
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
        builder.append("AtomyCountryZoneVO {\n    atomyCountryZoneSeq : ");
        builder.append(atomyCountryZoneSeq);
        builder.append(",\n    compcd : ");
        builder.append(compcd);
        builder.append(",\n    countryName : ");
        builder.append(countryName);
        builder.append(",\n    countryCode : ");
        builder.append(countryCode);
        builder.append(",\n    localShipper : ");
        builder.append(localShipper);
        builder.append(",\n    zone : ");
        builder.append(zone);
        builder.append(",\n    bound : ");
        builder.append(bound);
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
