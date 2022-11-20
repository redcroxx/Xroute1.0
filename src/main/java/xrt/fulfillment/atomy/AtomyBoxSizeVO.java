package xrt.fulfillment.atomy;

import java.io.Serializable;

public class AtomyBoxSizeVO implements Serializable{
    
    private static final long serialVersionUID = 1L;
    
    private String atomyBozSizeSeq;
    private String compcd;
    private String no;
    private String length;
    private String width;
    private String height;
    private String cbm;
    private String weight;
    private String limitWeight;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    
    public String getAtomyBozSizeSeq() {
        return atomyBozSizeSeq;
    }
    public void setAtomyBozSizeSeq(String atomyBozSizeSeq) {
        this.atomyBozSizeSeq = atomyBozSizeSeq;
    }
    public String getCompcd() {
        return compcd;
    }
    public void setCompcd(String compcd) {
        this.compcd = compcd;
    }
    public String getNo() {
        return no;
    }
    public void setNo(String no) {
        this.no = no;
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
    public String getCbm() {
        return cbm;
    }
    public void setCbm(String cbm) {
        this.cbm = cbm;
    }
    public String getWeight() {
        return weight;
    }
    public void setWeight(String weight) {
        this.weight = weight;
    }
    public String getLimitWeight() {
        return limitWeight;
    }
    public void setLimitWeight(String limitWeight) {
        this.limitWeight = limitWeight;
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
        builder.append("AtomyBoxSizeVO {\n    atomyBozSizeSeq : ");
        builder.append(atomyBozSizeSeq);
        builder.append(",\n    compcd : ");
        builder.append(compcd);
        builder.append(",\n    no : ");
        builder.append(no);
        builder.append(",\n    length : ");
        builder.append(length);
        builder.append(",\n    width : ");
        builder.append(width);
        builder.append(",\n    height : ");
        builder.append(height);
        builder.append(",\n    cbm : ");
        builder.append(cbm);
        builder.append(",\n    weight : ");
        builder.append(weight);
        builder.append(",\n    limitWeight : ");
        builder.append(limitWeight);
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
