package xrt.sys.promotionCode;

import java.io.Serializable;

public class PromotionCodeVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String promotionCodeSeq;
    private String promotionCode;
    private String codeStartDate;
    private String codeEndDate;
    private String codePeriod;
    private String codeCount;
    private String discountStartDate;
    private String discountEndDate;
    private String discountPeriod;
    private String premium;
    private String dhl;
    private String content;
    private String addusercd;
    private String adddatetime;
    private String updusercd;
    private String upddatetime;
    private String terminalcd;

    public String getPromotionCodeSeq() {
        return promotionCodeSeq;
    }

    public void setPromotionCodeSeq(String promotionCodeSeq) {
        this.promotionCodeSeq = promotionCodeSeq;
    }

    public String getPromotionCode() {
        return promotionCode;
    }

    public void setPromotionCode(String promotionCode) {
        this.promotionCode = promotionCode;
    }

    public String getCodeStartDate() {
        return codeStartDate;
    }

    public void setCodeStartDate(String codeStartDate) {
        this.codeStartDate = codeStartDate;
    }

    public String getCodeEndDate() {
        return codeEndDate;
    }

    public void setCodeEndDate(String codeEndDate) {
        this.codeEndDate = codeEndDate;
    }

    public String getCodePeriod() {
        return codePeriod;
    }

    public void setCodePeriod(String codePeriod) {
        this.codePeriod = codePeriod;
    }

    public String getCodeCount() {
        return codeCount;
    }

    public void setCodeCount(String codeCount) {
        this.codeCount = codeCount;
    }

    public String getDiscountStartDate() {
        return discountStartDate;
    }

    public void setDiscountStartDate(String discountStartDate) {
        this.discountStartDate = discountStartDate;
    }

    public String getDiscountEndDate() {
        return discountEndDate;
    }

    public void setDiscountEndDate(String discountEndDate) {
        this.discountEndDate = discountEndDate;
    }

    public String getDiscountPeriod() {
        return discountPeriod;
    }

    public void setDiscountPeriod(String discountPeriod) {
        this.discountPeriod = discountPeriod;
    }

    public String getPremium() {
        return premium;
    }

    public void setPremium(String premium) {
        this.premium = premium;
    }

    public String getDhl() {
        return dhl;
    }

    public void setDhl(String dhl) {
        this.dhl = dhl;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAddusercd() {
        return addusercd;
    }

    public void setAddusercd(String addusercd) {
        this.addusercd = addusercd;
    }

    public String getAdddatetime() {
        return adddatetime;
    }

    public void setAdddatetime(String adddatetime) {
        this.adddatetime = adddatetime;
    }

    public String getUpdusercd() {
        return updusercd;
    }

    public void setUpdusercd(String updusercd) {
        this.updusercd = updusercd;
    }

    public String getUpddatetime() {
        return upddatetime;
    }

    public void setUpddatetime(String upddatetime) {
        this.upddatetime = upddatetime;
    }

    public String getTerminalcd() {
        return terminalcd;
    }

    public void setTerminalcd(String terminalcd) {
        this.terminalcd = terminalcd;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tpromotionCodeSeq: ");
        builder.append(promotionCodeSeq);
        builder.append("\n\tpromotionCode: ");
        builder.append(promotionCode);
        builder.append("\n\tcodeStartDate: ");
        builder.append(codeStartDate);
        builder.append("\n\tcodeEndDate: ");
        builder.append(codeEndDate);
        builder.append("\n\tcodePeriod: ");
        builder.append(codePeriod);
        builder.append("\n\tcodeCount: ");
        builder.append(codeCount);
        builder.append("\n\tdiscountStartDate: ");
        builder.append(discountStartDate);
        builder.append("\n\tdiscountEndDate: ");
        builder.append(discountEndDate);
        builder.append("\n\tdiscountPeriod: ");
        builder.append(discountPeriod);
        builder.append("\n\tpremium: ");
        builder.append(premium);
        builder.append("\n\tdhl: ");
        builder.append(dhl);
        builder.append("\n\tcontent: ");
        builder.append(content);
        builder.append("\n\taddusercd: ");
        builder.append(addusercd);
        builder.append("\n\tadddatetime: ");
        builder.append(adddatetime);
        builder.append("\n\tupdusercd: ");
        builder.append(updusercd);
        builder.append("\n\tupddatetime: ");
        builder.append(upddatetime);
        builder.append("\n\tterminalcd: ");
        builder.append(terminalcd);
        builder.append("\n}");
        return builder.toString();
    }
}
