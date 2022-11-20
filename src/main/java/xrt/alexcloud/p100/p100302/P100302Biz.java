package xrt.alexcloud.p100.p100302;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 입고등록 - 마스터 디테일 그리드 2개 패턴 Biz
 */
@Service
public class P100302Biz extends DefaultBiz {

	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100302Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100302Mapper.getDetailList", param);
	}

	//저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {
		int scnt = 0;

		if ("".equals(param.get("WIKEY"))) {

			//채번
			param.put("WIKEY", dao.getKey("WAREHOUSE_IN"));

			scnt = dao.insert("P100302Mapper.insertMst", param);

			for (int i = 0; i < paramList.size(); i++) {
				LDataMap detailData = new LDataMap(paramList.get(i));

				detailData.put("WIKEY", param.get("WIKEY"));
				detailData.put("WHCD", param.get("WHCD"));
				detailData.put("COMPCD", param.get("COMPCD"));
				detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
				detailData.put("LOGIN_IP", param.get("LOGIN_IP"));

				dao.insert("P100302Mapper.insertDet", detailData);
			}

		} else {

			String sts = dao.getStatus("P130", param.getString("WIKEY"));

			if(!sts.equals("100")) { //예정전표인지 확인
				throw new LingoException("예정 전표만 수정가능합니다. 재조회하시기 바랍니다.");
			}

			scnt = dao.update("P100302Mapper.updateMst", param);

			if(scnt > 0) { //마스터가 정상적으로 업데이트 되면 디테일을 업데이트 한다.
				for (int i = 0; i < paramList.size(); i++) {
					LDataMap detailData = new LDataMap(paramList.get(i));

					detailData.put("WIKEY", param.get("WIKEY"));
					detailData.put("COMPCD", param.get("COMPCD"));
					detailData.put("WHCD", param.get("WHCD"));
					detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
					detailData.put("LOGIN_IP", param.get("LOGIN_IP"));

					if ("D".equals(detailData.getString("IDU"))) {
						dao.delete("P100302Mapper.deleteDet", detailData);
					} else if ("I".equals(detailData.getString("IDU"))) {
						dao.insert("P100302Mapper.insertDet", detailData);
					} else if ("U".equals(detailData.getString("IDU"))) {
						dao.update("P100302Mapper.updateDet", detailData);
					}
				}
			}
		}
		// 발주 체크
		setCheckWISave(param);

		param.put("SCNT", scnt);

		return param;
	}

	//취소
	public LDataMap setDelete(LDataMap param) throws Exception {
		int scnt = 0;

		String sts = (String) dao.selectOne("P100302Mapper.getWISTS", param);

		if(!sts.equals("100")) { //예정전표인지 확인
			throw new LingoException("예정 전표만 취소가능합니다. 재조회하시기 바랍니다.");
		}

		//입고 전표 상태 값 취소로 변경
		scnt = dao.update("P100302Mapper.updateMstSts", param);

		param.put("SCNT", scnt);

		return param;
	}

	/**
	 *  발주수량 체크
	 */
	public void setCheckWISave(LDataMap param) throws Exception {
		// 상태값 체크
		LDataMap exeData = new LDataMap();
		exeData.put("TYPE", "WI");
		exeData.put("KEY", param.get("WIKEY"));
		exeData.put("MSGID", "");
		exeData.put("MSG", "");

		dao.select("P100302Mapper.setCheckWISave", exeData);

		if(!"1".equals(exeData.getString("MSGID"))){
			throw new LingoException(exeData.getString("MSG"));
		}
	}
}
