package xrt.fulfillment.order.settlement;

import java.io.Serializable;

public class SettlementListVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String orgcd; // 셀러ID
    private String mallNm; // 쇼핑몰
    private String xrtInvcSno; // 송장 번호
    private String invcSno1; // 배송No1
    private String invcSno2; // 배송No2
    private String uploadDate; // 업로드 일자
    private String shipMethodCd; // 서비스 타입
    private String localShipper; // 현지 배송사
    private String sNation; // 출발국가
    private String eNation; // 도착국가
    private String shipName; // 송화인명
    private String shipTel; // 송화인 전화번호
    private String shipMobile; // 송화인 휴대폰
    private String shipAddr; // 송화인 주소
    private String shipPost; // 송화인 우편번호
    private String recvName; // 수화인명
    private String recvTel; // 수화인 전화번호
    private String recvMobile; // 수화인 핸드폰번호
    private String recvAddr1; // 수화인 주소1
    private String recvAddr2; // 수화인 주소2
    private String recvPost; // 수화인 우편번호
    private String recvCity; // 도시
    private String recvState; // 주(State)
    private String recvCurrency; // 통화
    private String ordCnt; // 주문수량
    private String ordNo; // 주문번호
    private String cartNo; // 장바구니 번호
    private String goodsCd; // 상품번호
    private String goodsNm; // 상품명
    private String goodsOption; // 상품옵션
    private String goodsCnt; // 상품수량
    private String totPaymentPrice; // 구매자 결제금액
    private String statusCd; // 배송상태
    private String cWgtCharge; // 과금 중량(Kg)
    private String cWgtReal; // 실제 중량(Kg)
    private String cWgtVolume; // 부피 중량(Kg)
    private String cBoxWidth; // 가로(Cm)
    private String cBoxLength; // 세로(Cm)
    private String cBoxHeight; // 높이(Cm)
    private String xWgt; // XROUTE_중량(Kg)
    private String xBoxWidth; // XROUTE_가로(Cm)
    private String xBoxLength; // XROUTE_세로(Cm)
    private String xBoxHeight; // XROUTE_높이(Cm)
    private String upddatetime; // 수정 날짜/시간
    private String cShippingPrice; // 배송업체 판매가
    private String cShippingPriceUnit; // 배송업체판매가 단위
    private String xrtShippingPrice; // XRT판매가 (KRW)
    private String xrtShippingPricedate; // XRT판매가 갱신일시
    private String shipCompany; // 배송업체명
    private String sellerName;

    public String getOrgcd() {
        return orgcd;
    }

    public void setOrgcd(String orgcd) {
        this.orgcd = orgcd;
    }

    public String getMallNm() {
        return mallNm;
    }

    public void setMallNm(String mallNm) {
        this.mallNm = mallNm;
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

    public String getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(String uploadDate) {
        this.uploadDate = uploadDate;
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

    public String getRecvPost() {
        return recvPost;
    }

    public void setRecvPost(String recvPost) {
        this.recvPost = recvPost;
    }

    public String getRecvCurrency() {
        return recvCurrency;
    }

    public void setRecvCurrency(String recvCurrency) {
        this.recvCurrency = recvCurrency;
    }

    public String getOrdCnt() {
        return ordCnt;
    }

    public void setOrdCnt(String ordCnt) {
        this.ordCnt = ordCnt;
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

    public String getStatusCd() {
        return statusCd;
    }

    public void setStatusCd(String statusCd) {
        this.statusCd = statusCd;
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

    public String getcWgtVolume() {
        return cWgtVolume;
    }

    public void setcWgtVolume(String cWgtVolume) {
        this.cWgtVolume = cWgtVolume;
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

    public String getxWgt() {
        return xWgt;
    }

    public void setxWgt(String xWgt) {
        this.xWgt = xWgt;
    }

    public String getxBoxWidth() {
        return xBoxWidth;
    }

    public void setxBoxWidth(String xBoxWidth) {
        this.xBoxWidth = xBoxWidth;
    }

    public String getxBoxLength() {
        return xBoxLength;
    }

    public void setxBoxLength(String xBoxLength) {
        this.xBoxLength = xBoxLength;
    }

    public String getxBoxHeight() {
        return xBoxHeight;
    }

    public void setxBoxHeight(String xBoxHeight) {
        this.xBoxHeight = xBoxHeight;
    }

    public String getUpddatetime() {
        return upddatetime;
    }

    public void setUpddatetime(String upddatetime) {
        this.upddatetime = upddatetime;
    }

    public String getShipName() {
        return shipName;
    }

    public void setShipName(String shipName) {
        this.shipName = shipName;
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

    public String getcShippingPrice() {
        return cShippingPrice;
    }

    public void setcShippingPrice(String cShippingPrice) {
        this.cShippingPrice = cShippingPrice;
    }

    public String getcShippingPriceUnit() {
        return cShippingPriceUnit;
    }

    public void setcShippingPriceUnit(String cShippingPriceUnit) {
        this.cShippingPriceUnit = cShippingPriceUnit;
    }

    public String getXrtShippingPrice() {
        return xrtShippingPrice;
    }

    public void setXrtShippingPrice(String xrtShippingPrice) {
        this.xrtShippingPrice = xrtShippingPrice;
    }

    public String getXrtShippingPricedate() {
        return xrtShippingPricedate;
    }

    public void setXrtShippingPricedate(String xrtShippingPricedate) {
        this.xrtShippingPricedate = xrtShippingPricedate;
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

    public String getShipCompany() {
        return shipCompany;
    }

    public void setShipCompany(String shipCompany) {
        this.shipCompany = shipCompany;
    }

    public String getSellerName() {
        return sellerName;
    }

    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\torgcd: ");
        builder.append(orgcd);
        builder.append("\n\tmallNm: ");
        builder.append(mallNm);
        builder.append("\n\txrtInvcSno: ");
        builder.append(xrtInvcSno);
        builder.append("\n\tinvcSno1: ");
        builder.append(invcSno1);
        builder.append("\n\tinvcSno2: ");
        builder.append(invcSno2);
        builder.append("\n\tuploadDate: ");
        builder.append(uploadDate);
        builder.append("\n\tshipMethodCd: ");
        builder.append(shipMethodCd);
        builder.append("\n\tlocalShipper: ");
        builder.append(localShipper);
        builder.append("\n\tsNation: ");
        builder.append(sNation);
        builder.append("\n\teNation: ");
        builder.append(eNation);
        builder.append("\n\tshipName: ");
        builder.append(shipName);
        builder.append("\n\tshipTel: ");
        builder.append(shipTel);
        builder.append("\n\tshipMobile: ");
        builder.append(shipMobile);
        builder.append("\n\tshipAddr: ");
        builder.append(shipAddr);
        builder.append("\n\tshipPost: ");
        builder.append(shipPost);
        builder.append("\n\trecvName: ");
        builder.append(recvName);
        builder.append("\n\trecvTel: ");
        builder.append(recvTel);
        builder.append("\n\trecvMobile: ");
        builder.append(recvMobile);
        builder.append("\n\trecvAddr1: ");
        builder.append(recvAddr1);
        builder.append("\n\trecvAddr2: ");
        builder.append(recvAddr2);
        builder.append("\n\trecvPost: ");
        builder.append(recvPost);
        builder.append("\n\trecvCity: ");
        builder.append(recvCity);
        builder.append("\n\trecvState: ");
        builder.append(recvState);
        builder.append("\n\trecvCurrency: ");
        builder.append(recvCurrency);
        builder.append("\n\tordCnt: ");
        builder.append(ordCnt);
        builder.append("\n\tordNo: ");
        builder.append(ordNo);
        builder.append("\n\tcartNo: ");
        builder.append(cartNo);
        builder.append("\n\tgoodsCd: ");
        builder.append(goodsCd);
        builder.append("\n\tgoodsNm: ");
        builder.append(goodsNm);
        builder.append("\n\tgoodsOption: ");
        builder.append(goodsOption);
        builder.append("\n\tgoodsCnt: ");
        builder.append(goodsCnt);
        builder.append("\n\ttotPaymentPrice: ");
        builder.append(totPaymentPrice);
        builder.append("\n\tstatusCd: ");
        builder.append(statusCd);
        builder.append("\n\tcWgtCharge: ");
        builder.append(cWgtCharge);
        builder.append("\n\tcWgtReal: ");
        builder.append(cWgtReal);
        builder.append("\n\tcWgtVolume: ");
        builder.append(cWgtVolume);
        builder.append("\n\tcBoxWidth: ");
        builder.append(cBoxWidth);
        builder.append("\n\tcBoxLength: ");
        builder.append(cBoxLength);
        builder.append("\n\tcBoxHeight: ");
        builder.append(cBoxHeight);
        builder.append("\n\txWgt: ");
        builder.append(xWgt);
        builder.append("\n\txBoxWidth: ");
        builder.append(xBoxWidth);
        builder.append("\n\txBoxLength: ");
        builder.append(xBoxLength);
        builder.append("\n\txBoxHeight: ");
        builder.append(xBoxHeight);
        builder.append("\n\tupddatetime: ");
        builder.append(upddatetime);
        builder.append("\n\tcShippingPrice: ");
        builder.append(cShippingPrice);
        builder.append("\n\tcShippingPriceUnit: ");
        builder.append(cShippingPriceUnit);
        builder.append("\n\txrtShippingPrice: ");
        builder.append(xrtShippingPrice);
        builder.append("\n\txrtShippingPricedate: ");
        builder.append(xrtShippingPricedate);
        builder.append("\n\tshipCompany: ");
        builder.append(shipCompany);
        builder.append("\n\tsellerName: ");
        builder.append(sellerName);
        builder.append("\n}");
        return builder.toString();
    }

}
