package xrt.fulfillment.interfaces.vo;

import java.io.Serializable;
import java.math.BigDecimal;

public class TOrderVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String ordCd;               
    private String compcd;              
    private String orgcd;               
    private String whcd;                
    private String uploadDate;          
    private String fileSeq;             
    private String fileNm;              
    private String fileNmReal;          
    private String siteCd;              
    private String statusCd;            
    private String stockType;           
    private String mallNm;              
    private String sellerRefNo1;        
    private String sellerRefNo2;        
    private String shipMethodCd;        
    private String localShipper;        
    private String ordNo;               
    private String cartNo;              
    private String ordCnt;              
    private String xrtInvcSno;          
    private String invcSno1;            
    private String invcSno2;            
    private String sNation;             
    private String eNation;             
    private String wgt;                 
    private String boxWidth;            
    private String boxLength;           
    private String boxHeight;           
    private String boxVolume;           
    private String cWgtCharge;          
    private String cWgtReal;            
    private String cBoxWidth;           
    private String cBoxLength;          
    private String cBoxHeight;          
    private String cWgtVolume;          
    private String shipName;            
    private String shipTel;             
    private String shipMobile;          
    private String shipAddr;            
    private String shipPost;            
    private String recvName;            
    private String recvTel;             
    private String recvMobile;          
    private String recvAddr1;           
    private String recvAddr2;           
    private String recvCity;            
    private String recvState;           
    private String recvPost;            
    private String recvNation;          
    private String recvCurrency;        
    private String totPaymentPrice;     
    private String invcPrintCnt;        
    private String invcPrintDate;       
    private String stockUsercd;         
    private String stockDate;           
    private String addusercd;           
    private String adddatetime;         
    private String updusercd;           
    private String upddatetime;         
    private String terminalcd;          
    private long relaySeq;              
    private long fileRelaySeq;          
    private String slug1;               
    private String slug2;               
    private String delFlg;              
    private String amount;              
    private String shippoId;            
    private String invcSno3;            
    private String tallyDatetime;       
    private String tallyUserCd;         
    private String cShippingPrice;      
    private String xrtShippingPrice;    
    private String shippingCompany;     
    private String cShippingPriceUnit;  
    private String xrtShippingPricedate;
    private String cShippingPricedate;  
    private String paymentType;         
    private BigDecimal inputAmount;
    private String apiInvcSno;          
    private String purchaseUrl;
    private String shipmentBlNo;
    private String pcc;
    private String expNo;
    private String boxSize;
    private String dasNo;               
    private String pickingPage;         
    private String pickingSeq;          
    private String boxNo;               
    private String confirmDate;
    private String graphicImage;        
    private String htmlImage;           
    private String clgoScanYn;          
    private String clgoScanAdmin;       
    private String clgoScanYmdh;        
    private String upsError;
    private String purchasesPrice1;
    private String purchasesPrice2;
    private String purchasesPrice3;
    private String unipassRefresh;
    private String unipassTkofdt;
    private String clgodatetime;
    private String shpmcmplYn;
                                             
    public String getOrdCd() {               
        return ordCd;                        
    }                                        
                                             
    public void setOrdCd(String ordCd) {     
        if (ordCd.contains("W")) {           
            this.ordCd = ordCd;
        } else {
            this.ordCd = "W" + ordCd;
        }
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

    public String getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(String uploadDate) {
        this.uploadDate = uploadDate;
    }

    public String getFileSeq() {
        return fileSeq;
    }

    public void setFileSeq(String fileSeq) {
        this.fileSeq = fileSeq;
    }

    public String getFileNm() {
        return fileNm;
    }

    public void setFileNm(String fileNm) {
        this.fileNm = fileNm;
    }

    public String getFileNmReal() {
        return fileNmReal;
    }

    public void setFileNmReal(String fileNmReal) {
        this.fileNmReal = fileNmReal;
    }

    public String getSiteCd() {
        return siteCd;
    }

    public void setSiteCd(String siteCd) {
        this.siteCd = siteCd;
    }

    public String getStatusCd() {
        return statusCd;
    }

    public void setStatusCd(String statusCd) {
        this.statusCd = statusCd;
    }

    public String getStockType() {
        return stockType;
    }

    public void setStockType(String stockType) {
        this.stockType = stockType;
    }

    public String getMallNm() {
        return mallNm;
    }

    public void setMallNm(String mallNm) {
        this.mallNm = mallNm;
    }

    public String getSellerRefNo1() {
        return sellerRefNo1;
    }

    public void setSellerRefNo1(String sellerRefNo1) {
        this.sellerRefNo1 = sellerRefNo1;
    }

    public String getSellerRefNo2() {
        return sellerRefNo2;
    }

    public void setSellerRefNo2(String sellerRefNo2) {
        this.sellerRefNo2 = sellerRefNo2;
    }

    public String getShipMethodCd() {
        return shipMethodCd;
    }

    public void setShipMethodCd(String shipMethodCd) {
        this.shipMethodCd = shipMethodCd;
    }

    public String getLocalShipper() {
        return localShipper;
    }

    public void setLocalShipper(String localShipper) {
        this.localShipper = localShipper;
    }

    public String getOrdNo() {
        return ordNo;
    }

    public void setOrdNo(String ordNo) {
        this.ordNo = ordNo;
    }

    public String getCartNo() {
        return cartNo;
    }

    public void setCartNo(String cartNo) {
        this.cartNo = cartNo;
    }

    public String getOrdCnt() {
        return ordCnt;
    }

    public void setOrdCnt(String ordCnt) {
        this.ordCnt = ordCnt;
    }

    public String getXrtInvcSno() {
        return xrtInvcSno;
    }

    public void setXrtInvcSno(String xrtInvcSno) {

        if (xrtInvcSno.contains("XLF")) {
            this.xrtInvcSno = xrtInvcSno;
        } else {
            this.xrtInvcSno = "XLF" + xrtInvcSno;
        }
    }

    public String getInvcSno1() {
        return invcSno1;
    }

    public void setInvcSno1(String invcSno1) {
        this.invcSno1 = invcSno1;
    }

    public String getInvcSno2() {
        return invcSno2;
    }

    public void setInvcSno2(String invcSno2) {
        this.invcSno2 = invcSno2;
    }

    public String getsNation() {
        return sNation;
    }

    public void setsNation(String sNation) {
        this.sNation = sNation;
    }

    public String geteNation() {
        return eNation;
    }

    public void seteNation(String eNation) {
        this.eNation = eNation;
    }

    public String getWgt() {
        return wgt;
    }

    public void setWgt(String wgt) {
        this.wgt = wgt;
    }

    public String getBoxWidth() {
        return boxWidth;
    }

    public void setBoxWidth(String boxWidth) {
        this.boxWidth = boxWidth;
    }

    public String getBoxLength() {
        return boxLength;
    }

    public void setBoxLength(String boxLength) {
        this.boxLength = boxLength;
    }

    public String getBoxHeight() {
        return boxHeight;
    }

    public void setBoxHeight(String boxHeight) {
        this.boxHeight = boxHeight;
    }

    public String getBoxVolume() {
        return boxVolume;
    }

    public void setBoxVolume(String boxVolume) {
        this.boxVolume = boxVolume;
    }

    public String getcWgtCharge() {
        return cWgtCharge;
    }

    public void setcWgtCharge(String cWgtCharge) {
        this.cWgtCharge = cWgtCharge;
    }

    public String getcWgtReal() {
        return cWgtReal;
    }

    public void setcWgtReal(String cWgtReal) {
        this.cWgtReal = cWgtReal;
    }

    public String getcBoxWidth() {
        return cBoxWidth;
    }

    public void setcBoxWidth(String cBoxWidth) {
        this.cBoxWidth = cBoxWidth;
    }

    public String getcBoxLength() {
        return cBoxLength;
    }

    public void setcBoxLength(String cBoxLength) {
        this.cBoxLength = cBoxLength;
    }

    public String getcBoxHeight() {
        return cBoxHeight;
    }

    public void setcBoxHeight(String cBoxHeight) {
        this.cBoxHeight = cBoxHeight;
    }

    public String getcWgtVolume() {
        return cWgtVolume;
    }

    public void setcWgtVolume(String cWgtVolume) {
        this.cWgtVolume = cWgtVolume;
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

    public String getShipMobile() {
        return shipMobile;
    }

    public void setShipMobile(String shipMobile) {
        this.shipMobile = shipMobile;
    }

    public String getShipAddr() {
        return shipAddr;
    }

    public void setShipAddr(String shipAddr) {
        this.shipAddr = shipAddr;
    }

    public String getShipPost() {
        return shipPost;
    }

    public void setShipPost(String shipPost) {
        this.shipPost = shipPost;
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

    public String getRecvMobile() {
        return recvMobile;
    }

    public void setRecvMobile(String recvMobile) {
        this.recvMobile = recvMobile;
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

    public String getRecvNation() {
        return recvNation;
    }

    public void setRecvNation(String recvNation) {
        this.recvNation = recvNation;
    }

    public String getRecvCurrency() {
        return recvCurrency;
    }

    public void setRecvCurrency(String recvCurrency) {
        this.recvCurrency = recvCurrency;
    }

    public String getTotPaymentPrice() {
        return totPaymentPrice;
    }

    public void setTotPaymentPrice(String totPaymentPrice) {
        this.totPaymentPrice = totPaymentPrice;
    }

    public String getInvcPrintCnt() {
        return invcPrintCnt;
    }

    public void setInvcPrintCnt(String invcPrintCnt) {
        this.invcPrintCnt = invcPrintCnt;
    }

    public String getInvcPrintDate() {
        return invcPrintDate;
    }

    public void setInvcPrintDate(String invcPrintDate) {
        this.invcPrintDate = invcPrintDate;
    }

    public String getStockUsercd() {
        return stockUsercd;
    }

    public void setStockUsercd(String stockUsercd) {
        this.stockUsercd = stockUsercd;
    }

    public String getStockDate() {
        return stockDate;
    }

    public void setStockDate(String stockDate) {
        this.stockDate = stockDate;
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

    public long getRelaySeq() {
        return relaySeq;
    }

    public void setRelaySeq(long relaySeq) {
        this.relaySeq = relaySeq;
    }

    public long getFileRelaySeq() {
        return fileRelaySeq;
    }

    public void setFileRelaySeq(long fileRelaySeq) {
        this.fileRelaySeq = fileRelaySeq;
    }

    public String getSlug1() {
        return slug1;
    }

    public void setSlug1(String slug1) {
        this.slug1 = slug1;
    }

    public String getSlug2() {
        return slug2;
    }

    public void setSlug2(String slug2) {
        this.slug2 = slug2;
    }

    public String getDelFlg() {
        return delFlg;
    }

    public void setDelFlg(String delFlg) {
        this.delFlg = delFlg;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getShippoId() {
        return shippoId;
    }

    public void setShippoId(String shippoId) {
        this.shippoId = shippoId;
    }

    public String getInvcSno3() {
        return invcSno3;
    }

    public void setInvcSno3(String invcSno3) {
        this.invcSno3 = invcSno3;
    }

    public String getTallyDatetime() {
        return tallyDatetime;
    }

    public void setTallyDatetime(String tallyDatetime) {
        this.tallyDatetime = tallyDatetime;
    }

    public String getTallyUserCd() {
        return tallyUserCd;
    }

    public void setTallyUserCd(String tallyUserCd) {
        this.tallyUserCd = tallyUserCd;
    }

    public String getcShippingPrice() {
        return cShippingPrice;
    }

    public void setcShippingPrice(String cShippingPrice) {
        this.cShippingPrice = cShippingPrice;
    }

    public String getXrtShippingPrice() {
        return xrtShippingPrice;
    }

    public void setXrtShippingPrice(String xrtShippingPrice) {
        this.xrtShippingPrice = xrtShippingPrice;
    }

    public String getShippingCompany() {
        return shippingCompany;
    }

    public void setShippingCompany(String shippingCompany) {
        this.shippingCompany = shippingCompany;
    }

    public String getcShippingPriceUnit() {
        return cShippingPriceUnit;
    }

    public void setcShippingPriceUnit(String cShippingPriceUnit) {
        this.cShippingPriceUnit = cShippingPriceUnit;
    }

    public String getXrtShippingPricedate() {
        return xrtShippingPricedate;
    }

    public void setXrtShippingPricedate(String xrtShippingPricedate) {
        this.xrtShippingPricedate = xrtShippingPricedate;
    }

    public String getcShippingPricedate() {
        return cShippingPricedate;
    }

    public void setcShippingPricedate(String cShippingPricedate) {
        this.cShippingPricedate = cShippingPricedate;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getApiInvcSno() {
        return apiInvcSno;
    }

    public void setApiInvcSno(String apiInvcSno) {
        this.apiInvcSno = apiInvcSno;
    }

    public BigDecimal getInputAmount() {
        return inputAmount;
    }

    public void setInputAmount(BigDecimal inputAmount) {
        this.inputAmount = inputAmount;
    }

    public String getPurchaseUrl() {
        return purchaseUrl;
    }

    public void setPurchaseUrl(String purchaseUrl) {
        this.purchaseUrl = purchaseUrl;
    }

    public String getShipmentBlNo() {
        return shipmentBlNo;
    }

    public void setShipmentBlNo(String shipmentBlNo) {
        this.shipmentBlNo = shipmentBlNo;
    }

    public String getPcc() {
        return pcc;
    }

    public void setPcc(String pcc) {
        this.pcc = pcc;
    }

    public String getExpNo() {
        return expNo;
    }

    public void setExpNo(String expNo) {
        this.expNo = expNo;
    }

    public String getBoxSize() {
        return boxSize;
    }

    public void setBoxSize(String boxSize) {
        this.boxSize = boxSize;
    }

    public String getDasNo() {
        return dasNo;
    }

    public void setDasNo(String dasNo) {
        this.dasNo = dasNo;
    }

    public String getPickingPage() {
        return pickingPage;
    }

    public void setPickingPage(String pickingPage) {
        this.pickingPage = pickingPage;
    }

    public String getPickingSeq() {
        return pickingSeq;
    }

    public void setPickingSeq(String pickingSeq) {
        this.pickingSeq = pickingSeq;
    }

    public String getBoxNo() {
        return boxNo;
    }

    public void setBoxNo(String boxNo) {
        this.boxNo = boxNo;
    }

    public String getConfirmDate() {
        return confirmDate;
    }

    public void setConfirmDate(String confirmDate) {
        this.confirmDate = confirmDate;
    }

    public String getGraphicImage() {
        return graphicImage;
    }

    public void setGraphicImage(String graphicImage) {
        this.graphicImage = graphicImage;
    }

    public String getHtmlImage() {
        return htmlImage;
    }

    public void setHtmlImage(String htmlImage) {
        this.htmlImage = htmlImage;
    }

    public String getClgoScanYn() {
        return clgoScanYn;
    }

    public void setClgoScanYn(String clgoScanYn) {
        this.clgoScanYn = clgoScanYn;
    }

    public String getClgoScanAdmin() {
        return clgoScanAdmin;
    }

    public void setClgoScanAdmin(String clgoScanAdmin) {
        this.clgoScanAdmin = clgoScanAdmin;
    }

    public String getClgoScanYmdh() {
        return clgoScanYmdh;
    }

    public void setClgoScanYmdh(String clgoScanYmdh) {
        this.clgoScanYmdh = clgoScanYmdh;
    }

    public String getUpsError() {
        return upsError;
    }

    public void setUpsError(String upsError) {
        this.upsError = upsError;
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

    public String getUnipassRefresh() {
        return unipassRefresh;
    }

    public void setUnipassRefresh(String unipassRefresh) {
        this.unipassRefresh = unipassRefresh;
    }

    public String getUnipassTkofdt() {
        return unipassTkofdt;
    }

    public void setUnipassTkofdt(String unipassTkofdt) {
        this.unipassTkofdt = unipassTkofdt;
    }

    public String getClgodatetime() {
        return clgodatetime;
    }

    public void setClgodatetime(String clgodatetime) {
        this.clgodatetime = clgodatetime;
    }

    public String getShpmcmplYn() {
        return shpmcmplYn;
    }

    public void setShpmcmplYn(String shpmcmplYn) {
        this.shpmcmplYn = shpmcmplYn;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("TOrderVo {\n    ordCd : ");
        builder.append(ordCd);
        builder.append(",\n    compcd : ");
        builder.append(compcd);
        builder.append(",\n    orgcd : ");
        builder.append(orgcd);
        builder.append(",\n    whcd : ");
        builder.append(whcd);
        builder.append(",\n    uploadDate : ");
        builder.append(uploadDate);
        builder.append(",\n    fileSeq : ");
        builder.append(fileSeq);
        builder.append(",\n    fileNm : ");
        builder.append(fileNm);
        builder.append(",\n    fileNmReal : ");
        builder.append(fileNmReal);
        builder.append(",\n    siteCd : ");
        builder.append(siteCd);
        builder.append(",\n    statusCd : ");
        builder.append(statusCd);
        builder.append(",\n    stockType : ");
        builder.append(stockType);
        builder.append(",\n    mallNm : ");
        builder.append(mallNm);
        builder.append(",\n    sellerRefNo1 : ");
        builder.append(sellerRefNo1);
        builder.append(",\n    sellerRefNo2 : ");
        builder.append(sellerRefNo2);
        builder.append(",\n    shipMethodCd : ");
        builder.append(shipMethodCd);
        builder.append(",\n    localShipper : ");
        builder.append(localShipper);
        builder.append(",\n    ordNo : ");
        builder.append(ordNo);
        builder.append(",\n    cartNo : ");
        builder.append(cartNo);
        builder.append(",\n    ordCnt : ");
        builder.append(ordCnt);
        builder.append(",\n    xrtInvcSno : ");
        builder.append(xrtInvcSno);
        builder.append(",\n    invcSno1 : ");
        builder.append(invcSno1);
        builder.append(",\n    invcSno2 : ");
        builder.append(invcSno2);
        builder.append(",\n    sNation : ");
        builder.append(sNation);
        builder.append(",\n    eNation : ");
        builder.append(eNation);
        builder.append(",\n    wgt : ");
        builder.append(wgt);
        builder.append(",\n    boxWidth : ");
        builder.append(boxWidth);
        builder.append(",\n    boxLength : ");
        builder.append(boxLength);
        builder.append(",\n    boxHeight : ");
        builder.append(boxHeight);
        builder.append(",\n    boxVolume : ");
        builder.append(boxVolume);
        builder.append(",\n    cWgtCharge : ");
        builder.append(cWgtCharge);
        builder.append(",\n    cWgtReal : ");
        builder.append(cWgtReal);
        builder.append(",\n    cBoxWidth : ");
        builder.append(cBoxWidth);
        builder.append(",\n    cBoxLength : ");
        builder.append(cBoxLength);
        builder.append(",\n    cBoxHeight : ");
        builder.append(cBoxHeight);
        builder.append(",\n    cWgtVolume : ");
        builder.append(cWgtVolume);
        builder.append(",\n    shipName : ");
        builder.append(shipName);
        builder.append(",\n    shipTel : ");
        builder.append(shipTel);
        builder.append(",\n    shipMobile : ");
        builder.append(shipMobile);
        builder.append(",\n    shipAddr : ");
        builder.append(shipAddr);
        builder.append(",\n    shipPost : ");
        builder.append(shipPost);
        builder.append(",\n    recvName : ");
        builder.append(recvName);
        builder.append(",\n    recvTel : ");
        builder.append(recvTel);
        builder.append(",\n    recvMobile : ");
        builder.append(recvMobile);
        builder.append(",\n    recvAddr1 : ");
        builder.append(recvAddr1);
        builder.append(",\n    recvAddr2 : ");
        builder.append(recvAddr2);
        builder.append(",\n    recvCity : ");
        builder.append(recvCity);
        builder.append(",\n    recvState : ");
        builder.append(recvState);
        builder.append(",\n    recvPost : ");
        builder.append(recvPost);
        builder.append(",\n    recvNation : ");
        builder.append(recvNation);
        builder.append(",\n    recvCurrency : ");
        builder.append(recvCurrency);
        builder.append(",\n    totPaymentPrice : ");
        builder.append(totPaymentPrice);
        builder.append(",\n    invcPrintCnt : ");
        builder.append(invcPrintCnt);
        builder.append(",\n    invcPrintDate : ");
        builder.append(invcPrintDate);
        builder.append(",\n    stockUsercd : ");
        builder.append(stockUsercd);
        builder.append(",\n    stockDate : ");
        builder.append(stockDate);
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
        builder.append(",\n    relaySeq : ");
        builder.append(relaySeq);
        builder.append(",\n    fileRelaySeq : ");
        builder.append(fileRelaySeq);
        builder.append(",\n    slug1 : ");
        builder.append(slug1);
        builder.append(",\n    slug2 : ");
        builder.append(slug2);
        builder.append(",\n    delFlg : ");
        builder.append(delFlg);
        builder.append(",\n    amount : ");
        builder.append(amount);
        builder.append(",\n    shippoId : ");
        builder.append(shippoId);
        builder.append(",\n    invcSno3 : ");
        builder.append(invcSno3);
        builder.append(",\n    tallyDatetime : ");
        builder.append(tallyDatetime);
        builder.append(",\n    tallyUserCd : ");
        builder.append(tallyUserCd);
        builder.append(",\n    cShippingPrice : ");
        builder.append(cShippingPrice);
        builder.append(",\n    xrtShippingPrice : ");
        builder.append(xrtShippingPrice);
        builder.append(",\n    shippingCompany : ");
        builder.append(shippingCompany);
        builder.append(",\n    cShippingPriceUnit : ");
        builder.append(cShippingPriceUnit);
        builder.append(",\n    xrtShippingPricedate : ");
        builder.append(xrtShippingPricedate);
        builder.append(",\n    cShippingPricedate : ");
        builder.append(cShippingPricedate);
        builder.append(",\n    paymentType : ");
        builder.append(paymentType);
        builder.append(",\n    inputAmount : ");
        builder.append(inputAmount);
        builder.append(",\n    apiInvcSno : ");
        builder.append(apiInvcSno);
        builder.append(",\n    purchaseUrl : ");
        builder.append(purchaseUrl);
        builder.append(",\n    shipmentBlNo : ");
        builder.append(shipmentBlNo);
        builder.append(",\n    pcc : ");
        builder.append(pcc);
        builder.append(",\n    expNo : ");
        builder.append(expNo);
        builder.append(",\n    boxSize : ");
        builder.append(boxSize);
        builder.append(",\n    dasNo : ");
        builder.append(dasNo);
        builder.append(",\n    pickingPage : ");
        builder.append(pickingPage);
        builder.append(",\n    pickingSeq : ");
        builder.append(pickingSeq);
        builder.append(",\n    boxNo : ");
        builder.append(boxNo);
        builder.append(",\n    confirmDate : ");
        builder.append(confirmDate);
        builder.append(",\n    graphicImage : ");
        builder.append(graphicImage);
        builder.append(",\n    htmlImage : ");
        builder.append(htmlImage);
        builder.append(",\n    clgoScanYn : ");
        builder.append(clgoScanYn);
        builder.append(",\n    clgoScanAdmin : ");
        builder.append(clgoScanAdmin);
        builder.append(",\n    clgoScanYmdh : ");
        builder.append(clgoScanYmdh);
        builder.append(",\n    upsError : ");
        builder.append(upsError);
        builder.append(",\n    purchasesPrice1 : ");
        builder.append(purchasesPrice1);
        builder.append(",\n    purchasesPrice2 : ");
        builder.append(purchasesPrice2);
        builder.append(",\n    purchasesPrice3 : ");
        builder.append(purchasesPrice3);
        builder.append(",\n    unipassRefresh : ");
        builder.append(unipassRefresh);
        builder.append(",\n    unipassTkofdt : ");
        builder.append(unipassTkofdt);
        builder.append(",\n    clgodatetime : ");
        builder.append(clgodatetime);
        builder.append(",\n    shpmcmplYn : ");
        builder.append(shpmcmplYn);
        builder.append("\n}");
        return builder.toString();
    }
}
