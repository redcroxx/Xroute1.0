package xrt.fulfillment.system;

import java.io.Serializable;

/**
 * Rate VO
 * 
 * @since 2020-12-23
 * @author ljh
 *
 */
public class PremiumRateVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String wgt;
    private String premium1;
    private String premium2;
    private String premium3;
    private String premium4;
    private String premium5;
    private String country;
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
    public String getPremium1() {
        return premium1;
    }
    public void setPremium1(String premium1) {
        this.premium1 = premium1;
    }
    public String getPremium2() {
        return premium2;
    }
    public void setPremium2(String premium2) {
        this.premium2 = premium2;
    }
    public String getPremium3() {
        return premium3;
    }
    public void setPremium3(String premium3) {
        this.premium3 = premium3;
    }
    public String getPremium4() {
        return premium4;
    }
    public void setPremium4(String premium4) {
        this.premium4 = premium4;
    }
    public String getPremium5() {
        return premium5;
    }
    public void setPremium5(String premium5) {
        this.premium5 = premium5;
    }
    public String getCountry() {
        return country;
    }
    public void setCountry(String country) {
        this.country = country;
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
        builder.append("PremiumRateVO {\n    wgt : ");
        builder.append(wgt);
        builder.append(",\n    premium1 : ");
        builder.append(premium1);
        builder.append(",\n    premium2 : ");
        builder.append(premium2);
        builder.append(",\n    premium3 : ");
        builder.append(premium3);
        builder.append(",\n    premium4 : ");
        builder.append(premium4);
        builder.append(",\n    premium5 : ");
        builder.append(premium5);
        builder.append(",\n    country : ");
        builder.append(country);
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
