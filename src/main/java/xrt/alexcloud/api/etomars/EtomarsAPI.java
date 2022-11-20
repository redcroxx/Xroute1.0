package xrt.alexcloud.api.etomars;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import xrt.alexcloud.api.etomars.vo.EtomarsDataDtlVo;
import xrt.alexcloud.api.etomars.vo.EtomarsDataVo;
import xrt.alexcloud.api.etomars.vo.EtomarsOrderDtlVo;
import xrt.alexcloud.api.etomars.vo.EtomarsShipmentVo;
import xrt.alexcloud.api.etomars.vo.EtomarsTrackingDtlVo;
import xrt.alexcloud.api.etomars.vo.EtomarsTrackingVo;
import xrt.fulfillment.order.settlement.ShippingPriceVo;
import xrt.lingoframework.utils.Util;

@Component
public class EtomarsAPI {

	@Value("#{config['c.debugtype']}")
	private String debugtype;

	@Value("#{config['c.etomarsURL']}")
	private String etomarsURL;

	@Value("#{config['c.devEtomarsApiKey']}")
	private String devEtomarsApiKey;

	@Value("#{config['c.realEtomarsApiKey']}")
	private String realEtomarsApiKey;

	Logger logger = LoggerFactory.getLogger(EtomarsAPI.class);

	/**
	 * Etomars API Header
	 * @param pCd
	 * @return
	 * @throws Exception
	 */
	public HttpURLConnection createHeader(String pCd) throws Exception  {

		String httpURL = etomarsURL + pCd;

		// 1. etomars API를 통신하기전에 httpURLConnection 을 생성
		HttpURLConnection retURL = (HttpURLConnection) new URL(httpURL).openConnection();
		retURL.setRequestMethod("POST");
		retURL.setRequestProperty("Content-Type", "application/json");
		retURL.setDoOutput(true);

		return retURL;
	}

	/**
	 * etomars API Body 설정 및 etomars Server에 전송
	 * @param conn
	 * @param sendData
	 * @return
	 * @throws Exception
	 */
	public JSONObject sendData(HttpURLConnection conn, StringBuffer sendData) throws Exception  {

		// 1. 데이터 발송
		OutputStreamWriter outputStreamWriter = new OutputStreamWriter(conn.getOutputStream(), "utf-8");
		outputStreamWriter.write(sendData.toString());
		outputStreamWriter.flush();
		// 2. 응답 받은 데이터 저장
		StringBuilder sb = new StringBuilder();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		String readLine;
		while ((readLine = bufferedReader.readLine()) != null) {
			sb.append(readLine).append("\n");
		}

		logger.debug("sb : "+ sb.toString());

		bufferedReader.close();
		JSONParser jsonParser = new JSONParser();
		Object object = jsonParser.parse(sb.toString());
		JSONObject  retJson = (JSONObject) object;

		logger.debug("sendData retJson : "+ retJson);

		return retJson;
	}

