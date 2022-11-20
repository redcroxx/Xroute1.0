package xrt.interfaces.common.vo;

import java.io.Serializable;

public class ApiAuthKeyVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String compcd;
    private String orgcd;
    private String whcd;
    private String usercd;
    private String testKey;
    private String realKey;

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

    public String getWhcd() {
        return whcd;
    }

    public void setWhcd(String whcd) {
        this.whcd = whcd;
    }

    public String getUsercd() {
        return usercd;
    }

    public void setUsercd(String usercd) {
        this.usercd = usercd;
    }

    public String getTestKey() {
        return testKey;
    }

    public void setTestKey(String testKey) {
        this.testKey = testKey;
    }

    public String getRealKey() {
        return realKey;
    }

    public void setRealKey(String realKey) {
        this.realKey = realKey;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tcompcd: ");
        builder.append(compcd);
        builder.append("\n\torgcd: ");
        builder.append(orgcd);
        builder.append("\n\twhcd: ");
        builder.append(whcd);
        builder.append("\n\tusercd: ");
        builder.append(usercd);
        builder.append("\n\ttestKey: ");
        builder.append(testKey);
        builder.append("\n\trealKey: ");
        builder.append(realKey);
        builder.append("\n}");
        return builder.toString();
    }
}
