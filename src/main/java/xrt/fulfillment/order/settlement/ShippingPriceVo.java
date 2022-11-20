package xrt.fulfillment.order.settlement;

import java.io.Serializable;

public class ShippingPriceVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String ordcd; // 오더CD
    private String orgcd; // 셀러ID
    private String xrtInvcSno; // 송장 번호
    private String invcSno1; // 배송No1
    private String wgt; // XROUTE_중량(Kg)
    private String boxVolume; // 부피 중량(Kg)
    private String eNation; // 도착국가
    private String shippingCompany; // 배송업체
    private String shippingType; // 배송타입(A~Z)
    private String realWeight; // 무게
    private String weightUnit; // 무게단위(KG)

    public String getOrdcd() {
        return ordcd;
    }

    public void setOrdcd(String ordcd) {
        this.ordcd = ordcd;
    }

    public String getOrgcd() {
        return orgcd;
    }

    public void setOrgcd(String orgcd) {
        this.orgcd = orgcd;
    }

    public String getXrtInvcSno() {
        return xrtInvcSno;
    }

    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }

    public String getInvcSno1() {
        return invcSno1;
    }

    public void setInvcSno1(String invcSno1) {
        this.invcSno1 = invcSno1;
    }

    public String getWgt() {
        return wgt;
    }

    public void setWgt(String wgt) {
        this.wgt = wgt;
    }

    public String geteNation() {
        return eNation;
    }

    public void seteNation(String eNation) {
        this.eNation = eNation;
    }

    public String getShippingCompany() {
        return shippingCompany;
    }

    public void setShippingCompany(String shippingCompany) {
        this.shippingCompany = shippingCompany;
    }

    public String getShippingType() {
        return shippingType;
    }

    public void setShippingType(String shippingType) {
        this.shippingType = shippingType;
    }

    public String getRealWeight() {
        return realWeight;
    }

    public void setRealWeight(String realWeight) {
        this.realWeight = realWeight;
    }

    public String getWeightUnit() {
        return weightUnit;
    }

    public void setWeightUnit(String weightUnit) {
        this.weightUnit = weightUnit;
    }

    public String getBoxVolume() {
        return boxVolume;
    }

    public void setBoxVolume(String boxVolume) {
        this.boxVolume = boxVolume;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tordcd: ");
        builder.append(ordcd);
        builder.append("\n\torgcd: ");
        builder.append(orgcd);
        builder.append("\n\txrtInvcSno: ");
        builder.append(xrtInvcSno);
        builder.append("\n\tinvcSno1: ");
        builder.append(invcSno1);
        builder.append("\n\twgt: ");
        builder.append(wgt);
        builder.append("\n\tboxVolume: ");
        builder.append(boxVolume);
        builder.append("\n\teNation: ");
        builder.append(eNation);
        builder.append("\n\tshippingCompany: ");
        builder.append(shippingCompany);
        builder.append("\n\tshippingType: ");
        builder.append(shippingType);
        builder.append("\n\trealWeight: ");
        builder.append(realWeight);
        builder.append("\n\tweightUnit: ");
        builder.append(weightUnit);
        builder.append("\n}");
        return builder.toString();
    }

}
