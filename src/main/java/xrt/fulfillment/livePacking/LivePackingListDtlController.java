package xrt.fulfillment.livePacking;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import xrt.lingoframework.common.biz.CommonBiz;

@Controller
@RequestMapping(value = "/fulfillment/livePackingListDtl")
public class LivePackingListDtlController {

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private LivePackingListBiz biz;

	Logger logger = LoggerFactory.getLogger(LivePackingListDtlController.class);

	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {

		return "fulfillment/livePacking/LivePackingListDtl";
	}

}