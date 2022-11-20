package xrt.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.shippo.Shippo;
import com.shippo.model.Rate;
import com.shippo.model.Shipment;
import com.shippo.model.Transaction;

import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

@Service
public class ShippoTestBiz {

public LRespData getShippoSend(LDataMap paramList) throws Exception {
		
		// replace with your Shippo Token
		// don't have one? get more info here (https://goshippo.com/docs/#overview)
		// String apiKey = "shippo_test_cf1b6d0655e59fc6316880580765066038ef20d8";
		String apiKey = paramList.get("KEY").toString();
	
		Shippo.setApiKey(apiKey);
		Shippo.setApiVersion("2018-02-08");

		// Optional defaults to false
		Shippo.setDEBUG(true);
		
		LRespData resultMap = new LRespData();

		// to address
		Map<String, Object> toAddressMap = new HashMap<String, Object>();
		toAddressMap.put("name", "Mr Hippo");
		toAddressMap.put("company", "Shippo");
		toAddressMap.put("street1", "215 Clayton St.");
		toAddressMap.put("city", "San Francisco");
		toAddressMap.put("state", "CA");
		toAddressMap.put("zip", "94117");
		toAddressMap.put("country", "US");
		toAddressMap.put("phone", "+1 555 341 9393");
		toAddressMap.put("email", "mrhippo@goshipppo.com");

		// from address
		Map<String, Object> fromAddressMap = new HashMap<String, Object>();
		fromAddressMap.put("name", "Ms Hippo");
		fromAddressMap.put("company", "San Diego Zoo");
		fromAddressMap.put("street1", "2920 Zoo Drive");
		fromAddressMap.put("city", "San Diego");
		fromAddressMap.put("state", "CA");
		fromAddressMap.put("zip", "92101");
		fromAddressMap.put("country", "US");
		fromAddressMap.put("email", "mshippo@goshipppo.com");
		fromAddressMap.put("phone", "+1 619 231 1515");
		fromAddressMap.put("metadata", "Customer ID 123456");

		// parcel
		Map<String, Object> parcelMap = new HashMap<String, Object>();
		parcelMap.put("length", "5");
		parcelMap.put("width", "5");
		parcelMap.put("height", "5");
		parcelMap.put("distance_unit", "in");
		parcelMap.put("weight", "2");
		parcelMap.put("mass_unit", "lb");
		List<Map<String, Object>> parcels = new ArrayList<Map<String, Object>>();
		parcels.add(parcelMap);

		Map<String, Object> shipmentMap = new HashMap<String, Object>();
		shipmentMap.put("address_to", toAddressMap);
		shipmentMap.put("address_from", fromAddressMap);
		shipmentMap.put("parcels", parcels);
		shipmentMap.put("async", false);

		Shipment shipment = Shipment.create(shipmentMap);

		// select shipping rate according to your business logic
		// we select the first rate in this example
		List<Rate> rates = shipment.getRates();
		Rate rate = rates.get(0);

		resultMap.put("rates", rates);
		resultMap.put("rate", rate);
		
		System.out.println("Getting shipping label..");
		Map<String, Object> transParams = new HashMap<String, Object>();
		transParams.put("rate", rate.getObjectId());
		transParams.put("async", false);
		Transaction transaction = Transaction.create(transParams);

		if (transaction.getStatus().equals("SUCCESS")) {
			System.out.println(String.format("Label url : %s", transaction.getLabelUrl()));
			System.out.println(String.format("Tracking number : %s", transaction.getTrackingNumber()));
			
			resultMap.put("resultData", transaction);
		} else {
			System.out.println(String.format("An Error has occured while generating you label. Messages : %s", transaction.getMessages()));
		}
	
		return resultMap;		
	}

}
