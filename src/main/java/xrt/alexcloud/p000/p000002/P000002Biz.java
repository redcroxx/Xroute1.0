package xrt.alexcloud.p000.p000002;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class P000002Biz extends DefaultBiz{

	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000002Mapper.getSearch", param);
	}

	//저장
	public LDataMap setSave(List<LDataMap> paramList) throws Exception {

		//마스터 신규 저장 처리
		for (int i=0; i<paramList.size(); i++) {
			LDataMap map = paramList.get(i);
			map.put("LOGIN_USERCD", LoginInfo.getUsercd());
			map.put("LOGIN_IP", ClientInfo.getClntIP());

			if ("I".equals(map.getString("IDU"))) {
				int orgcdChk = (int) dao.selectOne("P000002Mapper.orgcdChk", map);
				int compcdChk = (int) dao.selectOne("P000001Mapper.getCompChk", map);
				if ( orgcdChk == 1) {
					throw new LingoException("사용 중인 셀러코드["+map.getString("ORGCD")+"]가 존재합니다.");
				}
				if (compcdChk == 0) {
					throw new LingoException("회사코드["+map.getString("COMPCD")+"]가 존재하지 않습니다.");
				}
				dao.insert("P000002Mapper.insertMst", map);

			} else if ("U".equals(map.getString("IDU"))) {

				dao.update("P000002Mapper.updateMst", map);
			}
		}
		LDataMap resultmap= new LDataMap(paramList.get(0));
		return resultmap;
	}

	//삭제
	public LDataMap setDelete(LDataMap param) throws Exception {

		String isusingChk = (String) dao.selectOne("P000002Mapper.getIsusingChk", param);
		// 미사용 처리
		// 변경처리건이 Y
		if ("Y".equals(param.getString("ISUSING"))){
			if(isusingChk.equals("N")){
				throw new LingoException("이미 미사용처리 되어 있습니다.");
			}
			//회사 사용여부 N으로 변경
			param.put("ISUSING", "N");
		} else {
			if(isusingChk.equals("Y")){
				throw new LingoException("이미 사용처리 되어 있습니다.");
			}
			//회사 사용여부 Y으로 변경
			param.put("ISUSING", "Y");
		}
		dao.update("P000002Mapper.updateMstSts", param);

		return param;
	}
}
