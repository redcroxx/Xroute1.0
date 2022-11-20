package xrt.interfaces.common.service;

import java.util.List;
import java.util.Map;

import xrt.interfaces.common.vo.ApiAuthKeyVo;
import xrt.interfaces.common.vo.ParamVo;
import xrt.interfaces.common.vo.ReqOrderVo;
import xrt.interfaces.common.vo.ResResultVo;
import xrt.interfaces.common.vo.TorderVo;

public interface APIService {

    // Shippo API Valid, Shipment, refund
    Map<String, Object> shippoValid(ParamVo paramVo, String type);

    // Shippo API Create Shipment
    Map<String, Object> shippoShipment(TorderVo torderVo, String state);

    // Shippo API Create Refund
    Map<String, Object> shippoRefund(List<TorderVo> torderVo, String state);

    // Add AfterShip API Trackings
    Map<String, Object> addAfterShipTrackings(ParamVo paramVo);

    // Efs API Get TrackStatus
    Map<String, Object> efsGetTrackStatus(ParamVo paramVo);

    // API Order Insert Service
    ResResultVo createOrder(ReqOrderVo paramVo, ApiAuthKeyVo apiAuthKeyVo) throws Exception;
}
