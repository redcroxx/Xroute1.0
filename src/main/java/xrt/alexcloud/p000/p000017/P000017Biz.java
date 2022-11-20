package xrt.alexcloud.p000.p000017;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;
/**
 * 품목분류 관리 Biz
 */
@Service
public class P000017Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000017Mapper.getSearch", param);
	}
	
	//상세 검색
	public LDataMap getDetail(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("P000017Mapper.getDetail", param);
	}

	//분류별 품목 검색
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P000017Mapper.getDetailList", param);
	}

	//저장
	public LDataMap setSave(LDataMap param) throws Exception {
		int scnt = 0;
		//필수 값 유효성 검사
		if (Util.isEmpty(param.get("COMPCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드가 없는 분류는 저장할 수 없습니다.");
		} else if (Util.isEmpty(param.get("CATEGORYCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n분류코드는 필수 입력값 입니다.");
		} else if (Util.isEmpty(param.get("NAME"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n분류명은 필수 입력값 입니다.");
		} else if (!Util.isInteger(param.get("SORTNO"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n정렬순서는 숫자만 입력 가능합니다.");
		}
		
		LDataMap map = this.getDetail(param);
		
		if ("I".equals(param.get("IDU"))) {
			if (map != null) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n이미 존재하는 분류코드 입니다.");
			} else if (param.getInt("LVL") > 3) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n하위 분류 생성은 3단계까지만 가능합니다.");
			}
			
			scnt = dao.insert("P000017Mapper.insertMst", param);
		} else if ("U".equals(param.get("IDU"))) {
			if (map == null) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n존재하지 않는 분류입니다.");
			}
			
			scnt = dao.update("P000017Mapper.updateMst", param);
		}
		
		param.put("SCNT", scnt);
		
		return param;
	}

	//삭제
	public void setDelete(List<LDataMap> paramList) throws Exception {
		String LOGIN_USERCD = LoginInfo.getUsercd();
		String LOGIN_IP = ClientInfo.getClntIP();
		
		if (paramList != null) {
			for (int i=0; i<paramList.size(); i++) {
				LDataMap map = new LDataMap(paramList.get(i));
				
				List<LDataMap> list = this.getDetailList(map);
				
				if (list != null && list.size() > 0) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n분류코드 [" + map.getString("CATEGORYCD") + "] 에 품목이 존재하여 삭제가 불가능 합니다.");
				}
				
				map.put("LOGIN_USERCD", LOGIN_USERCD);
				map.put("LOGIN_IP", LOGIN_IP);
				
				dao.delete("P000017Mapper.deleteMst", map);
			}
		}
	}
}
