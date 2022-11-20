package xrt.fulfillment.order.shippinglist;

import java.io.Serializable;

public class ShippingListVO implements Serializable {

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
    private String recvName; // 수화인명
    private String recvTel; // 수화인 전화번호
    private String recvMobile; // 수화인 핸드폰번호
    private String recvAddr1; // 수화인 주소1
    private String recvAddr2; // 수화인 주소2
    private String recvPost; // 수화인 우편번호
    private String recvCurrency; // 통화
    private String ordCd; // 상세주문번호
    private String ordCnt; // 주문수량
    private String ordNo; // 주문번호
    private String cartNo; // 장바구니 번호
    private String goodsCd; // 상품번호
    private String goodsNm; // 상품명
    private String goodsOption; // 상품옵션
    private String goodsCnt; // 상품수량
    private String paymentPrice; // 상품 금액
    private String totPaymentPrice; // 구매자 결제금액
    private String statusCd; // 배송상태
    private String statusCdKr; // 배송상태 한글
    private String statusCdEn; // 배송상태 영어
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
    private String adddatetime; // 등록 날짜/시간
    private String upddatetime; // 수정 날짜/시간
    private String shipName; // 송화인명
    private String shipTel; // 송화인명
    private String shipAddr; // 송화인명
    private String recvCity; // 도시
    private String recvState; // 주(State)
    private String cShippingPrice;
    private String xrtShippingPrice;
    private String paymentType; // 결제타입구분
    private String purchaseUrl;
    private String stockDate;
    private String shipmentBlNo;
    private String houseBlNo;
    private String scacCode;
    private String masterBlNo;
    private String airwayBill;
    private String shippoId;
    private String pickingPage;
    private String pickingSeq;
    private String unipass_tkofdt;
    
    public String getUnipass_tkofdt() {
		return unipass_tkofdt;
	}
	public void setUnipass_tkofdt(String unipass_tkofdt) {
		this.unipass_tkofdt = unipass_tkofdt;
	}
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
    public String getOrdCd() {
        return ordCd;
    }
    public void setOrdCd(String ordCd) {
        this.ordCd = ordCd;
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
    public String getPaymentPrice() {
        return paymentPrice;
    }
    public void setPaymentPrice(String paymentPrice) {
        this.paymentPrice = paymentPrice;
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
    public String getStatusCdKr() {
        return statusCdKr;
    }
    public void setStatusCdKr(String statusCdKr) {
        this.statusCdKr = statusCdKr;
    }
    public String getStatusCdEn() {
        return statusCdEn;
    }
    public void setStatusCdEn(String statusCdEn) {
        this.statusCdEn = statusCdEn;
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
    public String getAdddatetime() {
        return adddatetime;
    }
    public void setAdddatetime(String adddatetime) {
        this.adddatetime = adddatetime;
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
    public String getShipTel() {
        return shipTel;
    }
    public void setShipTel(String shipTel) {
        this.shipTel = shipTel;
    }
    public String getShipAddr() {
        return shipAddr;
    }
    public void setShipAddr(String shipAddr) {
        this.shipAddr = shipAddr;
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
    public String getXrtShippingPrice() {
        return xrtShippingPrice;
    }
    public void setXrtShippingPrice(String xrtShippingPrice) {
        this.xrtShippingPrice = xrtShippingPrice;
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
    public String getStockDate() {
        return stockDate;
    }
    public void setStockDate(String stockDate) {
        this.stockDate = stockDate;
    }
    public String getShipmentBlNo() {
        return shipmentBlNo;
    }
    public void setShipmentBlNo(String shipmentBlNo) {
        this.shipmentBlNo = shipmentBlNo;
    }
    public String getHouseBlNo() {
        return houseBlNo;
    }
    public void setHouseBlNo(String houseBlNo) {
        this.houseBlNo = houseBlNo;
    }
    public String getScacCode() {
        return scacCode;
    }
    public void setScacCode(String scacCode) {
        this.scacCode = scacCode;
    }
    public String getMasterBlNo() {
        return masterBlNo;
    }
    public void setMasterBlNo(String masterBlNo) {
        this.masterBlNo = masterBlNo;
    }
    public String getAirwayBill() {
        return airwayBill;
    }
    public void setAirwayBill(String airwayBill) {
        this.airwayBill = airwayBill;
    }
    public String getShippoId() {
        return shippoId;
    }
    public void setShippoId(String shippoId) {
        this.shippoId = shippoId;
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
	@Override
	public String toString() {
		return "ShippingListVO [orgcd=" + orgcd + ", mallNm=" + mallNm + ", xrtInvcSno=" + xrtInvcSno + ", invcSno1="
				+ invcSno1 + ", invcSno2=" + invcSno2 + ", uploadDate=" + uploadDate + ", shipMethodCd=" + shipMethodCd
				+ ", localShipper=" + localShipper + ", sNation=" + sNation + ", eNation=" + eNation + ", recvName="
				+ recvName + ", recvTel=" + recvTel + ", recvMobile=" + recvMobile + ", recvAddr1=" + recvAddr1
				+ ", recvAddr2=" + recvAddr2 + ", recvPost=" + recvPost + ", recvCurrency=" + recvCurrency + ", ordCd="
				+ ordCd + ", ordCnt=" + ordCnt + ", ordNo=" + ordNo + ", cartNo=" + cartNo + ", goodsCd=" + goodsCd
				+ ", goodsNm=" + goodsNm + ", goodsOption=" + goodsOption + ", goodsCnt=" + goodsCnt + ", paymentPrice="
				+ paymentPrice + ", totPaymentPrice=" + totPaymentPrice + ", statusCd=" + statusCd + ", statusCdKr="
				+ statusCdKr + ", statusCdEn=" + statusCdEn + ", cWgtCharge=" + cWgtCharge + ", cWgtReal=" + cWgtReal
				+ ", cWgtVolume=" + cWgtVolume + ", cBoxWidth=" + cBoxWidth + ", cBoxLength=" + cBoxLength
				+ ", cBoxHeight=" + cBoxHeight + ", xWgt=" + xWgt + ", xBoxWidth=" + xBoxWidth + ", xBoxLength="
				+ xBoxLength + ", xBoxHeight=" + xBoxHeight + ", adddatetime=" + adddatetime + ", upddatetime="
				+ upddatetime + ", shipName=" + shipName + ", shipTel=" + shipTel + ", shipAddr=" + shipAddr
				+ ", recvCity=" + recvCity + ", recvState=" + recvState + ", cShippingPrice=" + cShippingPrice
				+ ", xrtShippingPrice=" + xrtShippingPrice + ", paymentType=" + paymentType + ", purchaseUrl="
				+ purchaseUrl + ", stockDate=" + stockDate + ", shipmentBlNo=" + shipmentBlNo + ", houseBlNo="
				+ houseBlNo + ", scacCode=" + scacCode + ", masterBlNo=" + masterBlNo + ", airwayBill=" + airwayBill
				+ ", shippoId=" + shippoId + ", pickingPage=" + pickingPage + ", pickingSeq=" + pickingSeq
				+ ", unipass_tkofdt=" + unipass_tkofdt + "]";
	}

}