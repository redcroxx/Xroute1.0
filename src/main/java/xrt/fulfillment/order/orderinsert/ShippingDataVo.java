package xrt.fulfillment.order.orderinsert;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import xrt.alexcloud.api.efs.vo.EfsShipmentVo;
import xrt.alexcloud.api.etomars.vo.EtomarsShipmentVo;
import xrt.alexcloud.api.tolos.vo.TolosShipmentVo;
import xrt.interfaces.qxpress.vo.QxpressVo;

public class ShippingDataVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private List<Map<String, Object>> xrtInvcSnos; // xrt송장번호
    private List<Map<String, Object>> tOrders; // 오더데이터
    private List<EfsShipmentVo> efsShipmentVos; // efs배송데이터
    private List<EtomarsShipmentVo> etomarsShipmentVos; // etomars배송데이터
    private List<TolosShipmentVo> tolosShipmentVos; // tolos배송데이터
    private List<QxpressVo> qxpressVos;

    public List<Map<String, Object>> getXrtInvcSnos() {
        return xrtInvcSnos;
    }

    public void setXrtInvcSnos(List<Map<String, Object>> xrtInvcSnos) {
        this.xrtInvcSnos = xrtInvcSnos;
    }

    public List<Map<String, Object>> gettOrders() {
        return tOrders;
    }

    public void settOrders(List<Map<String, Object>> tOrders) {
        this.tOrders = tOrders;
    }

    public List<EfsShipmentVo> getEfsShipmentVos() {
        return efsShipmentVos;
    }

    public void setEfsShipmentVos(List<EfsShipmentVo> efsShipmentVos) {
        this.efsShipmentVos = efsShipmentVos;
    }

    public List<EtomarsShipmentVo> getEtomarsShipmentVos() {
        return etomarsShipmentVos;
    }

    public void setEtomarsShipmentVos(List<EtomarsShipmentVo> etomarsShipmentVos) {
        this.etomarsShipmentVos = etomarsShipmentVos;
    }

    public List<TolosShipmentVo> getTolosShipmentVos() {
        return tolosShipmentVos;
    }

    public void setTolosShipmentVos(List<TolosShipmentVo> tolosShipmentVos) {
        this.tolosShipmentVos = tolosShipmentVos;
    }

    public List<QxpressVo> getQxpressVos() {
        return qxpressVos;
    }

    public void setQxpressVos(List<QxpressVo> qxpressVos) {
        this.qxpressVos = qxpressVos;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\txrtInvcSnos: ");
        builder.append(xrtInvcSnos);
        builder.append("\n\ttOrders: ");
        builder.append(tOrders);
        builder.append("\n\tefsShipmentVos: ");
        builder.append(efsShipmentVos);
        builder.append("\n\tetomarsShipmentVos: ");
        builder.append(etomarsShipmentVos);
        builder.append("\n\ttolosShipmentVos: ");
        builder.append(tolosShipmentVos);
        builder.append("\n\tqxpressVos: ");
        builder.append(qxpressVos);
        builder.append("\n}");
        return builder.toString();
    }
}
