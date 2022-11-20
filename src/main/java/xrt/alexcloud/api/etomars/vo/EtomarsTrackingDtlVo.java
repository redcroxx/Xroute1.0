package xrt.alexcloud.api.etomars.vo;

import java.io.Serializable;

public class EtomarsTrackingDtlVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String status; // 상태코드
    private String statusDesc; // 상태설명
    private String issueDateTime; // 날짜시간
    private String issueDetail; // 이슈상세설명

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatusDesc() {
        return statusDesc;
    }

    public void setStatusDesc(String statusDesc) {
        this.statusDesc = statusDesc;
    }

    public String getIssueDateTime() {
        return issueDateTime;
    }

    public void setIssueDateTime(String issueDateTime) {
        this.issueDateTime = issueDateTime;
    }

    public String getIssueDetail() {
        return issueDetail;
    }

    public void setIssueDetail(String issueDetail) {
        this.issueDetail = issueDetail;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tstatus: ");
        builder.append(status);
        builder.append("\n\tstatusDesc: ");
        builder.append(statusDesc);
        builder.append("\n\tissueDateTime: ");
        builder.append(issueDateTime);
        builder.append("\n\tissueDetail: ");
        builder.append(issueDetail);
        builder.append("\n}");
        return builder.toString();
    }
}
