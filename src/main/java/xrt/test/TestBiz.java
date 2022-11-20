package xrt.test;

import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

import java.net.HttpURLConnection;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;


@Service
public class TestBiz extends DefaultBiz {
	
	public LRespData getSend(LDataMap paramList) throws Exception {
		LRespData resultMap = null;
		String data = null;
		URL obj = null;
		int responsResultCnt = 0;
		
		try {
			
			resultMap = new LRespData();
			
//			data = "apikey=" + paramList.get("KEY").toString() + "&req_function=" + paramList.get("FUNCTION").toString() + "&send_data=" + paramList.get("DATA").toString();
//	        obj = new URL(paramList.get("URL").toString());
			
		    String convSendData = java.net.URLEncoder.encode(paramList.get("DATA").toString(), "UTF-8");
			data = "apikey=" + paramList.get("KEY").toString() + "&req_function=" + paramList.get("FUNCTION").toString() + "&send_data=" + convSendData;
			
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
	        System.out.println("\nSending 'POST' request to URL : " + paramList.get("URL").toString());
	        System.out.println("Post parameters : " + data);
	        System.out.println("Response Code : " + responseCode);
	
	        BufferedReader in = new BufferedReader(
	                new InputStreamReader(con.getInputStream()));
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	
	        while ((inputLine = in.readLine()) != null) {
	            response.append(inputLine).append("\n");
	        }
	        in.close();
	        
	        System.out.println("Response Data : " + response);
	        
	        String[] change_target = response.toString().split("\\n");
	        
	        for(int i=0; i < change_target.length; i++) {
	        	System.out.println("change_target["+i+"] : "+change_target[i]);
	        }
	        resultMap.put("resultData", response);
		}
		catch(Exception e) {
			throw new LingoException("처리중 오류가 발생되었습니다.");
		}
		finally {
			return resultMap;
		}
	}
	
}
