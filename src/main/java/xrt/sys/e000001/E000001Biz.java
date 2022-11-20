package xrt.sys.e000001;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class E000001Biz extends DefaultBiz{
	//등록정보 검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("E000001Mapper.getSearch", param);
	}
	//상세정보 검색
	public List<LDataMap> getDetailSearch(LDataMap param) throws Exception {
		return dao.select("E000001Mapper.getDetailSearch", param);
	}

	//저장
	public LDataMap setSave(LDataMap mGridData, List<LDataMap> dGridDataList) throws Exception {

		//LDataMap resultmap = new LDataMap(mGridData);

		// E001 삭제이후 재등록 처리함
		// 마스터 정보를 삭제
		dao.delete("E000001Mapper.deleteMst", mGridData);

		//마스터(등록정보) 신규 저장 처리
		for(int j=0; j<dGridDataList.size();j++){
			// 그리드 삭제 내역은 제외함
			if(!"D".equals(dGridDataList.get(j).getString("IDU")))
				mGridData.put(dGridDataList.get(j).getString("COL_ID"), dGridDataList.get(j).getString("COL_NM"));
		}
		// 마스터 정보 등록
		mGridData.put("LOGIN_USERCD", LoginInfo.getUsercd());
		mGridData.put("LOGIN_IP", ClientInfo.getClntIP());

		dao.insert("E000001Mapper.insertMst", mGridData);

		// 상세정보를 삭제
		dao.delete("E000001Mapper.deleteDet", mGridData);

		//상제정보 신규 저장 처리
		if(dGridDataList.size() > 0){

			for(int j=0; j<dGridDataList.size();j++){
				LDataMap map= dGridDataList.get(j);
				map.put("PGMID", mGridData.getString("PGMID"));
				map.put("LOGIN_USERCD", LoginInfo.getUsercd());
				map.put("LOGIN_IP",ClientInfo.getClntIP());

				// 그리드 삭제 내역은 제외함
				if(!"D".equals(map.getString("IDU"))){
					dao.insert("E000001Mapper.insertDet", map);
				}
			}
			//resultmap.put("COL_ID", dGridDataList.get(0));
		}

		return mGridData;
	}
}
