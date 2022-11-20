package xrt.fulfillment.interfaces;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.api.efs.EfsAPI;
import xrt.alexcloud.api.efs.vo.EfsShipmentVo;
import xrt.alexcloud.api.etomars.EtomarsAPI;
import xrt.alexcloud.api.etomars.vo.EtomarsOrderDtlVo;
import xrt.alexcloud.api.etomars.vo.EtomarsShipmentVo;
import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.interfaces.vo.InterfaceSettingVo;
import xrt.fulfillment.interfaces.vo.TOrderDtlVo;
import xrt.fulfillment.interfaces.vo.TOrderVo;
import xrt.fulfillment.order.orderinsert.ShippingDataVo;
import xrt.interfaces.common.vo.EfsOrderDtlVo;
import xrt.interfaces.qxpress.QxpressAPI;
import xrt.interfaces.qxpress.vo.QxpressVo;
import xrt.interfaces.shopee.Shopee;
import xrt.interfaces.shopee.vo.ShopeeOrderItemsVo;
import xrt.interfaces.shopee.vo.ShopeeOrderVo;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.Util;

@Service
public class ShopeeOrderBiz extends DefaultBiz {

	@Resource
	Shopee shopee;

	@Resource
	EfsAPI efsAPI;

	@Resource
	EtomarsAPI etomarsAPI;

	@Resource
	QxpressAPI qxpress;

	Logger logger = LoggerFactory.getLogger(ShopeeOrderBiz.class);

	List<ShopeeOrderVo> getSearch(CommonSearchVo paramVo) throws Exception {
		return  dao.selectList("ShopeeOrderMapper.getSearch", paramVo);
	}

