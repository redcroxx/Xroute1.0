package xrt.fulfillment.order.ups;

import java.io.Serializable;

public class UpsVO implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String shipperNumber; // W499X4 고정.
    private String shipmentRef1; // XROUTE 송장번호.
    private String shipmentRef2; // 애터미 주문번호.
    private String shipmentRef3;
    private String shipmentRef4;
    private String shipmentRef5;
    private String numberOfPkg; // 상품 수량.
    private String shipmentWeight; // XROUTE 중량.
    private String shipToContact; // 수화인명.
    private String companyName; // 수화인명.
    private String phone; // 수화인 전화번호.
    private String address1; // 수화인 주소1.
    private String address2; // 수화인 주소2.
    private String address3; // 수화인 주소3.
    private String city; // 수화인 도시.
    private String state; // 수화인 주.
    private String zip; // 수화인 우편번호.
    private String country; // 도착국가.
    private String service; // SV. 고정
    private String billTransportation; // SHIP 고정.
    private String billDuty; // REC 고정.
    private String descriptionOfGoods; // 상품명.
    private String shipToEmail;
    private String printCopyOfInvoice;
    private String qvnOption;
    private String qvContactname;
    private String qvEmail; // dy.lee@logifocus.co.kr 고정.
    private String qvShip;
    private String qvExpection;
    private String qvDelivery; // Y 고정.
    private String createAnInvoice; // Y 고정.
    private String processAsPaperless; // Y 고정.
    
    public String getShipperNumber() {
        return shipperNumber;
    }
    public void setShipperNumber(String shipperNumber) {
        this.shipperNumber = shipperNumber;
    }
    public String getShipmentRef1() {
        return shipmentRef1;
    }
    public void setShipmentRef1(String shipmentRef1) {
        this.shipmentRef1 = shipmentRef1;
    }
    public String getShipmentRef2() {
        return shipmentRef2;
    }
    public void setShipmentRef2(String shipmentRef2) {
        this.shipmentRef2 = shipmentRef2;
    }
    public String getShipmentRef3() {
        return shipmentRef3;
    }
    public void setShipmentRef3(String shipmentRef3) {
        this.shipmentRef3 = shipmentRef3;
    }
    public String getShipmentRef4() {
        return shipmentRef4;
    }
    public void setShipmentRef4(String shipmentRef4) {
        this.shipmentRef4 = shipmentRef4;
    }
    public String getShipmentRef5() {
        return shipmentRef5;
    }
    public void setShipmentRef5(String shipmentRef5) {
        this.shipmentRef5 = shipmentRef5;
    }
    public String getNumberOfPkg() {
        return numberOfPkg;
    }
    public void setNumberOfPkg(String numberOfPkg) {
        this.numberOfPkg = numberOfPkg;
    }
    public String getShipmentWeight() {
        return shipmentWeight;
    }
    public void setShipmentWeight(String shipmentWeight) {
        this.shipmentWeight = shipmentWeight;
    }
    public String getShipToContact() {
        return shipToContact;
    }
    public void setShipToContact(String shipToContact) {
        this.shipToContact = shipToContact;
    }
    public String getCompanyName() {
        return companyName;
    }
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getAddress1() {
        return address1;
    }
    public void setAddress1(String address1) {
        this.address1 = address1;
    }
    public String getAddress2() {
        return address2;
    }
    public void setAddress2(String address2) {
        this.address2 = address2;
    }
    public String getAddress3() {
        return address3;
    }
    public void setAddress3(String address3) {
        this.address3 = address3;
    }
    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }
    public String getState() {
        return state;
    }
    public void setState(String state) {
        this.state = state;
    }
    public String getZip() {
        return zip;
    }
    public void setZip(String zip) {
        this.zip = zip;
    }
    public String getCountry() {
        return country;
    }
    public void setCountry(String country) {
        this.country = country;
    }
    public String getService() {
        return service;
    }
    public void setService(String service) {
        this.service = service;
    }
    public String getBillTransportation() {
        return billTransportation;
    }
    public void setBillTransportation(String billTransportation) {
        this.billTransportation = billTransportation;
    }
    public String getBillDuty() {
        return billDuty;
    }
    public void setBillDuty(String billDuty) {
        this.billDuty = billDuty;
    }
    public String getDescriptionOfGoods() {
        return descriptionOfGoods;
    }
    public void setDescriptionOfGoods(String descriptionOfGoods) {
        this.descriptionOfGoods = descriptionOfGoods;
    }
    public String getShipToEmail() {
        return shipToEmail;
    }
    public void setShipToEmail(String shipToEmail) {
        this.shipToEmail = shipToEmail;
    }
    public String getPrintCopyOfInvoice() {
        return printCopyOfInvoice;
    }
    public void setPrintCopyOfInvoice(String printCopyOfInvoice) {
        this.printCopyOfInvoice = printCopyOfInvoice;
    }
    public String getQvnOption() {
        return qvnOption;
    }
    public void setQvnOption(String qvnOption) {
        this.qvnOption = qvnOption;
    }
    public String getQvContactname() {
        return qvContactname;
    }
    public void setQvContactname(String qvContactname) {
        this.qvContactname = qvContactname;
    }
    public String getQvEmail() {
        return qvEmail;
    }
    public void setQvEmail(String qvEmail) {
        this.qvEmail = qvEmail;
    }
    public String getQvShip() {
        return qvShip;
    }
    public void setQvShip(String qvShip) {
        this.qvShip = qvShip;
    }
    public String getQvExpection() {
        return qvExpection;
    }
    public void setQvExpection(String qvExpection) {
        this.qvExpection = qvExpection;
    }
    public String getQvDelivery() {
        return qvDelivery;
    }
    public void setQvDelivery(String qvDelivery) {
        this.qvDelivery = qvDelivery;
    }
    public String getCreateAnInvoice() {
        return createAnInvoice;
    }
    public void setCreateAnInvoice(String createAnInvoice) {
        this.createAnInvoice = createAnInvoice;
    }
    public String getProcessAsPaperless() {
        return processAsPaperless;
    }
    public void setProcessAsPaperless(String processAsPaperless) {
        this.processAsPaperless = processAsPaperless;
    }
    
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("UpsVO {\n    shipperNumber : ");
        builder.append(shipperNumber);
        builder.append(",\n    shipmentRef1 : ");
        builder.append(shipmentRef1);
        builder.append(",\n    shipmentRef2 : ");
        builder.append(shipmentRef2);
        builder.append(",\n    shipmentRef3 : ");
        builder.append(shipmentRef3);
        builder.append(",\n    shipmentRef4 : ");
        builder.append(shipmentRef4);
        builder.append(",\n    shipmentRef5 : ");
        builder.append(shipmentRef5);
        builder.append(",\n    numberOfPkg : ");
        builder.append(numberOfPkg);
        builder.append(",\n    shipmentWeight : ");
        builder.append(shipmentWeight);
        builder.append(",\n    shipToContact : ");
        builder.append(shipToContact);
        builder.append(",\n    companyName : ");
        builder.append(companyName);
        builder.append(",\n    phone : ");
        builder.append(phone);
        builder.append(",\n    address1 : ");
        builder.append(address1);
        builder.append(",\n    address2 : ");
        builder.append(address2);
        builder.append(",\n    address3 : ");
        builder.append(address3);
        builder.append(",\n    city : ");
        builder.append(city);
        builder.append(",\n    state : ");
        builder.append(state);
        builder.append(",\n    zip : ");
        builder.append(zip);
        builder.append(",\n    country : ");
        builder.append(country);
        builder.append(",\n    service : ");
        builder.append(service);
        builder.append(",\n    billTransportation : ");
        builder.append(billTransportation);
        builder.append(",\n    billDuty : ");
        builder.append(billDuty);
        builder.append(",\n    descriptionOfGoods : ");
        builder.append(descriptionOfGoods);
        builder.append(",\n    shipToEmail : ");
        builder.append(shipToEmail);
        builder.append(",\n    printCopyOfInvoice : ");
        builder.append(printCopyOfInvoice);
        builder.append(",\n    qvnOption : ");
        builder.append(qvnOption);
        builder.append(",\n    qvContactname : ");
        builder.append(qvContactname);
        builder.append(",\n    qvEmail : ");
        builder.append(qvEmail);
        builder.append(",\n    qvShip : ");
        builder.append(qvShip);
        builder.append(",\n    qvExpection : ");
        builder.append(qvExpection);
        builder.append(",\n    qvDelivery : ");
        builder.append(qvDelivery);
        builder.append(",\n    createAnInvoice : ");
        builder.append(createAnInvoice);
        builder.append(",\n    processAsPaperless : ");
        builder.append(processAsPaperless);
        builder.append("\n}");
        return builder.toString();
    }
}
