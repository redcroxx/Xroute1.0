package xrt.alexcloud.api.efs;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import xrt.alexcloud.api.efs.vo.EfsShipmentVo;
import xrt.lingoframework.utils.Util;

@Component
public class EfsAPI {

	@Value("#{config['c.debugtype']}")
	private String debugtype;

	@Value("#{config['c.realEfsURL']}")
	private String realEfsURL;

	@Value("#{config['c.realEfsApiKey']}")
	private String realEfsApiKey;


	private static final String DATA_FIELD_CODE = "|";
	private static final String DTL_DATA_ST = "{";
	private static final String DTL_DATA_END = "}";
	private static final String COMMA_CODE = ",";
	private static final String CRLF_CODE = "\r\n";

	Logger logger = LoggerFactory.getLogger(EfsAPI.class);

	/**
	 * EFS API 설정 및 EFS Server에 전송
	 * @param paramList
	 * @return
	 * @throws Exception
	 */
	public String sendData(StringBuffer sendData, String functionNm) throws Exception {
		String data = null;
		URL obj = null;

		String convSendData = java.net.URLEncoder.encode(sendData.toString(), "UTF-8");
		data = "apikey=" + realEfsApiKey + "&req_function=" + functionNm + "&send_data=" + convSendData;

		obj = new URL(realEfsURL);
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
		logger.debug("\nSending 'POST' request to URL : " + realEfsURL);
		logger.debug("Post parameters : " + data);
		logger.debug("Response Code : " + responseCode);

		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine).append("\n");
		}
		in.close();

		logger.debug("response : "+ response.toString());

		return response.toString();
	}


	/**
	 * EFS 송화물 운송 상세정보 송수신 (req_function=createShipment)
	 * @param serverType
	 * @param shipments
	 * @return
	 */
	public Map<String, Object> createShipment(List<EfsShipmentVo> shipments ) {

		Map<String, Object> retMap = new HashMap<>();

		logger.debug("shipments.size() : "+ shipments.size());
		if ( shipments.size() == 0) {
			retMap.put("code", "404");
			retMap.put("message", "주문정보가 없습니다.");
			return retMap;
		}

		try {

			StringBuffer sb = new StringBuffer();

			for (int i = 0; i < shipments.size(); i++) {
				if (i > 0) {
					sb.append(CRLF_CODE);
				}
				sb.append(DATA_FIELD_CODE);         //송장번호 (예약번호)
				sb.append(shipments.get(i).getXrtInvcNo()).append(DATA_FIELD_CODE);          // 발송품 참조 번호
				sb.append(shipments.get(i).getShipMethodCd()).append(DATA_FIELD_CODE);       // 발송 서비스 타입
				sb.append(shipments.get(i).getShipName()).append(DATA_FIELD_CODE);           // 송화인명
				sb.append(shipments.get(i).getShipAddr()).append(DATA_FIELD_CODE);           // 송화인 주소
				sb.append(shipments.get(i).getShipPost()).append(DATA_FIELD_CODE);           // 송화인 우편번호
				sb.append(shipments.get(i).getShipTel()).append(DATA_FIELD_CODE);            // 송화인 전화번호
				sb.append(shipments.get(i).getShipMobile()).append(DATA_FIELD_CODE);         // 송화인 핸드폰번호
				sb.append(DATA_FIELD_CODE);         // 송화인 국가 코드
				sb.append(DATA_FIELD_CODE);         // 송화인 도시 코드
				sb.append(shipments.get(i).getRecvName()).append(DATA_FIELD_CODE);           // 수화인명
				sb.append(shipments.get(i).getRecvAddr()).append(DATA_FIELD_CODE);           // 수화인 주소
				sb.append(shipments.get(i).getRecvPost()).append(DATA_FIELD_CODE);           // 수화인 우편번호
				sb.append(shipments.get(i).getRecvTel()).append(DATA_FIELD_CODE);            // 수화인 전화번호
				sb.append(shipments.get(i).getRecvMobile()).append(DATA_FIELD_CODE);         // 수화인 핸드폰번호
				sb.append(shipments.get(i).getRecvNation()).append(DATA_FIELD_CODE);         // 수화인 국가코드
				sb.append(DATA_FIELD_CODE);         // 수화인 도시코드


				for (int j = 0; j <shipments.get(i).getOrderDtlList().size(); j++) {
					if (j > 0) {
						sb.append(COMMA_CODE);         // 항목구분콤마(,)
					}
					sb.append(DTL_DATA_ST);         // 상세 START
					sb.append("\"XROUTE\"");         //판매 쇼핑몰명
					sb.append(COMMA_CODE);         // 항목구분콤마(,)
					sb.append("\"" + shipments.get(i).getOrderDtlList().get(j).getDtlCartNo() +"\"");         //장바구니번호
					sb.append(COMMA_CODE);         // 항목구분콤마(,)
					sb.append("\"" + shipments.get(i).getOrderDtlList().get(j).getDtlOrdNo() +"\"");          //주문 번호
					sb.append(COMMA_CODE);         // 항목구분콤마(,)
					sb.append("\"" + shipments.get(i).getOrderDtlList().get(j).getGoodsCd() +"\"");           //상품 번호
					sb.append(COMMA_CODE);         // 항목구분콤마(,)
					sb.append("\"" + shipments.get(i).getOrderDtlList().get(j).getGoodsNm() +"\"");           //상품명
					sb.append(COMMA_CODE);         // 항목구분콤마(,)
					sb.append("\"\"");             //상품종류
					sb.append(COMMA_CODE);         // 항목구분콤마(,)
					sb.append("\"" + shipments.get(i).getOrderDtlList().get(j).getGoodsOption() +"\"");       //상품 옵션
					sb.append(COMMA_CODE);         // 항목구분콤마(,)
					sb.append("\"" + shipments.get(i).getOrderDtlList().get(j).getGoodsOptionKor() +"\"");    //상품 옵션(KOR)
					sb.append(COMMA_CODE);         // 항목구분콤마(,)
					sb.append("\"" + shipments.get(i).getOrderDtlList().get(j).getGoodsCnt() +"\"");          //상품수량
					sb.append(COMMA_CODE);         // 항목구분콤마(,)
					sb.append("\"" + shipments.get(i).getOrderDtlList().get(j).getDtlRecvCurrency() +"\"");   //상품단위가격통화
					sb.append(COMMA_CODE);         // 항목구분콤마(,)
					sb.append("\"" + shipments.get(i).getOrderDtlList().get(j).getPaymentPrice() +"\"");      //상품단위가격
					sb.append(DTL_DATA_END);         // 상세 END
				}

				sb.append(DATA_FIELD_CODE);      //상품전체무게
				sb.append(DATA_FIELD_CODE);      //수출입 신고 가격
				sb.append(DATA_FIELD_CODE);      //배송요청사항
				sb.append(DATA_FIELD_CODE);      //선백 배송
				sb.append(DATA_FIELD_CODE);      //물품 무게 정보
				//수출신고번호는 DATA_FIELD_CODE가 불필요.
			}

			logger.debug("send_data : " + sb.toString());

			// 데이터 송수신
			String responseStr= this.sendData(sb, "createShipment");
			retMap.put("data", responseStr);
			return retMap;
		} catch ( Exception e ) {
			retMap.put("code", "500");
			retMap.put("message", e.fillInStackTrace());
			return retMap;
		}
	}

	/**
	 * 송화물 운송 Tracking 정보 송수신 (req_function=getTrackStatus)
	 * @param invcSno
	 * @return
	 */
	public Map<String, Object> getTrackStatus(String invcSno) {
		logger.debug("[getTrackStatus] invcSno : "+ invcSno);
		Map<String, Object> retMap = new HashMap<>();

		if (Util.isEmpty(invcSno)) {
			logger.debug("code : 404, message : 송장번호가 없습니다.");
			retMap.put("code", "404");
			retMap.put("message", "송장번호가 없습니다.");
			return retMap;
		}

		try {

			logger.debug("Try Start!");

			StringBuffer sb = new StringBuffer();
			sb.append(invcSno);

			// 데이터 송수신
			String responseStr =  this.sendData(sb, "getTrackStatus");
			retMap.put("data", responseStr);
			retMap.put("message", "success");
			retMap.put("code", "200");
			return retMap;
		} catch ( Exception e ) {
			logger.debug("fillInStackTrace : "+ e.fillInStackTrace());
			retMap.put("code", "500");
			retMap.put("message", e.getMessage());
			return retMap;
		}
	}
}