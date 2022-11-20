package xrt.fulfillment.order.manual.etsy;

import java.io.Serializable;

public class EtsyVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String orderEtsySeq;
    private String compcd;
    private String orgcd;
    private String whcd;
    private String fileYmd;
    private int fileSeq;
    private String saleDate; // 판매 일자
    private String itemName; // 상품 이름
    private String buyer; // 구매자
    private String quantity; // 수량
    private String price; // 가격
    private String couponCode; // 쿠폰카드
    private String couponDetails; // 쿠폰 상세설명
    private String discountAmount; // 할인 금액
    private String shippingDiscount; // 배송 할인금액
    private String orderShipping; // 주문 배송
    private String orderSalesTax; // 주문 판매 세금
    private String itemTotal; // 상품 전체 가격
    private String currency; // 통화
    private String transactionId; // 거래 ID
    private String listingId; // 목록 ID
    private String datePaid; // 지불 일자
    private String dateShipped; // 배송 일자
    private String shipName; // 배송자
    private String shipAddress1; // 배송 주소1
    private String shipAddress2; // 배송 주소2
    private String shipCity; // 배송 도시
    private String shipState; // 배송 주
    private String shipZipcode; // 배송 우편번호
    private String shipCountry; // 배송 국가
    private String orderId; // 주문 ID
    private String variations; // 변형
    private String orderType; // 주문 유형
    private String listingsType; // 목록 유형
    private String paymentType; // 결제 유형
    private String inpersonDiscount; // 직접 할인
    private String inpersonLocation; // 대면 위치
    private String vatPaidByBuyer; // 구매자가 지불 하는 VAT
    private String sku; // 재고 유지 단위(stock keeping unit)
    private String itemCount;
    private String regYn;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;

    public String getOrderEtsySeq() {
        return orderEtsySeq;
    }

    public void setOrderEtsySeq(String orderEtsySeq) {
        this.orderEtsySeq = orderEtsySeq;
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

    public String getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(String saleDate) {
        this.saleDate = saleDate;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getBuyer() {
        return buyer;
    }

    public void setBuyer(String buyer) {
        this.buyer = buyer;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public String getCouponDetails() {
        return couponDetails;
    }

    public void setCouponDetails(String couponDetails) {
        this.couponDetails = couponDetails;
    }

    public String getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(String discountAmount) {
        this.discountAmount = discountAmount;
    }

    public String getShippingDiscount() {
        return shippingDiscount;
    }

    public void setShippingDiscount(String shippingDiscount) {
        this.shippingDiscount = shippingDiscount;
    }

    public String getOrderShipping() {
        return orderShipping;
    }

    public void setOrderShipping(String orderShipping) {
        this.orderShipping = orderShipping;
    }

    public String getOrderSalesTax() {
        return orderSalesTax;
    }

    public void setOrderSalesTax(String orderSalesTax) {
        this.orderSalesTax = orderSalesTax;
    }

    public String getItemTotal() {
        return itemTotal;
    }

    public void setItemTotal(String itemTotal) {
        this.itemTotal = itemTotal;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getListingId() {
        return listingId;
    }

    public void setListingId(String listingId) {
        this.listingId = listingId;
    }

    public String getDatePaid() {
        return datePaid;
    }

    public void setDatePaid(String datePaid) {
        this.datePaid = datePaid;
    }

    public String getDateShipped() {
        return dateShipped;
    }

    public void setDateShipped(String dateShipped) {
        this.dateShipped = dateShipped;
    }

    public String getShipName() {
        return shipName;
    }

    public void setShipName(String shipName) {
        this.shipName = shipName;
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

    public String getShipZipcode() {
        return shipZipcode;
    }

    public void setShipZipcode(String shipZipcode) {
        this.shipZipcode = shipZipcode;
    }

    public String getShipCountry() {
        return shipCountry;
    }

    public void setShipCountry(String shipCountry) {
        this.shipCountry = shipCountry;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getVariations() {
        return variations;
    }

    public void setVariations(String variations) {
        this.variations = variations;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    public String getListingsType() {
        return listingsType;
    }

    public void setListingsType(String listingsType) {
        this.listingsType = listingsType;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getInpersonDiscount() {
        return inpersonDiscount;
    }

    public void setInpersonDiscount(String inpersonDiscount) {
        this.inpersonDiscount = inpersonDiscount;
    }

    public String getInpersonLocation() {
        return inpersonLocation;
    }

    public void setInpersonLocation(String inpersonLocation) {
        this.inpersonLocation = inpersonLocation;
    }

    public String getVatPaidByBuyer() {
        return vatPaidByBuyer;
    }

    public void setVatPaidByBuyer(String vatPaidByBuyer) {
        this.vatPaidByBuyer = vatPaidByBuyer;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getItemCount() {
        return itemCount;
    }

    public void setItemCount(String itemCount) {
        this.itemCount = itemCount;
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
        builder.append(" {\n\torderEtsySeq: ");
        builder.append(orderEtsySeq);
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
        builder.append("\n\tsaleDate: ");
        builder.append(saleDate);
        builder.append("\n\titemName: ");
        builder.append(itemName);
        builder.append("\n\tbuyer: ");
        builder.append(buyer);
        builder.append("\n\tquantity: ");
        builder.append(quantity);
        builder.append("\n\tprice: ");
        builder.append(price);
        builder.append("\n\tcouponCode: ");
        builder.append(couponCode);
        builder.append("\n\tcouponDetails: ");
        builder.append(couponDetails);
        builder.append("\n\tdiscountAmount: ");
        builder.append(discountAmount);
        builder.append("\n\tshippingDiscount: ");
        builder.append(shippingDiscount);
        builder.append("\n\torderShipping: ");
        builder.append(orderShipping);
        builder.append("\n\torderSalesTax: ");
        builder.append(orderSalesTax);
        builder.append("\n\titemTotal: ");
        builder.append(itemTotal);
        builder.append("\n\tcurrency: ");
        builder.append(currency);
        builder.append("\n\ttransactionId: ");
        builder.append(transactionId);
        builder.append("\n\tlistingId: ");
        builder.append(listingId);
        builder.append("\n\tdatePaid: ");
        builder.append(datePaid);
        builder.append("\n\tdateShipped: ");
        builder.append(dateShipped);
        builder.append("\n\tshipName: ");
        builder.append(shipName);
        builder.append("\n\tshipAddress1: ");
        builder.append(shipAddress1);
        builder.append("\n\tshipAddress2: ");
        builder.append(shipAddress2);
        builder.append("\n\tshipCity: ");
        builder.append(shipCity);
        builder.append("\n\tshipState: ");
        builder.append(shipState);
        builder.append("\n\tshipZipcode: ");
        builder.append(shipZipcode);
        builder.append("\n\tshipCountry: ");
        builder.append(shipCountry);
        builder.append("\n\torderId: ");
        builder.append(orderId);
        builder.append("\n\tvariations: ");
        builder.append(variations);
        builder.append("\n\torderType: ");
        builder.append(orderType);
        builder.append("\n\tlistingsType: ");
        builder.append(listingsType);
        builder.append("\n\tpaymentType: ");
        builder.append(paymentType);
        builder.append("\n\tinpersonDiscount: ");
        builder.append(inpersonDiscount);
        builder.append("\n\tinpersonLocation: ");
        builder.append(inpersonLocation);
        builder.append("\n\tvatPaidByBuyer: ");
        builder.append(vatPaidByBuyer);
        builder.append("\n\tsku: ");
        builder.append(sku);
        builder.append("\n\titemCount: ");
        builder.append(itemCount);
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
