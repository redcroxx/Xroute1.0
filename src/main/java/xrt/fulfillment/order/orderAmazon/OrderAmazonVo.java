package xrt.fulfillment.order.orderAmazon;

import java.io.Serializable;

public class OrderAmazonVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String orderAmazonSeq;
    private String compcd;
    private String orgcd;
    private String whcd;
    private String fileYmd;
    private int fileSeq;
    private String itemPrice; // 물품 가격
    private String orderId; // 주문 ID
    private String orderItemId; // 주문 물품 ID
    private String purchaseDate; // 구매 일자
    private String paymentsDate; // 결제 일자
    private String reportingDate; // 보고 일자
    private String promiseDate; // 약속 일자
    private String daysPastPromise; // 배송 약속일자
    private String buyerEmail; // 구매자 이메일
    private String buyerName; // 구매자 이름
    private String buyerPhoneNumber; // 구매자 연락처
    private String sku; // 상품 관리 명
    private String productName; // 상품 이름
    private String quantityPurchased; // 상품 구매 수
    private String quantityShipped; // 상품 배송
    private String quantityToShip; // 상품 배송 일자
    private String shipServiceLevel; // 배송 서비스 레벨
    private String recipientName; // 받는 사람 이름
    private String shipAddress1; // 배송 주소1
    private String shipAddress2; // 배송 주소2
    private String shipAddress3; // 배송 주소3
    private String shipCity; // 배송 도시
    private String shipState; // 배송 주
    private String shipPostalCode; // 배송 우편번호
    private String shipCountry; // 배송 국가
    private String regYn;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;

    public String getOrderAmazonSeq() {
        return orderAmazonSeq;
    }

    public void setOrderAmazonSeq(String orderAmazonSeq) {
        this.orderAmazonSeq = orderAmazonSeq;
    }

    public String getCompcd() {
        return compcd;
    }

    public void setCompcd(String compcd) {
        this.compcd = compcd;
    }

    public String getOrgcd() {
        return orgcd;
    }

    public void setOrgcd(String orgcd) {
        this.orgcd = orgcd;
    }

    public String getWhcd() {
        return whcd;
    }

    public void setWhcd(String whcd) {
        this.whcd = whcd;
    }

    public String getFileYmd() {
        return fileYmd;
    }

    public void setFileYmd(String fileYmd) {
        this.fileYmd = fileYmd;
    }

    public int getFileSeq() {
        return fileSeq;
    }

    public void setFileSeq(int fileSeq) {
        this.fileSeq = fileSeq;
    }

    public String getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(String itemPrice) {
        this.itemPrice = itemPrice;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(String orderItemId) {
        this.orderItemId = orderItemId;
    }

    public String getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(String purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public String getPaymentsDate() {
        return paymentsDate;
    }

    public void setPaymentsDate(String paymentsDate) {
        this.paymentsDate = paymentsDate;
    }

    public String getReportingDate() {
        return reportingDate;
    }

    public void setReportingDate(String reportingDate) {
        this.reportingDate = reportingDate;
    }

    public String getPromiseDate() {
        return promiseDate;
    }

    public void setPromiseDate(String promiseDate) {
        this.promiseDate = promiseDate;
    }

    public String getDaysPastPromise() {
        return daysPastPromise;
    }

    public void setDaysPastPromise(String daysPastPromise) {
        this.daysPastPromise = daysPastPromise;
    }

    public String getBuyerEmail() {
        return buyerEmail;
    }

    public void setBuyerEmail(String buyerEmail) {
        this.buyerEmail = buyerEmail;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public String getBuyerPhoneNumber() {
        return buyerPhoneNumber;
    }

    public void setBuyerPhoneNumber(String buyerPhoneNumber) {
        this.buyerPhoneNumber = buyerPhoneNumber;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getQuantityPurchased() {
        return quantityPurchased;
    }

    public void setQuantityPurchased(String quantityPurchased) {
        this.quantityPurchased = quantityPurchased;
    }

    public String getQuantityShipped() {
        return quantityShipped;
    }

    public void setQuantityShipped(String quantityShipped) {
        this.quantityShipped = quantityShipped;
    }

    public String getQuantityToShip() {
        return quantityToShip;
    }

    public void setQuantityToShip(String quantityToShip) {
        this.quantityToShip = quantityToShip;
    }

    public String getShipServiceLevel() {
        return shipServiceLevel;
    }

    public void setShipServiceLevel(String shipServiceLevel) {
        this.shipServiceLevel = shipServiceLevel;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getShipAddress1() {
        return shipAddress1;
    }

    public void setShipAddress1(String shipAddress1) {
        this.shipAddress1 = shipAddress1;
    }

    public String getShipAddress2() {
        return shipAddress2;
    }

    public void setShipAddress2(String shipAddress2) {
        this.shipAddress2 = shipAddress2;
    }

    public String getShipAddress3() {
        return shipAddress3;
    }

    public void setShipAddress3(String shipAddress3) {
        this.shipAddress3 = shipAddress3;
    }

    public String getShipCity() {
        return shipCity;
    }

    public void setShipCity(String shipCity) {
        this.shipCity = shipCity;
    }

    public String getShipState() {
        return shipState;
    }

    public void setShipState(String shipState) {
        this.shipState = shipState;
    }

    public String getShipPostalCode() {
        return shipPostalCode;
    }

    public void setShipPostalCode(String shipPostalCode) {
        this.shipPostalCode = shipPostalCode;
    }

    public String getShipCountry() {
        return shipCountry;
    }

    public void setShipCountry(String shipCountry) {
        this.shipCountry = shipCountry;
    }

    public String getRegYn() {
        return regYn;
    }

    public void setRegYn(String regYn) {
        this.regYn = regYn;
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
        builder.append(getClass().getName());
        builder.append(" {\n\torderAmazonSeq: ");
        builder.append(orderAmazonSeq);
        builder.append("\n\tcompcd: ");
        builder.append(compcd);
        builder.append("\n\torgcd: ");
        builder.append(orgcd);
        builder.append("\n\twhcd: ");
        builder.append(whcd);
        builder.append("\n\tfileYmd: ");
        builder.append(fileYmd);
        builder.append("\n\tfileSeq: ");
        builder.append(fileSeq);
        builder.append("\n\titemPrice: ");
        builder.append(itemPrice);
        builder.append("\n\torderId: ");
        builder.append(orderId);
        builder.append("\n\torderItemId: ");
        builder.append(orderItemId);
        builder.append("\n\tpurchaseDate: ");
        builder.append(purchaseDate);
        builder.append("\n\tpaymentsDate: ");
        builder.append(paymentsDate);
        builder.append("\n\treportingDate: ");
        builder.append(reportingDate);
        builder.append("\n\tpromiseDate: ");
        builder.append(promiseDate);
        builder.append("\n\tdaysPastPromise: ");
        builder.append(daysPastPromise);
        builder.append("\n\tbuyerEmail: ");
        builder.append(buyerEmail);
        builder.append("\n\tbuyerName: ");
        builder.append(buyerName);
        builder.append("\n\tbuyerPhoneNumber: ");
        builder.append(buyerPhoneNumber);
        builder.append("\n\tsku: ");
        builder.append(sku);
        builder.append("\n\tproductName: ");
        builder.append(productName);
        builder.append("\n\tquantityPurchased: ");
        builder.append(quantityPurchased);
        builder.append("\n\tquantityShipped: ");
        builder.append(quantityShipped);
        builder.append("\n\tquantityToShip: ");
        builder.append(quantityToShip);
        builder.append("\n\tshipServiceLevel: ");
        builder.append(shipServiceLevel);
        builder.append("\n\trecipientName: ");
        builder.append(recipientName);
        builder.append("\n\tshipAddress1: ");
        builder.append(shipAddress1);
        builder.append("\n\tshipAddress2: ");
        builder.append(shipAddress2);
        builder.append("\n\tshipAddress3: ");
        builder.append(shipAddress3);
        builder.append("\n\tshipCity: ");
        builder.append(shipCity);
        builder.append("\n\tshipState: ");
        builder.append(shipState);
        builder.append("\n\tshipPostalCode: ");
        builder.append(shipPostalCode);
        builder.append("\n\tshipCountry: ");
        builder.append(shipCountry);
        builder.append("\n\tregYn: ");
        builder.append(regYn);
        builder.append("\n\taddusercd: ");
        builder.append(addusercd);
        builder.append("\n\tadddatetime: ");
        builder.append(adddatetime);
        builder.append("\n\tupdusercd: ");
        builder.append(updusercd);
        builder.append("\n\tupddatetime: ");
        builder.append(upddatetime);
        builder.append("\n\tterminalcd: ");
        builder.append(terminalcd);
        builder.append("\n}");
        return builder.toString();
    }

}
