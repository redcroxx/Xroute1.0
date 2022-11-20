package xrt.alexcloud.api.etomars.vo;

import java.io.Serializable;
import java.util.List;

public class EtomarsShipmentVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String NationCode; // 배송국가코드;
    private String ShippingType; // 배송타입(A~Z);
    private String OrderNo1; // 주문번호1;
    private String OrderNo2; // 주문번호2;
    private String SenderName; // 발송인 이름;
    private String SenderTelno; // 발송인 전화번호;
    private String SenderAddr; // 발송인 주소;
    private String ReceiverName; // 수취인 이름;
    private String ReceiverNameYomigana; // 수취인 이름 요미가나 (일본);
    private String ReceiverNameExpEng; // 수취인 영문이름(수출신고용);
    private String ReceiverTelNo1; // 수취인 전화번호1;
    private String ReceiverTelNo2; // 수취인 전화번호2;
    private String ReceiverZipcode; // 수취인 우편번호;
    private String ReceiverState; // 수취인 주소-성;
    private String ReceiverCity; // 수취인 주소-시;
    private String ReceiverDistrict; // 수취인 주소-구;
    private String ReceiverDetailAddr; // 수취인 나머지 주소;
    private String ReceiverEmail; // 수취인 이메일주소;
    private String ReceiverSocialNo; // 수취인 신분증번호;
    private String RealWeight; // 무게 (기본값 : 1);
    private String WeightUnit; // 무게단위(KG/LB);
    private String BoxCount; // 박스갯수 (기본값 : 1);
    private String CurrencyUnit; // 화폐단위;
    private String DelvMessage; // 배송메세지;
    private String UserData1; // 사용자 데이터1;
    private String UserData2; // 사용자 데이터2;
    private String UserData3; // 사용자 데이터3;
    private String DimWidth; // 가로;
    private String DimLength; // 세로;
    private String DimHeight; // 높이;
    private String DimUnit; // 치수단위(cm/inch);
    private String DelvNo; // 도착국가 택배번호(미리 부여받은 경우만 입력);
    private String DelvCom; // 택배회사코드(미리 부여받은 경우만 입력);
    private String StockMode; // 재고포장배송요청(3PL);
    private String SalesSite; // 판매Site;
    private List<EtomarsOrderDtlVo> GoodsList; // 상품갯수만큼 리스트로 작성;

    public String getNationCode() {
        return NationCode;
    }

    public void setNationCode(String nationCode) {
        NationCode = nationCode;
    }

    public String getShippingType() {
        return ShippingType;
    }

    public void setShippingType(String shippingType) {
        ShippingType = shippingType;
    }

    public String getOrderNo1() {
        return OrderNo1;
    }

    public void setOrderNo1(String orderNo1) {
        OrderNo1 = orderNo1;
    }

    public String getOrderNo2() {
        return OrderNo2;
    }

    public void setOrderNo2(String orderNo2) {
        OrderNo2 = orderNo2;
    }

    public String getSenderName() {
        return SenderName;
    }

    public void setSenderName(String senderName) {
        SenderName = senderName;
    }

    public String getSenderTelno() {
        return SenderTelno;
    }

    public void setSenderTelno(String senderTelno) {
        SenderTelno = senderTelno;
    }

    public String getSenderAddr() {
        return SenderAddr;
    }

    public void setSenderAddr(String senderAddr) {
        SenderAddr = senderAddr;
    }

    public String getReceiverName() {
        return ReceiverName;
    }

    public void setReceiverName(String receiverName) {
        ReceiverName = receiverName;
    }

    public String getReceiverNameYomigana() {
        return ReceiverNameYomigana;
    }

    public void setReceiverNameYomigana(String receiverNameYomigana) {
        ReceiverNameYomigana = receiverNameYomigana;
    }

    public String getReceiverNameExpEng() {
        return ReceiverNameExpEng;
    }

    public void setReceiverNameExpEng(String receiverNameExpEng) {
        ReceiverNameExpEng = receiverNameExpEng;
    }

    public String getReceiverTelNo1() {
        return ReceiverTelNo1;
    }

    public void setReceiverTelNo1(String receiverTelNo1) {
        ReceiverTelNo1 = receiverTelNo1;
    }

    public String getReceiverTelNo2() {
        return ReceiverTelNo2;
    }

    public void setReceiverTelNo2(String receiverTelNo2) {
        ReceiverTelNo2 = receiverTelNo2;
    }

    public String getReceiverZipcode() {
        return ReceiverZipcode;
    }

    public void setReceiverZipcode(String receiverZipcode) {
        ReceiverZipcode = receiverZipcode;
    }

    public String getReceiverState() {
        return ReceiverState;
    }

    public void setReceiverState(String receiverState) {
        ReceiverState = receiverState;
    }

    public String getReceiverCity() {
        return ReceiverCity;
    }

    public void setReceiverCity(String receiverCity) {
        ReceiverCity = receiverCity;
    }

    public String getReceiverDistrict() {
        return ReceiverDistrict;
    }

    public void setReceiverDistrict(String receiverDistrict) {
        ReceiverDistrict = receiverDistrict;
    }

    public String getReceiverDetailAddr() {
        return ReceiverDetailAddr;
    }

    public void setReceiverDetailAddr(String receiverDetailAddr) {
        ReceiverDetailAddr = receiverDetailAddr;
    }

    public String getReceiverEmail() {
        return ReceiverEmail;
    }

    public void setReceiverEmail(String receiverEmail) {
        ReceiverEmail = receiverEmail;
    }

    public String getReceiverSocialNo() {
        return ReceiverSocialNo;
    }

    public void setReceiverSocialNo(String receiverSocialNo) {
        ReceiverSocialNo = receiverSocialNo;
    }

    public String getRealWeight() {
        return RealWeight;
    }

    public void setRealWeight(String realWeight) {
        RealWeight = realWeight;
    }

    public String getWeightUnit() {
        return WeightUnit;
    }

    public void setWeightUnit(String weightUnit) {
        WeightUnit = weightUnit;
    }

    public String getBoxCount() {
        return BoxCount;
    }

    public void setBoxCount(String boxCount) {
        BoxCount = boxCount;
    }

    public String getCurrencyUnit() {
        return CurrencyUnit;
    }

    public void setCurrencyUnit(String currencyUnit) {
        CurrencyUnit = currencyUnit;
    }

    public String getDelvMessage() {
        return DelvMessage;
    }

    public void setDelvMessage(String delvMessage) {
        DelvMessage = delvMessage;
    }

    public String getUserData1() {
        return UserData1;
    }

    public void setUserData1(String userData1) {
        UserData1 = userData1;
    }

    public String getUserData2() {
        return UserData2;
    }

    public void setUserData2(String userData2) {
        UserData2 = userData2;
    }

    public String getUserData3() {
        return UserData3;
    }

    public void setUserData3(String userData3) {
        UserData3 = userData3;
    }

    public String getDimWidth() {
        return DimWidth;
    }

    public void setDimWidth(String dimWidth) {
        DimWidth = dimWidth;
    }

    public String getDimLength() {
        return DimLength;
    }

    public void setDimLength(String dimLength) {
        DimLength = dimLength;
    }

    public String getDimHeight() {
        return DimHeight;
    }

    public void setDimHeight(String dimHeight) {
        DimHeight = dimHeight;
    }

    public String getDimUnit() {
        return DimUnit;
    }

    public void setDimUnit(String dimUnit) {
        DimUnit = dimUnit;
    }

    public String getDelvNo() {
        return DelvNo;
    }

    public void setDelvNo(String delvNo) {
        DelvNo = delvNo;
    }

    public String getDelvCom() {
        return DelvCom;
    }

    public void setDelvCom(String delvCom) {
        DelvCom = delvCom;
    }

    public String getStockMode() {
        return StockMode;
    }

    public void setStockMode(String stockMode) {
        StockMode = stockMode;
    }

    public String getSalesSite() {
        return SalesSite;
    }

    public void setSalesSite(String salesSite) {
        SalesSite = salesSite;
    }

    public List<EtomarsOrderDtlVo> getGoodsList() {
        return GoodsList;
    }

    public void setGoodsList(List<EtomarsOrderDtlVo> goodsList) {
        GoodsList = goodsList;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tNationCode: ");
        builder.append(NationCode);
        builder.append("\n\tShippingType: ");
        builder.append(ShippingType);
        builder.append("\n\tOrderNo1: ");
        builder.append(OrderNo1);
        builder.append("\n\tOrderNo2: ");
        builder.append(OrderNo2);
        builder.append("\n\tSenderName: ");
        builder.append(SenderName);
        builder.append("\n\tSenderTelno: ");
        builder.append(SenderTelno);
        builder.append("\n\tSenderAddr: ");
        builder.append(SenderAddr);
        builder.append("\n\tReceiverName: ");
        builder.append(ReceiverName);
        builder.append("\n\tReceiverNameYomigana: ");
        builder.append(ReceiverNameYomigana);
        builder.append("\n\tReceiverNameExpEng: ");
        builder.append(ReceiverNameExpEng);
        builder.append("\n\tReceiverTelNo1: ");
        builder.append(ReceiverTelNo1);
        builder.append("\n\tReceiverTelNo2: ");
        builder.append(ReceiverTelNo2);
        builder.append("\n\tReceiverZipcode: ");
        builder.append(ReceiverZipcode);
        builder.append("\n\tReceiverState: ");
        builder.append(ReceiverState);
        builder.append("\n\tReceiverCity: ");
        builder.append(ReceiverCity);
        builder.append("\n\tReceiverDistrict: ");
        builder.append(ReceiverDistrict);
        builder.append("\n\tReceiverDetailAddr: ");
        builder.append(ReceiverDetailAddr);
        builder.append("\n\tReceiverEmail: ");
        builder.append(ReceiverEmail);
        builder.append("\n\tReceiverSocialNo: ");
        builder.append(ReceiverSocialNo);
        builder.append("\n\tRealWeight: ");
        builder.append(RealWeight);
        builder.append("\n\tWeightUnit: ");
        builder.append(WeightUnit);
        builder.append("\n\tBoxCount: ");
        builder.append(BoxCount);
        builder.append("\n\tCurrencyUnit: ");
        builder.append(CurrencyUnit);
        builder.append("\n\tDelvMessage: ");
        builder.append(DelvMessage);
        builder.append("\n\tUserData1: ");
        builder.append(UserData1);
        builder.append("\n\tUserData2: ");
        builder.append(UserData2);
        builder.append("\n\tUserData3: ");
        builder.append(UserData3);
        builder.append("\n\tDimWidth: ");
        builder.append(DimWidth);
        builder.append("\n\tDimLength: ");
        builder.append(DimLength);
        builder.append("\n\tDimHeight: ");
        builder.append(DimHeight);
        builder.append("\n\tDimUnit: ");
        builder.append(DimUnit);
        builder.append("\n\tDelvNo: ");
        builder.append(DelvNo);
        builder.append("\n\tDelvCom: ");
        builder.append(DelvCom);
        builder.append("\n\tStockMode: ");
        builder.append(StockMode);
        builder.append("\n\tSalesSite: ");
        builder.append(SalesSite);
        builder.append("\n\tGoodsList: ");
        builder.append(GoodsList);
        builder.append("\n}");
        return builder.toString();
    }

}