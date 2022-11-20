package xrt.fulfillment.livePacking;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.utils.LRespData;
import xrt.sys.popup.LivePackingVo;

@Controller
@RequestMapping(value = "/fulfillment/livePackingList")
public class LivePackingListController {

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private LivePackingListBiz biz;

	Logger logger = LoggerFactory.getLogger(LivePackingListController.class);

	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {

		String XROUTE_ADMIN = CommonConst.XROUTE_ADMIN;
		String CENTER_ADMIN = CommonConst.CENTER_ADMIN;
		String SELLER_ADMIN = CommonConst.SELLER_ADMIN;

		// 권한
		model.addAttribute("XROUTE_ADMIN", XROUTE_ADMIN);
		model.addAttribute("CENTER_ADMIN", CENTER_ADMIN);
		model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);


		return "fulfillment/livePacking/LivePackingList";
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	public 	@ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVo) throws Exception {

		List<LivePackingVo> livePackingList = biz.getSearch(paramVo);

		LRespData retMap = new LRespData();
		retMap.put("resultList", livePackingList);

		return retMap;
	}

}