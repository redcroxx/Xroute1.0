package xrt.lingoframework.realgrid.biz;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class RealGridBiz extends DefaultBiz {
	//그리드 컬럼 정보 가져오기
	public List<LDataMap> getColumns(LDataMap param) throws Exception {
		return dao.select("RealgridMapper.getColumns", param);
	}

	//그리드 컬럼 정보 저장
	public void setColumns(LDataMap param) throws Exception {
		dao.delete("RealgridMapper.deleteColumns", param);
		dao.insert("RealgridMapper.insertColumns", param);
	}

	//그리드 컬럼 정보 초기화
	public void deleteColumns(LDataMap param) throws Exception {
		dao.delete("RealgridMapper.deleteColumns", param);
	}
}