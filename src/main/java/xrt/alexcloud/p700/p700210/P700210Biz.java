package xrt.alexcloud.p700.p700210;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

/**
 * 로케이션이동확정 - RealGrid 마스터 디테일 그리드 2개 패턴 Biz
 */
@Service
public class P700210Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P700210Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P700210Mapper.getDetailList", param);
	}

	//저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {
		//마스터 상태값 가져오기
		String sts = dao.getStatus("P710", param.getString("IMKEY"));

		if(!sts.equals("100")) { //예정전표인지 확인
			throw new LingoException("예정 전표만 수정가능합니다. 재조회하시기 바랍니다.");
		}

		//디테일 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap detailData = new LDataMap(paramList.get(i));

			detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			detailData.put("LOGIN_IP", param.get("LOGIN_IP"));

			if ("U".equals(detailData.getString("IDU"))) {
				dao.update("P700210Mapper.updateDet", detailData);
			}
		}
		return param;
	}

	//확정
	public LDataMap setExecute(List<LDataMap> paramMList, List<LDataMap> paramDList) throws Exception {
		LDataMap param = new LDataMap(paramMList.get(0));
		param.put("LOGIN_USERCD", LoginInfo.getUsercd());
		param.put("LOGIN_IP", ClientInfo.getClntIP());

		//마스터 상태값 가져오기
		String sts = dao.getStatus("P710", param.getString("IMKEY"));

		if(!sts.equals("100")) { //예정전표인지 확인
			throw new LingoException("예정 전표만 확정가능합니다. 재조회하시기 바랍니다.");
		}

		//디테일 저장 처리
		for (int i = 0; i < paramDList.size(); i++) {
			LDataMap detailData = new LDataMap(paramDList.get(i));

			detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			detailData.put("LOGIN_IP", param.get("LOGIN_IP"));

			if ("U".equals(detailData.getString("IDU"))) {
				dao.update("P700210Mapper.updateDet", detailData);
			}
		}

		//체크된 마스터 확정 처리(USX_WhLocMoveStock)
		for (int i = 0; i < paramMList.size(); i++) {
			LDataMap masterData = new LDataMap(paramMList.get(i));

			masterData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			masterData.put("LOGIN_IP", param.get("LOGIN_IP"));

			dao.update("P700210Mapper.setExecute", masterData);

			if(!"1".equals(masterData.getString("MSGID"))){
				throw new LingoException(masterData.getString("MSG"));
			}
		}

		return param;
	}
}
