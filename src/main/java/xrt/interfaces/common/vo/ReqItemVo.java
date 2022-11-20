package xrt.interfaces.common.vo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ReqItemVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String compcd;
    private String orgcd;
    private String whcd;
    private String invcSno;
    private String orderId;
    private String itemOrder;
    private String itemId;
    private String itemName;
    private String itemCount;
    private String itemPrice;
    private String itemOption;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;

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

    public String getInvcSno() {
        return invcSno;
    }

    public void setInvcSno(String invcSno) {
        this.invcSno = invcSno;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getItemOrder() {
        return itemOrder;
    }

    public void setItemOrder(String itemOrder) {
        this.itemOrder = itemOrder;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemCount() {
        return itemCount;
    }

    public void setItemCount(String itemCount) {
        this.itemCount = itemCount;
    }

    public String getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(String itemPrice) {
        this.itemPrice = itemPrice;
    }

    public String getItemOption() {
        return itemOption;
    }

    public void setItemOption(String itemOption) {
        this.itemOption = itemOption;
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
        builder.append(" {\n\tcompcd: ");
        builder.append(compcd);
        builder.append("\n\torgcd: ");
        builder.append(orgcd);
        builder.append("\n\twhcd: ");
        builder.append(whcd);
        builder.append("\n\tinvcSno: ");
        builder.append(invcSno);
        builder.append("\n\torderId: ");
        builder.append(orderId);
        builder.append("\n\titemOrder: ");
        builder.append(itemOrder);
        builder.append("\n\titemId: ");
        builder.append(itemId);
        builder.append("\n\titemName: ");
        builder.append(itemName);
        builder.append("\n\titemCount: ");
        builder.append(itemCount);
        builder.append("\n\titemPrice: ");
        builder.append(itemPrice);
        builder.append("\n\titemOption: ");
        builder.append(itemOption);
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
