package xrt.alexcloud.popup;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 품목(복합,단품)코드 팝업 Biz
 */
@Service
public class PopP025Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch1(LDataMap param) throws Exception {
		return dao.select("PopP025Mapper.getSearch1", param);
	}
	
	//상세검색
	public List<LDataMap> getSearch2(LDataMap param) throws Exception {
		return dao.select("PopP025Mapper.getSearch2", param);
	}
	
	//코드 유효성 검사
	public List<LDataMap> getCheck(LDataMap param) throws Exception {
		return dao.select("PopP025Mapper.getCheck", param);
	}
}