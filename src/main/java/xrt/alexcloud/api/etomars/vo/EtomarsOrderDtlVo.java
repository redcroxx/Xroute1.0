package xrt.alexcloud.api.etomars.vo;

import java.io.Serializable;

public class EtomarsOrderDtlVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String GoodsName; // 상품명;
    private int Qty; // 개수;
    private float UnitPrice; // 단가;
    private String BrandName; // 브랜드명;
    private String SKU; // 상품코드;
    private String HSCODE; // 배송국가 HSCODE;
    private String PurchaseUrl; // 상품 상세페이지 URL;
    private String Material; // 의류인 경우 재질;
    private String Barcode; // 바코드;
    private String GoodsNameExpEn; // 영문상품명(수출신고용);
    private String HscodeExpEn; // HSCODE(수출신고용 10자리);

    public String getGoodsName() {
        return GoodsName;
    }

    public void setGoodsName(String goodsName) {
        this.GoodsName = goodsName;
    }

    public int getQty() {
        return Qty;
    }

    public void setQty(int qty) {
        this.Qty = qty;
    }

    public float getUnitPrice() {
        return UnitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.UnitPrice = unitPrice;
    }

    public String getBrandName() {
        return BrandName;
    }

    public void setBrandName(String brandName) {
        this.BrandName = brandName;
    }

    public String getSKU() {
        return SKU;
    }

    public void setSKU(String sKU) {
        this.SKU = sKU;
    }

    public String getHSCODE() {
        return HSCODE;
    }

    public void setHSCODE(String hSCODE) {
        this.HSCODE = hSCODE;
    }

    public String getPurchaseUrl() {
        return PurchaseUrl;
    }

    public void setPurchaseUrl(String purchaseUrl) {
        this.PurchaseUrl = purchaseUrl;
    }

    public String getMaterial() {
        return Material;
    }

    public void setMaterial(String material) {
        this.Material = material;
    }

    public String getBarcode() {
        return Barcode;
    }

    public void setBarcode(String barcode) {
        this.Barcode = barcode;
    }

    public String getGoodsNameExpEn() {
        return GoodsNameExpEn;
    }

    public void setGoodsNameExpEn(String goodsNameExpEn) {
        this.GoodsNameExpEn = goodsNameExpEn;
    }

    public String getHscodeExpEn() {
        return HscodeExpEn;
    }

    public void setHscodeExpEn(String hscodeExpEn) {
        this.HscodeExpEn = hscodeExpEn;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tGoodsName: ");
        builder.append(GoodsName);
        builder.append("\n\tQty: ");
        builder.append(Qty);
        builder.append("\n\tUnitPrice: ");
        builder.append(UnitPrice);
        builder.append("\n\tBrandName: ");
        builder.append(BrandName);
        builder.append("\n\tSKU: ");
        builder.append(SKU);
        builder.append("\n\tHSCODE: ");
        builder.append(HSCODE);
        builder.append("\n\tPurchaseUrl: ");
        builder.append(PurchaseUrl);
        builder.append("\n\tMaterial: ");
        builder.append(Material);
        builder.append("\n\tBarcode: ");
        builder.append(Barcode);
        builder.append("\n\tGoodsNameExpEn: ");
        builder.append(GoodsNameExpEn);
        builder.append("\n\tHscodeExpEn: ");
        builder.append(HscodeExpEn);
        builder.append("\n}");
        return builder.toString();
    }
}