	public Map<String, Object> getShopeeOrderList(Map<String, Object> paramMap) throws Exception {
		logger.debug("[getShopeeOrderList] Map<String, Object>  : "+ paramMap.toString());

		logger.debug("01. Shopee 기본 정보 조회");
		List<InterfaceSettingVo> shopeeList = dao.selectList("ShopeeOrderMapper.getAPIData", paramMap);

		if (shopeeList.size() == 0) {
			throw new LingoException("등록된 Shopee 정보가 없습니다. 등록해주세요.");
		}

		logger.debug("shopeeList  : "+ shopeeList.toString());
		logger.debug("02. Shopee 기본 정보 생성");
		String partnerId = shopeeList.get(0).getAuthId();
		String partnerKey = shopeeList.get(0).getAuthKey();
		String shopId = shopeeList.get(0).getEtcKey();
		String toDate = (String) paramMap.get("toDate");
		String fromDate = (String) paramMap.get("toDate");
		String orgCd;
		String whcd;
		String usercd = paramMap.get("userCd").toString();
		String compcd = paramMap.get("compCd").toString();
		String clientIp = paramMap.get("clientIp").toString();
		Object oOrgCd = paramMap.get("orgCd");
		Object oWhcd = paramMap.get("whCd");

		if (oOrgCd == null) {
			orgCd = "9999";
		} else {
			orgCd = oOrgCd.toString();
		}
		if (oWhcd == null) {
			whcd = "9999";
		} else {
			whcd = oWhcd.toString();
		}
		logger.debug("03. Shopee 파라메터 생성");
		Map<String, Object> shopeeParamMap = new HashMap<>();
		shopeeParamMap.put("shopId", shopId);
		shopeeParamMap.put("partnerId", partnerId);
		shopeeParamMap.put("partnerKey", partnerKey);
		shopeeParamMap.put("toDate", toDate);
		shopeeParamMap.put("fromDate", fromDate);
		shopeeParamMap.put("count", paramMap.get("count"));
		logger.debug("04. Shopee OrderList 호출");
		Map<String, Object> orderMap = shopee.getOrdersList(shopeeParamMap);
		logger.debug("05. Shopee OrderList 확인");
		if (!orderMap.get("code").equals("200")) {
			logger.debug("code : "+ orderMap.get("code") +", message : "+ orderMap.get("message"));
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", orderMap.get("code"));
			retMap.put("message", orderMap.get("message"));

			return retMap;
		}

		List<Map<String, Object>> shopeeOrderList = (List<Map<String, Object>>) orderMap.get("data");
		List<Map<String, Object>> readyToshipList = shopeeOrderList.stream().filter(x -> "READY_TO_SHIP".equals(x.get("order_status"))).collect(Collectors.toList());

		logger.debug("readyToshipList.size() :"+ readyToshipList.size());
		logger.debug("readyToshipList :"+ readyToshipList.toString());

		logger.debug("06. Shopee OrderDetail 호출");
		shopeeParamMap.put("data", readyToshipList);
		Map<String, Object> orderDtlMap  = shopee.getOrderDetails(shopeeParamMap);
		Map<String, Object> data = (Map<String, Object>) orderDtlMap.get("data");
		List<Map<String, Object>> errorList  = (List<Map<String, Object>>) data.get("errors");
		List<Map<String, Object>> orderList  = (List<Map<String, Object>>) data.get("orders");

		Date toDay = new Date();
		SimpleDateFormat yyyymmdd = new SimpleDateFormat("yyyyMMdd");
		paramMap.put("fileYmd", yyyymmdd.format(toDay));

		Object fileSeq = dao.selectOne("ShopeeOrderMapper.getShopeeFileSeq",paramMap);
		int iFileSeq = (Integer) fileSeq + 1;

		for (Map<String, Object> order : orderList) {
			logger.debug("06-01. order : "+ order.toString());
			Map<String, Object> recipientAddressMap = (Map<String, Object>) order.get("recipient_address");
			logger.debug("06-02. recipientAddressMap : "+ recipientAddressMap.toString());

			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss z");

			long lCreateTime = 0;
			long lPayTime = 0;
			long lNoteUpdateTime = 0;
			long lUpdateTime = 0;

			if (order.get("create_time") != null) {
				lCreateTime = (long) order.get("create_time") * 1000;
			}

			if (order.get("pay_time") != null) {
				lPayTime = (long) order.get("pay_time") * 1000;
			}

			if (order.get("note_update_time") != null) {
				lNoteUpdateTime = (long) order.get("note_update_time") * 1000;
			}

			if (order.get("update_time") != null) {
				lUpdateTime = (long) order.get("update_time") * 1000;
			}

			String sCreateTime = (lCreateTime != 0 ? simpleDateFormat.format(lCreateTime) : Long.toString(lCreateTime));
			String sPayTime = (lPayTime != 0 ? simpleDateFormat.format(lPayTime) : Long.toString(lPayTime));
			String sNoteUpdateTime = (lNoteUpdateTime != 0 ? simpleDateFormat.format(lNoteUpdateTime) : Long.toString(lNoteUpdateTime));
			String sUpdateTime = (lUpdateTime != 0 ? simpleDateFormat.format(lUpdateTime) : Long.toString(lUpdateTime));

			ShopeeOrderVo shopeeOrderVo = new ShopeeOrderVo();
			shopeeOrderVo.setFileSeq(iFileSeq);
			shopeeOrderVo.setEstimatedShippingFee(order.get("estimated_shipping_fee").toString());
			shopeeOrderVo.setPaymentMethod(order.get("payment_method").toString());
			shopeeOrderVo.setDropshipperPhone(order.get("dropshipper_phone").toString());
			shopeeOrderVo.setMessageToSeller(order.get("message_to_seller").toString());
			shopeeOrderVo.setShippingCarrier(order.get("shipping_carrier").toString());
			shopeeOrderVo.setCurrency(order.get("currency").toString());
			logger.debug("06-03. currency : "+ order.get("currency"));
			shopeeOrderVo.setCreateTime(sCreateTime);
			shopeeOrderVo.setPayTime(sPayTime);
			shopeeOrderVo.setDaysToShip((long) order.get("days_to_ship"));
			shopeeOrderVo.setNote(order.get("note").toString());
			shopeeOrderVo.setSplitUp((boolean) order.get("is_split_up"));
			shopeeOrderVo.setShipByDate((long) order.get("ship_by_date"));
			logger.debug("06-04. ship_by_date : "+ order.get("ship_by_date"));
			shopeeOrderVo.setCancelBy(order.get("cancel_by").toString());
			shopeeOrderVo.setTrackingNo(order.get("tracking_no").toString());
			shopeeOrderVo.setOrderStatus(order.get("order_status").toString());
			shopeeOrderVo.setNoteUpdateTime(sNoteUpdateTime);
			shopeeOrderVo.setFmTn(order.get("fm_tn").toString());
			shopeeOrderVo.setUpdateTime(sUpdateTime);
			logger.debug("06-05. update_time : "+ sUpdateTime);
			shopeeOrderVo.setCancelReason(order.get("cancel_reason").toString());
			shopeeOrderVo.setEscrowAmount(order.get("escrow_amount").toString());
			shopeeOrderVo.setGoodsToDeclare((boolean) order.get("goods_to_declare"));
			shopeeOrderVo.setTotalAmount(order.get("total_amount").toString());
			shopeeOrderVo.setServiceCode(order.get("service_code").toString());
			logger.debug("06-06. country : "+ order.get("country"));
			shopeeOrderVo.setCountry(order.get("country").toString());
			shopeeOrderVo.setActualShippingCost(order.get("actual_shipping_cost").toString());
			shopeeOrderVo.setCod((boolean) order.get("cod"));
			shopeeOrderVo.setOrdersn(order.get("ordersn").toString());
			shopeeOrderVo.setDropshipper(order.get("dropshipper").toString());
			shopeeOrderVo.setBuyerUsername(order.get("buyer_username").toString());
			logger.debug("06-07. buyer_username : "+ order.get("buyer_username"));
			shopeeOrderVo.setRecvTown(recipientAddressMap.get("town").toString());
			shopeeOrderVo.setRecvCity(recipientAddressMap.get("city").toString());
			shopeeOrderVo.setRecvName(recipientAddressMap.get("name").toString());
			shopeeOrderVo.setRecvDistrict(recipientAddressMap.get("district").toString());
			shopeeOrderVo.setRecvCountry(recipientAddressMap.get("country").toString());
			shopeeOrderVo.setRecvZipcode(recipientAddressMap.get("zipcode").toString());
			shopeeOrderVo.setRecvFullAddress(recipientAddressMap.get("full_address").toString());
			shopeeOrderVo.setRecvPhone(recipientAddressMap.get("phone").toString());
			shopeeOrderVo.setRecvState(recipientAddressMap.get("state").toString());
			logger.debug("06-08. state : "+ recipientAddressMap.get("state"));
			shopeeOrderVo.setUsercd(usercd);
			shopeeOrderVo.setCompcd(compcd);
			shopeeOrderVo.setOrgcd(orgCd);
			shopeeOrderVo.setWhcd(whcd);
			shopeeOrderVo.setRegYn("N");
			shopeeOrderVo.setIpAddr(clientIp);
			logger.debug("06-09. clientIp : "+ clientIp);

			Map<String, Object> param = new HashMap<>();
			param.put("ordersn", order.get("ordersn").toString());
			param.put("usercd", usercd);
			param.put("compcd", compcd);
			param.put("orgcd", orgCd);

			Object selectCount = dao.selectOne("ShopeeOrderMapper.getShopeeOrderCount", param);
			int count = (Integer) selectCount;
			logger.debug("selectCount : "+ count);

			if (count == 0 ) {
				dao.insert("ShopeeOrderMapper.insertTempShopeeOrder", shopeeOrderVo);

				List<Map<String, Object>> itemsList = (List<Map<String, Object>>) order.get("items");
				for (Map<String, Object> item : itemsList) {
					logger.debug("06-02. item : "+ item.toString());
					ShopeeOrderItemsVo shopeeOrderItemsVo = new ShopeeOrderItemsVo();
					shopeeOrderItemsVo.setOrdersn(order.get("ordersn").toString());
					shopeeOrderItemsVo.setWeight((double) item.get("weight"));
					shopeeOrderItemsVo.setItemName(item.get("item_name").toString());
					shopeeOrderItemsVo.setWholesale((boolean) item.get("is_wholesale"));
					shopeeOrderItemsVo.setPromotionType(item.get("promotion_type").toString());
					shopeeOrderItemsVo.setItemSku(item.get("item_sku").toString());
					shopeeOrderItemsVo.setVariationDiscountedPrice(item.get("variation_discounted_price").toString());
					shopeeOrderItemsVo.setVariationId((long) item.get("variation_id"));
					shopeeOrderItemsVo.setVariationName(item.get("variation_name").toString());
					shopeeOrderItemsVo.setAddOnDeal((boolean) item.get("is_add_on_deal"));
					shopeeOrderItemsVo.setItemId((long) item.get("item_id"));
					shopeeOrderItemsVo.setPromotionId((long) item.get("promotion_id"));
					shopeeOrderItemsVo.setAddOnDealId((long) item.get("add_on_deal_id"));
					shopeeOrderItemsVo.setVariationQuantityPurchased((long) item.get("variation_quantity_purchased"));
					shopeeOrderItemsVo.setVariationSku(item.get("variation_sku").toString());
					shopeeOrderItemsVo.setVariationOriginalPrice(item.get("variation_original_price").toString());
					shopeeOrderItemsVo.setMainItem((boolean) item.get("is_main_item"));
					shopeeOrderItemsVo.setUsercd(usercd);
					shopeeOrderItemsVo.setCompcd(compcd);
					shopeeOrderItemsVo.setOrgcd(orgCd);
					shopeeOrderItemsVo.setWhcd(whcd);

					dao.insert("ShopeeOrderMapper.insertTempShopeeOrderItem", shopeeOrderItemsVo);

					Thread.sleep(100);
				}
			}

			Thread.sleep(100);
		}

		Map<String, Object> retMap = new HashMap<>();
		retMap.put("code", "200");
		retMap.put("message", "정상적으로 처리되었습니다.");
		return retMap;
	}

