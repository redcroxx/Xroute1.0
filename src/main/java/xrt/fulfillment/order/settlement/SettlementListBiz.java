package xrt.fulfillment.order.settlement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.api.efs.EfsAPI;
import xrt.alexcloud.api.etomars.EtomarsAPI;
import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.alexcloud.common.vo.ShipPriceSearchVo;
import xrt.interfaces.qxpress.QxpressAPI;
import xrt.interfaces.qxpress.vo.QxpressVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.Util;

@Service
public class SettlementListBiz extends DefaultBiz {

	@Resource
	EfsAPI efsAPI;

	@Resource
	EtomarsAPI etomarsAPI;

	@Resource
	QxpressAPI qxpressAPI;

	Logger logger = LoggerFactory.getLogger(SettlementListBiz.class);

	List<SettlementListVo> getSearch(CommonSearchVo paramVo) throws Exception {
		return  dao.selectList("SettlementListMapper.getSearch", paramVo);
	}

	List<ShippingPriceVo> getPriceSearch(ShipPriceSearchVo paramVo) throws Exception {
		return  dao.selectList("SettlementListMapper.getPriceSearch", paramVo);
	}

	List<SettlementListVo> getPriceSearchData(ShipPriceSearchVo paramVo) throws Exception {
		return  dao.selectList("SettlementListMapper.getPriceSearchData", paramVo);
	}

