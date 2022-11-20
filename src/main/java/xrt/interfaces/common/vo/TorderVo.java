package xrt.interfaces.common.vo;

import java.io.Serializable;

public class TorderVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String amount; // 라벨그액
    private String recvName; // 수취인 이름
    private String recvTel; // 수취인 전화 번호
    private String recvMobile; // 수취인 휴대전화 번호
    private String recvAddr1; // 수취인 주소
    private String recvCity; // 수취인 도시
    private String recvState; // 수취인 전환번호
    private String recvPost; // 수취인 우편번호
    private String sNation; // 시작국가
    private String eNation; // 도착국가
    private String invcSno1; // 기타 송장번호1
    private String invcSno2; // 기타 송장번호2
    private String invcSno3; // 기타 송장번호3
    private String shippoId; // ShippoObject Id
    private String boxLength; // 화물의 길이
    private String boxWidth; // 화물의 넓이
    private String boxHeight; // 화물의 높이
    private String wgt; // 화물의 무게
    private String xrtInvcSno; // xroute 송장번호
    private String localShipper; // 해당지역 배송사
    private String ordCd; //
    private String ordNo; //
    private String slug1; //
    private String slug2; //
    private String goodsNm;
    private String price;

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
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

    public String getInvcSno3() {
        return invcSno3;
    }

    public void setInvcSno3(String invcSno3) {
        this.invcSno3 = invcSno3;
    }

    public String getShippoId() {
        return shippoId;
    }

    public void setShippoId(String shippoId) {
        this.shippoId = shippoId;
    }

    public String getBoxLength() {
        return boxLength;
    }

    public void setBoxLength(String boxLength) {
        this.boxLength = boxLength;
    }

    public String getBoxWidth() {
        return boxWidth;
    }

    public void setBoxWidth(String boxWidth) {
        this.boxWidth = boxWidth;
    }

    public String getBoxHeight() {
        return boxHeight;
    }

    public void setBoxHeight(String boxHeight) {
        this.boxHeight = boxHeight;
    }

    public String getWgt() {
        return wgt;
    }

    public void setWgt(String wgt) {
        this.wgt = wgt;
    }

    public String getXrtInvcSno() {
        return xrtInvcSno;
    }

    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }

    public String getLocalShipper() {
        return localShipper;
    }

    public void setLocalShipper(String localShipper) {
        this.localShipper = localShipper;
    }

    public String getOrdCd() {
        return ordCd;
    }

    public void setOrdCd(String ordCd) {
        this.ordCd = ordCd;
    }

    public String getOrdNo() {
        return ordNo;
    }

    public void setOrdNo(String ordNo) {
        this.ordNo = ordNo;
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

    public String getGoodsNm() {
        return goodsNm;
    }

    public void setGoodsNm(String goodsNm) {
        this.goodsNm = goodsNm;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tamount: ");
        builder.append(amount);
        builder.append("\n\trecvName: ");
        builder.append(recvName);
        builder.append("\n\trecvTel: ");
        builder.append(recvTel);
        builder.append("\n\trecvMobile: ");
        builder.append(recvMobile);
        builder.append("\n\trecvAddr1: ");
        builder.append(recvAddr1);
        builder.append("\n\trecvCity: ");
        builder.append(recvCity);
        builder.append("\n\trecvState: ");
        builder.append(recvState);
        builder.append("\n\trecvPost: ");
        builder.append(recvPost);
        builder.append("\n\tsNation: ");
        builder.append(sNation);
        builder.append("\n\teNation: ");
        builder.append(eNation);
        builder.append("\n\tinvcSno1: ");
        builder.append(invcSno1);
        builder.append("\n\tinvcSno2: ");
        builder.append(invcSno2);
        builder.append("\n\tinvcSno3: ");
        builder.append(invcSno3);
        builder.append("\n\tshippoId: ");
        builder.append(shippoId);
        builder.append("\n\tboxLength: ");
        builder.append(boxLength);
        builder.append("\n\tboxWidth: ");
        builder.append(boxWidth);
        builder.append("\n\tboxHeight: ");
        builder.append(boxHeight);
        builder.append("\n\twgt: ");
        builder.append(wgt);
        builder.append("\n\txrtInvcSno: ");
        builder.append(xrtInvcSno);
        builder.append("\n\tlocalShipper: ");
        builder.append(localShipper);
        builder.append("\n\tordCd: ");
        builder.append(ordCd);
        builder.append("\n\tordNo: ");
        builder.append(ordNo);
        builder.append("\n\tslug1: ");
        builder.append(slug1);
        builder.append("\n\tslug2: ");
        builder.append(slug2);
        builder.append("\n\tgoodsNm: ");
        builder.append(goodsNm);
        builder.append("\n\tprice: ");
        builder.append(price);
        builder.append("\n}");
        return builder.toString();
    }

}
