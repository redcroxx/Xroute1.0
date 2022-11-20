package xrt.interfaces.tolos.vo;

import java.io.Serializable;
import java.util.List;

public class TolosShipmentVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String shprrefno; // 발송품 참조번호
    private String shipmethod; // 발송 서비스 타입 배송방식(POSTAL,NORMAL, PREMIUM)
    private String shipname; // 송화인 명
    private String shipaddr; // 송화인 주소
    private String shippostal; // 송화인 우편번호
    private String shiptel; // 송화인 전화번호
    private String shipmobile; // 송화인 휴대폰번호
    private String snation; // 송화인 국가코드
    private String cneename; // 수화인명
    private String cneeaddr; // 수화인 주소
    private String cneepostal; // 수화인 우편번호
    private String cneetel; // 수화인 전화번호
    private String cneemobile; // 수화인 휴대폰번호
    private String enation; // 수화인 국가코드
    private String shopcode; // 판매 쇼핑몰 코드
    private String currency; // 상품단위 가격통화
    private float purchasecharge; // 수출입 신고 가격
    private String cartno; // 장바구니 번호
    private List<TolosOrderVo> orderList; // 주문 정보

    public String getShprrefno() {
        return shprrefno;
    }

    public void setShprrefno(String shprrefno) {
        this.shprrefno = shprrefno;
    }

    public String getShipmethod() {
        return shipmethod;
    }

    public void setShipmethod(String shipmethod) {
        this.shipmethod = shipmethod;
    }

    public String getShipname() {
        return shipname;
    }

    public void setShipname(String shipname) {
        this.shipname = shipname;
    }

    public String getShipaddr() {
        return shipaddr;
    }

    public void setShipaddr(String shipaddr) {
        this.shipaddr = shipaddr;
    }

    public String getShippostal() {
        return shippostal;
    }

    public void setShippostal(String shippostal) {
        this.shippostal = shippostal;
    }

    public String getShiptel() {
        return shiptel;
    }

    public void setShiptel(String shiptel) {
        this.shiptel = shiptel;
    }

    public String getShipmobile() {
        return shipmobile;
    }

    public void setShipmobile(String shipmobile) {
        this.shipmobile = shipmobile;
    }

    public String getSnation() {
        return snation;
    }

    public void setSnation(String snation) {
        this.snation = snation;
    }

    public String getCneename() {
        return cneename;
    }

    public void setCneename(String cneename) {
        this.cneename = cneename;
    }

    public String getCneeaddr() {
        return cneeaddr;
    }

    public void setCneeaddr(String cneeaddr) {
        this.cneeaddr = cneeaddr;
    }

    public String getCneepostal() {
        return cneepostal;
    }

    public void setCneepostal(String cneepostal) {
        this.cneepostal = cneepostal;
    }

    public String getCneetel() {
        return cneetel;
    }

    public void setCneetel(String cneetel) {
        this.cneetel = cneetel;
    }

    public String getCneemobile() {
        return cneemobile;
    }

    public void setCneemobile(String cneemobile) {
        this.cneemobile = cneemobile;
    }

    public String getEnation() {
        return enation;
    }

    public void setEnation(String enation) {
        this.enation = enation;
    }

    public String getShopcode() {
        return shopcode;
    }

    public void setShopcode(String shopcode) {
        this.shopcode = shopcode;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public float getPurchasecharge() {
        return purchasecharge;
    }

    public void setPurchasecharge(float purchasecharge) {
        this.purchasecharge = purchasecharge;
    }

    public String getCartno() {
        return cartno;
    }

    public void setCartno(String cartno) {
        this.cartno = cartno;
    }

    public List<TolosOrderVo> getOrderList() {
        return orderList;
    }

    public void setOrderList(List<TolosOrderVo> orderList) {
        this.orderList = orderList;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tshprrefno: ");
        builder.append(shprrefno);
        builder.append("\n\tshipmethod: ");
        builder.append(shipmethod);
        builder.append("\n\tshipname: ");
        builder.append(shipname);
        builder.append("\n\tshipaddr: ");
        builder.append(shipaddr);
        builder.append("\n\tshippostal: ");
        builder.append(shippostal);
        builder.append("\n\tshiptel: ");
        builder.append(shiptel);
        builder.append("\n\tshipmobile: ");
        builder.append(shipmobile);
        builder.append("\n\tsnation: ");
        builder.append(snation);
        builder.append("\n\tcneename: ");
        builder.append(cneename);
        builder.append("\n\tcneeaddr: ");
        builder.append(cneeaddr);
        builder.append("\n\tcneepostal: ");
        builder.append(cneepostal);
        builder.append("\n\tcneetel: ");
        builder.append(cneetel);
        builder.append("\n\tcneemobile: ");
        builder.append(cneemobile);
        builder.append("\n\tenation: ");
        builder.append(enation);
        builder.append("\n\tshopcode: ");
        builder.append(shopcode);
        builder.append("\n\tcurrency: ");
        builder.append(currency);
        builder.append("\n\tpurchasecharge: ");
        builder.append(purchasecharge);
        builder.append("\n\tcartno: ");
        builder.append(cartno);
        builder.append("\n\torderList: ");
        builder.append(orderList);
        builder.append("\n}");
        return builder.toString();
    }
}
