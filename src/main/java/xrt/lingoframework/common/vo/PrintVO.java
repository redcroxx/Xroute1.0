package xrt.lingoframework.common.vo;

public class PrintVO extends SearchVO {

    private static final long serialVersionUID = 1L;
    
    private String print1;
    private String print2;
    private String print3;
    private String print4;

    public String getPrint1() {
        return print1;
    }

    public void setPrint1(String print1) {
        this.print1 = print1;
    }

    public String getPrint2() {
        return print2;
    }

    public void setPrint2(String print2) {
        this.print2 = print2;
    }

    public String getPrint3() {
        return print3;
    }

    public void setPrint3(String print3) {
        this.print3 = print3;
    }

    public String getPrint4() {
        return print4;
    }

    public void setPrint4(String print4) {
        this.print4 = print4;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("PrintVO {\n\tprint1 : ");
        builder.append(print1);
        builder.append(",\n\tprint2 : ");
        builder.append(print2);
        builder.append(",\n\tprint3 : ");
        builder.append(print3);
        builder.append(",\n\tprint4 : ");
        builder.append(print4);
        builder.append("\n}");
        return builder.toString();
    }
}
