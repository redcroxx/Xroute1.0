package xrt.fulfillment.order.manual.ebay;

import java.io.Serializable;

public class EbayVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String orderEbaySeq;
    private String compcd;
    private String orgcd;
    private String whcd;
    private String fileYmd;
    private int fileSeq;
    private String salesRecordNumber; // 판매 기록 번호
    private String orderNumber; // 주문 번호
    private String buyerUsername; // 구매자 사용자 이름
    private String buyerName; // 구매자 이름
    private String buyerEmail; // 구매자 이메일
    private String buyerNote; // 구매자 참고
    private String buyerAddress1; // 구매자 주소1
    private String buyerAddress2; // 구매자 주소2
    private String buyerCity; // 구매자 도시
    private String buyerState; // 구매자 주
    private String buyerZip; // 구매자 우편번호
    private String buyerCountry; // 구매자 국가
    private String shipToName; // 배송자 이름
    private String shipToPhone; // 배송자 연락처
    private String shipToAddress1; // 배송자 주소1
    private String shipToAddress2; // 배송자 주소2
    private String shipToCity; // 배송자 도시
    private String shipToState; // 배송자 주
    private String shipToZip; // 배송자 우편번호
    private String shipToCountry; // 배송자 국가
    private String itemNumber; // 품목 번호
    private String itemTitle; // 품목 제목
    private String customLabel; // 맞춤 라벨
    private String soldViaPromotedListings; // 프로모션 목록에서 판매
    private String quantity; // 수량
    private String soldFor; // 판매
    private String shippingAndHandling; // 배송 및 취급
    private String sellerCollectedTax; // 판매자 징수 세금
    private String eBayCollectedTax; // eBay 징수 세금
    private String electronicWasteRecyclingFee; // 전자 폐기물 재활용 수수료
    private String mattressRecyclingFee; // 매트리스 재활용 수수료
    private String additionalFee; // 추가 비용
    private String totalPrice; // 합계 금액
    private String eBayCollectedTaxAndFeesIncludedInTotal; // eBay 징수 세금 및 수수료합계에 포함
    private String paymentMethod; // 결제 방법
    private String saleDate; // 판매 날짜
    private String paidOnDate; // 지급 날짜
    private String shipByDate; // 발송일
    private String minimumEstimatedDeliveryDate; // 최소 예상 배송일
    private String maximumEstimatedDeliveryDate; // 최대 예상 배송일
    private String shippedOnDate; // 발송 날짜
    private String feedbackLeft; // 피드 남음
    private String feedbackReceived; // 피드백 접수
    private String myItemNote; // 내 품목 참조
    private String payPalTransactionId; // 페이팔 거래 ID
    private String shippingService; // 배송 서비스
    private String trackingNumber; // 추적번호
    private String transactionId; // 거래 ID
    private String variationDetails; // 품목 세부 정보
    private String globalShippingProgram; // 전역 배송 프로그램
    private String globalShippingReferenceId; // 전역 배송 참조 ID
    private String clickAndCollect; // 클릭 및 수집
    private String clickAndCollectReferenceNumber; // 클릭 및 수집 참조 번호
    private String eBayPlus; // Ebay Plus
    private String regYn;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;

    public String getOrderEbaySeq() {
        return orderEbaySeq;
    }

    public void setOrderEbaySeq(String orderEbaySeq) {
        this.orderEbaySeq = orderEbaySeq;
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

    public String getSalesRecordNumber() {
        return salesRecordNumber;
    }

    public void setSalesRecordNumber(String salesRecordNumber) {
        this.salesRecordNumber = salesRecordNumber;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getBuyerUsername() {
        return buyerUsername;
    }

    public void setBuyerUsername(String buyerUsername) {
        this.buyerUsername = buyerUsername;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public String getBuyerEmail() {
        return buyerEmail;
    }

    public void setBuyerEmail(String buyerEmail) {
        this.buyerEmail = buyerEmail;
    }

    public String getBuyerNote() {
        return buyerNote;
    }

    public void setBuyerNote(String buyerNote) {
        this.buyerNote = buyerNote;
    }

    public String getBuyerAddress1() {
        return buyerAddress1;
    }

    public void setBuyerAddress1(String buyerAddress1) {
        this.buyerAddress1 = buyerAddress1;
    }

    public String getBuyerAddress2() {
        return buyerAddress2;
    }

    public void setBuyerAddress2(String buyerAddress2) {
        this.buyerAddress2 = buyerAddress2;
    }

    public String getBuyerCity() {
        return buyerCity;
    }

    public void setBuyerCity(String buyerCity) {
        this.buyerCity = buyerCity;
    }

    public String getBuyerState() {
        return buyerState;
    }

    public void setBuyerState(String buyerState) {
        this.buyerState = buyerState;
    }

    public String getBuyerZip() {
        return buyerZip;
    }

    public void setBuyerZip(String buyerZip) {
        this.buyerZip = buyerZip;
    }

    public String getBuyerCountry() {
        return buyerCountry;
    }

    public void setBuyerCountry(String buyerCountry) {
        this.buyerCountry = buyerCountry;
    }

    public String getShipToName() {
        return shipToName;
    }

    public void setShipToName(String shipToName) {
        this.shipToName = shipToName;
    }

    public String getShipToPhone() {
        return shipToPhone;
    }

    public void setShipToPhone(String shipToPhone) {
        this.shipToPhone = shipToPhone;
    }

    public String getShipToAddress1() {
        return shipToAddress1;
    }

    public void setShipToAddress1(String shipToAddress1) {
        this.shipToAddress1 = shipToAddress1;
    }

    public String getShipToAddress2() {
        return shipToAddress2;
    }

    public void setShipToAddress2(String shipToAddress2) {
        this.shipToAddress2 = shipToAddress2;
    }

    public String getShipToCity() {
        return shipToCity;
    }

    public void setShipToCity(String shipToCity) {
        this.shipToCity = shipToCity;
    }

    public String getShipToState() {
        return shipToState;
    }

    public void setShipToState(String shipToState) {
        this.shipToState = shipToState;
    }

    public String getShipToZip() {
        return shipToZip;
    }

    public void setShipToZip(String shipToZip) {
        this.shipToZip = shipToZip;
    }

    public String getShipToCountry() {
        return shipToCountry;
    }

    public void setShipToCountry(String shipToCountry) {
        this.shipToCountry = shipToCountry;
    }

    public String getItemNumber() {
        return itemNumber;
    }

    public void setItemNumber(String itemNumber) {
        this.itemNumber = itemNumber;
    }

    public String getItemTitle() {
        return itemTitle;
    }

    public void setItemTitle(String itemTitle) {
        this.itemTitle = itemTitle;
    }

    public String getCustomLabel() {
        return customLabel;
    }

    public void setCustomLabel(String customLabel) {
        this.customLabel = customLabel;
    }

    public String getSoldViaPromotedListings() {
        return soldViaPromotedListings;
    }

    public void setSoldViaPromotedListings(String soldViaPromotedListings) {
        this.soldViaPromotedListings = soldViaPromotedListings;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getSoldFor() {
        return soldFor;
    }

    public void setSoldFor(String soldFor) {
        this.soldFor = soldFor;
    }

    public String getShippingAndHandling() {
        return shippingAndHandling;
    }

    public void setShippingAndHandling(String shippingAndHandling) {
        this.shippingAndHandling = shippingAndHandling;
    }

    public String getSellerCollectedTax() {
        return sellerCollectedTax;
    }

    public void setSellerCollectedTax(String sellerCollectedTax) {
        this.sellerCollectedTax = sellerCollectedTax;
    }

    public String geteBayCollectedTax() {
        return eBayCollectedTax;
    }

    public void seteBayCollectedTax(String eBayCollectedTax) {
        this.eBayCollectedTax = eBayCollectedTax;
    }

    public String getElectronicWasteRecyclingFee() {
        return electronicWasteRecyclingFee;
    }

    public void setElectronicWasteRecyclingFee(String electronicWasteRecyclingFee) {
        this.electronicWasteRecyclingFee = electronicWasteRecyclingFee;
    }

    public String getMattressRecyclingFee() {
        return mattressRecyclingFee;
    }

    public void setMattressRecyclingFee(String mattressRecyclingFee) {
        this.mattressRecyclingFee = mattressRecyclingFee;
    }

    public String getAdditionalFee() {
        return additionalFee;
    }

    public void setAdditionalFee(String additionalFee) {
        this.additionalFee = additionalFee;
    }

    public String getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(String totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String geteBayCollectedTaxAndFeesIncludedInTotal() {
        return eBayCollectedTaxAndFeesIncludedInTotal;
    }

    public void seteBayCollectedTaxAndFeesIncludedInTotal(String eBayCollectedTaxAndFeesIncludedInTotal) {
        this.eBayCollectedTaxAndFeesIncludedInTotal = eBayCollectedTaxAndFeesIncludedInTotal;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(String saleDate) {
        this.saleDate = saleDate;
    }

    public String getPaidOnDate() {
        return paidOnDate;
    }

    public void setPaidOnDate(String paidOnDate) {
        this.paidOnDate = paidOnDate;
    }

    public String getShipByDate() {
        return shipByDate;
    }

    public void setShipByDate(String shipByDate) {
        this.shipByDate = shipByDate;
    }

    public String getMinimumEstimatedDeliveryDate() {
        return minimumEstimatedDeliveryDate;
    }

    public void setMinimumEstimatedDeliveryDate(String minimumEstimatedDeliveryDate) {
        this.minimumEstimatedDeliveryDate = minimumEstimatedDeliveryDate;
    }

    public String getMaximumEstimatedDeliveryDate() {
        return maximumEstimatedDeliveryDate;
    }

    public void setMaximumEstimatedDeliveryDate(String maximumEstimatedDeliveryDate) {
        this.maximumEstimatedDeliveryDate = maximumEstimatedDeliveryDate;
    }

    public String getShippedOnDate() {
        return shippedOnDate;
    }

    public void setShippedOnDate(String shippedOnDate) {
        this.shippedOnDate = shippedOnDate;
    }

    public String getFeedbackLeft() {
        return feedbackLeft;
    }

    public void setFeedbackLeft(String feedbackLeft) {
        this.feedbackLeft = feedbackLeft;
    }

    public String getFeedbackReceived() {
        return feedbackReceived;
    }

    public void setFeedbackReceived(String feedbackReceived) {
        this.feedbackReceived = feedbackReceived;
    }

    public String getMyItemNote() {
        return myItemNote;
    }

    public void setMyItemNote(String myItemNote) {
        this.myItemNote = myItemNote;
    }

    public String getPayPalTransactionId() {
        return payPalTransactionId;
    }

    public void setPayPalTransactionId(String payPalTransactionId) {
        this.payPalTransactionId = payPalTransactionId;
    }

    public String getShippingService() {
        return shippingService;
    }

    public void setShippingService(String shippingService) {
        this.shippingService = shippingService;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getVariationDetails() {
        return variationDetails;
    }

    public void setVariationDetails(String variationDetails) {
        this.variationDetails = variationDetails;
    }

    public String getGlobalShippingProgram() {
        return globalShippingProgram;
    }

    public void setGlobalShippingProgram(String globalShippingProgram) {
        this.globalShippingProgram = globalShippingProgram;
    }

    public String getGlobalShippingReferenceId() {
        return globalShippingReferenceId;
    }

    public void setGlobalShippingReferenceId(String globalShippingReferenceId) {
        this.globalShippingReferenceId = globalShippingReferenceId;
    }

    public String getClickAndCollect() {
        return clickAndCollect;
    }

    public void setClickAndCollect(String clickAndCollect) {
        this.clickAndCollect = clickAndCollect;
    }

    public String getClickAndCollectReferenceNumber() {
        return clickAndCollectReferenceNumber;
    }

    public void setClickAndCollectReferenceNumber(String clickAndCollectReferenceNumber) {
        this.clickAndCollectReferenceNumber = clickAndCollectReferenceNumber;
    }

    public String geteBayPlus() {
        return eBayPlus;
    }

    public void seteBayPlus(String eBayPlus) {
        this.eBayPlus = eBayPlus;
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
        builder.append(" {\n\torderEbaySeq: ");
        builder.append(orderEbaySeq);
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
        builder.append("\n\tsalesRecordNumber: ");
        builder.append(salesRecordNumber);
        builder.append("\n\torderNumber: ");
        builder.append(orderNumber);
        builder.append("\n\tbuyerUsername: ");
        builder.append(buyerUsername);
        builder.append("\n\tbuyerName: ");
        builder.append(buyerName);
        builder.append("\n\tbuyerEmail: ");
        builder.append(buyerEmail);
        builder.append("\n\tbuyerNote: ");
        builder.append(buyerNote);
        builder.append("\n\tbuyerAddress1: ");
        builder.append(buyerAddress1);
        builder.append("\n\tbuyerAddress2: ");
        builder.append(buyerAddress2);
        builder.append("\n\tbuyerCity: ");
        builder.append(buyerCity);
        builder.append("\n\tbuyerState: ");
        builder.append(buyerState);
        builder.append("\n\tbuyerZip: ");
        builder.append(buyerZip);
        builder.append("\n\tbuyerCountry: ");
        builder.append(buyerCountry);
        builder.append("\n\tshipToName: ");
        builder.append(shipToName);
        builder.append("\n\tshipToPhone: ");
        builder.append(shipToPhone);
        builder.append("\n\tshipToAddress1: ");
        builder.append(shipToAddress1);
        builder.append("\n\tshipToAddress2: ");
        builder.append(shipToAddress2);
        builder.append("\n\tshipToCity: ");
        builder.append(shipToCity);
        builder.append("\n\tshipToState: ");
        builder.append(shipToState);
        builder.append("\n\tshipToZip: ");
        builder.append(shipToZip);
        builder.append("\n\tshipToCountry: ");
        builder.append(shipToCountry);
        builder.append("\n\titemNumber: ");
        builder.append(itemNumber);
        builder.append("\n\titemTitle: ");
        builder.append(itemTitle);
        builder.append("\n\tcustomLabel: ");
        builder.append(customLabel);
        builder.append("\n\tsoldViaPromotedListings: ");
        builder.append(soldViaPromotedListings);
        builder.append("\n\tquantity: ");
        builder.append(quantity);
        builder.append("\n\tsoldFor: ");
        builder.append(soldFor);
        builder.append("\n\tshippingAndHandling: ");
        builder.append(shippingAndHandling);
        builder.append("\n\tsellerCollectedTax: ");
        builder.append(sellerCollectedTax);
        builder.append("\n\teBayCollectedTax: ");
        builder.append(eBayCollectedTax);
        builder.append("\n\telectronicWasteRecyclingFee: ");
        builder.append(electronicWasteRecyclingFee);
        builder.append("\n\tmattressRecyclingFee: ");
        builder.append(mattressRecyclingFee);
        builder.append("\n\tadditionalFee: ");
        builder.append(additionalFee);
        builder.append("\n\ttotalPrice: ");
        builder.append(totalPrice);
        builder.append("\n\teBayCollectedTaxAndFeesIncludedInTotal: ");
        builder.append(eBayCollectedTaxAndFeesIncludedInTotal);
        builder.append("\n\tpaymentMethod: ");
        builder.append(paymentMethod);
        builder.append("\n\tsaleDate: ");
        builder.append(saleDate);
        builder.append("\n\tpaidOnDate: ");
        builder.append(paidOnDate);
        builder.append("\n\tshipByDate: ");
        builder.append(shipByDate);
        builder.append("\n\tminimumEstimatedDeliveryDate: ");
        builder.append(minimumEstimatedDeliveryDate);
        builder.append("\n\tmaximumEstimatedDeliveryDate: ");
        builder.append(maximumEstimatedDeliveryDate);
        builder.append("\n\tshippedOnDate: ");
        builder.append(shippedOnDate);
        builder.append("\n\tfeedbackLeft: ");
        builder.append(feedbackLeft);
        builder.append("\n\tfeedbackReceived: ");
        builder.append(feedbackReceived);
        builder.append("\n\tmyItemNote: ");
        builder.append(myItemNote);
        builder.append("\n\tpayPalTransactionId: ");
        builder.append(payPalTransactionId);
        builder.append("\n\tshippingService: ");
        builder.append(shippingService);
        builder.append("\n\ttrackingNumber: ");
        builder.append(trackingNumber);
        builder.append("\n\ttransactionId: ");
        builder.append(transactionId);
        builder.append("\n\tvariationDetails: ");
        builder.append(variationDetails);
        builder.append("\n\tglobalShippingProgram: ");
        builder.append(globalShippingProgram);
        builder.append("\n\tglobalShippingReferenceId: ");
        builder.append(globalShippingReferenceId);
        builder.append("\n\tclickAndCollect: ");
        builder.append(clickAndCollect);
        builder.append("\n\tclickAndCollectReferenceNumber: ");
        builder.append(clickAndCollectReferenceNumber);
        builder.append("\n\teBayPlus: ");
        builder.append(eBayPlus);
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
