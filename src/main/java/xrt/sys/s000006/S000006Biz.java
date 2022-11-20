package xrt.sys.s000006;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
/**
 * 권한 Biz
 */
@Service
public class S000006Biz extends DefaultBiz {

	//대메뉴 코드 가져오기
	public List<LDataMap> getMenuL1(String code) throws Exception {
		LDataMap map = new LDataMap();
		map.put("S_COMPCD", LoginInfo.getCompcd());
		System.out.println(map);

		return dao.select("S000006Mapper.getMenuL1", map);
	}

	//검색 - 사용자 리스트
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("S000006Mapper.getSearch", param);
	}

	//검색 - 전체메뉴 리스트
	public List<LDataMap> getMenuList(LDataMap param) throws Exception {
		return dao.select("S000006Mapper.getMenuList", param);
	}

	//사용자별 권한 검색
	public List<LDataMap> getAuthList(LDataMap param) throws Exception {
		return dao.select("S000006Mapper.getAuthList", param);
	}

	//권한 추가
	public LDataMap setAuth(LDataMap param, List<LDataMap> paramList) throws Exception {
		int size = paramList.size();
		for (int i = 0; i < size; i++) {
			LDataMap paramData = new LDataMap(paramList.get(i));
			if(paramData.get("APPKEY") != null){
				paramData.put("COMPCD", param.get("COMPCD"));
				paramData.put("USERCD", param.get("USERCD"));
				paramData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
				paramData.put("LOGIN_IP", param.get("LOGIN_IP"));

				dao.update("S000006Mapper.setAuth", paramData);
			}
		}
		return param;
	}

	//권한 삭제
	public LDataMap deleteAuth(LDataMap param, List<LDataMap> paramList) throws Exception {

		int size = paramList.size();
		for (int i = 0; i < size; i++) {
			LDataMap paramData = new LDataMap(paramList.get(i));
			paramData.put("COMPCD", param.get("COMPCD"));
			paramData.put("USERCD", param.get("USERCD"));

			dao.delete("S000006Mapper.delAuth", paramData);
		}
		return param;
	}

	// 권한 버튼 저장
	public int updateAuthSearch(List<LDataMap> paramList) throws Exception {
		LDataMap param = new LDataMap();
		param.put("LOGIN_USERCD", LoginInfo.getUsercd());
		param.put("LOGIN_IP", ClientInfo.getClntIP());
		param.put("paramList", paramList);

		return dao.update("S000006Mapper.updateAuthSearch", param);
	}

	// 권한 버튼 저장
	public int saveUserXAuthDtAuth(List<LDataMap> paramList) throws Exception {
		LDataMap param = new LDataMap();
		param.put("LOGIN_USERCD", LoginInfo.getUsercd());
		param.put("LOGIN_IP", ClientInfo.getClntIP());
		param.put("paramList", paramList);

		return dao.update("S000006Mapper.updateUserXAuthDtAuth", param);
	}

	//권한 복사
	public void insertCopyAuth(LDataMap param, List<LDataMap> paramList) throws Exception {

		int size = paramList.size();
		String usercd = param.getString("USERCD");

		for (int i = 0; i < size; i++) {
			LDataMap paramData = new LDataMap(paramList.get(i));

			if(!usercd.equals(paramData.getString("USERCD"))) {
				paramData.put("O_COMPCD", param.get("COMPCD"));
				paramData.put("O_USERCD", param.get("USERCD"));
				paramData.put("LOGIN_USERCD", LoginInfo.getUsercd());
				paramData.put("LOGIN_IP", ClientInfo.getClntIP());

				dao.delete("S000006Mapper.delBeforeAuth", paramData);
				dao.insert("S000006Mapper.copyAuth", paramData);
			}
		}
	}
}
