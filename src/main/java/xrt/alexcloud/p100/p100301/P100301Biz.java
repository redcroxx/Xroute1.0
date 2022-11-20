package xrt.alexcloud.p100.p100301;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.Util;
/**
 * 입고등록2 Biz
 */
@Service
public class P100301Biz extends DefaultBiz {
	//상세정보 가져오기
	public LDataMap getDetail(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("P100301Mapper.getDetail", param);
	}

	//디테일 리스트 가져오기
	public List<LDataMap> getDetailList(LDataMap param) throws Exception {
		return dao.select("P100301Mapper.getDetailList", param);
	}

	//저장
	public LDataMap setSave(LDataMap param, List<LDataMap> paramList) throws Exception {

		if ("I".equals(param.getString("IDUR"))) {

			//입고번호 채번
			param.put("WIKEY", dao.getKey("WAREHOUSE_IN"));
			//마스터 저장
			dao.insert("P100301Mapper.insertMst", param);


		} else {
			//입고전표 상태 체크
			String sts = dao.getStatus("P130", param.getString("WIKEY"));
			String WIKEY = Util.ifEmpty(param.getString("WIKEY"));

			if(!sts.equals("100")){
				throw new LingoException("예정 상태 일 때만 처리할 수 있습니다.");
			}

			//마스터 수정
			dao.update("P100301Mapper.updateMst", param);

		}
		//디테일저장
		int size = paramList.size();
		for(int i = 0; i<size; i++){
			LDataMap map = new LDataMap(paramList.get(i));

			map.put("WIKEY", param.get("WIKEY"));
			map.put("COMPCD", param.get("LOGIN_COMPCD"));
			map.put("WHCD", param.get("WHCD"));
			map.put("LOGIN_USERCD", param.get("LOGIN_USERCD"));
			map.put("LOGIN_IP", param.get("LOGIN_IP"));
			//추후 변경될 컬럼(현재 임의로 무조건 국내버전으로 넣는다.)
			map.put("EXCHCD", "KRW");
			map.put("EXCHRATE", 1);
			map.put("EXCHAMT", map.get("SUPPLYAMT"));

			//디테일 저장
			if ("D".equals(map.getString("IDU"))) {
				dao.delete("P100301Mapper.deleteDtl", map);
			} else if ("I".equals(map.getString("IDU"))) {
				dao.insert("P100301Mapper.insertDtl", map);
			} else if ("U".equals(map.getString("IDU"))) {
				dao.update("P100301Mapper.updateDtl", map);
			}

			if(!map.getString("POKEY").isEmpty() && !"D".equals(map.getString("IDU"))){
				//발주수량체크
				LDataMap poCntChk = (LDataMap) dao.selectOne("P100301Mapper.poCntChk", map);
				String ITEMCD = Util.ifEmpty(poCntChk.getString("ITEMCD"));
				int poqty =  (int) Double.parseDouble(poCntChk.getString("POQTY"));
				int wischqty = (int) Double.parseDouble(poCntChk.getString("WISCHQTY"));

				if( poqty <  wischqty) {
					throw new LingoException("발주 수량을 초과하였습니다. 상품 [" + ITEMCD + "] 수량을 수정하세요.");
				}
			}
		}

		return param;
	}

	//취소
	public LDataMap setDelete(LDataMap param) throws Exception {

		//입고전표 상태 체크
		String sts = dao.getStatus("P130", param.getString("WIKEY"));
		//String WIKEY = Util.ifEmpty(param.getString("WIKEY"));

		if(!sts.equals("100")){
			throw new LingoException("예정 상태 일 때만 처리할 수 있습니다.");
		}

		//입고상태 취소(99)로 변경
		dao.update("P100301Mapper.updateWiCancel", param);

		return param;
	}

	//출력시 상태값 가져오기
	public LDataMap getPrint(LDataMap param) throws Exception {
		//입고전표 상태 체크
		LDataMap checkMap = (LDataMap) dao.selectOne("P100301Mapper.getWiSts", param);
		//String WIKEY = Util.ifEmpty(param.getString("WIKEY"));

		if(checkMap == null){
			throw new LingoException("존재하지 않는 전표입니다.");
		} else if("99".equals(Util.ifEmpty(checkMap.get("WISTS")))){
			throw new LingoException("취소 상태에서는 처리할 수 없습니다");
		}

		return  checkMap;
	}

}
