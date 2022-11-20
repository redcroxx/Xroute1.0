package xrt.alexcloud.p700.p700200;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

/**
 * 로케이션이동등록 - RealGrid 마스터 디테일 그리드 2개 패턴 Biz
 */
@Service
public class P700200Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P700200Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P700200Mapper.getDetailList", param);
	}

	//저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {
		//마스터 신규 저장 처리
		if ("I".equals(param.get("IDU"))) {
			//마스터 채번
			param.put("IMKEY", dao.getKey("INVENTORY_MOVEMENT"));
			param.put("LOGIN_USERCD", LoginInfo.getUsercd());
			param.put("LOGIN_IP", ClientInfo.getClntIP());

			//마스터 신규
			dao.insert("P700200Mapper.insertMst", param);
		} else {
			//마스터 상태값 가져오기
			String sts = dao.getStatus("P710", param.getString("IMKEY"));

			if(!sts.equals("100")) { //예정전표인지 확인
				throw new LingoException("예정 전표만 수정가능합니다. 재조회하시기 바랍니다.");
			}

			//마스터 수정
			dao.update("P700200Mapper.updateMst", param);
		}

		//디테일 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap detailData = new LDataMap(paramList.get(i));

			detailData.put("IMKEY", param.get("IMKEY"));
			detailData.put("COMPCD", param.get("COMPCD"));
			detailData.put("ORGCD", param.get("ORGCD"));
			detailData.put("BEFOREWHCD", param.get("WHCD"));
			detailData.put("AFTERWHCD", param.get("WHCD"));
			detailData.put("IMWHCD", param.get("WHCD"));
			detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			detailData.put("LOGIN_IP", param.get("LOGIN_IP"));

			if ("D".equals(detailData.getString("IDU"))) {
				dao.delete("P700200Mapper.deleteDet", detailData);
			} else if ("I".equals(detailData.getString("IDU"))) {
				dao.insert("P700200Mapper.insertDet", detailData);
			} else if ("U".equals(detailData.getString("IDU"))) {
				dao.update("P700200Mapper.updateDet", detailData);
			}
		}
		return param;
	}

	//취소
	public LDataMap setDelete(LDataMap param) throws Exception {
		//마스터 상태값 가져오기
		String sts = dao.getStatus("P710", param.getString("IMKEY"));

		if(!sts.equals("100")) { //예정전표인지 확인
			throw new LingoException("예정 전표만 취소가능합니다. 재조회하시기 바랍니다.");
		}

		//전표 상태 값 취소로 변경
		dao.update("P700200Mapper.updateCancel", param);

		return param;
	}
}
