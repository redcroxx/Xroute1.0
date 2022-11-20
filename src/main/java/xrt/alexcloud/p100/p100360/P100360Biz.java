package xrt.alexcloud.p100.p100360;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;
/**
 * 입고지시취소 Biz
 */
@Service
public class P100360Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100360Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100360Mapper.getDetail", param);
	}
	
	//실행(입고지시취소)
	public LDataMap setCancel(List<LDataMap> paramList) throws Exception {
		int size = paramList.size();
		for (int i=0; i<size; i++){
			LDataMap map = new LDataMap(paramList.get(i));
			map.put("LOGIN_USERCD", LoginInfo.getUsercd());
			map.put("LOGIN_IP", ClientInfo.getClntIP());
			
			//LOCK
			dao.update("P100360Mapper.updateWDLock", map);
			
			//입고전표 상태 체크
			String sts = dao.getStatus("P130", map.getString("WIKEY"));
			String WDKEY = Util.ifEmpty(map.getString("WDKEY"));
			String WIKEY = Util.ifEmpty(map.getString("WIKEY"));
			
			if(!sts.equals("200")) { 
				throw new LingoException("지시완료 상태 일 때만 처리할 수 있습니다. 입고지시번호 [" + WDKEY + "] 입고번호[" + WIKEY + "]");
			}

			//입고마스터 상태, 입고일자, 입고지시번호 update
			dao.update("P100360Mapper.updateWiChange", map);
			
			//입고지시전표 삭제여부 체크
			int delChk = (int) dao.selectOne("P100360Mapper.getWdDelChk", map);
						
			if(delChk == 0){
				//입고지시전표 삭제
				dao.delete("P100360Mapper.deleteWD", map);
			}
			
		}
	
		
		return null;
	}
}

