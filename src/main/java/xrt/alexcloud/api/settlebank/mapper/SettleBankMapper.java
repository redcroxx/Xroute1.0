package xrt.alexcloud.api.settlebank.mapper;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import xrt.alexcloud.api.settlebank.vo.SettleBankResNotiVO;
import xrt.lingoframework.utils.LDataMap;

@Mapper
public interface SettleBankMapper {
	// 세틀뱅크에서 승인내역 데이터 조회
	public int getConfirmCount(SettleBankResNotiVO paramVO);
	// 상태코드 0051 일때 TPAYMENT, TPAYMENTDTL Insert
	public int insertTPayment(SettleBankResNotiVO paramVO);
	public int insertTPaymentDtl(SettleBankResNotiVO paramVO);
	// TStock_history 수정
	public int insertTStockHistory(SettleBankResNotiVO paramVO);
	// 상태코드 0021 일때 TPAYMENT, TPAYMENTDTL Update
	public int updateTPayment(SettleBankResNotiVO paramVO);
	public int updateTPaymentDtl(SettleBankResNotiVO paramVO);
	// TORDER  수정
	public int updateTOrder(SettleBankResNotiVO paramVO);
	// TCart, TCartDtl 삭제
	public int deleteTCart(SettleBankResNotiVO paramVO);
	public int deleteTCartDtl(SettleBankResNotiVO paramVO);
    public int insertTrackingHistory(LDataMap dataMap);
}
