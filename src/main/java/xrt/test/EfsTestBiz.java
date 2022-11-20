package xrt.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.api.aftership.AfterShipAPI;
import xrt.alexcloud.api.efs.EfsAPI;
import xrt.alexcloud.api.efs.vo.EfsShipmentVo;
import xrt.fulfillment.order.orderinsert.OrderInsertBiz;
import xrt.interfaces.common.vo.EfsOrderDtlVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

/**
 * EFS biz
 * 
 * @author jy.hong
 *
 */
@Service
public class EfsTestBiz extends DefaultBiz {
	
	@Resource
	EfsAPI efsAPI;

	@Resource
	AfterShipAPI afterShipAPI;
	
	Logger logger = LoggerFactory.getLogger(OrderInsertBiz.class);

	/**
	 * EFS API createShipment 실행
	 *
	 * @param regSeq
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> efsCreateShipment(LDataMap paramList) throws Exception {

//		if (regSeq == 0) {
//			throw new LingoException("REG_SEQ 정보가 없습니다.");
//		}

//		String sReqSeq = Integer.toString(regSeq);
//		Map<String, Object> paramMap = new HashMap<>();
//		paramMap.put("regSeq", sReqSeq);

//		List<Map<String, Object>> xrtInvcSnos = dao.selectList("OrderInsertMapper.getXrtInvcSno", paramMap);
		List<Map<String, Object>> tOrders = new ArrayList<>();
//
//		if (xrtInvcSnos.size() == 0) {
//			throw new LingoException("INVC_SNO 정보가 없습니다.");
//		}

		String xrtInvcSno = paramList.get("INVCSNO").toString();
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("xrtInvcSno", xrtInvcSno);
		
//		for (Map<String, Object> xrtInveSno : xrtInvcSnos) {
//			System.out.println("xrtInveSno : " + xrtInveSno.toString());
//			// TODO
			tOrders.addAll(dao.selectList("OrderInsertMapper.getTorderData", paramMap));
//		}

		List<EfsShipmentVo> shipmentVos = new ArrayList<>();
		for (Map<String, Object> tOrder : tOrders) {
			System.out.println("tOrder : " + tOrder.toString());
			List<Map<String, Object>> items = dao.selectList("OrderInsertMapper.getTorderDTL", tOrder);
			String eNation = tOrder.get("eNation").toString().toUpperCase();

			if (eNation.equals("US")) {
				logger.debug(" EFS API는 USA를 제외하고 진행됩니다. ");
			} else {

				List<EfsOrderDtlVo> orders = new ArrayList<>();

				for (int i = 0; i < items.size(); i++) {
					logger.debug("=================");
					
					EfsOrderDtlVo dtlVo = new EfsOrderDtlVo();
					
					dtlVo.setDtlCartNo(tOrder.get("cartNo").toString());  //판매  쇼핑몰명
					dtlVo.setDtlMallNm(tOrder.get("mallNm").toString());  // 장바구니 번호
					dtlVo.setDtlOrdNo(items.get(i).get("ordNo").toString());  // 주문번호
					dtlVo.setGoodsCd(items.get(i).get("goodsCd").toString()); //상품코드
					dtlVo.setGoodsNm(items.get(i).get("goodsNm").toString());  //상품명
					dtlVo.setGoodsOption(items.get(i).get("goodsOption").toString()); //상품명옵션 (영문)
					dtlVo.setGoodsOptionKor(items.get(i).get("goodsOption").toString()); //상품명옵션 (한글)
					dtlVo.setGoodsCnt(items.get(i).get("goodsCnt").toString());
					dtlVo.setDtlRecvCurrency(tOrder.get("recvCurrency").toString());
					dtlVo.setPaymentPrice(items.get(i).get("paymentPrice").toString());
					orders.add(dtlVo);
				}

				EfsShipmentVo shipmentVo = new EfsShipmentVo();
				shipmentVo.setXrtInvcNo(tOrder.get("xrtInvcSno").toString());
				shipmentVo.setShipMethodCd(tOrder.get("shipMethodCd").toString());
				shipmentVo.setShipName(tOrder.get("shipName").toString());
				shipmentVo.setShipAddr(tOrder.get("shipAddr").toString());
				shipmentVo.setShipPost(tOrder.get("shipPost").toString());
				shipmentVo.setShipTel(tOrder.get("shipTel").toString());
				shipmentVo.setShipMobile(tOrder.get("shipMobile").toString());
				shipmentVo.setRecvName(tOrder.get("recvName").toString());
				shipmentVo.setRecvAddr(tOrder.get("recvAddr1").toString() +" "+ tOrder.get("recvAddr2").toString());
				shipmentVo.setRecvPost(tOrder.get("recvPost").toString());
				shipmentVo.setRecvTel(tOrder.get("recvTel").toString());
				shipmentVo.setRecvMobile(tOrder.get("recvMobile").toString());
				shipmentVo.setRecvNation(eNation);
				shipmentVo.setRecvCity(tOrder.get("recvCity").toString());
				shipmentVo.setOrderDtlList(orders);

				shipmentVos.add(shipmentVo);
			}
		}

		if (shipmentVos.size() == 0) {
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "201");
			retMap.put("message", "");
			retMap.put("data", new ArrayList());

			return retMap;
		} else {
			//TODO
			Map<String, Object> resMap = efsAPI.createShipment(shipmentVos);
			List<Map<String, Object>> xrtInvcSnoList = new ArrayList();
			
	        String[] changeData = resMap.get("data").toString().split("\\n");

//				Map<String, Object> retMap = new HashMap<>();
//				retMap.put("code", "200");
////				retMap.put("message", message);
//				retMap.put("data", xrtInvcSnoList);

				return resMap;
			}
		}
	
}
