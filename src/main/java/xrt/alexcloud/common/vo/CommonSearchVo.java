package xrt.alexcloud.common.vo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class CommonSearchVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String sCompCd; // 회사코드
    private String sPeriodType; // 기간 구분 선택
    private String sToDate; // 시작 일자
    private String sFromDate; // 종료 일자
    private String sToNation; // 시작 국가
    private String sFromNation; // 종료 국가
    private String sKeywordType; // 검색단어 구분 선택
    private String sKeyword; // 검색어
    private String sOrgCd; // 화주(셀러) 코드
    private String sOrgNm; // 화주(셀러) 이름
    private String sOrdNo; // 주문번호.
    private String sWhcd; // 창고 코드
    private int sFileSeq; // 업로드 차수
    private String xrtInvcSno;
    private String invcSno1;
    private String invcSno2;
    private String invcSno3;
    private String sShipCompany; // 배송업체명
    private String sCount;
    private String sCountry;
    private String sUserCd;
    private String sCompNm;
    private String sInvcStart;
    private String sInvcEnd;
    private String sXrtInvcSno; // 송방번호
    private String sPaymentType; // 결제 타입
    private String sStatusCd; // 상태 코드
    private String sEtcCd1;
    private String sEtcCd2;
    private String sKrProductName; // 상품명
    private String sKrProductCode; // 상품코드
    private String sCountryCode; // 국가코드
    private String sZone; // 존
    
    public String getsCompCd() {
        return sCompCd;
    }
    public void setsCompCd(String sCompCd) {
        this.sCompCd = sCompCd;
    }
    public String getsPeriodType() {
        return sPeriodType;
    }
    public void setsPeriodType(String sPeriodType) {
        this.sPeriodType = sPeriodType;
    }
    public String getsToDate() {
        return sToDate;
    }
    public void setsToDate(String sToDate) {
        this.sToDate = sToDate;
    }
    public String getsFromDate() {
        return sFromDate;
    }
    public void setsFromDate(String sFromDate) {
        this.sFromDate = sFromDate;
    }
    public String getsToNation() {
        return sToNation;
    }
    public void setsToNation(String sToNation) {
        this.sToNation = sToNation;
    }
    public String getsFromNation() {
        return sFromNation;
    }
    public void setsFromNation(String sFromNation) {
        this.sFromNation = sFromNation;
    }
    public String getsKeywordType() {
        return sKeywordType;
    }
    public void setsKeywordType(String sKeywordType) {
        this.sKeywordType = sKeywordType;
    }
    public String getsKeyword() {
        return sKeyword;
    }
    public void setsKeyword(String sKeyword) {
        this.sKeyword = sKeyword;
    }
    public String getsOrgCd() {
        return sOrgCd;
    }
    public void setsOrgCd(String sOrgCd) {
        this.sOrgCd = sOrgCd;
    }
    public String getsOrgNm() {
        return sOrgNm;
    }
    public void setsOrgNm(String sOrgNm) {
        this.sOrgNm = sOrgNm;
    }
    public String getsOrdNo() {
        return sOrdNo;
    }
    public void setsOrdNo(String sOrdNo) {
        this.sOrdNo = sOrdNo;
    }
    public String getsWhcd() {
        return sWhcd;
    }
    public void setsWhcd(String sWhcd) {
        this.sWhcd = sWhcd;
    }
    public int getsFileSeq() {
        return sFileSeq;
    }
    public void setsFileSeq(int sFileSeq) {
        this.sFileSeq = sFileSeq;
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
    public String getInvcSno3() {
        return invcSno3;
    }
    public void setInvcSno3(String invcSno3) {
        this.invcSno3 = invcSno3;
    }
    public String getsShipCompany() {
        return sShipCompany;
    }
    public void setsShipCompany(String sShipCompany) {
        this.sShipCompany = sShipCompany;
    }
    public String getsCount() {
        return sCount;
    }
    public void setsCount(String sCount) {
        this.sCount = sCount;
    }
    public String getsCountry() {
        return sCountry;
    }
    public void setsCountry(String sCountry) {
        this.sCountry = sCountry;
    }
    public String getsUserCd() {
        return sUserCd;
    }
    public void setsUserCd(String sUserCd) {
        this.sUserCd = sUserCd;
    }
    public String getsCompNm() {
        return sCompNm;
    }
    public void setsCompNm(String sCompNm) {
        this.sCompNm = sCompNm;
    }
    public String getsInvcStart() {
        return sInvcStart;
    }
    public void setsInvcStart(String sInvcStart) {
        this.sInvcStart = sInvcStart;
    }
    public String getsInvcEnd() {
        return sInvcEnd;
    }
    public void setsInvcEnd(String sInvcEnd) {
        this.sInvcEnd = sInvcEnd;
    }
    public String getsXrtInvcSno() {
        return sXrtInvcSno;
    }
    public void setsXrtInvcSno(String sXrtInvcSno) {
        this.sXrtInvcSno = sXrtInvcSno;
    }
    public String getsPaymentType() {
        return sPaymentType;
    }
    public void setsPaymentType(String sPaymentType) {
        this.sPaymentType = sPaymentType;
    }
    public String getsStatusCd() {
        return sStatusCd;
    }
    public void setsStatusCd(String sStatusCd) {
        this.sStatusCd = sStatusCd;
    }
    public String getsEtcCd1() {
        return sEtcCd1;
    }
    public void setsEtcCd1(String sEtcCd1) {
        this.sEtcCd1 = sEtcCd1;
    }
    public String getsEtcCd2() {
        return sEtcCd2;
    }
    public void setsEtcCd2(String sEtcCd2) {
        this.sEtcCd2 = sEtcCd2;
    }
    public String getsKrProductName() {
        return sKrProductName;
    }
    public void setsKrProductName(String sKrProductName) {
        this.sKrProductName = sKrProductName;
    }
    public String getsKrProductCode() {
        return sKrProductCode;
    }
    public void setsKrProductCode(String sKrProductCode) {
        this.sKrProductCode = sKrProductCode;
    }
    public String getsCountryCode() {
        return sCountryCode;
    }
    public void setsCountryCode(String sCountryCode) {
        this.sCountryCode = sCountryCode;
    }
    public String getsZone() {
        return sZone;
    }
    public void setsZone(String sZone) {
        this.sZone = sZone;
    }
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("CommonSearchVo {\n    sCompCd : ");
        builder.append(sCompCd);
        builder.append(",\n    sPeriodType : ");
        builder.append(sPeriodType);
        builder.append(",\n    sToDate : ");
        builder.append(sToDate);
        builder.append(",\n    sFromDate : ");
        builder.append(sFromDate);
        builder.append(",\n    sToNation : ");
        builder.append(sToNation);
        builder.append(",\n    sFromNation : ");
        builder.append(sFromNation);
        builder.append(",\n    sKeywordType : ");
        builder.append(sKeywordType);
        builder.append(",\n    sKeyword : ");
        builder.append(sKeyword);
        builder.append(",\n    sOrgCd : ");
        builder.append(sOrgCd);
        builder.append(",\n    sOrgNm : ");
        builder.append(sOrgNm);
        builder.append(",\n    sOrdNo : ");
        builder.append(sOrdNo);
        builder.append(",\n    sWhcd : ");
        builder.append(sWhcd);
        builder.append(",\n    sFileSeq : ");
        builder.append(sFileSeq);
        builder.append(",\n    xrtInvcSno : ");
        builder.append(xrtInvcSno);
        builder.append(",\n    invcSno1 : ");
        builder.append(invcSno1);
        builder.append(",\n    invcSno2 : ");
        builder.append(invcSno2);
        builder.append(",\n    invcSno3 : ");
        builder.append(invcSno3);
        builder.append(",\n    sShipCompany : ");
        builder.append(sShipCompany);
        builder.append(",\n    sCount : ");
        builder.append(sCount);
        builder.append(",\n    sCountry : ");
        builder.append(sCountry);
        builder.append(",\n    sUserCd : ");
        builder.append(sUserCd);
        builder.append(",\n    sCompNm : ");
        builder.append(sCompNm);
        builder.append(",\n    sInvcStart : ");
        builder.append(sInvcStart);
        builder.append(",\n    sInvcEnd : ");
        builder.append(sInvcEnd);
        builder.append(",\n    sXrtInvcSno : ");
        builder.append(sXrtInvcSno);
        builder.append(",\n    sPaymentType : ");
        builder.append(sPaymentType);
        builder.append(",\n    sStatusCd : ");
        builder.append(sStatusCd);
        builder.append(",\n    sEtcCd1 : ");
        builder.append(sEtcCd1);
        builder.append(",\n    sEtcCd2 : ");
        builder.append(sEtcCd2);
        builder.append(",\n    sKrProductName : ");
        builder.append(sKrProductName);
        builder.append(",\n    sKrProductCode : ");
        builder.append(sKrProductCode);
        builder.append(",\n    sCountryCode : ");
        builder.append(sCountryCode);
        builder.append(",\n    sZone : ");
        builder.append(sZone);
        builder.append("\n}");
        return builder.toString();
    }
}
