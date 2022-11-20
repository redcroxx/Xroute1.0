package xrt.alexcloud.api.etomars.vo;

import java.io.Serializable;

public class EtomarsDataDtlVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String goodsName; // 상품명
    private int qty; // 개수
    private String unitPrice; // 단가
    private String brandName; // 브랜드명
    private String sku; // 상품코드
    private String hsCode; // 배송국가 HSCODE
    private String purchaseUrl; // 상품 상세페이지 URL

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public String getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(String unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getHsCode() {
        return hsCode;
    }

    public void setHsCode(String hsCode) {
        this.hsCode = hsCode;
    }

    public String getPurchaseUrl() {
        return purchaseUrl;
    }

    public void setPurchaseUrl(String purchaseUrl) {
        this.purchaseUrl = purchaseUrl;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tgoodsName: ");
        builder.append(goodsName);
        builder.append("\n\tqty: ");
        builder.append(qty);
        builder.append("\n\tunitPrice: ");
        builder.append(unitPrice);
        builder.append("\n\tbrandName: ");
        builder.append(brandName);
        builder.append("\n\tsku: ");
        builder.append(sku);
        builder.append("\n\thsCode: ");
        builder.append(hsCode);
        builder.append("\n\tpurchaseUrl: ");
        builder.append(purchaseUrl);
        builder.append("\n}");
        return builder.toString();
    }

}
