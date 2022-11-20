package xrt.interfaces.shopee.vo;

import java.io.Serializable;

public class ShopeeOrderItemsVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String ordersn;
    private double weight;
    private String itemName;
    private boolean isWholesale;
    private String promotionType;
    private String itemSku;
    private String variationDiscountedPrice;
    private long variationId;
    private String variationName;
    private boolean isAddOnDeal;
    private long itemId;
    private long promotionId;
    private long addOnDealId;
    private long variationQuantityPurchased;
    private String variationSku;
    private String variationOriginalPrice;
    private Boolean isMainItem;
    private String usercd;
    private String compcd;
    private String orgcd;
    private String whcd;
    private String totalPrice;
    private String orderCount;

    public String getOrdersn() {
        return ordersn;
    }

    public void setOrdersn(String ordersn) {
        this.ordersn = ordersn;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public boolean isWholesale() {
        return isWholesale;
    }

    public void setWholesale(boolean wholesale) {
        isWholesale = wholesale;
    }

    public String getPromotionType() {
        return promotionType;
    }

    public void setPromotionType(String promotionType) {
        this.promotionType = promotionType;
    }

    public String getItemSku() {
        return itemSku;
    }

    public void setItemSku(String itemSku) {
        this.itemSku = itemSku;
    }

    public String getVariationDiscountedPrice() {
        return variationDiscountedPrice;
    }

    public void setVariationDiscountedPrice(String variationDiscountedPrice) {
        this.variationDiscountedPrice = variationDiscountedPrice;
    }

    public long getVariationId() {
        return variationId;
    }

    public void setVariationId(long variationId) {
        this.variationId = variationId;
    }

    public String getVariationName() {
        return variationName;
    }

    public void setVariationName(String variationName) {
        this.variationName = variationName;
    }

    public boolean isAddOnDeal() {
        return isAddOnDeal;
    }

    public void setAddOnDeal(boolean addOnDeal) {
        isAddOnDeal = addOnDeal;
    }

    public long getItemId() {
        return itemId;
    }

    public void setItemId(long itemId) {
        this.itemId = itemId;
    }

    public long getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(long promotionId) {
        this.promotionId = promotionId;
    }

    public long getAddOnDealId() {
        return addOnDealId;
    }

    public void setAddOnDealId(long addOnDealId) {
        this.addOnDealId = addOnDealId;
    }

    public long getVariationQuantityPurchased() {
        return variationQuantityPurchased;
    }

    public void setVariationQuantityPurchased(long variationQuantityPurchased) {
        this.variationQuantityPurchased = variationQuantityPurchased;
    }

    public String getVariationSku() {
        return variationSku;
    }

    public void setVariationSku(String variationSku) {
        this.variationSku = variationSku;
    }

    public String getVariationOriginalPrice() {
        return variationOriginalPrice;
    }

    public void setVariationOriginalPrice(String variationOriginalPrice) {
        this.variationOriginalPrice = variationOriginalPrice;
    }

    public Boolean getMainItem() {
        return isMainItem;
    }

    public void setMainItem(Boolean mainItem) {
        isMainItem = mainItem;
    }

    public String getUsercd() {
        return usercd;
    }

    public void setUsercd(String usercd) {
        this.usercd = usercd;
    }

    public String getCompcd() {
        return compcd;
    }

    public void setCompcd(String compcd) {
        this.compcd = compcd;
    }

    public String getOrgcd() {
        return orgcd;
    }

    public void setOrgcd(String orgcd) {
        this.orgcd = orgcd;
    }

    public String getWhcd() {
        return whcd;
    }

    public void setWhcd(String whcd) {
        this.whcd = whcd;
    }

    public String getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(String totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(String orderCount) {
        this.orderCount = orderCount;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tordersn: ");
        builder.append(ordersn);
        builder.append("\n\tweight: ");
        builder.append(weight);
        builder.append("\n\titemName: ");
        builder.append(itemName);
        builder.append("\n\tisWholesale: ");
        builder.append(isWholesale);
        builder.append("\n\tpromotionType: ");
        builder.append(promotionType);
        builder.append("\n\titemSku: ");
        builder.append(itemSku);
        builder.append("\n\tvariationDiscountedPrice: ");
        builder.append(variationDiscountedPrice);
        builder.append("\n\tvariationId: ");
        builder.append(variationId);
        builder.append("\n\tvariationName: ");
        builder.append(variationName);
        builder.append("\n\tisAddOnDeal: ");
        builder.append(isAddOnDeal);
        builder.append("\n\titemId: ");
        builder.append(itemId);
        builder.append("\n\tpromotionId: ");
        builder.append(promotionId);
        builder.append("\n\taddOnDealId: ");
        builder.append(addOnDealId);
        builder.append("\n\tvariationQuantityPurchased: ");
        builder.append(variationQuantityPurchased);
        builder.append("\n\tvariationSku: ");
        builder.append(variationSku);
        builder.append("\n\tvariationOriginalPrice: ");
        builder.append(variationOriginalPrice);
        builder.append("\n\tisMainItem: ");
        builder.append(isMainItem);
        builder.append("\n\tusercd: ");
        builder.append(usercd);
        builder.append("\n\tcompcd: ");
        builder.append(compcd);
        builder.append("\n\torgcd: ");
        builder.append(orgcd);
        builder.append("\n\twhcd: ");
        builder.append(whcd);
        builder.append("\n\ttotalPrice: ");
        builder.append(totalPrice);
        builder.append("\n\torderCount: ");
        builder.append(orderCount);
        builder.append("\n}");
        return builder.toString();
    }

}