	/**
	 * etomars API 배송비 예상금액
	 * @param shipments
	 * @return
	 */
	public Map<String, Object> estShippingFee(ShippingPriceVo shipments ) {
		Map<String, Object> retMap = new HashMap<>();

		if (Util.isEmpty(shipments)) {
			retMap.put("code", "404");
			retMap.put("message", "주문정보가 없습니다.");
			return retMap;
		}

		try {
			// 1. 해더생성
			HttpURLConnection conn = this.createHeader("EstShippingFee");
			conn.connect();

			// 2. etomars API 서버에 보낼 body 데이터 생성
			String apiKey = realEtomarsApiKey;
			StringBuffer sb = new StringBuffer();

			//볼륨중량과 무게중량을 비교해서 볼륨중량이 더 크면 볼륨중량을 사용.
			BigDecimal box_volume = new BigDecimal(shipments.getBoxVolume());
			BigDecimal xrt_wgt = new BigDecimal(shipments.getWgt());
			if( box_volume.compareTo(xrt_wgt) == 1 ) // compareTo :::: -1은 작다, 0은 같다, 1은 크다
			{
				xrt_wgt = box_volume;
			}

			sb.append("{ ");
			sb.append("\"ApiKey\": "+"\""+ apiKey +"\"");
			sb.append(" , ");
			sb.append("\"NationCode\": "+"\""+ shipments.geteNation() +"\"");
			sb.append(" , ");
			sb.append("\"ShippingType\": "+"\"A\"");
			sb.append(" , ");
			sb.append("\"RealWeight\": " + xrt_wgt );
			sb.append(" , ");
			sb.append("\"WeightUnit\": "+"\"KG\"");
			sb.append(" }");

			logger.debug("EstShippingFee JSON Data : "+ sb.toString());
			JSONObject resJson =  this.sendData(conn, sb);

			JSONParser jsonParser = new JSONParser();
			Object oResponse = jsonParser.parse(resJson.toString());
			JSONObject jResponse = (JSONObject) oResponse;

			Object oList = jsonParser.parse(jResponse.get("Data").toString());
			if (!Util.isEmpty(oList)) {
				JSONObject jList = (JSONObject) oList;

				logger.debug("========");

				if (jResponse.get("Code").toString().equals("0")) {
					retMap.put("code", "0");
					retMap.put("message", "success");
					retMap.put("list", jList);
				} else {
					retMap.put("code", jResponse.get("Code").toString());
					retMap.put("message", jResponse.get("Message").toString());
					retMap.put("list", "");
				}
			} else {
				retMap.put("code", jResponse.get("Code").toString());
				retMap.put("message", "API Connect error");
				retMap.put("list", "");
			}
			return retMap;
		} catch ( Exception e ) {
			retMap.put("code", "500");
			retMap.put("message", e.fillInStackTrace());
			return retMap;
		}
	}

