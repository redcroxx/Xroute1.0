package xrt.fulfillment.seller.sellertally;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class SellerTallyBiz extends DefaultBiz {
	// 검색
	public List<LDataMap> getOrder(LDataMap param) throws Exception {
		return dao.select("SellerTallyMapper.getOrder", param);
	}

	// 상세 검색
	public LDataMap getSearch(LDataMap param) throws Exception {
		LDataMap resultData = (LDataMap) dao.selectOne("SellerTallyMapper.getSearch", param);
		return resultData;
	}

	// 재고검색
	public String getInventoryQty(LDataMap param) throws Exception {
		String resultData = (String) dao.selectOne("SellerTallyMapper.getInventoryQty", param);
		return resultData;
	}

	// 검색
	public LDataMap getTallySearch(LDataMap param) throws Exception {
		LDataMap resultData = (LDataMap) dao.selectOne("SellerTallyMapper.getTallySearch", param);
		return resultData;
	}

	// 임시테이블 검색
	public List<LDataMap> getTmpOrderDtl(LDataMap param) throws Exception {
		return dao.select("SellerTallyMapper.getTmpOrderDtl", param);
	}

	// 오더상세 검색
	public List<LDataMap> getOrderDtl(LDataMap param) throws Exception {
		return dao.select("SellerTallyMapper.getOrderDtl", param);
	}

	// 상품검색
	public LDataMap getGoodsSearch(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("SellerTallyMapper.getGoodsSearch", param);
	}

	// 임시테이블 데이터 삭제
	public LDataMap setTmpDelete(LDataMap param) throws Exception {
		dao.delete("SellerTallyMapper.setTmpDelete", param);
		return param;
	}

	// 저장
	public LDataMap setMatchCnt(List<LDataMap> paramList) throws Exception {

		LDataMap paramMap = null;
		int allUpdCnt = 0;

		// 마스터 신규 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap map = paramList.get(i);

			paramMap = new LDataMap();
			paramMap.put("ORGCD", map.getString("ORGCD"));
			paramMap.put("ORD_CD", map.getString("ORD_CD"));
			paramMap.put("ORD_SEQ", map.getString("ORD_SEQ"));
			paramMap.put("GOODS_CNT", map.getString("GOODS_CNT"));

			if (map.getString("SCAN_CNT").equals(map.getString("GOODS_CNT"))) {
				paramMap.put("SCAN_CNT", map.getString("SCAN_CNT"));
				paramMap.put("LACK_CNT", map.getString("LACK_CNT"));
			} else {
				paramMap.put("SCAN_CNT", map.getString("GOODS_CNT"));
				paramMap.put("LACK_CNT", "0");
			}

			int updCnt = dao.update("SellerTallyMapper.setMatchCnt", paramMap);
			allUpdCnt = allUpdCnt + updCnt;
		}
		if (allUpdCnt != paramList.size()) {
			throw new LingoException("처리중 에러가 발생했습니다.");
		}

		LDataMap resultmap = new LDataMap(paramList.get(0));

		return resultmap;
	}

	public int updInventoryQty(LDataMap param) throws Exception {

		if (param == null) {
			throw new LingoException("변경된 항목이 없습니다.");
		}
		return dao.update("SellerTallyMapper.updInventoryQty", param);
	}

	public int setTallyComp(LDataMap param) throws Exception {

		if (param == null) {
			throw new LingoException("변경된 항목이 없습니다.");
		}
		return dao.update("SellerTallyMapper.setTallyComp", param);
	}

	// 스캔수량 저장
	public int setScanCnt(LDataMap param) throws Exception {
		if (param == null) {
			throw new LingoException("변경된 항목이 없습니다.");
		}
		return dao.update("SellerTallyMapper.setScanCnt", param);
	}

	// 상품상세 임시저장
	public LDataMap setTmpOrderDtl(LDataMap param) throws Exception {
		dao.insert("SellerTallyMapper.setTmpOrderDtl", param);
		return param;
	}

	// 검수 완료 tally_goods 테이블 저장
	public LDataMap setTallyGoodsInsert(LDataMap param) throws Exception {
		dao.insert("SellerTallyMapper.setTallyGoodsInsert", param);
		return param;
	}

	// 검수완료 테이블 검색
		public List<LDataMap> getTallyGoodsDtl(LDataMap param) throws Exception {
			return dao.select("SellerTallyMapper.getTallyGoodsDtl", param);
		}
	
	// 상품출고이력
	public int insertInventoryHistory(LDataMap param) throws Exception {

		if (param == null) {
			throw new LingoException("변경된 항목이 없습니다.");
		}
		return dao.insert("SellerTallyMapper.insInventoryHistory", param);
	}

	public List<LDataMap> getSeq(LDataMap paramMap) throws Exception {
		return dao.select("SellerTallyMapper.getSeq", paramMap);
	}

}
