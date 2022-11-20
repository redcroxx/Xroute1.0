package xrt.interfaces.common.vo;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ReqOrderVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String apiOrderSeq;
    private String compcd;
    private String orgcd;
    private String whcd;
    private String xrtInvcSno;
    private String invcSno;
    private String fileSeq;
    private String company;
    private String shipMethod;
    private String fileYmd;
    private String storeName;
    private String sellerName;
    private String orderId;
    private String cartId;
    private String buyerName;
    private String shipCountry;
    private String currency;
    private String shipCity;
    private String shipState;
    private String shipPostalCode;
    private String shipAddr1;
    private String shipAddr2;
    private String shipNumber1;
    private String shipNumber2;
    private List<ReqItemVo> itemList;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;

    public String getApiOrderSeq() {
        return apiOrderSeq;
    }

    public void setApiOrderSeq(String apiOrderSeq) {
        this.apiOrderSeq = apiOrderSeq;
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

    public String getXrtInvcSno() {
        return xrtInvcSno;
    }

    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }

    public String getInvcSno() {
        return invcSno;
    }

    public void setInvcSno(String invcSno) {
        this.invcSno = invcSno;
    }

    public String getFileSeq() {
        return fileSeq;
    }

    public void setFileSeq(String fileSeq) {
        this.fileSeq = fileSeq;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getShipMethod() {
        return shipMethod;
    }

    public void setShipMethod(String shipMethod) {
        this.shipMethod = shipMethod;
    }

    public String getFileYmd() {
        return fileYmd;
    }

    public void setFileYmd(String fileYmd) {
        this.fileYmd = fileYmd;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getSellerName() {
        return sellerName;
    }

    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getCartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId = cartId;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public String getShipCountry() {
        return shipCountry;
    }

    public void setShipCountry(String shipCountry) {
        this.shipCountry = shipCountry;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
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

    public String getShipAddr1() {
        return shipAddr1;
    }

    public void setShipAddr1(String shipAddr1) {
        this.shipAddr1 = shipAddr1;
    }

    public String getShipAddr2() {
        return shipAddr2;
    }

    public void setShipAddr2(String shipAddr2) {
        this.shipAddr2 = shipAddr2;
    }

    public String getShipNumber1() {
        return shipNumber1;
    }

    public void setShipNumber1(String shipNumber1) {
        this.shipNumber1 = shipNumber1;
    }

    public String getShipNumber2() {
        return shipNumber2;
    }

    public void setShipNumber2(String shipNumber2) {
        this.shipNumber2 = shipNumber2;
    }

    public List<ReqItemVo> getItemList() {
        return itemList;
    }

    public void setItemList(List<ReqItemVo> itemList) {
        this.itemList = itemList;
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
        builder.append(" {\n\tapiOrderSeq: ");
        builder.append(apiOrderSeq);
        builder.append("\n\tcompcd: ");
        builder.append(compcd);
        builder.append("\n\torgcd: ");
        builder.append(orgcd);
        builder.append("\n\twhcd: ");
        builder.append(whcd);
        builder.append("\n\txrtInvcSno: ");
        builder.append(xrtInvcSno);
        builder.append("\n\tinvcSno: ");
        builder.append(invcSno);
        builder.append("\n\tfileSeq: ");
        builder.append(fileSeq);
        builder.append("\n\tcompany: ");
        builder.append(company);
        builder.append("\n\tshipMethod: ");
        builder.append(shipMethod);
        builder.append("\n\tfileYmd: ");
        builder.append(fileYmd);
        builder.append("\n\tstoreName: ");
        builder.append(storeName);
        builder.append("\n\tsellerName: ");
        builder.append(sellerName);
        builder.append("\n\torderId: ");
        builder.append(orderId);
        builder.append("\n\tcartId: ");
        builder.append(cartId);
        builder.append("\n\tbuyerName: ");
        builder.append(buyerName);
        builder.append("\n\tshipCountry: ");
        builder.append(shipCountry);
        builder.append("\n\tcurrency: ");
        builder.append(currency);
        builder.append("\n\tshipCity: ");
        builder.append(shipCity);
        builder.append("\n\tshipState: ");
        builder.append(shipState);
        builder.append("\n\tshipPostalCode: ");
        builder.append(shipPostalCode);
        builder.append("\n\tshipAddr1: ");
        builder.append(shipAddr1);
        builder.append("\n\tshipAddr2: ");
        builder.append(shipAddr2);
        builder.append("\n\tshipNumber1: ");
        builder.append(shipNumber1);
        builder.append("\n\tshipNumber2: ");
        builder.append(shipNumber2);
        builder.append("\n\titemList: ");
        builder.append(itemList);
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
