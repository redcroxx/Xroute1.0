package xrt.alexcloud.popup;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 공지사항 팝업 Biz
 */
@Service
public class PopS014Biz extends DefaultBiz {
	//내용 검색
	public LDataMap getSearch(LDataMap param) throws Exception {		
		return (LDataMap) dao.selectOne("PopS014Mapper.getSearch", param);
	}
	
	//첨부파일 리스트 가져오기
	public List<LDataMap> getFile(LDataMap param) throws Exception {
		return dao.select("PopS014Mapper.getFile", param);
	}
}