package xrt.alexcloud.api.etomars.vo;

import java.io.Serializable;
import java.util.List;

public class EtomarsDataVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String regNo; // 접수번호
    private String status; // 상태(Status > 0 : 성공)
    private String statusDesc; // 상태설명
    private String orderNo1; // 주문번호1
    private String orderNo2; // 주문번호2
    private String delvNo; // 도착국가 택배번호
    private String delvCom; // 택배회사코드
    private String delvComName; // 택배회사 이름
    private String nationCode; // 배송국가코드
    private String shippingType; // 배송타입(A~Z)
    private String senderName; // 발송인 이름
    private String senderTelno; // 발송인 전화번호
    private String senderAddr; // 발송인 주소
    private String receiverName; // 수취인 이름
    private String receiverNameYomigana; // 수취인 이름(요미가나-일본)
    private String receiverTelNo1; // 수취인 전화번호1
    private String receiverTelNo2; // 수취인 전화번호2
    private String receiverZipcode; // 수취인 우편번호
    private String receiverState; // 수취인 주소-성
    private String receiverCity; // 수취인 주소-시
    private String receiverDistrict; // 수취인 주소-구
    private String receiverDetailAddr; // 수취인 나머지 주소
    private String receiverEmail; // 수취인 이메일주소
    private String receiverSocialNo; // 수취인 신분증번호
    private String realWeight; // 무게
    private String weightUnit; // 무게단위(KG/LB)
    private int boxCount; // 박스갯수
    private String currencyUnit; // 화폐단위
    private String delvMessage; // 배송메세지
    private String userData1; // 사용자 데이터1
    private String userData2; // 사용자 데이터2
    private String userData3; // 사용자 데이터3
    private String dimWidth; // 가로
    private String dimLength; // 세로
    private String dimHeight; // 높이
    private String dimUnit; // 치수단위(cm/inch)
    private List<EtomarsDataDtlVo> goodsList; // 상품갯수만큼 리스트로 리턴

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

    public String getNationCode() {
        return nationCode;
    }

    public void setNationCode(String nationCode) {
        this.nationCode = nationCode;
    }

    public String getShippingType() {
        return shippingType;
    }

    public void setShippingType(String shippingType) {
        this.shippingType = shippingType;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getSenderTelno() {
        return senderTelno;
    }

    public void setSenderTelno(String senderTelno) {
        this.senderTelno = senderTelno;
    }

    public String getSenderAddr() {
        return senderAddr;
    }

    public void setSenderAddr(String senderAddr) {
        this.senderAddr = senderAddr;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverNameYomigana() {
        return receiverNameYomigana;
    }

    public void setReceiverNameYomigana(String receiverNameYomigana) {
        this.receiverNameYomigana = receiverNameYomigana;
    }

    public String getReceiverTelNo1() {
        return receiverTelNo1;
    }

    public void setReceiverTelNo1(String receiverTelNo1) {
        this.receiverTelNo1 = receiverTelNo1;
    }

    public String getReceiverTelNo2() {
        return receiverTelNo2;
    }

    public void setReceiverTelNo2(String receiverTelNo2) {
        this.receiverTelNo2 = receiverTelNo2;
    }

    public String getReceiverZipcode() {
        return receiverZipcode;
    }

    public void setReceiverZipcode(String receiverZipcode) {
        this.receiverZipcode = receiverZipcode;
    }

    public String getReceiverState() {
        return receiverState;
    }

    public void setReceiverState(String receiverState) {
        this.receiverState = receiverState;
    }

    public String getReceiverCity() {
        return receiverCity;
    }

    public void setReceiverCity(String receiverCity) {
        this.receiverCity = receiverCity;
    }

    public String getReceiverDistrict() {
        return receiverDistrict;
    }

    public void setReceiverDistrict(String receiverDistrict) {
        this.receiverDistrict = receiverDistrict;
    }

    public String getReceiverDetailAddr() {
        return receiverDetailAddr;
    }

    public void setReceiverDetailAddr(String receiverDetailAddr) {
        this.receiverDetailAddr = receiverDetailAddr;
    }

    public String getReceiverEmail() {
        return receiverEmail;
    }

    public void setReceiverEmail(String receiverEmail) {
        this.receiverEmail = receiverEmail;
    }

    public String getReceiverSocialNo() {
        return receiverSocialNo;
    }

    public void setReceiverSocialNo(String receiverSocialNo) {
        this.receiverSocialNo = receiverSocialNo;
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

    public int getBoxCount() {
        return boxCount;
    }

    public void setBoxCount(int boxCount) {
        this.boxCount = boxCount;
    }

    public String getCurrencyUnit() {
        return currencyUnit;
    }

    public void setCurrencyUnit(String currencyUnit) {
        this.currencyUnit = currencyUnit;
    }

    public String getDelvMessage() {
        return delvMessage;
    }

    public void setDelvMessage(String delvMessage) {
        this.delvMessage = delvMessage;
    }

    public String getUserData1() {
        return userData1;
    }

    public void setUserData1(String userData1) {
        this.userData1 = userData1;
    }

    public String getUserData2() {
        return userData2;
    }

    public void setUserData2(String userData2) {
        this.userData2 = userData2;
    }

    public String getUserData3() {
        return userData3;
    }

    public void setUserData3(String userData3) {
        this.userData3 = userData3;
    }

    public String getDimWidth() {
        return dimWidth;
    }

    public void setDimWidth(String dimWidth) {
        this.dimWidth = dimWidth;
    }

    public String getDimLength() {
        return dimLength;
    }

    public void setDimLength(String dimLength) {
        this.dimLength = dimLength;
    }

    public String getDimHeight() {
        return dimHeight;
    }

    public void setDimHeight(String dimHeight) {
        this.dimHeight = dimHeight;
    }

    public String getDimUnit() {
        return dimUnit;
    }

    public void setDimUnit(String dimUnit) {
        this.dimUnit = dimUnit;
    }

    public List<EtomarsDataDtlVo> getGoodsList() {
        return goodsList;
    }

    public void setGoodsList(List<EtomarsDataDtlVo> goodsList) {
        this.goodsList = goodsList;
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
        builder.append("\n\tnationCode: ");
        builder.append(nationCode);
        builder.append("\n\tshippingType: ");
        builder.append(shippingType);
        builder.append("\n\tsenderName: ");
        builder.append(senderName);
        builder.append("\n\tsenderTelno: ");
        builder.append(senderTelno);
        builder.append("\n\tsenderAddr: ");
        builder.append(senderAddr);
        builder.append("\n\treceiverName: ");
        builder.append(receiverName);
        builder.append("\n\treceiverNameYomigana: ");
        builder.append(receiverNameYomigana);
        builder.append("\n\treceiverTelNo1: ");
        builder.append(receiverTelNo1);
        builder.append("\n\treceiverTelNo2: ");
        builder.append(receiverTelNo2);
        builder.append("\n\treceiverZipcode: ");
        builder.append(receiverZipcode);
        builder.append("\n\treceiverState: ");
        builder.append(receiverState);
        builder.append("\n\treceiverCity: ");
        builder.append(receiverCity);
        builder.append("\n\treceiverDistrict: ");
        builder.append(receiverDistrict);
        builder.append("\n\treceiverDetailAddr: ");
        builder.append(receiverDetailAddr);
        builder.append("\n\treceiverEmail: ");
        builder.append(receiverEmail);
        builder.append("\n\treceiverSocialNo: ");
        builder.append(receiverSocialNo);
        builder.append("\n\trealWeight: ");
        builder.append(realWeight);
        builder.append("\n\tweightUnit: ");
        builder.append(weightUnit);
        builder.append("\n\tboxCount: ");
        builder.append(boxCount);
        builder.append("\n\tcurrencyUnit: ");
        builder.append(currencyUnit);
        builder.append("\n\tdelvMessage: ");
        builder.append(delvMessage);
        builder.append("\n\tuserData1: ");
        builder.append(userData1);
        builder.append("\n\tuserData2: ");
        builder.append(userData2);
        builder.append("\n\tuserData3: ");
        builder.append(userData3);
        builder.append("\n\tdimWidth: ");
        builder.append(dimWidth);
        builder.append("\n\tdimLength: ");
        builder.append(dimLength);
        builder.append("\n\tdimHeight: ");
        builder.append(dimHeight);
        builder.append("\n\tdimUnit: ");
        builder.append(dimUnit);
        builder.append("\n\tgoodsList: ");
        builder.append(goodsList);
        builder.append("\n}");
        return builder.toString();
    }
}
