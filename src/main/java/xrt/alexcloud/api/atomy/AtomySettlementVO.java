package xrt.alexcloud.api.atomy;

public class AtomySettlementVO {

    private String orderDate;
    private String unipassTkofdt;
    private String expNo;
    private String xrtInvcSno;
    private String ordNo;
    private String localShipper;
    private String invcSno1;
    private String eNation;
    private String productName;
    private String quantity;
    private String kg;
    private String salesPrice1;
    private String salesPrice2;
    private String salesPrice3;
    private String purchasesPrice1;
    private String purchasesPrice2;
    private String purchasesPrice3;
    private String grossProfits1;
    private String grossProfits2;
    private String grossProfits3;
    private String memo;
    
    public String getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }
    public String getUnipassTkofdt() {
        return unipassTkofdt;
    }
    public void setUnipassTkofdt(String unipassTkofdt) {
        this.unipassTkofdt = unipassTkofdt;
    }
    public String getExpNo() {
        return expNo;
    }
    public void setExpNo(String expNo) {
        this.expNo = expNo;
    }
    public String getXrtInvcSno() {
        return xrtInvcSno;
    }
    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }
    public String getOrdNo() {
        return ordNo;
    }
    public void setOrdNo(String ordNo) {
        this.ordNo = ordNo;
    }
    public String getLocalShipper() {
        return localShipper;
    }
    public void setLocalShipper(String localShipper) {
        this.localShipper = localShipper;
    }
    public String getInvcSno1() {
        return invcSno1;
    }
    public void setInvcSno1(String invcSno1) {
        this.invcSno1 = invcSno1;
    }
    public String geteNation() {
        return eNation;
    }
    public void seteNation(String eNation) {
        this.eNation = eNation;
    }
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }
    public String getQuantity() {
        return quantity;
    }
    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }
    public String getKg() {
        return kg;
    }
    public void setKg(String kg) {
        this.kg = kg;
    }
    public String getSalesPrice1() {
        return salesPrice1;
    }
    public void setSalesPrice1(String salesPrice1) {
        this.salesPrice1 = salesPrice1;
    }
    public String getSalesPrice2() {
        return salesPrice2;
    }
    public void setSalesPrice2(String salesPrice2) {
        this.salesPrice2 = salesPrice2;
    }
    public String getSalesPrice3() {
        return salesPrice3;
    }
    public void setSalesPrice3(String salesPrice3) {
        this.salesPrice3 = salesPrice3;
    }
    public String getPurchasesPrice1() {
        return purchasesPrice1;
    }
    public void setPurchasesPrice1(String purchasesPrice1) {
        this.purchasesPrice1 = purchasesPrice1;
    }
    public String getPurchasesPrice2() {
        return purchasesPrice2;
    }
    public void setPurchasesPrice2(String purchasesPrice2) {
        this.purchasesPrice2 = purchasesPrice2;
    }
    public String getPurchasesPrice3() {
        return purchasesPrice3;
    }
    public void setPurchasesPrice3(String purchasesPrice3) {
        this.purchasesPrice3 = purchasesPrice3;
    }
    public String getGrossProfits1() {
        return grossProfits1;
    }
    public void setGrossProfits1(String grossProfits1) {
        this.grossProfits1 = grossProfits1;
    }
    public String getGrossProfits2() {
        return grossProfits2;
    }
    public void setGrossProfits2(String grossProfits2) {
        this.grossProfits2 = grossProfits2;
    }
    public String getGrossProfits3() {
        return grossProfits3;
    }
    public void setGrossProfits3(String grossProfits3) {
        this.grossProfits3 = grossProfits3;
    }
    public String getMemo() {
        return memo;
    }
    public void setMemo(String memo) {
        this.memo = memo;
    }
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("AtomySettlementVO {\n    orderDate : ");
        builder.append(orderDate);
        builder.append(",\n    unipassTkofdt : ");
        builder.append(unipassTkofdt);
        builder.append(",\n    expNo : ");
        builder.append(expNo);
        builder.append(",\n    xrtInvcSno : ");
        builder.append(xrtInvcSno);
        builder.append(",\n    ordNo : ");
        builder.append(ordNo);
        builder.append(",\n    localShipper : ");
        builder.append(localShipper);
        builder.append(",\n    invcSno1 : ");
        builder.append(invcSno1);
        builder.append(",\n    eNation : ");
        builder.append(eNation);
        builder.append(",\n    productName : ");
        builder.append(productName);
        builder.append(",\n    quantity : ");
        builder.append(quantity);
        builder.append(",\n    kg : ");
        builder.append(kg);
        builder.append(",\n    salesPrice1 : ");
        builder.append(salesPrice1);
        builder.append(",\n    salesPrice2 : ");
        builder.append(salesPrice2);
        builder.append(",\n    salesPrice3 : ");
        builder.append(salesPrice3);
        builder.append(",\n    purchasesPrice1 : ");
        builder.append(purchasesPrice1);
        builder.append(",\n    purchasesPrice2 : ");
        builder.append(purchasesPrice2);
        builder.append(",\n    purchasesPrice3 : ");
        builder.append(purchasesPrice3);
        builder.append(",\n    grossProfits1 : ");
        builder.append(grossProfits1);
        builder.append(",\n    grossProfits2 : ");
        builder.append(grossProfits2);
        builder.append(",\n    grossProfits3 : ");
        builder.append(grossProfits3);
        builder.append(",\n    memo : ");
        builder.append(memo);
        builder.append("\n}");
        return builder.toString();
    }
}
