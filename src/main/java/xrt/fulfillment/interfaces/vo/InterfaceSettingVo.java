package xrt.fulfillment.interfaces.vo;

import java.io.Serializable;

public class InterfaceSettingVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String interfaceSeq;
    private String userId;
    private String userName;
    private String interfaceType;
    private String authId;
    private String authKey;
    private String post;
    private String phoneNumber;
    private String koAddress;
    private String enAddress;
    private String shipMethod;
    private String mappingKey;
    private String etcKey;
    private String paymentType;

    public String getInterfaceSeq() {
        return interfaceSeq;
    }

    public void setInterfaceSeq(String interfaceSeq) {
        this.interfaceSeq = interfaceSeq;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getInterfaceType() {
        return interfaceType;
    }

    public void setInterfaceType(String interfaceType) {
        this.interfaceType = interfaceType;
    }

    public String getAuthId() {
        return authId;
    }

    public void setAuthId(String authId) {
        this.authId = authId;
    }

    public String getAuthKey() {
        return authKey;
    }

    public void setAuthKey(String authKey) {
        this.authKey = authKey;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getKoAddress() {
        return koAddress;
    }

    public void setKoAddress(String koAddress) {
        this.koAddress = koAddress;
    }

    public String getEnAddress() {
        return enAddress;
    }

    public void setEnAddress(String enAddress) {
        this.enAddress = enAddress;
    }

    public String getShipMethod() {
        return shipMethod;
    }

    public void setShipMethod(String shipMethod) {
        this.shipMethod = shipMethod;
    }

    public String getMappingKey() {
        return mappingKey;
    }

    public void setMappingKey(String mappingKey) {
        this.mappingKey = mappingKey;
    }

    public String getEtcKey() {
        return etcKey;
    }

    public void setEtcKey(String etcKey) {
        this.etcKey = etcKey;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tinterfaceSeq: ");
        builder.append(interfaceSeq);
        builder.append("\n\tuserId: ");
        builder.append(userId);
        builder.append("\n\tuserName: ");
        builder.append(userName);
        builder.append("\n\tinterfaceType: ");
        builder.append(interfaceType);
        builder.append("\n\tauthId: ");
        builder.append(authId);
        builder.append("\n\tauthKey: ");
        builder.append(authKey);
        builder.append("\n\tpost: ");
        builder.append(post);
        builder.append("\n\tphoneNumber: ");
        builder.append(phoneNumber);
        builder.append("\n\tkoAddress: ");
        builder.append(koAddress);
        builder.append("\n\tenAddress: ");
        builder.append(enAddress);
        builder.append("\n\tshipMethod: ");
        builder.append(shipMethod);
        builder.append("\n\tmappingKey: ");
        builder.append(mappingKey);
        builder.append("\n\tetcKey: ");
        builder.append(etcKey);
        builder.append("\n\tpaymentType: ");
        builder.append(paymentType);
        builder.append("\n}");
        return builder.toString();
    }

}
