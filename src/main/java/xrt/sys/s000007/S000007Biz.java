package xrt.sys.s000007;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class S000007Biz extends DefaultBiz {

	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("S000007Mapper.getSearch", param);
	}

	//저장
	public LDataMap setSave(List<LDataMap> paramList) throws Exception {

		//마스터 신규 저장 처리
		for (int i=0; i<paramList.size(); i++) {
			LDataMap map = paramList.get(i);
			map.put("LOGIN_USERCD", LoginInfo.getUsercd());
			map.put("LOGIN_IP", ClientInfo.getClntIP());

			if ("I".equals(map.getString("IDU"))) {
				int orgcdChk = (int) dao.selectOne("S000007Mapper.orgcdChk", map);
				if ( orgcdChk == 1) {
					throw new LingoException("사용 중인 메뉴코드가 존재합니다.");
				}

				dao.insert("S000007Mapper.insertMst", map);
			} else if ("U".equals(map.getString("IDU"))) {
				dao.update("S000007Mapper.updateMst", map);
			}
		}
		LDataMap resultmap= new LDataMap(paramList.get(0));
		return resultmap;
	}

	//삭제
	public LDataMap setDelete(LDataMap param) throws Exception {
		dao.delete("S000007Mapper.deleteMst", param);
		return param;
	}
}