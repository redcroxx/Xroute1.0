package xrt.fulfillment.interfaces.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.io.Serializable;

@JsonIgnoreProperties(ignoreUnknown = true)
public class InterfaceSettingDtlVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private int interfaceDtlSeq;
    private String userId;
    private String interfaceType;
    private String mappingKey;
    private String etcKey;

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

    public String getInterfaceType() {
        return interfaceType;
    }

    public void setInterfaceType(String interfaceType) {
        this.interfaceType = interfaceType;
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

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tinterfaceDtlSeq: ");
        builder.append(interfaceDtlSeq);
        builder.append("\n\tuserId: ");
        builder.append(userId);
        builder.append("\n\tinterfaceType: ");
        builder.append(interfaceType);
        builder.append("\n\tmappingKey: ");
        builder.append(mappingKey);
        builder.append("\n\tetcKey: ");
        builder.append(etcKey);
        builder.append("\n}");
        return builder.toString();
    }

}
