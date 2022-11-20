package xrt.alexcloud.p100.p100200;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
/**
 * 입고 인터페이스 매핑 Biz
 */
@Service
public class P100200Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100200Mapper.getSearch", param);
	}

	//실행(실적처리)
	public LDataMap setExecute(List<LDataMap> paramList) throws Exception {

		int size = paramList.size();

		for (int i=0; i<size; i++) {
			LDataMap map = new LDataMap(paramList.get(i));

			map.put("LOGIN_USERCD", LoginInfo.getUsercd());
			map.put("LOGIN_IP", ClientInfo.getClntIP());

			// IF항목 UPDATE (P130) 입고 상세 테이블
			/* 기존 매핑방식 -> 체크 방식으로 변경, 사용 중지 2019. 04. 28
			 * dao.update("P100200Mapper.updateAtomy", map);*/

			//Atomy IF데이터 상태 UPDATE (INTF_ORDERSTOCK) 인터페이스 테이블
			dao.update("P100200Mapper.updateAtomyIF", map);

			//Atomy IF데이터 HISTORY UPDATE (INTF_ORDERSTOCK_101) 히스토리테이블
			dao.insert("P100200Mapper.insertAtomyIFHis", map);
		}


		LDataMap param = new LDataMap(paramList.get(0));
		return param;
	}

}
