package xrt.alexcloud.p000.p000006;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;


/**
 * 품목 관리 Biz
 */
@Service
public class P000006Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000006Mapper.getSearch", param);
	}
	
	// 품목 바코드 검색
	public List<LDataMap> getSearchBarcode(LDataMap param) throws Exception {
		return dao.select("P000006Mapper.getSearchBarcode", param);
	}

	// 대입코드 검색
	public List<LDataMap> getSearchCItem(LDataMap param) throws Exception {
		return dao.select("P000006Mapper.getSearchCItem", param);
	}

	//저장
	public LDataMap setSave(List<LDataMap> paramList, List<LDataMap> barList, List<LDataMap> cItemList) throws Exception {
		int scnt = 0, paramListSize = 0;
		String LOGIN_USERCD = LoginInfo.getUsercd();
		String LOGIN_IP = ClientInfo.getClntIP();

		if (paramList != null && paramList.size() > 0) {
			paramListSize = paramList.size();
		}
		
		// 단품정보 저장
		for (int i=0; i<paramListSize; i++) {
			LDataMap map = new LDataMap(paramList.get(i));
			map.put("LOGIN_USERCD", LOGIN_USERCD);
			map.put("LOGIN_IP", LOGIN_IP);

			//필수 값 유효성 검사
			if (Util.isEmpty(map.get("COMPCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드는 필수 입력값 입니다.");
			} else if (Util.isEmpty(map.get("ITEMCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n품목코드는 필수 입력값 입니다.");
			} else if (Util.isEmpty(map.get("NAME"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n품목명은 필수 입력값 입니다.");
			}

			LDataMap detailData = (LDataMap) dao.selectOne("P000006Mapper.getDetail", map);

			// 신규저장
			if ("I".equals(map.get("IDU"))) {
				if (detailData != null && !Util.isEmpty(detailData.get("MAP_PROD_CD"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n품목코드[" + map.get("ITEMCD") + "]는 이미 사용중인 품목코드 입니다.");
				}

				map.put("MAP_PROD_CD", map.get("ITEMCD")); // 단품
				map.put("PROD_TYPE_CD", "00001"); // 단품
				scnt = dao.insert("P000006Mapper.insertMst", map);
				scnt = dao.insert("P000006Mapper.insertPRODUCTMAP", map);
				scnt = dao.insert("P000006Mapper.insertPRODUCT", map);
				scnt = dao.insert("P000006Mapper.insertPRODSPROD", map);

				Date date = new Date();
				SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd");

				//거래처코드
				map.put("CUSTCD", "*");
				map.put("STARTDT", today.format(date));
				map.put("ENDDT", "99991231");

				//매입단가 등록 넣기
				dao.select("P000012Mapper.updateCost", map);
				if(!"1".equals(map.getString("MSGID"))){
					throw new LingoException(map.getString("MSG"));
				}

				//판매단가 등록 넣기
				dao.select("P000011Mapper.updatePrice", map);
				if(!"1".equals(map.getString("MSGID"))){
					throw new LingoException(map.getString("MSG"));
				}

			} else if ("U".equals(map.get("IDU"))) {
				if (detailData == null || Util.isEmpty(detailData.get("ITEMCD"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n품목코드[" + map.get("ITEMCD") + "]는 존재하지 않는 품목입니다.");
				} else if ("N".equals(detailData.get("ISUSING"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n품목코드[" + map.get("ITEMCD") + "]는 사용중지 되었습니다.");
				}

				scnt = dao.update("P000006Mapper.updateMst", map);
				scnt = dao.update("P000006Mapper.updatePRODUCT", map);
			}
		}
		
		// 바코드 정보 저장
		paramListSize = 0;
		if (barList != null && barList.size() > 0) {
			paramListSize = barList.size();
		}
		
		for (int i=0; i<paramListSize; i++) {
			LDataMap map = new LDataMap(barList.get(i));
			map.put("LOGIN_USERCD", LOGIN_USERCD);
			map.put("LOGIN_IP", LOGIN_IP);

			LDataMap detailData = (LDataMap) dao.selectOne("P000006Mapper.getBarDetail", map);

			// 신규저장
			if ("I".equals(map.get("IDU"))) {
				if (detailData != null && !Util.isEmpty(detailData.get("BARCODE"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n 바코드[" + map.get("BARCODE") + "]는 이미 사용중인 바코드 입니다.");
				}
				scnt = dao.insert("P000006Mapper.insertSPRODBARCODE", map);
			} else if ("U".equals(map.get("IDU"))) {
				scnt = dao.update("P000006Mapper.updateSPRODBARCODE", map);
			} else if ("D".equals(map.get("IDU"))) { // 수정은 없음
				scnt = dao.update("P000006Mapper.deleteSPRODBARCODE", map);
			}
		}
			
		// 대입코드 정보 저장
		paramListSize = 0;
		if (cItemList != null && cItemList.size() > 0) {
			paramListSize = cItemList.size();
		}
		
		for (int i=0; i<paramListSize; i++) {
			LDataMap map = new LDataMap(cItemList.get(i));
			map.put("LOGIN_USERCD", LOGIN_USERCD);
			map.put("LOGIN_IP", LOGIN_IP);

			LDataMap detailData = (LDataMap) dao.selectOne("P000006Mapper.getCItemDetail", map);

			// 신규저장
			if ("I".equals(map.get("IDU"))) {
				if (detailData != null && !Util.isEmpty(detailData.get("MAP_PROD_CD"))) {
					throw new LingoException("처리 중 오류가 발생하였습니다.\n 대입코드[" + map.get("MAP_PROD_CD") + "]는 이미 사용중인 코드 입니다.");
				}
				scnt = dao.insert("P000006Mapper.insertPRODUCTMAP", map);
			} else if ("D".equals(map.get("IDU"))) { // 수정은 없음
				scnt = dao.update("P000006Mapper.deletePRODUCTMAP", map);
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
		} else if (Util.isEmpty(param.get("ITEMCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n품목코드가 없습니다.");
		}

		//미사용,사용 처리 분기
		if ("N".equals(param.get("ISUSING"))) {
			param.put("ISUSING", "Y");
		} else {
			param.put("ISUSING", "N");
		}
		scnt = dao.update("P000006Mapper.updateIsusing", param);

		param.put("SCNT", scnt);

		return param;
	}
}
