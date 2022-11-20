package xrt.alexcloud.p000.p000022;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
/**
 * 주문서양식설정 Biz
 */
@Service
public class P000022Biz extends DefaultBiz {
	//검색
	public LDataMap getSearch1(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("P000022Mapper.getSearch1", param);
	}

	//검색(셀병합하기)
	public List<LDataMap> getSearch2(LDataMap param) throws Exception {
		return dao.select("P000022Mapper.getSearch2", param);
	}
	//검색(문자치환하기)
	public List<LDataMap> getSearch3(LDataMap param) throws Exception {
		return dao.select("P000022Mapper.getSearch3", param);
	}
	//검색(양식세부설정:대입코드)
	public List<LDataMap> getSearch4(LDataMap param) throws Exception {
		return dao.select("P000022Mapper.getSearch4", param);
	}
	//양식명 SEELCTBOX
	public List<LDataMap> getSiteCd(LDataMap param) throws Exception {
		return dao.select("P000022Mapper.getSiteCd", param);
	}

	//저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList1, List<LDataMap> paramList2, List<LDataMap> paramList3) throws Exception {

		/*//주문서 양식 설정 대입코드(기본은 대입코드 갯수로 감)
		int headerCnt = 0;

		String ltSitecd = ""; //주문서 양식 설정 코드
		int sitecdCnt = 0;

		System.out.println("1");

		LDataMap cntMap = new LDataMap(paramList2.get(0));
		cntMap.put("IDU", "U");

		System.out.println(paramList2.get(0));
		//주문서 양식 gridList
		for(int i = 0; i<100; i++){
			//빈값은 포함, null은 제외
			System.out.println("value = " + cntMap.getString(String.valueOf(i+1)));
			if(!cntMap.getString(String.valueOf(i+1)).equals("") && cntMap.getString(String.valueOf(i+1)) != null){
				headerCnt = headerCnt + 1;
				ltSitecd = ltSitecd + "|" + cntMap.getString(String.valueOf(i+1)) ;
			}
		}

		//주문서 양식 설정 VALIDATION CHECK
		//중복체크, 필수값체크
		List<LDataMap> ltSiteCode = new ArrayList<LDataMap>(); //주문서 양식 설정 공통코드 리스트
		ltSiteCode = dao.select("P000022Mapper.getSiteCode", param);

		System.out.println("2");
		System.out.println("ltSitecd : " + ltSitecd);
		System.out.println("headerCnt : " + headerCnt);

		String[] ltSiteList = ltSitecd.split("\\|"); //주문서 양식 설정 사용자 지정 리스트

		//사용자가 설정한 양식 리스트와, 공통코드에 지정된 리스트 비교
		for(int i = 0; i < ltSiteCode.size(); i++) {
			sitecdCnt = 0;
			LDataMap sitecdMap = new LDataMap(ltSiteCode.get(i));
			for (int j = 0; j < ltSiteList.length; j++) {
				System.out.println("ltSiteList["+j+"]" + ltSiteList[j]);
				//사용자 설정 양식 리스트가 공통코드 리스트에 존재할 경우
				if(!ltSiteList[j].equals("NULL")) {
					if(sitecdMap.getString("CODE").equals(ltSiteList[j])) {
						sitecdCnt = sitecdCnt + 1;
					}
				}

				//사용자 설정 양식 리스트가 중복 체크 된 경우
				if(sitecdCnt > 1){
					throw new LingoException("양식 세부 설정\n중복컬럼 [" + sitecdMap.getString("SNAME1") + "]");
				}
			}

			//필수 컬럼이 존재하지 않는 경우
			if(sitecdMap.getString("SNAME3").equals("MANDATORY") && (sitecdCnt == 0)){
				throw new LingoException("양식 세부 설정\n필수컬럼 [" + sitecdMap.getString("SNAME1") + "]");
			}
		}

		String colnminvs = "";
		int mapCnt = 0;
		int columnCnt = 0;

		//양식세부설정 코드명
		LDataMap codeMap = new LDataMap(paramList2.get(0));
		for(int i = 0; i<100; i++){
			columnCnt = columnCnt + 1;//빈값포함 컬럼의 개수
			if(!codeMap.getString(String.valueOf(i+1)).equals("") && codeMap.getString(String.valueOf(i+1)) != null) {
				colnminvs +=  codeMap.getString(String.valueOf(i+1)) + "|";
				mapCnt = mapCnt + 1;
			} else {
				colnminvs +=  "|";
			}

			System.out.println("mapCnt : " + mapCnt + "// colnminvs :" + colnminvs );
			if(mapCnt == headerCnt)
				break;
		}
		System.out.println("3");
		colnminvs = colnminvs.substring(0, colnminvs.length()-1);
		System.out.println("DB_COL_NM_INVCS :" + colnminvs );
		param.put("DB_COL_NM_INVCS", colnminvs);

		mapCnt = 0;
		String colnms = "";
		//양식헤더명
		LDataMap headNmMap = new LDataMap(paramList3.get(0));
		for(int i = 1; i<columnCnt+1; i++){
			if(!headNmMap.getString(String.valueOf(i)).equals("") && headNmMap.getString(String.valueOf(i)) != null) {
				colnms +=  headNmMap.getString(String.valueOf(i)) + "|";
				mapCnt = mapCnt + 1;
			} else {
				colnms +=  "|";
			}

			System.out.println("mapCnt : " + mapCnt + "// colnms :" + colnms );

			if(mapCnt == headerCnt)
				break;
		}
		colnms = colnms.substring(0, colnms.length()-1);
		System.out.println("COL_NMS :" + colnms );
		param.put("COL_NMS", colnms);


		if ("I".equals(param.getString("IDUR"))) {
			//신규저장  프로시저 호출
			dao.select("P000022Mapper.setUspInsMktSite", param);

			if(!"1".equals(param.getString("MSGID"))){
				throw new LingoException(param.getString("MSG"));
			}
			param.put("SITE_CD", param.get("MSG"));

		} else {
			//수정저장  프로시저 호출
			dao.select("P000022Mapper.setUspUpdMktSiteLotNew2", param);

			if(!"1".equals(param.getString("MSGID"))){
				throw new LingoException(param.getString("MSG"));
			}
		}

		//치환하기 삭제 후 저장
		dao.delete("P000022Mapper.deleteReplace", param);

		int size = paramList1.size();
		for(int i = 0; i<size; i++){
			LDataMap map = new LDataMap(paramList1.get(i));
			map.put("S_COMPCD", param.get("S_COMPCD"));
			map.put("S_ORGCD", param.get("S_ORGCD"));
			map.put("SITE_CD", param.get("SITE_CD"));
			map.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			map.put("LOGIN_IP", param.get("LOGIN_IP"));

			dao.insert("P000022Mapper.insertReplace", map);

		}

		//셀병합하기 삭제 후 저장
		dao.delete("P000022Mapper.deleteMerge", param);
		param.put("SRC_LOCS", "A|A|A|");
		if(Util.ifEmpty(param.getString("TGT_COL1")) != "") {

			param.put("TGT_COL", param.get("TGT_COL1"));

			String srcCols = param.getString("SRC_COLS11") + "|" + param.getString("SRC_COLS12") + "|" + param.getString("SRC_COLS13") + "|";
			param.put("SRC_COLS", srcCols);
			param.put("SRC_COLS1", param.getString("SRC_COLS11"));
			param.put("SRC_COLS2", param.getString("SRC_COLS12"));
			param.put("SRC_COLS3", param.getString("SRC_COLS13"));

			String seps = param.getString("SEPS11") + "|" + param.getString("SEPS12") + "|";
			param.put("SEPS", seps);
			param.put("SEPS1", param.getString("SEPS11"));
			param.put("SEPS2", param.getString("SEPS12"));

			dao.insert("P000022Mapper.insertMerge", param);
		}
		if(Util.ifEmpty(param.getString("TGT_COL2")) != "") {
			param.put("TGT_COL", param.get("TGT_COL2"));

			String srcCols = param.getString("SRC_COLS21") + "|" + param.getString("SRC_COLS22") + "|" + param.getString("SRC_COLS23") + "|";
			param.put("SRC_COLS", srcCols);
			param.put("SRC_COLS1", param.getString("SRC_COLS21"));
			param.put("SRC_COLS2", param.getString("SRC_COLS22"));
			param.put("SRC_COLS3", param.getString("SRC_COLS23"));

			String seps = param.getString("SEPS21") + "|" + param.getString("SEPS22") + "|";
			param.put("SEPS", seps);
			param.put("SEPS1", param.getString("SEPS21"));
			param.put("SEPS2", param.getString("SEPS22"));

			dao.insert("P000022Mapper.insertMerge", param);
		}
		if(Util.ifEmpty(param.getString("TGT_COL3")) != "") {
			param.put("TGT_COL", param.get("TGT_COL3"));

			String srcCols = param.getString("SRC_COLS31") + "|" + param.getString("SRC_COLS32") + "|" + param.getString("SRC_COLS33") + "|";
			param.put("SRC_COLS", srcCols);
			param.put("SRC_COLS1", param.getString("SRC_COLS31"));
			param.put("SRC_COLS2", param.getString("SRC_COLS32"));
			param.put("SRC_COLS3", param.getString("SRC_COLS33"));

			String seps = param.getString("SEPS31") + "|" + param.getString("SEPS32") + "|";
			param.put("SEPS", seps);
			param.put("SEPS1", param.getString("SEPS31"));
			param.put("SEPS2", param.getString("SEPS32"));

			dao.insert("P000022Mapper.insertMerge", param);
		}*/

