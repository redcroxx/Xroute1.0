package xrt.sys.s000008;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

/**
 * 중메뉴 - 마스터, 디테일 그리드 2개 패턴 biz
 */
@Service
public class S000008Biz extends DefaultBiz{

	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {

		String S_L1TITLE = param.getString("S_L1TITLE");
		String S_L2TITLE = param.getString("S_L2TITLE");

		//대메뉴명 & 중메뉴명 TEXT값 없을 경우
		if( (S_L1TITLE.equals("")||S_L1TITLE.equals(null)) && (S_L2TITLE.equals("")||S_L2TITLE.equals(null))){
			return dao.select("S000008Mapper.getSearch", param);
		}
		//대메뉴명 ,중메뉴명 TEXT값 있을 경우
		else{
			return dao.select("S000008Mapper.getSearch", param);
		}

	}

	//마스터(중메뉴) 가져오기
	public List<LDataMap> getMstList(LDataMap param) throws Exception {
		return dao.select("S000008Mapper.getMstList", param);
	}

	//디테일(소메뉴) 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("S000008Mapper.getDetailList", param);
	}
	//저장
	public LDataMap setSave(LDataMap mGridData, List<LDataMap> dGridDataList) throws Exception {

		//마스터(중메뉴) 신규 저장 처리
		if("I".equals(mGridData.get("IDU"))){

			mGridData.put("LOGIN_USERCD", LoginInfo.getUsercd());
			mGridData.put("LOGIN_IP", ClientInfo.getClntIP());

			int menul2keyChk = (int)dao.selectOne("S000008Mapper.menul2keyChk", mGridData);
			if( menul2keyChk == 1){
				throw new LingoException("사용 중인 중메뉴 코드가 존재합니다.");
			}

			dao.insert("S000008Mapper.insertMst", mGridData);

		} else if ("U".equals(mGridData.get("IDU"))){

			dao.update("S000008Mapper.updateMst", mGridData);

		}
		LDataMap resultmap = new LDataMap(mGridData);

		//소메뉴 신규 저장 처리
		if(dGridDataList.size() > 0){
			for(int j=0; j<dGridDataList.size();j++){

				LDataMap map= dGridDataList.get(j);
				map.put("LOGIN_USERCD", LoginInfo.getUsercd());
				map.put("LOGIN_IP",ClientInfo.getClntIP());

				if("I".equals(map.getString("IDU"))){

					dao.insert("S000008Mapper.insertDet", map);

				} else if ("U".equals(map.getString("IDU"))){

					dao.update("S000008Mapper.updateDet", map);

				}
			}
			resultmap.put("APPKEY", dGridDataList.get(0).getString("APPKEY"));
		}
		return resultmap;
	}
	// 중메뉴 삭제
	public LDataMap setDelete(LDataMap param) throws Exception {

		dao.delete("S000008Mapper.deleteMst", param);
		dao.delete("S000008Mapper.deleteDelete", param);

		return param;
	}
	// 소메뉴 삭제
	public LDataMap setDelete2(LDataMap param) throws Exception {

		dao.delete("S000008Mapper.deleteDet", param);

		return param;
	}
}
