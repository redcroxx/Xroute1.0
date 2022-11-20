package xrt.alexcloud.common.vo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ShipPriceSearchVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String sCompCd; // 회사코드
    private String shipToDate; // 시작 일자
    private String shipFromDate; // 종료 일자
    private String shipCompany; // 배송업체명

    public String getsCompCd() {
        return sCompCd;
    }

    public void setsCompCd(String sCompCd) {
        this.sCompCd = sCompCd;
    }

    public String getShipToDate() {
        return shipToDate;
    }

    public void setShipToDate(String shipToDate) {
        this.shipToDate = shipToDate;
    }

    public String getShipFromDate() {
        return shipFromDate;
    }

    public void setShipFromDate(String shipFromDate) {
        this.shipFromDate = shipFromDate;
    }

    public String getShipCompany() {
        return shipCompany;
    }

    public void setShipCompany(String shipCompany) {
        this.shipCompany = shipCompany;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tsCompCd: ");
        builder.append(sCompCd);
        builder.append("\n\tshipToDate: ");
        builder.append(shipToDate);
        builder.append("\n\tshipFromDate: ");
        builder.append(shipFromDate);
        builder.append("\n\tshipCompany: ");
        builder.append(shipCompany);
        builder.append("\n}");
        return builder.toString();
    }

}
