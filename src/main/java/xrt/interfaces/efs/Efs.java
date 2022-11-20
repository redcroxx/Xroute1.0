package xrt.interfaces.efs;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import xrt.lingoframework.utils.LDataMap;

@Component
public class Efs {

	private static final String REAL_URL = "http://www.efs.asia:200/api/in/";
	private static final String API_KEY = "3d10ad45396a1cda654bc40498551eb0";
	private static final String CREATE_SHIPMENT_FUNCTION = "createshipment";

	Logger logger = LoggerFactory.getLogger(Efs.class);


	/**
	 * EFS API 설정 및 EFS Server에 전송
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getSend(LDataMap paramList) throws Exception {
		String data = null;
		URL obj = null;

		Map<String, Object> retMap = new HashMap<>();

		try {
			data = "apikey=" + API_KEY + "&req_function=" + CREATE_SHIPMENT_FUNCTION + "&send_data=" + paramList.get("DATA").toString();

			obj = new URL(paramList.get("URL").toString());
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			//add reuqest header
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");

			// Send post request
			con.setDoInput(true);
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.write(data.getBytes());
			wr.flush();
			wr.close();

			int responseCode = con.getResponseCode();
			logger.debug("\nSending 'POST' request to URL : " + REAL_URL);
			logger.debug("Post parameters : " + data);
			logger.debug("Response Code : " + responseCode);

			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}

			in.close();

			retMap.put("resultData", response);
			retMap.put("code", "200");
			retMap.put("message", "success");
			return retMap;
		} catch(Exception e) {
			retMap.put("code", "500");
			retMap.put("message", e.fillInStackTrace());
			return retMap;
		}
	}
}
