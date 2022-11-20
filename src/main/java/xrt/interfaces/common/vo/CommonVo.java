package xrt.interfaces.common.vo;

import java.io.Serializable;

public class CommonVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String codekey;
    private String code;
    private String sname1;
    private String sname2;

    public String getCodekey() {
        return codekey;
    }

    public void setCodekey(String codekey) {
        this.codekey = codekey;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getSname1() {
        return sname1;
    }

    public void setSname1(String sname1) {
        this.sname1 = sname1;
    }

    public String getSname2() {
        return sname2;
    }

    public void setSname2(String sname2) {
        this.sname2 = sname2;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tcodekey: ");
        builder.append(codekey);
        builder.append("\n\tcode: ");
        builder.append(code);
        builder.append("\n\tsname1: ");
        builder.append(sname1);
        builder.append("\n\tsname2: ");
        builder.append(sname2);
        builder.append("\n}");
        return builder.toString();
    }
}
