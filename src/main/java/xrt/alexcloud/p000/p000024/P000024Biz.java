package xrt.alexcloud.p000.p000024;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;


/**
 * 창고별 피킹렉 Biz
 */
@Service
public class P000024Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000024Mapper.getSearch", param);
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
			} else if (Util.isEmpty(map.get("WHCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드가 없습니다.");
			} else if (Util.isEmpty(map.get("ITEMCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n품목코드가 없습니다.");
			}

			LDataMap detailData = (LDataMap) dao.selectOne("P000024Mapper.getChkRack", map);
			
			if (detailData != null && !Util.isEmpty(detailData.get("ITEMCD"))) {
				dao.update("P000024Mapper.updateMst", map);
			} else {
				dao.insert("P000024Mapper.insertMst", map);
			}
		}

		LDataMap param = paramList.get(0);
		
		return param;
	}
	
	//삭제
	public LDataMap setDelete(List<LDataMap> paramList) throws Exception {
		int scnt = 0, size = 0;
		
		if (paramList == null || paramList.size() == 0) {
			throw new LingoException("선택된 항목이 없습니다.");
		} else {
			size = paramList.size();
		}
		
		for (int i=0; i<size; i++) {
			LDataMap map = new LDataMap(paramList.get(i));
		
			//필수 값 유효성 검사
			if (Util.isEmpty(map.get("ORGCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n화주코드가 없습니다.");
			} else if (Util.isEmpty(map.get("WHCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드가 없습니다.");
			} else if (Util.isEmpty(map.get("ITEMCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n품목코드가 없습니다.");
			}
		
			dao.delete("P000024Mapper.deleteMst", map);
		}
		
		LDataMap param = paramList.get(0);		
		return param;
	}
}
