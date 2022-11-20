package xrt.alexcloud.p000.boxsize;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;
/**
 * 박스 관리 Biz
 */
@Service
public class BOXSIZEBiz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("BOXSIZEMapper.getSearch", param);
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

			LDataMap detailData = (LDataMap) dao.selectOne("BOXSIZEMapper.getDetail", map);

			if ("I".equals(map.get("IDU"))) {
				if (detailData != null && !Util.isEmpty(detailData.get("BOX_ID"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n박스ID[" + map.get("BOX_ID") + "]는 이미 존재하는 박스ID 입니다.");
				}

				scnt = dao.insert("BOXSIZEMapper.insertMst", map);
			} else if ("U".equals(map.get("IDU"))) {
				if (detailData == null || Util.isEmpty(detailData.get("BOX_ID"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n박스ID[" + map.get("BOX_ID") + "]는 존재하지 않는 박스ID 입니다.");
				}

				scnt = dao.update("BOXSIZEMapper.updateMst", map);
			}
		}

		LDataMap param = paramList.get(0);
		param.put("SCNT", scnt);

		return param;
	}

	//삭제
	public LDataMap setDelete(LDataMap param) throws Exception {
		int scnt = 0;

		scnt = dao.update("BOXSIZEMapper.deleteMst", param);

		param.put("SCNT", scnt);

		return param;
	}
}
