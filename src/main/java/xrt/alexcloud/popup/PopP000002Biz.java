package xrt.alexcloud.popup;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 사업자등록증 수정 팝업 Biz
 */
@Service
public class PopP000002Biz extends DefaultBiz {
	//검색
	public LDataMap getSearch(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("PopP000002Mapper.getSearch", param);
	}
	
	//수정
	public LDataMap setSave(LDataMap param) throws Exception {
		dao.insert("PopP000002Mapper.updateMst", param);
		return param;
	}
}