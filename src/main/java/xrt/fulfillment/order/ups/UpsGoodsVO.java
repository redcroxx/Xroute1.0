package xrt.fulfillment.order.ups;

import java.io.Serializable;

public class UpsGoodsVO implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String shipmentRef1;
    private String goodsPartNumber;
    private String goodsDescription;
    private String goodsTariffCode;
    private String goodsCoo;
    private String goodsUnits;
    private String goodsUnitOfMeasure;
    private String goodsUnitPrice;
    private String goodsCurrency;
    
    public String getShipmentRef1() {
        return shipmentRef1;
    }
    public void setShipmentRef1(String shipmentRef1) {
        this.shipmentRef1 = shipmentRef1;
    }
    public String getGoodsPartNumber() {
        return goodsPartNumber;
    }
    public void setGoodsPartNumber(String goodsPartNumber) {
        this.goodsPartNumber = goodsPartNumber;
    }
    public String getGoodsDescription() {
        return goodsDescription;
    }
    public void setGoodsDescription(String goodsDescription) {
        this.goodsDescription = goodsDescription;
    }
    public String getGoodsTariffCode() {
        return goodsTariffCode;
    }
    public void setGoodsTariffCode(String goodsTariffCode) {
        this.goodsTariffCode = goodsTariffCode;
    }
    public String getGoodsCoo() {
        return goodsCoo;
    }
    public void setGoodsCoo(String goodsCoo) {
        this.goodsCoo = goodsCoo;
    }
    public String getGoodsUnits() {
        return goodsUnits;
    }
    public void setGoodsUnits(String goodsUnits) {
        this.goodsUnits = goodsUnits;
    }
    public String getGoodsUnitOfMeasure() {
        return goodsUnitOfMeasure;
    }
    public void setGoodsUnitOfMeasure(String goodsUnitOfMeasure) {
        this.goodsUnitOfMeasure = goodsUnitOfMeasure;
    }
    public String getGoodsUnitPrice() {
        return goodsUnitPrice;
    }
    public void setGoodsUnitPrice(String goodsUnitPrice) {
        this.goodsUnitPrice = goodsUnitPrice;
    }
    public String getGoodsCurrency() {
        return goodsCurrency;
    }
    public void setGoodsCurrency(String goodsCurrency) {
        this.goodsCurrency = goodsCurrency;
    }
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("UpsGoodsVO {\n    shipmentRef1 : ");
        builder.append(shipmentRef1);
        builder.append(",\n    goodsPartNumber : ");
        builder.append(goodsPartNumber);
        builder.append(",\n    goodsDescription : ");
        builder.append(goodsDescription);
        builder.append(",\n    goodsTariffCode : ");
        builder.append(goodsTariffCode);
        builder.append(",\n    goodsCoo : ");
        builder.append(goodsCoo);
        builder.append(",\n    goodsUnits : ");
        builder.append(goodsUnits);
        builder.append(",\n    goodsUnitOfMeasure : ");
        builder.append(goodsUnitOfMeasure);
        builder.append(",\n    goodsUnitPrice : ");
        builder.append(goodsUnitPrice);
        builder.append(",\n    goodsCurrency : ");
        builder.append(goodsCurrency);
        builder.append("\n}");
        return builder.toString();
    }
}
