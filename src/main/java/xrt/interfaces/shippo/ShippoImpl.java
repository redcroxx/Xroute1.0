package xrt.interfaces.shippo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.shippo.Shippo;
import com.shippo.exception.ShippoException;
import com.shippo.model.Rate;
import com.shippo.model.Refund;
import com.shippo.model.Shipment;
import com.shippo.model.Transaction;

public class ShippoImpl {

	Logger logger = LoggerFactory.getLogger(ShippoImpl.class);

	@Autowired
	Shippo shippo;
	@Autowired
	Shipment shipment;
	@Autowired
	Rate rate;
	@Autowired
	Transaction transaction;

	public Map<String, Object> shipment(String apiKey, Map<String, Object> toAddressMap, Map<String, Object> fromAddressMap,
										List<Map<String, Object>> parcels ) throws ShippoException {
		logger.debug("apiKey : "+ apiKey +", toAddressMap : "+ toAddressMap.toString() +" , fromAddressMap : "+ fromAddressMap.toString() +" , parcels : "+ parcels.toString());
		logger.debug("01. API Null Check");
		if (apiKey.equals("")) {
			logger.debug("code : 404, message : API Key를 찾을 수 없습니다.");
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "404");
			retMap.put("message", "API Key를 찾을 수 없습니다.");
			return retMap;
		}
		logger.debug("02. API KEY Setting");
		shippo.setApiKey(apiKey);
		Map<String, Object> shipmentMap = new HashMap<>();
		shipmentMap.put("address_to", toAddressMap);
		shipmentMap.put("address_from", fromAddressMap);
		shipmentMap.put("parcels", parcels);
		shipmentMap.put("async", false);
		logger.debug("03. Shipment Create");
		Shipment shipment = Shipment.create(shipmentMap);
		logger.debug("04. get Rates Data");
		List<Rate> rates = shipment.getRates();
		Rate rate = rates.get(1);

		String weight = parcels.get(0).get("weight").toString();
		logger.debug("05. wgt <= 0.368 check");
		double wgt = Double.parseDouble(weight);
		if (wgt <= 0.3685) {
			if (apiKey.contains("test")) {
				rate = rates.get(1);
			} else {
				rate = rates.get(3);
			}
		}
		logger.debug("06. Getting shipping label..");
		Map<String, Object> transParams = new HashMap<String, Object>();
		transParams.put("rate", rate.getObjectId());
		transParams.put("async", false);
		Transaction transaction = Transaction.create(transParams);
		logger.debug("07. transaction Status Check");
		if (transaction.getStatus().equals("SUCCESS")) {
			logger.debug(String.format("Label url : %s", transaction.getLabelUrl()));
			logger.debug(String.format("transaction Tracking number : %s", transaction.getTrackingNumber()));
			logger.debug(String.format("transaction Object Id : %s", transaction.getObjectId()));

			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "200");
			retMap.put("message", "정상적으로 처리되었습니다.");
			retMap.put("trackingNumber", transaction.getTrackingNumber());
			retMap.put("shippoId", transaction.getObjectId());
			retMap.put("amount", rate.getAmount());

			return retMap;
		} else {
			logger.debug("code : 500, message : "+ transaction.getMessages());

			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "500");
			retMap.put("message", transaction.getMessages());
			return retMap;
		}
	}

	public Map<String, Object> refund(String apiKey, String transaction) {

		shippo.setApiKey(apiKey);

		Map<String, Object> retMap = new HashMap<>();

		HashMap<String, Object> createRefundMap = new HashMap<String, Object>();
		createRefundMap.put("transaction", transaction);
		createRefundMap.put("async", false);

		try {
			Refund refund =  Refund.create(createRefundMap);

			retMap.put("code", "200");
			retMap.put("message", "정상적으로 처리되었습니다.");
		} catch (Exception e) {
			String message = "";
			String errorMSG = e.getMessage();
			if (errorMSG.contains("Refund with this Transaction already exists")) {
				message = "이미 환불 처리된 데이터입니다.";
			}

			retMap.put("code", "500");
			retMap.put("message", message);
		}

		return retMap;
	}
}
