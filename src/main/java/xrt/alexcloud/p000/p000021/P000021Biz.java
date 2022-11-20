package xrt.alexcloud.p000.p000021;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 회사별 품목속성
 */
@Service
public class P000021Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000021Mapper.getSearch", param);
	}

	//저장
	public LDataMap setSave(List<LDataMap> paramList) throws Exception {
		
		for(int i=0; i<paramList.size(); i++) {
			dao.update("P000021Mapper.updateMst", paramList.get(i));
		}
		return paramList.get(0);
	}
	
	//취소
	public LDataMap setDelete(LDataMap param) throws Exception {

		dao.update("P000021Mapper.deleteDet", param);

		return param;
	}
	
	//20171128 변수설정 from 데어터 가져오기
	//공통코드 값 가져오기
	@SuppressWarnings("unchecked")
	public List<LDataMap> getVariableCode(String code) throws Exception {
		LDataMap param = new LDataMap();
		param.put("ENV_CD", code);
		return dao.selectList("P000021Mapper.getVariableCode", param);
	}
}
