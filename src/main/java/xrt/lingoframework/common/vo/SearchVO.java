package xrt.lingoframework.common.vo;

import java.io.Serializable;

/**
 * 검색조건, 키워드와 페이지정보를 갖고 있는 VO클래스
 *
 * @author 표준프레임워크센터
 * @since 2014.01.24
 * @version 1.0
 * @see
 * 
 *      <pre>
 *  == 개정이력(Modification Information) ==
 *
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2014.01.24        표준프레임워크센터          최초 생성
 *
 *      </pre>
 */
public class SearchVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private int pageIndex = 1;
    private int pageUnit;
    private int pageSize;
    private int firstIndex = 1;
    private int lastIndex = 1;
    private int recordCountPerPage = 10;
    private String searchCondition = "";
    private String searchKeyword = "";

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageUnit() {
        return pageUnit;
    }

    public void setPageUnit(int pageUnit) {
        this.pageUnit = pageUnit;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getFirstIndex() {
        return firstIndex;
    }

    public void setFirstIndex(int firstIndex) {
        this.firstIndex = firstIndex;
    }

    public int getLastIndex() {
        return lastIndex;
    }

    public void setLastIndex(int lastIndex) {
        this.lastIndex = lastIndex;
    }

    public int getRecordCountPerPage() {
        return recordCountPerPage;
    }

    public void setRecordCountPerPage(int recordCountPerPage) {
        this.recordCountPerPage = recordCountPerPage;
    }

    public String getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(String searchCondition) {
        this.searchCondition = searchCondition;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("SearchVO {\n\tpageIndex : ");
        builder.append(pageIndex);
        builder.append(",\n\tpageUnit : ");
        builder.append(pageUnit);
        builder.append(",\n\tpageSize : ");
        builder.append(pageSize);
        builder.append(",\n\tfirstIndex : ");
        builder.append(firstIndex);
        builder.append(",\n\tlastIndex : ");
        builder.append(lastIndex);
        builder.append(",\n\trecordCountPerPage : ");
        builder.append(recordCountPerPage);
        builder.append(",\n\tsearchCondition : ");
        builder.append(searchCondition);
        builder.append(",\n\tsearchKeyword : ");
        builder.append(searchKeyword);
        builder.append("\n}");
        return builder.toString();
    }
}
