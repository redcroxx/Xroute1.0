package xrt.fulfillment.system;

import java.io.Serializable;

public class DhlRateVO implements Serializable{

    private static final long serialVersionUID = 1L;
    
    private String dhlRateSeq;
    private String kg;
    private String zone1;
    private String zone2;
    private String zone3;
    private String zone4;
    private String zone5;
    private String zone6;
    private String zone7;
    private String zone8;
    private String zone41;
    private String zoneCode;
    private String dhlPrice;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    
    public String getDhlRateSeq() {
        return dhlRateSeq;
    }
    public void setDhlRateSeq(String dhlRateSeq) {
        this.dhlRateSeq = dhlRateSeq;
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
    public String getZone41() {
        return zone41;
    }
    public void setZone41(String zone41) {
        this.zone41 = zone41;
    }
    public String getZoneCode() {
        return zoneCode;
    }
    public void setZoneCode(String zoneCode) {
        this.zoneCode = zoneCode;
    }
    public String getDhlPrice() {
        return dhlPrice;
    }
    public void setDhlPrice(String dhlPrice) {
        this.dhlPrice = dhlPrice;
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
        builder.append("DhlRateVO {\n    dhlRateSeq : ");
        builder.append(dhlRateSeq);
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
        builder.append(",\n    zone41 : ");
        builder.append(zone41);
        builder.append(",\n    zoneCode : ");
        builder.append(zoneCode);
        builder.append(",\n    dhlPrice : ");
        builder.append(dhlPrice);
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
