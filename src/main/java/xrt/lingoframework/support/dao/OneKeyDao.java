package xrt.lingoframework.support.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

@Repository("OneKeyDao")
public class OneKeyDao extends SqlSessionDaoSupport {

	@Override
	@Resource(name = "sqlSession")
	public void setSqlSessionFactory(SqlSessionFactory sqlSession) {
		super.setSqlSessionFactory(sqlSession);
	}

	@SuppressWarnings("rawtypes")
	public List selectList(String mapperId, Object param) throws Exception {
		return getSqlSession().selectList(mapperId, param);
	}

	@SuppressWarnings("rawtypes")
	public List selectListPaging(String mapperId, Object param, int pageIndex, int pageSize) throws Exception {
		int skipResults = pageIndex * pageSize;
		RowBounds rowBounds = new RowBounds(skipResults, pageSize);

		return getSqlSession().selectList(mapperId, param, rowBounds);
	}

	public List<LDataMap> select(String mapperId, Object param) throws Exception {
		return getSqlSession().selectList(mapperId, param);
	}

	public List<LDataMap> selectPaging(String mapperId, Object param, int pageIndex, int pageSize) throws Exception {
		int skipResults = pageIndex * pageSize;
		RowBounds rowBounds = new RowBounds(skipResults, pageSize);

		return getSqlSession().selectList(mapperId, param, rowBounds);
	}

	public Object selectOne(String mapperId, Object param) throws Exception {
		return getSqlSession().selectOne(mapperId, param);
	}

	public int insert(String mapperId, Object param) throws Exception {
		return getSqlSession().insert(mapperId, param);
	}

	public int update(String mapperId, Object param) throws Exception {
		return getSqlSession().update(mapperId, param);
	}

	public int delete(String mapperId, Object param) throws Exception {
		return getSqlSession().delete(mapperId, param);
	}

	public void commit() throws Exception {
		getSqlSession().commit();
	}

	public void rollback() throws Exception {
		getSqlSession().rollback();
	}

	/**
	 *  채번
	 *  입고 - WAREHOUSE_IN
	 *  출고 - WAREHOUSE_OUT
	 */
	public String getKey(String param) throws Exception {

		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		LDataMap exeData = new LDataMap();
		exeData.put("P_SEQ_NAME", param);
		exeData.put("P_DATA1", sdf.format(d));
		exeData.put("LOGIN_USERCD", LoginInfo.getUsercd());
		exeData.put("LOGIN_IP", ClientInfo.getClntIP());
		exeData.put("P_SEQVALUE", "");

		select("CommonMapper.getKEY", exeData);

		return exeData.getString("P_SEQVALUE");
	}

	/**
	 *  상태값 리턴
	 *  TABLE_NAME, KEY
	 */
	public String getStatus(String tablename, String key) throws Exception {

		LDataMap exeData = new LDataMap();
		exeData.put("P_TABLE", tablename);
		exeData.put("P_KEY", key);
		exeData.put("P_STS", "");

		select("CommonMapper.getStatus", exeData);
		return exeData.getString("P_STS");
	}
}