	/**
	 * etomars API 주문 정보 송수신
	 * @param serverType
	 * @param shipments
	 * @return
	 */
	public Map<String, Object> RegData(List<EtomarsShipmentVo> shipments ) {

		Map<String, Object> retMap = new HashMap<>();
		if (shipments.size() == 0) {
			retMap.put("code", "404");
			retMap.put("message", "주문정보가 없습니다.");
			retMap.put("list", "");
			return retMap;
		}

		try {

			// 1. 해더생성
			HttpURLConnection conn = this.createHeader("RegData");
			conn.connect();

			// 2. etomars API 서버에 보낼 body 데이터 생성
			String apiKey = realEtomarsApiKey;
			StringBuffer sb = new StringBuffer();
			sb.append("{ ");
			sb.append("\"ApiKey\": "+"\""+ apiKey +"\"");
			sb.append(" , ");
			sb.append("\"DataList\": [");

			for ( int i=0; i<shipments.size(); i++ ) {
				sb.append("{ ");
				sb.append("\"NationCode\": "+"\""+ shipments.get(i).getNationCode() +"\", ");
				sb.append("\"ShippingType\": "+"\""+ shipments.get(i).getShippingType().toUpperCase() +"\", ");
				sb.append("\"OrderNo1\": "+"\""+ shipments.get(i).getOrderNo1() +"\", ");
				sb.append("\"OrderNo2\": "+"\""+ shipments.get(i).getOrderNo2() +"\", ");
				sb.append("\"SenderName\": "+"\""+ shipments.get(i).getSenderName() +"\", ");
				sb.append("\"SenderTelno\": "+"\""+ shipments.get(i).getSenderTelno() +"\", ");
				sb.append("\"SenderAddr\": "+"\""+ shipments.get(i).getSenderAddr() +"\", ");
				sb.append("\"ReceiverName\": "+"\""+ shipments.get(i).getReceiverName() +"\", ");
				sb.append("\"ReceiverNameYomigana\": "+"\""+ shipments.get(i).getReceiverNameYomigana() +"\", ");
				sb.append("\"ReceiverNameExpEng\": "+"\""+ shipments.get(i).getReceiverNameExpEng() +"\", ");
				sb.append("\"ReceiverTelNo1\": "+"\""+ shipments.get(i).getReceiverTelNo1().replace("-", "")  +"\", ");
				sb.append("\"ReceiverTelNo2\": "+"\""+ shipments.get(i).getReceiverTelNo2() +"\", ");
				sb.append("\"ReceiverZipcode\": "+"\""+ shipments.get(i).getReceiverZipcode()  +"\", ");

				sb.append("\"ReceiverState\": "+"\""+ shipments.get(i).getReceiverState() +"\", ");
				sb.append("\"ReceiverCity\": "+"\""+ shipments.get(i).getReceiverCity() +"\", ");
				sb.append("\"ReceiverDistrict\": "+"\""+ shipments.get(i).getReceiverDistrict() +"\", ");
				sb.append("\"ReceiverDetailAddr\": "+"\""+ shipments.get(i).getReceiverDetailAddr()  +"\", ");

				sb.append("\"ReceiverEmail\": "+"\""+ shipments.get(i).getReceiverEmail()  +"\", ");
				sb.append("\"ReceiverSocialNo\": "+"\""+ shipments.get(i).getReceiverSocialNo()  +"\", ");
				sb.append("\"RealWeight\": "+ shipments.get(i).getRealWeight() +", ");  //float
				sb.append("\"WeightUnit\": "+"\""+ shipments.get(i).getWeightUnit()  +"\", ");
				sb.append("\"BoxCount\": "+ shipments.get(i).getBoxCount() +" , ");  //int
				sb.append("\"CurrencyUnit\": "+"\""+ shipments.get(i).getCurrencyUnit() +"\", ");
				sb.append("\"DelvMessage\": "+"\""+ shipments.get(i).getDelvMessage() +"\", ");
				sb.append("\"UserData1\": "+"\""+ shipments.get(i).getUserData1() +"\", ");
				sb.append("\"UserData2\": "+"\""+ shipments.get(i).getUserData2() +"\", ");
				sb.append("\"UserData3\": "+"\""+ shipments.get(i).getUserData3() +"\", ");
				sb.append("\"DimWidth\": "+"\""+ shipments.get(i).getDimWidth() +"\", ");  //float
				sb.append("\"DimLength\": "+"\""+ shipments.get(i).getDimLength() +"\", ");  //float
				sb.append("\"DimHeight\": "+"\""+ shipments.get(i).getDimHeight() +"\", ");  //float
				sb.append("\"DimUnit\": "+"\""+ shipments.get(i).getDimUnit() +"\", ");
				sb.append("\"DelvNo\": "+"\""+ shipments.get(i).getDelvNo() +"\", ");
				sb.append("\"DelvCom\": "+"\""+ shipments.get(i).getDelvCom() +"\", ");
				sb.append("\"StockMode\": "+"\""+ shipments.get(i).getStockMode() +"\", ");
				sb.append("\"SalesSite\": "+"\""+ shipments.get(i).getSalesSite() +"\", ");

				sb.append("\"GoodsList\": [ ");
				List<EtomarsOrderDtlVo> goodsList = shipments.get(i).getGoodsList();
				String defaultUrl = "http://";
				for ( int j=0; j<goodsList.size(); j++ ) {
					sb.append("{ ");
					sb.append("\"GoodsName\": "+"\""+ goodsList.get(j).getGoodsName() +"\",");
					sb.append("\"Qty\": "+ goodsList.get(j).getQty() +",");
					sb.append("\"UnitPrice\": "+ goodsList.get(j).getUnitPrice() +",");
					sb.append("\"BrandName\": "+"\""+ goodsList.get(j).getBrandName() +"\",");
					sb.append("\"SKU\": "+"\""+ goodsList.get(j).getSKU() +"\",");
					sb.append("\"HSCODE\": "+"\""+ goodsList.get(j).getHSCODE() +"\",");
					//sb.append("\"PurchaseUrl\": "+"\""+ goodsList.get(j).getPurchaseUrl() +"\",");
					sb.append("\"PurchaseUrl\": "+"\""+ defaultUrl+ goodsList.get(j).getPurchaseUrl() +"\",");
					sb.append("\"Material\": "+"\""+ goodsList.get(j).getMaterial() +"\",");
					sb.append("\"Barcode\": "+"\""+ goodsList.get(j).getBarcode() +"\",");
					sb.append("\"GoodsNameExpEn\": "+"\""+ goodsList.get(j).getGoodsNameExpEn() +"\",");
					sb.append("\"HscodeExpEn\": "+"\""+ goodsList.get(j).getHscodeExpEn() +"\"");
					sb.append( this.returnBrace( j, goodsList.size(), " }"));
				}
				sb.append(" ]");
				sb.append( this.returnBrace(i, shipments.size(), " }") );
			}
			sb.append(" ]");
			sb.append(" }");
			logger.debug("RegData JSON Data : "+ sb.toString());

			JSONObject resJson =  this.sendData(conn, sb);

			JSONParser jsonParser = new JSONParser();
			Object oResponse = jsonParser.parse(resJson.toString());
			JSONObject jResponse = (JSONObject) oResponse;

			Object oList = jsonParser.parse(jResponse.get("Data").toString());

			if (!Util.isEmpty(oList)) {
				JSONArray jList = (JSONArray) oList;

				logger.debug("========");
				if (jResponse.get("Code").toString().equals("0")) {
					retMap.put("code", "0");
					retMap.put("message", "success");
					retMap.put("list", jList);
				} else {
					retMap.put("code", jResponse.get("Code").toString());
					retMap.put("message", jResponse.get("Message").toString());
					retMap.put("list", "");
				}
			} else {
				retMap.put("code", jResponse.get("Code").toString());
				retMap.put("message", "API Connect error");
				retMap.put("list", "");
			}

			return retMap;
		} catch (Exception e) {
			retMap.put("code", "500");
			retMap.put("message", e.fillInStackTrace());
			retMap.put("list", "");
			return retMap;
		}
	}

