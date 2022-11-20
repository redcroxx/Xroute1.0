package xrt.fulfillment.order.shippinglist;

import java.io.Serializable;

public class OrderVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String ordCd; // 오더CD
    private String comcd; // 회사코드
    private String orgcd; // 화주코드
    private String whcd; // 창고코드
    private String uploadDate; // 오더등록일
    private String fileSeq; // 차수
    private String fileNm; // 차수명
    private String fileNmReal; // 파일명
    private String siteCd; // 주문서양식코드
    private String relaySeq; // 오더업로드 Seq
    private String statusCd; // 주문상태
    private String statusCdKr; // 주문상태 한글
    private String stockType; // 재고 구분
    private String mallNm; // 쇼핑몰이름
    private String sellerRefNo1; // 판매자 참조1
    private String sellerRefNo2; // 판매자 참조2
    private String shipMethodCd; // 서비스 타입
    private String localShipper; // 현지 배송사
    private String ordNo; // 주문번호
    private String cartNo; // 장바구니번호
    private String ordCnt; // 주문수량
    private String xrtInvcSno; // XROUTE 송장번호
    private String invcSno1; // 송장번호1
    private String invcSno2; // 송장번호2
    private String sNation; // 출발국가
    private String eNation; // 도착국가
    private String wgt; // XRT_무게 (Kg)
    private String boxWidth; // XRT_가로(Cm)
    private String boxLength; // XRT_세로(Cm)
    private String boxHeight; // XRT_높이(Cm)
    private String boxVolume; // XRT_부피 중량(가로x세로x높이/6000)
    private String cWgtCharge; // 과금 중량(Kg)
    private String cWgtReal; // 실제 중량(Kg)
    private String cBoxWidth; // 가로(Cm)
    private String cBoxLength; // 세로(Cm)
    private String cBoxHeight; // 높이(Cm)
    private String cWgtVolume; // 부피 중량(Kg)
    private String shipName; // 송화인명
    private String shipTel; // 송화인 전화번호
    private String shipMobile; // 송화인 휴대폰
    private String shipAddr; // 송화인 주소
    private String shipPost; // 송화인 우편번호
    private String recvName; // 수취인명
    private String recvTel; // 수취인 전화번호
    private String recvMobile; // 수취인 휴대폰
    private String recvAddr1; // 수취인 주소1
    private String recvAddr2; // 수취인 주소2
    private String recvCity; // 수취인 도시
    private String recvState; // 수취인 주
    private String recvPost; // 수취인 우편번호
    private String recvNation; // 수취인 국가
    private String recvCurrency; // 수취인 통화
    private String totPaymentPric; // 구매자 총결제금액
    private String invcPrintCnt; // 송장출력건수
    private String invcPrintDate; // 송장출력
    private String stockUsercd; // 입고처리ID
    private String stockDate; // 입고일자
    private String addusercd; // 등록자ID
    private String adddatetime; // 등록일시
    private String updusercd; // 수정자ID
    private String upddatetime; // 수정일시
    private String terminalcd; // IP
    private String delFlg; // 삭제FLG
    private String goodsCd; // 상품번호
    private String goodsNm; // 상품명
    private String goodsOption; // 상품옵션
    private String goodsCnt; // 상품수량
    private String totPaymentPrice; // 구매자 결제금액
    private String tallyDatetime; // 상품검수날짜
    private String tallyUserCd; // 상품검수 ID
    private String paymentType; // 결제타입구분
    private String purchaseUrl;
    private String upsError; // UPS 송장 발번 여부.

    private int sListCnt; // 리스트 갯수

    public String getOrdCd() {
        return ordCd;
    }

    public void setOrdCd(String ordCd) {
        this.ordCd = ordCd;
    }

    public String getComcd() {
        return comcd;
    }

    public void setComcd(String comcd) {
        this.comcd = comcd;
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

    public String getRelaySeq() {
        return relaySeq;
    }

    public void setRelaySeq(String relaySeq) {
        this.relaySeq = relaySeq;
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
        this.xrtInvcSno = xrtInvcSno;
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

    public String getTotPaymentPric() {
        return totPaymentPric;
    }

    public void setTotPaymentPric(String totPaymentPric) {
        this.totPaymentPric = totPaymentPric;
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

    public String getDelFlg() {
        return delFlg;
    }

    public void setDelFlg(String delFlg) {
        this.delFlg = delFlg;
    }

    public String getGoodsCd() {
        return goodsCd;
    }

    public void setGoodsCd(String goodsCd) {
        this.goodsCd = goodsCd;
    }

    public String getGoodsNm() {
        return goodsNm;
    }

    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    public String getGoodsOption() {
        return goodsOption;
    }

    public void setGoodsOption(String goodsOption) {
        this.goodsOption = goodsOption;
    }

    public String getGoodsCnt() {
        return goodsCnt;
    }

    public void setGoodsCnt(String goodsCnt) {
        this.goodsCnt = goodsCnt;
    }

    public String getTotPaymentPrice() {
        return totPaymentPrice;
    }

    public void setTotPaymentPrice(String totPaymentPrice) {
        this.totPaymentPrice = totPaymentPrice;
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

    public int getsListCnt() {
        return sListCnt;
    }

    public void setsListCnt(int sListCnt) {
        this.sListCnt = sListCnt;
    }

    public String getStatusCdKr() {
        return statusCdKr;
    }

    public void setStatusCdKr(String statusCdKr) {
        this.statusCdKr = statusCdKr;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getPurchaseUrl() {
        return purchaseUrl;
    }

    public void setPurchaseUrl(String purchaseUrl) {
        this.purchaseUrl = purchaseUrl;
    }
    
    public String getUpsError() {
        return upsError;
    }

    public void setUpsError(String upsError) {
        this.upsError = upsError;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("OrderVo {\n    ordCd : ");
        builder.append(ordCd);
        builder.append(",\n    comcd : ");
        builder.append(comcd);
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
        builder.append(",\n    relaySeq : ");
        builder.append(relaySeq);
        builder.append(",\n    statusCd : ");
        builder.append(statusCd);
        builder.append(",\n    statusCdKr : ");
        builder.append(statusCdKr);
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
        builder.append(",\n    totPaymentPric : ");
        builder.append(totPaymentPric);
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
        builder.append(",\n    delFlg : ");
        builder.append(delFlg);
        builder.append(",\n    goodsCd : ");
        builder.append(goodsCd);
        builder.append(",\n    goodsNm : ");
        builder.append(goodsNm);
        builder.append(",\n    goodsOption : ");
        builder.append(goodsOption);
        builder.append(",\n    goodsCnt : ");
        builder.append(goodsCnt);
        builder.append(",\n    totPaymentPrice : ");
        builder.append(totPaymentPrice);
        builder.append(",\n    tallyDatetime : ");
        builder.append(tallyDatetime);
        builder.append(",\n    tallyUserCd : ");
        builder.append(tallyUserCd);
        builder.append(",\n    paymentType : ");
        builder.append(paymentType);
        builder.append(",\n    purchaseUrl : ");
        builder.append(purchaseUrl);
        builder.append(",\n    upsError : ");
        builder.append(upsError);
        builder.append(",\n    sListCnt : ");
        builder.append(sListCnt);
        builder.append("\n}");
        return builder.toString();
    }
}
