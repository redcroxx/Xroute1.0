package xrt.sys.popup;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.Util;
/**
 * 사용자 프린터 정보 변경 팝업 Biz
 */
@Service
public class PopPrintBiz extends DefaultBiz {
	//검색
	public LDataMap getSearch(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("PopPrintMapper.getSearch", param);
	}

	//프린터 정보 변경 처리
	public LDataMap setSave(LDataMap param) throws Exception {
		int scnt = 0;
		String LOGIN_IP = ClientInfo.getClntIP();
		
		param.put("LOGIN_IP", LOGIN_IP);

		//필수 값 유효성 검사
		if (Util.isEmpty(param.get("COMPCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드가 없습니다.");
		} else if (Util.isEmpty(param.get("USERCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n사용자코드가 없습니다.");
		}

		if ("I".equals(param.get("IDU"))) {
			scnt = dao.update("PopPrintMapper.insertPrint", param);
		}else if("U".equals(param.get("IDU"))) {
			scnt = dao.update("PopPrintMapper.updatePrint", param);
		}
		
		param.put("SCNT", scnt);
		return param;
	}
}