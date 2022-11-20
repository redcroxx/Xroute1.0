package xrt.sys.s000050;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 프로그램관리 Biz
 */
@Service
public class S000050Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("S000050Mapper.getSearch", param);
	}

	//상세검색
	public LDataMap getDetail(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("S000050Mapper.getDetail", param);
	}

	//저장
	public LDataMap setSave(LDataMap param) throws Exception {
		int scnt = 0;

		if ("I".equals(param.get("IDUR")))
			scnt = dao.insert("S000050Mapper.insertMst", param);
		else
			scnt = dao.update("S000050Mapper.updateMst", param);

		param.put("SCNT", scnt);
		return param;
	}

	//삭제
	public LDataMap setDelete(LDataMap param) throws Exception {
		//프로그램 권한 삭제
		dao.delete("S000050Mapper.deleteAuthInfo", param);
		//프로그램 소메뉴 삭제
		dao.delete("S000050Mapper.deleteMenu3Info", param);
		//프로그램 삭제
		int scnt = dao.delete("S000050Mapper.deleteMst", param);

		param.put("SCNT", scnt);
		return param;
	}
}