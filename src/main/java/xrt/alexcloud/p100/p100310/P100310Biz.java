package xrt.alexcloud.p100.p100310;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.Util;
/**
 * 입고지시 Biz
 */
@Service
public class P100310Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100310Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100310Mapper.getDetail", param);
	}

	//실행(입고지시) --2018.03.12 변경
	public LDataMap setExecute(LDataMap param, LDataMap param2, List<LDataMap> paramList) throws Exception {

		int paramListSize = paramList.size();

		String wddt = param.get("WDDT").toString().replace("-", "");
		param.replace("WDDT", wddt);

		//생성단위가 전표별일때
		for (int i=0; i<paramListSize; i++) {
			LDataMap map = new LDataMap(paramList.get(i));

			// 입고전표 상태 체크
			String sts = dao.getStatus("P130", map.getString("WIKEY"));
			String WIKEY = Util.ifEmpty(map.getString("WIKEY"));

			if(!sts.equals("100")){
				throw new LingoException("예정 상태 일 때만 처리할 수 있습니다. 입고번호 [" + WIKEY + "]");
			}

			// 입고예정수량 0인거 체크 --2017.08.28
			int qtyChk = (int) dao.selectOne("P100310Mapper.getQtyCnt", map);
			if(qtyChk > 0){
				throw new LingoException("입고예정수량이 0 입니다. 입고번호 [" + WIKEY + "]");
			}

			//입고지시번호 채번
			param.put("WDKEY", dao.getKey("WAREHOUSE_DIRECTION"));
			map.put("WDKEY", param.get("WDKEY"));
			map.put("LOGIN_USERCD", param2.get("LOGIN_USERCD"));
			map.put("LOGIN_IP", param2.get("LOGIN_IP"));

			//입고전표 입고지시번호 UPDATE
			dao.update("P100310Mapper.updateWDkey", map);

			map.put("WDDT", param.get("WDDT"));
			map.put("WDTYPE", "INS");
			map.put("REMARK_P", param.get("REMARK_P"));
			map.put("USERCD", param.get("USERCD"));
			map.put("COMPCD", param2.get("LOGIN_COMPCD"));

			//입고지시마스터 생성
			dao.insert("P100310Mapper.insertMst", map);

			//입고전표 상태 UPDATE(지시완료)
			dao.update("P100310Mapper.updateWiSts", param);

		}

		LDataMap resultmap = new LDataMap(paramList.get(0));
		return resultmap;
	}

	//실행(입고지시) --기존것
	/*public LDataMap setExecute(LDataMap param, LDataMap param2, List<LDataMap> paramList) throws Exception {

		int paramListSize = paramList.size();

		String wddt = param.get("WDDT").toString().replace("-", "");
		param.replace("WDDT", wddt);

		//생성단위가 전표별일때
		for (int i=0; i<paramListSize; i++) {
    		LDataMap map = new LDataMap(paramList.get(i));

    		//입고전표 상태 체크
    		String sts = dao.getStatus("P130", map.getString("WIKEY"));
			String WIKEY = Util.ifEmpty(map.getString("WIKEY"));

    		if(!sts.equals("100")){
				throw new LingoException("예정 상태 일 때만 처리할 수 있습니다. 입고번호 [" + WIKEY + "]");
			}

    		// 입고예정수량 0인거 체크 --2017.08.28
    		int qtyChk = (int) dao.selectOne("P100310Mapper.getQtyCnt", map);
    		if(qtyChk > 0){
				throw new LingoException("입고예정수량이 0 입니다. 입고번호 [" + WIKEY + "]");
			}

			if("WIUNIT".equals(param.getString("UNIT"))){
				//입고지시번호 채번
				param.put("WDKEY", dao.getKey("WAREHOUSE_DIRECTION"));
		    	map.put("WDKEY", param.get("WDKEY"));
		    	map.put("LOGIN_USERCD", param2.get("LOGIN_USERCD"));
	    		map.put("LOGIN_IP", param2.get("LOGIN_IP"));

		    	//입고전표 입고지시번호 UPDATE
				dao.update("P100310Mapper.updateWDkey", map);

				map.put("WDDT", param.get("WDDT"));
				map.put("WDTYPE", param.get("WDTYPE"));
	    		map.put("REMARK_P", param.get("REMARK_P"));
	    		map.put("USERCD", param.get("USERCD"));
	    		map.put("COMPCD", param2.get("LOGIN_COMPCD"));

	    		//입고지시마스터 생성
	    		dao.insert("P100310Mapper.insertMst", map);

	    		//입고전표 상태 UPDATE(지시완료)
	    		dao.update("P100310Mapper.updateWiSts", param);
			}
		}

		if("BATCH".equals(param.getString("UNIT"))){
			//입고지시번호 채번
			param.put("WDKEY", dao.getKey("WAREHOUSE_DIRECTION"));
	    	param.put("LOGIN_USERCD", LoginInfo.getUsercd());
	    	param.put("LOGIN_IP", ClientInfo.getClntIP());

			for (int i=0; i<paramListSize; i++) {
	    		LDataMap map = new LDataMap(paramList.get(i));

	    		map.put("LOGIN_USERCD", param2.get("LOGIN_USERCD"));
	    		map.put("LOGIN_IP", param2.get("LOGIN_IP"));
	    		map.put("WDKEY", param.get("WDKEY"));

	    		//입고전표 입고지시번호 UPDATE
				dao.update("P100310Mapper.updateWDkey", map);
			}

			// 회사, 사업장, 창고가 같아야함
			int cnt =  (int) dao.selectOne("P100310Mapper.getMstInfo", param);
			if(cnt != 1){
    			throw new LingoException("입고전표의 회사, 셀러, 창고가 같을 때만 처리할 수 있습니다.");
			}

			param.put("WHCD", paramList.get(0).get("WHCD"));
			param.put("COMPCD", param2.get("LOGIN_COMPCD"));
			param.put("ORGCD", paramList.get(0).get("ORGCD"));

    		//입고전표 상태 UPDATE(지시완료)
    		dao.update("P100310Mapper.updateWiSts", param);

			//입고지시마스터 생성
    		dao.insert("P100310Mapper.insertMst", param);
		}

		LDataMap resultmap = new LDataMap(paramList.get(0));
        return resultmap;
	}*/
}

