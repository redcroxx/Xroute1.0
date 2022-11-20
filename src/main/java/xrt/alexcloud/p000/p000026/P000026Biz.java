package xrt.alexcloud.p000.p000026;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.Util;


/**
 * 복합품목 관리 Biz
 */
@Service
public class P000026Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000026Mapper.getSearch", param);
	}

	public List<LDataMap> getExcelSearch(LDataMap param) throws Exception {
		return dao.select("P000026Mapper.getExcelSearch", param);
	}

	//디테일리스트 검색
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P000026Mapper.getDetailList", param);
	}

	//저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {
		if ("I".equals(param.get("IDU"))) {
			//기등록 CODE 체크
			LDataMap ckData = (LDataMap) dao.selectOne("P000026Mapper.getDetailPRODUCTMAP", param);

			if(ckData != null && !"".equals(Util.ifEmpty(ckData.get("MAP_PROD_CD")))){
				throw new LingoException("이미 등록된 코드입니다. 복합코드 [" + ckData.get("MAP_PROD_CD") + "]");
			}
			//마스터 신규
			param.put("PROD_TYPE_CD", "00002"); //복합코드
			dao.insert("P000026Mapper.insertPRODUCTMAP", param);
			dao.insert("P000026Mapper.insertPRODUCT", param);
		} else {
			//마스터 수정
			dao.update("P000026Mapper.updatePRODUCT", param);
		}

		//디테일 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap detailData = new LDataMap(paramList.get(i));

			// 기등록 CODE 체크
			detailData.put("COMPCD", param.get("COMPCD"));
			detailData.put("ORGCD", param.get("ORGCD"));
			detailData.put("PROD_CD", param.get("PROD_CD"));
			detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			detailData.put("LOGIN_IP", param.get("LOGIN_IP"));

			if ("D".equals(detailData.getString("IDU"))) {
				dao.delete("P000026Mapper.deletePRODSPROD", detailData);
			} else if ("I".equals(detailData.getString("IDU"))) {
				LDataMap ckData = (LDataMap) dao.selectOne("P000026Mapper.getDetailPRODSPROD", detailData);
				if(ckData != null && !"".equals(Util.ifEmpty(ckData.get("ITEMCD")))){
					throw new LingoException("이미 복합코드에 등록된 단품코드입니다. \n중복된 단품코드를 입력할 수 없습니다. \n구성품목록 : [" + detailData.get("ITEMCD") + "]" + detailData.get("NAME"));
				}
				dao.insert("P000026Mapper.insertPRODSPROD", detailData);
			} else if ("U".equals(detailData.getString("IDU"))) {
				dao.update("P000026Mapper.updatePRODSPROD", detailData);
			}
		}

		return param;
	}

	//삭제 (사용/미사용)
	public void setDelete(LDataMap param) throws Exception {
		//필수 값 유효성 검사
		if (Util.isEmpty(param.get("PROD_CD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n복합코드가 없습니다.");
		}

		dao.update("P000026Mapper.deletePRODUCTMAP", param);
		dao.update("P000026Mapper.deletePRODUCT", param);
		dao.update("P000026Mapper.deleteAllPRODSPROD", param);
	}
}
