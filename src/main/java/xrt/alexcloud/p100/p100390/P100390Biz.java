package xrt.alexcloud.p100.p100390;

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
 * 입고적치실적 - RealGrid 마스터 디테일 그리드 2개 패턴 Biz
 */
@Service
public class P100390Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100390Mapper.getSearch", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100390Mapper.getDetailList", param);
	}

	//확정(일괄확정)
	public LDataMap setExecute(List<LDataMap> paramList) throws Exception {
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap masterData = new LDataMap(paramList.get(i));

			masterData.put("LOGIN_USERCD", LoginInfo.getUsercd());
			masterData.put("LOGIN_IP", ClientInfo.getClntIP());

			dao.update("P100390Mapper.setExecute", masterData);

			if(!"1".equals(masterData.getString("MSGID"))){
				throw new LingoException(masterData.getString("MSG"));
			}
		}

		LDataMap param = paramList.get(0);
		return param;
	}

	//확정(부분실적)
	public LDataMap setExecuteDiv(LDataMap param, List<LDataMap> paramList) throws Exception {

		//디테일 상태값 가져오기
		String sts = (String) dao.selectOne("P100390Mapper.getImdSts", param);

		if(!sts.equals("100")) { //예정전표인지 확인
			throw new LingoException("예정 전표만 처리가 가능합니다");
		}

		//xml 변환
		XStream xs = new XStream();
		xs.registerConverter(new MapEntryConverter());
		xs.alias("root", LDataList.class);

		String xml = xs.toXML(paramList);

		param.put("LOGIN_USERCD", LoginInfo.getUsercd());
		param.put("LOGIN_IP", ClientInfo.getClntIP());
		param.put("XML", xml);
		param.put("MSGID", "");
		param.put("MSG", "");

		dao.select("P100390Mapper.setExecuteDiv", param);

		if(!"1".equals(param.getString("MSGID"))){
			throw new LingoException(param.getString("MSG"));
		}


		return param;
	}

	//취소
	public LDataMap setDelete(List<LDataMap> paramList) throws Exception {
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap map = new LDataMap(paramList.get(i));

			// 적치번호 상태 체크
			String sts = dao.getStatus("P710", map.getString("IMKEY"));
			String IMKEY = Util.ifEmpty(map.getString("IMKEY"));

			if(!sts.equals("100")){
				throw new LingoException("예정 상태 일 때만 처리할 수 있습니다. 적치번호 [" + IMKEY + "]");
			}

			map.put("LOGIN_USERCD", LoginInfo.getUsercd());
			map.put("LOGIN_IP", ClientInfo.getClntIP());

			// 적치상태 취소(99)로 변경
			dao.update("P100390Mapper.updateImCancel", map);

		}

		LDataMap param = paramList.get(0);
		return param;
	}
}
