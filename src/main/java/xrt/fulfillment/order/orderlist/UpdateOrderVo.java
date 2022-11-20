package xrt.fulfillment.order.orderlist;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class UpdateOrderVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String compcd;
    private String orgcd;
    private String whcd;
    private String xrtInvcSno;
    private String prevPaymentType;
    private String prevMallNm;
    private String prevShipMethodCd;
    private String prevShipName;
    private String prevShipTel;
    private String prevRecvName;
    private String prevRecvTel;
    private String prevRecvCity;
    private String prevRecvState;
    private String prevRecvPost;
    private String prevRecvAddr1;
    private String prevRecvAddr2;
    private String prevStatusCd;
    private String prevTotPaymentPrice;
    private String prevPurchaseUrl;
    private String paymentType;
    private String mallNm;
    private String shipMethodCd;
    private String shipName;
    private String shipTel;
    private String recvName;
    private String recvTel;
    private String recvCity;
    private String recvState;
    private String recvPost;
    private String recvAddr1;
    private String recvAddr2;
    private String statusCd;
    private String totPaymentPrice;
    private String purchaseUrl;
    private List<UpdateOrderDtlVo> items;
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
    public String getXrtInvcSno() {
        return xrtInvcSno;
    }
    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }
    public String getPrevPaymentType() {
        return prevPaymentType;
    }
    public void setPrevPaymentType(String prevPaymentType) {
        this.prevPaymentType = prevPaymentType;
    }
    public String getPrevMallNm() {
        return prevMallNm;
    }
    public void setPrevMallNm(String prevMallNm) {
        this.prevMallNm = prevMallNm;
    }
    public String getPrevShipMethodCd() {
        return prevShipMethodCd;
    }
    public void setPrevShipMethodCd(String prevShipMethodCd) {
        this.prevShipMethodCd = prevShipMethodCd;
    }
    public String getPrevShipName() {
        return prevShipName;
    }
    public void setPrevShipName(String prevShipName) {
        this.prevShipName = prevShipName;
    }
    public String getPrevShipTel() {
        return prevShipTel;
    }
    public void setPrevShipTel(String prevShipTel) {
        this.prevShipTel = prevShipTel;
    }
    public String getPrevRecvName() {
        return prevRecvName;
    }
    public void setPrevRecvName(String prevRecvName) {
        this.prevRecvName = prevRecvName;
    }
    public String getPrevRecvTel() {
        return prevRecvTel;
    }
    public void setPrevRecvTel(String prevRecvTel) {
        this.prevRecvTel = prevRecvTel;
    }
    public String getPrevRecvCity() {
        return prevRecvCity;
    }
    public void setPrevRecvCity(String prevRecvCity) {
        this.prevRecvCity = prevRecvCity;
    }
    public String getPrevRecvState() {
        return prevRecvState;
    }
    public void setPrevRecvState(String prevRecvState) {
        this.prevRecvState = prevRecvState;
    }
    public String getPrevRecvPost() {
        return prevRecvPost;
    }
    public void setPrevRecvPost(String prevRecvPost) {
        this.prevRecvPost = prevRecvPost;
    }
    public String getPrevRecvAddr1() {
        return prevRecvAddr1;
    }
    public void setPrevRecvAddr1(String prevRecvAddr1) {
        this.prevRecvAddr1 = prevRecvAddr1;
    }
    public String getPrevRecvAddr2() {
        return prevRecvAddr2;
    }
    public void setPrevRecvAddr2(String prevRecvAddr2) {
        this.prevRecvAddr2 = prevRecvAddr2;
    }
    public String getPrevStatusCd() {
        return prevStatusCd;
    }
    public void setPrevStatusCd(String prevStatusCd) {
        this.prevStatusCd = prevStatusCd;
    }
    public String getPrevTotPaymentPrice() {
        return prevTotPaymentPrice;
    }
    public void setPrevTotPaymentPrice(String prevTotPaymentPrice) {
        this.prevTotPaymentPrice = prevTotPaymentPrice;
    }
    public String getPrevPurchaseUrl() {
        return prevPurchaseUrl;
    }
    public void setPrevPurchaseUrl(String prevPurchaseUrl) {
        this.prevPurchaseUrl = prevPurchaseUrl;
    }
    public String getPaymentType() {
        return paymentType;
    }
    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }
    public String getMallNm() {
        return mallNm;
    }
    public void setMallNm(String mallNm) {
        this.mallNm = mallNm;
    }
    public String getShipMethodCd() {
        return shipMethodCd;
    }
    public void setShipMethodCd(String shipMethodCd) {
        this.shipMethodCd = shipMethodCd;
    }
    public String getShipName() {
        return shipName;
    }
    public void setShipName(String shipName) {
        this.shipName = shipName;
    }
    public String getShipTel() {
        return shipTel;
    }
    public void setShipTel(String shipTel) {
        this.shipTel = shipTel;
    }
    public String getRecvName() {
        return recvName;
    }
    public void setRecvName(String recvName) {
        this.recvName = recvName;
    }
    public String getRecvTel() {
        return recvTel;
    }
    public void setRecvTel(String recvTel) {
        this.recvTel = recvTel;
    }
    public String getRecvCity() {
        return recvCity;
    }
    public void setRecvCity(String recvCity) {
        this.recvCity = recvCity;
    }
    public String getRecvState() {
        return recvState;
    }
    public void setRecvState(String recvState) {
        this.recvState = recvState;
    }
    public String getRecvPost() {
        return recvPost;
    }
    public void setRecvPost(String recvPost) {
        this.recvPost = recvPost;
    }
    public String getRecvAddr1() {
        return recvAddr1;
    }
    public void setRecvAddr1(String recvAddr1) {
        this.recvAddr1 = recvAddr1;
    }
    public String getRecvAddr2() {
        return recvAddr2;
    }
    public void setRecvAddr2(String recvAddr2) {
        this.recvAddr2 = recvAddr2;
    }
    public String getStatusCd() {
        return statusCd;
    }
    public void setStatusCd(String statusCd) {
        this.statusCd = statusCd;
    }
    public String getTotPaymentPrice() {
        return totPaymentPrice;
    }
    public void setTotPaymentPrice(String totPaymentPrice) {
        this.totPaymentPrice = totPaymentPrice;
    }
    public String getPurchaseUrl() {
        return purchaseUrl;
    }
    public void setPurchaseUrl(String purchaseUrl) {
        this.purchaseUrl = purchaseUrl;
    }
    public List<UpdateOrderDtlVo> getItems() {
        return items;
    }
    public void setItems(List<UpdateOrderDtlVo> items) {
        this.items = items;
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
        builder.append("UpdateOrderVo {\n    compcd : ");
        builder.append(compcd);
        builder.append(",\n    orgcd : ");
        builder.append(orgcd);
        builder.append(",\n    whcd : ");
        builder.append(whcd);
        builder.append(",\n    xrtInvcSno : ");
        builder.append(xrtInvcSno);
        builder.append(",\n    prevPaymentType : ");
        builder.append(prevPaymentType);
        builder.append(",\n    prevMallNm : ");
        builder.append(prevMallNm);
        builder.append(",\n    prevShipMethodCd : ");
        builder.append(prevShipMethodCd);
        builder.append(",\n    prevShipName : ");
        builder.append(prevShipName);
        builder.append(",\n    prevShipTel : ");
        builder.append(prevShipTel);
        builder.append(",\n    prevRecvName : ");
        builder.append(prevRecvName);
        builder.append(",\n    prevRecvTel : ");
        builder.append(prevRecvTel);
        builder.append(",\n    prevRecvCity : ");
        builder.append(prevRecvCity);
        builder.append(",\n    prevRecvState : ");
        builder.append(prevRecvState);
        builder.append(",\n    prevRecvPost : ");
        builder.append(prevRecvPost);
        builder.append(",\n    prevRecvAddr1 : ");
        builder.append(prevRecvAddr1);
        builder.append(",\n    prevRecvAddr2 : ");
        builder.append(prevRecvAddr2);
        builder.append(",\n    prevStatusCd : ");
        builder.append(prevStatusCd);
        builder.append(",\n    prevTotPaymentPrice : ");
        builder.append(prevTotPaymentPrice);
        builder.append(",\n    prevPurchaseUrl : ");
        builder.append(prevPurchaseUrl);
        builder.append(",\n    paymentType : ");
        builder.append(paymentType);
        builder.append(",\n    mallNm : ");
        builder.append(mallNm);
        builder.append(",\n    shipMethodCd : ");
        builder.append(shipMethodCd);
        builder.append(",\n    shipName : ");
        builder.append(shipName);
        builder.append(",\n    shipTel : ");
        builder.append(shipTel);
        builder.append(",\n    recvName : ");
        builder.append(recvName);
        builder.append(",\n    recvTel : ");
        builder.append(recvTel);
        builder.append(",\n    recvCity : ");
        builder.append(recvCity);
        builder.append(",\n    recvState : ");
        builder.append(recvState);
        builder.append(",\n    recvPost : ");
        builder.append(recvPost);
        builder.append(",\n    recvAddr1 : ");
        builder.append(recvAddr1);
        builder.append(",\n    recvAddr2 : ");
        builder.append(recvAddr2);
        builder.append(",\n    statusCd : ");
        builder.append(statusCd);
        builder.append(",\n    totPaymentPrice : ");
        builder.append(totPaymentPrice);
        builder.append(",\n    purchaseUrl : ");
        builder.append(purchaseUrl);
        builder.append(",\n    items : ");
        builder.append(items);
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
        builder.append("\n}");
        return builder.toString();
    }
}
