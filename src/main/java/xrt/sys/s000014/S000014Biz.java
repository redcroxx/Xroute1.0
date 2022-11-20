package xrt.sys.s000014;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 공지사항 등록 Biz
 */
@Service
public class S000014Biz extends DefaultBiz {

	//상세정보 가져오기
	public LDataMap getInfo(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("S000014Mapper.getInfo", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getTargetList(LDataMap param) throws Exception {
		return dao.select("S000014Mapper.getTargetList", param);
	}

	//저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList, LDataMap file) throws Exception {
		if ("I".equals(param.getString("IDUR"))) {

			//공지번호 채번
			param.put("NTKEY", dao.getKey("NOTICE"));

			//공지사항 저장
			dao.insert("S000014Mapper.insertNotice", param);

			//공지사항 대상저장
			int size = paramList.size();
			for(int i = 0; i<size; i++){
				LDataMap map = new LDataMap(paramList.get(i));

				map.put("NTKEY", param.get("NTKEY"));
//				map.put("COMPCD", param.get("LOGIN_COMPCD"));
				map.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
				map.put("LOGIN_IP", param.get("LOGIN_IP"));

				dao.insert("S000014Mapper.insertNoticeTarget", map);
			}

			//공지사항 파일저장
			file.put("NTKEY", param.get("NTKEY"));

			for(int i = 0; i < 5; i++) {
				if(file.containsKey("FILENM"+i)) {
					LDataMap map = new LDataMap();

					map.put("NTKEY", file.get("NTKEY"));
					map.put("FILENM", file.get("FILENM"+i));
					map.put("ORIGINFILENM", file.get("ORIGINFILENM"+i));
					map.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
					map.put("LOGIN_IP", param.get("LOGIN_IP"));

					dao.insert("S000014Mapper.insertNoticeFile", map);
				}
			}
		} else {

			int ntkeyChk = (int) dao.selectOne("S000014Mapper.getNoticeChk", param);
			if (ntkeyChk == 0) {
				throw new LingoException("삭제된 공지사항입니다.");
			}

			//공지사항 수정
			dao.update("S000014Mapper.updateNotice", param);

			//공지사항 대상수정
			dao.delete("S000014Mapper.delNoticeTarget", param);

			int size = paramList.size();
			for(int i = 0; i<size; i++){
				LDataMap map = new LDataMap(paramList.get(i));

				map.put("NTKEY", param.get("NTKEY"));
//				map.put("COMPCD", param.get("LOGIN_COMPCD"));
				map.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
				map.put("LOGIN_IP", param.get("LOGIN_IP"));

				dao.insert("S000014Mapper.insertNoticeTarget", map);
			}
			//공지사항 파일저장
			file.put("NTKEY", param.get("NTKEY"));

			for(int i = 0; i < 5; i++) {
				if(file.containsKey("FILENM"+i)) {
					LDataMap map = new LDataMap();

					map.put("NTKEY", file.get("NTKEY"));
					map.put("FILENM", file.get("FILENM"+i));
					map.put("ORIGINFILENM", file.get("ORIGINFILENM"+i));
					map.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
					map.put("LOGIN_IP", param.get("LOGIN_IP"));

					dao.insert("S000014Mapper.insertNoticeFile", map);
				}
			}
		}
		return param;
	}

	//파일 삭제
	public LDataMap setFileDel(LDataMap param) throws Exception {
		dao.delete("S000014Mapper.delNoticeFile", param);

		return param;
	}

}