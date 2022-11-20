package xrt.fulfillment.order.orderlist;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.order.shippinglist.OrderVo;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.Util;

/**
 * 오더리스트 Biz
 */

@Service
public class OrderListBiz extends DefaultBiz {

	Logger logger = LoggerFactory.getLogger(OrderListBiz.class);

	// 검색
	List<OrderVo> getSearch(CommonSearchVo paramVo) throws Exception {

		// 오더등록일자 Default설정
		if (paramVo.getsToDate() == null || "".equals(paramVo.getsToDate())) {
			paramVo.setsToDate(Util.getTodayFormat("yyyyMMdd"));
		}
		if (paramVo.getsFromDate() == null || "".equals(paramVo.getsFromDate())) {
			paramVo.setsFromDate(Util.getTodayFormat("yyyyMMdd"));
		}

		return dao.selectList("OrderListMapper.getSearch", paramVo);
	}

	// 품목리스트 갯수 low,max, 중간값
	public LDataMap getListCnt(CommonSearchVo paramVo) throws Exception {
		// 오더등록일자 Default설정
		if (paramVo.getsToDate() == null || "".equals(paramVo.getsToDate())) {
			paramVo.setsToDate(Util.getTodayFormat("yyyyMMdd"));
		}
		if (paramVo.getsFromDate() == null || "".equals(paramVo.getsFromDate())) {
			paramVo.setsFromDate(Util.getTodayFormat("yyyyMMdd"));
		}
		LDataMap CNT = (LDataMap) dao.selectOne("OrderListMapper.getCount", paramVo);

		if(Util.isEmpty(CNT)) {
			throw new LingoException("패킹리스트를 출력 할 수 없는 데이터입니다.");
		}

		String maxCnt = CNT.getString("MAXCNT");
		String minCnt = CNT.getString("LOWCNT");
		String why = CNT.getString("WHY");

		// WHY값 - 1 : 2X2송장 포함하지 않음, 2 : 2X2송장 포함
		logger.debug("max - " + maxCnt + " / " + "min - " + minCnt + " / " + "why - " + why);

		LDataMap count = new LDataMap();
		count.put("MAX_COUNT", maxCnt);
		count.put("MIN_COUNT", minCnt);
		count.put("WHY", why);

		return count;
	}

	// 송장 시퀀스 검색
	public LDataMap invcSEQ(CommonSearchVo paramVo) throws Exception {

		String strInvcStart = "";
		String strInvcEnd = "";

		LDataMap dt = (LDataMap) dao.selectOne("OrderListMapper.getSeqdata", paramVo);

		if (dt != null && dt.size() > 0) {
			strInvcStart = dt.getString("MIN_RELAY_SEQ");
			strInvcEnd = dt.getString("MAX_RELAY_SEQ");
		}

		LDataMap maxseq = new LDataMap();
		maxseq.put("S_INVCSTART", strInvcStart);
		maxseq.put("S_INVCEND", strInvcEnd);

		return maxseq;
	}

	// 삭제
	public LDataMap setDelete(LDataMap param) throws Exception {

		if (Util.isEmpty(param)) {
			throw new LingoException("선택된 오더정보가 없습니다.");
		}
		LDataMap dt = (LDataMap) dao.selectOne("OrderListMapper.getOrdCd", param);

		if (!Util.isEmpty(dt) && dt.size() > 0) {
			param.put("ORD_CD", dt.get("ORD_CD"));
			dao.update("OrderListMapper.delOrder", param);
			dao.update("OrderListMapper.delOrderDtl", param);

			//TODO 2019.12월 추가개발
			// torder의 TALLY_DATETIME, TALLY_USER_CD을 null로 설정
			// 재고테이블의 QTY를 돌린다.
		} else {
			throw new LingoException("해당하는 오더정보를 검색할 수 없습니다.");
		}
		return param;
	}
}