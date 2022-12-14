package xrt.alexcloud.api.atomy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Controller
@RequestMapping(value = "/fulfillment/atomy/apiOrderList")
public class AtomyApiOrderListController {

	Logger logger = LoggerFactory.getLogger(AtomyApiOrderListController.class);

	private AtomyApiOrderListBiz atomyApiOrderListBiz;

	@Autowired
	public AtomyApiOrderListController(AtomyApiOrderListBiz atomyApiOrderListBiz) {
		this.atomyApiOrderListBiz = atomyApiOrderListBiz;
	}

	@RequestMapping(value = "/view.do")
	public String view(Model model) throws Exception {
		Map<String, Object> userGroupMap = new HashMap<String, Object>();
		userGroupMap.put("xrouteAdmin", CommonConst.XROUTE_ADMIN);
		userGroupMap.put("centerAdmin", CommonConst.CENTER_ADMIN);
		userGroupMap.put("centerSuper", CommonConst.CENTER_SUPER_USER);
		userGroupMap.put("centerUser", CommonConst.CENTER_USER);
		userGroupMap.put("sellerAdmin", CommonConst.SELLER_ADMIN);
		userGroupMap.put("sellerSuper", CommonConst.SELLER_SUPER_USER);
		userGroupMap.put("sellerUser", CommonConst.SELLER_USER);

		model.addAttribute("userGroupMap", userGroupMap);
		model.addAttribute("usercd", LoginInfo.getUsercd());
		return "fulfillment/atomy/AtomyApiOrderList";
	}

	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	public @ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVo) throws Exception {
		List<LDataMap> orderList = atomyApiOrderListBiz.getSearch(paramVo);
		LRespData retMap = new LRespData();
		retMap.put("resultList", orderList);
		return retMap;
	}

	@RequestMapping(value = "/getOrderInfo.do", method = RequestMethod.POST)
	@ResponseBody
	public LDataMap getAtomyOrderInfo(@RequestBody CommonSearchVo paramVo) throws Exception {

		LDataMap apiReturnMap = new LDataMap();
		LDataMap retMap = new LDataMap();

		try {
			String status = "";
			String data = "";

			// 1. ?????? ?????? ??????.
			LDataMap dataMap = atomyApiOrderListBiz.getTotalcountDirect(paramVo); // 1. ???????????? ?????? ?????? (????????? ??????).
			status = dataMap.getString("Status"); // ?????? ??????.
			data = dataMap.getString("Data"); // ????????? ??????.

			// 2. ?????? ?????? ??????.
			if (status.equals("1")) { // ??????????????? 1??????,
				if (!data.equals("0")) { // Data??? ????????? 0??? ?????? ??? ??????????????? ??????.
				    if (paramVo.getsPeriodType().equals("2nd")) {
				        retMap = atomyApiOrderListBiz.getLastOrderList(data, paramVo);
                    }else {
                        retMap = atomyApiOrderListBiz.getOrderList(data, paramVo);
                    }
				    
					apiReturnMap.put("code", "200");
					apiReturnMap.put("message", "????????? ?????? ?????? ?????? ??????");
					return apiReturnMap;
				} else {
					retMap.put("apiType", "requestDirect");
					retMap.put("Status", "1");
					retMap.put("StatusDetailCode", "");
					retMap.put("Data", "0");
					retMap.put("ErrMsg", "?????? ????????? ???????????? ????????????.");
					atomyApiOrderListBiz.insertApiHistory(retMap);
					apiReturnMap.put("code", "500");
					apiReturnMap.put("message", "?????? ????????? ???????????? ????????????.");
					return apiReturnMap;
				}
			} else {
				retMap.put("Status", "0");
				retMap.put("StatusDetailCode", "");
				retMap.put("Data", "0");
				retMap.put("apiType", "totalCountDirect");
				retMap.put("ErrMsg", "???????????? ?????? ?????? ??????");
				atomyApiOrderListBiz.insertApiHistory(retMap);
				apiReturnMap.put("code", "500");
				apiReturnMap.put("message", "???????????? ?????? ?????? ??????");
				return apiReturnMap;
			}
		} catch (Exception e) {
			apiReturnMap.put("code", "500");
			apiReturnMap.put("message", "API ERROR - " + e.getMessage());
			return retMap;
		}
	}

	@RequestMapping(value = "/setAtomyOrder.do", method = RequestMethod.POST)
	@ResponseBody
	public LDataMap setAtomyOrder(@RequestBody CommonSearchVo paramVo) throws Exception {
        // ORDER_YN??? N??? SALE_NUM??? ???????????????.
        List<LDataMap> atomyGroupByOrderList = atomyApiOrderListBiz.getGroupByOrderList(paramVo);
        if (atomyGroupByOrderList.size() == 0) {
            LDataMap retMap = new LDataMap();
            retMap.put("code", "500");
            retMap.put("message", "XROUTE??? ????????? ???????????? ????????????.");
            return retMap;
        }
        LDataMap retMap = atomyApiOrderListBiz.preTorderData(atomyGroupByOrderList);
        return retMap;
	}

	// 3. ???????????? ?????? - ?????????????????? ????????????.
	@RequestMapping(value = "/setAtomyStatusUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public LDataMap setAtomyStatusUpdate(@RequestBody CommonSearchVo paramVo) throws Exception {
		LDataMap retMap = atomyApiOrderListBiz.setAtomyStatusUpdate(paramVo);
		return retMap;
	}
}
