package xrt.fulfillment.interfaces;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.fulfillment.interfaces.vo.InterfaceSettingDtlVo;
import xrt.fulfillment.interfaces.vo.InterfaceSettingVo;
import xrt.fulfillment.interfaces.vo.ShopeeParamVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.common.vo.LoginVO;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/interfaceSettings")
public class InterfacesSettingController {

	Logger logger = LoggerFactory.getLogger(InterfacesSettingController.class);

	@Resource
	private InterfacesSettingBiz interfacesSettingBiz;
	@Resource
	private CommonBiz commonBiz;

	// 페이지 호출
	@RequestMapping(value = "/view.do")
	public String view(HttpServletRequest request, ModelMap model) throws Exception {

		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
		logger.debug("loginVo : "+ loginVo.toString());

		List<CodeVO> shopeeCountry = commonBiz.getCommonCode("SHOPEE_COUNTRY");
		List<InterfaceSettingDtlVo> shopeeList = interfacesSettingBiz.getShopeeShopList(loginVo);
		InterfaceSettingVo interfaceSettingVo = (InterfaceSettingVo) interfacesSettingBiz.getShopeeData(loginVo);

		logger.debug("shopeeCountry.szie() : "+ shopeeCountry.size());
		logger.debug("shopeeList.size() : "+ shopeeList.size());

		model.addAttribute("shopeeCountry", shopeeCountry);
		model.addAttribute("shopeeList", shopeeList);
		model.addAttribute("shopeeData", interfaceSettingVo);

		return "fulfillment/interfaces/InterfaceSetting";
	}

	@ResponseBody
	@RequestMapping(value= "/shopee/save.do")
	public Map<String, Object> shopeeSave(HttpServletRequest request, @RequestBody ShopeeParamVo paramVo) throws Exception {
		logger.debug("ShopeeParamVo : "+ paramVo.toString());

		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
		logger.debug("loginVo : "+ loginVo.toString());

		logger.debug("01. shopee paramVo validation 처리.");
		Map<String, Object> validMap = interfacesSettingBiz.validationShopee(paramVo);
		String code = (String) validMap.get("code");
		String message = (String) validMap.get("message");
		if (!code.equals("200")) {
			Map<String, Object> retMap = new HashMap<>();
			retMap.put("code", code);
			retMap.put("message", message);
			return retMap;
		}

		logger.debug("02. shopee 데이터 여부 처리.");
		paramVo.setUserId(loginVo.getUsercd());
		Map<String, Object> checkMap = interfacesSettingBiz.checkedShopee(paramVo);

		logger.debug("03. shopee 데이터 저장 처리.");
		code = (String) checkMap.get("code");
		// 200 : ShopId 및 country 정보 추가 또는 수정, 201 : Shopee 신규등록, 202 : Shopee Auth 정보 변경
		Map<String, Object> saveMap = interfacesSettingBiz.seveShopee(paramVo, code);

		return saveMap;
	}


	@ResponseBody
	@RequestMapping(value= "/shopee/delete.do")
	public Map<String, Object> deleteShopee(HttpServletRequest request, @RequestBody ShopeeParamVo paramVo) throws Exception {
		logger.debug("ShopeeParamVo : "+ paramVo.toString());

		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
		logger.debug("loginVo : "+ loginVo.toString());

		logger.debug("03. shopee 데이터 저장 처리.");
		// 200 : ShopId 및 country 정보 추가 또는 수정, 201 : Shopee 신규등록, 202 : Shopee Auth 정보 변경
		Map<String, Object> retMap = interfacesSettingBiz.deleteShopee(paramVo);

		return retMap;
	}
}
