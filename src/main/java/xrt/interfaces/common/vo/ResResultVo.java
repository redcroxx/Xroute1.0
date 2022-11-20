package xrt.interfaces.common.vo;

import java.io.Serializable;
import java.util.Map;

public class ResResultVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private int resultCode;
    private String resultMessage;
    private Map<String, Object> resultData;

    public int getResultCode() {
        return resultCode;
    }

    public void setResultCode(int resultCode) {
        this.resultCode = resultCode;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public void setResultMessage(String resultMessage) {
        this.resultMessage = resultMessage;
    }

    public Map<String, Object> getResultData() {
        return resultData;
    }

    public void setResultData(Map<String, Object> resultData) {
        this.resultData = resultData;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tresultCode: ");
        builder.append(resultCode);
        builder.append("\n\tresultMessage: ");
        builder.append(resultMessage);
        builder.append("\n\tresultData: ");
        builder.append(resultData);
        builder.append("\n}");
        return builder.toString();
    }

}