	public Map<String, Object> shopeeOrderListToXrouteTorder(CommonSearchVo paramVo, String clientIp) throws Exception {
		logger.debug("[shopeeOrderListToXrouteTorder] CommonSearchVo : "+ paramVo.toString());

		logger.debug("01. 등록되지 않은 ShopeeOrderList 가져오기");

		String orgcd = (paramVo.getsOrgCd() == null ? "9999" : paramVo.getsOrgCd());
		String whcd = (paramVo.getsWhcd() == null ? "9999" : paramVo.getsWhcd());
		paramVo.setsOrgCd(orgcd);
		paramVo.setsWhcd(whcd);

		List<ShopeeOrderVo> shopeeOrderList = dao.selectList("ShopeeOrderMapper.getShopeeOrderList", paramVo);
		if (shopeeOrderList.size() == 0) {
			logger.debug("code : 404, message : 등록되지 않은 쇼피정보가 없습나다.");
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "404");
			retMap.put("message", "등록되지 않은 쇼피주문정보가 없습나다.");
			return retMap;
		}
		logger.debug("02. Shopee 기본 정보 조회");
		List<InterfaceSettingVo> shopeeList = dao.selectList("ShopeeOrderMapper.getAccountData", paramVo);
		if (shopeeList.size() == 0) {
			throw new LingoException("등록된 Shopee 정보가 없습니다. 등록해주세요.");
		}

		if (shopeeList.get(0).getPaymentType() == null) {
			throw new LingoException("센터 사용자는 등록 할 수 없습니다.");
		}

		String shipMethod = shopeeList.get(0).getShipMethod();
		String enAddress = shopeeList.get(0).getEnAddress();
		String koAddress = shopeeList.get(0).getKoAddress();
		String post = shopeeList.get(0).getPost();
		String phoneNumber = shopeeList.get(0).getPhoneNumber();
		String paymentType= shopeeList.get(0).getPaymentType();

		Date toDay = new Date();
		SimpleDateFormat yyyymmdd = new SimpleDateFormat("yyyyMMdd");

