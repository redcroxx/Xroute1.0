package xrt.fulfillment.order.shippinglist;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;
import xrt.alexcloud.api.aftership.AfterShipAPI;
import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.tracking.TrackingHistorytVO;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.Util;

@Service
public class ShippingListBiz extends DefaultBiz {

	Logger logger = LoggerFactory.getLogger(ShippingListBiz.class);

	@Value("#{config['c.debugtype']}")
	private String debugtype;

	@Autowired
	AfterShipAPI afterShipAPI;

	public List<ShippingListVO> getSearch(CommonSearchVo paramVo) throws Exception {
		return dao.selectList("shippingListMapper.getSearch", paramVo);
	}

	public LDataMap getPopSearch(CommonSearchVo paramVo) throws Exception {
		return (LDataMap) dao.selectOne("shippingListMapper.getTOrder", paramVo);
	}

	public List<LDataMap> shippingGetOrders() throws Exception {
		return dao.selectList("shippingListMapper.shippingGetOrders", null);
	}

	public LDataMap getOrderSearch(LDataMap param) throws Exception {
		return (LDataMap) dao.selectOne("shippingListMapper.getOrder", param);
	}

	public LRespData setTrackingHistory(LDataMap order) throws Exception {
		String atomyOrgCd = CommonConst.ATOMY_DEV_ORGCD;
		if (debugtype.equals("REAL")) {
			atomyOrgCd = CommonConst.ATOMY_REAL_ORGCD;
		}

		if (Util.isEmpty(order)) {
			LRespData retMap = new LRespData();
			return retMap;
		}

		String usercd = order.getString("addusercd");
		String xrtInvcSno = order.getString("xrtInvcSno");
		String resStatusCd = order.getString("statusCd");
		String slug = order.getString("slug").toLowerCase(); // XROUTE TORDER LOCAL_SHIPPER(?????? ?????????).
		String trackingNumber = order.getString("invcSno1");

		TrackingHistorytVO trackingHistorytVO = new TrackingHistorytVO();
		trackingHistorytVO.setXrtInvcSno(xrtInvcSno);
		List<TrackingHistorytVO> trackingHistoryList = dao.selectList("shippingListMapper.getTrackingHistory",
				trackingHistorytVO);
		List<TrackingHistorytVO> resList = new ArrayList<TrackingHistorytVO>();
		resList.addAll(trackingHistoryList);
		
		

		LDataMap trackingMap = afterShipAPI.getTrackings(slug, trackingNumber);
		JSONObject resJson = (JSONObject) trackingMap.get("data");
		JSONParser jsonParser = new JSONParser();
		JSONObject dataJson = (JSONObject) jsonParser.parse(resJson.get("data").toString()); // data.
		JSONObject metaJson = (JSONObject) resJson.get("meta"); // code : 200
		JSONObject trackingJson = (JSONObject) jsonParser.parse(dataJson.get("tracking").toString());
		JSONArray checkpointsJsonArray = (JSONArray) jsonParser.parse(trackingJson.get("checkpoints").toString());

		String tag = trackingJson.get("tag").toString();
		String pickupLocation = trackingJson.get("pickup_location").toString();

		// meta ?????? code??? 200??? ?????? ??????, ????????? ???????????? ???????????? ??????.
		if (!metaJson.get("code").toString().equals("200")) {
			LRespData retMap = new LRespData();
			retMap.put("resultList", resList);
			return retMap;
		}

		// LOCAL_SHIPPER(slug) ?????? ?????????????????? ?????????, ????????? ???????????? ???????????? ??????.
//		if (slug.equals("") || trackingNumber.equals("")) {
//			LRespData retMap = new LRespData();
//			retMap.put("resultList", resList);
//			return retMap;
//		}
		
		// histroyList??? rows??? addtime?????? ?????? ??????????????? ?????????????????????
		Date histroyDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(resList.get(resList.size()-1).getAdddatetime().toString());
		List<CheckPointVO> filterCheckpoints = new ArrayList<CheckPointVO>();
		for (int i = 0; i < checkpointsJsonArray.size(); i++) {
			filterCheckpoints.add(new ObjectMapper().readValue(((JSONObject) checkpointsJsonArray.get(i)).toJSONString(), CheckPointVO.class));
		}
		
		List<CheckPointVO> checkpoints = new ArrayList<CheckPointVO>();
		for (int i =0; i<filterCheckpoints.size(); i++) {
			// ?????? ?????? ??? add
			if (histroyDate.before(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(filterCheckpoints.get(i).getCheckpoint_time().toString()))){
				checkpoints.add(filterCheckpoints.get(i));
			}
		}
		

		List<TrackingHistorytVO> historytList = setTrackingFromAfterShip(xrtInvcSno, pickupLocation, usercd,
				checkpoints);
		// adddatetime ????????? ??????.
		resList.addAll(historytList);
		resList.sort(
				(TrackingHistorytVO a1, TrackingHistorytVO a2) -> a1.getAdddatetime().compareTo(a2.getAdddatetime()));

		// ??????????????? ???????????? ???????????? ??????
		if (resStatusCd.equals(CommonConst.ORD_STATUS_CD_DELIVERY_COMP)) {
			LRespData retMap = new LRespData();
			retMap.put("resultList", resList);
			return retMap;
		}
		
		String statusCd = "";
		switch (tag) {
		case "OutforDelivery":
			statusCd = CommonConst.ORD_STATUS_CD_CC_WAIT; // ????????????????????? ?????? (OutforDelivery??? ???????????? ???????????? ?????? ??????)
			break;
		case "InTransit":
			statusCd = CommonConst.ORD_STATUS_CD_CC_WAIT; // ????????????????????? ?????? (InTransit??? ???????????? ???????????? ???????????? ??????)
			break;
		case "Delivered":
			statusCd = CommonConst.ORD_STATUS_CD_DELIVERY_COMP; // ????????? ????????????.
			break;
		default:
			break;
		}
		

		
		if (tag.equals("Delivered")) {
			for (int i = 0; i < historytList.size(); i++) {
				dao.insert("trackingHistoryMapper.insertTrackingHistory", historytList.get(i));
			}
			
			String orgCd = dao.selectStrOne("shippingListMapper.getOrgCd", order);
			// ????????? ??????????????? ????????? ??????.
			if (orgCd.equals(atomyOrgCd)) {
				List<LDataMap> bodyList = dao.select("shippingListMapper.getDeliveredData", order);
				if (bodyList.size() != 0) {
					this.setDelivered(bodyList); // ????????? ???????????? ?????? API ??????.
				}
			}
		}

		if (statusCd.equals("")) {
			statusCd = "0";
		}

		if (Integer.parseInt(statusCd) > Integer.parseInt(resStatusCd)) {
			LDataMap paramMap = new LDataMap();
			paramMap.put("xrtInvcSno", xrtInvcSno);
			paramMap.put("usercd", "SYSTEM");
			paramMap.put("statusCd", statusCd);
			dao.update("shippingListMapper.updateTorder", paramMap);
		}

		LRespData retMap = new LRespData();
		retMap.put("resultList", resList);

		return retMap;
	}


