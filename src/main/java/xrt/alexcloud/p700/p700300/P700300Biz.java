package xrt.alexcloud.p700.p700300;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

/**
 * 로케이션변경 - 로케이션변경 - 마스터,디테일  RealGrid -> 총 2개 (장바구니 형태) Biz
 */
@Service
public class P700300Biz extends DefaultBiz {
	
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception{
		param.put("S_COMPCD",LoginInfo.getCompcd());
		return dao.select("P700300Mapper.getSearch", param);
	}
	//실행
	public LDataMap setExecute(List<LDataMap> paramList) throws Exception {
		LDataMap param = new LDataMap(paramList.get(0));
		
		param.put("IMKEY", dao.getKey("INVENTORY_MOVEMENT"));
		param.put("M_REMARK", "로케이션 즉시 변경"); //P710 전표비고
		param.put("LOGIN_USERCD", LoginInfo.getUsercd());
		param.put("LOGIN_IP", ClientInfo.getClntIP());
		
		dao.insert("P700300Mapper.insertMst", param);
		
		for (int i=0; i<paramList.size(); i++ ) {
			LDataMap paramData = new LDataMap(paramList.get(i));
			
			paramData.put("IMKEY", param.get("IMKEY"));
			paramData.put("LOGIN_USERCD", LoginInfo.getUsercd());
			paramData.put("LOGIN_IP", ClientInfo.getClntIP());
			
			if("I".equals(paramData.getString("IDU"))) {
				dao.insert("P700300Mapper.insertDet", paramData);
			}
		}
		
		//재고이동 프로시져 호출
		dao.update("P700300Mapper.setExecute", param);

		if(!"1".equals(param.getString("MSGID"))){
			throw new LingoException(param.getString("MSG"));
		}

		return param;
	}
}
