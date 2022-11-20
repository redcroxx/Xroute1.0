package xrt.fulfillment.order.kokusai;

import java.io.Serializable;

public class KokusaiVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String orderNo1; // 주문번호1. (송장번호)
    private String orderNo2; // 주문번호2
    private String shippingType; // 배송타입.
    private String senderName; // 발송인 이름.
    private String senderAddress; // 발송인 주소.
    private String senderPhoneno; // 발송인 전화번호.
    private String consigneeName; // 수취인 이름.
    private String yomigana; // 수취인 이름 요미가나.
    private String consigneeAddress; // 수취인 주소.
    private String consigneePostalcode; // 수취인 우편번호.
    private String consigneePhoneno; // 수취인 전화번호.
    private String consigneeEmailId; // 수취인 이메일.
    private String deliveryDate; // 배송 요청 일자.
    private String deliveryTime; // 배송 요청 시간.
    private String boxCount; // 박스 갯수.
    private String weight; // 전체 무게.
    private String codAmount; // 다이비끼 금액.
    private String width; // 가로
    private String length; // 세로
    private String height; // 높이
    private String uploadDate; // 업로드 날짜.
    private String userData; // 사용자 데이터
    private String currencyUnit; // 통화 단위
    private String itemCode; // 상품 코드
    private String itemName; // 상품명
    private String material; // 재질
    private String itemAmount; // 개수.
    private String unitPrice; // 단가.
    private String itemOrigin; // 원산지
    private String purchaseUrl; // 구매 URL
    private String salesSite; // 판매 사이트
    private String productOrderNo; // 주문 번호
    
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
    public String getSenderAddress() {
        return senderAddress;
    }
    public void setSenderAddress(String senderAddress) {
        this.senderAddress = senderAddress;
    }
    public String getSenderPhoneno() {
        return senderPhoneno;
    }
    public void setSenderPhoneno(String senderPhoneno) {
        this.senderPhoneno = senderPhoneno;
    }
    public String getConsigneeName() {
        return consigneeName;
    }
    public void setConsigneeName(String consigneeName) {
        this.consigneeName = consigneeName;
    }
    public String getYomigana() {
        return yomigana;
    }
    public void setYomigana(String yomigana) {
        this.yomigana = yomigana;
    }
    public String getConsigneeAddress() {
        return consigneeAddress;
    }
    public void setConsigneeAddress(String consigneeAddress) {
        this.consigneeAddress = consigneeAddress;
    }
    public String getConsigneePostalcode() {
        return consigneePostalcode;
    }
    public void setConsigneePostalcode(String consigneePostalcode) {
        this.consigneePostalcode = consigneePostalcode;
    }
    public String getConsigneePhoneno() {
        return consigneePhoneno;
    }
    public void setConsigneePhoneno(String consigneePhoneno) {
        this.consigneePhoneno = consigneePhoneno;
    }
    public String getConsigneeEmailId() {
        return consigneeEmailId;
    }
    public void setConsigneeEmailId(String consigneeEmailId) {
        this.consigneeEmailId = consigneeEmailId;
    }
    public String getDeliveryDate() {
        return deliveryDate;
    }
    public void setDeliveryDate(String deliveryDate) {
        this.deliveryDate = deliveryDate;
    }
    public String getDeliveryTime() {
        return deliveryTime;
    }
    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }
    public String getBoxCount() {
        return boxCount;
    }
    public void setBoxCount(String boxCount) {
        this.boxCount = boxCount;
    }
    public String getWeight() {
        return weight;
    }
    public void setWeight(String weight) {
        this.weight = weight;
    }
    public String getCodAmount() {
        return codAmount;
    }
    public void setCodAmount(String codAmount) {
        this.codAmount = codAmount;
    }
    public String getWidth() {
        return width;
    }
    public void setWidth(String width) {
        this.width = width;
    }
    public String getLength() {
        return length;
    }
    public void setLength(String length) {
        this.length = length;
    }
    public String getHeight() {
        return height;
    }
    public void setHeight(String height) {
        this.height = height;
    }
    public String getUploadDate() {
        return uploadDate;
    }
    public void setUploadDate(String uploadDate) {
        this.uploadDate = uploadDate;
    }
    public String getUserData() {
        return userData;
    }
    public void setUserData(String userData) {
        this.userData = userData;
    }
    public String getCurrencyUnit() {
        return currencyUnit;
    }
    public void setCurrencyUnit(String currencyUnit) {
        this.currencyUnit = currencyUnit;
    }
    public String getItemCode() {
        return itemCode;
    }
    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }
    public String getItemName() {
        return itemName;
    }
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }
    public String getMaterial() {
        return material;
    }
    public void setMaterial(String material) {
        this.material = material;
    }
    public String getItemAmount() {
        return itemAmount;
    }
    public void setItemAmount(String itemAmount) {
        this.itemAmount = itemAmount;
    }
    public String getUnitPrice() {
        return unitPrice;
    }
    public void setUnitPrice(String unitPrice) {
        this.unitPrice = unitPrice;
    }
    public String getItemOrigin() {
        return itemOrigin;
    }
    public void setItemOrigin(String itemOrigin) {
        this.itemOrigin = itemOrigin;
    }
    public String getPurchaseUrl() {
        return purchaseUrl;
    }
    public void setPurchaseUrl(String purchaseUrl) {
        this.purchaseUrl = purchaseUrl;
    }
    public String getSalesSite() {
        return salesSite;
    }
    public void setSalesSite(String salesSite) {
        this.salesSite = salesSite;
    }
    public String getProductOrderNo() {
        return productOrderNo;
    }
    public void setProductOrderNo(String productOrderNo) {
        this.productOrderNo = productOrderNo;
    }
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("KokusaiVO {\n    orderNo1 : ");
        builder.append(orderNo1);
        builder.append(",\n    orderNo2 : ");
        builder.append(orderNo2);
        builder.append(",\n    shippingType : ");
        builder.append(shippingType);
        builder.append(",\n    senderName : ");
        builder.append(senderName);
        builder.append(",\n    senderAddress : ");
        builder.append(senderAddress);
        builder.append(",\n    senderPhoneno : ");
        builder.append(senderPhoneno);
        builder.append(",\n    consigneeName : ");
        builder.append(consigneeName);
        builder.append(",\n    yomigana : ");
        builder.append(yomigana);
        builder.append(",\n    consigneeAddress : ");
        builder.append(consigneeAddress);
        builder.append(",\n    consigneePostalcode : ");
        builder.append(consigneePostalcode);
        builder.append(",\n    consigneePhoneno : ");
        builder.append(consigneePhoneno);
        builder.append(",\n    consigneeEmailId : ");
        builder.append(consigneeEmailId);
        builder.append(",\n    deliveryDate : ");
        builder.append(deliveryDate);
        builder.append(",\n    deliveryTime : ");
        builder.append(deliveryTime);
        builder.append(",\n    boxCount : ");
        builder.append(boxCount);
        builder.append(",\n    weight : ");
        builder.append(weight);
        builder.append(",\n    codAmount : ");
        builder.append(codAmount);
        builder.append(",\n    width : ");
        builder.append(width);
        builder.append(",\n    length : ");
        builder.append(length);
        builder.append(",\n    height : ");
        builder.append(height);
        builder.append(",\n    uploadDate : ");
        builder.append(uploadDate);
        builder.append(",\n    userData : ");
        builder.append(userData);
        builder.append(",\n    currencyUnit : ");
        builder.append(currencyUnit);
        builder.append(",\n    itemCode : ");
        builder.append(itemCode);
        builder.append(",\n    itemName : ");
        builder.append(itemName);
        builder.append(",\n    material : ");
        builder.append(material);
        builder.append(",\n    itemAmount : ");
        builder.append(itemAmount);
        builder.append(",\n    unitPrice : ");
        builder.append(unitPrice);
        builder.append(",\n    itemOrigin : ");
        builder.append(itemOrigin);
        builder.append(",\n    purchaseUrl : ");
        builder.append(purchaseUrl);
        builder.append(",\n    salesSite : ");
        builder.append(salesSite);
        builder.append(",\n    productOrderNo : ");
        builder.append(productOrderNo);
        builder.append("\n}");
        return builder.toString();
    }
}
