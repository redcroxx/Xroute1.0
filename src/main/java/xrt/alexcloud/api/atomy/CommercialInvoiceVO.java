package xrt.alexcloud.api.atomy;

import java.io.Serializable;

public class CommercialInvoiceVO implements Serializable{

    private static final long serialVersionUID = 1L;
    
    private String xrtInvcSno;
    private String corporateRegistrationNo;
    private String supplyNo;
    private String recvNation;
    private String shipPost;
    private String shipAddr;
    private String wgt;
    private String deliveryTerms;
    private String recvCurrency;
    private String excTagSum;
    private String excTotSum;
    private String excAmt;
    private String hsCode;
    private String volumeWeight;
    private String origin;
    private String enProductName;
    private String goodsCnt;
    private String each;
    private String price;
    private String amount;
    private String saleTagSum;
    private String saleTotSum;
    private String subtotal;
    private String packingUnitCnt;
    private String packingUnit;
    private String loadingPort;
    private String packingUnitAll;
    private String ordNo;
    private String expNo; // 수출신고필증번호.
    
    public String getXrtInvcSno() {
        return xrtInvcSno;
    }
    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }
    public String getCorporateRegistrationNo() {
        return corporateRegistrationNo;
    }
    public void setCorporateRegistrationNo(String corporateRegistrationNo) {
        this.corporateRegistrationNo = corporateRegistrationNo;
    }
    public String getSupplyNo() {
        return supplyNo;
    }
    public void setSupplyNo(String supplyNo) {
        this.supplyNo = supplyNo;
    }
    public String getRecvNation() {
        return recvNation;
    }
    public void setRecvNation(String recvNation) {
        this.recvNation = recvNation;
    }
    public String getShipPost() {
        return shipPost;
    }
    public void setShipPost(String shipPost) {
        this.shipPost = shipPost;
    }
    public String getShipAddr() {
        return shipAddr;
    }
    public void setShipAddr(String shipAddr) {
        this.shipAddr = shipAddr;
    }
    public String getWgt() {
        return wgt;
    }
    public void setWgt(String wgt) {
        this.wgt = wgt;
    }
    public String getDeliveryTerms() {
        return deliveryTerms;
    }
    public void setDeliveryTerms(String deliveryTerms) {
        this.deliveryTerms = deliveryTerms;
    }
    public String getRecvCurrency() {
        return recvCurrency;
    }
    public void setRecvCurrency(String recvCurrency) {
        this.recvCurrency = recvCurrency;
    }
    public String getExcTagSum() {
        return excTagSum;
    }
    public void setExcTagSum(String excTagSum) {
        this.excTagSum = excTagSum;
    }
    public String getExcTotSum() {
        return excTotSum;
    }
    public void setExcTotSum(String excTotSum) {
        this.excTotSum = excTotSum;
    }
    public String getExcAmt() {
        return excAmt;
    }
    public void setExcAmt(String excAmt) {
        this.excAmt = excAmt;
    }
    public String getHsCode() {
        return hsCode;
    }
    public void setHsCode(String hsCode) {
        this.hsCode = hsCode;
    }
    public String getVolumeWeight() {
        return volumeWeight;
    }
    public void setVolumeWeight(String volumeWeight) {
        this.volumeWeight = volumeWeight;
    }
    public String getOrigin() {
        return origin;
    }
    public void setOrigin(String origin) {
        this.origin = origin;
    }
    public String getEnProductName() {
        return enProductName;
    }
    public void setEnProductName(String enProductName) {
        this.enProductName = enProductName;
    }
    public String getGoodsCnt() {
        return goodsCnt;
    }
    public void setGoodsCnt(String goodsCnt) {
        this.goodsCnt = goodsCnt;
    }
    public String getEach() {
        return each;
    }
    public void setEach(String each) {
        this.each = each;
    }
    public String getPrice() {
        return price;
    }
    public void setPrice(String price) {
        this.price = price;
    }
    public String getAmount() {
        return amount;
    }
    public void setAmount(String amount) {
        this.amount = amount;
    }
    public String getSaleTagSum() {
        return saleTagSum;
    }
    public void setSaleTagSum(String saleTagSum) {
        this.saleTagSum = saleTagSum;
    }
    public String getSaleTotSum() {
        return saleTotSum;
    }
    public void setSaleTotSum(String saleTotSum) {
        this.saleTotSum = saleTotSum;
    }
    public String getSubtotal() {
        return subtotal;
    }
    public void setSubtotal(String subtotal) {
        this.subtotal = subtotal;
    }
    public String getPackingUnitCnt() {
        return packingUnitCnt;
    }
    public void setPackingUnitCnt(String packingUnitCnt) {
        this.packingUnitCnt = packingUnitCnt;
    }
    public String getPackingUnit() {
        return packingUnit;
    }
    public void setPackingUnit(String packingUnit) {
        this.packingUnit = packingUnit;
    }
    public String getLoadingPort() {
        return loadingPort;
    }
    public void setLoadingPort(String loadingPort) {
        this.loadingPort = loadingPort;
    }
    public String getPackingUnitAll() {
        return packingUnitAll;
    }
    public void setPackingUnitAll(String packingUnitAll) {
        this.packingUnitAll = packingUnitAll;
    }
    public String getOrdNo() {
        return ordNo;
    }
    public void setOrdNo(String ordNo) {
        this.ordNo = ordNo;
    }
    public String getExpNo() {
        return expNo;
    }
    public void setExpNo(String expNo) {
        this.expNo = expNo;
    }
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("CommercialInvoiceVO {\n    xrtInvcSno : ");
        builder.append(xrtInvcSno);
        builder.append(",\n    corporateRegistrationNo : ");
        builder.append(corporateRegistrationNo);
        builder.append(",\n    supplyNo : ");
        builder.append(supplyNo);
        builder.append(",\n    recvNation : ");
        builder.append(recvNation);
        builder.append(",\n    shipPost : ");
        builder.append(shipPost);
        builder.append(",\n    shipAddr : ");
        builder.append(shipAddr);
        builder.append(",\n    wgt : ");
        builder.append(wgt);
        builder.append(",\n    deliveryTerms : ");
        builder.append(deliveryTerms);
        builder.append(",\n    recvCurrency : ");
        builder.append(recvCurrency);
        builder.append(",\n    excTagSum : ");
        builder.append(excTagSum);
        builder.append(",\n    excTotSum : ");
        builder.append(excTotSum);
        builder.append(",\n    excAmt : ");
        builder.append(excAmt);
        builder.append(",\n    hsCode : ");
        builder.append(hsCode);
        builder.append(",\n    volumeWeight : ");
        builder.append(volumeWeight);
        builder.append(",\n    origin : ");
        builder.append(origin);
        builder.append(",\n    enProductName : ");
        builder.append(enProductName);
        builder.append(",\n    goodsCnt : ");
        builder.append(goodsCnt);
        builder.append(",\n    each : ");
        builder.append(each);
        builder.append(",\n    price : ");
        builder.append(price);
        builder.append(",\n    amount : ");
        builder.append(amount);
        builder.append(",\n    saleTagSum : ");
        builder.append(saleTagSum);
        builder.append(",\n    saleTotSum : ");
        builder.append(saleTotSum);
        builder.append(",\n    subtotal : ");
        builder.append(subtotal);
        builder.append(",\n    packingUnitCnt : ");
        builder.append(packingUnitCnt);
        builder.append(",\n    packingUnit : ");
        builder.append(packingUnit);
        builder.append(",\n    loadingPort : ");
        builder.append(loadingPort);
        builder.append(",\n    packingUnitAll : ");
        builder.append(packingUnitAll);
        builder.append(",\n    ordNo : ");
        builder.append(ordNo);
        builder.append(",\n    expNo : ");
        builder.append(expNo);
        builder.append("\n}");
        return builder.toString();
    }
}