		logger.debug("03. fileSeq, relaySeq 조회");
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("compcd", paramVo.getsCompCd());
		paramMap.put("ogrcd", orgcd);
		paramMap.put("fileYmd", yyyymmdd.format(toDay));
		Object fileSeq = dao.selectOne("ShopeeOrderMapper.getTorderFileSeq", paramMap);
		Object relaySeq = dao.selectOne("ShopeeOrderMapper.getRelaySeq", paramMap);

		int fileCount = (Integer) fileSeq + 1;
		int relayCount = (Integer) relaySeq + 1;
		int fileRelayCount = 1;

		logger.debug("04. fileSeq, relaySeq 조회");

		for (ShopeeOrderVo shopeeOrderVo : shopeeOrderList) {

			List<ShopeeOrderItemsVo> shopeeOrderItemsList = dao.selectList("ShopeeOrderMapper.getShopeeOrderItemList", shopeeOrderVo);

			String totalItemPrice = shopeeOrderItemsList.get(0).getTotalPrice();
			String orderCount = shopeeOrderItemsList.get(0).getOrderCount();

			TOrderVo torderVo = new TOrderVo();
			torderVo.setCompcd(paramVo.getsCompCd());
			torderVo.setOrgcd(orgcd);
			torderVo.setWhcd(whcd);
			torderVo.setUploadDate(shopeeOrderVo.getAdddatetime());
			torderVo.setFileSeq(fileCount +"");
			torderVo.setFileNm(fileCount +"차");
			torderVo.setFileNmReal("SHOPEE ORDER LIST API");
			torderVo.setSiteCd("30112");
			torderVo.setStatusCd("10");
			torderVo.setStockType("1");
			torderVo.setMallNm("SHOPEE");
			torderVo.setShipMethodCd(shipMethod);
			torderVo.setOrdNo(shopeeOrderVo.getOrdersn());
			torderVo.setCartNo(shopeeOrderVo.getOrdersn());
			torderVo.setOrdCnt(orderCount);
			torderVo.setsNation("KR");
			torderVo.seteNation(shopeeOrderVo.getRecvCountry());
			torderVo.setShipName(shopeeOrderVo.getBuyerUsername());
			torderVo.setShipTel("");
			torderVo.setShipMobile(phoneNumber);
			torderVo.setShipAddr(enAddress);
			torderVo.setShipPost(post);
			torderVo.setRecvName(shopeeOrderVo.getRecvName());
			torderVo.setRecvTel(shopeeOrderVo.getRecvPhone());
			torderVo.setRecvMobile(shopeeOrderVo.getRecvPhone());
			torderVo.setRecvAddr1(shopeeOrderVo.getRecvFullAddress());
			torderVo.setRecvAddr2(".");
			torderVo.setRecvCity(shopeeOrderVo.getRecvCity());
			torderVo.setRecvState(shopeeOrderVo.getRecvState());
			torderVo.setRecvPost(shopeeOrderVo.getRecvZipcode());
			torderVo.setRecvNation(shopeeOrderVo.getRecvCountry());
			torderVo.setRecvCurrency(shopeeOrderVo.getCurrency());
			torderVo.setTotPaymentPrice(shopeeOrderVo.getTotalAmount());
			torderVo.setAddusercd(paramVo.getsUserCd());
			torderVo.setUpdusercd(paramVo.getsUserCd());
			torderVo.setTerminalcd(clientIp);
			torderVo.setRelaySeq(relayCount);
			torderVo.setFileRelaySeq(fileRelayCount);
			torderVo.setPaymentType(paymentType);

			dao.insert("ShopeeOrderMapper.insertTorder", torderVo);

			Long itemCount = 1L;

			logger.debug("itemCount++ : "+ itemCount++);
			logger.debug("torderVo :"+ torderVo.toString());

			for (ShopeeOrderItemsVo shopeeOrderItemsVo : shopeeOrderItemsList) {

				TOrderDtlVo tOrderDtlVo = new TOrderDtlVo();

				tOrderDtlVo.setOrdCd(torderVo.getOrdCd());
				tOrderDtlVo.setOrdSeq(itemCount);
				tOrderDtlVo.setCompcd(paramVo.getsCompCd());
				tOrderDtlVo.setOrgcd(paramVo.getsOrgCd());
				tOrderDtlVo.setGoodsCd(Long.toString(shopeeOrderItemsVo.getItemId()));
				tOrderDtlVo.setGoodsNm(shopeeOrderItemsVo.getItemName());
				tOrderDtlVo.setGoodsOption("");
				tOrderDtlVo.setGoodsCnt(Long.toString(shopeeOrderItemsVo.getVariationQuantityPurchased()));
				tOrderDtlVo.setPaymentPrice(shopeeOrderItemsVo.getVariationOriginalPrice());
				tOrderDtlVo.setAddusercd(paramVo.getsUserCd());
				tOrderDtlVo.setUpdusercd(paramVo.getsUserCd());
				tOrderDtlVo.setOrdNo(shopeeOrderVo.getOrdersn());
				tOrderDtlVo.setTerminalcd(clientIp);

				dao.insert("ShopeeOrderMapper.insertTOrderDtl", tOrderDtlVo);

				itemCount++;
				Thread.sleep(100);
			}

			dao.update("ShopeeOrderMapper.updateTempShopeeOrder", shopeeOrderVo);

			relayCount++;
			fileRelayCount++;
			Thread.sleep(100);
		}

