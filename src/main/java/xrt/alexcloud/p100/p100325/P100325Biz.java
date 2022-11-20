package xrt.alexcloud.p100.p100325;

import java.util.List;

import org.springframework.stereotype.Service;

import com.thoughtworks.xstream.XStream;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataList;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.MapEntryConverter;
import xrt.lingoframework.utils.Util;
/**
 * 입고지시/실적 Biz
 */
@Service
public class P100325Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100325Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100325Mapper.getDetail", param);
	}

	//입고로케이션 가져오기
	public LDataMap getWiLoccd(LDataMap param) throws Exception {
		String loccd = (String) dao.selectOne("P100325Mapper.getWiLoccd", param);
		param.put("WHINLOCCD", loccd);
		return param;
	}

	//저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {
		String sts = dao.getStatus("P130", param.getString("WIKEY"));
		String WIKEY = Util.ifEmpty(param.getString("WIKEY"));
		if(!sts.equals("100")){
			throw new LingoException("예정 상태 일 때만 처리할 수 있습니다. 입고번호 [" + WIKEY + "]");
		}

		int size = paramList.size();

		for (int i=0; i<size; i++) {
			LDataMap map = new LDataMap(paramList.get(i));
			if ("U".equals(map.getString("IDU"))) {
				map.put("LOGIN_USERCD", LoginInfo.getUsercd());
				map.put("LOGIN_IP", ClientInfo.getClntIP());
				dao.update("P100325Mapper.updateDtl", map);
			}
		}

		return param;
	}
	//실행(입고지시/실적)
	public LDataMap setExecute(LDataMap param, List<LDataMap> paramList, List<LDataMap> paramList2) throws Exception {

		setSave(paramList2.get(0), paramList2);

		int size = paramList.size();

		//입고지시번호 채번
		param.put("WDKEY", dao.getKey("WAREHOUSE_DIRECTION"));
		param.put("LOGIN_USERCD", LoginInfo.getUsercd());
		param.put("LOGIN_IP", ClientInfo.getClntIP());

		for(int i=0; i<size; i++) {
			LDataMap map = new LDataMap(paramList.get(i));
			map.put("WDKEY", param.getString("WDKEY"));
			map.put("LOGIN_USERCD", LoginInfo.getUsercd());
			map.put("LOGIN_IP", ClientInfo.getClntIP());
			// 입고전표 입고지시번호 UPDATE
			dao.update("P100325Mapper.updateWDkey", map);
		}

		// 회사, 사업장, 창고가 같아야함
		LDataMap chkMap = (LDataMap) dao.selectOne("P100325Mapper.getMstInfo", param);
		if(!chkMap.getString("CNT").equals("1")){
			throw new LingoException("입고전표의 회사, 셀러, 창고가 같을 때만 처리할 수 있습니다.");
		}

		//입고로케이션 체크
		String loccd = Util.ifEmpty(dao.selectOne("P100325Mapper.getWiLoccd", chkMap));
		if(loccd.equals("")){
			throw new LingoException("입고로케이션을 지정해 주시기 바랍니다.");
		}

		//입고전표 상태 UPDATE(지시완료)
		dao.update("P100325Mapper.updateWiSts", param);

		param.put("COMPCD", paramList.get(0).get("COMPCD"));
		param.put("ORGCD", paramList.get(0).get("ORGCD"));
		param.put("WHCD", paramList.get(0).get("WHCD"));
		//입고지시마스터 생성
		dao.insert("P100325Mapper.insertMst", param);

		//실적처리(xml 변환)
		List<LDataMap> paramList3 = dao.select("P100325Mapper.getDetailList", param);

		/*
		for (int i=0; i<paramList3.size(); i++) {
			// 상태값 체크
			LDataMap exeData = new LDataMap(paramList3.get(i));
			exeData.put("MSGID", "");
			exeData.put("MSG", "");
			exeData.put("LOGIN_USERCD", param.getString("LOGIN_USERCD"));
			exeData.put("LOGIN_IP", param.getString("LOGIN_IP"));

			dao.select("P100325Mapper.setInstructComb", exeData);

			if(!"1".equals(exeData.getString("MSGID"))){
				throw new LingoException(exeData.getString("MSG"));
			}
		}
		*/

		XStream xs = new XStream();
		xs.registerConverter(new MapEntryConverter());
		xs.alias("root", LDataList.class);

		String xml = xs.toXML(paramList3);
		param.put("XML", xml);
		param.put("MSGID", "");
		param.put("MSG", "");

		dao.select("P100325Mapper.setInstructCombXml", param);

		if(!"1".equals(param.getString("MSGID"))){
			throw new LingoException(param.getString("MSG"));
		}

		LDataMap param2 = new LDataMap(paramList.get(0));
		return param2;
	}
}