	//ETOMARS API연동
	public List<Map<String, Object>> estShippingFee(ShipPriceSearchVo paramVo) throws Exception {
		List<ShippingPriceVo> shipmentVos = getPriceSearch(paramVo);

		if (shipmentVos.size() == 0) {
			List<Map<String, Object>> resList = new ArrayList<>();
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "201");
			retMap.put("message", "해당 데이터가 없습니다.");
			retMap.put("data", new ArrayList());

			resList.add(retMap);
			retMap.put("error", "Y");
			return resList;

		} else {
			List<Map<String, Object>> resList = new ArrayList<>();
			List<Map<String, Object>> xrtInvcSnoList = new ArrayList();

			for (ShippingPriceVo shipVo : shipmentVos) {
				Map<String, Object> resMap = etomarsAPI.estShippingFee(shipVo);

				//TODO ETOMARS API 연동
				if (!"0".equals(resMap.get("code").toString())) {
					String message = resMap.get("message").toString();

					Map<String, Object> retMap = new HashMap<>();
					retMap.put("message", message);
					retMap.put("data", resMap);
					retMap.put("error", "Y");

					resList.add(retMap);
				} else {
					JSONObject resultMap = (JSONObject) resMap.get("list");
					int sqlCnt = 0;

					//성공시
					Map<String, Object> updateMap = new HashMap<>();
					if (!Util.isEmpty(resultMap.get("ShippingFee"))) {
						updateMap.put("cShippingPrice", resultMap.get("ShippingFee").toString());  //배송비
						sqlCnt++;
					}
					if (!Util.isEmpty(resultMap.get("CurrencyUnit"))) {
						updateMap.put("cShippingPriceUnit", resultMap.get("CurrencyUnit").toString());   //화페단위
						sqlCnt++;
					}
					if (!Util.isEmpty(resultMap.get("ChargeableWeight"))) {
						updateMap.put("cWgtCharge", resultMap.get("ChargeableWeight").toString());   //적용무게
						sqlCnt++;
					}
					updateMap.put("xrtInvcSno", shipVo.getXrtInvcSno());

					Map<String, Object> retMap = new HashMap<>();
					xrtInvcSnoList.add(updateMap);

					retMap.put("data", xrtInvcSnoList);

					if (sqlCnt > 0) {
						dao.update("SettlementListMapper.etomarsWgtUpdate", updateMap);
						retMap.put("code", "200");
						retMap.put("error", "N");
					} else {
						retMap.put("code", "500");
						retMap.put("error", "Y");
					}
					resList.add(retMap);
				}
			}
			return resList;
		}
	}

	//EFS API연동
	public List<Map<String, Object>> getEfsTrackStatus(ShipPriceSearchVo paramVo) throws Exception {
		logger.debug("[getEfsTrackStatus] paramVo : "+ paramVo.toString());
		List<ShippingPriceVo> shipmentVos = getPriceSearch(paramVo);

		if (shipmentVos.size() == 0) {
			List<Map<String, Object>> resList = new ArrayList<>();
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "404");
			retMap.put("message", "해당 데이터가 없습니다.");
			retMap.put("data", new ArrayList());
			retMap.put("error", "Y");
			resList.add(retMap);

			return resList;

		} else {
			List<Map<String, Object>> resList = new ArrayList<>();
			Map<String, Object> retMap = new HashMap<>();

			for (ShippingPriceVo shipVo : shipmentVos) {

				Map<String, Object> resMap = efsAPI.getTrackStatus(shipVo.getInvcSno1());

				if (resMap.get("code").equals("404") || resMap.get("code").equals("500")) {
					retMap.put("code", "500");
					retMap.put("message", resMap.get("message"));
					retMap.put("xrtinvcsno", shipVo.getXrtInvcSno());
					retMap.put("error", "Y");
					resList.add(retMap);

					Map<String, Object> updateMap = new HashMap<>();
					logger.debug("failed : " + shipVo.getXrtInvcSno());
					updateMap.put("xrtInvcSno", shipVo.getXrtInvcSno());
					updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);

					dao.update("SettlementListMapper.efsWgtUpdate", updateMap);
					return resList;
				}

				String[] changeData = resMap.get("data").toString().split("\\n");

				if (Util.isEmpty(changeData) || !changeData[0].toUpperCase().contains(Util.getStrTrim("SUCCESSFULLY"))) {
					retMap.put("code", "500");
					retMap.put("message", "is not SUCCESSFULLY");
					retMap.put("xrtinvcsno", shipVo.getXrtInvcSno());
					retMap.put("error", "Y");
					resList.add(retMap);

					Map<String, Object> updateMap = new HashMap<>();
					logger.debug("xrtInvcSno : failed : " + shipVo.getXrtInvcSno());
					updateMap.put("xrtInvcSno", shipVo.getXrtInvcSno());
					updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);

					dao.update("SettlementListMapper.efsWgtUpdate", updateMap);

				} else {

					// 성공한 경우
					if (changeData.length > 0) {
						retMap.put("code", "200");
						retMap.put("message", "");
						retMap.put("listCnt", shipmentVos.size());
						retMap.put("xrtinvcsno", shipVo.getXrtInvcSno());
						logger.debug("changeData.length:"+changeData.length);

						for(int i=1; i < changeData.length; i++) {
							logger.debug("changeData["+i+"] : "+changeData[i]);

							Map<String, Object> updateMap = new HashMap<>();
							int sqlCnt = 0;
							int sqlWgtCnt = 0;

							String[] resultDtl = changeData[i].split("\\|");
							logger.debug("resultDtl.length:"+resultDtl.length);

							if (!Util.isEmpty(resultDtl[1])) {
								updateMap.put("xrtInvcSno", resultDtl[1]);
								sqlCnt++;
							}
							if (!Util.isEmpty(resultDtl[2])) {
								updateMap.put("localShipper", resultDtl[2]);
								sqlCnt++;
							}
							if (!Util.isEmpty(resultDtl[3])) {
								updateMap.put("invcSno2", resultDtl[3]);
								sqlCnt++;
							}

							if (!Util.isEmpty(resultDtl[7])) {
								String[] resultWgtDtl = resultDtl[7].split("\\,");
								logger.debug("resultWgtDtl.length:"+resultWgtDtl.length);
								updateMap.put("cWgtCharge", resultWgtDtl[0]);
								updateMap.put("cWgtReal", resultWgtDtl[1]);
								updateMap.put("cWgtVolume", resultWgtDtl[2]);
								sqlCnt++;
								sqlWgtCnt++;
							}
							if (!Util.isEmpty(resultDtl[9])) {
								updateMap.put("cShippingPrice", resultDtl[9]);
								sqlCnt++;
							}
							if (!Util.isEmpty(updateMap) && sqlWgtCnt > 0) {
								dao.update("SettlementListMapper.efsWgtUpdate", updateMap);
							} else {
									break;
							}
						}
						retMap.put("error", "N");
						resList.add(retMap);
					}
				}
			}
			return resList;
		}
	}

	// Qxpress 연동

	List<Map<String, Object>> getQxpressTrackingData(ShipPriceSearchVo paramVo) throws Exception {
		logger.info("[getQxpressTrackingData] ShipPriceSearchVo : " + paramVo);

		List<ShippingPriceVo> shipmentVos = getPriceSearch(paramVo);
		List<Map<String, Object>> resList = new ArrayList<>();

		if (shipmentVos.size() == 0) {
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "404");
			retMap.put("message", "해당 데이터가 없습니다.");
			retMap.put("data", new ArrayList());
			retMap.put("error", "Y");
			resList.add(retMap);

			return resList;
		}

		for(ShippingPriceVo shippingPriceVo : shipmentVos) {

			QxpressVo qxpressVo = new QxpressVo();
			qxpressVo.setXrtInvcSno(shippingPriceVo.getXrtInvcSno());
			qxpressVo.setDpc3refno1(shippingPriceVo.getInvcSno1());

			Map<String, Object> resMap = qxpressAPI.getShippingInfo(qxpressVo);

			String code = resMap.get("code").toString();
			if (code.equals("500")) {
				Map<String, Object> retMap = new HashMap<String, Object>();
				retMap.put("code", "500");
				retMap.put("message", resMap.get("message"));
				retMap.put("xrtinvcsno", shippingPriceVo.getXrtInvcSno());
				retMap.put("error", "Y");
				resList.add(retMap);

				Map<String, Object> updateMap = new HashMap<>();
				logger.debug("failed : " + shippingPriceVo.getXrtInvcSno());
				updateMap.put("xrtInvcSno", shippingPriceVo.getXrtInvcSno());
				updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);

				dao.update("SettlementListMapper.qxpressWgtUpdate", updateMap);
				return resList;
			}

			Map<String, Object> qxpressMap = (Map<String, Object>) resMap.get("data");

			String deliveryFeey = (qxpressMap.get("delivery_fee") == null ? "" : qxpressMap.get("delivery_fee").toString());
			String weight = (qxpressMap.get("weight") == null ? "" : qxpressMap.get("weight").toString());
			String width = (qxpressMap.get("width") == null ? "" : qxpressMap.get("width").toString());
			String height = (qxpressMap.get("height") == null ? "" : qxpressMap.get("height").toString());
			String depth = (qxpressMap.get("depth") == null ? "" : qxpressMap.get("depth").toString());

			Map<String, Object> updateMap = new HashMap<>();
			updateMap.put("xrtInvcSno", shippingPriceVo.getXrtInvcSno()); // xroute 송장번호
			updateMap.put("cWgtReal", weight); // 실제 중량(Kg)
			updateMap.put("cWgtWidth", width); // 가로(Cm)
			updateMap.put("cWgtLength", depth); // 세로(Cm)
			updateMap.put("cWgtHeight", height); // 높이(Cm)
			updateMap.put("cShippingPrice", deliveryFeey); // 배송비(KRW)

			dao.update("SettlementListMapper.qxpressWgtUpdate", updateMap);
			Map<String, Object> retMap = new HashMap<String, Object>();
			retMap.put("error", "N");
			resList.add(retMap);

		}

		return resList;
	}
}
