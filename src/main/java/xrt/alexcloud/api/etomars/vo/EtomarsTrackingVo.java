package xrt.alexcloud.api.etomars.vo;

import java.io.Serializable;
import java.util.List;

public class EtomarsTrackingVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String regNo; // 접수번호
    private String status; // 상태(Status > 0 : 성공)
    private String statusDesc; // 상태설명
    private String orderNo1; // 주문번호1
    private String orderNo2; // 주문번호2
    private String delvNo; // 도착국가 택배번호
    private String delvCom; // 택배회사코드
    private String delvComName; // 택배회사 이름
    private String depCountryCode; // 출발국가 코드
    private String depCountryName; // 출발국가 이름
    private String arrCountryCode; // 도착국가 코드
    private String arrCountryName; // 도착국가 이름
    private List<EtomarsTrackingDtlVo> trackingList; // 트랙킹 갯수만큼 리스트로 리턴됨

    public String getRegNo() {
        return regNo;
    }

    public void setRegNo(String regNo) {
        this.regNo = regNo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatusDesc() {
        return statusDesc;
    }

    public void setStatusDesc(String statusDesc) {
        this.statusDesc = statusDesc;
    }

    public String getOrderNo1() {
        return orderNo1;
    }

    public void setOrderNo1(String orderNo1) {
        this.orderNo1 = orderNo1;
    }

    public String getOrderNo2() {
        return orderNo2;
    }

    public void setOrderNo2(String orderNo2) {
        this.orderNo2 = orderNo2;
    }

    public String getDelvNo() {
        return delvNo;
    }

    public void setDelvNo(String delvNo) {
        this.delvNo = delvNo;
    }

    public String getDelvCom() {
        return delvCom;
    }

    public void setDelvCom(String delvCom) {
        this.delvCom = delvCom;
    }

    public String getDelvComName() {
        return delvComName;
    }

    public void setDelvComName(String delvComName) {
        this.delvComName = delvComName;
    }

    public String getDepCountryCode() {
        return depCountryCode;
    }

    public void setDepCountryCode(String depCountryCode) {
        this.depCountryCode = depCountryCode;
    }

    public String getDepCountryName() {
        return depCountryName;
    }

    public void setDepCountryName(String depCountryName) {
        this.depCountryName = depCountryName;
    }

    public String getArrCountryCode() {
        return arrCountryCode;
    }

    public void setArrCountryCode(String arrCountryCode) {
        this.arrCountryCode = arrCountryCode;
    }

    public String getArrCountryName() {
        return arrCountryName;
    }

    public void setArrCountryName(String arrCountryName) {
        this.arrCountryName = arrCountryName;
    }

    public List<EtomarsTrackingDtlVo> getTrackingList() {
        return trackingList;
    }

    public void setTrackingList(List<EtomarsTrackingDtlVo> trackingList) {
        this.trackingList = trackingList;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tregNo: ");
        builder.append(regNo);
        builder.append("\n\tstatus: ");
        builder.append(status);
        builder.append("\n\tstatusDesc: ");
        builder.append(statusDesc);
        builder.append("\n\torderNo1: ");
        builder.append(orderNo1);
        builder.append("\n\torderNo2: ");
        builder.append(orderNo2);
        builder.append("\n\tdelvNo: ");
        builder.append(delvNo);
        builder.append("\n\tdelvCom: ");
        builder.append(delvCom);
        builder.append("\n\tdelvComName: ");
        builder.append(delvComName);
        builder.append("\n\tdepCountryCode: ");
        builder.append(depCountryCode);
        builder.append("\n\tdepCountryName: ");
        builder.append(depCountryName);
        builder.append("\n\tarrCountryCode: ");
        builder.append(arrCountryCode);
        builder.append("\n\tarrCountryName: ");
        builder.append(arrCountryName);
        builder.append("\n\ttrackingList: ");
        builder.append(trackingList);
        builder.append("\n}");
        return builder.toString();
    }
}
