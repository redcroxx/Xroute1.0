package xrt.fulfillment.system;

public class UpsRateVO {
    
    private static final long serialVersionUID = 1L;
    
    private String upsRateSeq;
    private String kg;
    private String zone1;
    private String zone2;
    private String zone3;
    private String zone4;
    private String zone5;
    private String zone6;
    private String zone7;
    private String zone8;
    private String zone9;
    private String zone10;
    private String zoneCode;
    private String upsPrice;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    
    public String getUpsRateSeq() {
        return upsRateSeq;
    }
    public void setUpsRateSeq(String upsRateSeq) {
        this.upsRateSeq = upsRateSeq;
    }
    public String getKg() {
        return kg;
    }
    public void setKg(String kg) {
        this.kg = kg;
    }
    public String getZone1() {
        return zone1;
    }
    public void setZone1(String zone1) {
        this.zone1 = zone1;
    }
    public String getZone2() {
        return zone2;
    }
    public void setZone2(String zone2) {
        this.zone2 = zone2;
    }
    public String getZone3() {
        return zone3;
    }
    public void setZone3(String zone3) {
        this.zone3 = zone3;
    }
    public String getZone4() {
        return zone4;
    }
    public void setZone4(String zone4) {
        this.zone4 = zone4;
    }
    public String getZone5() {
        return zone5;
    }
    public void setZone5(String zone5) {
        this.zone5 = zone5;
    }
    public String getZone6() {
        return zone6;
    }
    public void setZone6(String zone6) {
        this.zone6 = zone6;
    }
    public String getZone7() {
        return zone7;
    }
    public void setZone7(String zone7) {
        this.zone7 = zone7;
    }
    public String getZone8() {
        return zone8;
    }
    public void setZone8(String zone8) {
        this.zone8 = zone8;
    }
    public String getZone9() {
        return zone9;
    }
    public void setZone9(String zone9) {
        this.zone9 = zone9;
    }
    public String getZone10() {
        return zone10;
    }
    public void setZone10(String zone10) {
        this.zone10 = zone10;
    }
    public String getZoneCode() {
        return zoneCode;
    }
    public void setZoneCode(String zoneCode) {
        this.zoneCode = zoneCode;
    }
    public String getUpsPrice() {
        return upsPrice;
    }
    public void setUpsPrice(String upsPrice) {
        this.upsPrice = upsPrice;
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
        builder.append("UpsRateVO {\n    upsRateSeq : ");
        builder.append(upsRateSeq);
        builder.append(",\n    kg : ");
        builder.append(kg);
        builder.append(",\n    zone1 : ");
        builder.append(zone1);
        builder.append(",\n    zone2 : ");
        builder.append(zone2);
        builder.append(",\n    zone3 : ");
        builder.append(zone3);
        builder.append(",\n    zone4 : ");
        builder.append(zone4);
        builder.append(",\n    zone5 : ");
        builder.append(zone5);
        builder.append(",\n    zone6 : ");
        builder.append(zone6);
        builder.append(",\n    zone7 : ");
        builder.append(zone7);
        builder.append(",\n    zone8 : ");
        builder.append(zone8);
        builder.append(",\n    zone9 : ");
        builder.append(zone9);
        builder.append(",\n    zone10 : ");
        builder.append(zone10);
        builder.append(",\n    zoneCode : ");
        builder.append(zoneCode);
        builder.append(",\n    upsPrice : ");
        builder.append(upsPrice);
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
