package xrt.alexcloud.p700.p700400;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

/**
 * 로트속성변경 - RealGrid 마스터 디테일 그리드 2개 패턴 Biz
 */
@Service
public class P700400Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P700400Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P700400Mapper.getDetailList", param);
	}

	//확정
	public LDataMap setExecute(LDataMap param, List<LDataMap> paramList) throws Exception {
		//키가 있는지 확인
		String sts = dao.getStatus("P740", param.getString("CLKEY"));

		if(!sts.equals("1")) { //신규전표인지 확인
			throw new LingoException("신규 전표만 확정가능합니다. 재조회하시기 바랍니다.");
		}

		//마스터 신규 저장 처리
		if ("I".equals(param.get("IDU"))) {
			//마스터 채번
			param.put("CLKEY", dao.getKey("CHANGE_LOT"));
          
			//마스터 신규
			dao.insert("P700400Mapper.insertMst", param);
		}

		//디테일 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
        	LDataMap detailData = new LDataMap(paramList.get(i));

        	detailData.put("CLKEY", param.get("CLKEY"));
        	detailData.put("COMPCD", param.get("COMPCD"));
        	detailData.put("ORGCD", param.get("ORGCD"));
        	detailData.put("WHCD", param.get("WHCD"));
        	detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
        	detailData.put("LOGIN_IP", param.get("LOGIN_IP"));

        	if ("I".equals(detailData.getString("IDU"))) {
				dao.insert("P700400Mapper.insertDet", detailData);
			}
		}

		//프로시져 호출
		dao.update("P700400Mapper.setExecute", param);

		if(!"1".equals(param.getString("MSGID"))){
			throw new LingoException(param.getString("MSG"));
		}

		return param;
	}
}
