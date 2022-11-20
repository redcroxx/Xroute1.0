package xrt.alexcloud.p000.p000009;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;
/**
 * 품목별로케이션 관리 Biz
 */
@Service
public class P000009Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000009Mapper.getSearch", param);
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
			if (Util.isEmpty(map.get("COMPCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드가 없습니다.");
			} else if (Util.isEmpty(map.get("WHCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드가 없습니다.");
			} else if (Util.isEmpty(map.get("ITEMCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n품목코드가 없습니다.");
			}

			LDataMap detailData = (LDataMap) dao.selectOne("P000009Mapper.getDetail", map);
			
			if (detailData != null && !Util.isEmpty(detailData.get("ITEMCD"))) {
				scnt = dao.update("P000009Mapper.updateMst", map);
			} else {
				scnt = dao.insert("P000009Mapper.insertMst", map);
			}
		}

		LDataMap param = paramList.get(0);
		param.put("SCNT", scnt);
		
		return param;
	}
	
	//삭제
	public LDataMap setDelete(List<LDataMap> paramList) throws Exception {
		int scnt = 0, paramListSize = 0;
		
		if (paramList == null || paramList.size() == 0) {
			throw new LingoException("선택된 항목이 없습니다.");
		} else {
			paramListSize = paramList.size();
		}
		
		for (int i=0; i<paramListSize; i++) {
			LDataMap map = new LDataMap(paramList.get(i));
		
			//필수 값 유효성 검사
			if (Util.isEmpty(map.get("COMPCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드가 없습니다.");
			} else if (Util.isEmpty(map.get("WHCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드가 없습니다.");
			} else if (Util.isEmpty(map.get("ITEMCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n품목코드가 없습니다.");
			}
		
			scnt = dao.delete("P000009Mapper.deleteMst", map);
		}
		
		LDataMap param = paramList.get(0);
		param.put("SCNT", scnt);
		
		return param;
	}
}