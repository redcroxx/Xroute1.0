package xrt.alexcloud.api.efs.vo;

import java.io.Serializable;
import java.util.List;

import xrt.interfaces.common.vo.EfsOrderDtlVo;

public class EfsShipmentVo implements Serializable {

    private static final long serialVersionUID = 1L;

    // private String reserveInvcNo; //송장번호(예약번호)
    private String xrtInvcNo; // xrt 송장번호
    private String shipMethodCd; // 물품 배송방식
    private String shipName; // 송화인명
    private String shipAddr; // 송화인 주소
    private String shipPost; // 송화인 우편번호
    private String shipTel; // 송화인 전화번호
    private String shipMobile; // 송화인 휴대폰
    private String recvName; // 수취인명
    private String recvAddr; // 수취인 주소
    private String recvPost; // 수취인 우편번호
    private String recvTel; // 수취인 전화번호
    private String recvMobile; // 수취인 휴대폰
    private String recvNation; // 수취인 국가
    private String recvCity; // 수취인 도시
    private String recvState; // 수취인 주
    private String sellerRefNo1; // 판매자 참조1
    private String sellerRefNo2; // 판매자 참조2
    private String recvCurrency; // 수취인 통화
    private String totPaymentPrice; // 결제금액

    private List<EfsOrderDtlVo> orderDtlList; // 오더상품상세리스트

    public String getXrtInvcNo() {
        return xrtInvcNo;
    }

    public void setXrtInvcNo(String xrtInvcNo) {
        this.xrtInvcNo = xrtInvcNo;
    }

    public String getShipMethodCd() {
        return shipMethodCd;
    }

    public void setShipMethodCd(String shipMethodCd) {
        this.shipMethodCd = shipMethodCd;
    }

    public String getShipName() {
        return shipName;
    }

    public void setShipName(String shipName) {
        this.shipName = shipName;
    }

    public String getShipAddr() {
        return shipAddr;
    }

    public void setShipAddr(String shipAddr) {
        this.shipAddr = shipAddr;
    }

    public String getShipPost() {
        return shipPost;
    }

    public void setShipPost(String shipPost) {
        this.shipPost = shipPost;
    }

    public String getShipTel() {
        return shipTel;
    }

    public void setShipTel(String shipTel) {
        this.shipTel = shipTel;
    }

    public String getShipMobile() {
        return shipMobile;
    }

    public void setShipMobile(String shipMobile) {
        this.shipMobile = shipMobile;
    }

    public String getRecvName() {
        return recvName;
    }

    public void setRecvName(String recvName) {
        this.recvName = recvName;
    }

    public String getRecvAddr() {
        return recvAddr;
    }

    public void setRecvAddr(String recvAddr) {
        this.recvAddr = recvAddr;
    }

    public String getRecvPost() {
        return recvPost;
    }

    public void setRecvPost(String recvPost) {
        this.recvPost = recvPost;
    }

    public String getRecvTel() {
        return recvTel;
    }

    public void setRecvTel(String recvTel) {
        this.recvTel = recvTel;
    }

    public String getRecvMobile() {
        return recvMobile;
    }

    public void setRecvMobile(String recvMobile) {
        this.recvMobile = recvMobile;
    }

    public String getRecvNation() {
        return recvNation;
    }

    public void setRecvNation(String recvNation) {
        this.recvNation = recvNation;
    }

    public String getRecvCity() {
        return recvCity;
    }

    public void setRecvCity(String recvCity) {
        this.recvCity = recvCity;
    }

    public String getRecvState() {
        return recvState;
    }

    public void setRecvState(String recvState) {
        this.recvState = recvState;
    }

    public String getSellerRefNo1() {
        return sellerRefNo1;
    }

    public void setSellerRefNo1(String sellerRefNo1) {
        this.sellerRefNo1 = sellerRefNo1;
    }

    public String getSellerRefNo2() {
        return sellerRefNo2;
    }

    public void setSellerRefNo2(String sellerRefNo2) {
        this.sellerRefNo2 = sellerRefNo2;
    }

    public String getRecvCurrency() {
        return recvCurrency;
    }

    public void setRecvCurrency(String recvCurrency) {
        this.recvCurrency = recvCurrency;
    }

    public String getTotPaymentPrice() {
        return totPaymentPrice;
    }

    public void setTotPaymentPrice(String totPaymentPrice) {
        this.totPaymentPrice = totPaymentPrice;
    }

    public List<EfsOrderDtlVo> getOrderDtlList() {
        return orderDtlList;
    }

    public void setOrderDtlList(List<EfsOrderDtlVo> orderDtlList) {
        this.orderDtlList = orderDtlList;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\txrtInvcNo: ");
        builder.append(xrtInvcNo);
        builder.append("\n\tshipMethodCd: ");
        builder.append(shipMethodCd);
        builder.append("\n\tshipName: ");
        builder.append(shipName);
        builder.append("\n\tshipAddr: ");
        builder.append(shipAddr);
        builder.append("\n\tshipPost: ");
        builder.append(shipPost);
        builder.append("\n\tshipTel: ");
        builder.append(shipTel);
        builder.append("\n\tshipMobile: ");
        builder.append(shipMobile);
        builder.append("\n\trecvName: ");
        builder.append(recvName);
        builder.append("\n\trecvAddr: ");
        builder.append(recvAddr);
        builder.append("\n\trecvPost: ");
        builder.append(recvPost);
        builder.append("\n\trecvTel: ");
        builder.append(recvTel);
        builder.append("\n\trecvMobile: ");
        builder.append(recvMobile);
        builder.append("\n\trecvNation: ");
        builder.append(recvNation);
        builder.append("\n\trecvCity: ");
        builder.append(recvCity);
        builder.append("\n\trecvState: ");
        builder.append(recvState);
        builder.append("\n\tsellerRefNo1: ");
        builder.append(sellerRefNo1);
        builder.append("\n\tsellerRefNo2: ");
        builder.append(sellerRefNo2);
        builder.append("\n\trecvCurrency: ");
        builder.append(recvCurrency);
        builder.append("\n\ttotPaymentPrice: ");
        builder.append(totPaymentPrice);
        builder.append("\n\torderDtlList: ");
        builder.append(orderDtlList);
        builder.append("\n}");
        return builder.toString();
    }
}
