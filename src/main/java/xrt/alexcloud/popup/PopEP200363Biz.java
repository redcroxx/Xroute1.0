package xrt.alexcloud.popup;

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
 * 업로드 팝업 Biz
 */
@Service
public class PopEP200363Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getInit(LDataMap param) throws Exception {
		return dao.select("PopEP200363Mapper.getInit", param);
	}

	//처리 프로시져명
	public LDataMap getMstData(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("PopEP200363Mapper.getMstData", param);
	}

	//검색
	public List<LDataMap> setCheck(LDataMap param, List<LDataMap> paramList) throws Exception {
		//기등록 데이터 삭제 처리
		dao.delete("PopEP200363Mapper.delete", param);

		param.put("COMPCD", LoginInfo.getCompcd());
		List<LDataMap> checkList = dao.select("PopEP200363Mapper.getCheckList", param);

		XStream xs = new XStream();
		xs.registerConverter(new MapEntryConverter());
		xs.alias("root", LDataList.class);

		String xml = xs.toXML(paramList);

		param.put("MSGID", "");
		param.put("MSG", "");
		param.put("XML", xml);

		dao.select("PopEP200363Mapper.uploadXml", param);

		if(!"1".equals(param.getString("MSGID"))){
			throw new LingoException(param.getString("MSG"));
		}
		param.put("CHECKLIST", checkList);
		return dao.select("PopEP200363Mapper.getXmlUploadList", param);
	}


}