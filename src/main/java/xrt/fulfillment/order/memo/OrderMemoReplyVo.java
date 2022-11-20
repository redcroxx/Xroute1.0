package xrt.fulfillment.order.memo;

import java.io.Serializable;

public class OrderMemoReplyVo implements Serializable {

	private static final long serialVersionUID = 1L;

	private String compcd; 
	private String orgcd;
	private String whcd;
	private String orderMemoReplySeq;
	private String orderMemoSeq;
	private int number;
	private String contents;
	private String addusercd;
	private String adddatetime;
	private String updusercd;
	private String upddatetime;
	private String terminalcd;
	private String memoType;
	private String shippingStatus;

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
	public String getOrderMemoReplySeq() {
		return orderMemoReplySeq;
	}
	public void setOrderMemoReplySeq(String orderMemoReplySeq) {
		this.orderMemoReplySeq = orderMemoReplySeq;
	}
	public String getOrderMemoSeq() {
		return orderMemoSeq;
	}
	public void setOrderMemoSeq(String orderMemoSeq) {
		this.orderMemoSeq = orderMemoSeq;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
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
    public String getMemoType() {
        return memoType;
    }
    public void setMemoType(String memoType) {
        this.memoType = memoType;
    }
    public String getShippingStatus() {
        return shippingStatus;
    }
    public void setShippingStatus(String shippingStatus) {
        this.shippingStatus = shippingStatus;
    }
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("OrderMemoReplyVo {\n    compcd : ");
        builder.append(compcd);
        builder.append(",\n    orgcd : ");
        builder.append(orgcd);
        builder.append(",\n    whcd : ");
        builder.append(whcd);
        builder.append(",\n    orderMemoReplySeq : ");
        builder.append(orderMemoReplySeq);
        builder.append(",\n    orderMemoSeq : ");
        builder.append(orderMemoSeq);
        builder.append(",\n    number : ");
        builder.append(number);
        builder.append(",\n    contents : ");
        builder.append(contents);
        builder.append(",\n    addusercd : ");
        builder.append(addusercd);
        builder.append(",\n    adddatetime : ");
        builder.append(adddatetime);
        builder.append(",\n    updusercd : ");
        builder.append(updusercd);
        builder.append(",\n    upddatetime : ");
        builder.append(upddatetime);
        builder.append(",\n    terminalcd : ");
        builder.append(terminalcd);
        builder.append(",\n    memoType : ");
        builder.append(memoType);
        builder.append(",\n    shippingStatus : ");
        builder.append(shippingStatus);
        builder.append("\n}");
        return builder.toString();
    }
}
