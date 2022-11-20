package xrt.alexcloud.p000.p000005;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;


/**
 * 로케이션 관리 Biz
 */
@Service
public class P000005Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P000005Mapper.getSearch", param);
	}

	//디테일 검색
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P000005Mapper.getDetailList", param);
	}

	//존행열단 검색
	public List<LDataMap> getCodeList(LDataMap param) throws Exception {
		return dao.select("P000005Mapper.getCodeList", param);
	}
	
	//저장
	public LDataMap setSave(List<LDataMap> paramList) throws Exception {
		int scnt = 0, paramListSize = 0;
		String LOGIN_USERCD = LoginInfo.getUsercd();
		String LOGIN_IP = ClientInfo.getClntIP();
		
		if (paramList == null || paramList.size() == 0) {
			throw new LingoException("변경된 항목이 없습니다.");
		} else {
			paramListSize = paramList.size();
		}
		
		for (int i=0; i<paramListSize; i++) {
			LDataMap map = new LDataMap(paramList.get(i));
			map.put("LOGIN_USERCD", LOGIN_USERCD);
			map.put("LOGIN_IP", LOGIN_IP);
			
			//필수 값 유효성 검사
			if (Util.isEmpty(map.get("COMPCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드가 없습니다.");
			} else if (Util.isEmpty(map.get("WHCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드가 없습니다.");
			} else if (Util.isEmpty(map.get("LOCCD"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n로케이션코드는 필수 입력값 입니다.");
			} else if (Util.isEmpty(map.get("LOCNAME"))) {
				throw new LingoException("처리 중 오류가 발생하였습니다.\n로케이션명은 필수 입력값 입니다.");
			}

			if ("I".equals(map.get("IDU")) || "U".equals(map.get("IDU"))) {
				LDataMap detailData = (LDataMap) dao.selectOne("P000005Mapper.getDetail", map);
				
				if ("I".equals(map.get("IDU"))) {
					if (detailData != null && !Util.isEmpty(detailData.get("LOCCD"))) {
						throw new LingoException("처리 중 오류가 발생하였습니다.\n로케이션코드[" + map.get("LOCCD") + "]는 이미 존재하는 로케이션코드 입니다.");
					}
					
					scnt = dao.insert("P000005Mapper.insertMst", map);
				} else if ("U".equals(map.get("IDU"))) {
					if (detailData == null || Util.isEmpty(detailData.get("LOCCD"))) {
						throw new LingoException("처리 중 오류가 발생하였습니다.\n로케이션코드[" + map.get("LOCCD") + "]는 존재하지 않는 로케이션입니다.");
					} else if ("N".equals(detailData.get("ISUSING"))) {
						throw new LingoException("처리 중 오류가 발생하였습니다.\n로케이션코드[" + map.get("LOCCD") + "]는 사용중지 되었습니다.");
					}
					
					scnt = dao.update("P000005Mapper.updateMst", map);
				}
			}
		}

		LDataMap param = paramList.get(0);
		param.put("SCNT", scnt);
		
		return param;
	}
	
	//삭제 (사용/미사용)
	public LDataMap setDelete(LDataMap param) throws Exception {
		int scnt = 0;
		//필수 값 유효성 검사
		if (Util.isEmpty(param.get("COMPCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드가 없습니다.");
		} else if (Util.isEmpty(param.get("WHCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드가 없습니다.");
		} else if (Util.isEmpty(param.get("LOCCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n로케이션코드가 없습니다.");
		}
		
		//미사용,사용 처리 분기
		if ("N".equals(param.get("ISUSING"))) {
			param.put("ISUSING", "Y");
		} else {
			param.put("ISUSING", "N");
		}
		scnt = dao.update("P000005Mapper.updateIsusing", param);
		
		param.put("SCNT", scnt);
		
		return param;
	}
	
	//로케이션코드 일괄 생성
	public LDataMap setLocCreate(LDataMap mData, LDataMap zoneData,
			List<LDataMap> lineList, List<LDataMap> rangeList, List<LDataMap> stepList) throws Exception {
		//필수 값 유효성 검사
		if (mData == null || Util.isEmpty(mData.get("COMPCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n회사코드가 없습니다.");
		} else if (Util.isEmpty(mData.get("WHCD"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n창고코드가 없습니다.");
		} else if (zoneData == null || Util.isEmpty(zoneData.get("CODE"))) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n존코드가 없습니다.");
		} else if (lineList == null || lineList.size() < 1) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n행이 없습니다.");
		} else if (rangeList == null || rangeList.size() < 1) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n열이 없습니다.");
		} else if (stepList == null || stepList.size() < 1) {
			throw new LingoException("처리 중 오류가 발생하였습니다.\n단이 없습니다.");
		}
		
		mData.put("LOCGROUP", zoneData.get("CODE"));
		mData.put("LOGIN_USERCD", LoginInfo.getUsercd());
		mData.put("LOGIN_IP", ClientInfo.getClntIP());
		int seq = 1;
		
		for (int i=0; i<lineList.size(); i++) {
			for (int j=0; j<rangeList.size(); j++) {
				for (int k=0; k<stepList.size(); k++) {
					LDataMap lineMap = lineList.get(i);
					LDataMap rangeMap = rangeList.get(j);
					LDataMap stepMap = stepList.get(k);
					mData.put("SEQ", seq);
					mData.put("LOCCD", lineMap.getString("CODE") + "-" + rangeMap.getString("CODE") + "-" + stepMap.getString("CODE"));
					mData.put("LINE", Util.strInteger(lineMap.get("CODE")));
					mData.put("RANGE", Util.strInteger(rangeMap.getString("CODE")));
					mData.put("STEP", Util.strInteger(stepMap.getString("CODE")));
					
					dao.update("P000005Mapper.insertLocCreate", mData);
					
					seq++;
				}
			}
		}
		
		return mData;
	}
}
