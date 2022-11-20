package xrt.sys.s000015;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 공지사항 Biz
 */
@Service
public class S000015Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("S000015Mapper.getSearch", param);
	}
	
	//조회수 증가
	public LDataMap setHits(LDataMap param) throws Exception {
		dao.update("S000015Mapper.setHits", param);
		
		return param;
	}
	
	//삭제
	public LDataMap setDelete(LDataMap param) throws Exception {
		dao.delete("S000015Mapper.delNotice", param);
		dao.delete("S000015Mapper.delNoticeTarget", param);
		dao.delete("S000015Mapper.delNoticeFile", param);
		
		return param;
	}
}