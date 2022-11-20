package xrt.alexcloud.p100.p100380;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.Util;
/**
 * 입고현황 Biz
 */
@Service
public class P100380Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		List<LDataMap> resultList = new ArrayList<LDataMap>();

		if ("1".equals(param.getString("TABIDX"))) {
			resultList = dao.select("P100380Mapper.getSearch", param);
		} else if ("2".equals(param.getString("TABIDX"))) {
			resultList =  dao.select("P100380Mapper.getSearch2", param);
		}

		return resultList;
	}

	//출력시 상태값 가져오기
	public LDataMap getPrint(LDataMap param) throws Exception {
		//입고전표 상태 체크
		LDataMap checkMap = (LDataMap) dao.selectOne("P100380Mapper.getWiSts", param);
		String WIKEY = Util.ifEmpty(param.getString("WIKEY"));

		if(checkMap == null){
			throw new LingoException("존재하지 않는 전표입니다.");
		} else if("99".equals(Util.ifEmpty(checkMap.get("WISTS")))){
			throw new LingoException("취소 상태에서는 처리할 수 없습니다");
		}

		return checkMap;
	}


}
