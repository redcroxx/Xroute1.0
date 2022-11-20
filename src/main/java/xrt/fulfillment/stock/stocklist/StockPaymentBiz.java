package xrt.fulfillment.stock.stocklist;

import java.util.Map;

import org.springframework.stereotype.Service;

import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class StockPaymentBiz extends DefaultBiz {

	// 금액 조회
	public Map<String, Object> getAmount(StockListVo paramVo) throws Exception {
		Map<String, Object> resultData = (Map<String, Object>) dao.selectOne("StockListMapper.getAmount", paramVo);
		return resultData;
	}
	
	//TORDER UPDATE, AMOUNT_HISTORY INSERT, PAYMENT_MASTER UPDATE
	public LDataMap updateData(LDataMap param) throws Exception{
		int scnt = 0;
		
		scnt = dao.update("StockListMapper.updateTorderMst", param);
		scnt += dao.insert("StockListMapper.insertAmountHistory", param);
		scnt += dao.update("StockListMapper.updatePaymentMst", param);
		param.put("EVENT_CD", CommonConst.EVENT_AMOUNT_SAVE);
		param.put("STATUS_CD", CommonConst.ORD_STATUS_CD_PAYMENT_COMP);
		LDataMap apiSno = (LDataMap) dao.selectOne("StockListMapper.getApiSno", param);
		param.put("API_INVC_SNO", apiSno.get("INVC_SNO1"));
		param.put("ORD_CD", apiSno.get("ORD_CD"));
		scnt += dao.insert("StockListMapper.insertStockHistory", param);
		
		LDataMap retParam = new LDataMap();
		if(scnt == 4) {
			retParam.put("SCNT", scnt);
		} else {
			throw new LingoException("처리에 실패하였습니다. 관리자에게 문의하시기 바랍니다.");
		}
		return retParam;
		
	}
}
