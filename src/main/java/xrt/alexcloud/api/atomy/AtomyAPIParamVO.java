package xrt.alexcloud.api.atomy;

import java.io.Serializable;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class AtomyAPIParamVO implements Serializable {

    private static final long serialVersionUID = 1L;

    // 요율 조회 파라메터.
    private String country; // 국가코드 (US)
    private String productCode; // 국내, 해외 상품 코드
    private String productCount; // 상품 수량
    private List<AtomyAPIParamVO> products; // 상품목록
    private String saleNum; // 주문번호.
    private String shipmentRef; // (0 : 주문취소 / 1 : 주문취소 철회).

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductCount() {
        return productCount;
    }

    public void setProductCount(String productCount) {
        this.productCount = productCount;
    }

    public List<AtomyAPIParamVO> getProducts() {
        return products;
    }

    public void setProducts(List<AtomyAPIParamVO> products) {
        this.products = products;
    }
    
    public String getSaleNum() {
        return saleNum;
    }

    public void setSaleNum(String saleNum) {
        this.saleNum = saleNum;
    }
    
    public String getShipmentRef() {
        return shipmentRef;
    }

    public void setShipmentRef(String shipmentRef) {
        this.shipmentRef = shipmentRef;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("AtomyAPIParamVO {\n    country : ");
        builder.append(country);
        builder.append(",\n    productCode : ");
        builder.append(productCode);
        builder.append(",\n    productCount : ");
        builder.append(productCount);
        builder.append(",\n    products : ");
        builder.append(products);
        builder.append(",\n    saleNum : ");
        builder.append(saleNum);
        builder.append(",\n    shipmentRef : ");
        builder.append(shipmentRef);
        builder.append("\n}");
        return builder.toString();
    }
}
