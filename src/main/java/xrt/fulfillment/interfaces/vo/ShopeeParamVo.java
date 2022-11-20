package xrt.fulfillment.interfaces.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ShopeeParamVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private int interfaceSeq;
    private int interfaceDtlSeq;
    private String userId;
    private String partnerId;
    private String partnerKey;
    private String interfaceType;
    private String post;
    private String phoneNumber;
    private String koAddress;
    private String enAddress;
    private String shipMethod;
    private List<Map<String, Object>> etcData;

    public int getInterfaceSeq() {
        return interfaceSeq;
    }

    public void setInterfaceSeq(int interfaceSeq) {
        this.interfaceSeq = interfaceSeq;
    }

    public int getInterfaceDtlSeq() {
        return interfaceDtlSeq;
    }

    public void setInterfaceDtlSeq(int interfaceDtlSeq) {
        this.interfaceDtlSeq = interfaceDtlSeq;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPartnerId() {
        return partnerId;
    }

    public void setPartnerId(String partnerId) {
        this.partnerId = partnerId;
    }

    public String getPartnerKey() {
        return partnerKey;
    }

    public void setPartnerKey(String partnerKey) {
        this.partnerKey = partnerKey;
    }

    public String getInterfaceType() {
        return interfaceType;
    }

    public void setInterfaceType(String interfaceType) {
        this.interfaceType = interfaceType;
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

    public List<Map<String, Object>> getEtcData() {
        return etcData;
    }

    public void setEtcData(List<Map<String, Object>> etcData) {
        this.etcData = etcData;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tinterfaceSeq: ");
        builder.append(interfaceSeq);
        builder.append("\n\tinterfaceDtlSeq: ");
        builder.append(interfaceDtlSeq);
        builder.append("\n\tuserId: ");
        builder.append(userId);
        builder.append("\n\tpartnerId: ");
        builder.append(partnerId);
        builder.append("\n\tpartnerKey: ");
        builder.append(partnerKey);
        builder.append("\n\tinterfaceType: ");
        builder.append(interfaceType);
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
        builder.append("\n\tetcData: ");
        builder.append(etcData);
        builder.append("\n}");
        return builder.toString();
    }

}