		if ("I".equals(param.getString("IDUR"))) {
			//마스터 신규저장
			//기본정보 & 발송정보

			//SITE_CD 채번
			param.put("SITE_CD", dao.getKey("MKTSITE"));

			dao.insert("P000022Mapper.insertMst", param);

		} else {
			//마스터 수정저장
			//기본정보 & 발송정보
			dao.update("P000022Mapper.updateMst", param);
		}

		String COMPCD = param.getString("S_COMPCD");
		String ORGCD = param.getString("S_ORGCD");
		String SITECD = param.getString("SITE_CD");
		String USERCD = param.getString("LOGIN_USERCD");
		String IP = param.getString("LOGIN_IP");

		//그리드(문자치환)
		for (int i = 0; i < paramList1.size(); i++) {
			LDataMap mergeData = new LDataMap(paramList1.get(i));

			mergeData.put("COMPCD", COMPCD);
			mergeData.put("ORGCD", ORGCD);
			mergeData.put("SITE_CD", SITECD);
			mergeData.put("LOGIN_USERCD", USERCD);
			mergeData.put("LOGIN_IP", IP);

			if ("I".equals(mergeData.getString("IDU"))) {
				//  디테일 신규저장
				dao.insert("P000022Mapper.insertMerge", mergeData);
			} else if ("U".equals(mergeData.getString("IDU"))) {
				//디테일 수정저장
				dao.update("P000022Mapper.updateMerge", mergeData);
			}
		}