	/**
	 * Etomars API 접수정보 가져오기
	 * @param serverType
	 * @param shipments
	 * @return
	 */
	private Map<String, Object> GetData(List<String> regNoList) {
		Map<String, Object> retMap = new HashMap<>();
		logger.debug("regNoList.size() : "+ regNoList.size());

		try {
			// 1. 해더생성
			HttpURLConnection conn = this.createHeader("GetData");
			conn.connect();

			// 2. etomars API 서버에 보낼 body 데이터 생성
			String apiKey = realEtomarsApiKey;
			StringBuffer sb = new StringBuffer();

			boolean flg = false;

			// 전송데이터 작성
			sb.append("{ ");
			sb.append("\"ApiKey\": "+"\""+ apiKey +"\"");
			sb.append(" , ");
			sb.append("\"RegNoList\": [ ");
			for ( int i=0; i<regNoList.size(); i++ ) {
				if (flg) {
					sb.append(",");
				}
				sb.append("\""+ Util.getStrTrim(regNoList.get(i).toString()) +"\"");
				flg = true;
			}
			sb.append("  ]");
			sb.append("}");

			logger.debug("GetData JSON Data : "+ sb.toString());

			JSONObject resJson =  this.sendData(conn, sb);

			JSONParser jsonParser = new JSONParser();
			Object oResponse = jsonParser.parse(resJson.toString());
			JSONObject jResponse = (JSONObject) oResponse;

			Object tmpObj = jsonParser.parse(jResponse.get("Data").toString());
			logger.debug("========");

			if (!Util.isEmpty(tmpObj)) {
				logger.debug("========");
				if (jResponse.get("Code").toString().equals("0")) {
					retMap.put("code", "0");
					retMap.put("message", "success");
					retMap.put("data", jResponse.get("Data").toString());
				} else {
					retMap.put("code", jResponse.get("Code").toString());
					retMap.put("message", jResponse.get("Message").toString());
					retMap.put("data", "");
				}
			} else {
				retMap.put("code", jResponse.get("Code").toString());
				retMap.put("message", "getTracking API data error");
				retMap.put("data", "");
			}

			return retMap;
		} catch (Exception e) {
			retMap.put("code", "500");
			retMap.put("message", e.fillInStackTrace());
			retMap.put("data", "");
			return retMap;
		}
	}

