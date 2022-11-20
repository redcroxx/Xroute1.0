package xrt.alexcloud.p100.p100300;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

/**
 * 입고등록 - 마스터 디테일 그리드 2개 패턴 Biz
 */
@Service
public class P100300Biz extends DefaultBiz {
	// 검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100300Mapper.getSearch", param);
	}

	// 디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100300Mapper.getDetailList", param);
	}

	// 저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {
		// 마스터 신규 저장 처리
		if ("I".equals(param.get("IDU"))) {
			// 마스터 채번
			param.put("WIKEY", dao.getKey("WAREHOUSE_IN"));

			// 마스터 신규
			dao.insert("P100300Mapper.insertMst", param);
			dao.insert("P100300Mapper.getInventoryQty", param);
		} else {
			// 마스터 상태값 가져오기
			String sts = dao.getStatus("TSTOCKGOODS", param.getString("WIKEY"));
			if (!sts.equals("100")) { // 예정전표인지 확인
				throw new LingoException("예정 전표만 수정가능합니다. 재조회하시기 바랍니다.");
			}

			// 마스터 수정
			dao.update("P100300Mapper.updateMst", param);
		}

		// 디테일 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap detailData = new LDataMap(paramList.get(i));

			detailData.put("WIKEY", param.get("WIKEY"));
			detailData.put("COMPCD", param.get("COMPCD"));
			detailData.put("WHCD", param.get("WHCD"));
			detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			detailData.put("LOGIN_IP", param.get("LOGIN_IP"));
			detailData.put("MSGID", "");
			detailData.put("MSG", "");
			if ("D".equals(detailData.getString("IDU"))) {
				dao.delete("P100300Mapper.deleteDet", detailData);
				int wiqty = Integer.parseInt(detailData.getString("WIQTY"));
				wiqty = wiqty * (-1);
				detailData.put("WIQTY", wiqty);
				detailData.put("INFO", "품목삭제(감소)");
				dao.update("P100300Mapper.getInventoryQty", detailData);
				/*
				 * 기존 매핑방식 -> 체크 방식으로 변경, 사용 중지 2019. 04. 28 if(detailData.get("IFORDERNO") !=
				 * null && !detailData.get("IFORDERNO").equals("")){
				 * dao.update("P100300Mapper.updateAtomyFlgN", detailData); }
				 */
			} else if ("I".equals(detailData.getString("IDU"))) {
				dao.insert("P100300Mapper.insertDet", detailData);
				detailData.put("INFO", "입고등록(증가)");
				dao.update("P100300Mapper.getInventoryQty", detailData);
				/*
				 * 기존 매핑방식 -> 체크 방식으로 변경, 사용 중지 2019. 04. 28 if(detailData.get("IFORDERNO") !=
				 * null){ dao.update("P100300Mapper.updateAtomyFlgY", detailData); }
				 */
			} else if ("U".equals(detailData.getString("IDU"))) {
				dao.update("P100300Mapper.updateDet", detailData);
				String dtl = (String) dao.selectOne("P100300Mapper.getSearchDtl", detailData);
				if (dtl == null) {
					dtl = "0";
				}
				if (!dtl.equals(detailData.getString("WIQTY"))) {
					detailData.put("INFO", "입고업데이트(증가)");
					dao.update("P100300Mapper.getInventoryQty", detailData);
				}

			}
		}

		return param;
	}

	// 취소
	public LDataMap setDelete(LDataMap param, List<LDataMap> paramList) throws Exception {
		// 마스터 상태값 가져오기
		String sts = dao.getStatus("TSTOCKGOODS", param.getString("WIKEY"));
		if (!sts.equals("100")) { // 예정전표인지 확인
			throw new LingoException("예정 전표만 취소가능합니다. 재조회하시기 바랍니다.");
		}

		// 입고 전표 상태 값 취소로 변경
		dao.update("P100300Mapper.updateMstSts", param);

		for (int i = 0; i < paramList.size(); i++) {
			LDataMap detailData = new LDataMap(paramList.get(i));

			detailData.put("WIKEY", param.get("WIKEY"));
			detailData.put("COMPCD", param.get("COMPCD"));
			detailData.put("WHCD", param.get("WHCD"));
			detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			detailData.put("LOGIN_IP", param.get("LOGIN_IP"));
			detailData.put("INFO", "입고삭제(감소)");
			detailData.put("MSGID", "");
			detailData.put("MSG", "");
			int wiqty = 0;
			if(!detailData.getString("WIQTY").equals("")) {
				wiqty = Integer.parseInt(detailData.getString("WIQTY"));
			}
			wiqty = wiqty * (-1);
			detailData.put("WIQTY", wiqty);
			dao.update("P100300Mapper.getInventoryQty", detailData);
		}

		// atomy flg update
		/*
		 * 기존 매핑방식 -> 체크 방식으로 변경, 사용 중지 2019. 04. 28 for (int i = 0; i <
		 * paramList.size(); i++) { LDataMap detailData = new
		 * LDataMap(paramList.get(i)); detailData.put("LOGIN_USERCD",
		 * param.get("LOGIN_USERCD")); detailData.put("LOGIN_IP",
		 * param.get("LOGIN_IP"));
		 * 
		 * if(detailData.get("IFORDERNO") != null &&
		 * !detailData.get("IFORDERNO").equals("")){
		 * dao.update("P100300Mapper.updateAtomyFlgN", detailData); } }
		 */

		return param;
	}
}
