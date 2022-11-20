package xrt.alexcloud.api.efs.vo;

import java.io.Serializable;

public class EfsTrackingStatusVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String efsInvcSno; // 송장번호(예약번호)
    private String xrtInvcSno; // 발송품 참조번호 (고객의 발송품 고유번호 : Xrt송장번호)
    private String localShipper; // 배송 회사명 (배송사 또는 배송상품 명)
    private String invcSno; // 배송 번호
    private String efsStatusCode; // 최종 배송 상태 코드 (배송 물품의 최종 상태 코드)
    private String efsStatus; // 최종 배송 상태 값 (배송 물품의 최종 상태값)
    private String efsStatysDate; // 최종 배송 상태일시 : 최종 상태의 날짜 및 시각 (YYYY.MM.DDHH:MM)
    private String wgtCharge; // 적용중량(kg)
    private String wgtReal; // 실중량(kg)
    private String boxWidth; // 가로(cm)
    private String boxLength; // 세로(cm)
    private String boxHeight; // 높이(cm)
    private String wgtVolume; // 부피중량(kg)
    private String shipMethodCd; // 작용 서비스 타입
    private String shippingPrice; // 배송비 (예상 배송 비용 (KRW))
    private String shippingNation; // 배송 상태 국가 (예) Korea, Singapore, Malaysia)

    public String getEfsInvcSno() {
        return efsInvcSno;
    }

    public void setEfsInvcSno(String efsInvcSno) {
        this.efsInvcSno = efsInvcSno;
    }

    public String getXrtInvcSno() {
        return xrtInvcSno;
    }

    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }

    public String getLocalShipper() {
        return localShipper;
    }

    public void setLocalShipper(String localShipper) {
        this.localShipper = localShipper;
    }

    public String getInvcSno() {
        return invcSno;
    }

    public void setInvcSno(String invcSno) {
        this.invcSno = invcSno;
    }

    public String getEfsStatusCode() {
        return efsStatusCode;
    }

    public void setEfsStatusCode(String efsStatusCode) {
        this.efsStatusCode = efsStatusCode;
    }

    public String getEfsStatus() {
        return efsStatus;
    }

    public void setEfsStatus(String efsStatus) {
        this.efsStatus = efsStatus;
    }

    public String getEfsStatysDate() {
        return efsStatysDate;
    }

    public void setEfsStatysDate(String efsStatysDate) {
        this.efsStatysDate = efsStatysDate;
    }

    public String getWgtCharge() {
        return wgtCharge;
    }

    public void setWgtCharge(String wgtCharge) {
        this.wgtCharge = wgtCharge;
    }

    public String getWgtReal() {
        return wgtReal;
    }

    public void setWgtReal(String wgtReal) {
        this.wgtReal = wgtReal;
    }

    public String getBoxWidth() {
        return boxWidth;
    }

    public void setBoxWidth(String boxWidth) {
        this.boxWidth = boxWidth;
    }

    public String getBoxLength() {
        return boxLength;
    }

    public void setBoxLength(String boxLength) {
        this.boxLength = boxLength;
    }

    public String getBoxHeight() {
        return boxHeight;
    }

    public void setBoxHeight(String boxHeight) {
        this.boxHeight = boxHeight;
    }

    public String getWgtVolume() {
        return wgtVolume;
    }

    public void setWgtVolume(String wgtVolume) {
        this.wgtVolume = wgtVolume;
    }

    public String getShipMethodCd() {
        return shipMethodCd;
    }

    public void setShipMethodCd(String shipMethodCd) {
        this.shipMethodCd = shipMethodCd;
    }

    public String getShippingPrice() {
        return shippingPrice;
    }

    public void setShippingPrice(String shippingPrice) {
        this.shippingPrice = shippingPrice;
    }

    public String getShippingNation() {
        return shippingNation;
    }

    public void setShippingNation(String shippingNation) {
        this.shippingNation = shippingNation;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tefsInvcSno: ");
        builder.append(efsInvcSno);
        builder.append("\n\txrtInvcSno: ");
        builder.append(xrtInvcSno);
        builder.append("\n\tlocalShipper: ");
        builder.append(localShipper);
        builder.append("\n\tinvcSno: ");
        builder.append(invcSno);
        builder.append("\n\tefsStatusCode: ");
        builder.append(efsStatusCode);
        builder.append("\n\tefsStatus: ");
        builder.append(efsStatus);
        builder.append("\n\tefsStatysDate: ");
        builder.append(efsStatysDate);
        builder.append("\n\twgtCharge: ");
        builder.append(wgtCharge);
        builder.append("\n\twgtReal: ");
        builder.append(wgtReal);
        builder.append("\n\tboxWidth: ");
        builder.append(boxWidth);
        builder.append("\n\tboxLength: ");
        builder.append(boxLength);
        builder.append("\n\tboxHeight: ");
        builder.append(boxHeight);
        builder.append("\n\twgtVolume: ");
        builder.append(wgtVolume);
        builder.append("\n\tshipMethodCd: ");
        builder.append(shipMethodCd);
        builder.append("\n\tshippingPrice: ");
        builder.append(shippingPrice);
        builder.append("\n\tshippingNation: ");
        builder.append(shippingNation);
        builder.append("\n}");
        return builder.toString();
    }
}
