package xrt.interfaces.qxpress.vo;

import java.io.Serializable;

public class QxpressVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String xrtInvcSno; // 엑스루트 송장번호
    private String rcvnm; // 구매자 명
    private String rcvnmHuri; // 빈값(기본값)
    private String hpNo; // 구매자 연락처
    private String telNo; // 구매자 연락처
    private String zipCode; // 구매자 우편번호
    private String delFrontaddress; // 구매자 기본주소
    private String delBackaddress; // 구매자 상세주소
    private String buyCustemail; // 구매자 이메일
    private String deliveryNationcd; // 도착국가 코드 (SG, KR, JP)
    private String deliveryOptionCode; // 빈값(기본값)
    private String sellCustnm; // 판매자명(옵션) 없으면 가입한 정보로 대체함
    private String remark; // 비고
    private String rcvid;
    private String rcvidPath;
    private String dpc3refno1; // 참조 주문번호(사용하는 곳의 주문번호 값)
    private String startNationcd; // 출발국가 코드(SG, KR, JP)
    private String ogSellnm;
    private String ogHpNo;
    private String ogTelNo;
    private String ogZipCode;
    private String ogDepFrontaddress;
    private String ogDepBackaddress;
    private String ogDepSelMail;
    private String expNmKr;
    private String expNmEn;
    private String expNmBiz;
    private String expNoBiz;
    private String expCl;
    private String expBizPost;
    private String expBizAdd1;
    private String expBizAdd2;
    private String expBizAdd1En;
    private String expBizAdd2En;
    private String itemNm; // 주문 아이템명
    private String qty; // 수량
    private String purchasAmt; // 구매금액
    private String currency; // 구매금액 통화
    private String hscd;
    private String bd;
    private String mf;
    private String me;
    private String md;
    private String pg;
    private String urlP;
    private String urlE;
    private String taxCg;
    private String ins;
    private String dpa;

    public String getXrtInvcSno() {
        return xrtInvcSno;
    }

    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }

    public String getRcvnm() {
        return rcvnm;
    }

    public void setRcvnm(String revnm) {
        this.rcvnm = revnm;
    }

    public String getRcvnmHuri() {
        return rcvnmHuri;
    }

    public void setRcvnmHuri(String rcvnmHuri) {
        this.rcvnmHuri = rcvnmHuri;
    }

    public String getHpNo() {
        return hpNo;
    }

    public void setHpNo(String hpNo) {
        this.hpNo = hpNo;
    }

    public String getTelNo() {
        return telNo;
    }

    public void setTelNo(String telNo) {
        this.telNo = telNo;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getDelFrontaddress() {
        return delFrontaddress;
    }

    public void setDelFrontaddress(String delFrontaddress) {
        this.delFrontaddress = delFrontaddress;
    }

    public String getDelBackaddress() {
        return delBackaddress;
    }

    public void setDelBackaddress(String delBackaddress) {
        this.delBackaddress = delBackaddress;
    }

    public String getBuyCustemail() {
        return buyCustemail;
    }

    public void setBuyCustemail(String buyCustemail) {
        this.buyCustemail = buyCustemail;
    }

    public String getDeliveryNationcd() {
        return deliveryNationcd;
    }

    public void setDeliveryNationcd(String deliveryNationcd) {
        this.deliveryNationcd = deliveryNationcd;
    }

    public String getDeliveryOptionCode() {
        return deliveryOptionCode;
    }

    public void setDeliveryOptionCode(String deliveryOptionCode) {
        this.deliveryOptionCode = deliveryOptionCode;
    }

    public String getSellCustnm() {
        return sellCustnm;
    }

    public void setSellCustnm(String sellCustnm) {
        this.sellCustnm = sellCustnm;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getRcvid() {
        return rcvid;
    }

    public void setRcvid(String rcvid) {
        this.rcvid = rcvid;
    }

    public String getRcvidPath() {
        return rcvidPath;
    }

    public void setRcvidPath(String rcvidPath) {
        this.rcvidPath = rcvidPath;
    }

    public String getDpc3refno1() {
        return dpc3refno1;
    }

    public void setDpc3refno1(String dpc3refno1) {
        this.dpc3refno1 = dpc3refno1;
    }

    public String getStartNationcd() {
        return startNationcd;
    }

    public void setStartNationcd(String startNationcd) {
        this.startNationcd = startNationcd;
    }

    public String getOgSellnm() {
        return ogSellnm;
    }

    public void setOgSellnm(String ogSellnm) {
        this.ogSellnm = ogSellnm;
    }

    public String getOgHpNo() {
        return ogHpNo;
    }

    public void setOgHpNo(String ogHpNo) {
        this.ogHpNo = ogHpNo;
    }

    public String getOgTelNo() {
        return ogTelNo;
    }

    public void setOgTelNo(String ogTelNo) {
        this.ogTelNo = ogTelNo;
    }

    public String getOgZipCode() {
        return ogZipCode;
    }

    public void setOgZipCode(String ogZipCode) {
        this.ogZipCode = ogZipCode;
    }

    public String getOgDepFrontaddress() {
        return ogDepFrontaddress;
    }

    public void setOgDepFrontaddress(String ogDepFrontaddress) {
        this.ogDepFrontaddress = ogDepFrontaddress;
    }

    public String getOgDepBackaddress() {
        return ogDepBackaddress;
    }

    public void setOgDepBackaddress(String ogDepBackaddress) {
        this.ogDepBackaddress = ogDepBackaddress;
    }

    public String getOgDepSelMail() {
        return ogDepSelMail;
    }

    public void setOgDepSelMail(String ogDepSelMail) {
        this.ogDepSelMail = ogDepSelMail;
    }

    public String getExpNmKr() {
        return expNmKr;
    }

    public void setExpNmKr(String expNmKr) {
        this.expNmKr = expNmKr;
    }

    public String getExpNmEn() {
        return expNmEn;
    }

    public void setExpNmEn(String expNmEn) {
        this.expNmEn = expNmEn;
    }

    public String getExpNmBiz() {
        return expNmBiz;
    }

    public void setExpNmBiz(String expNmBiz) {
        this.expNmBiz = expNmBiz;
    }

    public String getExpNoBiz() {
        return expNoBiz;
    }

    public void setExpNoBiz(String expNoBiz) {
        this.expNoBiz = expNoBiz;
    }

    public String getExpCl() {
        return expCl;
    }

    public void setExpCl(String expCl) {
        this.expCl = expCl;
    }

    public String getExpBizPost() {
        return expBizPost;
    }

    public void setExpBizPost(String expBizPost) {
        this.expBizPost = expBizPost;
    }

    public String getExpBizAdd1() {
        return expBizAdd1;
    }

    public void setExpBizAdd1(String expBizAdd1) {
        this.expBizAdd1 = expBizAdd1;
    }

    public String getExpBizAdd2() {
        return expBizAdd2;
    }

    public void setExpBizAdd2(String expBizAdd2) {
        this.expBizAdd2 = expBizAdd2;
    }

    public String getExpBizAdd1En() {
        return expBizAdd1En;
    }

    public void setExpBizAdd1En(String expBizAdd1En) {
        this.expBizAdd1En = expBizAdd1En;
    }

    public String getExpBizAdd2En() {
        return expBizAdd2En;
    }

    public void setExpBizAdd2En(String expBizAdd2En) {
        this.expBizAdd2En = expBizAdd2En;
    }

    public String getItemNm() {
        return itemNm;
    }

    public void setItemNm(String itemNm) {
        this.itemNm = itemNm;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    public String getPurchasAmt() {
        return purchasAmt;
    }

    public void setPurchasAmt(String purchasAmt) {
        this.purchasAmt = purchasAmt;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getHscd() {
        return hscd;
    }

    public void setHscd(String hscd) {
        this.hscd = hscd;
    }

    public String getBd() {
        return bd;
    }

    public void setBd(String bd) {
        this.bd = bd;
    }

    public String getMf() {
        return mf;
    }

    public void setMf(String mf) {
        this.mf = mf;
    }

    public String getMe() {
        return me;
    }

    public void setMe(String me) {
        this.me = me;
    }

    public String getMd() {
        return md;
    }

    public void setMd(String md) {
        this.md = md;
    }

    public String getPg() {
        return pg;
    }

    public void setPg(String pg) {
        this.pg = pg;
    }

    public String getUrlP() {
        return urlP;
    }

    public void setUrlP(String urlP) {
        this.urlP = urlP;
    }

    public String getUrlE() {
        return urlE;
    }

    public void setUrlE(String urlE) {
        this.urlE = urlE;
    }

    public String getTaxCg() {
        return taxCg;
    }

    public void setTaxCg(String taxCg) {
        this.taxCg = taxCg;
    }

    public String getIns() {
        return ins;
    }

    public void setIns(String ins) {
        this.ins = ins;
    }

    public String getDpa() {
        return dpa;
    }

    public void setDpa(String dpa) {
        this.dpa = dpa;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\txrtInvcSno: ");
        builder.append(xrtInvcSno);
        builder.append("\n\trcvnm: ");
        builder.append(rcvnm);
        builder.append("\n\trcvnmHuri: ");
        builder.append(rcvnmHuri);
        builder.append("\n\thpNo: ");
        builder.append(hpNo);
        builder.append("\n\ttelNo: ");
        builder.append(telNo);
        builder.append("\n\tzipCode: ");
        builder.append(zipCode);
        builder.append("\n\tdelFrontaddress: ");
        builder.append(delFrontaddress);
        builder.append("\n\tdelBackaddress: ");
        builder.append(delBackaddress);
        builder.append("\n\tbuyCustemail: ");
        builder.append(buyCustemail);
        builder.append("\n\tdeliveryNationcd: ");
        builder.append(deliveryNationcd);
        builder.append("\n\tdeliveryOptionCode: ");
        builder.append(deliveryOptionCode);
        builder.append("\n\tsellCustnm: ");
        builder.append(sellCustnm);
        builder.append("\n\tremark: ");
        builder.append(remark);
        builder.append("\n\trcvid: ");
        builder.append(rcvid);
        builder.append("\n\trcvidPath: ");
        builder.append(rcvidPath);
        builder.append("\n\tdpc3refno1: ");
        builder.append(dpc3refno1);
        builder.append("\n\tstartNationcd: ");
        builder.append(startNationcd);
        builder.append("\n\togSellnm: ");
        builder.append(ogSellnm);
        builder.append("\n\togHpNo: ");
        builder.append(ogHpNo);
        builder.append("\n\togTelNo: ");
        builder.append(ogTelNo);
        builder.append("\n\togZipCode: ");
        builder.append(ogZipCode);
        builder.append("\n\togDepFrontaddress: ");
        builder.append(ogDepFrontaddress);
        builder.append("\n\togDepBackaddress: ");
        builder.append(ogDepBackaddress);
        builder.append("\n\togDepSelMail: ");
        builder.append(ogDepSelMail);
        builder.append("\n\texpNmKr: ");
        builder.append(expNmKr);
        builder.append("\n\texpNmEn: ");
        builder.append(expNmEn);
        builder.append("\n\texpNmBiz: ");
        builder.append(expNmBiz);
        builder.append("\n\texpNoBiz: ");
        builder.append(expNoBiz);
        builder.append("\n\texpCl: ");
        builder.append(expCl);
        builder.append("\n\texpBizPost: ");
        builder.append(expBizPost);
        builder.append("\n\texpBizAdd1: ");
        builder.append(expBizAdd1);
        builder.append("\n\texpBizAdd2: ");
        builder.append(expBizAdd2);
        builder.append("\n\texpBizAdd1En: ");
        builder.append(expBizAdd1En);
        builder.append("\n\texpBizAdd2En: ");
        builder.append(expBizAdd2En);
        builder.append("\n\titemNm: ");
        builder.append(itemNm);
        builder.append("\n\tqty: ");
        builder.append(qty);
        builder.append("\n\tpurchasAmt: ");
        builder.append(purchasAmt);
        builder.append("\n\tcurrency: ");
        builder.append(currency);
        builder.append("\n\thscd: ");
        builder.append(hscd);
        builder.append("\n\tbd: ");
        builder.append(bd);
        builder.append("\n\tmf: ");
        builder.append(mf);
        builder.append("\n\tme: ");
        builder.append(me);
        builder.append("\n\tmd: ");
        builder.append(md);
        builder.append("\n\tpg: ");
        builder.append(pg);
        builder.append("\n\turlP: ");
        builder.append(urlP);
        builder.append("\n\turlE: ");
        builder.append(urlE);
        builder.append("\n\ttaxCg: ");
        builder.append(taxCg);
        builder.append("\n\tins: ");
        builder.append(ins);
        builder.append("\n\tdpa: ");
        builder.append(dpa);
        builder.append("\n}");
        return builder.toString();
    }

}
