package xrt.alexcloud.p000.p000027;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;


/**
 * 매입처별 품목관리 Biz
 */
@Service
public class P000027Biz extends DefaultBiz {
	//검색 매입처 목록
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000027Mapper.getSearch", param);
	}

	//검색 매입처 미지정 품목
	public List<LDataMap> getSearch2(LDataMap param) throws Exception {
		return dao.select("P000027Mapper.getSearch2", param);
	}

	//품목 디테일리스트 검색
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P000027Mapper.getDetailList", param);
	}


	//수정(미지정 품목 -> 품목 지정)
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {
		for(int i = 0; i < paramList.size(); i++){
			LDataMap paramData = new LDataMap(paramList.get(i));

			paramData.put("LOGIN_USERCD", LoginInfo.getUsercd());
			paramData.put("LOGIN_IP", ClientInfo.getClntIP());
			paramData.put("CUSTCD", param.get("CUSTCD"));
			paramData.put("COMPCD", param.get("COMPCD"));
			paramData.put("ORGCD", param.get("ORGCD"));

			dao.update("P000027Mapper.updateITEM", paramData);
		}

		return param;
	}

	//수정(품목 지정 -> 미지정 품목 )
	public LDataMap setDelete(LDataMap mgParamData, LDataMap dGParamData) throws Exception {
		dGParamData.put("LOGIN_USERCD", LoginInfo.getUsercd());
		dGParamData.put("LOGIN_IP", ClientInfo.getClntIP());
		dGParamData.put("ORGCD", mgParamData.get("ORGCD"));
		dGParamData.put("CUSTCD", mgParamData.get("CUSTCD"));
		dGParamData.put("CUSTNM", mgParamData.get("CUSTNM"));
		dGParamData.put("COMPCD", mgParamData.get("COMPCD"));

		dao.update("P000027Mapper.deleteITEM", dGParamData);

		return dGParamData;
	}
}
