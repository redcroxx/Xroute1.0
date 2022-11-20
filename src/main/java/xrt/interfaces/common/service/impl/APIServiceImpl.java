package xrt.interfaces.common.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import xrt.alexcloud.api.efs.EfsAPI;
import xrt.alexcloud.api.efs.vo.EfsTrackingStatusVo;
import xrt.alexcloud.api.shippo.ShippoAPI;
import xrt.fulfillment.interfaces.vo.TOrderDtlVo;
import xrt.fulfillment.interfaces.vo.TOrderVo;
import xrt.interfaces.aftership.AfterShip;
import xrt.interfaces.aftership.vo.AfterShipVo;
import xrt.interfaces.common.mapper.APIMapper;
import xrt.interfaces.common.service.APIService;
import xrt.interfaces.common.vo.ApiAuthKeyVo;
import xrt.interfaces.common.vo.CommonVo;
import xrt.interfaces.common.vo.ParamVo;
import xrt.interfaces.common.vo.ReqItemVo;
import xrt.interfaces.common.vo.ReqOrderVo;
import xrt.interfaces.common.vo.ResResultVo;
import xrt.interfaces.common.vo.TorderVo;
import xrt.interfaces.shippo.ShippoImpl;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.Util;

@Service
@Transactional
public class APIServiceImpl implements APIService {

	Logger logger = LoggerFactory.getLogger(APIServiceImpl.class);

	APIMapper apiMapper;

	AfterShip afterShip;

	@Value("#{config['c.debugtype']}")
	private String debugtype;

	@Value("#{config['c.devShippoWestApiyKey']}")
	private String devShippoWestApiyKey;

	@Value("#{config['c.devShippoEastApiKey']}")
	private String devShippoEastApiKey;

	@Value("#{config['c.realShippoWestApiyKey']}")
	private String realShippoWestApiyKey;

	@Value("#{config['c.realShippoEastApiKey']}")
	private String realShippoEastApiKey;

	@Autowired
	public APIServiceImpl(APIMapper apiMapper, AfterShip afterShip) {
		this.apiMapper = apiMapper;
		this.afterShip = afterShip;
	}

