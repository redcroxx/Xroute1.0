package xrt.fulfillment.system;

import java.io.Serializable;

public class KSERateVO implements Serializable{

    private static final long serialVersionUID = 1L;
    
    private String wgt;
    private String sagawa;
    private String nekopos;
    private String smallCargo;
    private String kPacket;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    
    public String getWgt() {
        return wgt;
    }
    public void setWgt(String wgt) {
        this.wgt = wgt;
    }
    public String getSagawa() {
        return sagawa;
    }
    public void setSagawa(String sagawa) {
        this.sagawa = sagawa;
    }
    public String getNekopos() {
        return nekopos;
    }
    public void setNekopos(String nekopos) {
        this.nekopos = nekopos;
    }
    public String getSmallCargo() {
        return smallCargo;
    }
    public void setSmallCargo(String smallCargo) {
        this.smallCargo = smallCargo;
    }
    public String getkPacket() {
        return kPacket;
    }
    public void setkPacket(String kPacket) {
        this.kPacket = kPacket;
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
        builder.append("KSERateVO {\n    wgt : ");
        builder.append(wgt);
        builder.append(",\n    sagawa : ");
        builder.append(sagawa);
        builder.append(",\n    nekopos : ");
        builder.append(nekopos);
        builder.append(",\n    smallCargo : ");
        builder.append(smallCargo);
        builder.append(",\n    kPacket : ");
        builder.append(kPacket);
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