	/**
	 * Etomars API 접수정보 가져오기
	 * @param regNoList
	 * @return
	 */
	public Map<String, Object> getDataSearch(List<String> regNoList) {

		Map<String, Object> retMap = new HashMap<>();
		if (regNoList.size() == 0) {
			retMap.put("code", "404");
			retMap.put("message", "접수번호정보가 없습니다.");
			retMap.put("data", "");
			return retMap;
		}

		try {
			Map<String, Object> resMap = GetData(regNoList);
			String strResult = resMap.get("data").toString();
			String resultStatus = resMap.get("code").toString();

			if (Util.isEmpty(strResult) || !"0".equals(resultStatus)) {
				return resMap;
			} else {
				JSONParser jsonParser = new JSONParser();
				Object oResponse = jsonParser.parse(strResult);
				JSONArray jDataRes = (JSONArray) oResponse;

				List<EtomarsDataVo> dataVoList = new ArrayList();

				boolean errorFlg = false;
				for (int i=0; i<jDataRes.size(); i++) {
					EtomarsDataVo dataVo = new EtomarsDataVo();

					JSONObject jResponse = (JSONObject) jDataRes.get(i);
					if (!Util.isEmpty(jResponse)) {

						if (Integer.parseInt(jResponse.get("Status").toString()) <= 0) {
							errorFlg = true;
							break;
						}

						dataVo.setRegNo(jResponse.get("RegNo").toString());
						dataVo.setStatus(jResponse.get("Status").toString());
						dataVo.setStatusDesc(jResponse.get("StatusDesc").toString());
						dataVo.setOrderNo1(jResponse.get("OrderNo1").toString());
						dataVo.setOrderNo2(jResponse.get("OrderNo2").toString());
						dataVo.setDelvNo(jResponse.get("DelvNo").toString());
						dataVo.setDelvCom(jResponse.get("DelvCom").toString());
						dataVo.setDelvComName(jResponse.get("DelvComName").toString());
						dataVo.setNationCode(jResponse.get("NationCode").toString());
						dataVo.setShippingType(jResponse.get("ShippingType").toString());
						dataVo.setSenderName(jResponse.get("SenderName").toString());
						dataVo.setSenderTelno(jResponse.get("SenderTelno").toString());
						dataVo.setSenderAddr(jResponse.get("SenderAddr").toString());
						dataVo.setReceiverName(jResponse.get("ReceiverName").toString());
						dataVo.setReceiverNameYomigana(jResponse.get("ReceiverNameYomigana").toString());
						dataVo.setReceiverTelNo1(jResponse.get("ReceiverTelNo1").toString());
						dataVo.setReceiverTelNo2(jResponse.get("ReceiverTelNo2").toString());
						dataVo.setReceiverZipcode(jResponse.get("ReceiverZipcode").toString());
						dataVo.setReceiverState(jResponse.get("ReceiverState").toString());
						dataVo.setReceiverCity(jResponse.get("ReceiverCity").toString());
						dataVo.setReceiverDistrict(jResponse.get("ReceiverDistrict").toString());
						dataVo.setReceiverDetailAddr(jResponse.get("ReceiverDetailAddr").toString());
						dataVo.setReceiverEmail(jResponse.get("ReceiverEmail").toString());
						dataVo.setReceiverSocialNo(jResponse.get("ReceiverSocialNo").toString());
						dataVo.setRealWeight(jResponse.get("RealWeight").toString());
						dataVo.setWeightUnit(jResponse.get("WeightUnit").toString());
						dataVo.setBoxCount(Integer.parseInt(jResponse.get("BoxCount").toString()));
						dataVo.setCurrencyUnit(jResponse.get("CurrencyUnit").toString());
						dataVo.setDelvMessage(jResponse.get("DelvMessage").toString());
						dataVo.setUserData1(jResponse.get("UserData1").toString());
						dataVo.setUserData2(jResponse.get("UserData2").toString());
						dataVo.setUserData3(jResponse.get("UserData3").toString());
						dataVo.setDimWidth(jResponse.get("DimWidth").toString());
						dataVo.setDimLength(jResponse.get("DimLength").toString());
						dataVo.setDimHeight(jResponse.get("DimHeight").toString());
						dataVo.setDimUnit(jResponse.get("DimUnit").toString());

						//goodslist취득
						JSONArray goodsListArray = (JSONArray) jResponse.get("GoodsList");
						//
						List<EtomarsDataDtlVo> dataDtlList = new ArrayList();
						for(int j=0; j<goodsListArray.size(); j++){
							JSONObject dataObj = (JSONObject) goodsListArray.get(j);
							EtomarsDataDtlVo dtlVo = new EtomarsDataDtlVo();

							dtlVo.setGoodsName(dataObj.get("GoodsName").toString());
							dtlVo.setQty(Integer.parseInt(dataObj.get("Qty").toString()));
							dtlVo.setUnitPrice(dataObj.get("UnitPrice").toString());
							dtlVo.setBrandName(dataObj.get("BrandName").toString());
							dtlVo.setSku(dataObj.get("SKU").toString());
							dtlVo.setHsCode(dataObj.get("HSCODE").toString());
							dtlVo.setPurchaseUrl(dataObj.get("PurchaseUrl").toString());
							dataDtlList.add(dtlVo);
						}
						dataVo.setGoodsList(dataDtlList);
					}
					dataVoList.add(dataVo);
				}

				if (errorFlg) {
					return resMap;
				} else {
					retMap.put("code", "0");
					retMap.put("message", "success");
					retMap.put("data", dataVoList);
					return retMap;
				}
			}
		} catch (Exception e) {
			retMap.put("code", "500");
			retMap.put("message", "getData API response ERROR");
			retMap.put("data", "");
			return retMap;
		}
	}


