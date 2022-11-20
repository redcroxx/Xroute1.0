package xrt.interfaces.common.vo;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class EtcParamVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String apikey; // API Key

    private List<OrderDataVo> orderlist; // 오더데이터

    public String getApikey() {
        return apikey;
    }

    public void setApikey(String apikey) {
        this.apikey = apikey;
    }

    public List<OrderDataVo> getOrderlist() {
        return orderlist;
    }

    public void setOrderlist(List<OrderDataVo> orderlist) {
        this.orderlist = orderlist;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("EtcParamVo = \n");
        sb.append("apiKey : " + getApikey() + "\n");
        sb.append(", orderlist : [  \n");

        for (int i = 0; i < getOrderlist().size(); i++) {
            sb.append("{etc_invc_no : " + getOrderlist().get(i).getEtc_invc_no() + "\n");
            sb.append(", mall_nm : " + getOrderlist().get(i).getMall_nm() + "\n");
            sb.append(", cart_no : " + getOrderlist().get(i).getCart_no() + "\n");
            sb.append(", seller_ref_no1 : " + getOrderlist().get(i).getSeller_ref_no1() + "\n");
            sb.append(", seller_ref_no2 : " + getOrderlist().get(i).getSeller_ref_no2() + "\n");
            sb.append(", ship_method_cd : " + getOrderlist().get(i).getShip_method_cd() + "\n");
            sb.append(", ship_name : " + getOrderlist().get(i).getShip_name() + "\n");
            sb.append(", ship_tel : " + getOrderlist().get(i).getShip_tel() + "\n");
            sb.append(", ship_mobile : " + getOrderlist().get(i).getShip_mobile() + "\n");
            sb.append(", ship_addr : " + getOrderlist().get(i).getShip_addr() + "\n");
            sb.append(", ship_post : " + getOrderlist().get(i).getShip_post() + "\n");
            sb.append(", recv_name : " + getOrderlist().get(i).getRecv_name() + "\n");
            sb.append(", recv_tel : " + getOrderlist().get(i).getRecv_tel() + "\n");
            sb.append(", recv_mobile : " + getOrderlist().get(i).getRecv_mobile() + "\n");
            sb.append(", recv_addr1 : " + getOrderlist().get(i).getRecv_addr1() + "\n");
            sb.append(", recv_addr2 : " + getOrderlist().get(i).getRecv_addr2() + "\n");
            sb.append(", recv_city : " + getOrderlist().get(i).getRecv_city() + "\n");
            sb.append(", recv_state : " + getOrderlist().get(i).getRecv_state() + "\n");
            sb.append(", recv_post : " + getOrderlist().get(i).getRecv_post() + "\n");
            sb.append(", recv_nation : " + getOrderlist().get(i).getRecv_nation() + "\n");
            sb.append(", recv_currency : " + getOrderlist().get(i).getRecv_currency() + "\n");
            sb.append(", tot_payment_price : " + getOrderlist().get(i).getTot_payment_price() + "\n");

            sb.append(", orderdtllist : [\n");

            for (int j = 0; j < getOrderlist().get(i).getOrderdtllist().size(); j++) {

                // sb.append("{ dtl_ord_No
                // ="+getOrderlist().get(i).getOrderdtllist().get(j).getDtl_ord_No()
                // +"\n");
                // sb.append(", goods_cd
                // ="+getOrderlist().get(i).getOrderdtllist().get(j).getDtl_ord_No()
                // +"\n");
                //
                // sb.append(", goods_cd
                // ="+getOrderlist().get(i).getOrderdtllist().get(j).getGoods_cd()
                // +"\n");
                // sb.append(", goods_nm
                // ="+getOrderlist().get(i).getOrderdtllist().get(j).getGoods_nm()
                // +"\n");
                // sb.append(", goods_option
                // ="+getOrderlist().get(i).getOrderdtllist().get(j).getGoods_option()
                // +"\n");
                // sb.append(", goods_cnt
                // ="+getOrderlist().get(i).getOrderdtllist().get(j).getGoods_cnt()
                // +"\n");
                // sb.append(", payment_price
                // ="+getOrderlist().get(i).getOrderdtllist().get(j).getPayment_price()
                // +" \n");
                sb.append("} \n");
            }
            sb.append("  ] \n");
            sb.append("} \n");
        }
        sb.append("] \n");

        return sb.toString();
    }
}
