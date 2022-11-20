package xrt.alexcloud.api.settlebank.vo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class SettleBankResNotiVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String PStateCd; // 거래상태 : 0021(성공), 0031(실패), 0051(입금대기중)
    private String POrderId; //
    private String PTrno; // 거래번호
    private String PAuthDt; // 승인시간
    private String PAuthNo; // 승인번호
    private String PType; // 거래종류 (CARD, BANK)
    private String PMid; // 회원사아이디
    private String POid; // 주문번호
    private String PFnCd1; // 금융사코드 (은행코드, 카드코드)
    private String PFnCd2; // 금융사코드 (은행코드, 카드코드)
    private String PFnNm; // 금융사명 (은행명, 카드사명)
    private String PUname; // 주문자명
    private String PAmt; // 거래금액
    private String PNoti; // 주문정보
    private String PRmesg1; // 메시지1
    private String PRmesg2; // 메시지2
    private String PHash; // NOTI HASH 코드값
    private String PData; //
    private String statusCd; // TOrder 상태코드

    public String getPStateCd() {
        return PStateCd;
    }

    public void setPStateCd(String pStateCd) {
        PStateCd = pStateCd;
    }

    public String getPOrderId() {
        return POrderId;
    }

    public void setPOrderId(String pOrderId) {
        POrderId = pOrderId;
    }

    public String getPTrno() {
        return PTrno;
    }

    public void setPTrno(String pTrno) {
        PTrno = pTrno;
    }

    public String getPAuthDt() {
        return PAuthDt;
    }

    public void setPAuthDt(String pAuthDt) {
        PAuthDt = pAuthDt;
    }

    public String getPAuthNo() {
        return PAuthNo;
    }

    public void setPAuthNo(String pAuthNo) {
        PAuthNo = pAuthNo;
    }

    public String getPType() {
        return PType;
    }

    public void setPType(String pType) {
        PType = pType;
    }

    public String getPMid() {
        return PMid;
    }

    public void setPMid(String pMid) {
        PMid = pMid;
    }

    public String getPOid() {
        return POid;
    }

    public void setPOid(String pOid) {
        POid = pOid;
    }

    public String getPFnCd1() {
        return PFnCd1;
    }

    public void setPFnCd1(String pFnCd1) {
        PFnCd1 = pFnCd1;
    }

    public String getPFnCd2() {
        return PFnCd2;
    }

    public void setPFnCd2(String pFnCd2) {
        PFnCd2 = pFnCd2;
    }

    public String getPFnNm() {
        return PFnNm;
    }

    public void setPFnNm(String pFnNm) {
        PFnNm = pFnNm;
    }

    public String getPUname() {
        return PUname;
    }

    public void setPUname(String pUname) {
        PUname = pUname;
    }

    public String getPAmt() {
        return PAmt;
    }

    public void setPAmt(String pAmt) {
        PAmt = pAmt;
    }

    public String getPNoti() {
        return PNoti;
    }

    public void setPNoti(String pNoti) {
        PNoti = pNoti;
    }

    public String getPRmesg1() {
        return PRmesg1;
    }

    public void setPRmesg1(String pRmesg1) {
        PRmesg1 = pRmesg1;
    }

    public String getPRmesg2() {
        return PRmesg2;
    }

    public void setPRmesg2(String pRmesg2) {
        PRmesg2 = pRmesg2;
    }

    public String getPHash() {
        return PHash;
    }

    public void setPHash(String pHash) {
        PHash = pHash;
    }

    public String getPData() {
        return PData;
    }

    public void setPData(String pData) {
        PData = pData;
    }

    public String getStatusCd() {
        return statusCd;
    }

    public void setStatusCd(String statusCd) {
        this.statusCd = statusCd;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tPStateCd: ");
        builder.append(PStateCd);
        builder.append("\n\tPOrderId: ");
        builder.append(POrderId);
        builder.append("\n\tPTrno: ");
        builder.append(PTrno);
        builder.append("\n\tPAuthDt: ");
        builder.append(PAuthDt);
        builder.append("\n\tPAuthNo: ");
        builder.append(PAuthNo);
        builder.append("\n\tPType: ");
        builder.append(PType);
        builder.append("\n\tPMid: ");
        builder.append(PMid);
        builder.append("\n\tPOid: ");
        builder.append(POid);
        builder.append("\n\tPFnCd1: ");
        builder.append(PFnCd1);
        builder.append("\n\tPFnCd2: ");
        builder.append(PFnCd2);
        builder.append("\n\tPFnNm: ");
        builder.append(PFnNm);
        builder.append("\n\tPUname: ");
        builder.append(PUname);
        builder.append("\n\tPAmt: ");
        builder.append(PAmt);
        builder.append("\n\tPNoti: ");
        builder.append(PNoti);
        builder.append("\n\tPRmesg1: ");
        builder.append(PRmesg1);
        builder.append("\n\tPRmesg2: ");
        builder.append(PRmesg2);
        builder.append("\n\tPHash: ");
        builder.append(PHash);
        builder.append("\n\tPData: ");
        builder.append(PData);
        builder.append("\n\tstatusCd: ");
        builder.append(statusCd);
        builder.append("\n}");
        return builder.toString();
    }

}
