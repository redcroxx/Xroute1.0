package xrt.interfaces.common.vo;

import java.io.Serializable;
import java.util.List;

public class OrderDataVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String etc_invc_no; // 송장번호
    private String mall_nm; // 판매자 쇼핑몰명
    private String cart_no; // 장바구니 번호
    private String seller_ref_no1; // 판매자 참조1
    private String seller_ref_no2; // 판매자 참조2
    private String ship_method_cd; // 물품 배송방식
    private String ship_name; // 송화인명
    private String ship_tel; // 송화인 전화번호
    private String ship_mobile; // 송화인 휴대폰
    private String ship_addr; // 송화인 주소
    private String ship_post; // 송화인 우편번호
    private String recv_name; // 수취인명
    private String recv_tel; // 수취인 전화번호
    private String recv_mobile; // 수취인 휴대폰
    private String recv_addr1; // 수취인 주소1
    private String recv_addr2; // 수취인 주소2
    private String recv_city; // 수취인 도시
    private String recv_state; // 수취인 주
    private String recv_post; // 수취인 우편번호
    private String recv_nation; // 수취인 국가
    private String recv_currency; // 수취인 통화
    private String tot_payment_price; // 결제금액
    private List<EfsOrderDtlVo> orderdtllist; // 오더상품상세리스트

    public String getEtc_invc_no() {
        return etc_invc_no;
    }

    public void setEtc_invc_no(String etc_invc_no) {
        this.etc_invc_no = etc_invc_no;
    }

    public String getMall_nm() {
        return mall_nm;
    }

    public void setMall_nm(String mall_nm) {
        this.mall_nm = mall_nm;
    }

    public String getCart_no() {
        return cart_no;
    }

    public void setCart_no(String cart_no) {
        this.cart_no = cart_no;
    }

    public String getSeller_ref_no1() {
        return seller_ref_no1;
    }

    public void setSeller_ref_no1(String seller_ref_no1) {
        this.seller_ref_no1 = seller_ref_no1;
    }

    public String getSeller_ref_no2() {
        return seller_ref_no2;
    }

    public void setSeller_ref_no2(String seller_ref_no2) {
        this.seller_ref_no2 = seller_ref_no2;
    }

    public String getShip_method_cd() {
        return ship_method_cd;
    }

    public void setShip_method_cd(String ship_method_cd) {
        this.ship_method_cd = ship_method_cd;
    }

    public String getShip_name() {
        return ship_name;
    }

    public void setShip_name(String ship_name) {
        this.ship_name = ship_name;
    }

    public String getShip_tel() {
        return ship_tel;
    }

    public void setShip_tel(String ship_tel) {
        this.ship_tel = ship_tel;
    }

    public String getShip_mobile() {
        return ship_mobile;
    }

    public void setShip_mobile(String ship_mobile) {
        this.ship_mobile = ship_mobile;
    }

    public String getShip_addr() {
        return ship_addr;
    }

    public void setShip_addr(String ship_addr) {
        this.ship_addr = ship_addr;
    }

    public String getShip_post() {
        return ship_post;
    }

    public void setShip_post(String ship_post) {
        this.ship_post = ship_post;
    }

    public String getRecv_name() {
        return recv_name;
    }

    public void setRecv_name(String recv_name) {
        this.recv_name = recv_name;
    }

    public String getRecv_tel() {
        return recv_tel;
    }

    public void setRecv_tel(String recv_tel) {
        this.recv_tel = recv_tel;
    }

    public String getRecv_mobile() {
        return recv_mobile;
    }

    public void setRecv_mobile(String recv_mobile) {
        this.recv_mobile = recv_mobile;
    }

    public String getRecv_addr1() {
        return recv_addr1;
    }

    public void setRecv_addr1(String recv_addr1) {
        this.recv_addr1 = recv_addr1;
    }

    public String getRecv_addr2() {
        return recv_addr2;
    }

    public void setRecv_addr2(String recv_addr2) {
        this.recv_addr2 = recv_addr2;
    }

    public String getRecv_city() {
        return recv_city;
    }

    public void setRecv_city(String recv_city) {
        this.recv_city = recv_city;
    }

    public String getRecv_state() {
        return recv_state;
    }

    public void setRecv_state(String recv_state) {
        this.recv_state = recv_state;
    }

    public String getRecv_post() {
        return recv_post;
    }

    public void setRecv_post(String recv_post) {
        this.recv_post = recv_post;
    }

    public String getRecv_nation() {
        return recv_nation;
    }

    public void setRecv_nation(String recv_nation) {
        this.recv_nation = recv_nation;
    }

    public String getRecv_currency() {
        return recv_currency;
    }

    public void setRecv_currency(String recv_currency) {
        this.recv_currency = recv_currency;
    }

    public String getTot_payment_price() {
        return tot_payment_price;
    }

    public void setTot_payment_price(String tot_payment_price) {
        this.tot_payment_price = tot_payment_price;
    }

    public List<EfsOrderDtlVo> getOrderdtllist() {
        return orderdtllist;
    }

    public void setOrderdtllist(List<EfsOrderDtlVo> orderdtllist) {
        this.orderdtllist = orderdtllist;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tetc_invc_no: ");
        builder.append(etc_invc_no);
        builder.append("\n\tmall_nm: ");
        builder.append(mall_nm);
        builder.append("\n\tcart_no: ");
        builder.append(cart_no);
        builder.append("\n\tseller_ref_no1: ");
        builder.append(seller_ref_no1);
        builder.append("\n\tseller_ref_no2: ");
        builder.append(seller_ref_no2);
        builder.append("\n\tship_method_cd: ");
        builder.append(ship_method_cd);
        builder.append("\n\tship_name: ");
        builder.append(ship_name);
        builder.append("\n\tship_tel: ");
        builder.append(ship_tel);
        builder.append("\n\tship_mobile: ");
        builder.append(ship_mobile);
        builder.append("\n\tship_addr: ");
        builder.append(ship_addr);
        builder.append("\n\tship_post: ");
        builder.append(ship_post);
        builder.append("\n\trecv_name: ");
        builder.append(recv_name);
        builder.append("\n\trecv_tel: ");
        builder.append(recv_tel);
        builder.append("\n\trecv_mobile: ");
        builder.append(recv_mobile);
        builder.append("\n\trecv_addr1: ");
        builder.append(recv_addr1);
        builder.append("\n\trecv_addr2: ");
        builder.append(recv_addr2);
        builder.append("\n\trecv_city: ");
        builder.append(recv_city);
        builder.append("\n\trecv_state: ");
        builder.append(recv_state);
        builder.append("\n\trecv_post: ");
        builder.append(recv_post);
        builder.append("\n\trecv_nation: ");
        builder.append(recv_nation);
        builder.append("\n\trecv_currency: ");
        builder.append(recv_currency);
        builder.append("\n\ttot_payment_price: ");
        builder.append(tot_payment_price);
        builder.append("\n\torderdtllist: ");
        builder.append(orderdtllist);
        builder.append("\n}");
        return builder.toString();
    }

}
