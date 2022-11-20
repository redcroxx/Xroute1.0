package xrt.fulfillment.order.manual.etsy;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.fulfillment.interfaces.vo.TOrderDtlVo;
import xrt.fulfillment.interfaces.vo.TOrderVo;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class EtsyUploadBiz extends DefaultBiz {

	Logger logger = LoggerFactory.getLogger(EtsyUploadBiz.class);

	/**
	 * 양식명 select box
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<LDataMap> getSiteCd(LDataMap param) throws Exception {
		return dao.select("EtsyUploadMapper.getSiteCd", param);
	}

	/**
	 * 공통 파라메터 검증
	 * @param paramMap
	 * @param dataList
	 * @return
	 * @throws Exception
	 */
	public LDataMap valid(LDataMap paramMap, List<LDataMap> dataList) throws Exception {
		logger.debug("[valid] paramMap : "+ paramMap +", dataList : "+ dataList.toString());

		logger.debug("1. 공통파라메터 변수 지정");
		String compcd = paramMap.getString("compcd");
		String orgcd = paramMap.getString("orgcd");
		String orgnm = paramMap.getString("orgnm");
		String whcd = paramMap.getString("whcd");
		String shipMethod = paramMap.getString("shipMethod");
		String fileYmd = paramMap.getString("fileYmd");
		String siteCd = paramMap.getString("siteCd");
		String userCd = paramMap.getString("LOGIN_USERCD");
		String loginIp = paramMap.getString("LOGIN_IP");
		String paymentType = paramMap.getString("LOGIN_PAYMENT_TPYE");

		logger.debug("2. 공통파라메터 null, 공백 검증");
		if (orgcd == null || "".equals(orgcd)) {
			throw new LingoException("셀러정보가 없습니다.");
		}
		if (whcd == null || "".equals(whcd)) {
			throw new LingoException("창고코드가 없습니다.");
		}
		if (shipMethod == null || "".equals(shipMethod)) {
			throw new LingoException("배송타입이 없습니다.");
		}
		if (fileYmd == null || "".equals(fileYmd)) {
			throw new LingoException("등록일자가 없습니다.");
		}
		if (userCd == null || "".equals(userCd)) {
			throw new LingoException("사용자 정보가 없습니다.");
		}

		logger.debug("3. 엣시 주문 목록 검증");
		logger.debug("dataList.size : "+ dataList.size());
		List<String> usStateList = dao.selectList("EtsyUploadMapper.getUsStateList", paramMap);
		List<EtsyVo> orderList = new ArrayList<EtsyVo>();
		logger.debug("for start");
		int fileSeq = (Integer) dao.selectOne("EtsyUploadMapper.getTorderFileSeq", paramMap) + 1;
		for (int i=0; i<dataList.size(); i++) {
			EtsyVo etsyVo = new EtsyVo();
			String country = dataList.get(i).getString("shipCountry").trim().toUpperCase();
			String state = dataList.get(i).getString("shipState").trim().toUpperCase();

			if (country.equals("")) {
				throw new LingoException("shipCountry가 없습니다.");
			}
			
			if (!country.equals("UNITED STATES") && !country.equals("US") ) {
				throw new LingoException("현재는 미국만 가능합니다.");
			} else {
				etsyVo.setShipCountry("US");
			}

			if (country.equals("UNITED STATES") || country.equals("US")) {
				if (state.equals("")) {
					throw new LingoException("shipState가없습니다.");
				} else {
					if (usStateList.contains(state)) {
						etsyVo.setShipState(state);
					} else {
						throw new LingoException("등록되지 않은 주입니다.");
					}
				}

				if (dataList.get(i).getString("shipCity").equals("")) {
					throw new LingoException("shipCity가없습니다.");
				} else {
					etsyVo.setShipCity(dataList.get(i).getString("shipCity"));
				}
			} else {
				etsyVo.setShipCity(dataList.get(i).getString("shipCity"));
			}

			if (dataList.get(i).getString("shipZipcode").equals("")) {
				throw new LingoException("shipZipcode가없습니다.");
			} else {
				etsyVo.setShipZipcode(dataList.get(i).getString("shipZipcode"));
			}

			if (dataList.get(i).getString("itemTotal").equals("")) {
				throw new LingoException("itemTotal이없습니다.");
			} else {
				etsyVo.setItemTotal(dataList.get(i).getString("itemTotal"));
			}

			if (dataList.get(i).getString("orderId").equals("")) {
				throw new LingoException("orderId가없습니다.");
			} else {
				etsyVo.setOrderId(dataList.get(i).getString("orderId"));
			}

			if (dataList.get(i).getString("itemName").equals("")) {
				throw new LingoException("itemName이 없습니다.");
			} else {
				etsyVo.setItemName(dataList.get(i).getString("itemName"));
			}

			if (dataList.get(i).getString("quantity").equals("")) {
				throw new LingoException("quantity가없습니다.");
			} else {
				etsyVo.setQuantity(dataList.get(i).getString("quantity"));
			}

			if (dataList.get(i).getString("shipName").equals("")) {
				throw new LingoException("shipName이없습니다.");
			} else {
				etsyVo.setShipName(dataList.get(i).getString("shipName"));
			}

			if (dataList.get(i).getString("shipAddress1").equals("")) {
				throw new LingoException("shipAddress1가없습니다.");
			} else {
				etsyVo.setShipAddress1(dataList.get(i).getString("shipAddress1"));
				etsyVo.setShipAddress2(dataList.get(i).getString("shipAddress2"));
			}

			DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String saleDate = "";
			String datePaid =  "";
			String dateShipped =  "";

			if (!dataList.get(i).getString("saleDate").equals("")) {
				Date dSaleDate = dateFormat.parse(dataList.get(i).getString("saleDate"));
				saleDate = formatter.format(dSaleDate);
			}
			if (!dataList.get(i).getString("datePaid").equals("")) {
				Date dDatePaid = dateFormat.parse(dataList.get(i).getString("datePaid"));
				datePaid = formatter.format(dDatePaid);
			}
			if (!dataList.get(i).getString("reportingDate").equals("")) {
				Date dDateShipped = dateFormat.parse(dataList.get(i).getString("dateShipped"));
				dateShipped = formatter.format(dDateShipped);
			}

			etsyVo.setCompcd(compcd);
			etsyVo.setOrgcd(orgcd);
			etsyVo.setWhcd(whcd);
			etsyVo.setFileYmd(fileYmd);
			etsyVo.setFileSeq(fileSeq);
			etsyVo.setSaleDate(saleDate);
			etsyVo.setBuyer(dataList.get(i).getString("buyer"));
			etsyVo.setPrice(dataList.get(i).getString("price"));
			etsyVo.setCouponCode(dataList.get(i).getString("couponCode"));
			etsyVo.setCouponDetails(dataList.get(i).getString("couponDetails"));
			etsyVo.setDiscountAmount(dataList.get(i).getString("discountAmount"));
			etsyVo.setShippingDiscount(dataList.get(i).getString("shippingDiscount"));
			etsyVo.setOrderShipping(dataList.get(i).getString("orderShipping"));
			etsyVo.setOrderSalesTax(dataList.get(i).getString("orderSalesTax"));
			etsyVo.setCurrency(dataList.get(i).getString("currency"));
			etsyVo.setTransactionId(dataList.get(i).getString("transactionId"));
			etsyVo.setListingId(dataList.get(i).getString("listingId"));
			etsyVo.setDatePaid(datePaid);
			etsyVo.setDateShipped(dateShipped);
			etsyVo.setVariations(dataList.get(i).getString("variations"));
			etsyVo.setOrderType(dataList.get(i).getString("orderType"));
			etsyVo.setListingsType(dataList.get(i).getString("listingsType"));
			etsyVo.setPaymentType(paymentType);
			etsyVo.setInpersonDiscount(dataList.get(i).getString("inpersonDiscount"));
			etsyVo.setInpersonLocation(dataList.get(i).getString("inpersonLocation"));
			etsyVo.setVatPaidByBuyer(dataList.get(i).getString("vatPaidByBuyer"));
			etsyVo.setSku(dataList.get(i).getString("sku"));
			etsyVo.setAddusercd(userCd);
			etsyVo.setUpdusercd(userCd);
			etsyVo.setTerminalcd(loginIp);

			orderList.add(etsyVo);
			Thread.sleep(100);
		}

		logger.debug("4. 공통 데이터 설정");
		Map<String, Object> commMap = new HashMap<>();
		commMap.put("compcd", compcd);
		commMap.put("orgcd", orgcd);
		commMap.put("orgnm", orgnm);
		commMap.put("whcd", whcd);
		commMap.put("shipMethod", shipMethod);
		commMap.put("fileYmd", fileYmd);
		commMap.put("siteCd", siteCd);
		commMap.put("paymentType", paymentType);
		commMap.put("userCd", userCd);
		commMap.put("loginIp", loginIp);

		logger.debug("5. 반환값 지정");
		LDataMap retMap = new LDataMap();
		retMap.put("commMap", commMap);
		retMap.put("orderList", orderList);
		retMap.put("code", "200");
		retMap.put("message", "성공하였습니다.");
		return retMap;
	}

	/**
	 * 아마존 오더 정보 저장
	 * @param paramMap
	 * @param orderList
	 * @return
	 * @throws Exception
	 */
	public void orderInsert(List<EtsyVo> orderList) throws Exception {
		logger.debug("[amazonOrderInsert] orderList : "+ orderList.toString());

		for (EtsyVo etsyVo : orderList) {
			dao.insert("EtsyUploadMapper.insertOrderEtsy", etsyVo);
		}
	}

	/**
	 *공통 파라메터 및 아마존 Order List를 Torder, TorderDtl 맵핑함.
	 * @param paramMap
	 * @param orderList
	 * @return
	 * @throws Exception
	 */
	public LDataMap processing(Map<String, Object> paramMap, List<EtsyVo> paramList) throws Exception {
		logger.debug("[processing] paramMap : "+ paramMap +", paramList : "+ paramList.toString());

		logger.debug("1. 셀러정보 조회");
		paramMap.put("fileYmd", paramList.get(0).getFileYmd());
		paramMap.put("fileSeq", paramList.get(0).getFileSeq());
		List<EtsyVo> orderList = dao.selectList("EtsyUploadMapper.getOrderList", paramMap);
		LDataMap sellerMap = (LDataMap) dao.selectOne("EtsyUploadMapper.getSeller", paramMap);

		int relayCount = ((Integer) dao.selectOne("EtsyUploadMapper.getTorderRelaySeq", paramMap)) + 1;
		int fileRelayCount = 1;

		logger.debug("2. 아마존 주문 정보 -> 엑스루트 정보 변환");
		List<TOrderVo> torderList = new ArrayList<>();
		for (EtsyVo etsyVo : orderList) {
			logger.debug("2-1. 주소2, 주소3 공백 확인");

			String recvTel = "";
			String paymenyType = paramMap.get("paymentType") + "";
			String addr2 = etsyVo.getShipAddress2() == ""? ".":etsyVo.getShipAddress2();

			TOrderVo torderVo = new TOrderVo();
			torderVo.setCompcd(etsyVo.getCompcd());
			torderVo.setOrgcd(etsyVo.getOrgcd());
			torderVo.setWhcd(etsyVo.getWhcd());
			torderVo.setUploadDate(etsyVo.getFileYmd());
			torderVo.setFileSeq(etsyVo.getFileSeq() +"");
			torderVo.setFileNm(etsyVo.getFileSeq() +"차");
			torderVo.setFileNmReal("Etsy Order Upload");
			torderVo.setSiteCd("30112");
			torderVo.setStatusCd("10");
			torderVo.setStockType("1");
			torderVo.setMallNm(sellerMap.getString("NAME"));
			torderVo.setShipMethodCd(paramMap.get("shipMethod") +"");
			torderVo.setOrdNo(etsyVo.getOrderId());
			torderVo.setCartNo(etsyVo.getOrderId());
			torderVo.setOrdCnt(etsyVo.getItemCount());
			torderVo.setsNation("KR");
			torderVo.seteNation(etsyVo.getShipCountry());
			torderVo.setShipName(sellerMap.getString("COMPANY_EN"));
			torderVo.setShipTel(sellerMap.getString("TEL1"));
			torderVo.setShipMobile(sellerMap.getString("TEL2"));
			torderVo.setShipAddr(sellerMap.getString("ENG_ADDR"));
			torderVo.setShipPost(sellerMap.getString("POST"));
			torderVo.setRecvName(etsyVo.getShipName());
			torderVo.setRecvTel(recvTel);
			torderVo.setRecvMobile(recvTel);
			torderVo.setRecvAddr1(etsyVo.getShipAddress1());
			torderVo.setRecvAddr2(addr2);
			torderVo.setRecvCity(etsyVo.getShipCity());
			torderVo.setRecvState(etsyVo.getShipState());
			torderVo.setRecvPost(etsyVo.getShipZipcode());
			torderVo.setRecvNation(etsyVo.getShipCountry());
			torderVo.setRecvCurrency(etsyVo.getCurrency());
			torderVo.setTotPaymentPrice(etsyVo.getItemTotal());
			torderVo.setAddusercd(etsyVo.getAddusercd());
			torderVo.setUpdusercd(etsyVo.getUpdusercd());
			torderVo.setTerminalcd(etsyVo.getTerminalcd());
			torderVo.setRelaySeq(relayCount);
			torderVo.setFileRelaySeq(fileRelayCount);
			torderVo.setPaymentType(paymenyType);
			logger.debug("EtsyUploadMapper.insertTorder");
			dao.insert("EtsyUploadMapper.insertTorder", torderVo);

			List<EtsyVo> itemList = dao.selectList("EtsyUploadMapper.getItemList", etsyVo);
			for (int i=0; i<itemList.size(); i++) {
				TOrderDtlVo tOrderDtlVo = new TOrderDtlVo();
				long count = i + 1;
				tOrderDtlVo.setOrdCd(torderVo.getOrdCd());
				tOrderDtlVo.setOrdSeq(count);
				tOrderDtlVo.setCompcd(itemList.get(i).getCompcd());
				tOrderDtlVo.setOrgcd(itemList.get(i).getOrgcd());
				tOrderDtlVo.setGoodsCd("");
				tOrderDtlVo.setGoodsNm(itemList.get(i).getItemName());
				tOrderDtlVo.setGoodsOption(itemList.get(i).getVariations());
				tOrderDtlVo.setGoodsCnt(itemList.get(i).getQuantity());
				tOrderDtlVo.setPaymentPrice(itemList.get(i).getItemTotal());
				tOrderDtlVo.setAddusercd(itemList.get(i).getAddusercd());
				tOrderDtlVo.setUpdusercd(itemList.get(i).getUpdusercd());
				tOrderDtlVo.setOrdNo(itemList.get(i).getOrderId());
				tOrderDtlVo.setTerminalcd(itemList.get(i).getTerminalcd());
				logger.debug("EtsyUploadMapper.insertTOrderDtl");
				dao.insert("EtsyUploadMapper.insertTOrderDtl", tOrderDtlVo);
			}

			relayCount++;
			fileRelayCount++;
			logger.debug("EtsyUploadMapper.updateOrderEtsy");
			dao.update("EtsyUploadMapper.updateOrderEtsy", etsyVo);
			torderList.add(torderVo);
			Thread.sleep(100);
		}

		LDataMap retMap = new LDataMap();
		retMap.put("CODE", "1");
		retMap.put("MESSAGE", "성공하였습니다.");
		return retMap;
	}


}