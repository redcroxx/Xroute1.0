package xrt.interfaces.tolos.vo;

import java.io.Serializable;
import java.util.Arrays;

public class TolosOrderVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String orderlistKey; // 주문 번호
    private String[] itemno; // 상품 번호
    private String[] item; // 상품명
    private String[] itemoption; // 상품 옵션
    private String[] itemoptionkr; // 상품 옵션(한글)
    private int[] itemcnt; // 상품 수량
    private float[] itemprice; // 상품단위 가격

    public String getOrderlistKey() {
        return orderlistKey;
    }

    public void setOrderlistKey(String orderlistKey) {
        this.orderlistKey = orderlistKey;
    }

    public String[] getItemno() {
        return itemno;
    }

    public void setItemno(String[] itemno) {
        this.itemno = itemno;
    }

    public String[] getItem() {
        return item;
    }

    public void setItem(String[] item) {
        this.item = item;
    }

    public String[] getItemoption() {
        return itemoption;
    }

    public void setItemoption(String[] itemoption) {
        this.itemoption = itemoption;
    }

    public String[] getItemoptionkr() {
        return itemoptionkr;
    }

    public void setItemoptionkr(String[] itemoptionkr) {
        this.itemoptionkr = itemoptionkr;
    }

    public int[] getItemcnt() {
        return itemcnt;
    }

    public void setItemcnt(int[] itemcnt) {
        this.itemcnt = itemcnt;
    }

    public float[] getItemprice() {
        return itemprice;
    }

    public void setItemprice(float[] itemprice) {
        this.itemprice = itemprice;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\torderlistKey: ");
        builder.append(orderlistKey);
        builder.append("\n\titemno: ");
        builder.append(Arrays.toString(itemno));
        builder.append("\n\titem: ");
        builder.append(Arrays.toString(item));
        builder.append("\n\titemoption: ");
        builder.append(Arrays.toString(itemoption));
        builder.append("\n\titemoptionkr: ");
        builder.append(Arrays.toString(itemoptionkr));
        builder.append("\n\titemcnt: ");
        builder.append(Arrays.toString(itemcnt));
        builder.append("\n\titemprice: ");
        builder.append(Arrays.toString(itemprice));
        builder.append("\n}");
        return builder.toString();
    }

}
