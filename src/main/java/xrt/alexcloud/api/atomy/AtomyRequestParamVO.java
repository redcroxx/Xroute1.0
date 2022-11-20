package xrt.alexcloud.api.atomy;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class AtomyRequestParamVO implements Serializable{

    private static final long serialVersionUID = 1L;
    
    private String startDate;
    private String endDate;
    private String pageSize;
    private String pageNo;
    private String useCrossBoarderShopping;
    
    public String getStartDate() {
        return startDate;
    }
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }
    public String getEndDate() {
        return endDate;
    }
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
    public String getPageSize() {
        return pageSize;
    }
    public void setPageSize(String pageSize) {
        this.pageSize = pageSize;
    }
    public String getPageNo() {
        return pageNo;
    }
    public void setPageNo(String pageNo) {
        this.pageNo = pageNo;
    }
    public String getUseCrossBoarderShopping() {
        return useCrossBoarderShopping;
    }
    public void setUseCrossBoarderShopping(String useCrossBoarderShopping) {
        this.useCrossBoarderShopping = useCrossBoarderShopping;
    }
    
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("AtomyRequestParamVO {\n    startDate : ");
        builder.append(startDate);
        builder.append(",\n    endDate : ");
        builder.append(endDate);
        builder.append(",\n    pageSize : ");
        builder.append(pageSize);
        builder.append(",\n    pageNo : ");
        builder.append(pageNo);
        builder.append(",\n    useCrossBoarderShopping : ");
        builder.append(useCrossBoarderShopping);
        builder.append("\n}");
        return builder.toString();
    }
}
