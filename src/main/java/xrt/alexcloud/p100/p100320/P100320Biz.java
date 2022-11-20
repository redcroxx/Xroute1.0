package xrt.alexcloud.p100.p100320;

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
 * 입고실적 Biz
 */
@Service
public class P100320Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100320Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100320Mapper.getDetailList", param);
	}

	//검색
	public List<LDataMap> getTab2List(LDataMap param) throws Exception {
		return dao.select("P100320Mapper.getTab2List", param);
	}

	/**
	 *  주문요청등록 정보 저장(입고실적등록)--xml 전송방식으로 변경 DB내부에서 처리되도록 20171107
	 */
	public void setInstruct(LDataMap param, List<LDataMap> paramList) throws Exception {

		//xml 변환
		XStream xs = new XStream();
		xs.registerConverter(new MapEntryConverter());
		xs.alias("root", LDataList.class);

		String xml = xs.toXML(paramList);
		param.put("XML", xml);
		param.put("MSGID", "");
		param.put("MSG", "");

		dao.select("P100320Mapper.setInstructXml", param);

		if(!"1".equals(param.getString("MSGID"))){
			throw new LingoException(param.getString("MSG"));
		}
	}

	/**
	 *  주문요청등록 정보 저장(입고실적등록)--기존 loop 20171107 이전사용
	 */
	public void setInstruct_loop(LDataMap param, List<LDataMap> paramList) throws Exception {
		for (int i=0; i<paramList.size(); i++) {
			// 상태값 체크
			LDataMap exeData = new LDataMap(paramList.get(i));
			exeData.put("MSGID", "");
			exeData.put("MSG", "");
			exeData.put("LOGIN_USERCD", param.getString("LOGIN_USERCD"));
			exeData.put("LOGIN_IP", param.getString("LOGIN_IP"));

			dao.select("P100320Mapper.setInstruct", exeData);

			if(!"1".equals(exeData.getString("MSGID"))){
				throw new LingoException(exeData.getString("MSG"));
			}
		}
	}

	//강제종료
	public LDataMap setExecute(LDataMap param) throws Exception {

		param.put("LOGIN_USERCD", LoginInfo.getUsercd());
		param.put("LOGIN_IP", ClientInfo.getClntIP());

		//강제종료 여부 체크
		String wdsts = (String) dao.selectOne("P100320Mapper.getWdSts", param);
		String wdkey = Util.ifEmpty(param.getString("WDKEY"));
		if("400".equals(wdsts)){
			throw new LingoException("강제종료처리를 할 수 없는 전표입니다. 전표번호 [" + wdkey + "]");
		}

		//상태값변경(입고완료처리)
		dao.update("P100320Mapper.updateWiSts", param);

		return param;
	}

}
