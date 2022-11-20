package xrt.alexcloud.p000.p000025;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;


/**
 * 대입품목관리 Biz
 */
@Service
public class P000025Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000025Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P000025Mapper.getDetail", param);
	}
	
	//저장
	public LDataMap setSave(List<LDataMap> paramList) throws Exception {
		int scnt = 0, paramListSize = 0;
		String LOGIN_USERCD = LoginInfo.getUsercd();
		String LOGIN_IP = ClientInfo.getClntIP();
		
		if (paramList == null || paramList.size() == 0) {
			throw new LingoException("선택된 항목이 없습니다.");
		} else {
			paramListSize = paramList.size();
		}
		
		for (int i=0; i<paramListSize; i++) {
			LDataMap map = new LDataMap(paramList.get(i));
			map.put("LOGIN_USERCD", LOGIN_USERCD);
			map.put("LOGIN_IP", LOGIN_IP);
			
			//필수 값 유효성 검사
			if (Util.isEmpty(map.get("ORGCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n화주코드가 없습니다.");
			} else if (Util.isEmpty(map.get("MAP_PROD_CD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n대입코드가 없습니다.");
			} else if (Util.isEmpty(map.get("PROD_CD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n대입된코드가 없습니다.");
			}

			LDataMap detailData = (LDataMap) dao.selectOne("P000025Mapper.getChkProdCd", map);
			
			if ("I".equals(map.get("IDU"))) {
				if (detailData != null && !Util.isEmpty(detailData.get("MAP_PROD_CD"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n이미 존재하는  대입코드[" + map.get("MAP_PROD_CD") + "] 입니다.");
				}
				dao.insert("P000025Mapper.insertMst", map);
			} else if ("U".equals(map.get("IDU"))) {
				if (detailData == null || Util.isEmpty(detailData.get("MAP_PROD_CD"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n존재하지 않는 대입코드[" + map.get("MAP_PROD_CD") + "]입니다.");
				}
				dao.update("P000025Mapper.updateMst", map);
			}
		}

		LDataMap param = paramList.get(0);		
		return param;
	}
	
	//삭제
	public LDataMap setDelete(LDataMap param) throws Exception {
	
		//필수 값 유효성 검사
		if (Util.isEmpty(param.get("ORGCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n화주코드가 없습니다.");
		} else if (Util.isEmpty(param.get("MAP_PROD_CD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n대입코드가 없습니다.");
		} 
	
		dao.delete("P000025Mapper.deleteMst", param);
		
		return param;
	}
}
