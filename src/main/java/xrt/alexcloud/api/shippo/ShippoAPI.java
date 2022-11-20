package xrt.alexcloud.api.shippo;

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

import xrt.lingoframework.utils.LDataMap;

public class ShippoAPI {

    Logger logger = LoggerFactory.getLogger(ShippoAPI.class);

    @Autowired
    private Shippo shippo;

    public LDataMap shipment(String apiKey, Map<String, Object> toAddressMap, Map<String, Object> fromAddressMap, List<Map<String, Object>> parcels) throws ShippoException {
        logger.debug("[shipment] apiKey : " + apiKey + ", toAddressMap : " + toAddressMap.toString() + ", fromAddressMap : " + fromAddressMap.toString() + ", parcels : " + parcels.toString());

        if (apiKey.equals("")) {
            LDataMap retMap = new LDataMap();
            retMap.put("code", "404");
            retMap.put("message", "API Key를 찾을 수 없습니다.");
            return retMap;
        }

        shippo.setApiKey(apiKey);

        LDataMap shipmentMap = new LDataMap();
        shipmentMap.put("address_to", toAddressMap);
        shipmentMap.put("address_from", fromAddressMap);
        shipmentMap.put("parcels", parcels);
        shipmentMap.put("async", false);

        Shipment shipment = Shipment.create(shipmentMap);

        List<Rate> rates = shipment.getRates();
        Rate rate = rates.get(1);

        String weight = parcels.get(0).get("weight").toString();
        double wgt = Double.parseDouble(weight);
        if (wgt <= 0.3685) {
            rate = rates.get(3);
        }

        logger.debug("Getting shipping label..");
        LDataMap transParams = new LDataMap();
        transParams.put("rate", rate.getObjectId());
        transParams.put("async", false);
        Transaction transaction = Transaction.create(transParams);

        if (transaction.getStatus().equals("SUCCESS")) {
            logger.debug("Label url : %s", transaction.getLabelUrl());
            logger.debug("transaction Tracking number : %s", transaction.getTrackingNumber());
            logger.debug("transaction Object Id : ", transaction.getObjectId());

            LDataMap retMap = new LDataMap();
            retMap.put("code", "200");
            retMap.put("message", "정상적으로 처리되었습니다.");
            retMap.put("trackingNumber", transaction.getTrackingNumber());
            retMap.put("shippoId", transaction.getObjectId());
            retMap.put("amount", rate.getAmount());

            return retMap;
        } else {
            logger.debug(String.format("An Error has occured while generating you label. Messages : %s", transaction.getMessages()));

            LDataMap retMap = new LDataMap();
            retMap.put("code", "500");
            retMap.put("message", transaction.getMessages());
            return retMap;
        }
    }

    public Map<String, Object> refund(String apiKey, String transaction) {
        logger.debug("[shipment] apiKey : " + apiKey + ", transaction : " + transaction);

        shippo.setApiKey(apiKey);

        Map<String, Object> retMap = new HashMap<>();

        HashMap<String, Object> createRefundMap = new HashMap<String, Object>();
        createRefundMap.put("transaction", transaction);
        createRefundMap.put("async", false);

        try {
            Refund refund = Refund.create(createRefundMap);

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
