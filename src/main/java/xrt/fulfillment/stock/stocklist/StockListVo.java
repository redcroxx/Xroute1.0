package xrt.fulfillment.stock.stocklist;

import java.io.Serializable;

public class StockListVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String uploadDate; // 오더등록일
    private String fileSeq; // 차수
    private String xrtInvcSno; // XROUTE송장번호
    private String invcSno; // 송장번호
    private String shipName; // 송화인
    private String shipMethodCd; // 배송방식
    private String eNation; // 도착국가
    private String status; // 입고상태
    private String stockDate; // 입고일자
    private String stockUserCd; // 입고ID
    private String invcSno1; // 배송No1
    private String invcSno2; // 배송No2
    private String ordCnt; // 총수량
    private String goodsNm; // 상품명
    private String goodsOption; // 상품옵션
    private String goodsCnt; // 상품수량
    private String totPaymentPrice; // 구매자 결제금액
    private String wgt; // 무게
    private String boxWidth; // 가로
    private String boxLength; // 세로
    private String boxHeight; // 높이
    private String paymentType; // 결제타입
    private String paymentAmount; // 결제금액
    private String statusCd; // 입고상태
    private String statusCdEn; // 입고상태영문
    private String statusCdKr; // 입고상태한글
    private String addusercd;

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

    public String getShipName() {
        return shipName;
    }

    public void setShipName(String shipName) {
        this.shipName = shipName;
    }

    public String getShipMethodCd() {
        return shipMethodCd;
    }

    public void setShipMethodCd(String shipMethodCd) {
        this.shipMethodCd = shipMethodCd;
    }

    public String geteNation() {
        return eNation;
    }

    public void seteNation(String eNation) {
        this.eNation = eNation;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStockDate() {
        return stockDate;
    }

    public void setStockDate(String stockDate) {
        this.stockDate = stockDate;
    }

    public String getStockUserCd() {
        return stockUserCd;
    }

    public void setStockUserCd(String stockUserCd) {
        this.stockUserCd = stockUserCd;
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

    public String getOrdCnt() {
        return ordCnt;
    }

    public void setOrdCnt(String ordCnt) {
        this.ordCnt = ordCnt;
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

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(String paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public String getStatusCd() {
        return statusCd;
    }

    public void setStatusCd(String statusCd) {
        this.statusCd = statusCd;
    }

    public String getStatusCdEn() {
        return statusCdEn;
    }

    public void setStatusCdEn(String statusCdEn) {
        this.statusCdEn = statusCdEn;
    }

    public String getStatusCdKr() {
        return statusCdKr;
    }

    public void setStatusCdKr(String statusCdKr) {
        this.statusCdKr = statusCdKr;
    }

    public String getAddusercd() {
        return addusercd;
    }

    public void setAddusercd(String addusercd) {
        this.addusercd = addusercd;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tuploadDate: ");
        builder.append(uploadDate);
        builder.append("\n\tfileSeq: ");
        builder.append(fileSeq);
        builder.append("\n\txrtInvcSno: ");
        builder.append(xrtInvcSno);
        builder.append("\n\tinvcSno: ");
        builder.append(invcSno);
        builder.append("\n\tshipName: ");
        builder.append(shipName);
        builder.append("\n\tshipMethodCd: ");
        builder.append(shipMethodCd);
        builder.append("\n\teNation: ");
        builder.append(eNation);
        builder.append("\n\tstatus: ");
        builder.append(status);
        builder.append("\n\tstockDate: ");
        builder.append(stockDate);
        builder.append("\n\tstockUserCd: ");
        builder.append(stockUserCd);
        builder.append("\n\tinvcSno1: ");
        builder.append(invcSno1);
        builder.append("\n\tinvcSno2: ");
        builder.append(invcSno2);
        builder.append("\n\tordCnt: ");
        builder.append(ordCnt);
        builder.append("\n\tgoodsNm: ");
        builder.append(goodsNm);
        builder.append("\n\tgoodsOption: ");
        builder.append(goodsOption);
        builder.append("\n\tgoodsCnt: ");
        builder.append(goodsCnt);
        builder.append("\n\ttotPaymentPrice: ");
        builder.append(totPaymentPrice);
        builder.append("\n\twgt: ");
        builder.append(wgt);
        builder.append("\n\tboxWidth: ");
        builder.append(boxWidth);
        builder.append("\n\tboxLength: ");
        builder.append(boxLength);
        builder.append("\n\tboxHeight: ");
        builder.append(boxHeight);
        builder.append("\n\tpaymentType: ");
        builder.append(paymentType);
        builder.append("\n\tpaymentAmount: ");
        builder.append(paymentAmount);
        builder.append("\n\tstatusCd: ");
        builder.append(statusCd);
        builder.append("\n\tstatusCdEn: ");
        builder.append(statusCdEn);
        builder.append("\n\tstatusCdKr: ");
        builder.append(statusCdKr);
        builder.append("\n\taddusercd: ");
        builder.append(addusercd);
        builder.append("\n}");
        return builder.toString();
    }

}
