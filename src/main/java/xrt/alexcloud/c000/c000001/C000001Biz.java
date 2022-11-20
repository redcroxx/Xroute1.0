package xrt.alexcloud.c000.c000001;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 품목분류 관리 Biz
 */
@Service
public class C000001Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("C000001Mapper.getSearch", param);
	}
	
	//상세 검색
	public List<LDataMap> getDetail(LDataMap param) throws Exception {
		return dao.select("C000001Mapper.getDetail", param);
	}
	
	//삭제
	public LDataMap setDelete(LDataMap param) throws Exception {
		dao.delete("C000001Mapper.setDelete", param);
		return param;
	}
	
	//정보 수정
	public LDataMap setUpdate(LDataMap param) throws Exception {
		dao.update("C000001Mapper.setUpdate", param);
		return param;
	}
	
	//메모 수정
	public LDataMap setMemoUpdate(LDataMap param) throws Exception {
		dao.update("C000001Mapper.setMemoUpdate", param);
		return param;
	}
	
	//메모 저장
	public LDataMap setMemoNew(LDataMap param) throws Exception {
		dao.insert("C000001Mapper.setMemoNew", param);
		return param;
	}
}
