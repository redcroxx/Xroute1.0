package xrt.sys.s000010;

import java.util.List;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;

import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.Constants;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;
/**
 * 사용자 관리 Biz
 */
@Service
public class S000010Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("S000010Mapper.getSearch", param);
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
			map.put("ENCKEY", Constants.ENCRYPTION_PW_KEY);

			//필수 값 유효성 검사
			if (Util.isEmpty(map.get("COMPCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n로그인 사용자의 회사코드가 없습니다.");
			} else if (Util.isEmpty(map.get("USERCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n사용자코드는 필수 입력값 입니다.");
			}

			LDataMap detailData = (LDataMap) dao.selectOne("S000010Mapper.getDetail", map);

			if ("I".equals(map.get("IDU"))) {
				if (detailData != null && !Util.isEmpty(detailData.get("USERCD"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n사용자코드[" + map.get("USERCD") + "]는 이미 존재하는 사용자코드 입니다.");
				} else if (!Pattern.matches("(^[a-zA-Z0-9_]{4,20}$)", map.getString("USERCD"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n사용자코드[" + map.get("USERCD") + "]는 4~20자의 영문자, 숫자, 특수기호(_)만 사용 가능합니다.");
				}

				scnt = dao.insert("S000010Mapper.insertMst", map);
				scnt = dao.insert("S000010Mapper.insertPrint", map);
				
				if (CommonConst.CENTER_USER.equals(map.get("USERGROUP"))) {
					scnt = dao.insert("S000010Mapper.insertScale", map);					
				}
			} else if ("U".equals(map.get("IDU"))) {
				if (detailData == null || Util.isEmpty(detailData.get("USERCD"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n사용자코드[" + map.get("USERCD") + "]는 존재하지 않는 사용자코드 입니다.");
				} else if ("N".equals(detailData.get("ISUSING"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n사용자코드[" + map.get("USERCD") + "]는 사용중지 되었습니다.");
				}

				scnt = dao.update("S000010Mapper.updateMst", map);
				scnt = dao.update("S000010Mapper.updatePrint", map);
				if (CommonConst.CENTER_USER.equals(detailData.get("USERGROUP"))) {
					scnt = dao.update("S000010Mapper.updateScale", map);					
				}
			}
		}

		LDataMap param = new LDataMap(paramList.get(0));
		param.put("SCNT", scnt);

		return param;
	}

	//삭제 (사용/미사용)
	public LDataMap setDelete(LDataMap param) throws Exception {
		int scnt = 0;
		//필수 값 유효성 검사
		if (Util.isEmpty(param.get("COMPCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드가 없습니다.");
		} else if (Util.isEmpty(param.get("USERCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n사용자코드가 없습니다.");
		}

		//미사용,사용 처리 분기
		if ("N".equals(param.get("ISUSING"))) {
			param.put("ISUSING", "Y");
		} else {
			param.put("ISUSING", "N");
		}
		scnt = dao.update("S000010Mapper.updateIsusing", param);

		param.put("SCNT", scnt);

		return param;
	}

	//비밀번호 초기화
	public LDataMap setPwInit(LDataMap param) throws Exception {
		int scnt = 0;
		//필수 값 유효성 검사
		if (Util.isEmpty(param.get("COMPCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드가 없습니다.");
		} else if (Util.isEmpty(param.get("USERCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n사용자코드가 없습니다.");
		}

		param.put("ENCKEY", Constants.ENCRYPTION_PW_KEY);

		scnt = dao.update("S000010Mapper.updatePassInit", param);

		//2017.11.06 비밀번호 초기화 시 로그인이력에 남기기
		//3개월간 로그인 안한 사용자에 대한 처리가 불가하기에 추가함
		param.put("HISTORYTYPE", "LOGIN");
		param.put("USERIP", ClientInfo.getClntIP());
		param.put("USERLOCALIP", ClientInfo.getClntLocalIP());
		param.put("USEROS", ClientInfo.getClntOsInfo());
		param.put("USERBROWSER", ClientInfo.getClntWebKind());
		scnt = dao.insert("S000010Mapper.insertLoginHistory", param);
		
		param.put("SCNT", scnt);

		return param;
	}
}
