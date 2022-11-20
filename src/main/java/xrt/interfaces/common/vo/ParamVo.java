package xrt.interfaces.common.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ParamVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String invcSno1; // 기타 송장번호1
    private String invcSno2; // 기타 송장번호2
    private String invcSno3; // 기타 송장번호3
    private String ordCd; // 주문코드
    private String xrtInvcSno; // xroute 송장번호
    private String codekey; // 공통코드 codekey

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

    public String getOrdCd() {
        return ordCd;
    }

    public void setOrdCd(String ordCd) {
        this.ordCd = ordCd;
    }

    public String getXrtInvcSno() {
        return xrtInvcSno;
    }

    public void setXrtInvcSno(String xrtInvcSno) {
        this.xrtInvcSno = xrtInvcSno;
    }

    public String getCodekey() {
        return codekey;
    }

    public void setCodekey(String codekey) {
        this.codekey = codekey;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tinvcSno1: ");
        builder.append(invcSno1);
        builder.append("\n\tinvcSno2: ");
        builder.append(invcSno2);
        builder.append("\n\tinvcSno3: ");
        builder.append(invcSno3);
        builder.append("\n\tordCd: ");
        builder.append(ordCd);
        builder.append("\n\txrtInvcSno: ");
        builder.append(xrtInvcSno);
        builder.append("\n\tcodekey: ");
        builder.append(codekey);
        builder.append("\n}");
        return builder.toString();
    }
}
