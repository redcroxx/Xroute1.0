package xrt.alexcloud.p000.p000000;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
/**
 * 회사 - 마스터 패턴 Biz
 */
@Service
public class P000000Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000001Mapper.getSearch", param);
	}

	// 저장
	public LDataMap setSave(List<LDataMap> paramList) throws Exception {
		// 마스터 신규 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap map = paramList.get(i);
			map.put("LOGIN_USERCD", LoginInfo.getUsercd());
			map.put("LOGIN_IP", ClientInfo.getClntIP());

			if ("I".equals(map.get("IDU"))) {
				int compcdChk = (int) dao.selectOne("P000001Mapper.getCompChk", map);
				if (compcdChk == 1) {
					throw new LingoException("사용 중인 회사코드가 존재합니다.");
				}
				// 마스터 신규
				dao.insert("P000001Mapper.insertMst", map);

				// 회사코드 신규 등록시 기본 공통코드 세팅 처리
				dao.select("P000001Mapper.setNewComp", map);
				if(!"1".equals(map.getString("MSGID"))){
					throw new LingoException(map.getString("MSG"));
				}

			} else if("U".equals(map.get("IDU"))) {
				// 마스터 수정
				dao.update("P000001Mapper.updateMst", map);
			}
		}
		LDataMap resultmap = new LDataMap(paramList.get(0));
		return resultmap;
	}

	//삭제
	public LDataMap setDelete(LDataMap param) throws Exception {

		String isusingChk = (String) dao.selectOne("P000001Mapper.getIsusingChk", param);
		// 미사용 처리
		// 변경처리건이 Y
		if ("Y".equals(param.getString("ISUSING"))){
			if(isusingChk.equals("N")){
				throw new LingoException("이미 미사용처리 되어 있습니다.");
			}
			param.put("ISUSING", "N");
		} else {
			if(isusingChk.equals("Y")){
				throw new LingoException("이미 사용처리 되어 있습니다.");
			}
			param.put("ISUSING", "Y");
		}
		//회사 사용여부 N으로 변경
		dao.update("P000001Mapper.updateMstSts", param);

		return param;
	}
}
