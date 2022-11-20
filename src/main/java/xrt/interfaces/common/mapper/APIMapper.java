package xrt.interfaces.common.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import xrt.alexcloud.api.efs.vo.EfsTrackingStatusVo;
import xrt.fulfillment.interfaces.vo.TOrderDtlVo;
import xrt.fulfillment.interfaces.vo.TOrderVo;
import xrt.interfaces.common.vo.ApiAuthKeyVo;
import xrt.interfaces.common.vo.CommonVo;
import xrt.interfaces.common.vo.ParamVo;
import xrt.interfaces.common.vo.ReqItemVo;
import xrt.interfaces.common.vo.ReqOrderVo;
import xrt.interfaces.common.vo.TorderVo;
import xrt.lingoframework.utils.LDataMap;

@Mapper
public interface APIMapper {
	// 공통코드 조회
	List<CommonVo> getCommonCode(ParamVo paramVo);
	// 미국 주코드 조회
	List<CommonVo> getUSStateList(Map<String, Object> paramMap);
	// Shippo Shipment 생성에 사용할 데이터 조회
	List<TorderVo> shippoShipment(ParamVo paramVo);
	// Shippo Refund에서 사용할 데이터 조회
	List<TorderVo> shippoRefund(ParamVo paramVo);
	// Aftership Trackins 생성에 사용힐 데이터 조회
	List<TorderVo> aftershipTrackings(ParamVo paramVo);

	List<LDataMap> getSeller(ApiAuthKeyVo apiAuthKeyVo);

	int getFileSeq(ReqOrderVo reqOrderVo);

	int getTorderFileSeq(ReqOrderVo reqOrderVo);

	int getTorderRelaySeq(ReqOrderVo reqOrderVo);
	// 인증키 조회
	ApiAuthKeyVo getAuthCheck(Map<String, Object> paramMap);
	// Torder AMOUNT, INVC_SNO1, SHIPPO_ID, LOCAL_SHIPPER UPDATE
	void updateTorderByShippo(TorderVo torderVo) throws Exception;
	//EFS getTrackingStatus 입고정보 갱신
	void efsTrackingUpd(EfsTrackingStatusVo trackingInfoVo) throws Exception;

	int insertApiOrderMaster(ReqOrderVo reqOrderVo);

	int insertApiOrderItem(ReqItemVo reqItemVo);

	int insertTorder(TOrderVo tOrderVo);

	int insertTOrderDtl(TOrderDtlVo tOrderDtlVo);
}