	/**
	 * Etomars API 배송조회
	 * @param serverType
	 * @param shipments
	 * @return
	 */
	private Map<String, Object> getTracking(List<String> regNoList) {
		Map<String, Object> retMap = new HashMap<>();
		logger.debug("regNoList.size() : "+ regNoList.size());

		try {
			// 1. 해더생성
			HttpURLConnection conn = this.createHeader("GetTracking");
			conn.connect();

			// 2. etomars API 서버에 보낼 body 데이터 생성
			String apiKey = realEtomarsApiKey;
			StringBuffer sb = new StringBuffer();

			boolean flg = false;

			// 전송데이터 작성
			sb.append("{ ");
			sb.append("\"ApiKey\": "+"\""+ apiKey +"\"");
			sb.append(" , ");
			sb.append("\"RegNoList\": [ ");
			for ( int i=0; i<regNoList.size(); i++ ) {
				if (flg) {
					sb.append(",");
				}
				sb.append("\""+ Util.getStrTrim(regNoList.get(i).toString()) +"\"");
				flg = true;
			}
			sb.append("  ]");
			sb.append("}");

			logger.debug("GetTracking JSON Data : "+ sb.toString());

			JSONObject resJson =  this.sendData(conn, sb);

			JSONParser jsonParser = new JSONParser();
			Object oResponse = jsonParser.parse(resJson.toString());
			JSONObject jResponse = (JSONObject) oResponse;

			Object tmpObj = jsonParser.parse(jResponse.get("Data").toString());
			logger.debug("========");

			if (!Util.isEmpty(tmpObj)) {
				logger.debug("========");
				if (jResponse.get("Code").toString().equals("0")) {
					retMap.put("code", "0");
					retMap.put("message", "success");
					retMap.put("data", jResponse.get("Data").toString());
				} else {
					retMap.put("code", jResponse.get("Code").toString());
					retMap.put("message", jResponse.get("Message").toString());
					retMap.put("data", "");
				}
			} else {
				retMap.put("code", jResponse.get("Code").toString());
				retMap.put("message", "getTracking API data error");
				retMap.put("data", "");
			}

			return retMap;
		} catch (Exception e) {
			retMap.put("code", "500");
			retMap.put("message", e.fillInStackTrace());
			retMap.put("data", "");
			return retMap;
		}
	}

