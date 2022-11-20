package xrt.fulfillment.order.orderinsert;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class CartNoVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String sCompCd; // 회사코드
    private String sOrgCd; // 화주(셀러) 코드
    private String sCartNo; // 장바구니넘버

    public String getsCompCd() {
        return sCompCd;
    }

    public void setsCompCd(String sCompCd) {
        this.sCompCd = sCompCd;
    }

    public String getsOrgCd() {
        return sOrgCd;
    }

    public void setsOrgCd(String sOrgCd) {
        this.sOrgCd = sOrgCd;
    }

    public String getsCartNo() {
        return sCartNo;
    }

    public void setsCartNo(String sCartNo) {
        this.sCartNo = sCartNo;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tsCompCd: ");
        builder.append(sCompCd);
        builder.append("\n\tsOrgCd: ");
        builder.append(sOrgCd);
        builder.append("\n\tsCartNo: ");
        builder.append(sCartNo);
        builder.append("\n}");
        return builder.toString();
    }
}
