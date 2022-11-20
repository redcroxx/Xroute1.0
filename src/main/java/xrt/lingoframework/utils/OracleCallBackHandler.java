package xrt.lingoframework.utils;

import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;
import org.springframework.jdbc.support.nativejdbc.CommonsDbcpNativeJdbcExtractor;

import java.sql.*;

/**
 * Created by prio_jeon on 2016-03-29.
 */
public class OracleCallBackHandler implements TypeHandler<Object> {

    @Override
    public Object getResult(ResultSet rs, String columnName) throws SQLException {
        // TODO Auto-generated method stub
        String value = "";
        try {
            if (StringUtils.isNotEmpty(rs.getString(columnName))) {
                value = new String(rs.getString(columnName).getBytes("8859_1"), "KSC5601");
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return value;
    }

    @Override
    public Object getResult(ResultSet resultSet, int i) throws SQLException {
        return null;
    }

    @Override
    public Object getResult(CallableStatement cs, int columnIndex) throws SQLException {
        // TODO Auto-generated method stub
        return cs.getString(columnIndex);
    }

    @Override
    public void setParameter(PreparedStatement ps, int i, Object parameter,
                             JdbcType arg3) throws SQLException {

        CommonsDbcpNativeJdbcExtractor extractor = new CommonsDbcpNativeJdbcExtractor();
        Connection conn = extractor.getNativeConnection(ps.getConnection());
//        Connection conn = ps.getConnection();
        // TODO Auto-generated method stub
        ArrayDescriptor desc = ArrayDescriptor.createDescriptor("STRING_ARRAY", conn);
        //parameter = new ARRAY(desc, conn, ((ArrayList) parameter).toArray());
        parameter = new ARRAY(desc, conn, (String[]) parameter);
        ps.setArray(i, (oracle.sql.ARRAY) parameter);
    }

}