	/**
	 * Etomars API 배송조회
	 * @param regNoList
	 * @return
	 */
	public Map<String, Object> getTrackingSearch(List<String> regNoList) {

		Map<String, Object> retMap = new HashMap<>();
		if (regNoList.size() == 0) {
			retMap.put("code", "404");
			retMap.put("message", "접수번호정보가 없습니다.");
			retMap.put("data", "");
			return retMap;
		}

		try {
			Map<String, Object> resMap = getTracking(regNoList);
			String strResult = resMap.get("data").toString();
			String resultStatus = resMap.get("code").toString();

			if (Util.isEmpty(strResult) || !"0".equals(resultStatus)) {
				return resMap;
			} else {
				JSONParser jsonParser = new JSONParser();
				Object oResponse = jsonParser.parse(strResult);
				JSONArray jDataRes = (JSONArray) oResponse;

				List<EtomarsTrackingVo> trackingVoList = new ArrayList();

				boolean errorFlg = false;
				for (int i=0; i<jDataRes.size(); i++) {
					EtomarsTrackingVo trackingVo = new EtomarsTrackingVo();

					JSONObject jResponse = (JSONObject) jDataRes.get(i);
					if (!Util.isEmpty(jResponse)) {

						if (Integer.parseInt(jResponse.get("Status").toString()) <= 0) {
							errorFlg = true;
							break;
						}

						trackingVo.setRegNo(jResponse.get("RegNo").toString());
						trackingVo.setStatus(jResponse.get("Status").toString());
						trackingVo.setStatusDesc(jResponse.get("StatusDesc").toString());
						trackingVo.setOrderNo1(jResponse.get("OrderNo1").toString());
						trackingVo.setOrderNo2(jResponse.get("OrderNo2").toString());
						trackingVo.setDelvNo(jResponse.get("DelvNo").toString());
						trackingVo.setDelvCom(jResponse.get("DelvCom").toString());
						trackingVo.setDelvComName(jResponse.get("DelvComName").toString());
						trackingVo.setDepCountryCode(jResponse.get("DepCountryCode").toString());
						trackingVo.setDepCountryName(jResponse.get("DepCountryName").toString());
						trackingVo.setArrCountryCode(jResponse.get("ArrCountryCode").toString());
						trackingVo.setArrCountryName(jResponse.get("ArrCountryName").toString());

						//traickinglist취득
						JSONArray trackingListArray = (JSONArray) jResponse.get("TrackingList");

						List<EtomarsTrackingDtlVo> trackingList = new ArrayList();
						for(int j=0; j<trackingListArray.size(); j++){
							JSONObject trackingObj = (JSONObject) trackingListArray.get(j);
							EtomarsTrackingDtlVo dtlVo = new EtomarsTrackingDtlVo();

							dtlVo.setStatus(trackingObj.get("Status").toString());
							dtlVo.setStatusDesc(trackingObj.get("StatusDesc").toString());
							dtlVo.setIssueDateTime(trackingObj.get("IssueDateTime").toString());
							dtlVo.setIssueDetail(trackingObj.get("IssueDetail").toString());
							trackingList.add(dtlVo);
						}
						trackingVo.setTrackingList(trackingList);
					}
					trackingVoList.add(trackingVo);
				}

				if (errorFlg) {
					return resMap;
				} else {
					retMap.put("code", "0");
					retMap.put("message", "success");
					retMap.put("data", trackingVoList);
					return retMap;
				}
			}
		} catch (Exception e) {
			retMap.put("code", "500");
			retMap.put("message", "getTracking API response ERROR");
			retMap.put("data", "");
			return retMap;
		}
	}

	String returnBrace(int idnex, int listSize, String type) {
		if ((idnex + 1) == listSize) {
			return type;
		} else {
			return type +",";
		}
	}

}