		Map<String, Object> retMap = new HashMap<>();
		retMap.put("code", "200");
		retMap.put("message", "정상적으로 처리되었습니다.");
		return retMap;
	}

	public Map<String, Object> getAgencyInvoicNumber(CommonSearchVo paramVo, String clientIp) throws Exception {
		logger.debug("[getAgencyInvoicNumber] CommonSearchVo : "+ paramVo.toString());

		String orgcd = (paramVo.getsOrgCd() == null ? "9999" : paramVo.getsOrgCd());
		String whcd = (paramVo.getsWhcd() == null ? "9999" : paramVo.getsWhcd());
		paramVo.setsOrgCd(orgcd);
		paramVo.setsWhcd(whcd);

		List<TOrderVo> tOrderList = dao.selectList("ShopeeOrderMapper.getTorderList",paramVo);

		if (tOrderList.size() == 0) {
			throw new LingoException("가져올 데이타가 없습니다.");
		}

		ShippingDataVo shippingDataVo = new ShippingDataVo();
		List efsOrderList = new ArrayList();
		List qxpressOrderList = new ArrayList();
		List etomarsOrderList = new ArrayList();

		for (TOrderVo tOrderVo : tOrderList) {
			logger.debug("tOrderVo : " + tOrderVo.toString());
			String eNation = tOrderVo.geteNation().toUpperCase();
			String shipMethod = tOrderVo.getShipMethodCd().toUpperCase();

			switch (eNation) {
			case "US":
				// 미국
				if ("DHL".equals(shipMethod) || "EMS".equals(shipMethod) || "K-PACKET".equals(shipMethod)) {
					// EFS API연동
					// NORMAL은 체크처리에서 걸러냄.
					// PREMIUM은 쉬포. (입고스캔화면에서 송장처리)
					EfsShipmentVo efsOrderData = efsShippingData(tOrderVo);
					efsOrderList.add(efsOrderData);
				}
				break;

			case "TW":
				// 대만
				if ("DHL".equals(shipMethod) || "EMS".equals(shipMethod) || "K-PACKET".equals(shipMethod)) {
					// EFS API연동
					// NORMAL은 체크처리에서 걸러냄.
					EfsShipmentVo efsOrderData = efsShippingData(tOrderVo);
					efsOrderList.add(efsOrderData);
				} else if ("PREMIUM".equals(shipMethod)){
					// PREMIUM
					// Tolos API연동 제거. 20200115 jy.hong
					//					TolosShipmentVo tolosOrderData = tolosShippingData(tOrder);
					//					tolosOrderList.add(tolosOrderData);
					List<QxpressVo> qxpressVos = qxpressShippingData(tOrderVo);
					qxpressOrderList.addAll(qxpressVos);
				} else {
					logger.info("지원하지 않은 배송타입 입니다.");
				}
				break;

			case "JP":
				// 일본
				if ("DHL".equals(shipMethod) || "EMS".equals(shipMethod) || "K-PACKET".equals(shipMethod)) {
					// EFS API연동
					EfsShipmentVo efsOrderData = efsShippingData(tOrderVo);
					efsOrderList.add(efsOrderData);
				} else if ("NORMAL".equals(shipMethod)) {
					// ETOMARS API 연동
					EtomarsShipmentVo etomarsOrderData = etomarsShippingData(tOrderVo);
					etomarsOrderList.add(etomarsOrderData);
				} else {
					// PREMIUM
					// TODO QXEXPRESS API 연동
					List<QxpressVo> qxpressVos = qxpressShippingData(tOrderVo);
					qxpressOrderList.addAll(qxpressVos);
				}
				break;

			case "HK":
			case "SG":
				// 홍콩, 싱가포르
				if ("DHL".equals(shipMethod) || "EMS".equals(shipMethod) || "K-PACKET".equals(shipMethod)) {
					// EFS API연동
					EfsShipmentVo efsOrderData = efsShippingData(tOrderVo);
					efsOrderList.add(efsOrderData);
				} else if ("PREMIUM".equals(shipMethod)){
					List<QxpressVo> qxpressVos = qxpressShippingData(tOrderVo);
					qxpressOrderList.addAll(qxpressVos);
				} else {
					logger.info("지원하지 않은 배송타입 입니다.");
				}
				break;

			case "PH":
			case "MY":
			case "ID":
			case "TH":
				if ("PREMIUM".equals(shipMethod) || "DHL".equals(shipMethod) || "EMS".equals(shipMethod) || "K-PACKET".equals(shipMethod)) {
					// EFS API연동
					EfsShipmentVo efsOrderData = efsShippingData(tOrderVo);
					efsOrderList.add(efsOrderData);
				} else {
					logger.info("지원하지 않은 배송타입 입니다.");
				}
				break;

			default:
				if ("DHL".equals(shipMethod) || "EMS".equals(shipMethod) || "K-PACKET".equals(shipMethod)) {
					// EFS API연동
					EfsShipmentVo efsOrderData2 = efsShippingData(tOrderVo);
					efsOrderList.add(efsOrderData2);
				} else {
					logger.info("지원하지 않은 배송타입 입니다.");
				}
			}
		}
		// 오더등록리스트의 사이즈가 0보다 큰경우, VO에 담아서 반환
		// EFS
		if (efsOrderList.size() > 0) {
			shippingDataVo.setEfsShipmentVos(efsOrderList);
		}
		// ETOMARS
		if (etomarsOrderList.size() > 0) {
			shippingDataVo.setEtomarsShipmentVos(etomarsOrderList);
		}
		// Tolos API연동 제거. 20200115 jy.hong
		//		// TOLOS
		//		if (tolosOrderList.size() > 0) {
		//			shippingVo.setTolosShipmentVos(tolosOrderList);
		//		}

		// 2019.12월 추가개발 jy.hong
		if (qxpressOrderList.size() > 0) {
			shippingDataVo.setQxpressVos(qxpressOrderList);
		}

		Map<String, Object> retMap = new HashMap<>();
		retMap.put("code", "200");
		retMap.put("message", "정상적으로 처리되었습니다.");
		retMap.put("data", shippingDataVo);
		return retMap;
	}

	public EfsShipmentVo efsShippingData(TOrderVo tOrderVo) throws Exception {
		logger.debug("[efsShippingData] tOrderVo : " + tOrderVo.toString());

		if (tOrderVo.getOrdCd() == null) {
			throw new LingoException("오더 정보가 없습니다.");
		}

		List<TOrderDtlVo> tOrderDtlList = dao.selectList("ShopeeOrderMapper.getTorderDTL", tOrderVo);
		List<EfsOrderDtlVo> orders = new ArrayList<>();
		String eNation = tOrderVo.geteNation().toUpperCase();

		for (TOrderDtlVo tOrderDtlVo : tOrderDtlList) {

			EfsOrderDtlVo dtlVo = new EfsOrderDtlVo();

			dtlVo.setDtlCartNo(tOrderVo.getCartNo()); // 판매 쇼핑몰명
			dtlVo.setDtlMallNm(tOrderVo.getMallNm()); // 장바구니 번호
			dtlVo.setDtlOrdNo(tOrderDtlVo.getOrdNo()); // 주문번호
			dtlVo.setGoodsCd(tOrderDtlVo.getGoodsCd()); // 상품코드
			dtlVo.setGoodsNm(tOrderDtlVo.getGoodsNm()); // 상품명
			dtlVo.setGoodsOption(tOrderDtlVo.getGoodsOption()); // 상품명옵션 (영문)
			dtlVo.setGoodsOptionKor(""); // 상품명옵션 (한글)
			dtlVo.setGoodsCnt(tOrderDtlVo.getGoodsCnt());
			dtlVo.setDtlRecvCurrency(tOrderVo.getRecvCurrency());
			dtlVo.setPaymentPrice(tOrderDtlVo.getPaymentPrice());
			orders.add(dtlVo);
		}

		EfsShipmentVo shipmentVo = new EfsShipmentVo();
		shipmentVo.setXrtInvcNo(tOrderVo.getXrtInvcSno());
		shipmentVo.setShipMethodCd(tOrderVo.getShipMethodCd());
		shipmentVo.setShipName(tOrderVo.getShipName());
		shipmentVo.setShipAddr(tOrderVo.getShipAddr());
		shipmentVo.setShipPost(tOrderVo.getShipPost());
		shipmentVo.setShipTel(tOrderVo.getShipTel());
		shipmentVo.setShipMobile(tOrderVo.getShipMobile());
		shipmentVo.setRecvName(tOrderVo.getRecvName());
		shipmentVo.setRecvAddr(tOrderVo.getRecvAddr1());

		if (!Util.isEmpty(tOrderVo.getRecvPost())) {
			shipmentVo.setRecvPost(Util.getStrTrim(tOrderVo.getRecvPost()));
		} else {
			shipmentVo.setRecvPost("-");
		}

		shipmentVo.setRecvTel(tOrderVo.getRecvTel());
		shipmentVo.setRecvMobile(tOrderVo.getRecvMobile());
		shipmentVo.setRecvNation(eNation);
		shipmentVo.setRecvCity("");
		shipmentVo.setOrderDtlList(orders);

		return shipmentVo;
	}

	public EtomarsShipmentVo etomarsShippingData(TOrderVo tOrderVo) throws Exception {
		logger.debug("[etomarsShippingData] tOrderVo : " + tOrderVo.toString());
		List<TOrderDtlVo> tOrderDtlList = dao.selectList("ShopeeOrderMapper.getTorderDTL", tOrderVo);

		EtomarsShipmentVo shipmentVo = new EtomarsShipmentVo();
		List<EtomarsOrderDtlVo> orders = new ArrayList<>();
		for (TOrderDtlVo tOrderDtlVo : tOrderDtlList) {

			int cnt = Integer.parseInt(tOrderDtlVo.getGoodsCnt());
			float unitPrice = Integer.parseInt(tOrderDtlVo.getPaymentPrice());

			EtomarsOrderDtlVo dtlVo = new EtomarsOrderDtlVo();
			dtlVo.setGoodsName(tOrderDtlVo.getGoodsNm());
			dtlVo.setQty(cnt);
			dtlVo.setUnitPrice(unitPrice);
			dtlVo.setBrandName("XROUTE");
			dtlVo.setSKU(tOrderDtlVo.getGoodsCd());
			dtlVo.setHSCODE("");
			dtlVo.setPurchaseUrl("");
			dtlVo.setMaterial("");
			dtlVo.setBarcode("");
			dtlVo.setGoodsNameExpEn("");
			dtlVo.setHscodeExpEn("");
			orders.add(dtlVo);
		}

		String eNation = tOrderVo.geteNation().toUpperCase();

		shipmentVo.setNationCode(eNation);
		shipmentVo.setShippingType("A");
		shipmentVo.setOrderNo1(tOrderVo.getXrtInvcSno());
		shipmentVo.setOrderNo2("");
		shipmentVo.setSenderName(tOrderVo.getShipName());
		shipmentVo.setSenderTelno(tOrderVo.getShipTel());
		shipmentVo.setSenderAddr(tOrderVo.getShipAddr());
		shipmentVo.setReceiverName(tOrderVo.getRecvName());
		shipmentVo.setReceiverNameYomigana(tOrderVo.getRecvName());
		shipmentVo.setReceiverNameExpEng("");
		shipmentVo.setReceiverTelNo1(tOrderVo.getRecvTel());
		shipmentVo.setReceiverTelNo2(tOrderVo.getRecvMobile());
		shipmentVo.setReceiverZipcode(tOrderVo.getRecvPost());
		shipmentVo.setReceiverState("");
		shipmentVo.setReceiverCity("");
		shipmentVo.setReceiverDistrict("");

		shipmentVo.setReceiverDetailAddr(tOrderVo.getRecvAddr1());
		shipmentVo.setReceiverEmail("");
		shipmentVo.setReceiverSocialNo("");
		shipmentVo.setRealWeight("1");
		shipmentVo.setWeightUnit("KG");
		shipmentVo.setBoxCount("1");
		shipmentVo.setCurrencyUnit(tOrderVo.getRecvCurrency());
		shipmentVo.setDelvMessage("");
		shipmentVo.setUserData1("");
		shipmentVo.setUserData2("");
		shipmentVo.setUserData3("");
		shipmentVo.setDimWidth("");
		shipmentVo.setDimLength("");
		shipmentVo.setDimHeight("");
		shipmentVo.setDimUnit("cm");
		shipmentVo.setDelvNo("");
		shipmentVo.setDelvCom("");
		shipmentVo.setStockMode("");
		shipmentVo.setSalesSite(tOrderVo.getMallNm());
		shipmentVo.setGoodsList(orders);

		return shipmentVo;
	}

	public List<QxpressVo> qxpressShippingData(TOrderVo tOrderVo) throws Exception {
		logger.debug("[qxpressShippingData] tOrderVo : " + tOrderVo.toString());

		List<QxpressVo> qxpressVoList = new ArrayList<>();
		List<TOrderDtlVo> tOrderDtlList = dao.selectList("ShopeeOrderMapper.getTorderDTL", tOrderVo);

		for (TOrderDtlVo tOrderDtlVo : tOrderDtlList) {
			String recvHpNo = tOrderVo.getRecvMobile();
			String recvTel = tOrderVo.getRecvTel();

			QxpressVo qxpressVo = new QxpressVo();
			qxpressVo.setXrtInvcSno(tOrderVo.getXrtInvcSno());
			qxpressVo.setRcvnm(tOrderVo.getRecvName());
			qxpressVo.setHpNo((!recvHpNo.equals("") ? recvHpNo : recvTel));
			qxpressVo.setDelFrontaddress(tOrderVo.getRecvAddr1());
			qxpressVo.setDelBackaddress(tOrderVo.getRecvAddr2());
			qxpressVo.setDpc3refno1(tOrderVo.getOrdCd());
			qxpressVo.setTelNo(recvTel);
			qxpressVo.setZipCode(tOrderVo.getRecvPost());
			qxpressVo.setBuyCustemail("");
			qxpressVo.setDeliveryNationcd(tOrderVo.geteNation().toUpperCase());
			qxpressVo.setDeliveryOptionCode("");
			qxpressVo.setSellCustnm(tOrderVo.getShipName());
			qxpressVo.setStartNationcd(tOrderVo.getsNation());
			qxpressVo.setRemark("");
			qxpressVo.setItemNm(tOrderDtlVo.getGoodsNm());
			qxpressVo.setQty(tOrderDtlVo.getGoodsCnt());
			qxpressVo.setPurchasAmt(tOrderDtlVo.getPaymentPrice());
			qxpressVo.setCurrency(tOrderVo.getRecvCurrency());
			qxpressVoList.add(qxpressVo);

			Thread.sleep(100);
		}

		return qxpressVoList;
	}

	public Map<String, Object> efsCreateShipment(ShippingDataVo reqVo) throws Exception {

		List<EfsShipmentVo> shipmentVos = reqVo.getEfsShipmentVos();

		if (shipmentVos.size() == 0) {
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "404");
			retMap.put("message", "데이터가 없습니다.");
			return retMap;
		} else {
			Map<String, Object> resMap = efsAPI.createShipment(shipmentVos);
			List<Map<String, Object>> xrtInvcSnoList = new ArrayList();

			String[] changeData = resMap.get("data").toString().split("\\n");

			// 실패한 경우
			if (Util.isEmpty(changeData) || !changeData[0].toUpperCase().contains(Util.getStrTrim("SUCCESSFULLY"))) {
				resMap.put("code", "500");
				resMap.put("message", "failed");
				Map<String, Object> updateMap = new HashMap<>();

				for (EfsShipmentVo efsShipmentVo : shipmentVos) {
					logger.debug("xrtInvcSno : failed" + efsShipmentVo.getXrtInvcNo());
					updateMap.put("xrtInvcSno", efsShipmentVo.getXrtInvcNo());
					updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);

					dao.update("ShopeeOrderMapper.updateTOrder", updateMap);
				}
			} else {
				// 성공한 경우
				if (changeData.length > 0) {
					resMap.put("code", "200");
					resMap.put("message", "정상적으로 처리되었습니다.");

					logger.debug("changeData.length:" + changeData.length);
					for (int i = 1; i < changeData.length; i++) {
						logger.debug("changeData[" + i + "] : " + changeData[i]);

						Map<String, Object> updateMap = new HashMap<>();

						String[] resultDtl = changeData[i].split("\\|");
						logger.debug("resultDtl.length:" + resultDtl.length);

						updateMap.put("invcSno1", resultDtl[0]);
						updateMap.put("xrtInvcSno", resultDtl[1]);
						if (resultDtl.length > 2) {
							if ("N".equals(resultDtl[2])) {
								resMap.put("code", "500");
								resMap.put("message", "Data ERROR");
								break;
							}
						}
						if (resultDtl.length > 4) {
							updateMap.put("localShipper", resultDtl[4]);
						}
						if (resultDtl.length > 5) {
							updateMap.put("invcSno2", resultDtl[5]);
						}
						updateMap.put("shippingCompany", "EFS");
						dao.update("ShopeeOrderMapper.updateTOrder", updateMap);
						Thread.sleep(100);
					}
				}
			}

			return resMap;
		}
	}

	public Map<String, Object> etomarsRegData(ShippingDataVo reqVo) throws Exception {

		List<EtomarsShipmentVo> shipmentVos = reqVo.getEtomarsShipmentVos();

		if (shipmentVos.size() == 0) {
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "404");
			retMap.put("message", "데이터가 없습니다.");
			return retMap;
		} else {
			Map<String, Object> resMap = etomarsAPI.RegData(shipmentVos);
			List<Map<String, Object>> xrtInvcSnoList = new ArrayList();

			if (!"0".equals(resMap.get("code").toString())) {
				String message = (String) resMap.get("message");
				Map<String, Object> retMap = new HashMap<>();
				retMap.put("message", message);
				return retMap;
			} else {
				JSONArray resList = (JSONArray) resMap.get("list");

				String message = "";
				for (int i = 0; i < resList.size(); i++) {
					Map<String, Object> updateMap = new HashMap<>();
					JSONObject jsonObject = (JSONObject) resList.get(i);

					// 성공한 경우
					if ("0".equals(resMap.get("code").toString())) {
						updateMap.put("xrtInvcSno", jsonObject.get("OrderNo1").toString());
						updateMap.put("invcSno1", jsonObject.get("RegNo").toString());
						updateMap.put("invcSno2", jsonObject.get("DelvNo").toString());
						updateMap.put("localShipper", jsonObject.get("DelvComName").toString());
						updateMap.put("shippingCompany", "ETOMARS");
					} else {
						updateMap.put("xrtInvcSno", jsonObject.get("OrderNo1").toString());
						updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);
						message += "(" + jsonObject.get("xrtInvcSno").toString() + ")"
								+ jsonObject.get("Message").toString() + "\n";
					}

					dao.update("ShopeeOrderMapper.updateTOrder", updateMap);
					Thread.sleep(100);
				}

				Map<String, Object> retMap = new HashMap<>();
				retMap.put("code", "200");
				retMap.put("message", "정상적으로 처리되었습니다.");
				return retMap;
			}
		}
	}

	public Map<String, Object> qxpressRegData(ShippingDataVo shipmentVo) throws Exception {
		logger.debug("[qxpressRegData] shipmentVo : " + shipmentVo.toString());

		List<QxpressVo> qxpressVos = shipmentVo.getQxpressVos();

		if (qxpressVos.size() == 0) {
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "404");
			retMap.put("message", "데이터가 없습니다.");
			return retMap;
		}

		List<Map<String, Object>> xrtInvcSnoList = new ArrayList();
		for (QxpressVo qxpressVo : qxpressVos) {
			logger.debug("[qxpressRegData] qxpressVo : " + qxpressVo.toString());
			// TODO. 오류 처리 로직 추가해야함.
			Map<String, Object> retMap = qxpress.createOrder(qxpressVo);
			String code = (String) retMap.get("code");
			if (!code.equals("200")) {
				retMap.put("code", code);
				retMap.put("message", retMap.get("message").toString());
				return retMap;
			}

			JSONArray resList = (JSONArray) retMap.get("data");

			for (int i = 0; i < resList.size(); i++) {
				Map<String, Object> updateMap = new HashMap<>();
				JSONObject jsonObject = (JSONObject) resList.get(i);
				logger.debug("[qxpressRegData] jsonObject : " + jsonObject.toString());
				JSONParser jsonParser = new JSONParser();
				Object oOrder = jsonParser.parse(jsonObject.get("Order").toString());
				JSONObject jOrder = (JSONObject) oOrder;

				// 성공한 경우
				logger.debug("[qxpressRegData] jOrder : " + jOrder.toString());
				if ("OK".equals(jOrder.get("RESULT__MSG").toString())) {
					updateMap.put("xrtInvcSno", qxpressVo.getXrtInvcSno());
					updateMap.put("invcSno1", jOrder.get("SHIPPING_NO").toString());
					updateMap.put("localShipper", jOrder.get("DELIVERY_OPTION_CODE").toString());
					updateMap.put("shippingCompany", "QXPRESS");

					xrtInvcSnoList.add(updateMap);
				} else {
					updateMap.put("xrtInvcSno", qxpressVo.getXrtInvcSno());
					updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);
				}

				dao.update("ShopeeOrderMapper.updateTOrder", updateMap);
				Thread.sleep(100);
			}
		}

		Map<String, Object> retMap = new HashMap<>();
		retMap.put("code", "200");
		retMap.put("message", "정상적으로 처리되었습니다.");
		return retMap;
	}
}
