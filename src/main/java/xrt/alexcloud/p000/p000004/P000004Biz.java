package xrt.alexcloud.p000.p000004;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;
/**
 * 창고 관리 Biz
 */
@Service
public class P000004Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000004Mapper.getSearch", param);
	}

	//저장
	public LDataMap setSave(List<LDataMap> paramList) throws Exception {
		int scnt = 0, paramListSize = 0;
		String LOGIN_USERCD = LoginInfo.getUsercd();
		String LOGIN_IP = ClientInfo.getClntIP();

		if (paramList == null || paramList.size() == 0) {
			throw new LingoException("변경된 항목이 없습니다.");
		} else {
			paramListSize = paramList.size();
		}

		for (int i=0; i<paramListSize; i++) {
			LDataMap map = new LDataMap(paramList.get(i));
			map.put("LOGIN_USERCD", LOGIN_USERCD);
			map.put("LOGIN_IP", LOGIN_IP);

			//필수 값 유효성 검사
			if (Util.isEmpty(map.get("COMPCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드는 필수 입력값 입니다.");
			} else if (Util.isEmpty(map.get("WHCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드는 필수 입력값 입니다.");
			} else if (Util.isEmpty(map.get("NAME"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n창고명은 필수 입력값 입니다.");
			}

			LDataMap detailData = (LDataMap) dao.selectOne("P000004Mapper.getDetail", map);

			if ("I".equals(map.get("IDU"))) {
				if (detailData != null && !Util.isEmpty(detailData.get("WHCD"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드[" + map.get("WHCD") + "]는 이미 존재하는 창고코드 입니다.");
				}

				scnt = dao.insert("P000004Mapper.insertMst", map);
			} else if ("U".equals(map.get("IDU"))) {
				if (detailData == null || Util.isEmpty(detailData.get("WHCD"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드[" + map.get("WHCD") + "]는 존재하지 않는 창고입니다.");
				} else if ("N".equals(detailData.get("ISUSING"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드[" + map.get("WHCD") + "]는 사용중지 되었습니다.");
				}

				scnt = dao.update("P000004Mapper.updateMst", map);
			}
		}

		LDataMap param = paramList.get(0);
		param.put("SCNT", scnt);

		return param;
	}

	//삭제 (사용/미사용)
	public LDataMap setDelete(LDataMap param) throws Exception {
		int scnt = 0;
		//필수 값 유효성 검사
		if (Util.isEmpty(param.get("COMPCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드가 없습니다.");
		} else if (Util.isEmpty(param.get("WHCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드가 없습니다.");
		}

		//미사용,사용 처리 분기
		if ("N".equals(param.get("ISUSING"))) {
			param.put("ISUSING", "Y");
		} else {
			param.put("ISUSING", "N");
		}
		scnt = dao.update("P000004Mapper.updateIsusing", param);

		param.put("SCNT", scnt);

		return param;
	}
}
