package xrt.alexcloud.p100.p100370;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 입고등록/실적 - 마스터 디테일 그리드 2개, 탭 패턴 Biz
 */
@Service
public class P100370Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100370Mapper.getSearch", param);
	}

	//등록 탭 디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100370Mapper.getDetailList", param);
	}

	//실적 탭 디테일 리스트 가져오기
	public List<LDataMap> getDetailList2(LDataMap param) throws Exception {
		return dao.select("P100370Mapper.getDetailList2", param);
	}

	//저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {
		//마스터 신규 저장 처리
		if ("I".equals(param.get("IDU"))) {
			//마스터 채번
			param.put("WIKEY", dao.getKey("WAREHOUSE_IN"));

			//마스터 신규
			dao.insert("P100370Mapper.insertMst", param);
		} else {
			//마스터 상태값 가져오기
			String sts = dao.getStatus("P130", param.getString("WIKEY"));

			if(!sts.equals("100")) { //예정전표인지 확인
				throw new LingoException("예정 전표만 수정가능합니다. 재조회하시기 바랍니다.");
			}

			//마스터 수정
			dao.select("P100370Mapper.updateMst", param);
		}

		//디테일 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap detailData = new LDataMap(paramList.get(i));

			detailData.put("WIKEY", param.get("WIKEY"));
			detailData.put("COMPCD", param.get("COMPCD"));
			detailData.put("WHCD", param.get("WHCD"));
			detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			detailData.put("LOGIN_IP", param.get("LOGIN_IP"));

			if ("D".equals(detailData.getString("IDU"))) {
				dao.delete("P100370Mapper.deleteDet", detailData);
			} else if ("I".equals(detailData.getString("IDU"))) {
				dao.insert("P100370Mapper.insertDet", detailData);
			} else if ("U".equals(detailData.getString("IDU"))) {
				dao.select("P100370Mapper.updateDet", detailData);
			}
		}

		return param;
	}

	//취소
	public LDataMap setDelete(LDataMap param) throws Exception {
		//마스터 상태값 가져오기
		String sts = dao.getStatus("P130", param.getString("WIKEY"));

		if(!sts.equals("100")) { //예정전표인지 확인
			throw new LingoException("예정 전표만 취소가능합니다. 재조회하시기 바랍니다.");
		}

		//입고 전표 상태 값 취소로 변경
		dao.update("P100370Mapper.updateMstSts", param);

		return param;
	}

	//저장 -> 지시처리 -> 실적처리
	public LDataMap setExecute(LDataMap param, List<LDataMap> paramList) throws Exception {
		param = setSave(param, paramList);

		paramList = dao.select("P100370Mapper.getDetailList", param);

		//마스터 상태값 가져오기(저장먼저한다면 저장시에 상태값 체크함)
		String sts = dao.getStatus("P130", param.getString("WIKEY"));

		if(!sts.equals("100")) { //예정전표인지 확인
			throw new LingoException("예정 전표만 확정가능합니다. 재조회하시기 바랍니다.");
		}

		//지시마스터 채번
		param.put("WDKEY", dao.getKey("WAREHOUSE_DIRECTION"));


		//입고전표 입고지시번호 UPDATE
		dao.update("P100370Mapper.updateWDkey", param);

		param.put("REMARK_P", "단순입고 : 내부 지시마스터 생성");
		//입고지시마스터 생성
		dao.insert("P100370Mapper.insertWDMst", param);

		//입고전표 상태(지시완료), 입고일자 UPDATE
		dao.update("P100370Mapper.updateWiSts", param);

		//각 품목을 실적처리한다.
		for (int i=0; i<paramList.size(); i++) {
			LDataMap exeData = new LDataMap(paramList.get(i));
			exeData.put("MSGID", "");
			exeData.put("MSG", "");
			exeData.put("LOGIN_USERCD", param.getString("LOGIN_USERCD"));
			exeData.put("LOGIN_IP", param.getString("LOGIN_IP"));

			dao.select("P100370Mapper.setInstruct", exeData);

			if(!"1".equals(exeData.getString("MSGID"))){
				throw new LingoException(exeData.getString("MSG"));
			}
		}

    	return param;
	}
}
