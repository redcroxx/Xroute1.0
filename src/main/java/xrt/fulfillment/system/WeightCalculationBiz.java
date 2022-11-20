package xrt.fulfillment.system;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

/**
 * WeightCalculationService
 * 
 * @since 2021-01-05
 * @author wnkim
 *
 */
@Service
public class WeightCalculationBiz extends DefaultBiz {

	Logger logger = LoggerFactory.getLogger(WeightCalculationBiz.class);

	/**
	 * PREMIUM : 기본반환 (length * height * width) / 6000, DHL : 기본반환 (length * height
	 * * width) / 5000, UPS : 기본반환 (length * height * width) / 5000
	 * 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public LDataMap getWeightCalculation(LDataMap paramMap) throws Exception {
		logger.info("reqMap => ");
		paramMap.entrySet().forEach(entry -> {
			logger.info("" + entry.getKey() + " : " + entry.getValue());
		});

		paramMap.put("type", "multi");
		LDataMap retMap = checkCountry(paramMap);
		return retMap;
	}

	public void testJson() throws Exception {

		
		ClassPathResource resource = new ClassPathResource("json/upsZone.json");
		System.out.println(resource.getFilename()); 
		JSONObject json = (JSONObject) new JSONParser().parse(new InputStreamReader(resource.getInputStream(), "UTF-8"));
		// JSONArray임
		// json.get(/*국가코드*/)
		System.out.println(json.get("AR").toString());
		
	}

	// 국가 체크.
	public LDataMap checkCountry(LDataMap paramMap) throws Exception {

		String shippingType = paramMap.getString("shippingType").toUpperCase(); // 배송 구분.
		String wgt = paramMap.getString("wgt"); // 무게.
		String width = paramMap.getString("width"); // 가로 길이.
		String height = paramMap.getString("height"); // 세로 길이.
		String length = paramMap.getString("length"); // 높이.
		String premiumCountry = paramMap.getString("premiumCountry").toUpperCase(); // 프리미엄 국가 코드.
		String dhlCountry = paramMap.getString("dhlCountry").toUpperCase(); // DHL 국가 코드.
		String upsCountry = paramMap.getString("upsCountry").toUpperCase(); // UPS 국가 코드.

		// 가로, 세로, 높이 길이 체크.
		if (length == null || length.equals("")) {
			length = "0";
		}

		if (width == null || width.equals("")) {
			width = "0";
		}

		if (height == null || height.equals("")) {
			height = "0";
		}

		if (wgt == null || wgt.equals("")) {
			wgt = "0";
		}

		if (length.indexOf(".") == 0) {
			length = "0" + length;
		}

		if (width.indexOf(".") == 0) {
			width = "0" + width;
		}

		if (height.indexOf(".") == 0) {
			height = "0" + height;
		}

		if (wgt.indexOf(".") == 0) {
			wgt = "0" + wgt;
		}

		// 가로, 세로, 높이, 무게 소수로 변환.
		Double lengthD = Double.parseDouble(length);
		Double widthD = Double.parseDouble(width);
		Double heightD = Double.parseDouble(height);
		Double wgtD = Double.parseDouble(wgt);
		Double paramWgtD = Double.parseDouble(wgt); // 리턴 중량값.

		// 리턴 Map
		LDataMap retMap = new LDataMap();

		// 배송 구분 확인.
		switch (shippingType) {
		// 배송 구분이 premium.
		case CommonConst.SHIP_METHOD_PREMIUM:
			Double premiumVolumeD = (Double) (lengthD * widthD * heightD) / 6000;
			String sPremiumVolume = String.format("%.2f", premiumVolumeD);

			if (wgtD < Float.parseFloat(sPremiumVolume)) {
				paramWgtD = Double.parseDouble(sPremiumVolume);
			}

			if (paramWgtD > Integer.parseInt(CommonConst.LIMIT_WGT)) {
				throw new LingoException("최대 중량은 30kg 이하입니다.");
			}

			LDataMap dataMap = new LDataMap();
			dataMap.put("wgt", paramWgtD.toString());
			dataMap.put("country", premiumCountry);

			// 국가 코드 체크.
			switch (premiumCountry) {
			case "JP":
				break;
			case "US":
				break;
			case "SG":
				break;
			case "HK":
				break;
			case "MY":
				break;
			case "TW":
				break;
			default:
				throw new LingoException("지정된 국가가 아닙니다.");
			}

			PremiumRateVO rateVO = (PremiumRateVO) dao.selectOne("weightCalulationMapper.getPremiumPrice", dataMap);
			retMap.put("resultPrice", String.format("%,d", Integer.parseInt(rateVO.getPremium1())));
			break;

		// 배송 구분이 DHL.
		case CommonConst.SHIP_METHOD_DHL:
			Double dhlVolumeD = (Double) (lengthD * widthD * heightD) / 5000;
			String sDhlVolume = String.format("%.2f", dhlVolumeD);

			if (wgtD < Float.parseFloat(sDhlVolume)) {
				paramWgtD = Double.parseDouble(sDhlVolume);
			}

			if (paramWgtD > Integer.parseInt(CommonConst.LIMIT_WGT)) {
				throw new LingoException("최대 중량은 30kg 이하입니다.");
			}

			LDataMap dhlMap = new LDataMap();
			dhlMap.put("wgt", paramWgtD.toString());
			dhlMap.put("dhlCountry", dhlCountry);

			// DHL ZONE 정보 가져오기.
			DhlCountryZoneVO dhlCountryZoneVO = (DhlCountryZoneVO) dao.selectOne("weightCalulationMapper.getDhlZone",
					dhlMap);
			String zoneCode = dhlCountryZoneVO.getZone();

			DhlRateVO dhlRateVO = new DhlRateVO();
			dhlRateVO.setKg(paramWgtD.toString()); // 최종 무게.
			dhlRateVO.setZoneCode(zoneCode); // 해당 국가의 ZONE 정보.

			// 최종 무게와 존 정보로 배송비 계산.
			DhlRateVO dhlPriceVO = (DhlRateVO) dao.selectOne("weightCalulationMapper.getDhlPrice", dhlRateVO);

			if (dhlPriceVO.getDhlPrice() == null) {
				throw new LingoException("존재하지 않는 데이터입니다.");
			}

			retMap.put("resultPrice", String.format("%,d", Integer.parseInt(dhlPriceVO.getDhlPrice())));
			break;
		// 배송구분이 UPS일 경우,
		case CommonConst.SHIP_METHOD_UPS:
			Double upsVolumeD = (Double) (lengthD * widthD * heightD) / 5000;
			String sUpsVolume = String.format("%.2f", upsVolumeD);

			if (wgtD < Float.parseFloat(sUpsVolume)) {
				paramWgtD = Double.parseDouble(sUpsVolume);
			}

			if (paramWgtD > Integer.parseInt(CommonConst.UPS_LIMIT_WGT)) {
				throw new LingoException("UPS 최대 중량은 20kg 이하입니다.");
			}

			LDataMap upsMap = new LDataMap();
			upsMap.put("wgt", paramWgtD.toString());
			upsMap.put("upsCountry", upsCountry);

			// UPS ZONE 정보 가져오기.
			UpsCountryZoneVO upsCountryZoneVO = (UpsCountryZoneVO) dao.selectOneLE("weightCalulationMapper.getUpsZone",
					upsMap);
			String upsZoneCode = upsCountryZoneVO.getZone(); // 존 정보.
			String ess = upsCountryZoneVO.getEss(); // 비상상황수수료.

			UpsRateVO upsRateVO = new UpsRateVO();
			upsRateVO.setKg(paramWgtD.toString()); // 최종 무게.
			upsRateVO.setZoneCode(upsZoneCode); // 해당 국가의 ZONE 정보.

			// 최종 무게와 존 정보로 배송비 계산.
			UpsRateVO upsPriceVO = (UpsRateVO) dao.selectOne("weightCalulationMapper.getUpsPrice", upsRateVO);
			if (upsPriceVO.getUpsPrice() == null) {
				throw new LingoException("존재하지 않는 데이터입니다.");
			}

			logger.info("기본 요율 : " + upsPriceVO.getUpsPrice());

			int basicsPrice = Integer.parseInt(upsPriceVO.getUpsPrice()); // 기본 요율.
			int iEss = Integer.parseInt(ess); // 비상상황수수료.
			Double baf = 1.1925; // 2021년 07월 12일 유류할증료.

			Double dResultPrice = (basicsPrice + iEss) * baf;
			int iResultPrice = dResultPrice.intValue(); // int로 변환.
			logger.info("종합 요율 : " + iResultPrice);

			// String resultPrice = String.format("%,d", iResultPrice) + " (" + ess + " + "
			// + " 19.25(%))";
			String resultPrice = String.format("%,d", iResultPrice);

			retMap.put("resultPrice", resultPrice);
			break;
		default:
			throw new LingoException("배송구분이 없습니다.");
		}
		retMap.put("code", "1");
		retMap.put("message", "success");
		return retMap;
	}
}
