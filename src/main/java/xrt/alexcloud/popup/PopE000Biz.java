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
public class PopE000Biz extends DefaultBiz {
	//검색
	public List<LDataMap> getInit(LDataMap param) throws Exception {
		return dao.select("PopE000Mapper.getInit", param);
	}

	//처리 프로시져명
	public LDataMap getMstData(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("PopE000Mapper.getMstData", param);
	}

	//검색
	public List<LDataMap> setCheck(LDataMap param, List<LDataMap> paramList) throws Exception {
		//기등록 데이터 삭제 처리
		dao.delete("PopE000Mapper.delete", param);

		param.put("COMPCD", LoginInfo.getCompcd());
		List<LDataMap> checkList = dao.select("PopE000Mapper.getCheckList", param);

		XStream xs = new XStream();
		xs.registerConverter(new MapEntryConverter());
		xs.alias("root", LDataList.class);

		String xml = xs.toXML(paramList);

		param.put("MSGID", "");
		param.put("MSG", "");
		param.put("XML", xml);

		dao.select("PopE000Mapper.uploadXml", param);

		if(!"1".equals(param.getString("MSGID"))){
			throw new LingoException(param.getString("MSG"));
		}

		//업로드 내역 등록
		// XML 처리 변경으로 인한 주석 처리
		/*
		int seq = 0;
		for (int i=0; i<paramList.size(); i++) {
			// 삭제 내역이 아닐때만 처리
			if (!"D".equals(paramList.get(i).get("IDU"))) {
				seq = seq+1;
				LDataMap map = new LDataMap(paramList.get(i));
				map.put("PGMID", param.getString("PGMID"));
				map.put("COMPCD", LoginInfo.getCompcd());
				map.put("SEQ", seq);
				map.put("LOGIN_IP", ClientInfo.getClntIP());
				map.put("LOGIN_USERCD", LoginInfo.getUsercd());
				map.put("CHECKLIST", checkList);

				dao.insert("PopE000Mapper.insert", map);
			}
		}

		return dao.select("PopE000Mapper.getUploadList", param);
		 */
		param.put("CHECKLIST", checkList);
		return dao.select("PopE000Mapper.getXmlUploadList", param);
	}

	/**
	 *  주문요청등록(업로드) 정보 저장
	 */
	public void setUpload(LDataMap param) throws Exception {

		param.put("MSGID", "");
		param.put("MSG", "");
		dao.select("PopE000Mapper.upload", param);

		if(!"1".equals(param.getString("MSGID"))){
			throw new LingoException(param.getString("MSG"));
		}
	}

	//검색
	public List<LDataMap> getAuditInit(LDataMap param) throws Exception {
		return dao.select("PopE000Mapper.getAuditInit", param);
	}

	//검색(정산관리)
	public List<LDataMap> setAuditCheck(LDataMap param, List<LDataMap> paramList) throws Exception {
		//기등록 데이터 삭제 처리
		dao.delete("PopE000Mapper.delete", param);

		param.put("COMPCD", LoginInfo.getCompcd());
		List<LDataMap> checkList = dao.select("PopE000Mapper.getCheckList", param);

		XStream xs = new XStream();
		xs.registerConverter(new MapEntryConverter());
		xs.alias("root", LDataList.class);

		String xml = xs.toXML(paramList);

		param.put("MSGID", "");
		param.put("MSG", "");
		param.put("XML", xml);

		dao.select("PopE000Mapper.uploadXml", param);

		if(!"1".equals(param.getString("MSGID"))){
			throw new LingoException(param.getString("MSG"));
		}

		//업로드 내역 등록
		// XML 처리 변경으로 인한 주석 처리
		/*
		int seq = 0;
		for (int i=0; i<paramList.size(); i++) {
			// 삭제 내역이 아닐때만 처리
			if (!"D".equals(paramList.get(i).get("IDU"))) {
				seq = seq+1;
				LDataMap map = new LDataMap(paramList.get(i));
				map.put("PGMID", param.getString("PGMID"));
				map.put("COMPCD", LoginInfo.getCompcd());
				map.put("SEQ", seq);
				map.put("LOGIN_IP", ClientInfo.getClntIP());
				map.put("LOGIN_USERCD", LoginInfo.getUsercd());
				map.put("CHECKLIST", checkList);

				dao.insert("PopE000Mapper.insert", map);
			}
		}

		return dao.select("PopE000Mapper.getUploadList", param);
		 */
		param.put("CHECKLIST", checkList);
		return dao.select("PopE000Mapper.getXmlAuditUploadList", param);
	}

	public LDataMap getAuditMstData(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("PopE000Mapper.getAuditMstData", param);
	}
}