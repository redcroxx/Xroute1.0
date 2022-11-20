package xrt.alexcloud.p100.p100340;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 입고등록 - 마스터 디테일 그리드 2개 패턴 Biz
 */
@Service
public class P100340Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100340Mapper.getSearch", param);
	}

	//입고상세
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100340Mapper.getDetailList", param);
	}

	//실적상세
	public List<LDataMap> getDetailList2(LDataMap param) throws Exception {
		return dao.select("P100340Mapper.getDetailList2", param);
	}

	/**
	 *  입고예정처리
	 */
	public void setExecute(LDataMap param, List<LDataMap> paramList) throws Exception {
		for (int i=0; i<paramList.size(); i++) {
			// 상태값 체크
			LDataMap exeData = new LDataMap(paramList.get(i));
			exeData.put("MSGID", "");
			exeData.put("MSG", "");
			exeData.put("LOGIN_USERCD", param.getString("LOGIN_USERCD"));
			exeData.put("LOGIN_IP", param.getString("LOGIN_IP"));

			dao.select("P100340Mapper.setExecute", exeData);

			if(!"1".equals(exeData.getString("MSGID"))){
				throw new LingoException(exeData.getString("MSG"));
			}
		}
	}

	/**
	 *  입고취소
	 *  - 입고예정처리 이후 입고전표를 취소처리함
	 */
	public void setCancel(LDataMap param, List<LDataMap> paramList) throws Exception {
		for (int i=0; i<paramList.size(); i++) {
			// 상태값 체크
			LDataMap exeData = new LDataMap(paramList.get(i));
			exeData.put("MSGID", "");
			exeData.put("MSG", "");
			exeData.put("LOGIN_USERCD", param.getString("LOGIN_USERCD"));
			exeData.put("LOGIN_IP", param.getString("LOGIN_IP"));

			dao.select("P100340Mapper.setExecute", exeData);

			if(!"1".equals(exeData.getString("MSGID"))){
				throw new LingoException(exeData.getString("MSG"));
			}

			dao.update("P100340Mapper.setCancel", exeData);

			/* 인터페이스 입고 매핑->확정 처리 방식 변경으로 인한 사용 x
			 * List<LDataMap> resultList = new ArrayList<LDataMap>();
			resultList = dao.select("P100340Mapper.getDetailList", exeData);
			for (int j=0; j<resultList.size(); j++) {
				LDataMap map = new LDataMap(resultList.get(j));
				if(map.get("IFORDERNO") != null && !map.get("IFORDERNO").equals("")){
					map.put("LOGIN_USERCD", param.getString("LOGIN_USERCD"));
					map.put("LOGIN_IP", param.getString("LOGIN_IP"));
					dao.update("P100340Mapper.updateAtomyFlgN", map);
				}
			}*/
		}
	}
}