	public LRespData setAtomyHistoryRefresh(List<LDataMap> order) throws Exception {
		for (int i = 0; i < order.size(); i++) {
			setTrackingHistory(order.get(i));
		}
		LRespData retMap = new LRespData();
		retMap.put("code", "200");
		return retMap;
	}

	public List<TrackingHistorytVO> setTrackingFromAfterShip(String xrtInvcSno, String country, String usercd,
			List<CheckPointVO> checkPoints) throws Exception {
		List<TrackingHistorytVO> resList = new ArrayList<TrackingHistorytVO>();
		SimpleDateFormat timeZone1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
		SimpleDateFormat timeZone2 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		for (int i = 0; i < checkPoints.size(); i++) {
			TrackingHistorytVO historytVO = new TrackingHistorytVO();
			historytVO.setXrtInvcSno(xrtInvcSno);
			historytVO.seteNation(checkPoints.get(i).getCountry_name() == null ? "KOR"
					: checkPoints.get(i).getCountry_name().toString());
			historytVO.setAddusercd(usercd);

			String checkpointTime = "";
			if (timeZoneValid(checkPoints.get(i).getCheckpoint_time())) {
				Date oriDate = timeZone1.parse(checkPoints.get(i).getCheckpoint_time());
				checkpointTime = dateFormat.format(oriDate);
			} else {
				Date oriDate = timeZone2.parse(checkPoints.get(i).getCheckpoint_time());
				checkpointTime = dateFormat.format(oriDate);
			}

			historytVO.setAdddatetime(checkpointTime);
			historytVO.setUpdusercd(usercd);
			historytVO.setTerminalcd(ClientInfo.getClntIP());

			String tag = checkPoints.get(i).getTag();
			switch (tag) {
			case "InTransit":
				historytVO.setStatusCd(CommonConst.ORD_STATUS_CD_CC_WAIT); // ????????? ??????????????? ??????
				historytVO.setStatusNm(checkPoints.get(i).getSubtag()); // Aftership ????????? ????????? ??????
				historytVO.setStatusEnNm(checkPoints.get(i).getMessage()); // ????????? ?????? ??????.
				resList.add(historytVO);
				break;
			case "OutForDelivery":
				historytVO.setStatusCd(CommonConst.ORD_STATUS_CD_CC_WAIT); // ????????? ?????????.
				historytVO.setStatusNm(checkPoints.get(i).getSubtag()); // Aftership ????????? ????????? ??????
				historytVO.setStatusEnNm(checkPoints.get(i).getMessage()); // ????????? ?????????.
				resList.add(historytVO);
				break;
			case "Delivered":
				historytVO.setStatusCd(CommonConst.ORD_STATUS_CD_DELIVERY_COMP); // ????????? ????????????.
				historytVO.setStatusNm(CommonConst.ORD_STATUS_NM_DELIVERY_COMP); // ????????? ????????????.
				historytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_DELIVERY_COMP); // ????????? ????????????.
				resList.add(historytVO);
				break;
			case "FailedAttempt":
				historytVO.setStatusCd(CommonConst.ORD_STATUS_CD_API_FAIL); // API ??????.
				historytVO.setStatusNm(checkPoints.get(i).getSubtag()); // API ??????.
				historytVO.setStatusEnNm(checkPoints.get(i).getMessage()); // API ??????.
				break;
			case "Exception":
				historytVO.setStatusCd(CommonConst.ORD_STATUS_CD_CC_WAIT); // ????????? ?????? ??????.
				historytVO.setStatusNm(checkPoints.get(i).getSubtag()); // API ??????.
				historytVO.setStatusEnNm(checkPoints.get(i).getMessage()); // API ??????.
				break;
			default:
				historytVO.setStatusCd(CommonConst.ORD_STATUS_CD_PENDING); // ????????? ?????? ??????.
				historytVO.setStatusNm(CommonConst.ORD_STATUS_NM_PENDING); // ????????? ?????? ??????.
				historytVO.setStatusEnNm(CommonConst.ORD_STATUS_EN_NM_PENDING); // ????????? ?????? ??????.
				break;
			}
		}
		return resList;
	}

	public boolean timeZoneValid(String date) {
		boolean flag = true;
		try {
			SimpleDateFormat timeZone = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");

			timeZone.setLenient(false);
			timeZone.parse(date);
			return flag;
		} catch (Exception e) {
			flag = false;
			return flag;
		}
	}

	// ????????? ???????????? API.
	public LDataMap setDelivered(List<LDataMap> bodyList) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for (int i = 0; i < bodyList.size(); i++) {
			sb.append("{");
			sb.append("\"SaleNum\": \"" + bodyList.get(i).getString("ordNo") + "\",");
			sb.append("\"Seq\": \"" + bodyList.get(i).getString("ordSeq") + "\",");
			if ((i + 1) == bodyList.size()) {
				sb.append("}");
			} else {
				sb.append("},");
			}
		}
		sb.append("]");

		String queryString = "/apiglobal/scm/kr/v1/status/finished";
		String apiType = "delivered";
		String httpMethod = "PUT";

		HttpURLConnection conn = this.setHttpHeader(queryString, httpMethod, apiType);
		JSONObject jsonObject = this.setHttpBody(conn, apiType, sb);

		LDataMap resMap = new ObjectMapper().readValue(jsonObject.toJSONString(), LDataMap.class);
		resMap.entrySet().forEach(entry -> {
			logger.info("" + entry.getKey() + " : " + entry.getValue());
		});

		String status = resMap.getString("Status");
		String message = resMap.getString("Message");

		LDataMap retMap = new LDataMap();
		retMap.put("code", status);
		retMap.put("message", message);
		return retMap;
	}

	public HttpURLConnection setHttpHeader(String queryString, String httpMethod, String apiType) throws Exception {

		String apiToken = CommonConst.ATOMY_DEV_API_TOKEN;
		String apiUserToken = CommonConst.ATOMY_DEV_API_USER_TOKEN;
		String url = CommonConst.ATOMY_DEV_URL;

		if (debugtype.equals("REAL")) {
			url = CommonConst.ATOMY_REAL_URL;
			apiToken = CommonConst.ATOMY_DEV_API_TOKEN;
			apiUserToken = CommonConst.ATOMY_DEV_API_USER_TOKEN;
		}

		HttpURLConnection retUrl = (HttpURLConnection) new URL(url + queryString).openConnection();
		retUrl.setRequestMethod(httpMethod);
		retUrl.setRequestProperty("Content-Type", "application/json;charset=utf-8");
		retUrl.setRequestProperty("Accept", "application/json;charset=utf-8");
		retUrl.setRequestProperty("Atomy-Api-Token", apiToken);
		retUrl.setRequestProperty("Atomy-User-Token", apiUserToken);
		retUrl.setDoOutput(true);
		return retUrl;
	}

	@SuppressWarnings({ "unchecked", "finally" })
	public JSONObject setHttpBody(HttpURLConnection conn, String apiType, StringBuffer reqSB) throws Exception {

		logger.info("reqSB : " + reqSB.toString());

		JSONObject retJson = new JSONObject();

		try {
			conn.connect();

			String encodeSendData = new String(reqSB.toString().getBytes("8859_1"), StandardCharsets.UTF_8);

			// 1. ????????? ??????
			OutputStreamWriter outputStreamWriter = new OutputStreamWriter(conn.getOutputStream(),
					StandardCharsets.UTF_8);
			outputStreamWriter.write(encodeSendData);
			outputStreamWriter.flush();

			// 2. ?????? ?????? ????????? ??????
			StringBuilder sb = new StringBuilder();
			BufferedReader bufferedReader = new BufferedReader(
					new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));

			String readLine;
			while ((readLine = bufferedReader.readLine()) != null) {
				sb.append(readLine).append("\n");
			}

			bufferedReader.close();
			JSONParser jsonParser = new JSONParser();
			Object object = jsonParser.parse(sb.toString());
			retJson = (JSONObject) object;

		} catch (Exception e) {
			retJson.put("Status", "0");
			retJson.put("StatusDetailCode", "");
			retJson.put("data", "");
			retJson.put("apiType", apiType);
			retJson.put("errMsg", e.getMessage());
		} finally {
			return retJson;
		}
	}
}