	@Override
	public Map<String, Object> shippoValid(ParamVo paramVo, String type) {
		logger.debug("paramVo : "+ paramVo.toString() +", type : "+ type);

		try {
			// 01. xroute 송장번호가 Null 또는 빈값 일때 확인
			logger.debug("01. XrtInvcSno null Check");
			if (paramVo.getXrtInvcSno() == null || "".equals(paramVo.getXrtInvcSno())) {
				logger.debug("code : 404, message : 송장번호가 없습니다.");
				Map<String, Object> retMap = new HashMap<>();
				retMap.put("code", "404");
				retMap.put("message", "송장번호가 없습니다.");
				retMap.put("data", "");
				return retMap;
			}
			// 02. 등록된 데이터 확인
			logger.debug("02. XrtInvcSno size Check");
			List<TorderVo> shipmentList = apiMapper.shippoShipment(paramVo);
			if (shipmentList.size() == 0) {
				logger.debug("code : 404, message : 해당 송장번호로 등록된 데이터가 없습니다.");
				Map<String, Object> retMap = new HashMap<>();
				retMap.put("code", "404");
				retMap.put("message", "해당 송장번호로 등록된 데이터가 없습니다.");
				retMap.put("data", "");
				return retMap;
			}
			// 03. US 동부, 서부 정보 가져오기
			logger.debug("03. getUsStateData");
			paramVo.setCodekey("US_STATE_EAST");
			List<CommonVo> usStateEastList = apiMapper.getCommonCode(paramVo);
			paramVo.setCodekey("US_STATE_WEST");
			List<CommonVo> usStateWestList = apiMapper.getCommonCode(paramVo);

			// 04. 주 정보확인
			logger.debug("04. US State Check");
			String usState = "";
			for (TorderVo torderVo : shipmentList) {
				if (!"US".equals(torderVo.geteNation().toUpperCase())) {
					logger.debug("code : 501, message : 도착국가가 미국이 아닙니다.");
					Map<String, Object> retMap = new HashMap<>();
					retMap.put("code", "501");
					retMap.put("message", "도착국가가 US가 아닙니다.");
					retMap.put("data", "");
					return retMap;
				}

				// 04-1. Type 비교
				logger.debug("04-1. Type Check");
				if (type.equals("refund")) {
					if ("".equals(torderVo.getShippoId()) || torderVo.getShippoId() == null) {
						logger.debug("code : 503, message : Shippo ObjectId를 찾을 수 없습니다.");
						Map<String, Object> retMap = new HashMap<>();
						retMap.put("code", "503");
						retMap.put("message", "Shippo ObjectId를 찾을 수 없습니다.");
						retMap.put("data", "");
						return retMap;
					}
				} else {
					if (!"".equals(torderVo.getShippoId()) && torderVo.getShippoId() != null) {
						logger.debug("code : 504, message : 이미 처리된 송장번호 입니다.");
						Map<String, Object> retMap = new HashMap<>();
						retMap.put("code", "504");
						retMap.put("message", "이미 처리된 송장번호 입니다.");
						retMap.put("data", "");
						return retMap;
					}
				}
				// 04-2. usState 빈값 체크
				logger.debug("04-2. usState Null Check");
				if (!usState.equals("")) {
					break;
				}
				// 04-3. 동부 확인
				logger.debug("04-3. usState East Check");
				for (CommonVo commonVo : usStateEastList) {
					if (commonVo.getCode().equals(torderVo.getRecvState())) {
						usState = "east";
						logger.debug("usState : "+ usState);
						break;
					}
				}
				// 04-4. 서부 확인
				logger.debug("04-4. usState West Check");
				for (CommonVo commonVo : usStateWestList) {
					if (commonVo.getCode().equals(torderVo.getRecvState())) {
						usState = "west";
						logger.debug("usState : "+ usState);
						break;
					}
				}
			}

			if ("".equals(usState)) {
				logger.debug("code : 502, message : US에 소속되지 않은 주입니다.");
				Map<String, Object> retMap = new HashMap<>();
				retMap.put("code", "502");
				retMap.put("message", "US에 소속되지 않은 주입니다.");
				retMap.put("data", "");
				return retMap;
			}

			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "200");
			retMap.put("message", "정상적으로 처리되었습니다.");
			retMap.put("state", usState);
			retMap.put("data", shipmentList);
			return retMap;
		} catch (Exception e) {
			logger.debug("code : 500, message : 알수없는 오류가 발생하 였습니다.");
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "500");
			retMap.put("message", "알수없는 오류가 발생하 였습니다.");
			retMap.put("data", "");
			return retMap;
		}
	}

	@Override
	public Map<String, Object> shippoShipment(TorderVo torderVo, String state) {
		logger.debug("torderVo : "+ torderVo.toString() +", state : "+ state);

		try {

			String apiKey;
			Map<String, Object> fromAddressMap = new HashMap<String, Object>();
			fromAddressMap.put("name", "logifocus");
			fromAddressMap.put("company", "logifocus");
			fromAddressMap.put("country", "US");
			if ("east".equals(state)) {

				logger.debug("debugtype : "+ debugtype);

				if (debugtype.equals("DEV")) {
					apiKey = devShippoEastApiKey;
				} else {
					apiKey = realShippoEastApiKey;
				}

				fromAddressMap.put("street1", "207 REDNECK AVENUE");
				fromAddressMap.put("city", "LITTLE FERRY");
				fromAddressMap.put("state", "NJ");
				fromAddressMap.put("zip", "07643");
				fromAddressMap.put("phone", "+1 201-440-2972");
				fromAddressMap.put("email", "sjlee@logifocus.co.kr");
			} else {

				logger.debug("debugtype : "+ debugtype);

				if (debugtype.equals("DEV")) {
					apiKey = devShippoWestApiyKey;
				} else {
					apiKey = realShippoWestApiyKey;
				}

				fromAddressMap.put("street1", "361 E Jefferson Blvd");
				fromAddressMap.put("city", "Los Angeles");
				fromAddressMap.put("state", "CA");
				fromAddressMap.put("zip", "90011");
				fromAddressMap.put("phone", "+1 323-235-5000");
				fromAddressMap.put("email", "jay.chang@logifocus.co.kr");
			}

			Map<String, Object> toAddressMap = new HashMap<String, Object>();
			toAddressMap.put("name", torderVo.getRecvName());
			toAddressMap.put("company", "");
			toAddressMap.put("street1", torderVo.getRecvAddr1());
			toAddressMap.put("city", torderVo.getRecvCity());
			toAddressMap.put("state", torderVo.getRecvState());
			toAddressMap.put("zip", torderVo.getRecvPost());
			toAddressMap.put("country", "US");
			toAddressMap.put("email", "");
			toAddressMap.put("phone", torderVo.getRecvTel());

			List<Map<String, Object>> parcels = new ArrayList<>();
			Map<String, Object> parcel = new HashMap<>();
			parcel.put("length", "10");
			parcel.put("width", "10");
			parcel.put("height", "10");
			parcel.put("distance_unit", "cm");
			parcel.put("weight", torderVo.getWgt());
			parcel.put("mass_unit", "kg");
			parcels.add(parcel);

			logger.debug("ShippoAPI Start");
			ShippoImpl shippo = new ShippoImpl();
			Map<String, Object> shippoMap = shippo.shipment(apiKey, toAddressMap, fromAddressMap, parcels);
			if (!"200".equals(shippoMap.get("code"))) {
				logger.debug("code : "+ shippoMap.get("code") +", message : "+ shippoMap.get("message"));
				Map<String, Object> retMap = new HashMap<>();
				retMap.put("code", shippoMap.get("code"));
				retMap.put("message", shippoMap.get("message"));
				retMap.put("data", "");
				return retMap;
			}

			logger.debug("setter TorderVo ");
			String localShipper = "USPS";
			torderVo.setAmount((String) shippoMap.get("amount"));
			torderVo.setLocalShipper(localShipper);
			torderVo.setInvcSno1((String) shippoMap.get("trackingNumber"));
			torderVo.setShippoId((String) shippoMap.get("shippoId"));
			logger.debug("Update TorderByShippo");
			apiMapper.updateTorderByShippo(torderVo);

			Map<String, Object> dataMap = new HashMap<>();
			dataMap.put("AMOUNT", shippoMap.get("amount"));
			dataMap.put("LOCAL_SHIPPER", localShipper);
			dataMap.put("INVC_SNO1", shippoMap.get("trackingNumber"));
			dataMap.put("SHIPPO_ID", shippoMap.get("shippoId"));

			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "200");
			retMap.put("message", "정상적으로 처리되었습니다.");
			retMap.put("data", dataMap);
			return retMap;
		} catch (Exception e) {
			logger.debug("code : 500, message : "+ e.fillInStackTrace());
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "500");
			retMap.put("message", e.getMessage());
			retMap.put("data", "");
			return retMap;
		}
	}

	@Override
	public Map<String, Object> shippoRefund(List<TorderVo> shippoList, String state) {

		Map<String, Object> retMap = new HashMap<>();

		try {

			String shippoId;
			String amount;
			String invcSno1;

			for (TorderVo torderVo :  shippoList ) {

				amount = torderVo.getAmount();
				shippoId = torderVo.getShippoId();
				invcSno1 = torderVo.getInvcSno1();

				logger.debug("debugtype : "+ debugtype);

				String apiKey = "";
				if ("east".equals(state)) {
					if (debugtype.equals("DEV")) {
						apiKey = devShippoEastApiKey;
					} else {
						apiKey = realShippoEastApiKey;
					}

				} else {
					if (debugtype.equals("DEV")) {
						apiKey = devShippoWestApiyKey;
					} else {
						apiKey = realShippoWestApiyKey;
					}
				}

				String transaction = torderVo.getShippoId();
				ShippoAPI shippoAPI = new ShippoAPI();
				retMap = shippoAPI.refund(apiKey, transaction);
			}

			retMap.put("code", "200");
			retMap.put("message", "정상적으로 처리되었습니다.");
			retMap.put("data", "");
			return retMap;
		} catch (Exception e) {

			retMap.put("code", "500");
			retMap.put("message", "알수없는 오류가 발생하 였습니다.");
			retMap.put("data", "");
			return retMap;
		}
	}

	@Override
	public Map<String, Object> addAfterShipTrackings(ParamVo paramVo) {

		try {
			List<TorderVo> afterShipList = apiMapper.aftershipTrackings(paramVo);
			logger.debug("01. aftershipTrackings 조회");
			if (afterShipList.size() == 0) {
				logger.debug("code : 404, message : 데이터가 없습니다.");
				Map<String, Object> retMap = new HashMap<>();
				retMap.put("code", "404");
				retMap.put("message", "데이터가 없습니다.");
				return retMap;
			}

			logger.debug("02. aftershipVo Settings");
			AfterShipVo afterShipVo = new AfterShipVo();
			for (TorderVo torderVo : afterShipList) {

				afterShipVo.setSlug(torderVo.getLocalShipper().toLowerCase());
				afterShipVo.setTrackingNumber(torderVo.getInvcSno1());
				afterShipVo.setTitle("");

				List<String> emails = new ArrayList<>();
				emails.add("xroute@logifocus.co.kr");
				afterShipVo.setEmails(emails);
				afterShipVo.setOrderId(torderVo.getOrdNo());
				afterShipVo.setOrderIdPath("");
				Map<String, Object> customFileds = new HashMap<>();
				customFileds.put("productName", torderVo.getGoodsNm());
				customFileds.put("productPrice", torderVo.getPrice());

				afterShipVo.setCustomFields(customFileds);
				// TODO 해당 국가 언어로 변경해야하는 로직추가
				// trackingVo.setLanguage(xrtDatas.get(i).get("sNation").toString());
				afterShipVo.setLanguage("en");
				afterShipVo.setOrderPromisedDeliveryDate("");
				afterShipVo.setDeliveryType("pickup_at_courier");
				afterShipVo.setPickupLocation(torderVo.geteNation());
				afterShipVo.setPickupNote("");
			}

			Map<String, Object> retMap = afterShip.createTrackings(afterShipVo);
			return retMap;

		} catch (Exception e) {
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "404");
			retMap.put("message", "송장번호가 없습니다.");
			retMap.put("data", "");
			return retMap;
		}
	}

	@Override
	public Map<String, Object> efsGetTrackStatus(ParamVo paramVo) {

		Map<String, Object> retMap = new HashMap<>();

		String invcSno1 = paramVo.getInvcSno1();
		try {

			EfsAPI efsAPI = new EfsAPI();
			Map<String, Object> resMap = efsAPI.getTrackStatus(invcSno1);

			String[] changeData = resMap.get("data").toString().split("\\n");

			//실패한 경우
			if (Util.isEmpty(changeData) || !changeData[0].toUpperCase().contains(Util.getStrTrim("SUCCESSFULLY"))) {
				retMap.put("code", "500");
				retMap.put("message", "failed");
				retMap.put("invcsno", invcSno1);
				retMap.put("data", "");
			} else {
				//성공한 경우
				boolean updFlg = false;
				if (changeData.length > 0) {
					retMap.put("code", "200");
					retMap.put("invcsno", invcSno1);
					retMap.put("data", changeData);

					for(int i=1; i < changeData.length; i++) {
						logger.debug("changeData["+i+"] : "+changeData[i]);

						EfsTrackingStatusVo trackingInfoVo = new EfsTrackingStatusVo();

						String[] resultDtl = changeData[i].toString().split("\\|");

						trackingInfoVo.setEfsInvcSno(resultDtl[0]);          //Efs송장번호
						trackingInfoVo.setXrtInvcSno(resultDtl[1]);          //Xrt송장번호
						trackingInfoVo.setLocalShipper(resultDtl[2]);        //배송회사
						trackingInfoVo.setInvcSno(resultDtl[3]);             //배송번호
						trackingInfoVo.setEfsStatusCode(resultDtl[4]);       //최종배송상태코드
						trackingInfoVo.setEfsStatus(resultDtl[5]);           //최종배송상태값
						trackingInfoVo.setEfsStatysDate(resultDtl[6]);       //최종배송상태일시
						if (!Util.isEmpty(resultDtl[7])) {
							String[] wgtData = resultDtl[7].toString().split(",");
							//적용중량(kg), 실중량(kg), 가로(cm), 세로(cm), 높이(cm), 부피중량(kg)
							trackingInfoVo.setWgtCharge(wgtData[0]);
							trackingInfoVo.setWgtReal(wgtData[1]);
							trackingInfoVo.setBoxWidth(wgtData[2]);
							trackingInfoVo.setBoxLength(wgtData[3]);
							trackingInfoVo.setBoxHeight(wgtData[4]);
							trackingInfoVo.setWgtVolume(wgtData[5]);
						}
						trackingInfoVo.setShipMethodCd(resultDtl[8]);        //적용서비스타입
						trackingInfoVo.setShippingPrice(resultDtl[9]);       //배송비
						trackingInfoVo.setShippingNation(resultDtl[10]);     //배송상태국가

						//DB torder update (무게, 배송비, 배송번호)
						if (!Util.isEmpty(resultDtl[1]) && (!Util.isEmpty(resultDtl[2]) || !Util.isEmpty(resultDtl[3]) || !Util.isEmpty(resultDtl[7]))) {
							apiMapper.efsTrackingUpd(trackingInfoVo);
							updFlg = true;
						}
					}

					if (updFlg) {
						retMap.put("message", "정상적으로 처리되었습니다.");
					} else {
						retMap.put("message", "데이터 갱신처리에 문제가 발생했습니다.");
						retMap.put("code", "500");
						retMap.put("data", "");
					}
				}
			}

			return retMap;
		} catch (Exception e) {

			retMap.put("code", "500");
			retMap.put("message", "알수없는 오류가 발생하 였습니다.");
			retMap.put("invcsno", invcSno1);
			retMap.put("data", "");
			return retMap;
		}
	}

	@Override
	public ResResultVo createOrder(ReqOrderVo paramVo, ApiAuthKeyVo apiAuthKeyVo) throws Exception {

		ResResultVo resResultVo = this.paramValid(paramVo);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.processValid(paramVo);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.apiOrderProcess(paramVo, apiAuthKeyVo);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.tOrderProcess((ReqOrderVo) resResultVo.getResultData().get("data"), apiAuthKeyVo) ;

		return resResultVo;
	}

	/**
	 * API Request Param 검증
	 * @param paramVo
	 * @return
	 * @throws Exception
	 */
	public ResResultVo paramValid(ReqOrderVo paramVo) throws Exception {

		ResResultVo resResultVo = this.resultParamValid("InvcSno", paramVo.getInvcSno() , 30, false);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("Company", paramVo.getCompany() , 20, false);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("FileYmd", paramVo.getFileYmd() , 8, "^[0-9]+$");
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("StoreName", paramVo.getStoreName() , 20, false);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("SellerName", paramVo.getSellerName() , 30, false);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("OrderId", paramVo.getOrderId() , 20, false);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("CartId", paramVo.getCartId() , 30, true);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("BuyerName", paramVo.getBuyerName() , 20, false);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("ShipCountry", paramVo.getShipCountry() , 30, false);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("ShipCity", paramVo.getShipCity() , 100, false);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("ShipState", paramVo.getShipState() , 100, false);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("ShipPostalCode", paramVo.getShipPostalCode() , 20, false);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("ShipAddr1", paramVo.getShipAddr1() , 500, false);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("ShipAddr2", paramVo.getShipAddr2() , 100, true);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("ShipNumber1", paramVo.getShipNumber1() , 30, true);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		resResultVo = this.resultParamValid("ShipNumber2", paramVo.getShipNumber2() , 30, true);
		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		for (ReqItemVo itemVo : paramVo.getItemList()) {
			resResultVo = this.resultParamValid("ItemId", itemVo.getItemId() , 30, false);
			if (resResultVo.getResultCode() != 200) {
				return resResultVo;
			}

			resResultVo = this.resultParamValid("ItemName", itemVo.getItemName() , 30, false);
			if (resResultVo.getResultCode() != 200) {
				return resResultVo;
			}

			resResultVo = this.resultParamValid("ItemCount", itemVo.getItemCount() , 30, false);
			if (resResultVo.getResultCode() != 200) {
				return resResultVo;
			}

			resResultVo = this.resultParamValid("ItemPrice", itemVo.getItemPrice() , 30, "^[0-9]+$");
			if (resResultVo.getResultCode() != 200) {
				return resResultVo;
			}

			resResultVo = this.resultParamValid("ItemOption", itemVo.getItemOption() , 30, true);
			if (resResultVo.getResultCode() != 200) {
				return resResultVo;
			}
		}

		return resResultVo;
	}

	/**
	 * 프로세스 실행시 데이터 검증
	 * @param paramVo
	 * @return
	 */
	public ResResultVo processValid(ReqOrderVo paramVo) {
		ResResultVo resResultVo = new ResResultVo();

		Map<String, Object> paramMap = new HashMap<>();
		List<CommonVo> usStateList = apiMapper.getUSStateList(paramMap);

		String shipMethod = paramVo.getShipMethod();
		String country = paramVo.getShipCountry();
		String state = paramVo.getShipState();
		String currency = paramVo.getCurrency();

		switch (shipMethod) {
		case "PREMIUM":
			Boolean bState = false;
			if (country.equals("US")) {
				for (CommonVo commonVo : usStateList) {
					if (commonVo.getCode().equals(state)) {
						bState = true;
						break;
					}
				}

				if (bState == false) {
					resResultVo.setResultCode(404);
					resResultVo.setResultMessage("등록되지 않은 주입니다.");
					break;
				} else {
					resResultVo.setResultCode(200);
					resResultVo.setResultMessage("정상적으로 처리되었습니다.");
				}

				if (!currency.equals("USD")) {
					resResultVo.setResultCode(402);
					resResultVo.setResultMessage("Currency 정보가 틀렸습니다.");
				}
			} else {
				resResultVo.setResultCode(404);
				resResultVo.setResultMessage("현재 지원되지 않은 국가 입니다.");
			}
			break;

		default:
			resResultVo.setResultCode(404);
			resResultVo.setResultMessage("등록되지 않은 shipMethod 입니다.");
			break;
		}

		if (resResultVo.getResultCode() != 200) {
			return resResultVo;
		}

		Boolean bSpecialCharacter = false;
		for (ReqItemVo itemVo : paramVo.getItemList()) {
			if (Pattern.matches("^[a-zA-Z0-9\\s]*$", itemVo.getItemName()) == false) {
				resResultVo.setResultCode(401);
				resResultVo.setResultMessage("itemName은 영문, 숫자, 공백만 가능합니다.");
				break;
			} else {
				bSpecialCharacter = true;
			}
		}

		return resResultVo;
	}

	/**
	 *
	 * @param paramVo
	 * @param apiAuthKeyVo
	 * @return
	 * @throws Exception
	 */
	private ResResultVo apiOrderProcess(ReqOrderVo paramVo, ApiAuthKeyVo apiAuthKeyVo) throws Exception {

		ResResultVo resResultVo = new ResResultVo();

		paramVo.setCompcd(apiAuthKeyVo.getCompcd());
		paramVo.setOrgcd(apiAuthKeyVo.getOrgcd());
		paramVo.setWhcd(apiAuthKeyVo.getWhcd());
		paramVo.setAddusercd(apiAuthKeyVo.getUsercd());
		paramVo.setUpdusercd(apiAuthKeyVo.getUsercd());

		int fileSeq = apiMapper.getFileSeq(paramVo) + 1;
		paramVo.setFileSeq(Integer.toString(fileSeq));

		int insertCount = apiMapper.insertApiOrderMaster(paramVo);
		int itemOrder = 1;
		for (ReqItemVo itemVo : paramVo.getItemList()) {
			itemVo.setOrderId(paramVo.getOrderId());
			itemVo.setInvcSno(paramVo.getInvcSno());
			itemVo.setCompcd(apiAuthKeyVo.getCompcd());
			itemVo.setItemOrder(itemOrder +"");
			itemVo.setOrgcd(apiAuthKeyVo.getOrgcd());
			itemVo.setWhcd(apiAuthKeyVo.getWhcd());
			itemVo.setAddusercd(apiAuthKeyVo.getUsercd());
			itemVo.setUpdusercd(apiAuthKeyVo.getUsercd());
			itemVo.setTerminalcd(paramVo.getTerminalcd());
			insertCount = apiMapper.insertApiOrderItem(itemVo);
			itemOrder++;
			Thread.sleep(10);
		}

		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("data", paramVo);
		resResultVo.setResultCode(200);
		resResultVo.setResultMessage("정상적으로 처리되었습니다.");
		resResultVo.setResultData(dataMap);

		return resResultVo;
	}

	/**
	 * @param orderVo
	 * @param apiAuthKeyVo
	 * @return
	 * @throws Exception
	 */
	private ResResultVo tOrderProcess(ReqOrderVo orderVo, ApiAuthKeyVo apiAuthKeyVo) throws Exception {
		logger.debug("orderVo : "+ orderVo +", apiAuthKeyVo : "+ apiAuthKeyVo +", itemList : "+ orderVo.getItemList().toString());

		logger.debug("1. 셀러정보 조회");
		List<LDataMap> sellerList = apiMapper.getSeller(apiAuthKeyVo);
		Object fileSeq = apiMapper.getTorderFileSeq(orderVo);
		Object relaySeq = apiMapper.getTorderRelaySeq(orderVo);

		int fileCount = (Integer) fileSeq + 1;
		int relayCount = (Integer) relaySeq + 1;
		int fileRelayCount = 1;
		int totalPrice = 0;
		for (ReqItemVo itemVo : orderVo.getItemList()) {
			totalPrice += Integer.parseInt(itemVo.getItemPrice());
		}

		TOrderVo torderVo = new TOrderVo();
		torderVo.setCompcd(orderVo.getCompcd());
		torderVo.setOrgcd(orderVo.getOrgcd());
		torderVo.setWhcd(orderVo.getWhcd());
		torderVo.setUploadDate(orderVo.getFileYmd());
		torderVo.setFileSeq(fileCount +"");
		torderVo.setFileNm(fileCount +"차");
		torderVo.setFileNmReal("API Order Upload");
		torderVo.setSiteCd("30112");
		torderVo.setStatusCd("10");
		torderVo.setStockType("1");
		torderVo.setMallNm(sellerList.get(0).getString("NAME"));
		torderVo.setShipMethodCd(orderVo.getShipMethod());
		torderVo.setOrdNo(orderVo.getOrderId());
		torderVo.setCartNo(orderVo.getCartId());
		torderVo.setOrdCnt(orderVo.getItemList().size() +"");
		torderVo.setsNation("KR");
		torderVo.seteNation(orderVo.getShipCountry());
		torderVo.setShipName(sellerList.get(0).getString("NAME"));
		torderVo.setShipTel(sellerList.get(0).getString("TEL1"));
		torderVo.setShipMobile(sellerList.get(0).getString("TEL2"));
		torderVo.setShipAddr(sellerList.get(0).getString("ENG_ADDR"));
		torderVo.setShipPost(sellerList.get(0).getString("POST"));
		torderVo.setRecvName(orderVo.getBuyerName());
		torderVo.setRecvTel(orderVo.getShipNumber1());
		torderVo.setRecvMobile(orderVo.getShipNumber2());
		torderVo.setRecvAddr1(orderVo.getShipAddr1());
		torderVo.setRecvAddr2(orderVo.getShipAddr2());
		torderVo.setRecvCity(orderVo.getShipCity());
		torderVo.setRecvState(orderVo.getShipState());
		torderVo.setRecvPost(orderVo.getShipPostalCode());
		torderVo.setRecvNation(orderVo.getShipCountry());
		torderVo.setRecvCurrency(orderVo.getCurrency());
		torderVo.setTotPaymentPrice(Integer.toString(totalPrice));
		torderVo.setAddusercd(orderVo.getAddusercd());
		torderVo.setUpdusercd(orderVo.getUpdusercd());
		torderVo.setTerminalcd(orderVo.getTerminalcd());
		torderVo.setRelaySeq(relayCount);
		torderVo.setFileRelaySeq(fileRelayCount);
		torderVo.setPaymentType(sellerList.get(0).getString("PAYMENT_TYPE"));
		torderVo.setApiInvcSno(orderVo.getInvcSno());
		apiMapper.insertTorder(torderVo);

		for (ReqItemVo itemVo : orderVo.getItemList()) {
			TOrderDtlVo tOrderDtlVo = new TOrderDtlVo();
			tOrderDtlVo.setOrdCd(torderVo.getOrdCd());
			tOrderDtlVo.setOrdSeq(Long.parseLong(itemVo.getItemOrder()));
			tOrderDtlVo.setCompcd(itemVo.getCompcd());
			tOrderDtlVo.setOrgcd(itemVo.getOrgcd());
			tOrderDtlVo.setGoodsCd(itemVo.getOrderId());
			tOrderDtlVo.setGoodsNm(itemVo.getItemName());
			tOrderDtlVo.setGoodsOption("");
			tOrderDtlVo.setGoodsCnt(itemVo.getItemCount());
			tOrderDtlVo.setPaymentPrice(itemVo.getItemPrice());
			tOrderDtlVo.setAddusercd(itemVo.getAddusercd());
			tOrderDtlVo.setUpdusercd(itemVo.getUpdusercd());
			tOrderDtlVo.setOrdNo(itemVo.getOrderId());
			tOrderDtlVo.setTerminalcd(itemVo.getTerminalcd());
			apiMapper.insertTOrderDtl(tOrderDtlVo);
			Thread.sleep(100);
		}

		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("xrtInvcSno", torderVo.getXrtInvcSno());
		ResResultVo resResultVo = new ResResultVo();
		resResultVo.setResultCode(200);
		resResultVo.setResultMessage("정상적으로 처리되었습니다.");
		resResultVo.setResultData(dataMap);

		return resResultVo;
	}

	/**
	 * API Request Param 검증 공통 결과
	 * @param key
	 * @param value
	 * @param valueLength
	 * @param nullChecked
	 * @return
	 */
	public ResResultVo resultParamValid(String key, String value, int valueLength, Boolean nullChecked) {

		ResResultVo resResultVo = new ResResultVo();
		if (nullChecked == false){
			if (value == null) {
				resResultVo.setResultCode(404);
				resResultVo.setResultMessage(key +"는(은) 정보가 누락되었습니다.");
				return resResultVo;
			} else if (value.equals("")) {
				resResultVo.setResultCode(404);
				resResultVo.setResultMessage(key +"는(은) 정보가 누락되었습니다.");
				return resResultVo;
			} else if (value.length() > valueLength) {
				resResultVo.setResultCode(400);
				resResultVo.setResultMessage(key +"는(은) 최대 "+ valueLength +"자까지 입력가능합니다.");
				return resResultVo;
			}
		} else {
			if (value.length() > valueLength) {
				resResultVo.setResultCode(400);
				resResultVo.setResultMessage(key +"는(은) 최대 "+ valueLength +"자까지 입력가능합니다.");
				return resResultVo;
			}
		}

		resResultVo.setResultCode(200);
		resResultVo.setResultMessage("정상적으로 처리되었습니다.");
		return resResultVo;
	}

	/**
	 * API Request Param 검증 공통 결과
	 * @param key
	 * @param value
	 * @param valueLength
	 * @param pattern
	 * @return
	 */
	public ResResultVo resultParamValid(String key, String value, int valueLength, String pattern) {

		ResResultVo resResultVo = new ResResultVo();
		if (value == null) {
			resResultVo.setResultCode(404);
			resResultVo.setResultMessage(key +"는(은) 정보가 누락되었습니다.");
			return resResultVo;
		} else if (value.equals("")) {
			resResultVo.setResultCode(404);
			resResultVo.setResultMessage(key +"는(은) 정보가 누락되었습니다.");
			return resResultVo;
		} else if (value.length() > valueLength) {
			resResultVo.setResultCode(400);
			resResultVo.setResultMessage(key +"는(은) 최대 "+ valueLength +"자까지 입력가능합니다.");
			return resResultVo;
		} else if (value.matches(pattern) == false) {
			resResultVo.setResultCode(401);
			resResultVo.setResultMessage(key +"는(은) 숫자만 입력가능합니다.");
			return resResultVo;
		}

		resResultVo.setResultCode(200);
		resResultVo.setResultMessage("정상적으로 처리되었습니다.");
		return resResultVo;
	}
}
