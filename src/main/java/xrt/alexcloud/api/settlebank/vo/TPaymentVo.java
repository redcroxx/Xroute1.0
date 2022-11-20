package xrt.alexcloud.api.settlebank.vo;

import java.io.Serializable;

public class TPaymentVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String poid; // 결제주문번호
    private String compcd; // 회사코드
    private String orgcd; // 셀러코드
    private String pamt; // 결제상태
    private String pmname; // 거래금액
    private String puname; // 상점한글명
    private String pename; // 주문자명
    private String pnoti; // 영문상점명
    private String pgoods; // 기타주문정보
    private String pbname; // 상품명
    private String pvtransdt; // 입금만료일
    private String vbankCreateDate; // 가상계좌신청칠자
    private String vbabnkConfirmDate; // 입금확인일자
    private String usercd; // 사용자ID
    private String addusercd; // 등록 사용자 ID
    private String adddatetime; // 등록 일시
    private String updusercd; // 수정 사용자 ID
    private String upddatetime; // 수정 일시
    private String terminalcd;

    public String getPoid() {
        return poid;
    }

    public void setPoid(String poid) {
        this.poid = poid;
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

    public String getPamt() {
        return pamt;
    }

    public void setPamt(String pamt) {
        this.pamt = pamt;
    }

    public String getPmname() {
        return pmname;
    }

    public void setPmname(String pmname) {
        this.pmname = pmname;
    }

    public String getPuname() {
        return puname;
    }

    public void setPuname(String puname) {
        this.puname = puname;
    }

    public String getPename() {
        return pename;
    }

    public void setPename(String pename) {
        this.pename = pename;
    }

    public String getPnoti() {
        return pnoti;
    }

    public void setPnoti(String pnoti) {
        this.pnoti = pnoti;
    }

    public String getPgoods() {
        return pgoods;
    }

    public void setPgoods(String pgoods) {
        this.pgoods = pgoods;
    }

    public String getPbname() {
        return pbname;
    }

    public void setPbname(String pbname) {
        this.pbname = pbname;
    }

    public String getPvtransdt() {
        return pvtransdt;
    }

    public void setPvtransdt(String pvtransdt) {
        this.pvtransdt = pvtransdt;
    }

    public String getVbankCreateDate() {
        return vbankCreateDate;
    }

    public void setVbankCreateDate(String vbankCreateDate) {
        this.vbankCreateDate = vbankCreateDate;
    }

    public String getVbabnkConfirmDate() {
        return vbabnkConfirmDate;
    }

    public void setVbabnkConfirmDate(String vbabnkConfirmDate) {
        this.vbabnkConfirmDate = vbabnkConfirmDate;
    }

    public String getUsercd() {
        return usercd;
    }

    public void setUsercd(String usercd) {
        this.usercd = usercd;
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
        builder.append(getClass().getName());
        builder.append(" {\n\tpoid: ");
        builder.append(poid);
        builder.append("\n\tcompcd: ");
        builder.append(compcd);
        builder.append("\n\torgcd: ");
        builder.append(orgcd);
        builder.append("\n\tpamt: ");
        builder.append(pamt);
        builder.append("\n\tpmname: ");
        builder.append(pmname);
        builder.append("\n\tpuname: ");
        builder.append(puname);
        builder.append("\n\tpename: ");
        builder.append(pename);
        builder.append("\n\tpnoti: ");
        builder.append(pnoti);
        builder.append("\n\tpgoods: ");
        builder.append(pgoods);
        builder.append("\n\tpbname: ");
        builder.append(pbname);
        builder.append("\n\tpvtransdt: ");
        builder.append(pvtransdt);
        builder.append("\n\tvbankCreateDate: ");
        builder.append(vbankCreateDate);
        builder.append("\n\tvbabnkConfirmDate: ");
        builder.append(vbabnkConfirmDate);
        builder.append("\n\tusercd: ");
        builder.append(usercd);
        builder.append("\n\taddusercd: ");
        builder.append(addusercd);
        builder.append("\n\tadddatetime: ");
        builder.append(adddatetime);
        builder.append("\n\tupdusercd: ");
        builder.append(updusercd);
        builder.append("\n\tupddatetime: ");
        builder.append(upddatetime);
        builder.append("\n\tterminalcd: ");
        builder.append(terminalcd);
        builder.append("\n}");
        return builder.toString();
    }

}
