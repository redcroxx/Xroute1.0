package xrt.fulfillment.order.memo;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

public class OrderMemoMasterVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String compcd;
    private String orgcd;
    private String whcd;
    private String orderMemoSeq;
    private String xrtInvcSno;
    private String ordNo;
    private String title;
    private String contents;
    private String replyCount;
    private String shippingStatus;
    private String statusCd;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;
    private String memoType;
    private String memoAuthority;
    private MultipartFile memoMultiFile;
    private String memoFilePath;
    private String eNation;
    
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
    public String getOrderMemoSeq() {
        return orderMemoSeq;
    }
    public void setOrderMemoSeq(String orderMemoSeq) {
        this.orderMemoSeq = orderMemoSeq;
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
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContents() {
        return contents;
    }
    public void setContents(String contents) {
        this.contents = contents;
    }
    public String getReplyCount() {
        return replyCount;
    }
    public void setReplyCount(String replyCount) {
        this.replyCount = replyCount;
    }
    public String getShippingStatus() {
        return shippingStatus;
    }
    public void setShippingStatus(String shippingStatus) {
        this.shippingStatus = shippingStatus;
    }
    public String getStatusCd() {
        return statusCd;
    }
    public void setStatusCd(String statusCd) {
        this.statusCd = statusCd;
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
    public String getMemoAuthority() {
        return memoAuthority;
    }
    public void setMemoAuthority(String memoAuthority) {
        this.memoAuthority = memoAuthority;
    }
    public MultipartFile getMemoMultiFile() {
        return memoMultiFile;
    }
    public void setMemoMultiFile(MultipartFile memoMultiFile) {
        this.memoMultiFile = memoMultiFile;
    }
    public String getMemoFilePath() {
        return memoFilePath;
    }
    public void setMemoFilePath(String memoFilePath) {
        this.memoFilePath = memoFilePath;
    }
    public String geteNation() {
        return eNation;
    }
    public void seteNation(String eNation) {
        this.eNation = eNation;
    }
    
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("OrderMemoMasterVo {\n    compcd : ");
        builder.append(compcd);
        builder.append(",\n    orgcd : ");
        builder.append(orgcd);
        builder.append(",\n    whcd : ");
        builder.append(whcd);
        builder.append(",\n    orderMemoSeq : ");
        builder.append(orderMemoSeq);
        builder.append(",\n    xrtInvcSno : ");
        builder.append(xrtInvcSno);
        builder.append(",\n    ordNo : ");
        builder.append(ordNo);
        builder.append(",\n    title : ");
        builder.append(title);
        builder.append(",\n    contents : ");
        builder.append(contents);
        builder.append(",\n    replyCount : ");
        builder.append(replyCount);
        builder.append(",\n    shippingStatus : ");
        builder.append(shippingStatus);
        builder.append(",\n    statusCd : ");
        builder.append(statusCd);
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
        builder.append(",\n    memoAuthority : ");
        builder.append(memoAuthority);
        builder.append(",\n    memoMultiFile : ");
        builder.append(memoMultiFile);
        builder.append(",\n    memoFilePath : ");
        builder.append(memoFilePath);
        builder.append(",\n    eNation : ");
        builder.append(eNation);
        builder.append("\n}");
        return builder.toString();
    }
}
