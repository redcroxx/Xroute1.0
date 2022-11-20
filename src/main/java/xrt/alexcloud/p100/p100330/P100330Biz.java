package xrt.alexcloud.p100.p100330;

import java.util.List;

import org.springframework.stereotype.Service;

import com.thoughtworks.xstream.XStream;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataList;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.MapEntryConverter;
/**
 * 입고적치 지시 Biz
 */
@Service
public class P100330Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("P100330Mapper.getSearch", param);
	}

	//입고적치지시
	public void setMoveLoc(LDataMap param, List<LDataMap> paramList) throws Exception {

		//xml 변환
		XStream xs = new XStream();
		xs.registerConverter(new MapEntryConverter());
		xs.alias("root", LDataList.class);

		String xml = xs.toXML(paramList);

		param.put("COMPCD", LoginInfo.getCompcd());
		param.put("MSGID", "");
		param.put("MSG", "");
		param.put("XML", xml);

		dao.select("P100330Mapper.setMoveLoc", param);

		if(!"1".equals(param.getString("MSGID"))){
			throw new LingoException(param.getString("MSG"));
		}
	}
}
