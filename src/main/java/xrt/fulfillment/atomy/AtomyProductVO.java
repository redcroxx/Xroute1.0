package xrt.fulfillment.atomy;

import java.io.Serializable;

public class AtomyProductVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String atomyProductSeq;
    private String type;
    private String krProductName;
    private String krProductCode;
    private String enProductName;
    private String odpCode;
    private String usaFdaProductNo;
    private String canadaFdaProductNo;
    private String price;
    private String length;
    private String width;
    private String height;
    private String kg;
    private String cbm;
    private String volumeWeight;
    private String hsCode;
    private String origin;
    private String zone;
    private String rack;
    private String sumLength;
    private String sumWidth;
    private String sumHeight;
    private String sumVolumeWeight;
    private String sumKg;
    private String productCount;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    
    public String getAtomyProductSeq() {
        return atomyProductSeq;
    }
    public void setAtomyProductSeq(String atomyProductSeq) {
        this.atomyProductSeq = atomyProductSeq;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public String getKrProductName() {
        return krProductName;
    }
    public void setKrProductName(String krProductName) {
        this.krProductName = krProductName;
    }
    public String getKrProductCode() {
        return krProductCode;
    }
    public void setKrProductCode(String krProductCode) {
        this.krProductCode = krProductCode;
    }
    public String getEnProductName() {
        return enProductName;
    }
    public void setEnProductName(String enProductName) {
        this.enProductName = enProductName;
    }
    public String getOdpCode() {
        return odpCode;
    }
    public void setOdpCode(String odpCode) {
        this.odpCode = odpCode;
    }
    public String getUsaFdaProductNo() {
        return usaFdaProductNo;
    }
    public void setUsaFdaProductNo(String usaFdaProductNo) {
        this.usaFdaProductNo = usaFdaProductNo;
    }
    public String getCanadaFdaProductNo() {
        return canadaFdaProductNo;
    }
    public void setCanadaFdaProductNo(String canadaFdaProductNo) {
        this.canadaFdaProductNo = canadaFdaProductNo;
    }
    public String getPrice() {
        return price;
    }
    public void setPrice(String price) {
        this.price = price;
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
    public String getKg() {
        return kg;
    }
    public void setKg(String kg) {
        this.kg = kg;
    }
    public String getCbm() {
        return cbm;
    }
    public void setCbm(String cbm) {
        this.cbm = cbm;
    }
    public String getVolumeWeight() {
        return volumeWeight;
    }
    public void setVolumeWeight(String volumeWeight) {
        this.volumeWeight = volumeWeight;
    }
    public String getHsCode() {
        return hsCode;
    }
    public void setHsCode(String hsCode) {
        this.hsCode = hsCode;
    }
    public String getOrigin() {
        return origin;
    }
    public void setOrigin(String origin) {
        this.origin = origin;
    }
    public String getZone() {
        return zone;
    }
    public void setZone(String zone) {
        this.zone = zone;
    }
    public String getRack() {
        return rack;
    }
    public void setRack(String rack) {
        this.rack = rack;
    }
    public String getSumLength() {
        return sumLength;
    }
    public void setSumLength(String sumLength) {
        this.sumLength = sumLength;
    }
    public String getSumWidth() {
        return sumWidth;
    }
    public void setSumWidth(String sumWidth) {
        this.sumWidth = sumWidth;
    }
    public String getSumHeight() {
        return sumHeight;
    }
    public void setSumHeight(String sumHeight) {
        this.sumHeight = sumHeight;
    }
    public String getSumVolumeWeight() {
        return sumVolumeWeight;
    }
    public void setSumVolumeWeight(String sumVolumeWeight) {
        this.sumVolumeWeight = sumVolumeWeight;
    }
    public String getSumKg() {
        return sumKg;
    }
    public void setSumKg(String sumKg) {
        this.sumKg = sumKg;
    }
    public String getProductCount() {
        return productCount;
    }
    public void setProductCount(String productCount) {
        this.productCount = productCount;
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
        builder.append("AtomyProductVO {\n    atomyProductSeq : ");
        builder.append(atomyProductSeq);
        builder.append(",\n    type : ");
        builder.append(type);
        builder.append(",\n    krProductName : ");
        builder.append(krProductName);
        builder.append(",\n    krProductCode : ");
        builder.append(krProductCode);
        builder.append(",\n    enProductName : ");
        builder.append(enProductName);
        builder.append(",\n    odpCode : ");
        builder.append(odpCode);
        builder.append(",\n    usaFdaProductNo : ");
        builder.append(usaFdaProductNo);
        builder.append(",\n    canadaFdaProductNo : ");
        builder.append(canadaFdaProductNo);
        builder.append(",\n    price : ");
        builder.append(price);
        builder.append(",\n    length : ");
        builder.append(length);
        builder.append(",\n    width : ");
        builder.append(width);
        builder.append(",\n    height : ");
        builder.append(height);
        builder.append(",\n    kg : ");
        builder.append(kg);
        builder.append(",\n    cbm : ");
        builder.append(cbm);
        builder.append(",\n    volumeWeight : ");
        builder.append(volumeWeight);
        builder.append(",\n    hsCode : ");
        builder.append(hsCode);
        builder.append(",\n    origin : ");
        builder.append(origin);
        builder.append(",\n    zone : ");
        builder.append(zone);
        builder.append(",\n    rack : ");
        builder.append(rack);
        builder.append(",\n    sumLength : ");
        builder.append(sumLength);
        builder.append(",\n    sumWidth : ");
        builder.append(sumWidth);
        builder.append(",\n    sumHeight : ");
        builder.append(sumHeight);
        builder.append(",\n    sumVolumeWeight : ");
        builder.append(sumVolumeWeight);
        builder.append(",\n    sumKg : ");
        builder.append(sumKg);
        builder.append(",\n    productCount : ");
        builder.append(productCount);
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
