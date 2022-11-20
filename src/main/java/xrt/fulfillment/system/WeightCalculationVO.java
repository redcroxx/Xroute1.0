package xrt.fulfillment.system;

import java.io.Serializable;

/**
 * Rate VO
 * 
 * @since 2020-12-23
 * @author ljh
 *
 */
public class WeightCalculationVO  implements Serializable {

    private static final long serialVersionUID = 1L;

    private String wgt;     // 무게
    private String length;  // 높이
    private String width;   // 가로
    private String height;  // 세로
    private String country; // 국가
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
    public String getLength() {
        return length;
    }
    public void setLength(String length) {
        this.length = length;
    }
    public String getWidth() {
        return width;
    }
    public void setWidth(String width) {
        this.width = width;
    }
    public String getHeight() {
        return height;
    }
    public void setHeight(String height) {
        this.height = height;
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
        builder.append("WeightCalculationVO {\n\twgt : ");
        builder.append(wgt);
        builder.append(",\n\tlength : ");
        builder.append(length);
        builder.append(",\n\twidth : ");
        builder.append(width);
        builder.append(",\n\theight : ");
        builder.append(height);
        builder.append(",\n\tcountry : ");
        builder.append(country);
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
