package xrt.lingoframework.common.vo;

public class CodeVO extends SearchVO {

    private static final long serialVersionUID = 1L;
    private String compcd;
    private String codekey;
    private String code;
    private String value;
    private String value2;
    private String value3;
    private String value4;
    private String value5;
    private String status;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getValue2() {
        return value2;
    }

    public void setValue2(String value2) {
        this.value2 = value2;
    }

    public String getValue3() {
        return value3;
    }

    public void setValue3(String value3) {
        this.value3 = value3;
    }

    public String getValue4() {
        return value4;
    }

    public void setValue4(String value4) {
        this.value4 = value4;
    }

    public String getValue5() {
        return value5;
    }

    public void setValue5(String value5) {
        this.value5 = value5;
    }

    public String getCompcd() {
        return compcd;
    }

    public void setCompcd(String compcd) {
        this.compcd = compcd;
    }

    public String getCodekey() {
        return codekey;
    }

    public void setCodekey(String codekey) {
        this.codekey = codekey;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("CodeVO {\n\tcompcd : ");
        builder.append(compcd);
        builder.append(",\n\tcodekey : ");
        builder.append(codekey);
        builder.append(",\n\tcode : ");
        builder.append(code);
        builder.append(",\n\tvalue : ");
        builder.append(value);
        builder.append(",\n\tvalue2 : ");
        builder.append(value2);
        builder.append(",\n\tvalue3 : ");
        builder.append(value3);
        builder.append(",\n\tvalue4 : ");
        builder.append(value4);
        builder.append(",\n\tvalue5 : ");
        builder.append(value5);
        builder.append(",\n\tstatus : ");
        builder.append(status);
        builder.append("\n}");
        return builder.toString();
    }
}