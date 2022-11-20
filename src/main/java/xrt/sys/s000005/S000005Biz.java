package xrt.sys.s000005;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
/**
 * 프로그램 Biz
 */
@Service
public class S000005Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("S000005Mapper.getSearch", param);
	}

	// 저장
	public LDataMap setSave(List<LDataMap> paramList) throws Exception {
		// 마스터 신규 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap map = paramList.get(i);
			map.put("LOGIN_USERCD", LoginInfo.getUsercd());
			map.put("LOGIN_IP", ClientInfo.getClntIP());

			if ("I".equals(map.get("IDU"))) {
				int compcdChk = (int) dao.selectOne("S000005Mapper.getAppChk", map);
				if (compcdChk == 1) {
					throw new LingoException("사용 중인 프로그램코드가 존재합니다.");
				}
				// 마스터 신규
				dao.insert("S000005Mapper.insertMst", map);

			} else if("U".equals(map.get("IDU"))) {
				// 마스터 수정
				dao.update("S000005Mapper.updateMst", map);
			}
		}
		LDataMap resultmap = new LDataMap(paramList.get(0));
		return resultmap;
	}

	//삭제
	public LDataMap setDelete(LDataMap param) throws Exception {

		// 마스터 삭제
		dao.delete("S000005Mapper.deleteMst", param);
		//소메뉴 삭제
		dao.delete("S000005Mapper.deleteMenu", param);
		//프로그램권한 삭제
		dao.delete("S000005Mapper.deleteAuth", param);

		return param;
	}
}