		//그리드(문자치환)
		for (int i = 0; i < paramList2.size(); i++) {
			LDataMap replaceData = new LDataMap(paramList2.get(i));

			replaceData.put("COMPCD", COMPCD);
			replaceData.put("ORGCD", ORGCD);
			replaceData.put("SITE_CD", SITECD);
			replaceData.put("LOGIN_USERCD", USERCD);
			replaceData.put("LOGIN_IP", IP);

			if ("I".equals(replaceData.getString("IDU"))) {
				// 디테일 신규저장
				dao.insert("P000022Mapper.insertReplace", replaceData);
			} else if ("U".equals(replaceData.getString("IDU"))) {
				//디테일 수정저장
				dao.update("P000022Mapper.updateReplace", replaceData);
			}
		}

		//그리드(주문접수양식)
		for (int i = 0; i < paramList3.size(); i++) {
			LDataMap mktsiteFileData = new LDataMap(paramList3.get(i));

			mktsiteFileData.put("COMPCD", COMPCD);
			mktsiteFileData.put("ORGCD", ORGCD);
			mktsiteFileData.put("SITE_CD", SITECD);
			mktsiteFileData.put("LOGIN_USERCD", USERCD);
			mktsiteFileData.put("LOGIN_IP", IP);

			if ("I".equals(mktsiteFileData.getString("IDU"))) {
				// 디테일 신규저장
				dao.insert("P000022Mapper.insertDtl", mktsiteFileData);
			} else if ("U".equals(mktsiteFileData.getString("IDU"))) {
				//디테일 수정저장
				dao.update("P000022Mapper.updateDtl", mktsiteFileData);
			}
		}

		return param;
	}

	//삭제
	public LDataMap setDelete(LDataMap param) throws Exception {

		//삭제  프로시저 호출
		dao.select("P000022Mapper.setUspDelSite", param);
		if(!"1".equals(param.getString("MSGID"))){
			throw new LingoException(param.getString("MSG"));
		}

		return param;
	}

}
