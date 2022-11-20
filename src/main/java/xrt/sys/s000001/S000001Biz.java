package xrt.sys.s000001;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.Util;
/**
 * 공통코드 Biz
 */
@Service
public class S000001Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("CodeCacheMapper.getSearch", param);
	}

	//상세검색
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("CodeCacheMapper.getDetailList", param);
	}

	//저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {
		if ("I".equals(param.get("IDU"))) {
			//기등록 CODEKEY 체크
			LDataMap ckData = (LDataMap) dao.selectOne("CodeCacheMapper.getDetail", param);
			if(ckData != null && !"".equals(Util.ifEmpty(ckData.get("CODEKEY")))){
				throw new LingoException("이미 등록된 공통코드키입니다. 공통코드키 [" + ckData.get("CODEKEY") + "]");
			}
			//마스터 신규
			dao.insert("CodeCacheMapper.insertMst", param);
		} else {
			//마스터 수정
			dao.update("CodeCacheMapper.updateMst", param);
		}

		//디테일 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap detailData = new LDataMap(paramList.get(i));

			detailData.put("COMPCD", param.get("COMPCD"));
			detailData.put("CODEKEY", param.get("CODEKEY"));
			detailData.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			detailData.put("LOGIN_IP", param.get("LOGIN_IP"));

			if ("D".equals(detailData.getString("IDU"))) {
				dao.delete("CodeCacheMapper.deleteDtl", detailData);
			} else if ("I".equals(detailData.getString("IDU"))) {
				LDataMap ckData = (LDataMap) dao.selectOne("CodeCacheMapper.getDetailList2", detailData);
				if(ckData != null && !"".equals(Util.ifEmpty(ckData.get("CODEKEY")))){
					throw new LingoException("이미 등록된 코드입니다.(상세 리스트)\n중복된 코드를 입력할 수 없습니다. \n코드 [" + detailData.get("CODE") + "] : " + detailData.get("SNAME1"));
				}
				dao.insert("CodeCacheMapper.insertDtl", detailData);
			} else if ("U".equals(detailData.getString("IDU"))) {
				dao.update("CodeCacheMapper.updateDtl", detailData);
			}
		}

		return param;
	}
}