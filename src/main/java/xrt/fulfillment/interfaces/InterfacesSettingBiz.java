package xrt.fulfillment.interfaces;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import xrt.fulfillment.interfaces.vo.InterfaceSettingDtlVo;
import xrt.fulfillment.interfaces.vo.ShopeeParamVo;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.support.service.DefaultBiz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class InterfacesSettingBiz extends DefaultBiz {

	Logger logger = LoggerFactory.getLogger(InterfacesSettingBiz.class);

	List<InterfaceSettingDtlVo> getShopeeShopList(LoginVO loginVo) throws Exception {
		return dao.selectList("InterfacesMapper.getShopeeShopList", loginVo);
	}

	Object getShopeeData(LoginVO loginVo) throws Exception {
		return  dao.selectOne("InterfacesMapper.getShopeeData", loginVo);
	}

	Map<String, Object> validationShopee(ShopeeParamVo paramVo) {
		logger.debug("ShopeeParamVo : "+ paramVo.toString());

		if (paramVo.getPartnerId().equals("")) {
			logger.debug("code : 404, message : Shopee Partner id가 누락되었습니다.");
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "404");
			retMap.put("message", "Shopee Partner id가 누락되었습니다.");
			return retMap;
		}

		if (paramVo.getPartnerKey().equals("")) {
			logger.debug("code : 404, message : Shopee Partner Key가 누락되었습니다.");
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "404");
			retMap.put("message", "Shopee Partner Key가 누락되었습니다.");
			return retMap;
		}

		for (int i=0; i<paramVo.getEtcData().size(); i++) {
			if (paramVo.getEtcData().get(i).get("shopId").equals("")) {
				logger.debug("code : 404, message : "+ (i+1)  +"번째 Shopee Shop Id가 누락되었습니다.");
				Map<String, Object> retMap = new HashMap<>();
				retMap.put("code", "404");
				retMap.put("message", (i+1) +"번째 Shopee Shop Id가 누락되었습니다.");
				return retMap;
			}

			if (paramVo.getEtcData().get(i).get("country").equals("")) {
				logger.debug("code : 404, message : "+ (i+1)  +"번째 Shopee Country가 누락되었습니다.");
				Map<String, Object> retMap = new HashMap<>();
				retMap.put("code", "404");
				retMap.put("message", (i+1) +"번째 Shopee Country가 누락되었습니다.");
				return retMap;
			}

			if (paramVo.getEtcData().get(i).get("country").equals("") && paramVo.getEtcData().get(i).get("shopId").equals("")) {
				logger.debug("code : 404, message : "+ (i+1)  +"번째 Shopee Shop Id, Country가 누락되었습니다.");
				Map<String, Object> retMap = new HashMap<>();
				retMap.put("code", "404");
				retMap.put("message", (i+1) +"번째 Shopee Shop Id, Country가 누락되었습니다.");
				return retMap;
			}
			 //TODO. 계정당 국가별 shopid 있는지 체크하는 부분 필요
		}

		Map<String, Object> retMap = new HashMap<>();
		retMap.put("code", "200");
		retMap.put("message", "정상적인 데이터 입니다.");
		return retMap;
	}

	Map<String, Object> checkedShopee(ShopeeParamVo paramVo) throws Exception {
		logger.debug("ShopeeParamVo : "+ paramVo.toString());

		String shopeeYn = dao.selectStrOne("InterfacesMapper.getCheckedShopee", paramVo);
		if (shopeeYn.equals("N")) {
			Map<String, Object> retMap = new HashMap<>();
			logger.debug("code : 201, message : Shopee 신규등록 입니다.");
			retMap.put("code", "201");
			retMap.put("message", "Shopee 신규등록 입니다.");
			return retMap;
		}

		String authCheck = dao.selectStrOne("InterfacesMapper.getCheckedShopeeAuth", paramVo);
		if (authCheck.equals("N")) {
			Map<String, Object> retMap = new HashMap<>();
			logger.debug("code : 202, message : Shopee Auth 정보가 변경되었습니다.");
			retMap.put("code", "202");
			retMap.put("message", "Shopee Auth 정보가 변경되었습니다.");
			return retMap;
		}

		Map<String, Object> retMap = new HashMap<>();
		retMap.put("code", "200");
		retMap.put("message", "Country, shopId 수정을 처리합니다.");
		return retMap;
	}

	Map<String, Object> seveShopee(ShopeeParamVo paramVo, String code) throws Exception {
		logger.debug("ShopeeParamVo : "+ paramVo.toString() +", code : "+ code);
		// 200 : ShopId 및 country 정보 추가 또는 수정, 201 : Shopee 신규등록, 202 : Shopee Auth 정보 변경
		if (code.equals("201")) {
			logger.debug("Shopee 신규등록");

			logger.debug("CODE : 201 [TINTERFACE, TINTERFACE_DTL Insert]");
			dao.insert("InterfacesMapper.insertShopee", paramVo);
			Map<String, Object> retMap = this.saveShopeeDtl(paramVo, code);
			return retMap;
		} else if (code.equals("202")) {
			logger.debug("Shopee Auth 정보 변경 및 ShopId 및 country 저장");

			dao.update("InterfacesMapper.updateShopee", paramVo);
			Map<String, Object> retMap = this.saveShopeeDtl(paramVo, code);
			return retMap;
		} else if (code.equals("200")) {
			logger.debug("ShopId 및 country 정보 추가 또는 수정");

			Map<String, Object> retMap = this.saveShopeeDtl(paramVo, code);
			return retMap;
		} else {
			logger.debug("알수없는 코드발생");
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", "500");
			retMap.put("message", "내부 오류가 발생하였습니다.");
			return retMap;
		}
	}

	Map<String, Object> saveShopeeDtl(ShopeeParamVo paramVo, String code) throws Exception  {
		logger.debug("ShopeeParamVo : "+ paramVo.toString() +", code : "+ code);

		for (int i=0; i<paramVo.getEtcData().size(); i++) {
			logger.debug("etcData("+ i +") : "+ paramVo.getEtcData().get(i).toString());
			String seq = String.valueOf(paramVo.getEtcData().get(i).get("seq"));
			int interfaceDtlSeq = Integer.parseInt(seq);

			InterfaceSettingDtlVo interfaceDtlVo = new InterfaceSettingDtlVo();
			interfaceDtlVo.setUserId(paramVo.getUserId());
			interfaceDtlVo.setInterfaceType(paramVo.getInterfaceType());
			interfaceDtlVo.setMappingKey((String) paramVo.getEtcData().get(i).get("country"));
			interfaceDtlVo.setEtcKey((String) paramVo.getEtcData().get(i).get("shopId"));
			interfaceDtlVo.setInterfaceDtlSeq(interfaceDtlSeq);

			if (interfaceDtlSeq == 0) {
				int insertCount = dao.insert("InterfacesMapper.insertTInterfaceDtl", interfaceDtlVo);
			} else {
				int insertCount = dao.insert("InterfacesMapper.updateShopeeDtl", interfaceDtlVo);
			}
		}

		Map<String, Object> retMap = new HashMap<>();
		retMap.put("code", "200");
		retMap.put("message", "정상적으로 처리되었습니다.");
		return retMap;
	}

	Map<String, Object> deleteShopee(ShopeeParamVo paramVo) throws Exception {
		logger.debug("ShopeeParamVo : "+ paramVo.toString());

		dao.delete("InterfacesMapper.deleteShopeeDtl", paramVo);

		Map<String, Object> retMap = new HashMap<>();
		retMap.put("code", "200");
		retMap.put("message", "정상적으로 처리되었습니다.");
		return retMap;
	}

}
