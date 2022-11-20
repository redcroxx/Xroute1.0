package xrt.fulfillment.system;

public class UpsCountryZoneVO {
    
    private static final long serialVersionUID = 1L;
    
    private String upsCountryZoneSeq;
    private String countryName;
    private String countryCode;
    private String zone;
    private String ess;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    
    public String getUpsCountryZoneSeq() {
        return upsCountryZoneSeq;
    }
    public void setUpsCountryZoneSeq(String upsCountryZoneSeq) {
        this.upsCountryZoneSeq = upsCountryZoneSeq;
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
    public String getEss() {
        return ess;
    }
    public void setEss(String ess) {
        this.ess = ess;
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
        builder.append("UpsCountryZoneVO {\n    upsCountryZoneSeq : ");
        builder.append(upsCountryZoneSeq);
        builder.append(",\n    countryName : ");
        builder.append(countryName);
        builder.append(",\n    countryCode : ");
        builder.append(countryCode);
        builder.append(",\n    zone : ");
        builder.append(zone);
        builder.append(",\n    ess : ");
        builder.append(ess);
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
